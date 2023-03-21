Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F386C29CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCUFYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCUFXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A86A83E1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 22:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57B546195D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053CBC433EF;
        Tue, 21 Mar 2023 05:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679376223;
        bh=Bl81czR/G5Q+BkeayvN9xxkRrRyrsFU1ZSuvHOhqwQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BN7PvaXa0kQp7q2Gn8SHGMdVBXvE4b1ebmaS4QKWTY2XoRi67FMH2Oqncj+PvxD2Y
         +NLvl7jDzt9ujOudoXqJWaqxYnElvpAozEnFGm0Y+SCZN3V432Vx2nyMJIAlnNWwRn
         lQ4ZHYwFO6s2I8JKuuk2WmbSVR/ybh5of61jFbI8j+WLTphZS/bIvyY+63utqqWFf2
         LBTRlhZRg3X2fZ0fxT3MBdLOp0hewP0V3npz8uCA1pX43yw8RHyDqVgXVD8X50XG0t
         zAmmrCAlkNlzlFqA0nvcQtgfvSpw2p5KFRjrhVp71G3wTbPmM9N0aQtWdf4h6xusVL
         CrDS6ptuQZSAQ==
Date:   Mon, 20 Mar 2023 22:23:41 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ndesaulniers@google.com,
        trix@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] x86: Avoid relocation information in final vmlinux
Message-ID: <20230321052341.GA1536736@dev-arch.thelio-3990X>
References: <20230320121006.4863-1-petr.pavlu@suse.com>
 <e8a36925-2965-1dae-da01-5d06ba6747c8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8a36925-2965-1dae-da01-5d06ba6747c8@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:12:07PM -0700, Dave Hansen wrote:
> On 3/20/23 05:10, Petr Pavlu wrote:
> > The issue is then that the collected vmlinux file and hence distribution
> > packages end up unnecessarily large because of this extra data. The
> > following is a size comparison of vmlinux v6.0 with and without the
> > relocation information:
> > | Configuration      | With relocs | Stripped relocs |
> > | x86_64_defconfig   |       70 MB |           43 MB |
> > | +CONFIG_DEBUG_INFO |      818 MB |          367 MB |
> > 
> > Optimize a resulting vmlinux by adding a postlink step that splits the
> > relocation information into vmlinux.relocs and then strips it from the
> > vmlinux binary.
> 
> When I saw that this adds a postlink step, I read that as, "adds another
> step to the unbearably slow single-threaded part of kernel builds". :)
> 
> But, here's one data point that made me feel a lot better.  Using a
> random .config:
> 
> > https://sr71.net/~dave/intel/config-reloctest
> 
> the builds get a _bit_ slower, going from 37.0s->37.7s.  This is pretty
> arbitrary of course, using my compiler on my hardware, so YMMV.  But,
> for me, this seems like a reasonable tradeoff given the space savings.
> 
> I'd be curious what other people are seeing.

I am seeing a negligible difference (~1%) with LLVM 16 when targeting
the following configuration combinations and building the 'bzImage'
target.

* allmodconfig:

Benchmark 1: v6.3-rc3
  Time (mean ± σ):     93.370 s ±  0.313 s    [User: 3462.570 s, System: 371.420 s]
  Range (min … max):   92.993 s … 93.659 s    5 runs

Benchmark 2: v6.3-rc3 + "x86: Avoid relocation information in final vmlinux"
  Time (mean ± σ):     93.539 s ±  0.193 s    [User: 3464.361 s, System: 370.709 s]
  Range (min … max):   93.281 s … 93.816 s    5 runs

Summary
  'v6.3-rc3' ran
    1.00 ± 0.00 times faster than 'v6.3-rc3 + "x86: Avoid relocation information in final vmlinux"'

* allmodconfig + debug info (DWARF5):

Benchmark 1: v6.3-rc3
  Time (mean ± σ):     97.952 s ±  0.451 s    [User: 3673.380 s, System: 378.814 s]
  Range (min … max):   97.420 s … 98.568 s    5 runs

Benchmark 2: v6.3-rc3 + "x86: Avoid relocation information in final vmlinux"
  Time (mean ± σ):     98.302 s ±  1.050 s    [User: 3674.310 s, System: 378.323 s]
  Range (min … max):   97.603 s … 100.152 s    5 runs

Summary
  'v6.3-rc3' ran
    1.00 ± 0.01 times faster than 'v6.3-rc3 + "x86: Avoid relocation information in final vmlinux"'

* allyesconfig bzImage:

Benchmark 1: v6.3-rc3
  Time (mean ± σ):     674.232 s ±  1.581 s    [User: 24901.883 s, System: 2223.728 s]
  Range (min … max):   672.478 s … 676.678 s    5 runs

Benchmark 2: v6.3-rc3 + "x86: Avoid relocation information in final vmlinux"
  Time (mean ± σ):     679.783 s ±  2.454 s    [User: 24903.720 s, System: 2228.943 s]
  Range (min … max):   676.369 s … 682.772 s    5 runs

Summary
  'v6.3-rc3' ran
    1.01 ± 0.00 times faster than 'v6.3-rc3 + "x86: Avoid relocation information in final vmlinux"'

* allyesconfig + debug info (DWARF5):

Benchmark 1: v6.3-rc3
  Time (mean ± σ):     709.745 s ±  1.880 s    [User: 26570.531 s, System: 2304.563 s]
  Range (min … max):   707.918 s … 712.818 s    5 runs

Benchmark 2: v6.3-rc3 + "x86: Avoid relocation information in final vmlinux"
  Time (mean ± σ):     711.773 s ±  1.152 s    [User: 26571.973 s, System: 2307.176 s]
  Range (min … max):   710.127 s … 713.224 s    5 runs

Summary
  'v6.3-rc3' ran
    1.00 ± 0.00 times faster than 'v6.3-rc3 + "x86: Avoid relocation information in final vmlinux"'

Cheers,
Nathan
