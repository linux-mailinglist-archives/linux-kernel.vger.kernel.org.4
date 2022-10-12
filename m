Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4F55FCE3F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJLWQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJLWQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:16:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E690A347C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:16:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fw14so287715pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcceU1SnNN9WxmhwpR7jvQXVmAOSHo4vqoVYcRh7uxw=;
        b=fLycqik2otARDGrY7ih6Yzrcy1ZkzLpukZGdimqpg7HXtPlwvps2fsMM7aJpnWWbgL
         QHTzrLraj5yOol98GgPCuaotebw1SEtOGQekbJUdOk7oX+ZlqplD4Fn0pRWHxQp10Iua
         CZLum6W2MO52qsYRh27dyKyEWVi29LRLascob1c1rw1dPGhMmNMAmnrGT2iLDmTRDv7B
         nfPKdCiJgb/dKM3jtS/9UD7+C+1YPSmnF7hfAFq2Kz/3li+rjiTqa9yF1Rbioq3uxU7n
         5xzlHjV9h+IFTHaIgOOmr9u4laDdV4d7cIHw07dS69TznGWkhjs4AlzpsF4eRmz4VFu1
         GBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcceU1SnNN9WxmhwpR7jvQXVmAOSHo4vqoVYcRh7uxw=;
        b=Vb3PPly/Xto41fN9GCK4IuQDYke4hRg2gQx0Q+A6zHxsVY/KY+MGPXIGXhDE7XCWth
         yK5inkNe8VhpaHgvt2B9XWW2VCBhVn/lJGbUk30/ELadkLBZA+/mdScw4GbxT2EloROa
         lj+qktiQHJTBgjvXsXiGSyhfbEiDe9ucBBZqgFCQJrU/ETHqJGv3iaxeJhK2iCoKdPb8
         mInK4WOOP0EseG5XRu9H504YeHVZEhb5xNr3yeiK/yFg3X2LllRnX7Im73O8JtPfttoM
         Flx3KmmfdskFQOxQbULOucKgC28uJz8eOKhiMEaWV4gWI0caHiKbYSdRcbBO+WdeH2Ru
         SJiw==
X-Gm-Message-State: ACrzQf3OY0gskHzFapukCLknQmxsEX9hedRntGQBoA85KILCs10q/Ydl
        JYcuRaeP9ATOUBkUbpx5+4k=
X-Google-Smtp-Source: AMsMyM6knrPCf9i6xOjmT2d6ZYKOxZ2Z1YUJG9HY0HExIw9QBlOBL9EqtFdYRkz7mR31+TeJCESQKQ==
X-Received: by 2002:a17:90a:4983:b0:20a:9509:8347 with SMTP id d3-20020a17090a498300b0020a95098347mr7456134pjh.101.1665612977610;
        Wed, 12 Oct 2022 15:16:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b001766a3b2a26sm11243466plh.105.2022.10.12.15.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:16:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Oct 2022 15:16:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
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
Message-ID: <20221012221615.GA364143@roeck-us.net>
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <20221012141827.GA2405914@roeck-us.net>
 <Y0biBtCUtc2mowbQ@zx2c4.com>
 <20221012164452.GA2990467@roeck-us.net>
 <Y0b3ZsTRHWG6jGK8@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0b3ZsTRHWG6jGK8@zx2c4.com>
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

On Wed, Oct 12, 2022 at 11:20:38AM -0600, Jason A. Donenfeld wrote:
> 
> I've also managed to not hit this bug a few times. When it triggers,
> after "kprobes: kprobe jump-optimization is enabled. All kprobes are
> optimized if possible.", there's a long hang - tens seconds before it
> continues. When it doesn't trigger, there's no hang at that point in the
> boot process.
> 

I managed to bisect the problem. See below for results. Reverting the
offending patch fixes the problem for me.

Guenter

---
# bad: [1440f576022887004f719883acb094e7e0dd4944] Merge tag 'mm-hotfixes-stable-2022-10-11' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
# good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
git bisect start 'HEAD' 'v6.0'
# good: [7171a8da00035e7913c3013ca5fb5beb5b8b22f0] Merge tag 'arm-dt-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 7171a8da00035e7913c3013ca5fb5beb5b8b22f0
# good: [f01603979a4afaad7504a728918b678d572cda9e] Merge tag 'gpio-updates-for-v6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect good f01603979a4afaad7504a728918b678d572cda9e
# bad: [8aeab132e05fefc3a1a5277878629586bd7a3547] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
git bisect bad 8aeab132e05fefc3a1a5277878629586bd7a3547
# bad: [493ffd6605b2d3d4dc7008ab927dba319f36671f] Merge tag 'ucount-rlimits-cleanups-for-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
git bisect bad 493ffd6605b2d3d4dc7008ab927dba319f36671f
# good: [0e470763d84dcad27284067647dfb4b1a94dfce0] Merge tag 'efi-next-for-v6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi
git bisect good 0e470763d84dcad27284067647dfb4b1a94dfce0
# bad: [110a58b9f91c66f743c01a2c217243d94c899c23] powerpc/boot: Explicitly disable usage of SPE instructions
git bisect bad 110a58b9f91c66f743c01a2c217243d94c899c23
# good: [fdfdcfd504933ed06eb6b4c9df21eede0e213c3e] powerpc/build: put sys_call_table in .data.rel.ro if RELOCATABLE
git bisect good fdfdcfd504933ed06eb6b4c9df21eede0e213c3e
# good: [c2e7a19827eec443a7cbe85e8d959052412d6dc3] powerpc: Use generic fallocate compatibility syscall
git bisect good c2e7a19827eec443a7cbe85e8d959052412d6dc3
# good: [56adbb7a8b6cc7fc9b940829c38494e53c9e57d1] powerpc/64/interrupt: Fix false warning in context tracking due to idle state
git bisect good 56adbb7a8b6cc7fc9b940829c38494e53c9e57d1
# bad: [754f611774e4b9357a944f5b703dd291c85161cf] powerpc/64: switch asm helpers from GOT to TOC relative addressing
git bisect bad 754f611774e4b9357a944f5b703dd291c85161cf
# bad: [f7bff6e7759b1abb59334f6448f9ef3172c4c04a] powerpc/64/interrupt: avoid BUG/WARN recursion in interrupt entry
git bisect bad f7bff6e7759b1abb59334f6448f9ef3172c4c04a
# bad: [e485f6c751e0a969327336c635ca602feea117f0] powerpc/64/interrupt: Fix return to masked context after hard-mask irq becomes pending
git bisect bad e485f6c751e0a969327336c635ca602feea117f0
# good: [799f7063c7645f9a751d17f5dfd73b952f962cd2] powerpc/64: mark irqs hard disabled in boot paca
git bisect good 799f7063c7645f9a751d17f5dfd73b952f962cd2
# first bad commit: [e485f6c751e0a969327336c635ca602feea117f0] powerpc/64/interrupt: Fix return to masked context after hard-mask irq becomes pending
