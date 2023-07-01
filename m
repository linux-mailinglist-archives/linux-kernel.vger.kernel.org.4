Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF474487B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGAKcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAKcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:32:18 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD73ABD;
        Sat,  1 Jul 2023 03:32:15 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1a28de15c8aso2626718fac.2;
        Sat, 01 Jul 2023 03:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688207535; x=1690799535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGpM6CzxS23sdxO56fNlVqxcfTCp7IVYaCNZLh8aKSE=;
        b=PAsUACBjiDmca1uG/cRa+14CvaPNzBosEv8uPiP0xVRTBr8sp9MjKGQMzq/zGxnJ+z
         V20eFrw1c7Sc86rs2aIEp8e/0PwK0/JVLSq3RlEzJyfz49Bt2FAS97ZkGbHloaOO41he
         orYdC2d8lClXzIPoE6IeOhzPt4PuV/RARfQVq2XuNlgnJ/K+VQMaPNjvyBZyN49+eBOp
         9fV3AqlQiI+Xb9odyCryBL+IqOSnTA0sRkWsGXMxmU2zJvED2wYDlPDZmBaMg2OphUn1
         LGQ8/eOZP3mIP77TTjHMlxxJEcwBbVvQFgovssrzGcQ47EIjbHCfFUtSdoWxuGxHPq6R
         PNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688207535; x=1690799535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGpM6CzxS23sdxO56fNlVqxcfTCp7IVYaCNZLh8aKSE=;
        b=VRLLWSeNRQ61vBx9qohGUkBub0WQDhAk1R+lTLaWSmDyuA27TEb/kBWSLIE1hif8HP
         RnkB+826PJ5USL2BEgZ8tHXjPuJNOB+DQFzWfV/cJwmd/QRE/ZK7mXhKVTDior592vY0
         48H+XYKX7GbyJHXNoi9HSKJSzo9y+rTNljOmjs9cqRiEtlecqYOCpn2vF9h6L8btAFZT
         X/AdkQdpweYDdtOSgckew+xg5Ip6+B3/JRYiQLAgyRjhwnR4qbzkhpAT6mrqn/wqwBXQ
         wzTC2m1D36sZLBPXTHe0hPUgKLa2zaxX9Oj82/Sft3q/QYtk34l4Wz4pnat6iunZVz8Y
         qrCQ==
X-Gm-Message-State: AC+VfDxu7+yaBx2xWttYhh9vfApifi81JcZ8j8DXg0w3urXtBrPGzJhK
        DRqoVmAQKVIMt420vMbR5Sq8ZMWLoIY=
X-Google-Smtp-Source: ACHHUZ5uOA5xbSyBGlBFlIvtCukl6K/M9dx0Xq1bDXphbQ7Vs1joYUrrpgWnjuzV3/KyCCiI5W6G8A==
X-Received: by 2002:a05:6870:e253:b0:1b0:6f63:8619 with SMTP id d19-20020a056870e25300b001b06f638619mr7416607oac.24.1688207535215;
        Sat, 01 Jul 2023 03:32:15 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:fb41:4abd:2fa3:e68b])
        by smtp.gmail.com with ESMTPSA id x187-20020a6363c4000000b005533b6cb3a6sm11753316pgb.16.2023.07.01.03.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 03:32:14 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: fix lock_mm_and_find_vma in case VMA not found
Date:   Sat,  1 Jul 2023 03:31:55 -0700
Message-Id: <20230701103155.1209274-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU version of lock_mm_and_find_vma releases the mm lock before
returning when VMA is not found. Do the same in noMMU version.
This fixes hang on an attempt to handle protection fault.

Fixes: d85a143b69ab ("xtensa: fix NOMMU build with lock_mm_and_find_vma() conversion")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 mm/nommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index fdc392735ec6..c072a660ec2c 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -637,8 +637,13 @@ EXPORT_SYMBOL(find_vma);
 struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
 			unsigned long addr, struct pt_regs *regs)
 {
+	struct vm_area_struct *vma;
+
 	mmap_read_lock(mm);
-	return vma_lookup(mm, addr);
+	vma = vma_lookup(mm, addr);
+	if (!vma)
+		mmap_read_unlock(mm);
+	return vma;
 }
 
 /*
-- 
2.30.2

