Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADEC73FC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjF0Mnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjF0Mnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:43:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AEC26AF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:43:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565d1b86a64so47392857b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687869816; x=1690461816;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BeZ04hbX0o0OGbczXpo+BMf+c6CF1b+wPc/4mciyaDk=;
        b=N4jr1ly5sXWSLB61CdJ88r1mZUD3cS2jkXNpOj7eN2zwCJy4PEuMh5OXXvZb0NpavI
         WBTjIiJhRvLDh1BDoJvVk73Pv/MftEnH93xLt3TLXcWQ8F9oWNT4ixsTWXPe0kXKobyZ
         4ZhFhh3p6UDyc55dNpR3jKVB7hIMXGeoOnw7sGj/vqiJg0+5oX6+vEQJ/seczUDQS7z4
         PykriSaN5nN88uFuWZ7zX2wiDQ0PLsVMVl8aJl1b/n6ff8LcgCksrU5E1tp0J+CZgLuJ
         b2JI7tpAOPEbJ0iRvWMsvjs0SAWe3ysxm0sfHZPKMAzy49swu7K1zE9WH3qRuc135AOD
         Yrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687869816; x=1690461816;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeZ04hbX0o0OGbczXpo+BMf+c6CF1b+wPc/4mciyaDk=;
        b=Mf6XXwwxJ+ia9iz0kMkM2THnRROF+92LJRwmE+X1xXPdUT+Bsf6gJNlXgn7lsAD79r
         qwRxQgaeJVMGqJdkiZ0ohrfswrMEd3xuJOUGNmfpfvxwhGYhqVwQRnLpoPPVgz7Zb4+I
         tUgN7CsKM8eoyu4+KC1BlVkiUtmoOmQy8uBAvXseAjliyYD9lTsPeAHxDrCotBKYlf3/
         71tH3ZGY6v1HFEReMmh/ovdtK2++q1jnJsxiZMFoz9pTLnkyHApm4d/GFdt4x2KXy6IL
         +VGeH9LPxqwKPncPotjHmT/soepKz07Z3xPD2KNT3Ni4At/1OH9PwYs1jmm5N83gy2G8
         eYSg==
X-Gm-Message-State: AC+VfDzygUegRi66bJDERlZVgyIDKuLCtBMHF1C1MhlIpR7ovAoYOsnS
        8oFcYrIJj0a1nwMr5GjP//kQoYf6AbuVr8DjocV66N46VZLMFffkjPrtZjbSb8bnlk8zD8thzEy
        nKi3vwY8fQgeopfwABqv4JsGUEJm71RGp0CfW5zSqlVmu2O2zdc3vzaW5KJ98ZFOw681gfcm/z9
        w=
X-Google-Smtp-Source: ACHHUZ7EbEy6fAjpgj1zgm12/sgVflV0BqhZDMWbjW4N5VbcCmo80YOqLO1NzxO1qWZaKnB9Y5GTY1H3lu9AEQ==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:690c:701:b0:565:bd68:b493 with SMTP
 id bs1-20020a05690c070100b00565bd68b493mr14670642ywb.6.1687869815849; Tue, 27
 Jun 2023 05:43:35 -0700 (PDT)
Date:   Tue, 27 Jun 2023 12:43:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627124332.82758-1-jackmanb@google.com>
Subject: [PATCH] scripts/gdb: Fix importing SB_ constants
From:   Brendan Jackman <jackmanb@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org, f.fainelli@gmail.com,
        akpm@linux-foundation.org, jackmanb@google.com,
        p.raghav@samsung.com, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f15afbd34d8f ("fs: fix undefined behavior in bit shift for
SB_NOUSER") switched these defines over to use BIT which when,
!__ASSEMBLY__, expands to something equivalent to 1UL << x. The UL
suffix isn't valid python.

Luckily we already seem to have a facility in the preprocessed code to
handle cases like this.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 scripts/gdb/linux/constants.py.in | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 471300ba176c..50a92c4e9984 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -48,12 +48,12 @@ if IS_BUILTIN(CONFIG_COMMON_CLK):
     LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
 
 /* linux/fs.h */
-LX_VALUE(SB_RDONLY)
-LX_VALUE(SB_SYNCHRONOUS)
-LX_VALUE(SB_MANDLOCK)
-LX_VALUE(SB_DIRSYNC)
-LX_VALUE(SB_NOATIME)
-LX_VALUE(SB_NODIRATIME)
+LX_GDBPARSED(SB_RDONLY)
+LX_GDBPARSED(SB_SYNCHRONOUS)
+LX_GDBPARSED(SB_MANDLOCK)
+LX_GDBPARSED(SB_DIRSYNC)
+LX_GDBPARSED(SB_NOATIME)
+LX_GDBPARSED(SB_NODIRATIME)
 
 /* linux/htimer.h */
 LX_GDBPARSED(hrtimer_resolution)
-- 
2.41.0.162.gfafddb0af9-goog

