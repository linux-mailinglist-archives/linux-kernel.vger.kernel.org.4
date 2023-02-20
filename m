Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A3E69CC03
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBTNYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBTNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:23:39 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A1CDD4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:23:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o12so5059233edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8l95YRAWFdAoVKDb4fm4MMMtCrYao4RIbB5WDhi3KqI=;
        b=dBTNeicXTmopqNJhI9mgRZyTveDsUgFdmM8KW6Kld8wc6k9qRUW+RoU63fIljLWhfa
         AvRSLmHVgmH3I78jWyz7mQvngW8XZbNslH35zt29a8NDovNcT31iZGR2h0ou4EvMVMIF
         Ct8JXbFVT1dZOwOY88q/02N/vXASZB/INV1z1qxK5zZxmxfqj/Ml18f5KQWMlbkQLIJ0
         36Agm87HIvAstXdgwynTT4wLqCJ6IYY9cYgd78k0ENW8MM7K1ux5W2+CMVFWYxzigrLc
         wbWJt2+of9/l05zHJDgYbLp1AkXAOmRhK7Ysd/bD3tExq526cBNfCKWC1QGhLJMWz8GJ
         qZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8l95YRAWFdAoVKDb4fm4MMMtCrYao4RIbB5WDhi3KqI=;
        b=ACosLjDJew7Jm550M3Ykm/dqanl3S4zo/rDWKQ9uEKnifX0dR6flbcgzFdAMqnsI4C
         9Auys0h8pZvU7dqkm+wKXDWqU9nLQnSGXFA8Nas9/yqmihrSk/wCy88GOOGZMtLKrSpb
         Pdq0/Wg/UQWFb85rAAYlGcNqSdOXITu7BZh5RzxADU1lYYzW4JKAFfsXyKzx+cmBJS/F
         RvdBvYH4WVoZDDWeM2cp3vfYBuv6z6280SVLUNuAmW5CsuN2zQ8Y5fmDcoqN25sGZw6c
         JKneRbVZPF6KP4U0UXmlaB8wwb1iZBn/wrbAPsizDQL8mDSoouNRb/e5vKWLIMDKmydv
         CNYQ==
X-Gm-Message-State: AO0yUKWAG/dF8zqNTbmcKxgyzpV9sRS/YGwCieGSdY+flJc48I5hrvqs
        7+3e/DAxan1wBlOBXnpCjbc=
X-Google-Smtp-Source: AK7set+iE3Vfi7MPGM0B3KI+2XKUEeVH0y+zQj6DvpF2YI1rzuJ02VEOCeWDYaWpjJZvkFyc5ztKTA==
X-Received: by 2002:a05:6402:1604:b0:4ac:d973:bb2c with SMTP id f4-20020a056402160400b004acd973bb2cmr2573780edv.28.1676899415948;
        Mon, 20 Feb 2023 05:23:35 -0800 (PST)
Received: from gmail.com (1F2EF163.nat.pool.telekom.hu. [31.46.241.99])
        by smtp.gmail.com with ESMTPSA id y102-20020a50bb6f000000b004acb3026af2sm6200628ede.59.2023.02.20.05.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 05:23:35 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 20 Feb 2023 14:23:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/fpu changes for v6.3
Message-ID: <Y/N0VZlRQc+f8+N/@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/fpu git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2023-02-20

   # HEAD: cb3ea4b7671b7cfbac3ee609976b790aebd0bbda x86/fpu: Don't set TIF_NEED_FPU_LOAD for PF_IO_WORKER threads

Updates in this cycle:

 - Replace zero-length array in struct xregs_state with flexible-array member,
   to help the enabling of stricter compiler checks.

 - Don't set TIF_NEED_FPU_LOAD for PF_IO_WORKER threads.

 Thanks,

	Ingo

------------------>
Gustavo A. R. Silva (1):
      x86/fpu: Replace zero-length array in struct xregs_state with flexible-array member

Jens Axboe (1):
      x86/fpu: Don't set TIF_NEED_FPU_LOAD for PF_IO_WORKER threads


 arch/x86/include/asm/fpu/sched.h | 2 +-
 arch/x86/include/asm/fpu/types.h | 2 +-
 arch/x86/kernel/fpu/context.h    | 2 +-
 arch/x86/kernel/fpu/core.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
