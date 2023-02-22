Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA069EE72
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjBVFj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBVFjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:39:24 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A4E3431E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:39:22 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d7so3934377pfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uLVfjCRzss/xwXNobW3aKCGuDntkGHej1tSNXCA8VQ=;
        b=v2P8i10tN9N4ftFuujRjViMb7v95BAl1BRZ3f6ug9wqxssUaI7SVNE/1UjahEz/4w3
         36F6Tz+xIIn2J9yCqynx2wZNrJa8GALlu9HVIdDsVsZqRq2ri+5r/3mvFPSNuIyOVWRW
         GTqMH8cPhwYi2xdif2ra0JXycaKGuJxCcu/mAXMLaQGppqiH4gWh6f64ztwnCsXE+L5t
         GJ3RVaMjN32tBCTfgw0x/6+kWdEViZxsPCrOAJqQkxvJhitIePr50ktChlgmyu4VNYrw
         7WBVDEBKxNfBf6VPXR6e5vJi/D4MrddCsFmei9W2Q+akT3W7RAV91I/YgsVmbClDRok0
         JlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uLVfjCRzss/xwXNobW3aKCGuDntkGHej1tSNXCA8VQ=;
        b=VQaQh8q0qvBiP/CMLVm0xblyztvNqkJdO4eYwuy3JRkOSLyhGHxBxieokWWMX5af4O
         Vn/N0vM7YqSrrVxHwi0tvnfk/zVr1N043QYjgpBgSRtPy4mPioj0gOB6gDOGoQaV9Myv
         kpJbyo16j2LlyhzXIkU2gIEVJk/DFbcUT7KxeW7MGzOrA4WSvriI8B3EtYstPpXUVNG4
         GWcSchrg2lx2s33UpVJuqc5oO9eETvs7ecvL0kzQEjXbVzmzKb1lYXlUBRWets7+5Ovv
         2SBXBwJBxlK/0B1Vn3i8oAYqq7lKsk1C51SF2zqJ+AXYgJ7iHPblPOn69jdOjVGvm6WR
         L9lw==
X-Gm-Message-State: AO0yUKUamEEWRu8vl90KJnYyL0CYM238uWzfaHeKgfol2zKbst1JJhHN
        u+8udD7WVSpyl1nELGXPhCQMjA==
X-Google-Smtp-Source: AK7set9NMn0QrWn2pOuo7EoSj/WuhfT2Xv5MDeDc2OBwYr6TcFbMjtv4rKm4aNTAgH9Ym68VeJjG2Q==
X-Received: by 2002:a05:6a00:2d1b:b0:5a8:d3d9:e03a with SMTP id fa27-20020a056a002d1b00b005a8d3d9e03amr7374216pfb.0.1677044361682;
        Tue, 21 Feb 2023 21:39:21 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79203000000b005931a44a239sm1107130pfo.112.2023.02.21.21.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 21:39:21 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v3 2/3] efi: Add EFI_ACCESS_DENIED status code
Date:   Wed, 22 Feb 2023 14:38:23 +0900
Message-Id: <20230222053825.992-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230222053825.992-1-masahisa.kojima@linaro.org>
References: <20230222053825.992-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the EFI_ACCESS_DENIED status code.

Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/linux/efi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7e5239da87bf..c0f60dbb8a8c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -39,6 +39,7 @@
 #define EFI_WRITE_PROTECTED	( 8 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_OUT_OF_RESOURCES	( 9 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_ACCESS_DENIED	(15 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_TIMEOUT		(18 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
-- 
2.30.2

