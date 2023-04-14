Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6016E2693
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjDNPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjDNPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:13:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AD572AB;
        Fri, 14 Apr 2023 08:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69E796478A;
        Fri, 14 Apr 2023 15:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC54C433EF;
        Fri, 14 Apr 2023 15:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681485210;
        bh=dvJEqZwBxcCbVE0hi2EybF2Jd9r00VIRulxaBnnaXKw=;
        h=From:To:Cc:Subject:Date:From;
        b=GZw4WI0958R09GedK7ZrHdgARDAaMN4C7iJ3LztzRA1KhBV2zCiQdLFMXLURCyUW7
         HjbJkMV0AK1PdIfvMI/RXmyY23PmUSIZ32JP499AltKs2TEFSPGqfgvt1LUAQrCD5k
         SRl6o3OUz8sjnqJwvve/XbwGpiudBTf6fYByxfxMSzUqikPYaGXPn7uSWrjtSZn0Nd
         LpQBZkUjCz8zJ487dwk4mUG20/jwoCvmolRU2cuJhDIc1Y7D0VVq5T/vZ7mbbE2Ofz
         XJAIk2VHPxHfMry+ittzuIiQ2zm9HOM//t8/VxLcl2EkZE+69/AxKQzvE+HJcf12Oe
         wCfPYJzIbxtEg==
From:   broonie@kernel.org
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: linux-next: manual merge of the char-misc tree with the devicetree tree
Date:   Fri, 14 Apr 2023 16:13:26 +0100
Message-Id: <20230414151326.2134818-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  include/linux/of.h

between commit:

  82174a0a9c5cf ("of: Move of_device_get_match_data() declaration")

from the devicetree tree and commit:

  673aa1ed1c9b6 ("of: Rename of_modalias_node()")

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/linux/of.h
index bc2eb39dcf753,9b7a99499ef35..0000000000000
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@@ -370,8 -373,8 +370,9 @@@ extern int of_n_addr_cells(struct devic
  extern int of_n_size_cells(struct device_node *np);
  extern const struct of_device_id *of_match_node(
  	const struct of_device_id *matches, const struct device_node *node);
 +extern const void *of_device_get_match_data(const struct device *dev);
- extern int of_modalias_node(struct device_node *node, char *modalias, int len);
+ extern int of_alias_from_compatible(const struct device_node *node, char *alias,
+ 				    int len);
  extern void of_print_phandle_args(const char *msg, const struct of_phandle_args *args);
  extern int __of_parse_phandle_with_args(const struct device_node *np,
  	const char *list_name, const char *cells_name, int cell_count,
