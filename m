Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52270B155
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjEUV5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 17:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjEUV5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 17:57:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965DDB
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 14:57:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae50da739dso34483315ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684706233; x=1687298233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lcnVnxDvif0ZfkyQkkgd2zU4HMJfXMdHIx335Lxz+H8=;
        b=zrtjPUo834/13md+sL+66/JcVnmbMw9vwrfF7JI5+764einZmY0OY+4gdhmPny4ST/
         HbkML21Xd0/CY+2TqZVpecEGMLZr4QlOVvgeOHVIOeMLLX/9gRjZegTVQisUGjg41XKP
         9q6kCBPEc7CbivmQxA2naeMDjil/VtDNmtqb1U4+1IsfsKQiGH4XmaSo3GdBoXKTV6+C
         31SxTfi8b53orphsztr6spUf2RbBPJqf7cHRDlsI0aoVxP442aVyNVUAGEXXVS+IgjIx
         Vk8Q5q9TG3fSQStZaGM+ldMQpVYiQgMlDTHCbBNUw6lcCcqgO+W8gqbb55/3JjEtdors
         /HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684706233; x=1687298233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcnVnxDvif0ZfkyQkkgd2zU4HMJfXMdHIx335Lxz+H8=;
        b=FuKl3xYsXPKYRB0UGIMkQQ/zuiTGgiB5uvliE1RRvc5E4glf2PH0Ce/2ssBt6lv8q1
         dgccd2FnkPqMCm5uF3H55sH84U7SULTUgNfmUL3NWR152BQK2MRfk+AxsCSK91wIru/Y
         NjauXTRoh4ULolck12AVYDqRCti98TOd8vknAjUobLdggrk9w5tIX7cBmUICjYo8drBm
         LS2r14PlMJuyM9Shuhq2tM7LjwmXb2GvGirvBFukWcanajEscG65HQzMs4wB/g2zJKh6
         o1D6sHjC2WD7SqroDGEMjFwL5kqsMvkshaV5RszritXlHtC7aowW/taGeZESOKe6k8KW
         1onA==
X-Gm-Message-State: AC+VfDwLNEvPg63HhwnzCoF1Mak4J9j7FjYHjKJNWLB6Jwf+KPgA0JPn
        I0lqcJxaJcFfef5SOHlqGwcQhw==
X-Google-Smtp-Source: ACHHUZ5W8aWE6eRHEmfCisBZ6pvyYucjXedqi6mQQ/3ryc3KvpLVD1LA0wy8ok/0oPuyz5Pc7Qmqxg==
X-Received: by 2002:a17:903:2310:b0:1aa:f53a:5e47 with SMTP id d16-20020a170903231000b001aaf53a5e47mr11864710plh.16.1684706232828;
        Sun, 21 May 2023 14:57:12 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:9483:9e6b:e3e5:203])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b001a94a497b50sm3382147plr.20.2023.05.21.14.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 14:57:12 -0700 (PDT)
Date:   Sun, 21 May 2023 15:01:11 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: riscv: boot failure for 3335068f8721 ("riscv: Use PUD/P4D/PGD
 pages for the linear mapping")
Message-ID: <ZGqUpwJOiiLnKMkg@x1>
References: <ZGl8gn/rD8WZ0nak@x1>
 <51339689-b92f-52fb-9202-2b91733f9180@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51339689-b92f-52fb-9202-2b91733f9180@sholland.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 10:22:36PM -0500, Samuel Holland wrote:
> Hi Drew,
> 
> On 5/20/23 21:05, Drew Fustini wrote:
> > Hello, I tested 6.4-rc1 on an internal RISC-V SoC and observed a boot
> > failure on a Store/AMO access fault (exception code 7) in __memset().
> > stval (e.g. badaddr) was set to 0xffffaf8000000000. This SoC is RV64GC
> > with Sv48 so it seems that address is the start of the "direct mapping
> > of all physical memory" [1].
> > 
> > The 6.3 release boots okay and the system is able to operate correctly
> > with an Ubuntu 23.04 rootfs on eMMC. Therefore, I decided to bisect and
> > I found the failure begins with 3335068f8721 ("riscv: Use PUD/P4D/PGD
> > pages for the linear mapping"). The system boots okay with the prior
> > commit 8589e346bbb6 ("riscv: Move the linear mapping creation in its
> > own function").
> > 
> > The boot log [2] shows that the fault happens right after buildroot's
> > init script [3] uses switch_root to execute init from the Ubuntu rootfs
> > on the eMMC.
> > 
> > DWARF4 is enabled in .config [4] and the decoded stack trace [5] shows:
> > 
> >   epc : __memset (/eng/dfustini/gitlab/linux/arch/riscv/lib/memset.S:67)
> > 
> > From memset.S:
> > 
> >  Line 67:         REG_S a1,        0(t0)
> > 
> > From the oops:
> > 
> >  epc : ffffffff81122d6c ra : ffffffff80218504 sp : ffffaf8002e47500
> >   gp : ffffffff82695010 tp : ffffaf8002e2ec00 t0 : ffffaf8000000000
> >   t1 : 0000000000000080 t2 : 0000000000000001 s0 : ffffaf8002e47550
> >   s1 : ffff8d8200000040 a0 : ffffaf8000000000 a1 : 0000000000000000
> > 
> > Thus I think it is trying to store 0x0 to 0xffffaf8000000000 which is
> > the start of the direct map. From the boot log [2], OpenSBI shows:
> > 
> >  Domain0 Region00 : 0x0000000002080000-0x00000000020bffff M: (I,R,W) S/U: ()
> >  Domain0 Region01 : 0x0000008000000000-0x000000800003ffff M: (R,W,X) S/U: ()
> >  Domain0 Region02 : 0x0000000002000000-0x000000000207ffff M: (I,R,W) S/U: ()
> >  Domain0 Region03 : 0x0000000000000000-0xffffffffffffffff M: (R,W,X) S/U: (R,W,X)
> > 
> > The DDR memory on this SoC starts at 0x8000000000 with size 2GB. The
> > memory node from the device tree [6]:
> > 
> >         memory@8000000000 {
> >                 device_type = "memory";
> >                 reg = <0x80 0 0x00000000 0x80000000>;
> >         };
> > 
> > I think the direct map address 0xffffaf8000000000 would map to physical
> > address 0x8000000000. Thus I think the attempted store in S-mode to that
> > address would violate the PMP settings for Region01.
> > 
> > I do not yet understand why this happens with 3335068f8721 ("riscv: Use
> > PUD/P4D/PGD pages for the linear mapping") but not for the prior commit
> > 8589e346bbb6 ("riscv: Move the linear mapping creation in its own
> > function").
> 
> Where does Linux's DTB come from? It should be the one that was modified
> by OpenSBI to add a reserved-memory node matching PMP Region01
> (fdt_reserved_memory_fixup()).
> 
> Before this commit, Linux ignored the first 2 MiB of physical RAM. So if
> OpenSBI was loaded in this region, you could get away with ignoring the
> firmware-provided DTB; now you actually need to use it, as intended.

The address of the dtb is passed by the boot code to OpenSBI. I had been
using OpenSBI master from Jan 9: 001106d ("docs: Update domain's region
permissions and requirements"). The kernel receives the device tree from
OpenSBI but I had never actually dumped it from sysfs.

I checked out the prior kernel commit 8589e346bbb6 ("riscv: Move the
linear mapping creation in its own function") and ran "dtc -I fs
/sys/firmware/devicetree/base/" to dump the device tree [1]. This showed
that the reserved-memory node was blank.

Jessica pointed out to me on #riscv irc that this was fixed in OpenSBI
on Jan 21 with: a990309 ("lib: utils: Fix reserved memory node for
firmware memory"). Therefore, I updated to the current OpenSBI master:
33f1722 ("lib: sbi: Document sbi_ecall_extension members") from May 15.
The device tree that OpenSBI passes to the kernel now has
"mmode_resv0@80,0" and "mmode_resv1@80,20000".

Furthermore, my system now boots okay with 3335068f8721 ("riscv: Use
PUD/P4D/PGD pages for the linear mapping") so the problem was just that
I had been using an OpenSBI that was slightly too old.

Thanks,
Drew

[1] https://gist.github.com/pdp7/71ca465997274e11953b26861e36144f
[2] https://gist.github.com/pdp7/90b4632146fc55625735fa288d80532b
