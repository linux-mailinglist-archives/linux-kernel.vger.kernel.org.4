Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDED6144E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 08:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKAHE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 03:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKAHE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 03:04:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C6010B66
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667286295; x=1698822295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=krP+7HTZhXI4XzFI/mvOb52bDMhAGH76tAHdLqKcV/Q=;
  b=gu3kNl/r1WrGYXDX8QSezEyahTvrTdgBFFBrlkvlA4M5dGoDxm2o8qvu
   ZXDdEEK/2zFkJ/cJqqH86peYFP95S3z7W7IwcGXmw7oZYUIYCMkfU3Iwz
   96Mfh0HHisobVylYEI52r2CuWgCpjsgXBuDjji/tJ2WOUlBF9YmqfZPQ1
   qCYWE/+T+XwOImxRxeco1b7gq2tXXbnU0HlYq9Wg/fDNc3fDAty9swUqf
   /9vytI8Gi3518q+ddetNvDS78M/rd04NM3lUa2xfTgu+QAnG1fl6tghnV
   SeXximKIQjIXA8uCoL4elhre2f1xTAWzK1cquryX2zVgdgtreTvXsVCsq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="309079451"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="309079451"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 00:04:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="702793369"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="702793369"
Received: from sushilsu-mobl1.amr.corp.intel.com (HELO [10.209.50.146]) ([10.209.50.146])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 00:04:54 -0700
Message-ID: <6bbbb89b-1339-e5a1-b127-09270327b6c8@intel.com>
Date:   Tue, 1 Nov 2022 00:04:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] selftests/x86: add "ffff8" -- kernel memory scanner
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <Y1wunXB2iv0QHr22@p183>
 <84E9CFF2-760D-4A5D-9B19-11CA804E1FE8@zytor.com> <Y11h+mbtSEEwHKRZ@p183>
 <429982ba-e06f-e76b-061c-39db67558aa5@intel.com> <Y2DAk9zKYG9hT/Ov@p183>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y2DAk9zKYG9hT/Ov@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 23:45, Alexey Dobriyan wrote:
> On Mon, Oct 31, 2022 at 02:37:43PM -0700, Dave Hansen wrote:
>> On 10/29/22 10:25, Alexey Dobriyan wrote:
>>> 	$ ./ffff8_64 -h
>>> 	usage: ./ffff8_64 [-f] [-r] [-n N] [-s S]
>>> 	        -f: sequential scan
>>> 	        -r: random scan (default)
>>> 	        -n: use N threads (default: $(nproc))
>>> 	        -s: lowest address shift (default: 47)
>>> 	        -t: time to run (default: 256 seconds)
>> Does this mean that if someone is just running all kernel selftests,
>> they need to wait for 256 seconds for this to finish?
> Yes. But low time will cover negligible amount of address space.
> 
> Is there some kind of policy to not do this? LTP surely has similar
> tests for races.

There's no written policy that I know of.  But, right now, the entirety
of the x86 selftests will run in a second or two.  It's actually
something I run in a loop to stress the entry/exit paths when I'm
messing with them.  Something silly like this:

	for i in *_32 *_64; do ./$i; done

Just picking a number out of thin air, I'd say that running for a couple
of seconds, like 2 is fine by default for any one tests.  Longer than
that, and it'll be out of whack with all the other x86 selftests.  If
it's 256 seconds, it just won't get run.

Yes, a single run will not have as much coverage, but a lot of people
run those tests (think 0day) and some folks run them a *lot*, like how I
run them in a loop.

The MPX selftest that was in there was in a similar situation.  It
*could* run for a long, long time and that helped because address
randomization would eventually help find some of the nastier corner
cases.  But, it was limited to a few seconds.

I really think we should stick to just a few seconds at most for any
individual test.
