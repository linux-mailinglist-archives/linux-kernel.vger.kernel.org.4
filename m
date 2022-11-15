Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E372E62A3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiKOVKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKOVKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:10:45 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB9012D3D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:10:41 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k7so14389592pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x00a1e9-dev.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNMU8TIeSMv0FTr0kNyxjAzh/+lrHRAj4t2ZSINdgVA=;
        b=kWylbFAEh24rQdEt4k+VipJIdPYlOvNYqugMiolgAhVYI9PgwztNserNuOmrnPs7Rt
         kXU2DxMRqY1kx9Yh5hqYbEKp76GHD/GPuIldwdWMdtD5b9WB+IZWg7nOnze8CjeLsKBi
         01HRZ43Y//0vkAVcU0Ae6G3MxWU1rgpdBBURtWVinLubl6gm46db+1vX/+fy+oRl3eNo
         5pPuzbF+TvdK3ZrPbbUy+qNtbOp1UrZKm+YFPii6IUe8kh3UMpJnhx11Eua/ioJZTwyI
         EcCWDfEyz5B2A8giso4odz7tYYCdSWkEkv3uuWyKTZbSVV8NYcPl3MbKqqKc+GrSRvGb
         fbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNMU8TIeSMv0FTr0kNyxjAzh/+lrHRAj4t2ZSINdgVA=;
        b=m+7Mk4jKgv/vLKyV3uOsFNziRltCGdsayIejWDA+03mBvSZ1Yx8ewSXrHtkpaXpnD/
         Ic3avN65Mz3Mh/ijUX7C4YWVePEn8v1F6KqgmcAQYGfjfrcfL/kLRsfvNM3lnztZZOPi
         WwwaNjRaS0tvWxP3IEYPbQa16B2XI5RG4VdH50Tu/MQwUlOV6Xuvb/2CMTRZo7eokEEb
         dc9vlGPlpvQGsAoMyKr/NWvvGflQGbffbGGMf+gnQJnSf8nxLbpuLCrDMt+MNJXDLLjO
         KnLfIOsO62MvvIAhLFc3+5b8aFmVvkBFwuq46w77qw2iAfiz5vqvOHaXG/4xHwphYwB5
         SJhA==
X-Gm-Message-State: ANoB5pmnwItvSCT/rcnhDNCYQw7ToSHLr7+Gvskc9/h6/w68i7mVor3Q
        WD5dmj1npZb8qB3pNaqSrdhVofwESBHr+mzu
X-Google-Smtp-Source: AA0mqf7WExdmGxFIDXNktByWKdeGT1b1xlrTejS45ZqpCc8FWhSnpF4BC2t6/4EeixtUa0BsttbBnA==
X-Received: by 2002:a17:902:ee53:b0:188:5e78:be0 with SMTP id 19-20020a170902ee5300b001885e780be0mr5843505plo.18.1668546640405;
        Tue, 15 Nov 2022 13:10:40 -0800 (PST)
Received: from 0x00a1e9.dev ([2001:200:0:8802:ff5b:df6b:bf6c:21ba])
        by smtp.gmail.com with ESMTPSA id 77-20020a621750000000b0056baebf23e7sm9516437pfx.141.2022.11.15.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:10:40 -0800 (PST)
From:   Yuma Ueda <cyan@0x00a1e9.dev>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        ojeda@kernel.org, boqun.feng@gmail.com, masahiroy@kernel.org,
        samitolvanen@google.com, ytcoode@gmail.com,
        Yuma Ueda <cyan@0x00a1e9.dev>
Subject: [PATCH] scripts/kallsyms.c Make the comment up-to-date with current implementation
Date:   Wed, 16 Nov 2022 06:10:34 +0900
Message-Id: <20221115211034.6330-1-cyan@0x00a1e9.dev>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in scripts/kallsyms.c describing the usage of
scripts/kallsyms does not reflect the latest implementation.
Fix the comment to be up-to-date with the current implementation.

Signed-off-by: Yuma Ueda <cyan@0x00a1e9.dev>
---
 scripts/kallsyms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03fa07ad45d9..e1080fed69fc 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,8 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
+ * Usage: scripts/kallsyms [--all-symbols] [--absolute-percpu]
+ * 			"[--base-relative] in.map > out.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
-- 
2.17.1

