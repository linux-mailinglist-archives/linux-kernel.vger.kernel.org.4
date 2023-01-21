Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAFA6769DF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 23:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAUWyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 17:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjAUWyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 17:54:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95338279AA
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:53:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q5so3089733wrv.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aLj/ODwGBPQt5M/SiFpK9bRbaBx3QXPkN8yFU/v4Uw=;
        b=wLK+/TX2jqUkSLNGrOV33nztWjS0BVBKyxpAoiH+fxZ9SyYAAJN5PpcvQqP0oo/3wj
         xmTqZ8rRmAjdiMx9zPBeQtsGbLpbq5R+YAo+tOMWNR+ulOH9UOCZ4a9PXC9Lu242HtFE
         kabFGpVGVkVQs74hDFrjdscUS97M0D7gathV5kRWGIzNeLGH2o99FiyB+X9Wq2Em7aC0
         1rFFnfr2MFMGPW9O+T1RTdedQNrDRnsYK1JJnuvEn3JEJ7p44TA7zWamazmZVWxVPkSj
         vO7zFgLzmqtK++FZVNNhOLU1tXC1+P4b8vfteMtBzXXBGpZ9W+gs37LshLeDKMc4yhRF
         ngIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aLj/ODwGBPQt5M/SiFpK9bRbaBx3QXPkN8yFU/v4Uw=;
        b=Kj/78k431gUfdaq+K2z5n9cMhuFTLX3Djpc+q8Fi3I0ANiJx1uyPBgaV60A7rw3j0J
         pKHzaCB65IZEgkMG/WQhS6VdpzGQgvPg3Jh/gUMRsjw0y5xiP8GqVLgDK2n/gkBTGyVb
         3/u2SrKZ64TkNFldXe0LnNfTeCybkh7mBKYBf8QZDqZFgQIS0Abw4YyHu3Nr2FoulKTJ
         XDhWKaPSba1DRWBLUxSYXq8cISuwxyBYo7kHGPu4MpQylvz9KG6lVQPQGgpSfoik7AlX
         HOhyA58w1/kwWsP2Nt12KYNs0bhS7Zlp8BOts6nCK4lfgl1htigm+ZZYqFrTjoTQ0/Ut
         EKsA==
X-Gm-Message-State: AFqh2kryd3wlyE/kRX+ODLWTcyOgNkmOeXcY1qUUNBOM+iaVHF3kvxsX
        UvxPOPLuQTOQ0ms9khxOFZXnOQ==
X-Google-Smtp-Source: AMrXdXsQPdS/rsAH2VkJLGhbcDT6rXm833dub6ajarrpe+sJ6MAEQqUcL1XCAkOQNQdY1NP0SX5mIA==
X-Received: by 2002:adf:b604:0:b0:242:1809:7e17 with SMTP id f4-20020adfb604000000b0024218097e17mr16696562wre.6.1674341636948;
        Sat, 21 Jan 2023 14:53:56 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.mpl.intranet (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bcaa47bf78sm29531001wrr.26.2023.01.21.14.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 14:53:56 -0800 (PST)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 3/3] Documentation: kprobetrace: Split paragraphs
Date:   Sat, 21 Jan 2023 23:53:05 +0100
Message-Id: <20230121225304.1711635-4-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121225304.1711635-1-yoann.congal@smile.fr>
References: <20230121225304.1711635-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an empty line to force the output to split paragraphs like it is
splitin the REST source.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 Documentation/trace/kprobetrace.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index febfd3792854f..fda155237be7a 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -74,12 +74,14 @@ respectively. 'x' prefix implies it is unsigned. Traced arguments are shown
 in decimal ('s' and 'u') or hexadecimal ('x'). Without type casting, 'x32'
 or 'x64' is used depends on the architecture (e.g. x86-32 uses x32, and
 x86-64 uses x64).
+
 These value types can be an array. To record array data, you can add '[N]'
 (where N is a fixed number, less than 64) to the base type.
 E.g. 'x16[4]' means an array of x16 (2-byte hex) with 4 elements.
 Note that the array can be applied to memory type fetchargs, you can not
 apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
 wrong, but '+8($stack):x8[8]' is OK.)
+
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
 has been paged out. "ustring" type is an alternative of string for user-space.
-- 
2.30.2

