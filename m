Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E626266713D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjALLtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjALLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:49:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CFD55E09D;
        Thu, 12 Jan 2023 03:38:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 423D5AD7;
        Thu, 12 Jan 2023 03:39:04 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04923F67D;
        Thu, 12 Jan 2023 03:38:19 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:38:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH 1/8] Compiler attributes: GCC function alignment
 workarounds
Message-ID: <Y7/xKbOZYztcqz2b@FVFF77S0Q05N>
References: <20230109135828.879136-1-mark.rutland@arm.com>
 <20230109135828.879136-2-mark.rutland@arm.com>
 <CANiq72kgmFYEO_EB_NxAF=S7VOf45KM7W3uwxxvftVErwfWzjg@mail.gmail.com>
 <Y77/qVgvaJidFpYt@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y77/qVgvaJidFpYt@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 06:27:53PM +0000, Mark Rutland wrote:
> On Mon, Jan 09, 2023 at 03:43:16PM +0100, Miguel Ojeda wrote:
> > On Mon, Jan 9, 2023 at 2:58 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > As far as I can tell, GCC doesn't respect '-falign-functions=N':
> > >
> > > * When the __weak__ attribute is used
> > >
> > >   GCC seems to forget the alignment specified by '-falign-functions=N',
> > >   but will respect the '__aligned__(N)' function attribute. Thus, we can
> > >   work around this by explciitly setting the alignment for weak
> > >   functions.
> > >
> > > * When the __cold__ attribute is used
> > >
> > >   GCC seems to forget the alignment specified by '-falign-functions=N',
> > >   and also doesn't seem to respect the '__aligned__(N)' function
> > >   attribute. The only way to work around this is to not use the __cold__
> > >   attibute.
> > 
> > If you happen to have a reduced case, then it would be nice to link it
> > in the commit. A bug report to GCC would also be nice.
> > 
> > I gave it a very quick try in Compiler Explorer, but I couldn't
> > reproduce it, so I guess it depends on flags, non-trivial functions or
> > something else.
> 
> So having spent today coming up with tests, it turns out it's not quite as I
> described above, but in a sense worse. I'm posting a summary here for
> posterity; I'll try to get this to compiler folk shortly.

I've added the cold bits to an existing ticket:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345

I have not been able to reproduce the issue with __weak__, so I'll go dig into
that some more; it's likely I was mistaken there.

Thanks,
Mark.
