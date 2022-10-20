Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85C7606216
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJTNqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJTNqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:46:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9747159A3C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666273560; x=1697809560;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sOvhO47D7FTpxIF0a2DwvTy4GmSSGRqIP8YnoXp6ofQ=;
  b=bhhyQR6pnTBFTGh26waGrzIrqekMuae2C6JdoiTwBncIm9szzlc3H7YN
   xMRXGr5bxXehotjBJt2BZJBH1kUfW++bY5ywbvzoXXuxMTtykMtNB2tuW
   1RSs9sRARmn8CSlsrFZXhFop4SNnCTNSWu8Q7cdzP9oQ/yZ23VFqxwhRH
   UxDDIJ/LvLpSvyRMErz5aYdLOSB0+/+AWzV3eKI+DIqToOE6hRm2OVeAV
   MefP3uNH/MYT/367QpkcikejgyT4jjKDSFC5frY+l1GrgATfXqykDpp7i
   V+O3GO4c3KLEFBmHm2Q2yp5UdpnSltlZAl0kIYhx5IEG0ccKDs+cotG4z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="308390701"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="308390701"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 06:45:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="692990171"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="692990171"
Received: from aasthash-mobl.ger.corp.intel.com (HELO [10.213.232.117]) ([10.213.232.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 06:45:51 -0700
Message-ID: <d47b30e9-5619-c631-aa92-f5d89e88a909@linux.intel.com>
Date:   Thu, 20 Oct 2022 14:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [Intel-gfx] signal: break out of wait loops on kthread_stop()
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Intel-gfx@lists.freedesktop.org" <Intel-gfx@lists.freedesktop.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, sultan@kerneltoast.com
References: <0029af41-bf24-9972-10ac-f52e1bdcbf08@linux.intel.com>
 <CAHmME9o25v0kZUV-7qEY=6XXAyOA7q0sG8gpQfxHgr3sSVdsWw@mail.gmail.com>
 <41455798-1dcb-135f-516d-25ab9a8082f5@linux.intel.com>
 <Y1A+9kN6bwfXeqVt@zx2c4.com>
 <8acc3e4a-abbc-32bc-626e-7a216f6755c3@linux.intel.com>
 <Y1Bby6FEEWiFIjjD@zx2c4.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <Y1Bby6FEEWiFIjjD@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/10/2022 21:19, Jason A. Donenfeld wrote:
> On Wed, Oct 19, 2022 at 09:09:28PM +0100, Tvrtko Ursulin wrote:
>> Hm why is kthread_stop() after kthread_run() abuse? I don't see it in
>> kerneldoc that it must not be used for stopping threads.
> 
> Because you don't want it to stop. You want to wait until it's done. If
> you call stop right after run, it will even stop it before it even
> begins to run. That's why you wind up sprinkling your msleeps
> everywhere, indicating that clearly this is not meant to work that way.
Not after kthread_run which wakes it up already. If the kerneldoc for 
kthread_stop() is correct at least... In which case I really do think 
that the yields are pointless/red herring. Perhaps they predate 
kthread_run and then they were even wrong.

>> Yep the yields and sleeps are horrible and will go. But they are also
>> not relevant for the topic at hand.
> 
> Except they very much are. The reason you need these is because you're
> using kthread_stop() for something it's not meant to do.

It is supposed to assert kthread_should_stop() which thread can look at 
as when to exit. Except that now it can fail to get to that controlled 
exit point. Granted that argument is moot since it implies incomplete 
error handling in the thread anyway.

Btw there are actually two use cases in our code base. One is thread 
controls the exit, second is caller controls the exit. Anyway...

>> Never mind, I was not looking for anything more than a suggestion on how
>> to maybe work around it in piece as someone is dealing with the affected
>> call sites.
> 
> Sultan's kthread_work idea is probably the right direction. This would
> seem to have what you need.

... yes, it can be converted. Even though for one of the two use cases 
we need explicit signalling. There now isn't anything which would assert 
kthread_should_stop() without also asserting the signal, right?. Neither 
I found that the thread work API can do it.

Fingers crossed we were the only "abusers" of the API. There's a quite a 
number of kthread_stop callers and it would be a large job to audit them 
all.

Regards,

Tvrtko
