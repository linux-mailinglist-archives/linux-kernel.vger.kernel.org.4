Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082F269CBD7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjBTNPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjBTNOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:14:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A872BDEA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:14:41 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id h16so4728598edz.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tLOVEDpnix7Q9ugiGBHyM3tS+zJ6i1NVh4eILlSalmo=;
        b=Phbb4IUcbUO32qJjIBxlMU0neD0r9lNsI6ndqGMk8UjDWY3eaU3sX9vjLT89uYgQL0
         5ewf6VHaQBYkEvPSVSGiFlxLBjOxhhVPjYAhKFXNsOr8lZwsQyANu64X3axFuvjWyZiY
         AWn+dwMRH9VnOa/qZRMHBd8YwvL4eKVS8PNymE+gEjqGG3XqnsyxvepwpOVzfXe0NTRL
         rzu6NtgPzWd9Zyxa+okBFDXizUqTqB0a8xTvLJupTAwjsrlFf49AYjBcFCUreq4TDdFO
         xnG4CpSmJxS3AU4e7bWtyPRah5uXiUmCBlWPsdZGVLY8EVvgRnJjTCics9HN6CIPwQAT
         bvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLOVEDpnix7Q9ugiGBHyM3tS+zJ6i1NVh4eILlSalmo=;
        b=lR9yHVtczMwFx+1UY+FdywdsS9Ms9vhyunXxmmgt8+M9KhNqpwyKaAYJuaT0tNf1yU
         cymqB5s74001tIzyH14oA5neRPf/iIVNNpaxRgeigBYFbkiC+KPbQ1pnDN1ZHCU3sEqm
         XN1OtLj/gDPb5dw8bR40A94C/LnhR3xrssMjTMfwzzm3l6lpgzlOkxZgKlxcvIwYlTTZ
         oz6UAW1sDH6JXbg/iLLz15FRlgdK72czryf3YE6//9klbXpPilMqTWsM3QbrbvtilXhH
         Yzb6neM6DWExEgj9hTaxMTYzEs3M+lk+Xo0ush8i0K6wL3lk9AD4KVli4mkcxHdIj4lh
         F53Q==
X-Gm-Message-State: AO0yUKUhntVCu1BjeHDW7pmjR1T1w1zY790TV3ld3i9QY0x9JJuBF/vs
        JTvr81x2cebffsHleyR0Ya0=
X-Google-Smtp-Source: AK7set+Q2vMsM/Jh0cxeUluxN1AN8NToldnYA4JRniB0hqAGupQIp/GfEcqzTuGxgbGlWnR4SYiOGA==
X-Received: by 2002:aa7:cb92:0:b0:4ab:49b9:686f with SMTP id r18-20020aa7cb92000000b004ab49b9686fmr202786edt.30.1676898879404;
        Mon, 20 Feb 2023 05:14:39 -0800 (PST)
Received: from gmail.com (1F2EF163.nat.pool.telekom.hu. [31.46.241.99])
        by smtp.gmail.com with ESMTPSA id m30-20020a50d7de000000b004acc61206cfsm1429253edj.33.2023.02.20.05.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 05:14:38 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 20 Feb 2023 14:14:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/build change for v6.3
Message-ID: <Y/NyOgU2AU5paKua@gmail.com>
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

Please pull the latest x86/build git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2023-02-20

   # HEAD: f9bb7f6a7eb0efd282f7364115f97e652677a29b x86/build: Make 64-bit defconfig the default

Make the 64-bit defconfig the x86 default for all builds,
unless x86-32 is requested explicitly.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      x86/build: Make 64-bit defconfig the default


 arch/x86/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
