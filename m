Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B697E6A922E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCCIJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCCIJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:09:44 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853A3199C7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:09:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i34so7016136eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 00:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4WTQThSIoEF32Ub6V9v7GmyYwnBKD53cEBEBaSt0zA=;
        b=aLyqdRMRrcIS85q9Lkp1ABFAZjgqHcOjlxjeGn78DOMaYXW4uRTyPL7zSxRKp2jFcN
         ietx/isVIl1uXoAV0vcUi2WKOsjrrTd6NmctLBo6TIpfkQHMisuJJOOAWzqL+anMxcIv
         iK9cFveXfloQbDQ6LmaoyCmn8LYC4OJzwxm6cnc/g2pSJaNYHGmsAadKQbqTA6oo8oLO
         bsBaM9w91pp0a6weRqls7td2/w0Wgmz1DxlQByIaxe3h2YEEDEFQCkvb5KmHi2UpFcgr
         Yf8gqW6PhPafK1CsT5o0AytD+su6h+kiK5vBzsL2eXwjlUeNU7sD7u8pFyVpPBwObTk2
         xiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4WTQThSIoEF32Ub6V9v7GmyYwnBKD53cEBEBaSt0zA=;
        b=U0ZfFKbVjri8oIMe6I3BRILCXDELrYeeQMvoPAFS9wZaM3vw7cVu2Np2+24TM8izOh
         p19Fh2h42IedFEmNj/UNBGQUt84UvT6h0A9zuiTrNS3n0xLX+m6Y1IhExRqqwIlYoODo
         JDpd+PrfJ3Zn5IEbT28pgYYOGcu3mTlOYKlq/dLMXJ4NYMcb1TE2iqKIHmdQFn61uj7R
         C2BcW9p/mj/lHPI1Z7en7iAXrM7lCwXJxdD4m3p0PN5Xqo25fZhpfYkKM18I7Dbirhn7
         xD2SP44SGDzYC6eNglS5wiWfH5fRXzSdmKiKKp5gJdjtLNtWdcKvNKVSHx9/kKrRQ/k3
         jz9w==
X-Gm-Message-State: AO0yUKXt3LPRDql4Z8F6GFSUhm80l6rUYevw6665rs4+FGsipOv5yG2/
        H9v+2UEF7mX+l4wamz37VZnDzIuHCX5oExh1
X-Google-Smtp-Source: AK7set/BTmesy88YX7WAMMNmgTPuqjNLvzlzo5tDl9IBAMPW4ZDcel3r6DO6t1dq4qeXaUAuHvqecQ==
X-Received: by 2002:a05:6402:1253:b0:4ad:738a:a5db with SMTP id l19-20020a056402125300b004ad738aa5dbmr1216384edw.0.1677830957038;
        Fri, 03 Mar 2023 00:09:17 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id m27-20020a170906599b00b008dea022f5e6sm679897ejs.24.2023.03.03.00.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 00:09:16 -0800 (PST)
Date:   Fri, 3 Mar 2023 09:09:10 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <20230303080910.hfipcsrgyvppa6ex@orel>
References: <20230227075942.rgl4hqnwttwvoroe@orel>
 <178ca008701147828d2e62402ff4f78a@EXMBX066.cuchost.com>
 <20230227114435.eow57ax5zhysz3kv@orel>
 <a6c319dd867f4f1d97e9d950b9e7c636@EXMBX066.cuchost.com>
 <20230228050457.zfbflfawctaccepv@orel>
 <803ac603023c4eeda4a0b8e414cce6f1@EXMBX066.cuchost.com>
 <20230228071845.k6s6bcnesdsnw3jl@orel>
 <abd16b950ca744b081fc9f545977b8fa@EXMBX066.cuchost.com>
 <20230228073725.m5t6rkcbgbi3g26z@orel>
 <94325d78a0b74d8289b77ec743840941@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94325d78a0b74d8289b77ec743840941@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 01:53:19AM +0000, JeeHeng Sia wrote:
> Hi Andrew,
> 
> 
> > -----Original Message-----
> > From: Andrew Jones <ajones@ventanamicro.com>
...
> > I'm not sure why you don't just write a paragraph or two here in this
> > email thread explaining what "the answer" is. Anyway, feel free to
> > invite me to a call if you think it'd be easier to hash out that way.
> Thank you very much to free up time to join the call. It was very nice to talk to you over the conference call and I did learn a lot from you.
> Below is the summary of the experiment that benefit everyone:
> To avoid inspecting a huge log, the experiment was carried out on the Qemu with 512MB of memory (128000 pages). 
> During hibernation, there are 22770 pages (out of 128000 pages) were identified need to be stored to the disk. Those pages consists of the kernel text code, rodata, page table, stack/heap/kmalloc/vmalloc memory, user space app, rootfs.....etc. The number of pages need to be stored to the disk are depends on the "workload" on the system.
> When resume, only 21651 pages were assigned to the restore_pblist. The rest of the pages consists of meta_data pages and forbidden pages which were handled by the "resume kernel". Arch code will handle the pages assigned to the restore_pblist.
> From the experiment, we also know that the game that is activated before hibernation is still "alive" after resume from hibernation and can continue to play without problem.
>

Thank you, Jee Heng. Indeed it looks like the majority of the pages that
are selected for the suspend image end up on the PBE list. While we don't
have definitive "this page must be on the PBE list" type of result, I
agree that we shouldn't need to worry about the PBE list ever being empty.

Thanks,
drew
