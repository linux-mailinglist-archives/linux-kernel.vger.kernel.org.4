Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3F70854A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjERPrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjERPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:47:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DD718C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so15541265e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684424826; x=1687016826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tye9L3auG/VYuq8Wu4br+PZRvWyj+Q5KoqkXJFSM6kY=;
        b=nm9gUVFy6rjGJIT0KFUSVbQLlAiWcMvEAfmiDxi166GZPFhyV2otVC463q3ZtwqWiF
         4RI3AzxUxTCnFdmOnAyUaUzJPyeaMmYg+u4muNSWI6Ez0UoC6bkWbYm2ERQHrTS9nLjf
         RzMpp3BhCIbLsbmqTsWHJJoLcBUmYIetei5/GjwQraTQ91CFWn38bW37nt0eY8grkVn6
         CJY78GDl0OIT/h9Y94IMkIy91TxLw+vym23pti8A1uFusT4qJM+K3iu0BZ7TUPPirOdO
         GKYnvbngLrR+4IOPEXB4N6HtbZ06nrck3h4NbCCXToQ+LZZ3o9LvWRzkigM26IA3aawK
         gxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684424826; x=1687016826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tye9L3auG/VYuq8Wu4br+PZRvWyj+Q5KoqkXJFSM6kY=;
        b=YfWASBDVrKQjN0s0cHwJ5E6p+vnCqpLDGFtBXECJ/eO34G7XPJzuJWtMYxR1tL3HsI
         7TuoWKc3wag6Xam8/pyxIkuaXayIUHWBnKnJzsau8yKQPbukQZe7Fm9YZd8NTj0CFqKP
         roUbOtrkUMUE0dgj1Vc9cV8/6oTYZ+xO3KkZnqwd8iQvbzHW6bmEmok7iAxRgyH7cdkX
         Xxz6fecztSuMTeRFhtnT1DRiEZKJKLolKXwNY5oOQBuS/DXWvc1GsatLP/FS6621vNk7
         V2WJzuz1wpkjEZ92cTGWQkJA09MjaHhlempWO2CZXcP/PYhyblF2pIK6SCykAzxJdxLC
         CN0g==
X-Gm-Message-State: AC+VfDwgW53bgyX/xNgOSM+zGtH+nzrNoCspmN9Q9oEktD0wNGGVKBOh
        Ft/Z7bYnKGpp4MfS/kOCbo3J5u30Yw==
X-Google-Smtp-Source: ACHHUZ4CWg2S+NM8yKxQ6pHQqB+d61K2qFnME6dkQjqIz9UQqvrcO1ltTu2eChC6ABYTl2TNhuCwEg==
X-Received: by 2002:a05:600c:b4f:b0:3f4:f0c2:125 with SMTP id k15-20020a05600c0b4f00b003f4f0c20125mr1788676wmr.23.1684424826040;
        Thu, 18 May 2023 08:47:06 -0700 (PDT)
Received: from p183.Dlink ([46.53.250.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003f421979398sm5671769wmb.26.2023.05.18.08.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:47:05 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 6/8] auto: promote DIV_U64_ROUND_CLOSEST macro to function
Date:   Thu, 18 May 2023 18:46:47 +0300
Message-Id: <20230518154648.581643-6-adobriyan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518154648.581643-1-adobriyan@gmail.com>
References: <20230518154648.581643-1-adobriyan@gmail.com>
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

Both arguments are cast to specific types, so moving cast earlier is OK.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 include/linux/math64.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index d8770c8a9cff..3ab235c8a94c 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -328,8 +328,10 @@ static inline u64 DIV64_U64_ROUND_CLOSEST(u64 dividend, u64 divisor)
  *
  * Return: dividend / divisor rounded to nearest integer
  */
-#define DIV_U64_ROUND_CLOSEST(dividend, divisor)	\
-	({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
+static inline u64 DIV_U64_ROUND_CLOSEST(u64 dividend, u32 divisor)
+{
+	return div_u64(dividend + divisor / 2, divisor);
+}
 
 /**
  * DIV_S64_ROUND_CLOSEST - signed 64bit divide with 32bit divisor rounded to nearest integer
-- 
2.40.1

