Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1B712E64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbjEZUsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243227AbjEZUsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:48:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08193189;
        Fri, 26 May 2023 13:48:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5148ebc4b89so223919a12.3;
        Fri, 26 May 2023 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685134086; x=1687726086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqcvTDSmtR3/nHHqfw4x74tCgNTC4R8I5JW/MpzlYaI=;
        b=b6hbdnN5b5gw+aNwMDh0jp1oPnfJIYsBcs6R9y2tmvUH+P9npp9e2zkLfMZ4uWXLOO
         RnVpq2kwjpl1tceIP6GTAlhT7S+++aDbK/IsX7zUQva8wy1+TkEUe5nNI+RGZEiIVMJV
         6p3FfOAjFkbImsVv2jCWrjmtAkLyAOi9Sl5oh+NdZZmj/kd2skgdqKX7pFJI/gTQO2PA
         zuE6bB6P7g5YqnKn6wvMaTW7DjNwxWO5RY26spVFeuuFRbgXHFtqSQFbPbFioCKmWNww
         tLc25smjSlKvsUhwhujmarpNxI4sD5sD7AIqjUGgeQF+C2Lb2U1eie4B0rviRbFTxHXq
         E2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134086; x=1687726086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqcvTDSmtR3/nHHqfw4x74tCgNTC4R8I5JW/MpzlYaI=;
        b=aumg7hZ7DegL493AgzF7IbybHijQDM6GLUWjAPLsjlHVCjCe9jGBfMjqWC9gsCknsm
         jljiPQffQsXA3giMn5lAJjVuiH+lDFIh5wWVhx0oxvyZ3q5gh80eDvoP6Q9YvU7m50cj
         1FIJjyTKQaTjgEBwDd0UDSHTDfcN6IH+eBJ+9G1bt5IzAUmYSpl5IagXMUV4uheNbdHb
         /kG0N4xQduVyFlSb/zuvQ2/MF4Bx1ZTAc7bNsDzlDZixTmo971c3p8V6gZcgQtFScQV7
         v4u85o3+2QPRcNz860kS8FwhFXAhpqbUXskb+B5AuUrt2MJZ9HdcvbL5FCwn0X7AvmIm
         DpPQ==
X-Gm-Message-State: AC+VfDz1py6nJFvMIHvTVqpug//yZ1gjQz354zm7gZjbzuf9HNPDGMQ8
        4R+qKvaRVDiaWZcCvZEqxoI=
X-Google-Smtp-Source: ACHHUZ4jSFssmk51geC9a85dPFQ13pfskwpL+6lMQ1VR5k9NVHtoBt9W0yX9NH+VgoQIe+YkJpRkUw==
X-Received: by 2002:a17:906:db0e:b0:96f:b8a0:6cfe with SMTP id xj14-20020a170906db0e00b0096fb8a06cfemr3069025ejb.54.1685134086303;
        Fri, 26 May 2023 13:48:06 -0700 (PDT)
Received: from fedora.. (dh207-98-6.xnet.hr. [88.207.98.6])
        by smtp.googlemail.com with ESMTPSA id m13-20020a170906160d00b0095342bfb701sm2604413ejd.16.2023.05.26.13.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 13:48:05 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: [PATCH v5 2/5] soc: qcom: smem: Switch to EXPORT_SYMBOL_GPL()
Date:   Fri, 26 May 2023 22:47:59 +0200
Message-Id: <20230526204802.3081168-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526204802.3081168-1-robimarko@gmail.com>
References: <20230526204802.3081168-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMEM has been GPL licensed from the start, and there is no reason to use
EXPORT_SYMBOL() so switch to the GPL version.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Trilok Soni <quic_tsoni@quicinc.com>
---
 drivers/soc/qcom/smem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 6be7ea93c78c..bc98520c4969 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -500,7 +500,7 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 
 	return ret;
 }
-EXPORT_SYMBOL(qcom_smem_alloc);
+EXPORT_SYMBOL_GPL(qcom_smem_alloc);
 
 static void *qcom_smem_get_global(struct qcom_smem *smem,
 				  unsigned item,
@@ -674,7 +674,7 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
 	return ptr;
 
 }
-EXPORT_SYMBOL(qcom_smem_get);
+EXPORT_SYMBOL_GPL(qcom_smem_get);
 
 /**
  * qcom_smem_get_free_space() - retrieve amount of free space in a partition
@@ -719,7 +719,7 @@ int qcom_smem_get_free_space(unsigned host)
 
 	return ret;
 }
-EXPORT_SYMBOL(qcom_smem_get_free_space);
+EXPORT_SYMBOL_GPL(qcom_smem_get_free_space);
 
 static bool addr_in_range(void __iomem *base, size_t size, void *addr)
 {
@@ -770,7 +770,7 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
 
 	return 0;
 }
-EXPORT_SYMBOL(qcom_smem_virt_to_phys);
+EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
 
 static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 {
-- 
2.40.1

