Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E43739961
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjFVIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjFVIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:23:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2E6E2102;
        Thu, 22 Jun 2023 01:23:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18E791042;
        Thu, 22 Jun 2023 01:24:08 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67F413F663;
        Thu, 22 Jun 2023 01:23:22 -0700 (PDT)
Date:   Thu, 22 Jun 2023 09:23:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
        bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
Message-ID: <ZJQE9PIjxuA3Q8Sm@FVFF77S0Q05N>
References: <20230619100121.27534-1-puranjay12@gmail.com>
 <20230619100121.27534-4-puranjay12@gmail.com>
 <ZJMXqTffB22LSOkd@FVFF77S0Q05N>
 <CANk7y0h5ucxmMz4K8sGx7qogFyx6PRxYxmFtwTRO7=0Y=B4ugw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0h5ucxmMz4K8sGx7qogFyx6PRxYxmFtwTRO7=0Y=B4ugw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:57:20PM +0200, Puranjay Mohan wrote:
> On Wed, Jun 21, 2023 at 5:31 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Jun 19, 2023 at 10:01:21AM +0000, Puranjay Mohan wrote:
> > > @@ -1562,34 +1610,39 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> > >
> > >       /* 3. Extra pass to validate JITed code. */
> > >       if (validate_ctx(&ctx)) {
> > > -             bpf_jit_binary_free(header);
> > >               prog = orig_prog;
> > > -             goto out_off;
> > > +             goto out_free_hdr;
> > >       }
> > >
> > >       /* And we're done. */
> > >       if (bpf_jit_enable > 1)
> > >               bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
> > >
> > > -     bpf_flush_icache(header, ctx.image + ctx.idx);
> > > +     bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
> >
> > I think this is too early; we haven't copied the instructions into the
> > ro_header yet, so that still contains stale instructions.
> >
> > IIUC at the whole point of this is to pack multiple programs into shared ROX
> > pages, and so there can be an executable mapping of the RO page at this point,
> > and the CPU can fetch stale instructions throught that.
> >
> > Note that *regardless* of whether there is an executeable mapping at this point
> > (and even if no executable mapping exists until after the copy), we at least
> > need a data cache clean to the PoU *after* the copy (so fetches don't get a
> > stale value from the PoU), and the I-cache maintenance has to happeon the VA
> > the instrutions will be executed from (or VIPT I-caches can still contain stale
> > instructions).
> 
> Thanks for catching this, It is a big miss from my side.
> 
> I was able to reproduce the boot issue in the other thread on my
> raspberry pi. I think it is connected to the
> wrong I-cache handling done by me.
> 
> As you rightly pointed out: We need to do bpf_flush_icache() after
> copying the instructions to the ro_header or the CPU can run
> incorrect instructions.
> 
> When I move the call to bpf_flush_icache() after
> bpf_jit_binary_pack_finalize() (this does the copy to ro_header), the
> boot issue
> is fixed. Would this change be enough to make this work or I would
> need to do more with the data cache as well to catch other
> edge cases?

AFAICT, bpf_flush_icache() calls flush_icache_range(). Despite its name,
flush_icache_range() has d-cache maintenance, i-cache maintenance, and context
synchronization (i.e. it does everything necessary).

As long as you call that with the VAs the code will be executed from, that
should be sufficient, and you don't need to do any other work.

Thanks,
Mark.
