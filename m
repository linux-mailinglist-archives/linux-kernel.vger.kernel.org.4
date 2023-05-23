Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7882870D86D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjEWJHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjEWJGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:06:45 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0BE126
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:06:43 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso4430819b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684832802; x=1687424802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNbc2Gn4lCWbgtCz86CXU5/fu3n/2droTjC+nnxxbnU=;
        b=m3dxUrhr7ssgRxrCAnXnCiKgDYN8FVNpEG1YyZbv4SLdIGjLgsQGnUBkj9mbtZpseW
         worrOSfWPZSONyeV/X665KYq26WN+UhV5ll4mRUCEfv3J6mkqpbjGp40zJGXTYjOGlMI
         nWxa2a/az1+rQoG26sqlSUf0bKi9YMt5x2REdpKGAnUw3lwHBlkBpPbuUJ9BErVZxUlT
         VGF4ki/86wwgy4hR+eyrZS3BftXKUkKpTxD7/q7Lv9nuCpB0E8LqW+Sfq464PUIHj3NT
         zdGGTkKsOgx/VQ+ddPjGoGm4xAoPG18HgxtsR5qYKc8/x+WHyNkjpu/NEkPmKrJxWe4c
         I70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684832802; x=1687424802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNbc2Gn4lCWbgtCz86CXU5/fu3n/2droTjC+nnxxbnU=;
        b=hZHyRz/dwHJcPAdQZCoNuAe+tniPZMgaqOpNWpJGlIMnBrpz6EblnYJY8o0Om9je9G
         Lga5zGOct4G+BJTb2WTX4Pu30+8p2izfKE5uRr0vkcJ9pQUK412/DKpljo3QAzwFRKOM
         0EIPYCA2/qcuz+++/E2QwJSJLTY/MCc9AqZtXnJX3hncE1D39s7w6GWCkzi3FUQ1nst2
         t0t657QxzteW8Sf/8NhBeRmVi1RDKYpGg1MeLJB5qhqAcvNzhsI/FClBAxgCdoqy155S
         bc17Rth5WqykpgNq8YwgHFiJaRv1z6IRHh2npThm7acGfhpXDsBn9vv+QjhlGIAsU+k6
         r+dg==
X-Gm-Message-State: AC+VfDyyOllwusn1fYD6p52HNBgU430qdXwuM6JkRL/I37IjziOrhHI9
        dwkEHjKBgKuSi3wa+w4q5V1JK3emcumjIUnOU/E=
X-Google-Smtp-Source: ACHHUZ7OBzMGCd5AtWIGzVeJwMHrjBmKNnV5JqscoqzMJj+eGF9s5MY0iuG0V6bLOa5yYQbkI49TXQ==
X-Received: by 2002:a05:6a00:23cc:b0:63d:368b:76b4 with SMTP id g12-20020a056a0023cc00b0063d368b76b4mr19569935pfc.17.1684832802632;
        Tue, 23 May 2023 02:06:42 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id b19-20020aa78113000000b006410f4f3ecdsm5338195pfi.83.2023.05.23.02.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:06:42 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v4 2/3] efi: Add EFI_ACCESS_DENIED status code
Date:   Tue, 23 May 2023 18:06:05 +0900
Message-Id: <20230523090607.1433-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230523090607.1433-1-masahisa.kojima@linaro.org>
References: <20230523090607.1433-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 6d6c5e384345..b3b74a5fb60f 100644
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

