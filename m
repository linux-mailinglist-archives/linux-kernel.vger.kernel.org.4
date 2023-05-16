Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FB470545B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjEPQuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjEPQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:50:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A877EE1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:50:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3078c092056so7815292f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684255805; x=1686847805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4qcI2UTgZBwmxBO2YPA1Xt+uX1yMcShj7SW095AgSs=;
        b=eIo3pQUeGiiTOYwGxpxeVm6OwmeYB3uuGYEtG2v1WCR+hnsIrCDHG+XTmCHl0NFWD6
         njUQgZ++1AiorFA3iZjn0WqtlqZALAR7ckqO0jrOreNresiY+15oo749U6wRfhpXb1m7
         IraRKkPZ0qU3x9S9t6C676Ig1BY6/CZIh33cqIvEChr456j58p7Dj2hJejGghagBURlI
         qisIcT+L8xEMfOhRZccCzQihJtU3Z2IHhGCtTiCP06OqKOgQgrSrGo/7yQHZCsOdB/9s
         G+zwnIFMVBGPbUnXtBnghxM5tkaRhsztKKE96qu7Lq6cvHuhynUEUZELIiWxZ8wQSanT
         uxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255805; x=1686847805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4qcI2UTgZBwmxBO2YPA1Xt+uX1yMcShj7SW095AgSs=;
        b=cSn/rO/HtLGQeutpuD9W1IQBKvmtPS5+FcvDzxG/8gu9mb8ncPbeztICBazzNXLYz/
         n+KtXToHrTh4PHeC9ciN8oSOUQqP6v40VdP6i/Lrm7/LghuiGX2Zt8nhaL6Lww6VYk7A
         679EUS4wvwvdQU3Vkg3ioR4WhKhzvbxK0GJ0FGTVbcI+LelTjDfXgiQlg8E4jcLuNnKz
         1dnkSXcToL5BcINsh4ut5EmvGZxRbFePlpq04mZS6QUSR9rvXMYvDAMsbdYUUPoaSW7w
         o8twV1OSzR1xr2pgBKn9dOHzmGltqQ/l0Vlza3iRIZyU8BJmDgM28Xlyl0udXF3xSgsD
         P8Xw==
X-Gm-Message-State: AC+VfDxRzRCAULMHBAcWYMgT4I2xnrpD70GX11Ek+bsQesvf4kOuXCXb
        186RhDG48er4vlOa11iJOJRe88n/tQ==
X-Google-Smtp-Source: ACHHUZ4kGZwaSaeHY+R6mP9SXvzmHfKZIHCZca0E29ysHU4JbOcxf2cNLl36SYeAiZq7gLiorct8Sg==
X-Received: by 2002:a5d:540d:0:b0:309:38f4:fb45 with SMTP id g13-20020a5d540d000000b0030938f4fb45mr1753616wrv.46.1684255804677;
        Tue, 16 May 2023 09:50:04 -0700 (PDT)
Received: from localhost.localdomain ([46.53.250.37])
        by smtp.gmail.com with ESMTPSA id d10-20020adffd8a000000b002f22c44e974sm3094789wrr.102.2023.05.16.09.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:50:04 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 2/3] auto: add "auto" keyword as alias for __auto_type
Date:   Tue, 16 May 2023 19:49:46 +0300
Message-Id: <20230516164947.86543-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516164947.86543-1-adobriyan@gmail.com>
References: <20230516164947.86543-1-adobriyan@gmail.com>
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

It has similar semantics to "auto" keyword from a language
which can not be named on this mailing list, in particular:

	{
		int a;
		const auto b = a; // const char b = a;
		b = 1;	// compile error
	}
	{
		char a;
		auto b = a; // char b = a;
		// no integer promotions
		static_assert(sizeof(b) == 1);
	}
	{
		int a;
		const auto p = &a; // int *const p = &a;
		*p = 1;	// works because const is applied only to top-level
	}

It can be used to save on macroexpansion inside macro forests which
use typeof() somewhere deep enough. It is cool regardless.

Use "auto" in your code today!

gcc 5.1 supports __auto_type.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 10fcc64fcd1f..d316924a466a 100644
--- a/Makefile
+++ b/Makefile
@@ -570,6 +570,7 @@ KBUILD_CFLAGS += -Werror=return-type
 KBUILD_CFLAGS += -Werror=strict-prototypes
 KBUILD_CFLAGS += -Wno-format-security
 KBUILD_CFLAGS += -Wno-trigraphs
+KBUILD_CFLAGS += -Dauto=__auto_type
 
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_RUSTFLAGS := $(rust_common_flags) \
-- 
2.40.1

