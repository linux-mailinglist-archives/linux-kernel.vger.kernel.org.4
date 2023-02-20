Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBAA69CC13
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjBTN3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjBTN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:29:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4195F9039
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:29:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cq23so4418095edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E+1bqLLLjLW1FI/aGhvjFDFwCFvcmqJnn+ZsqlNUCbU=;
        b=fURrixGoK5k53L8wVDs0d6mR/e6wEFmRxZVllR0nFKAFsoFdxMtB9CS/BqxCyCAWC/
         WsMupYa2RPJ4er8qvbP3hVRSFlegDKBA48PSO3hUjKHar2I84fLPXT9lKnxJcZua1qMZ
         THJWIF+Be1VElPZYxzFR2yIS2/8+M5jPGt3Bg+Sa4CF4S/vUPGNgTcBBnGqxA8cxx2in
         x7uiI5PDDWJSPhqRHkwmt9jbnlWTgaQ/gwKpyWYtOgP6Ti3pqvxyFM5Nny6TgdnMsF6J
         V4zTJOXPfKSnXEiG27BjbmHiVwqu5qKiUXU0YuENCSWarCY8tCHzXN71HSuD4ufgYcSW
         iS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+1bqLLLjLW1FI/aGhvjFDFwCFvcmqJnn+ZsqlNUCbU=;
        b=Jo+c/MV7USvzLmyEZPpViMCIXdTrS1MWxGkTZG8cfJFA7j1p4HWCMhriKUGh+rduIk
         R41PV5hZukj6xchj/LKaVVljTk+hlyx0ROvE+3PHBQrk7hUTVoDYOokJfpzYx1N86gPU
         5NWOwxYj9YIeHziLkuoTuLck1kL7fyLXJDuhYdQnzIEf8668TXgx/Vxqs7LUoEyozPvl
         teCqYPqY9HvtNgeKXv3zqm7Rds5e0xOv/KOyiFb3Ze9k2kTZnqkwVTaXxTQPJFfK2kLO
         qHr/and7E77sGu6YcS/p+NljFBe1XJtfok6LSC95t8kBtrSCBBZRo+RKYW0/WkQMurHs
         rpZg==
X-Gm-Message-State: AO0yUKU9uh5raRKhsTre6BwMhXWVnlSXjhiBFJHYJ9Qkk+WY1hwKsbTO
        66WPiJUZoarAwT0uJaVk894=
X-Google-Smtp-Source: AK7set/7nCkWFh2Wa5wiZ5OIAt77f8rKElmiJ65OuAtMsX5nOjN/9XgyIIrg/7kzQ1vpt+AeL5Awzw==
X-Received: by 2002:a17:906:4b02:b0:8aa:c143:ffe1 with SMTP id y2-20020a1709064b0200b008aac143ffe1mr9642772eju.48.1676899757794;
        Mon, 20 Feb 2023 05:29:17 -0800 (PST)
Received: from gmail.com (1F2EF163.nat.pool.telekom.hu. [31.46.241.99])
        by smtp.gmail.com with ESMTPSA id z10-20020a170906714a00b008ba365e7e59sm3576213ejj.121.2023.02.20.05.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 05:29:17 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 20 Feb 2023 14:29:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/platform changes for v6.3
Message-ID: <Y/N1q8vlYJMyrwSr@gmail.com>
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

Please pull the latest x86/platform git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2023-02-20

   # HEAD: 7ddf0050a21fdcc025c3cb1055fe3db60df1cd97 x86/mce/dev-mcelog: use strscpy() to instead of strncpy()

Changes in this cycle:

 - Simplify add_rtc_cmos()

 - Use strscpy() in the mcelog code

 Thanks,

	Ingo

------------------>
Hans de Goede (1):
      x86/rtc: Simplify PNP ids check

Xu Panda (1):
      x86/mce/dev-mcelog: use strscpy() to instead of strncpy()


 arch/x86/kernel/cpu/mce/dev-mcelog.c | 3 +--
 arch/x86/kernel/rtc.c                | 9 +++------
 2 files changed, 4 insertions(+), 8 deletions(-)
