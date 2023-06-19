Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA6B735DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjFSTsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFSTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:48:03 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C192118
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:48:02 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1aa161c3796so1919323fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687204081; x=1689796081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KdqIxbHxYkkYgey/kFZ36FiTNQJg7ZkQlMeqqDct7I=;
        b=N9k/9MiNYmIA4yWMCszP7Kdcz1ZTINAzqm5vnFIah/Dlcvk1bSDwLGabThl2SK1Dcm
         toyxplg+0y6JT9mvbsFsNNryEctPMZG49tPix5+3sC4vImYUS87igG26JmEhInvVderl
         HlrU96xQfOu5wRIo6i8GqzTpgk3TbJHBebE9bWeWhMakMLIY2GhNWyg/ja45JZeUW/fA
         YkFua3gjGoQmcOliGuazRaoEERENqwWevEoZ5lfevxvWm6EJP4UMxn1FCchJ+oSETniN
         GHMuRW3O65oAR2mk80y2W7XG97GGWHa4pQOQJ3bvWYQheJH2m1yRi7WKp/n1qQ3vJCZb
         IIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204081; x=1689796081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KdqIxbHxYkkYgey/kFZ36FiTNQJg7ZkQlMeqqDct7I=;
        b=jb/2GJ+11g/yDRhI7Oa7mi5bjQohDHDpF2iK3lttyFjsTq0EPBmGD/quWw7wbGChtW
         uyZElyOrW+qpm7yIbolUfufptgFnp8XhL4xU6H14clps3IaHomXH44yZSV5WHKr9iQnS
         amYsOEj9O5xJVcOY+mZAtVS7RN4bJSF9lQJmUgl63ZWuMx4SwSsd4WikrbgFh/vs9hjh
         rOombCi2s2wkuvEKuTvGQFhHVYQSzsS3AELaYUgVpnI1LEd52VfssuyD8sOCeyS8Rphe
         7i+6oBC8jfU+CEzhN3RO45Tb0rh1YQmktmTaxRv937UdGkARBzaXzSZLrsM7eDcMNr+v
         pF5g==
X-Gm-Message-State: AC+VfDxUz131utenBQmY+SYr6P4xUrdJ6wncrybOJ4S4/9IEIu2ePujc
        lTOd5o1PpFmrKjNYtx8XODrL4j1WcA==
X-Google-Smtp-Source: ACHHUZ7SlPbvnw+BUuZr3SDhttq/auEEvL9EgE8rLVGwKzICvRCGRRgZ+CCYOJDhuxjqF9OSDANNYw==
X-Received: by 2002:a05:6870:3a12:b0:1a9:9d07:f3a6 with SMTP id du18-20020a0568703a1200b001a99d07f3a6mr8377348oab.7.1687204081165;
        Mon, 19 Jun 2023 12:48:01 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870f10e00b001a9e4167444sm250939oac.44.2023.06.19.12.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 12:48:00 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/2] x86/syscall/compat: Remove unused macro __SYSCALL_ia32_NR
Date:   Mon, 19 Jun 2023 15:47:44 -0400
Message-Id: <20230619194745.80552-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619194745.80552-1-brgerst@gmail.com>
References: <20230619194745.80552-1-brgerst@gmail.com>
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

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/ia32_unistd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/ia32_unistd.h b/arch/x86/include/asm/ia32_unistd.h
index aa065c94ccf5..7bcb82951c11 100644
--- a/arch/x86/include/asm/ia32_unistd.h
+++ b/arch/x86/include/asm/ia32_unistd.h
@@ -6,7 +6,6 @@
  * This file contains the system call numbers of the ia32 compat ABI,
  * this is for the kernel only.
  */
-#define __SYSCALL_ia32_NR(x) (x)
 #include <asm/unistd_32_ia32.h>
 
 #endif /* _ASM_X86_IA32_UNISTD_H */
-- 
2.40.1

