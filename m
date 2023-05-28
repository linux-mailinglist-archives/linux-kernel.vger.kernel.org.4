Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD9F71412B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 01:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjE1XEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 19:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjE1XEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 19:04:02 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65861BB;
        Sun, 28 May 2023 16:04:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6da07feb2so28240085e9.0;
        Sun, 28 May 2023 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685315040; x=1687907040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nt4lk2LvorDlMmUZwioYE8n8ogEyIKWM/rXoeA3RL0=;
        b=OF8IKCHu66uXUYZ+syto9KLzQ3+6k9rwh6zX0zoHnpv76t2lagTmuKbdav0WKorOAY
         yGN4PcsXv6OxlfU51bncHDxmJqhCqk77beKAjBd4lOOeRc5ELFTHg9X4hj4kawn4qIS2
         YJ7uu01R0pCz/7sClmGED0fgQvEYBh7jXoH8t51hI8tLGAuZh+uL1bAxYXbB/LQiDGfi
         B3r60G7Zipbee3pgSOEwf9YhoRgCPa6ZJbS+pt/zc7dDQdtFfdIs5wzd0y2BgF6EeNAc
         gSwuJh9/DPHsKN7cp3y5kM45Wu0RYPS/cLffEANfFJv9a/bQRh2KrLA/ievJUthXSllL
         ATAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685315040; x=1687907040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nt4lk2LvorDlMmUZwioYE8n8ogEyIKWM/rXoeA3RL0=;
        b=a0JU3+gjHPAAYF/GA2uE4pDQkblpfg3lj8i78j87+H2fhSZLsH/Me/DxCxGXuSj4Cv
         4wgQGme23bYmXHP5MrJHppYnIdpCLmlZpZyk7SLnKjsnhSMDdJD0gEzKXSbLWRiCUroC
         cCC5Qrj6mojXFMFlCzuixbdRZqEaeS4YdxwowARc9h8VQH2KbEegFrVFbKkEt2Vkm4sf
         SsY9IEcTXjaB7D8ava2YgeAJqVDPwKGLl+3pas0+o//OycnhEvGNfxIYqWw6CgwyWjWH
         fIQGN3dxHRrTS8m2+UogqoUdmS8aZTuVZQGk0MXSSVOnA1Q0MX537sZTI2nW0miV/wF6
         JpQg==
X-Gm-Message-State: AC+VfDyeQ4TAXd3Ae9KFUApG6krf32Qw8pBnqfjVQSo0kbGgpD9+n3xc
        ML0/I9DThJW623FboQpZ4UY=
X-Google-Smtp-Source: ACHHUZ7RgYioF0v7TbjQQv7c7coa+aYHcR6JtakCbY6bFt2eN1D6501McbbBUfApptYk4hC3PWUTwA==
X-Received: by 2002:a05:600c:2197:b0:3f6:787:5e53 with SMTP id e23-20020a05600c219700b003f607875e53mr8013345wme.20.1685315039577;
        Sun, 28 May 2023 16:03:59 -0700 (PDT)
Received: from xws.localdomain (pd9ea3c90.dip0.t-ipconnect.de. [217.234.60.144])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003f4e47c6504sm15995411wmg.21.2023.05.28.16.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 16:03:58 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] lib/ucs2_string: Add UCS-2 strlcpy function
Date:   Mon, 29 May 2023 01:03:48 +0200
Message-Id: <20230528230351.168210-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528230351.168210-1-luzmaximilian@gmail.com>
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
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

Add a ucs2_strlcpy() function for UCS-2 strings. The behavior is
equivalent to the standard strlcpy() function, just for 16-bit character
UCS-2 strings.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Patch introduced in v4

---
 include/linux/ucs2_string.h |  1 +
 lib/ucs2_string.c           | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/ucs2_string.h b/include/linux/ucs2_string.h
index cf3ada3e820e..ffd2a3ed84bb 100644
--- a/include/linux/ucs2_string.h
+++ b/include/linux/ucs2_string.h
@@ -10,6 +10,7 @@ typedef u16 ucs2_char_t;
 unsigned long ucs2_strnlen(const ucs2_char_t *s, size_t maxlength);
 unsigned long ucs2_strlen(const ucs2_char_t *s);
 unsigned long ucs2_strsize(const ucs2_char_t *data, unsigned long maxlength);
+unsigned long ucs2_strlcpy(ucs2_char_t *dst, const ucs2_char_t *src, unsigned long size);
 int ucs2_strncmp(const ucs2_char_t *a, const ucs2_char_t *b, size_t len);
 
 unsigned long ucs2_utf8size(const ucs2_char_t *src);
diff --git a/lib/ucs2_string.c b/lib/ucs2_string.c
index 0a559a42359b..f474c6b2fe9e 100644
--- a/lib/ucs2_string.c
+++ b/lib/ucs2_string.c
@@ -32,6 +32,22 @@ ucs2_strsize(const ucs2_char_t *data, unsigned long maxlength)
 }
 EXPORT_SYMBOL(ucs2_strsize);
 
+unsigned long
+ucs2_strlcpy(ucs2_char_t *dst, const ucs2_char_t *src, unsigned long size)
+{
+	unsigned long ret = ucs2_strlen(src);
+	unsigned long len;
+
+	if (size) {
+		len = (ret >= size) ? size - 1 : ret;
+		memcpy(dst, src, len * sizeof(*src));
+		dst[len] = 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(ucs2_strlcpy);
+
 int
 ucs2_strncmp(const ucs2_char_t *a, const ucs2_char_t *b, size_t len)
 {
-- 
2.40.1

