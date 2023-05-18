Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23587708365
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjEROAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjERN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:59:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D0E5C;
        Thu, 18 May 2023 06:59:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso370060166b.2;
        Thu, 18 May 2023 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684418392; x=1687010392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2Hw87l7Ts/Jxr3HsiObApCTHPM3x3z16x4yMMIWg7U=;
        b=ha+I138R37UHZdgIlxPcdThYdbs6YEMmtrfjUKYO4mEEWUIkxEbBvhIlitda1qGTR8
         DFPeF3QECr8G62AP0XOTaasC52PsLKCsNqCJpzibJZMUk+BwHQkVabqxN/3/w9gFvEzu
         A+bxxU25eSDFaFCDyTUmcLi5ZZ+YE5DcKw41oNAF0+SiB/e+7HNQE2JY6fmrrfFag+s8
         xJeaNkVsabjcepOGAa+X2y2W2eB4X+rhqDL4Yp94CzGB4rFYWhDyuK5E5mWOJdDOyXjp
         6EToNJtjkC7rVOX2l1rdFMGCwhwg0gtko5RXiwb3lEPcIw8E/mmZJnKQft8CYzQ4+6kR
         8kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684418392; x=1687010392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2Hw87l7Ts/Jxr3HsiObApCTHPM3x3z16x4yMMIWg7U=;
        b=fJPr/19hvuCvC1vP/a2pa1wNeBiqMisMbvx81GSGa0v4NYvZ6CCI6KWnYbu9NFmpam
         1gfxNmYtOBVXj209rJ14g4FoIRM3VAie7P+fWruELjpNMCHMkAt6+yFIZ9/V6LbGFejJ
         TLowF+g/xnyepEoh/H5Ukuk/qEmbsESyHTpANOqoXLOzoSu5d9p7hmVNGhAmPfH37TgG
         LTFCzUchjiUu0hRUrraq9xYPeRR+kOFhzw5hztbrFo/Ae6uLNildzvfh7tPkqBVL4f8i
         qaOFvC6UFeTczSBAd6MfgcL9dzw9n/fsyCcID0ocoGGOGthIgUPMFJMik3RY0pAEOlD3
         b8Rg==
X-Gm-Message-State: AC+VfDxwT8EipsX15qQEqvskHYV1XzhOKCaVwlzfGF7jgbnz8V60mIBQ
        V6SbmGN9xmzHXhYCDJwp+2k=
X-Google-Smtp-Source: ACHHUZ6KBM5XBHs+4pu1U3pGzNjbd8A+aABNxvAEb37wiK/VlxqXDZEZsCOoDDky+vdHIXzysgvKBw==
X-Received: by 2002:a17:907:8a14:b0:8ae:11ca:81de with SMTP id sc20-20020a1709078a1400b008ae11ca81demr38023635ejc.34.1684418391309;
        Thu, 18 May 2023 06:59:51 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-130-143-cbl.xnet.hr. [94.253.130.143])
        by smtp.googlemail.com with ESMTPSA id t28-20020a50d71c000000b0050d89daaa70sm669003edi.2.2023.05.18.06.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 06:59:50 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.orgm, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] firmware: qcom: scm: disable SDI on IPQ5018
Date:   Thu, 18 May 2023 15:59:45 +0200
Message-Id: <20230518135945.2248451-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518135945.2248451-1-robimarko@gmail.com>
References: <20230518135945.2248451-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 seems to have SDI (Secure Debug Image) enabled by default which
prevents normal reboot from working causing the board to just hang after
reboot is called.

So, let disable SDI during SCM probe for IPQ5018.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/firmware/qcom_scm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index bdc9324d4e62..c6a38ce49fb0 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1525,6 +1525,14 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (download_mode)
 		qcom_scm_set_download_mode(true);
 
+	/* IPQ5018 seems to have SDI (Secure Debug Image) enabled by default
+	 * which will prevent normal reboot causing the board to hang after
+	 * making the reboot call.
+	 * So, make a call to SCM to disable SDI.
+	 */
+	if (of_machine_is_compatible("qcom,ipq5018"))
+		qcom_scm_disable_sdi();
+
 	return 0;
 }
 
-- 
2.40.1

