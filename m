Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8F473E25D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjFZOnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFZOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:43:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A7B10C8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:43:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666ecf9a081so3140570b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687790623; x=1690382623;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLwVC7ihwJgCLNAPdbYZ1bRYjS7hN3YK9btRuGB162w=;
        b=OiF+mqIEDLR+vsRfE9GqbFFYC38vHP5P012nTnSj3OP2PidFhBwtflPE0+0txPNHmv
         LhnKSwTEMGSiV+A9BdWZ2tgdTmVjAF7Wr6K99AjtPjLcCBCsurGzM9Qzw6fdbFN+32hd
         GgzIm71SA9INcIBFB8pHtvzScCYKqm7Fwmz6H97CIMM6UlJZsPJM+8nnZZep+0yYF4Mn
         3eC5v6pUhKVptMWQd+jtB5r4MFz6vMNmOe2sDdeP6EZNegvTloNYDfYoo18as4K0MaER
         YstNBClDRhUT7pqrLtA8nwt2SH3iDD3AjL6NZQQYfAhKFTDG9FvKVpqM2vuSkWB06gKz
         BM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687790623; x=1690382623;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLwVC7ihwJgCLNAPdbYZ1bRYjS7hN3YK9btRuGB162w=;
        b=Tap6aeIhC0cWlLnGhE/JIfHRi8ZGX/zz9+/aiEuGF279LtCWBs/XvwO+kMeTWnQDQb
         tvWCGfYGTuO9c//GGY06+GLHgj1MDywpZPoWZisPlGDsgOaJRFMvvUSfwj6lx2kn173n
         oTsUaD5s1F6lNu6Rq51mPgpPNvDjVKz6nwGdtSWbP+cc6/lQozXgScBTIEEewgj/wMM7
         lU9qdW0L4SVDhuuBdsrMhQQwUgZr0OXH+8QvAxu5geFkSWaFyYaWoj2Z1eJYnyZ2BdW1
         51A/5jhBx1w9/tirVjzSflHNg8gQte5f4qPd4v1Fkr8un6ctdtFeqbgPctsnG7GhMgxu
         ms/w==
X-Gm-Message-State: AC+VfDyLt7esh11ZBR9+cNBCfYMN0B3WtFFjO7dsRxRsJfiarDDsGFnE
        4lTtpxPblRYIVlMcJO4siOocuQ==
X-Google-Smtp-Source: ACHHUZ7ozozA+9/vM7RpuhtbNja+Yppkp8D7Oz2+QNA1Rr+8637hn1QfzKDpsKeKamfqiVtfb83iAg==
X-Received: by 2002:a05:6a00:10d5:b0:666:e42c:d5fb with SMTP id d21-20020a056a0010d500b00666e42cd5fbmr32869624pfu.32.1687790622785;
        Mon, 26 Jun 2023 07:43:42 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id d6-20020aa78146000000b0066145d63b1asm3898769pfn.138.2023.06.26.07.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:43:42 -0700 (PDT)
Date:   Mon, 26 Jun 2023 07:43:42 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Jun 2023 07:43:04 PDT (-0700)
Subject:     Re: [PATCH V1 1/3] Revert "RISC-V: mark hibernation as nonportable"
In-Reply-To: <20230626-mousy-latter-ad8088de089f@wendy>
CC:     Conor Dooley <conor@kernel.org>, suagrfillet@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        mpe@ellerman.id.au, Arnd Bergmann <arnd@arndb.de>, rppt@kernel.org,
        samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        anup@brainfault.org, xianting.tian@linux.alibaba.com,
        anshuman.khandual@arm.com, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Message-ID: <mhng-f018e5e3-61f5-47ee-a2ae-95309bbdb208@palmer-ri-x1c9>
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

On Mon, 26 Jun 2023 06:34:43 PDT (-0700), Conor Dooley wrote:
> On Sun, Jun 25, 2023 at 03:36:06PM -0700, Palmer Dabbelt wrote:
>> On Sun, 25 Jun 2023 15:15:14 PDT (-0700), Conor Dooley wrote:
>> > On Sun, Jun 25, 2023 at 11:09:21PM +0800, Song Shuai wrote:
>> > > 在 2023/6/25 22:18, Conor Dooley 写道:
>> > > > On Sun, Jun 25, 2023 at 10:09:29PM +0800, Song Shuai wrote:
>> > > > > This reverts commit ed309ce522185583b163bd0c74f0d9f299fe1826.
>> > > > > > > With the commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages
>> > > for the
>> > > > > linear mapping") reverted, the MIN_MEMBLOCK_ADDR points the kernel
>> > > > > load address which was placed at a PMD boundary.
>> > > > > > And firmware always
>> > > > > correctly mark resident memory, or memory protected with PMP as
>> > > > > per the devicetree specification and/or the UEFI specification.
>> > > > > But this is not true? The versions of OpenSBI that you mention
>> > > in your
>> > > > cover letter do not do this.
>> > > > Please explain.
>> > > >
>> > > 
>> > > At this time, OpenSbi [v0.8,v1.3) and edk2(RiscVVirt) indeed don't obey the
>> > > DT/UEFI spec. This statement is excerpted from "Reserved memory for resident
>> > > firmware" part from the upcoming riscv/boot.rst. It isn't accurate for now.
>> > > How about deleting this one?
>> > 
>> > It is incorrect, so it will need to be removed, yes.
>> > Unfortunately writing a doc does not fix the existing implementations :(
>> > 
>> > > Actually with 3335068f8721 reverted, the change of MIN_MEMBLOCK_ADDR can
>> > > avoid the mapping of firmware memory, I will make it clear in the next
>> > > version.
>> > 
>> > To be honest, I'd like to see this revert as the final commit in a
>> > series that deals with the problem by actually reserving the regions,
>> > rather than a set of reverts that go back to how we were.
>> > I was hoping that someone who cares about hibernation support would be
>> > interested in working on that - *cough* starfive *cough*, although maybe
>> > they just fixed their OpenSBI and moved on.
>> > If there were no volunteers, my intention was to add a firmware erratum
>> > that would probe the SBI implementation & version IDs, and add a firmware
>> > erratum that'd parse the DT for the offending regions and reserve them.
>> 
>> Is there any actual use case for hibernation on these boards?  Maybe it's
>> simpler to just add a "reserved regions actually work" sort of property and
>> then have new firmware set it -- that way we can avoid sorting through all
>> the old stuff nobody cares about and just get on with fixing the stuff
>> people use.
>
> What is "old stuff nobody cares about"? The first version of OpenSBI with
> the fix shipped only the other day, so effectively all current stuff has
> this problem. Certainly everything shipping from vendors at the moment
> has the problem, and probably whatever downstream, custom versions of
> OpenSBI also have it.

Ya, so "old stuff" is everything -- but that's all already broken, so 
nothing we can do about it.  IIUC there's nothing shipping that 
functions correctly here, so it's just a matter of detecting everything 
before the bug.

> Also, the problem isn't just limited to hibernation apparently. I
> think it was mentioned in the cover letter that according to Rob,
> without being marked as no-map we could also see speculative access &
> potentially some of the memory debugging stuff walking these regions.

We've got a bunch of other problems around speculative accesses to these 
regions in M-mode, so we'll have to deal with it at some point anyway.

> I'm not sure how you'd intend communicating "reserved regions actually
> work", I figure you mean via DT?

Somewhere in DT.  I hadn't thought about it a ton, just adding some 
property that says "this doesn't have the bug" was roughly the idea.

> I don't really see the benefit of adding a property for those who are
> behaving, if we can detect the versions of the one relevant SBI
> implementation that are broken at runtime. DT hat on, even less so.
> Perhaps I am missing your point, and there's another angle (like trying
> to per firmware code)?

If it's easy to figure out which versions are broken that seems fine to 
me.  My worry was just that's hard to do (folks forking OpenSBI) and it 
might be easier to just 
