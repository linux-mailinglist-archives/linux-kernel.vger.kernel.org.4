Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44F368B8B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBFJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjBFJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:28:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D92071BD2;
        Mon,  6 Feb 2023 01:28:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF661113E;
        Mon,  6 Feb 2023 01:28:56 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.91.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B6293F71E;
        Mon,  6 Feb 2023 01:28:11 -0800 (PST)
Date:   Mon, 6 Feb 2023 09:28:09 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, rostedt@goodmis.org, will@kernel.org,
        "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [PATCH v3 1/8] ftrace: Add DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <Y+DIKQvfYE15QL3F@FVFF77S0Q05N>
References: <20230123134603.1064407-1-mark.rutland@arm.com>
 <20230123134603.1064407-2-mark.rutland@arm.com>
 <f2f5dfc6-3deb-9fce-a9be-9386e844a9cf@huawei.com>
 <Y9ebIY/pWz0Ms9S6@FVFF77S0Q05N>
 <60ec7607-7c5c-1a6e-18c9-8025cb2f289f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60ec7607-7c5c-1a6e-18c9-8025cb2f289f@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 09:25:51AM +0800, Wangshaobo (bobo) wrote:
> 在 2023/1/30 18:25, Mark Rutland 写道:
> > On Sat, Jan 28, 2023 at 04:46:48PM +0800, Wangshaobo (bobo) wrote:
> > > 锟斤拷 2023/1/23 21:45, Mark Rutland 写锟斤拷:
> > > > +config DYNAMIC_FTRACE_WITH_CALL_OPS
> > > > +	def_bool y
> > > > +	depends on HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
> > > > +
> > > Hi Mark,
> > 
> > Hi,
> > 
> > > I have test your patches and it looks fine with my sample module,
> > 
> > Thanks for testing!
> > 
> > > but here setting DYNAMIC_FTRACE_WITH_CALL_OPS to y immutably may increase the
> > > .text section size by 5% or more, how about making this to optional^^
> > 
> > We could consider making this optional. I had not made this optional so far as
> > in the future I'd like to make this the only implementation of ftrace on arm64
> > (once we can drop the old mcount version, and once we've sorted out the
> > incompatibility with CFI). In the mean time, it probably makes sense to have
> > the option at least to enable testing of each of the two forms.
> > 
> > Is your concern that the overall kernel image size is larger, or do you care
> > specifically about the size of the .text section for some reason?
> > 
> > Thanks,
> > Mark
> Embedded devices may pay more attention to Image size, and which may also
> indirectly affects performance, for more reason,

I appreciate those concerns, however:

a) For the Image size, the mcount_loc table and associated relocations already
   imposes a much greater penalty. So I'd expect that where the size truly
   matters, ftrace would be completely disabled anyway.

   I'm currently looking at shrinking the mcount_loc table (and removing the
   need for relocationgs), which should save much more space.

b) For performance, without data this is supposition. Everything so far
   indicates that there is not a measureable performance difference, and from
   other threads it's possible that the increased function alignment *aids*
   performance.

   If you have data to the contrary, I'm happy to investigate.

> I think making sense to have the option for testing is more important.

As above, I'm happy to add an option for functional testing of the ftrace
implementation, but I don't think that it's a good idea to use that as a size
or performance tweak.

Thanks,
Mark.
