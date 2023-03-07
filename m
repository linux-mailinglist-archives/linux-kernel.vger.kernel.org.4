Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40C26AE793
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCGQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCGQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:07 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EAE94395;
        Tue,  7 Mar 2023 08:54:34 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 64544C0007;
        Tue,  7 Mar 2023 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678208073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dgBBTfpHgnXZ4Nqwu5rs0ftqLmummhA9TCyJqUGHyhw=;
        b=O8KN2Fypv/egq62SHo1ylWNtpQK89k9X99FpeTrpTrm4ZAYHAKUjW8Ku3Re/82Y7Do4Jy1
        OG5pN0UbcKeLfiAMwi/bNb4sH5B32/Gqe5G7sJn60qfBP8Qw/n7SMd4JdE7XBTpC2uwhG7
        uEBwusKQYHz/klYvSXJv4MlAHBlLGAIJCtdGorxvIBSF8IPSBfe9NKYHyYH8Ijoriu3HoU
        kxyHKKBqk1kjJ76HTZF1+i1jIMdx76SlWn01H1w6sf30XqnN9mi2IbzcKegKZEqt+x1hyi
        I6hajoZtMQDnXw++uRO5xg0eag0ekgjKpLNNsli299UXrALFlKRFOu0kG56dkg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 09/21] nvmem: core: return -ENOENT if nvmem cell is not found
Date:   Tue,  7 Mar 2023 17:53:47 +0100
Message-Id: <20230307165359.225361-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307165359.225361-1-miquel.raynal@bootlin.com>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Prior to commit 3cb05fdbaed6 ("nvmem: core: add an index parameter to
the cell") of_nvmem_cell_get() would return -ENOENT if the cell wasn't
found. Particularly, if of_property_match_string() returned -EINVAL,
that return code was passed as the index to of_parse_phandle(), which
then detected it as invalid and returned NULL. That led to an return
code of -ENOENT.

With the new code, the negative index will lead to an -EINVAL of
of_parse_phandle_with_optional_args() which pass straight to the
caller and break those who expect an -ENOENT.

Fix it by always returning -ENOENT.

Fixes: efff2655ab0f ("nvmem: core: add an index parameter to the cell")
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 174ef3574e07..22024b830788 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1231,7 +1231,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 						  "#nvmem-cell-cells",
 						  index, &cell_spec);
 	if (ret)
-		return ERR_PTR(ret);
+		return ERR_PTR(-ENOENT);
 
 	if (cell_spec.args_count > 1)
 		return ERR_PTR(-EINVAL);
-- 
2.34.1

