Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90A5F01F0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiI3AvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiI3Au3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:50:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED77B5B05D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0479ECE23EF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DC4C433D7;
        Fri, 30 Sep 2022 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664499020;
        bh=xeoSzNuqPluHkoak2Kt2ZcLQHxT/FauXizeyldfJSO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StZehtKYnEQuryaZA9/cyN6tSYSlHkb77b2RNpIF2Uf8mSJhFb7uhi1QrCfLXuD/L
         60r9qcxcIBWdiKI20bC6pUFtd7lXIDSxDAC3pn7gsnx9LyZgmKneNQa/cLB1pZhMVu
         4cvClIfxTKSTqXbm80nKyUiELgixA7VLI8h9X+TT5lBEaKY9thyMDfczGa9nYHtK5H
         Fh3bSnG+P9KFvN9y5E/C5e1wG/dpcmG6yWe2DNTi/mnO9jOgsnR0ecyeFNxfblVe93
         uB0GO8ijxeIksbeQN+hgiFhvv+3zyu0dbMAc5QsF6vd9X6zdqr/flI2cADPA59R9b2
         Aum3wenBsNa+w==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     keliu <liuke94@huawei.com>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 1/9] drivers: spmi: Directly use ida_alloc()/free()
Date:   Thu, 29 Sep 2022 17:50:10 -0700
Message-Id: <20220930005019.2663064-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930005019.2663064-1-sboyd@kernel.org>
References: <20220930005019.2663064-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: keliu <liuke94@huawei.com>

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
Link: https://lore.kernel.org/r/20220527071338.2359733-1-liuke94@huawei.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index a456ce5141e1..55381592bb5a 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -35,7 +35,7 @@ static void spmi_ctrl_release(struct device *dev)
 {
 	struct spmi_controller *ctrl = to_spmi_controller(dev);
 
-	ida_simple_remove(&ctrl_ida, ctrl->nr);
+	ida_free(&ctrl_ida, ctrl->nr);
 	kfree(ctrl);
 }
 
@@ -457,7 +457,7 @@ struct spmi_controller *spmi_controller_alloc(struct device *parent,
 	ctrl->dev.of_node = parent->of_node;
 	spmi_controller_set_drvdata(ctrl, &ctrl[1]);
 
-	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&ctrl_ida, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(parent,
 			"unable to allocate SPMI controller identifier.\n");
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

