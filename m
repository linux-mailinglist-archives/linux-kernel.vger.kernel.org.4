Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC9C5FD204
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 02:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiJMA6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 20:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiJMA5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 20:57:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97752501B3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 17:54:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b5so245906pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaAw8BTKIG9tAkvSBMCqtaZ5r2kfs+zZaLIVuG2dZHs=;
        b=K5sLdtJ3zfb6xlKrXbKc4Bi1kqdHF43hnr6V3W1kqVMyK/WgPRCBSeIlssQNjqN38k
         Ykc4udoNp8uSOE/2DsXPfb+f1BA+/HPIguYMsF8Co2QilJ8sX+Zs2OPTXUugWsuP+SB8
         QsgR+kIHAxI2VEmakIzP/AiznOSXg8Qn7vOZQFgdoFkkEtQsu1TdjuQUn396zg4lMXCW
         iS/3uVvY/92R5fXUa0xNzCvxAkThEtj4Ym8l5nNMw1OqL5SwxpLx/MYxQ3HP0PoD/kP1
         64ZS/oSJw4wpL901h96XgpGpBwOzZ4KgclxuaEbjhyHSYucUTsvOMLDVVLZ3IzYb4PsA
         +k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaAw8BTKIG9tAkvSBMCqtaZ5r2kfs+zZaLIVuG2dZHs=;
        b=dWdeTEP4ZV+IRnlgsVMLlX0sPtGw6Daslpn8xek+qDgylexDExY6Q0SJEIVekwSlto
         L2jIMsuEvjz1tLNiJTIXgKS7uJMVzIfzXdycoXJJAnlaY+p8hLpbnH/jTQajtyh1w5HR
         FG6vqU8ooBT/UecVsJmt1iBAK9gHfL+KPHds3P89lH+kASXi+mM9E6/SqXkgT47Xz8kW
         6eFusV9z09KvgPFLWJEvbCuUDHVpuatZ/cKlEe7pw3Qf1/kCRUcnueSFk385lNvZG5lr
         KSredzXje7NTyW/o5zkbWH+DrB+Ew6oWXxAeNNrgxNM+3ubOl7vmq2uyh2gzXEbS+d3F
         VHLw==
X-Gm-Message-State: ACrzQf2E/XTdwqSsR4vZQzgdvsphLugJTxs6Wq/QwkBQPPbLUUBV9f0L
        ClLDy6ha+h0j2nDuxr4jJHrEevMYCWB8Qw==
X-Google-Smtp-Source: AMsMyM7nKTrKlu6DHO0ftSLXnDkfs48a/jbCu3T3jD0HgX/d2Iqg01mE3LcqY+w6ub9uQZPbiCF13Q==
X-Received: by 2002:a05:6a00:1f10:b0:562:b9e1:55e9 with SMTP id be16-20020a056a001f1000b00562b9e155e9mr31523510pfb.60.1665620510829;
        Wed, 12 Oct 2022 17:21:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709027b8900b0017f62877604sm11159190pll.66.2022.10.12.17.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 17:21:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Oct 2022 17:21:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ajd@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        cuigaosheng1@huawei.com, david@redhat.com, farosas@linux.ibm.com,
        geoff@infradead.org, gustavoars@kernel.org, haren@linux.ibm.com,
        hbathini@linux.ibm.com, joel@jms.id.au, lihuafei1@huawei.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, npiggin@gmail.com,
        pali@kernel.org, paul@paul-moore.com, rmclure@linux.ibm.com,
        ruscur@russell.cc, windhl@126.com,
        wsa+renesas@sang-engineering.com, ye.xingchen@zte.com.cn,
        yuanjilin@cdjrlc.com, zhengyongjun3@huawei.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
Message-ID: <20221013002148.GA535574@roeck-us.net>
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <20221012141827.GA2405914@roeck-us.net>
 <Y0biBtCUtc2mowbQ@zx2c4.com>
 <20221012164452.GA2990467@roeck-us.net>
 <Y0b3ZsTRHWG6jGK8@zx2c4.com>
 <20221012221615.GA364143@roeck-us.net>
 <87bkqgmvxl.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkqgmvxl.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 11:03:34AM +1100, Michael Ellerman wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> > On Wed, Oct 12, 2022 at 11:20:38AM -0600, Jason A. Donenfeld wrote:
> >> 
> >> I've also managed to not hit this bug a few times. When it triggers,
> >> after "kprobes: kprobe jump-optimization is enabled. All kprobes are
> >> optimized if possible.", there's a long hang - tens seconds before it
> >> continues. When it doesn't trigger, there's no hang at that point in the
> >> boot process.
> >> 
> >
> > I managed to bisect the problem. See below for results. Reverting the
> > offending patch fixes the problem for me.
> 
> Thanks.
> 
> This is probably down to me/us not testing with PREEMPT enabled enough.
> 
Not sure. My configuration has

CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set

Guenter

> cheers
> 
> > ---
> > # bad: [1440f576022887004f719883acb094e7e0dd4944] Merge tag 'mm-hotfixes-stable-2022-10-11' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > # good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
> > git bisect start 'HEAD' 'v6.0'
> > # good: [7171a8da00035e7913c3013ca5fb5beb5b8b22f0] Merge tag 'arm-dt-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> > git bisect good 7171a8da00035e7913c3013ca5fb5beb5b8b22f0
> > # good: [f01603979a4afaad7504a728918b678d572cda9e] Merge tag 'gpio-updates-for-v6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
> > git bisect good f01603979a4afaad7504a728918b678d572cda9e
> > # bad: [8aeab132e05fefc3a1a5277878629586bd7a3547] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> > git bisect bad 8aeab132e05fefc3a1a5277878629586bd7a3547
> > # bad: [493ffd6605b2d3d4dc7008ab927dba319f36671f] Merge tag 'ucount-rlimits-cleanups-for-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
> > git bisect bad 493ffd6605b2d3d4dc7008ab927dba319f36671f
> > # good: [0e470763d84dcad27284067647dfb4b1a94dfce0] Merge tag 'efi-next-for-v6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi
> > git bisect good 0e470763d84dcad27284067647dfb4b1a94dfce0
> > # bad: [110a58b9f91c66f743c01a2c217243d94c899c23] powerpc/boot: Explicitly disable usage of SPE instructions
> > git bisect bad 110a58b9f91c66f743c01a2c217243d94c899c23
> > # good: [fdfdcfd504933ed06eb6b4c9df21eede0e213c3e] powerpc/build: put sys_call_table in .data.rel.ro if RELOCATABLE
> > git bisect good fdfdcfd504933ed06eb6b4c9df21eede0e213c3e
> > # good: [c2e7a19827eec443a7cbe85e8d959052412d6dc3] powerpc: Use generic fallocate compatibility syscall
> > git bisect good c2e7a19827eec443a7cbe85e8d959052412d6dc3
> > # good: [56adbb7a8b6cc7fc9b940829c38494e53c9e57d1] powerpc/64/interrupt: Fix false warning in context tracking due to idle state
> > git bisect good 56adbb7a8b6cc7fc9b940829c38494e53c9e57d1
> > # bad: [754f611774e4b9357a944f5b703dd291c85161cf] powerpc/64: switch asm helpers from GOT to TOC relative addressing
> > git bisect bad 754f611774e4b9357a944f5b703dd291c85161cf
> > # bad: [f7bff6e7759b1abb59334f6448f9ef3172c4c04a] powerpc/64/interrupt: avoid BUG/WARN recursion in interrupt entry
> > git bisect bad f7bff6e7759b1abb59334f6448f9ef3172c4c04a
> > # bad: [e485f6c751e0a969327336c635ca602feea117f0] powerpc/64/interrupt: Fix return to masked context after hard-mask irq becomes pending
> > git bisect bad e485f6c751e0a969327336c635ca602feea117f0
> > # good: [799f7063c7645f9a751d17f5dfd73b952f962cd2] powerpc/64: mark irqs hard disabled in boot paca
> > git bisect good 799f7063c7645f9a751d17f5dfd73b952f962cd2
> > # first bad commit: [e485f6c751e0a969327336c635ca602feea117f0] powerpc/64/interrupt: Fix return to masked context after hard-mask irq becomes pending
