Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFB56B495E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjCJPLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjCJPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:11:26 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0865A1AD;
        Fri, 10 Mar 2023 07:03:28 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id k199so5559748ybf.4;
        Fri, 10 Mar 2023 07:03:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678460486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCpL7ocfi58njdErkPxcygUe6uPmxZK7sL4VjSYUEoA=;
        b=CdxM2mokQ7mDhh2kVELL+O2mAZ7F7huAMb0UADDNSBNfwOzB0mKKQ3qI5G5fks15d4
         rHYm3XJiGHarYlPXM5/djs0MFaLwsOYvge6IJgenm3L45d8+jYo3YrfGdax1mxZt/cSH
         EKCLIaDxYenFbSGl0zrCmdUiVo9hG5vBQYThlEOHVOBeSyCCCAwHSCAMbDQGNV1gOl4g
         10BQnWMSO4RxOKb3IhdzSnxURbHoHR3A8Ah/k1my5ltnVyPiD/kOlDg/zOoRrF0PhMZj
         BGoST1E/47VuznV4XQ4mqE2PUo20FkBgC9NExwuVeIvfA0DOPqMsjjDRyEDNVL8/eVyi
         H7GQ==
X-Gm-Message-State: AO0yUKWTdjRt0ROH93ajRGAffJP6JtgHMRIninu4m1U+gkFPaBhsW+IX
        VKSrqSURYsCqYGFnEbWPT03FifSc6A==
X-Google-Smtp-Source: AK7set9LLLPhoeaA3/Sg53Plp3DTTBj+aU8Zy7fyHRUUAbXf8XfSnbThVAnP+AQCUm9GPyAxYbX8Pw==
X-Received: by 2002:a05:6870:4195:b0:16d:f177:1a1a with SMTP id y21-20020a056870419500b0016df1771a1amr16870566oac.46.1678459911484;
        Fri, 10 Mar 2023 06:51:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p12-20020a9d4e0c000000b00690df568258sm107688otf.63.2023.03.10.06.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:51:51 -0800 (PST)
Received: (nullmailer pid 1546998 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: st: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:35 -0600
Message-Id: <20230310144736.1546972-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/remoteproc/st_remoteproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index a3268d95a50e..50ef40671652 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -379,7 +379,7 @@ static int st_rproc_probe(struct platform_device *pdev)
 		clk_set_rate(ddata->clk, ddata->clk_rate);
 	}
 
-	if (of_get_property(np, "mbox-names", NULL)) {
+	if (of_property_present(np, "mbox-names")) {
 		ddata->mbox_client_vq0.dev		= dev;
 		ddata->mbox_client_vq0.tx_done		= NULL;
 		ddata->mbox_client_vq0.tx_block	= false;
-- 
2.39.2

