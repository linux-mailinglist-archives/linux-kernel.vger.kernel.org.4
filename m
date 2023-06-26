Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E7F73EC0C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjFZUs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFZUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:48:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5AC9E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:48:22 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e6541c98so3732828b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687812501; x=1690404501;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUPTOszK2L9RCrE5SeliLMIYDzSq6csnmoch3YF2q0Y=;
        b=kxQT1GBgAzYDw2egy8FFSNfu/DK7t7VCYNPVi1sUyLhtgkqmYuggpiomMVY30YwmQq
         pbt3hR0Z8puHg5J7WX/es6N5w6oRkSYMKfsDpHOO2p356yR+mCHidn/Q7CLWV2N0PJW3
         KoNydOqe8SUO9O/Rc+/ODMyJQ1of2JtSthgQ5aYR+m5oRhiptsCpChy8+dMSoETzTx9D
         BMMid2V7FrXpC03se4vf4Vc2dmrendNw3kZOWzEZkRrQotq3yyJp+KgI4DG1zeX8EoLV
         chHlZYotu1h9onpDU52TvrbogPa+ryTG70YI+ED1R/mYObKExMq7XcPZlTwMcjUGto8q
         cjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687812501; x=1690404501;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUPTOszK2L9RCrE5SeliLMIYDzSq6csnmoch3YF2q0Y=;
        b=OhH3K9BO9NtRIsdBgQmMvBcTjAYwsY6N3c9SjWLxy8Sue0v68ps7TSbPOAcE40aLmv
         IEtgAvBZl1PJ9r62d6mFIrXGjclSZ8Yf7O/TJQUhA0jn8O16ZdJDG0hbpQXfyiMvPwD1
         2gMnGHoICBu2T7tD1p9oAvInsS2dJS5/Op3541zZsIS+osezpAl2h2H5YqCakUh3AMuF
         ZdahhvFvBWvmr3MRqr+MbhVpemODdteVh+LopxK3A6S0FOznWgrf3uN2EHjh4zLrFRah
         abEgC7CGDs0CXpxt4or/KNv7JndY9TYwBZyM9/PyX4XHA258djqXC/8cfDiPUnCUqtGu
         yXxw==
X-Gm-Message-State: AC+VfDwK8M5oOwEAuesM6LdSOk9MCs+frDolbcBGY+nkCaXBYqGcesnS
        aZbpEe9l1xmee4wbRf4gaAOSLg==
X-Google-Smtp-Source: ACHHUZ6APq8gFSVMvW+cM54DA/ooh6HUyAsu9eSOu1JPULox1+qpHjnMZl2xusR6S+zbo5U8NDKllw==
X-Received: by 2002:a05:6a20:7495:b0:11f:33da:56ec with SMTP id p21-20020a056a20749500b0011f33da56ecmr34404579pzd.27.1687812501350;
        Mon, 26 Jun 2023 13:48:21 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id u4-20020a634544000000b0052c9d1533b6sm4536193pgk.56.2023.06.26.13.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:48:20 -0700 (PDT)
Date:   Mon, 26 Jun 2023 13:48:20 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Jun 2023 13:48:19 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
In-Reply-To: <20230626-nature-seventh-6102e17bb4be@spud>
CC:     Evan Green <evan@rivosinc.com>, aou@eecs.berkeley.edu,
        ajones@ventanamicro.com, apatel@ventanamicro.com,
        Conor Dooley <conor.dooley@microchip.com>,
        heiko.stuebner@vrull.eu, Paul Walmsley <paul.walmsley@sifive.com>,
        sunilvl@ventanamicro.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-7656ce4f-bdcb-419c-8a77-18ab7d301cd7@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 13:34:24 PDT (-0700), Conor Dooley wrote:
> On Mon, Jun 26, 2023 at 12:25:42PM -0700, Evan Green wrote:
>> On Fri, Jun 23, 2023 at 5:12 PM Conor Dooley <conor@kernel.org> wrote:
>> > On Fri, Jun 23, 2023 at 03:23:53PM -0700, Evan Green wrote:
>> > > In /proc/cpuinfo, most of the information we show for each processor is
>> > > specific to that hart: marchid, mvendorid, mimpid, processor, hart,
>> > > compatible, and the mmu size. But the ISA string gets filtered through a
>> > > lowest common denominator mask, so that if one CPU is missing an ISA
>> > > extension, no CPUs will show it.
>> > >
>> > > Now that we track the ISA extensions for each hart, let's report ISA
>> > > extension info accurately per-hart in /proc/cpuinfo.
>> >
>> > No, you can't do this as it breaks the assumptions of userspace that
>> > this shows the set supported across all harts.
>> > Sorry, but NAK.
>
>> My hope was that we were still early enough that no production systems
>> existed (yet) that actually had different ISA extensions in the set we
>> track, and therefore usermode would have been unable to make those
>> assumptions at this point. If such a system exists, and I don't know
>> if it does or not, then I agree it's too late to make a change like
>> this.
>
> You should put this information into your commit messages & not just
> hope that people understand your intent.
> Userspace does actually make these assumptions already, see for example
> this Google "cpu features" repo:
> https://github.com/google/cpu_features/tree/main
> To be quite honest, I really dislike the fragility of what they have
> implemented - with only one of the reasons being they made the mistake
> of assuming homogeneity.
>
> There's got to be a line somewhere for what constitutes buggy userspace
> and what's a regression. Up to Palmer I suppose as to what constitutes
> which.

Maybe let's just add a pretty printed version of the hwprobe info to 
/proc/cpuinfo, and then leave the ISA string alone as a legacy 
interface?

Having something so poorly defined as uABI is a bit embarassing, but 
it's our mistake so we've got to live with it.

>> I thought I'd put this out here and see if someone could point at such
>> a system; but if not it'd be great to keep /proc/cpuinfo accurate and
>> consistent with hwprobe (which does return accurate per-hart ISA
>> extension info).
>
> Just another nail in the coffin for a bad interface :)
> There are apparently some mixed c906 chips that support vector on one
> core and not the other - although it is thead vector which is not
> supported upstream yet...
>
> Other than that, SiFive stuff technically can be mixed - rv64imac &
> rv64imafdc on a bunch of the older stuff. I don't think anyone actually
> runs those sort of configurations on them though.
