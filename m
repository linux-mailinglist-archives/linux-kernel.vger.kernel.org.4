Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944B670AADA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 22:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjETUMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjETUMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 16:12:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCE6184
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zXkCVDb2bhMtAXt85DCGNGnmnYf+BDOHEzbv1HWT/nw=; b=raej4VtrOEhADlGD3uit2sSBlf
        gMFd6rVjbpNsO6m5hDqkPvsM4cwCyBVGuRtZNHCxUYfRr8ggWX8cvt5nltZvDhQ2g02et+5ENyJLB
        RZSmg3comu16ed3iYfAvlSEFlzon7mstlhOChdgVEveftBF6e8yaEE++ZQIGDylPNYkN/NrYAXI2g
        Mkn1qb+AAZjiItJLjdrGpHTtKFJ7VnayF/wTwjeMfsxo/736Q+nO5kU1mUWvvEHDKeNA0ClobZI2W
        SZtR5iWhWp502GuAaOf1SqrR17SCPmo1iuUpoV+VauPe00GY6aEPJ2FU7Gu0JqN0yisPvX5XGei+8
        fr/VcaTw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0Swa-002Cc2-29;
        Sat, 20 May 2023 20:12:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Subject: [PATCH] interconnect: add license and exports to fix build errors
Date:   Sat, 20 May 2023 13:12:48 -0700
Message-Id: <20230520201248.2437-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

icc-clk.c should have a MODULE_LICENSE() and export its register and
unregister functions to prevent build errors, so add them.

ERROR: modpost: missing MODULE_LICENSE() in drivers/interconnect/icc-clk.o
ERROR: modpost: "icc_clk_unregister" [drivers/clk/qcom/clk-cbf-8996.ko] undefined!
ERROR: modpost: "icc_clk_register" [drivers/clk/qcom/clk-cbf-8996.ko] undefined!

Fixes: 0ac2a08f42ce ("interconnect: add clk-based icc provider support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>
---
 drivers/interconnect/icc-clk.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff -- a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -5,8 +5,10 @@
 
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/export.h>
 #include <linux/interconnect-clk.h>
 #include <linux/interconnect-provider.h>
+#include <linux/module.h>
 
 struct icc_clk_node {
 	struct clk *clk;
@@ -146,6 +148,7 @@ err:
 
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(icc_clk_register);
 
 /**
  * icc_clk_unregister() - unregister a previously registered clk interconnect provider
@@ -166,3 +169,6 @@ void icc_clk_unregister(struct icc_provi
 			clk_disable_unprepare(qn->clk);
 	}
 }
+EXPORT_SYMBOL_GPL(icc_clk_unregister);
+
+MODULE_LICENSE("GPL");
