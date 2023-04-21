Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC06EB1E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjDUSyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjDUSym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:54:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2F21FE3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 11:54:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so19904735e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 11:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682103278; x=1684695278;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nffel26x+322FTsNOxdHjAkwK0bLjcBonRh64qTy50Q=;
        b=enmoIEoTxV6A6xpxbkvcC8RbrkD7FQvZEf8I/bghiFol5wMO1FZ1wrwG0KNCYJRMI+
         axMV3oFQNcipu/u2PclkV3xGpd4l22v7Vv7EFS8SVwST5i9j2odLayWpZU7qqqOe6xdH
         m7VaCMVpULjHSTja/g1cJw/8NYoBZ6RfgFFIWU3lKkNRYCfyati136UxpaRo4kTH8bFw
         hCEhMdIMUIIbINZC5FFmyygD61hKkw01XtlrJm8w0raNLKFV8T0d0GpCNrJiEKgDHrCw
         auV42qIBCf65efFj+U+U9M2d/HIzJ3gz84h5MazzP5/vZmmMH9Y/Q1LvX2N/1auMmFmW
         v1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682103278; x=1684695278;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nffel26x+322FTsNOxdHjAkwK0bLjcBonRh64qTy50Q=;
        b=N5ljzIALvwct4zzf6dAPyVrj/Y5AOUuBCVArQR5EZUfiKv0hbeQGbn/6mTxD3ILEMo
         5fGMkjy1rwbGd9zUCguZvJHrqUudHRuKtvc5dXomM0rii2vijlKYhtYfhnttC0djhsUJ
         SpBVPeT0fxCb4XFLgrtHzSnrHDDGUV54hvN9wwbkRw6b2OiXjLJgwT/5Ha/RBMEsM9kc
         Y4YghKZfq5emWGLVY7S/61pFQfDRkUa+epfn95FRg5aQDgKRdF+Toy6/pKxd3x/NVP3I
         C11zVS6AsxCVsvnW9B4cRiiX5VFyREJL0boW8Bva4hkxGptSvYla+qD8k7iStQjU2CoU
         S/5Q==
X-Gm-Message-State: AAQBX9f/zQQ3dQUFn7+B7dTZVW9hsOi4bVr5l8fR8igRcCjlXsO7H87s
        19AUPQiz8v+fSocI4n/X4jnl2r5r2w==
X-Google-Smtp-Source: AKy350YGm9UlNIBBs4wWfm7zxqSa4vcoO8Z2C6nvcm7/4Olys9+3+D03xYufmyeBoiy4fZhUpqIw8w==
X-Received: by 2002:adf:ed50:0:b0:2fb:92c7:b169 with SMTP id u16-20020adfed50000000b002fb92c7b169mr8776906wro.10.1682103278517;
        Fri, 21 Apr 2023 11:54:38 -0700 (PDT)
Received: from p183 ([46.53.252.188])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe44f000000b002f00793bd7asm4987868wrm.27.2023.04.21.11.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:54:37 -0700 (PDT)
Date:   Fri, 21 Apr 2023 21:54:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ELF: use __builtin_mul_overflow() more
Message-ID: <dd85c092-379e-4d14-88f0-8f3910de9f7f@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__builtin_mul_overflow() can do multiplication and overflow check
in one line.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1651,9 +1651,8 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
 
 	/* *Estimated* file count and total data size needed */
 	count = cprm->vma_count;
-	if (count > UINT_MAX / 64)
+	if (__builtin_mul_overflow(count, 64, &size))
 		return -EINVAL;
-	size = count * 64;
 
 	names_ofs = (2 + 3 * count) * sizeof(data[0]);
  alloc:
