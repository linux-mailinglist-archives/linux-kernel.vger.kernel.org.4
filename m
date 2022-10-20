Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8404F605846
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJTHUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJTHT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:19:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AEC32D83;
        Thu, 20 Oct 2022 00:19:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9A6FB228C8;
        Thu, 20 Oct 2022 07:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666250384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fVnKUVN+rk3hsRrJaEq7YSvnw07L+3uAYvZmtQr/27U=;
        b=ruOP6WHzMtqSd3sHQzx9qDusF18iwgbG8+jovJfWG3TQhxK2QkMZfppQKtGpwmJitTuVuP
        wY55GO8fyTPqT8D08VUpyJ3Gd4Fx5wcJ65Fzhg+Mdq83+pUsfnHDtm9twwIdVYB7SQXMqY
        eVxEU+tScDSElYyT7GgQoAwnLbCjvoY=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 78E832C141;
        Thu, 20 Oct 2022 07:19:44 +0000 (UTC)
Date:   Thu, 20 Oct 2022 09:19:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y1D2kFy+I8dgDkll@alley>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <2342ef17-f8f9-501f-0f7b-5a69e85c2cf4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2342ef17-f8f9-501f-0f7b-5a69e85c2cf4@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-10-18 15:53:03, Prarit Bhargava wrote:
> On 10/18/22 14:33, Luis Chamberlain wrote:
> > On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
> > > The patch does address a regression observed after commit 6e6de3dee51a
> > > ("kernel/module.c: Only return -EEXIST for modules that have finished
> > > loading"). I guess it can have a Fixes tag added to the patch.
> > > 
> > > I think it is hard to split this patch into parts because the implemented
> > > "optimization" is the fix.
> > 
> > git describe --contains 6e6de3dee51a
> > v5.3-rc1~38^2~6
> > 
> > I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
> > right thing to do, but without it, it still leaves the issue reported
> > by Prarit Bhargava. We need a way to resolve the issue on stable and
> > then your optimizations can be applied on top.
> > 
> > Prarit Bhargava, please review Petry's work and see if you can come up
> > with a sensible way to address this for stable.
> 
> I found the original thread surrounding these changes and I do not think
> this solution should have been committed to the kernel.  It is not a good
> solution to the problem being solved and adds complexity where none is
> needed IMO.
> 
> Quoting from the original thread,
> 
> > 
> > Motivation for this patch is to fix an issue observed on larger machines with
> > many CPUs where it can take a significant amount of time during boot to run
> > systemd-udev-trigger.service. An x86-64 system can have already intel_pstate
> > active but as its CPUs can match also acpi_cpufreq and pcc_cpufreq, udev will
> > attempt to load these modules too. The operation will eventually fail in the
> > init function of a respective module where it gets recognized that another
> > cpufreq driver is already loaded and -EEXIST is returned. However, one uevent
> > is triggered for each CPU and so multiple loads of these modules will be
> > present. The current code then processes all such loads individually and
> > serializes them with the barrier in add_unformed_module().
> > 
> 
> The way to solve this is not in the module loading code, but in the udev
> code by adding a new event or in the userspace which handles the loading
> events.
> 
> Option 1)
> 
> Write/modify a udev rule to to use a flock userspace file lock to prevent
> repeated loading.  The problem with this is that it is still racy and still
> consumes CPU time repeated load the ELF header and, depending on the system
> (ie a large number of cpus) would still cause a boot delay.  This would be
> better than what we have and is worth looking at as a simple solution.  I'd
> like to see boot times with this change, and I'll try to come up with a
> measurement on a large CPU system.

This sounds like a ping-pong between projects where to put the
complexity. Honestly, I think that it would be more reliable if
we serialized/squashed parallel loads on the kernel side.


> Option 2)
> 
> Create a new udev action, "add_once" to indicate to userspace that the
> module only needs to be loaded one time, and to ignore further load
> requests.  This is a bit tricky as both kernel space and userspace would
> have be modified.  The udev rule would end up looking very similar to what
> we now.
>
> The benefit of option 2 is that driver writers themselves can choose which
> drivers should issue "add_once" instead of add.  Drivers that are known to
> run on all devices at once would call "add_once" to only issue a single
> load.

My concern is how to distinguish first attempts and later (fixed)
attempts.

I mean that the module load might fail at boot. But the user might
fix the root of the problem and try to load the module once again
without reboot. The other load need not be direct. It might be part
of another more complex operation. Reload of another module.
Restart of a service.

It might be problematic to do this an user-friendly way.
And it might be much more complicated in the end.

Best Regards,
Petr
