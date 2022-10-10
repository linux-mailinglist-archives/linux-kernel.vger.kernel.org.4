Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9E5F9DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiJJLgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiJJLg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:36:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12866F262
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:36:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r14so16174279lfm.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rSoz9/FRpFY62QV1pyKv838T6CO3VX1FtUYWXZpyZFY=;
        b=KEOarLU0p/YVfrQpMcSO+KSsaQZRbINQKLAiz9H2QYZqVOFKdrS065S0SSqtgMih9s
         ImPAvBHlRlEvz/+1In+Yc7yVYCH8oy5q8KdFoYKQgMupoQp7U8xStCQQNL55H8u5667X
         8YgGJ/7xUpCRJKibu9E1XiwDZzldoOxepJayM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSoz9/FRpFY62QV1pyKv838T6CO3VX1FtUYWXZpyZFY=;
        b=shQrHZgKkqJIZ5ILBYcYikMi5Xfx3CPjTFC4jk2yCpa8T2C9FvL4ixbOEM7UvH1C1d
         LQ0gnORkFFZ0XnvfEM1NcEsWhZIDpdUTOo/w7u/S545CxZyU6Jz/EDzh2zI5D0X1/UKZ
         7z13fNA0jzz16Zg4OMGNSb/x6bkYXp6q6DYn/YTA/brl0lpjWguJ5EWjZvEEYDItOq9R
         lPe/yloODL+qaDB2RfI2Ozuza4nD+NK7Ax8UOSlY7vrFzqKK5u4rSO4EBU+ERsWV1bYS
         J8VzwgvbXRH7J+kSCFYZ9/TtqioBhXX3CFSQyVxrWON6IEFhO99TWpPSpDX0RDtjfbsq
         y8Ww==
X-Gm-Message-State: ACrzQf0KIW/HOj5Qwr02C4l5T7D+7Y3iwJMSaBLnjgZ/SDeIfIruRLqH
        aIVLGNiuMnGf10ihxIus1P2GfYNzLitih3Fv
X-Google-Smtp-Source: AMsMyM79qcUM/JwaPV+SA4l0Uiqkukm17nWVwgWNOSKNAkzcAMK6UA/+rFFW++/PyYCptV/GXHY0Zg==
X-Received: by 2002:a05:6512:1188:b0:4a2:4b2d:577d with SMTP id g8-20020a056512118800b004a24b2d577dmr5888900lfr.262.1665401769990;
        Mon, 10 Oct 2022 04:36:09 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b12-20020a056512070c00b004a2386b8d15sm1382582lfs.212.2022.10.10.04.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 04:36:09 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools/nolibc/string: fix memcmp() implementation
Date:   Mon, 10 Oct 2022 13:36:06 +0200
Message-Id: <20221010113606.2329457-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
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

The C standard says that memcmp() must treat the buffers as consisting
of "unsigned chars". If char happens to be unsigned, the casts are ok,
but then obviously the c1 variable can never contain a negative
value. And when char is signed, the casts are wrong, and there's still
a problem with using an 8-bit quantity to hold the difference, because
that can range from -255 to +255.

For example, assuming char is signed, comparing two 1-byte buffers,
one containing 0x00 and another 0x80, the current implementation would
return -128 for both memcmp(a, b, 1) and memcmp(b, a, 1), whereas one
of those should of course return something positive.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 tools/include/nolibc/string.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index bef35bee9c44..cc1bddcb5927 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -19,9 +19,9 @@ static __attribute__((unused))
 int memcmp(const void *s1, const void *s2, size_t n)
 {
 	size_t ofs = 0;
-	char c1 = 0;
+	int c1 = 0;
 
-	while (ofs < n && !(c1 = ((char *)s1)[ofs] - ((char *)s2)[ofs])) {
+	while (ofs < n && !(c1 = ((unsigned char *)s1)[ofs] - ((unsigned char *)s2)[ofs])) {
 		ofs++;
 	}
 	return c1;
-- 
2.37.2

