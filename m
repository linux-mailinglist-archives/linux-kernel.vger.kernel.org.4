Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86B861E169
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiKFJv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKFJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:51:25 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6678BDED9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:51:24 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id s196so8022761pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EV/3kxf+JYStgK+8mVTMI1s6/+ytl6YUPKqqhQP70b0=;
        b=a0Y5uLuqtiJAMKqE/NZ5uFs9XzJB4NAt2xmaqsK57kjOyJoOPZoNMAZ5NG7yCeA4xF
         jyAdIsEcwrwhJNZqPkVcR5x6K2AQQ7ax6oh0odY9H67C70hZ/drIUFG3qxCKMMOYQQNL
         tPOw0AH3OQJsU22eIynFO75b2QWfpotg/ZkuRUNa2i3O0zAiB11fHvyx44aL6t4SlWk8
         TfqVIHu7yKNcjSIFibHQ5Xy2TJNJXGcRGhmFw33gmtGjxRJkw7q9+tynK6KmA/K1Ai2j
         tkgTiGr6bf/HfIv+XvaF2B1S4IcNbl2faMnP10kVKWGJXTvYCX3k2NEoLgYHUmqCFVks
         hkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV/3kxf+JYStgK+8mVTMI1s6/+ytl6YUPKqqhQP70b0=;
        b=cvBtk68TVBx5mHVuknLUWsO8lQ1j6AHYFAJFMMmTF4LeTW+HipvGafqxQMfXfNMbeP
         3JhfL6VmiW3fwLcfCiAWt+7HojGjR/cgXqMb+swxP62dBAhV+bjaBFmyn2eRAayrvdJz
         DkXHogeVskZxsRxmO8xmMPE9lY5QJnBZozPwh/hgUFYyqs7vD9Ru+oB2EbaDuKbz6n36
         iTKBU8HYtOxNKuepKnGivWXms1jb7J2ZkPudJvTRzkM3/YW6bEJfKKuw6nWGx7Hxb46J
         GPjUewB5cqlyZq7P1W+Iq5tD1tBtaf7bK6ceJOe7exRpxWQytmlLL/o1/8BJ/59S535W
         XCbw==
X-Gm-Message-State: ACrzQf0i/dHRY7Ho8QlPjhHVNp1eCY8H48qieeaC6UsVbKyCw37BStI8
        8g1X49pR7JCu02n+UcH4FFM=
X-Google-Smtp-Source: AMsMyM4giBWvuuh/UBWaftSlfsZqJJHC6BdhoGFblLVwMVYxEi0pCX4KR5+2uyXKyFloLWjNC07M3w==
X-Received: by 2002:a65:6bc7:0:b0:44a:dcee:18a5 with SMTP id e7-20020a656bc7000000b0044adcee18a5mr37749031pgw.413.1667728283714;
        Sun, 06 Nov 2022 01:51:23 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id b5-20020aa79505000000b0056bfd4a2702sm2368677pfp.45.2022.11.06.01.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 01:51:23 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        llvm@lists.linux.dev, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 0/2] x86/asm/bitops: optimize fls functions for constant expressions
Date:   Sun,  6 Nov 2022 18:51:04 +0900
Message-Id: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compilers provide some builtin expression equivalent to the fls(),
__fls() and fls64() functions of the kernel.

The kernel's x86 implementation relies on assembly code. This assembly
code can not be folded when used with constant expressions.

This series replaces the kernel assembly by a builtin equivalent when
appropriate. It is a follow-up on this previous series:

  https://lore.kernel.org/all/20220907090935.919-1-mailhol.vincent@wanadoo.fr/

in which I promised to also modify the fls() functions.

Vincent Mailhol (2):
  x86/asm/bitops: Replace __fls() by its generic builtin implementation
  x86/asm/bitops: Use __builtin_clz*() to evaluate constant expressions

 arch/x86/include/asm/bitops.h | 71 ++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 30 deletions(-)

-- 
2.37.4

