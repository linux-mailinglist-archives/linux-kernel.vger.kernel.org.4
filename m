Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA61C6963D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjBNMr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjBNMrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:47:19 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD9322A33;
        Tue, 14 Feb 2023 04:47:18 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id o8so14564117pls.11;
        Tue, 14 Feb 2023 04:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//PUD5f7GplM89519c0hmn3dKQI620mHmk1UnlP9FPs=;
        b=XNPocGj7eiVthaKGOlegbMgkhofmsHsGcNdlNwjpQdYwAny3M5QEpXJe0VmLiF6xxr
         /rXwTQZkegRR11PvKJL3YEULFvw+FtKn3U4QtH9lGtG50xveeknTG2ZbxXqm3p4icUWo
         Tb3ApuzTX+rBRTCJTUIlAuPNNjlLQhkwLwiExWPwX4E9QX0822kRSzwimJPPUCS+oUrK
         hHgE7W0ChecHAsJYcyX/wAY4y+F5w8me7BbUw8tIDJqjj83BeWfp48J5HOLzoUL2RRjI
         WkgLqIqDw7b2/ZDO9q+xBrbmrUY7gZZ90kwKcRSdbgbIUYy2olrnv8r7g1Tg0mVTRlqB
         JBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//PUD5f7GplM89519c0hmn3dKQI620mHmk1UnlP9FPs=;
        b=uqAij0xq1+Ga2tYb/wYujbdiKaIsawCnqdzHiHeWdh2KPPZRuJwrcsLKzotO4VLAPN
         /Dm03brzAZuJWiq1k29QDPz6VLNQmgkEA8z8Hus2PbbDMT14MSMoD51c0KjarVbeO40Q
         O1h+bnBdQGsRiBzJnUvXLqnJuh5c3Vlv9NfsZPRFfbxyJFzGUOf5wGpeI26FV4GkB1ix
         CVfQn3RqR5uEChOYVauWcF8sHIJWi3gZM/aanQw6mVSqjSRkVmLnJ62l+H4CGks8Oy8q
         FjZ3yxd144KLTiipZSQH971e+L3K+l5dyCK32Au3Y6xY+472nMWXar4bBlkeYqU3va9S
         Db9w==
X-Gm-Message-State: AO0yUKV85qjPCq2J8w3Hl92N/tg5Oo1H8SXM4pkli+FFcOcCoyg0+ZAO
        KYc8omRdoqGihyoeJLfx1oWsWB9oSLWZOIXqxYY=
X-Google-Smtp-Source: AK7set+2pnH1CKd+RN83wqleMusbpFy3FlkYCo/TdXhpVa1RoyC5/XuwIYKjr9SCKABLrHl8FZUY+III+SgNUgOF72M=
X-Received: by 2002:a17:90a:ac18:b0:233:c5e8:7213 with SMTP id
 o24-20020a17090aac1800b00233c5e87213mr2422754pjq.93.1676378838445; Tue, 14
 Feb 2023 04:47:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676358308.git.jpoimboe@kernel.org> <ad801544cab7c26a0f3bbf7cfefb67303f4cd866.1676358308.git.jpoimboe@kernel.org>
In-Reply-To: <ad801544cab7c26a0f3bbf7cfefb67303f4cd866.1676358308.git.jpoimboe@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 14 Feb 2023 04:47:06 -0800
Message-ID: <CAMo8BfJsxu0Q1a0KOq2giBCESZE-Y10nqTOT43XQje0FtM7ixQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/24] xtensa/cpu: Mark cpu_die() __noreturn
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, linux-xtensa@linux-xtensa.org,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:07 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> cpu_die() doesn't return.  Annotate it as such.  By extension this also
> makes arch_cpu_idle_dead() noreturn.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/xtensa/include/asm/smp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
