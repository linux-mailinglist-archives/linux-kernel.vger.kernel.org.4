Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3C668ABDA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjBDSed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:34:31 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F7B29E0A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:34:30 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso10436006pju.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kxicov2ebXbMqKupnBjo4AO+peB87PtI30NHkCzhsxs=;
        b=iFZtF7mZLlg2pj/JdrijhYQz0A7XOBSQICekBwJcr0HYNdHbqBkc07FRNH7DpqTG8D
         tq18Jcml6WHSrW99u6XfwKhTRhiyjb3T0vbRRPLchueLvaOyUo0qOwVoCmoKcHEZMsAb
         5nFow9oentxxFIEg5f7plU2PKQukNQLl+FagA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kxicov2ebXbMqKupnBjo4AO+peB87PtI30NHkCzhsxs=;
        b=cb65+WRw2UAsQRkgPF0q8erMVcnvmtGqmahdC8a/QrOJvPfkOi7evdOxtetlV7Ko4q
         bHSvYh/VFW+OnhuPxlW/HWV/zZS6PtI8N9AC17hrvdWXx6Q6jZf9mBDlpbWpSQZ79t++
         oKHrcQ/GB5ZIKLxABwt1T+ddqGbiFXHtpyiim7Xv6rf1E8A7ctTh7VW/d53QaEYS/0/Y
         UYpnvb2BY8SWXRwTChOipGINwq2eXJ1aTyNd9Fhb0/aQaOD5nyBRLqsAfb5Fv4VspV1b
         asiT6Y02jVz4iArUR5a7BT7x5w6yXaIgWFXV3gB5ImuYbciV4XcUK9bwjjF2GeH3G7Hd
         Kj2A==
X-Gm-Message-State: AO0yUKUXiawVV5laA6DdjCuarJIzxzsweUwfMcAUoK3eCrIxk3EAb/r5
        syH+YyDmql5lv9i3wkCJI2IqAV4ZtEQWKh0t
X-Google-Smtp-Source: AK7set9/4ynVyg52xhq6+81+lcy1Xaq8EvmrzQue6Zastw62zQrbXd0J1eG6fLn1ssi2FS3ZD5+2tA==
X-Received: by 2002:a05:6a21:788e:b0:be:d4fd:bb14 with SMTP id bf14-20020a056a21788e00b000bed4fdbb14mr18439003pzc.47.1675535669670;
        Sat, 04 Feb 2023 10:34:29 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b00186cf82717fsm3745146plx.165.2023.02.04.10.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 10:34:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jan Kara <jack@suse.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] udf: Use unsigned variables for size calculations
Date:   Sat,  4 Feb 2023 10:34:27 -0800
Message-Id: <20230204183427.never.856-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389; h=from:subject:message-id; bh=VRwNzRTi6LcZ6ZVqSd89Li8t3x77uYWI9N+bQTnK9m0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3qUz+il9jLBqmkgMzWwOvwKBbUbMdveCpGjZhX1O DUMjUDOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY96lMwAKCRCJcvTf3G3AJqXpEA CsumXPOU2ImUnElYzWsx3h+j44zeu5chhHmc3XM5R/9QIubvYXMCGeFGUeTEhnIttFNu3GEvltwijz g86iAyka6bEttwJSL0f3aLJ0cvni8MAjOJpuzeQ2ABoWCWykeJBdmQwZYx5zRL+w/TvXgTLssGUcM4 +4etNwWaPx2jSmI9IiJhXp+9EHKZ9G1a9w9GodRhu9xSrUq2B0AZ6I8SBUXk/LY4p0CjjOOa/kcvgb F+4Mclfmd/cEEzx+GPnbO8DHstNaGjYAVsQljAs04chukqUFMghWXhGXN9+FHCQCdMtk8aHWq7Ua8M TFTQD4Heq47p9pidj9+2jVS8VXDVK66tGPMZelHQ0xmMCAsoeSOC4xPGsT1b+WUZHfmzjumWpseWHT 22cD2J22sEfja5JGsQ3Nmb8L6Qk/nZhwGPe7z32llCAllPCnXBUhgO3SuPBfEe3O3A6N7bdVQK7k/Y UC/9yqihY+WjWlmH4GqurjzryoZ/3/Q5ZXryiJcRCN50yhf9g8Sjxhr+Gm3wnf/LobOKogjaho+Gns T03AQh4zFxmM24iz1b5iLdRaQ4nap4HRD80Af1WvCZzAe4BsyJ08Yg0kSYtc7J9dx5+a7/4QXScT0G AGvDNr1M7beBshAFwD73tqJOGzd/alTHmPnS8Ibu1j/Gpo78s9QOb2E9oWWQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid confusing the compiler about possible negative sizes, switch
various size variables that can never be negative from int to u32. Seen
with GCC 13:

../fs/udf/directory.c: In function 'udf_copy_fi':
../include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' pointer overflow between offset 80 and size [-2147483648, -1] [-Warray-bounds=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
...
../fs/udf/directory.c:102:9: note: in expansion of macro 'memcpy'
  102 |         memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
      |         ^~~~~~

Cc: Jan Kara <jack@suse.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/udf/directory.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 2e13c4b5fb81..e0bb73d414dd 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -71,8 +71,9 @@ static int udf_verify_fi(struct udf_fileident_iter *iter)
 static int udf_copy_fi(struct udf_fileident_iter *iter)
 {
 	struct udf_inode_info *iinfo = UDF_I(iter->dir);
-	int blksize = 1 << iter->dir->i_blkbits;
-	int err, off, len, nameoff;
+	u32 blksize = 1 << iter->dir->i_blkbits;
+	u32 off, len, nameoff;
+	int err;
 
 	/* Skip copying when we are at EOF */
 	if (iter->pos >= iter->dir->i_size) {
-- 
2.34.1

