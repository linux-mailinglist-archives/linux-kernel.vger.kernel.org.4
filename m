Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5810E626D6D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 03:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiKMCGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 21:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiKMCGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 21:06:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F328012A9A;
        Sat, 12 Nov 2022 18:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668305172; x=1699841172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I/2EtdGnQR6PzOSAc1r+6SOJWRi+w2vpqpt4iSYyu08=;
  b=RcLCD3mhS/rslJwStKbzQgDL0+e08dmwUjix5xq+wWltmjS3tVO/j728
   u4JnH7kwXt0CyMwcB7VGGTpuZbdMdj05AZg1jVvB9Gitv32TgH9lt7Pch
   4Zkp5JMdixcmZADocchgxa2+FhVSUUknCdnPIBtiWvPJOUabM7dWXQ5BF
   mQ5BLcxUqcX5Tf+w4O22yzfIy5UuW7h/naVNADOnYgeNT4IuDD+0ie9OY
   npuDM8uKEqcH8xx7hjWz5zhoj/PT4kfRc7EZXzTaeFqd2PXFfuxdKE2Se
   CDUA6euuNiORsRPkYbWyu8qnBwN5s2vsqaO89NKvBaPmDKj+i3kNL3Kxl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="309398179"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="309398179"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 18:06:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="701585547"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="701585547"
Received: from fkabir-mobl.amr.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.255.228.60])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 18:06:11 -0800
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs entry
Date:   Sat, 12 Nov 2022 18:06:11 -0800
Message-ID: <1817246.Ty3P6RqcON@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <Y2/x/vdtE0ciuOhE@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com> <208647816.nNe6ejF2h0@tjmaciei-mobl5> <Y2/x/vdtE0ciuOhE@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 12 November 2022 11:20:30 PST Borislav Petkov wrote:
> This sounds to me like there's a special order in which those batches
> should be executed?
> 
> I thought they're simply collections of test sequences which can be run
> in any order...

As Ashok replied, no, they are not ordered. But running them from first to last 
is the simplest algorithm to code.

If we did support file names, then the directory order would be also as good as 
any (unsorted).

> It is not about seeing - you simply give it the filename -
> request_firmware* does the "seeing". Either the file's there or it
> isn't.

I meant knowing which files are there. If they don't form a specific pattern, 
then it's impossible to know what they have been named. And if they do form a 
specific pattern, what's the harm in just using the sequence number? It's much 
easier for the kernel to remember a single 8-bit number than a file name.

It also allows for new techniques like deploying a single cpio or tarball with 
everything with an update to the kernel, without having userspace have to 
update to match.

> There's a reason I wrote:
> 
> "There will be no requirement on the naming - only on the filename
> length and it should be in that directory /lib/firmware/intel/ifs_0/"
> 
> Of course the driver should load only from that directory.

Thank you for that explanation. But my argument was that the application 
driving this might be deployed as a container, as part of a container-
orchestration and scheduling system, while the firmware files would already be 
pre-installed on the machine and updated with the regular firmware update 
mechanism. If the container can't see what files are there, it would have to 
resort to the guessing I mentioned above. CSPs could avoid this by bind-
mounting /lib/firmware into the container, but we'd prefer not to add yet 
another constraint.

> All that doesn't matter - if the CPU *must* wait 15 minutes between
> batches, then that should be enforced by the driver and not relied upon
> by userspace to DTRT.

If's enforced by the CPU today. How it determines when a test can be run is 
besides the point; the driver will ask it to run and the CPU will reply it 
couldn't. That information is conveyed back to userspace by changing the 
"status" back to "untested".

> This all has nothing to do with whether you give it a number or a
> filename. How you glue your testing around it together is a userspace
> issue - all the kernel driver needs to be able to do is load the
> sequence and execute it.
> 
> Echoing filenames into sysfs is no different from echoing numbers into
> it - former is simpler. If the CPU says it cannot execute the sequence
> currently, you have to think about how you retry that sequence. How you
> specify it doesn't matter.

Right, it's no different from echoing file names, but it's much simpler to 
increment a number than do a directory listing and sort the file names, so it 
can pick up from where it left off.

I mentioned this complication to explain why the userspace won't be able to 
simply echo each file name and expect things to have reached full coverage. 
Unfortunately, userspace needs to cope with the fact that there will be a 
timeout for certain generations. It's not what we'd have preferred; it's a 
hardware constraint we have to adapt to.

WIth this constraint in mind, having a single number simplifies userspace. You 
can't do it with a three-line shell script, but we're not expecting that shell 
scripts are the means to use this feature in the first place.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Cloud Software Architect - Intel DCAI Cloud Engineering



