Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A576EF6A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbjDZOoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241486AbjDZOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:44:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B607A97;
        Wed, 26 Apr 2023 07:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5E826373B;
        Wed, 26 Apr 2023 14:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22503C433EF;
        Wed, 26 Apr 2023 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682520239;
        bh=o0ldxJi8PjCdc85sGMxMwUUf04YrZqa91ZDhQtfywSU=;
        h=From:To:Cc:Subject:Date:From;
        b=kcOAl7QU+uaBJmdj32NAU/bV9DkoH9tlRwooYHR56OcpxYhHRh+2JKecumYIiF7js
         L64WmGs5TB/vwe9UCKn5VT+37dPmQ80bBh/z6oN8CfwnuE8hKddupGjX4miKXPpkaN
         P/BcXWEm1XuEOywdGGC9qE4ksc6mMH78NpiM+MqX9jk5vDJmhumS9SwWPccDzK5Eq/
         1bvBTqvH73gzn/mhcQpe6N7FKoC3s06Pbr6PQ+MmgsBjJ5v6+3umlZr01Wd+bc1F8E
         d05HYUeeRyro2Uvjte+KM/SeSwibVgQkRvEgialwlHrIO6PCpJmOE6j3AxfDHj8Yd5
         W1dcR2fwVF+yg==
From:   broonie@kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sarannya S <quic_sarannya@quicinc.com>
Subject: linux-next: manual merge of the rpmsg tree with the origin tree
Date:   Wed, 26 Apr 2023 15:43:54 +0100
Message-Id: <20230426144354.87429-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the rpmsg tree got a conflict in:

  drivers/rpmsg/qcom_glink_native.c

between commit:

  0a7eee89e79eb ("rpmsg: glink: Transition intent request signaling to wait queue")

from the origin tree and commit:

  96a7a78517751 ("rpmsg: glink: Add support to handle signals command")

from the rpmsg tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/rpmsg/qcom_glink_native.c
index 1beb40a1d3df2,208a5e9443cb9..0000000000000
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
