Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4691C6E6017
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjDRLmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDRLl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:41:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340E1E58
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1EF463097
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D70C433EF;
        Tue, 18 Apr 2023 11:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681818114;
        bh=HDO76kSQTCd/EdXhW03QxEZMNUJlfvxdzP1GEo8IYVg=;
        h=From:Date:Subject:To:Cc:From;
        b=JZMzw7vBy3kF7tUHrf3heWahdw/+GlTfSbSfX4l8BXBY+xlpkYbzXBZF6yUtnZ6ei
         X9heGXlXJ7Qjq+ln6+s1947UlK8OkkZ8GO5SvG5L6ek9ceYzedjuzvPZfxymikoQY+
         e3xN7D2jgVVu7zVcX2rgraJ86iVq7G62fX9TnTnZ3cy6CQpj1mkPaQSTd0FJ09djlq
         Ott8fvgXVB18h1Z2jWGiQOs3a4y7x0d+smz5RcKCOs2Qm6EWCicR19vJHHrpjqh3Yd
         Wycn9PVVKILWspPmYdQLWAj2UTH539mJEdC3MrBHQG5XKAoYZ45uelHZwLuE+fL9gI
         hj7mkdKhM7mmg==
From:   Simon Horman <horms@kernel.org>
Date:   Tue, 18 Apr 2023 13:41:48 +0200
Subject: [PATCH] soc: ti: pruss: Avoid cast to incompatible function type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230418-pruss-clk-cb-v1-1-549a7e7febe4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPuBPmQC/x2N0QqDMAwAf0XyvICtE8d+ZeyhjekMlk4SHAPx3
 xf2eAfHHWCswgb37gDlj5i8m0O4dEBLai9GmZ0h9nHor+GGm+5mSHVFyljGkOfINA1jAU9yMsa
 sqdHiUdtrdbkpF/n+H4/nef4A+lxSD3MAAAA=
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Simon Horman <horms@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than casting clk_unregister_mux to an incompatible function
type provide a trivial wrapper with the correct signature for the
use-case.

Reported by clang-16 with W=1:

 drivers/soc/ti/pruss.c:158:38: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
         ret = devm_add_action_or_reset(dev, (void(*)(void *))clk_unregister_mux,

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/soc/ti/pruss.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 6882c86b3ce5..e68441bd7b30 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -38,6 +38,11 @@ static void pruss_of_free_clk_provider(void *data)
 	of_node_put(clk_mux_np);
 }
 
+static void pruss_clk_unregister_mux(void *data)
+{
+	clk_unregister_mux(data);
+}
+
 static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
 			       char *mux_name, struct device_node *clks_np)
 {
@@ -93,8 +98,7 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
 		goto put_clk_mux_np;
 	}
 
-	ret = devm_add_action_or_reset(dev, (void(*)(void *))clk_unregister_mux,
-				       clk_mux);
+	ret = devm_add_action_or_reset(dev, pruss_clk_unregister_mux, clk_mux);
 	if (ret) {
 		dev_err(dev, "failed to add clkmux unregister action %d", ret);
 		goto put_clk_mux_np;

