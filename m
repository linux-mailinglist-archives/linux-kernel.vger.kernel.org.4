Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94360CA8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiJYLES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiJYLEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:04:10 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7931180AE4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1666695849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CmpWjF+tdyh105skX48laQa4/MYRdbS099VgNPfZ0c=;
        b=QL+Z/tyFcq+4yUBxPR7Qmva09UBcYCbhP8dptEF1PGBbqOHx6QwFpdvOGOZSk2S4CMNyp8
        yE8r+6Yw+cYafBevopvNGwfk3FPg6Vgj0wGy/lUuJLBOHQFxNVAHBRAMV6edK9z/m/y40m
        /EpffmsJT5u2a53l+SJmRQo5XyLXzHhzcOnCR/fSohO7L6tFO7guTukHEUCLwTy23SKfDY
        5ilfLPFsxJu4vwyMPraycmZprrv+bpQOQx5CFVYLxyGfY0v/EA3TosQqtHG14vrBrLBpmw
        KMC5XylcCy5PuYzvLxZkG2xlKkhODIXkr02hYnF5QEdxcyU+Jm3nCAlH/Txplg==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-387-57sMzBxpPEGF0iddEP81UA-1; Tue, 25 Oct 2022 07:04:07 -0400
X-MC-Unique: 57sMzBxpPEGF0iddEP81UA-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Tue, 25 Oct 2022 04:04:04 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <dan.carpenter@oracle.com>,
        <linux-clk@vger.kernel.org>, <yzhu@maxlinear.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH 1/1] clk: mxl: Fix smatch static checker warning
Date:   Tue, 25 Oct 2022 19:03:57 +0800
Message-ID: <49e339d4739e4ae4c92b00c1b2918af0755d4122.1666695221.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1666695221.git.rtanwar@maxlinear.com>
References: <cover.1666695221.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 036177310bac: ("clk: mxl: Switch from direct readl/writel based IO t=
o
regmap based IO") introduced code resulting in below warning issued by the
smatch static checker.

        drivers/clk/x86/clk-lgm.c:441 lgm_cgu_probe()
        warn: passing zero to 'PTR_ERR'

Fix the warning by replacing incorrect IS_ERR_OR_NULL() with IS_ERR().

Fixes: 036177310bac: ("clk: mxl: Switch from direct readl/writel based IO t=
o
regmap based IO")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 drivers/clk/x86/clk-lgm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-lgm.c b/drivers/clk/x86/clk-lgm.c
index 4de77b2c750d..f69455dd1c98 100644
--- a/drivers/clk/x86/clk-lgm.c
+++ b/drivers/clk/x86/clk-lgm.c
@@ -436,7 +436,7 @@ static int lgm_cgu_probe(struct platform_device *pdev)
 =09ctx->clk_data.num =3D CLK_NR_CLKS;
=20
 =09ctx->membase =3D syscon_node_to_regmap(np);
-=09if (IS_ERR_OR_NULL(ctx->membase)) {
+=09if (IS_ERR(ctx->membase)) {
 =09=09dev_err(dev, "Failed to get clk CGU iomem\n");
 =09=09return PTR_ERR(ctx->membase);
 =09}
--=20
2.17.1

