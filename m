Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0307691093
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBISpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBISpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:45:15 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9A44ED24
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:45:14 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id y19so3163235ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 10:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D9Vua8LHA9JDjb46CzlFrnWZQdagkljpU9vsHTc0DF8=;
        b=4Asl2/b/Hg5mXqTofzECxhuPfV/1ELQIDimYZFo5ccuAteJziSJW3pYDXsJDmq7Y+p
         lpDDHNBVBIsZjuYrhT/8CO7je+D0yRIjnKBMx7GuQ3Iwx4I+G+nLehVUbH0TEajH6s3U
         IGsZgyI4UYvCbVRF6nLgaIyeCV3hvJ8a2V3A2Vjy++cLtMJNGrdeWeSVfxiocHfTBnmv
         cOjTcm/RJ8fTXs6aU7mjTOA1KODjFpjh2yfJC5p0X/XOKH0yKrgYtdSeuIdVkI7TSyDb
         19CjtZZWizsZnlrnI2iIceIRDLtgL1q5rBjOWBiImMnlyVTMwktoAUn5RJDzF2BRDSRK
         /9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9Vua8LHA9JDjb46CzlFrnWZQdagkljpU9vsHTc0DF8=;
        b=Vb6FJEBCmumDToZpbfqvwUEQsgu+5hJ1O/Rty1fsdc3etSPZ72u8OqTdGmUtZ7PbXD
         auI+wHDVSs1IuEBs5mx5F9Ei4I/W4+p5BU1fdQ6EoP7nQsiMMtVwkK1l/KZhlkvzKt30
         4FthgiJ0nqhr7hkNGTpCCqE8445HmdU23F1hw3Txi54QNC3JNv6P9wSrj0iYCS02kaZs
         NYGCawKedJQgkesILte7OdpQdTqUTUSy7oqSiyq7ckvUIIHaZEGGW0Qy4TYMXHQCx+61
         32vp60dv2jdrKFGBrD8SfjxZa1XYN+I/rOAKBWRkh+038dq7gVK+xU53e8TlIyrqrw+A
         UUOA==
X-Gm-Message-State: AO0yUKVYYsn8SE9MnoWJ3qdd93YbSZSfOAeVeNBmmrQAmMwSK6TPdle8
        GZ8pQblUJQOQozuEYoo+X5o/6YBDixELtCPetWMIug==
X-Google-Smtp-Source: AK7set9BEO75w+/zGEdYth0f1dUrFoFb09CZjL4/pITzFZUZHnpCtKSQrnmioh62h4aT4HugkczFG9LjIBQvWztIKT8=
X-Received: by 2002:a2e:6f14:0:b0:293:125c:284f with SMTP id
 k20-20020a2e6f14000000b00293125c284fmr2100576ljc.148.1675968312327; Thu, 09
 Feb 2023 10:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20230206201455.1790329-1-evan@rivosinc.com> <20230206201455.1790329-7-evan@rivosinc.com>
 <Y+FwvI+xRg7zMhSx@sirena.org.uk>
In-Reply-To: <Y+FwvI+xRg7zMhSx@sirena.org.uk>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 9 Feb 2023 10:44:36 -0800
Message-ID: <CALs-HsvQiRm-guFMy-E4J+CTLoOMoxb=JiedbtFrdXwzz-oSoA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] selftests: Test the new RISC-V hwprobe interface
To:     Mark Brown <broonie@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 1:27 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Feb 06, 2023 at 12:14:55PM -0800, Evan Green wrote:
>
> > +int main(int argc, char **argv)
> > +{
>
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/libc.S
>
> > +.global _start
> > +_start:
> > +.option push
> > +.option norelax
> > +     la gp, __global_pointer$
> > +.option pop
> > +
> > +     la sp, stack
> > +
> > +     la t0, heap
> > +     la t1, brk
> > +     REG_S t0, 0(t1)
> > +
> > +     li a0, 0
> > +     li a1, 0
> > +
> > +     call main
>
> This looks like it's just a standard program entry but I don't speak
> RISC-V asm so I might be missing something.  If that's the case might it
> make sense to use nolibc here?

I think I can just remove this file entirely along with -nostdlib, and
just let the compiler add in this glue.
-Evan
