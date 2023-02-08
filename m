Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA468F78A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjBHS4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjBHS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:56:51 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E7CCDE7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:56:49 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so2240736wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIo7KpMDaRfgRZgMFrjY9BiU3ZghspQ14enw5m/OmAA=;
        b=OTaIzU5p4Vm1ss7vcxGXZ3O5xVEX3TMR7EvPLga0WhoDWNy3jIevXkrXc9T6IOQjjh
         9GaCCaN2SV9daZjVsmSs3EIR4Q9hkBamEM21uUfYBpsqF/JEM8SnL8NE2Nxd/4j6aeMC
         /g8LyRMMqJDBZgkaq+9r5dtP+ZFPqK+81bhGGvatxqZigVHIOX2CkbsaNRAN6OBe2uJU
         Cpp47s6HpS03YlhyTX28n2wpGWf9bqWaiDsdWmBOwfkmLsrt0bZrTAHxD4v7sKuEtvOS
         qcY5NI++ZIqwQpjMEWQYYXsysgFm095LWGKuqGqtuekvzM1WCU41QqeIKXNS+vmNCF1a
         khcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIo7KpMDaRfgRZgMFrjY9BiU3ZghspQ14enw5m/OmAA=;
        b=X+SPKzNKFleb9l0/mpFZsjG44PWPwU8OrjJo/gqGz1KXFrVxkpPfz3vo73NCXU/H3Q
         UVq7et+RWthgWUATLEZXgly4Svl3BUpZEOYI3tgaRnyVOIK3t6JdQ+4HSEPJuLfxj+U6
         D8K4SrJZRTfOhpwrbOsBZJicLIkVb6fH3HZhbWI6TaYqj38khVmYWLhi5qjXkbWN03IQ
         MLh6woweXnpCxpzUbVWarw74mlcJ0iLQQKSrzg8nMhfijplF18TsoPpiu2uglXovi/x+
         vsXxLePWkWE9s64bwhvARdLd2jdYSLDTMss4FRu/nsd47RMQCLNwmHbIrsS2zqwUcOo3
         0o9A==
X-Gm-Message-State: AO0yUKVpj35+vTnrnb5ZPqFN7NbRD7hSu91rLlxUhp4LLu7/Ms5hk973
        lq/3C18NzgWoKw87ZU7B77s=
X-Google-Smtp-Source: AK7set/uBlZSZYh1C+IATXeS4vCMbRtg1YBmyDu6zO7dNNFDogmatg3TZeg0mxOsh9xPeAuLQt2d4A==
X-Received: by 2002:a05:600c:3ca3:b0:3dc:5ae4:c13d with SMTP id bg35-20020a05600c3ca300b003dc5ae4c13dmr10206985wmb.4.1675882607938;
        Wed, 08 Feb 2023 10:56:47 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b003dc433355aasm2698984wmq.18.2023.02.08.10.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:56:47 -0800 (PST)
Date:   Wed, 8 Feb 2023 19:56:45 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8192e: Use BIT() instead of << for bit field
 MSR_LINK_MASK
Message-ID: <20230208185645.GA14681@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use commonly used BIT() macro to define MSR_LINK_MASK. Equation is
not accepted by checkpatch because of missing spaces. Therefore line
needs to change anyhow.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: Changed patch, title and description
        Calculate MSR_LINK_MASK ((1<<0)|(1<<1)) = 3 is not wanted for
        bit fields
        Old patch name: Calculate definition of MSR_LINK_MASK
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 8b8a870fcbbd..99640c4779f7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -170,7 +170,7 @@ enum _RTL8192PCI_HW {
 #define	BW_OPMODE_20MHZ			BIT2
 	IC_VERRSION		= 0x301,
 	MSR			= 0x303,
-#define MSR_LINK_MASK      ((1<<0)|(1<<1))
+#define MSR_LINK_MASK		(BIT(1) | BIT(0))
 #define MSR_LINK_MANAGED   2
 #define MSR_LINK_ADHOC     1
 #define MSR_LINK_MASTER    3
-- 
2.39.1

