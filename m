Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5A69EB88
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBUX4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjBUXz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:55:58 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A61E17162;
        Tue, 21 Feb 2023 15:55:55 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-161-58.tukw.qwest.net [174.21.161.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 6C05D218;
        Tue, 21 Feb 2023 15:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1677023754;
        bh=iA3eX2JkRVDTDT2ipfUWkJ/tJSppV02IAvBLp2GA4Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3pL3kMxXRGS57bZs0bi0UxSMPqY+xoPYpikTIMQlrYctXjww6hQElNCOgEK0bF6S
         SounwmLUpKvotErTul86fAPHZqShXvwM9BjhW9fOHqNC5RSu28AqZbheEXGdJLZs+r
         39pQznJtrbKklL7b4bMAxcHax66ee+zPW10CsRSM=
Date:   Tue, 21 Feb 2023 15:55:53 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [RFC PATCH] hwmon: (peci/cputemp) Number cores as seen by host
 system
Message-ID: <Y/VaCRIuwD0Ihp5Z@hatter.bewilderbeest.net>
References: <20230209011632.32668-1-zev@bewilderbeest.net>
 <20230209175001.GA667937@roeck-us.net>
 <Y+WMcCukyTvPcN2F@hatter.bewilderbeest.net>
 <97485a97-08c4-917b-1b8d-8102a8575a58@roeck-us.net>
 <Y+WieWyU+055eEom@hatter.bewilderbeest.net>
 <20230210184511.GA3670524@roeck-us.net>
 <2e6e07e5decb9c9f2eef6a49f9e11ba23a15a180.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e6e07e5decb9c9f2eef6a49f9e11ba23a15a180.camel@intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        SUBJ_AS_SEEN autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 01:20:14PM PST, Winiarska, Iwona wrote:
>On Fri, 2023-02-10 at 10:45 -0800, Guenter Roeck wrote:
>> On Thu, Feb 09, 2023 at 05:48:41PM -0800, Zev Weiss wrote:
>> > On Thu, Feb 09, 2023 at 04:26:47PM PST, Guenter Roeck wrote:
>> > > On 2/9/23 16:14, Zev Weiss wrote:
>> > > > On Thu, Feb 09, 2023 at 09:50:01AM PST, Guenter Roeck wrote:
>> > > > > On Wed, Feb 08, 2023 at 05:16:32PM -0800, Zev Weiss wrote:
>> > > > > > While porting OpenBMC to a new platform with a Xeon Gold 6314U CPU
>> > > > > > (Ice Lake, 32 cores), I discovered that the core numbering used by
>> > > > > > the
>> > > > > > PECI interface appears to correspond to the cores that are present
>> > > > > > in
>> > > > > > the physical silicon, rather than those that are actually enabled
>> > > > > > and
>> > > > > > usable by the host OS (i.e. it includes cores that the chip was
>> > > > > > manufactured with but later had fused off).
>> > > > > >
>> > > > > > Thus far the cputemp driver has transparently exposed that numbering
>> > > > > > to userspace in its 'tempX_label' sysfs files, making the core
>> > > > > > numbers
>> > > > > > it reported not align with the core numbering used by the host
>> > > > > > system,
>> > > > > > which seems like an unfortunate source of confusion.
>> > > > > >
>> > > > > > We can instead use a separate counter to label the cores in a
>> > > > > > contiguous fashion (0 through numcores-1) so that the core numbering
>> > > > > > reported by the PECI cputemp driver matches the numbering seen by
>> > > > > > the
>> > > > > > host.
>> > > > > >
>> > > > >
>> > > > > I don't really have an opinion if this change is desirable or not.
>> > > > > I suspect one could argue either way. I'l definitely want to see
>> > > > > feedback from others. Any comments or thoughts, anyone ?
>> > > > >
>> > > >
>> > > > Agreed, I'd definitely like to get some input from Intel folks on this.
>> > > >
>> > > > Though since I realize my initial email didn't quite explain this
>> > > > explicitly, I should probably clarify with an example how weird the
>> > > > numbering can get with the existing code -- on the 32-core CPU I'm
>> > > > working with at the moment, the tempX_label files produce the following
>> > > > core numbers:
>> > > >
>> > > >     Core 0
>> > > >     Core 1
>> > > >     Core 2
>> > > >     Core 3
>> > > >     Core 4
>> > > >     Core 5
>> > > >     Core 6
>> > > >     Core 7
>> > > >     Core 8
>> > > >     Core 9
>> > > >     Core 11
>> > > >     Core 12
>> > > >     Core 13
>> > > >     Core 14
>> > > >     Core 15
>> > > >     Core 18
>> > > >     Core 20
>> > > >     Core 22
>> > > >     Core 23
>> > > >     Core 24
>> > > >     Core 26
>> > > >     Core 27
>> > > >     Core 28
>> > > >     Core 29
>> > > >     Core 30
>> > > >     Core 31
>> > > >     Core 33
>> > > >     Core 34
>> > > >     Core 35
>> > > >     Core 36
>> > > >     Core 38
>> > > >     Core 39
>> > > >
>> > > > i.e. it's not just a different permutation of the expected core numbers,
>> > > > we end up with gaps (e.g. the nonexistence of core 10), and core numbers
>> > > > well in excess of the number of cores the processor really "has" (e.g.
>> > > > number 39) -- all of which seems like a rather confusing thing to see in
>> > > > your BMC's sensor readings.
>> > > >
>> > >
>> > > Sure, but what do you see with /proc/cpuinfo and with coretemp
>> > > on the host ? It might be even more confusing if the core numbers
>> > > reported by the peci driver don't match the core numbers provided
>> > > by other tools.
>> > >
>> >
>> > The host sees them numbered as the usual 0-31 you'd generally expect, and
>> > assigned to those cores in the same increasing order -- hence the patch
>> > bringing the two into alignment with each other.  Currently only cores 0
>> > through 9 match up between the two, and the rest are off by somewhere
>> > between one and eight.
>> >
>>
>> Hmm, interesting. It is not sequential on my large system (Intel(R) Xeon(R)
>> Gold 6154). I also know for sure that core IDs on Intel server CPUs are
>> typically not sequential. The processor number is sequential, but the core
>> ID isn't. On my system, the output from the "sensors" command (that is,
>> from the coretemp driver) matches the non-sequential core IDs from
>> /proc/cpuinfo, which is exactly how I would expect it to be.
>>
>> Guenter
>
>On Linux, from host side, core ID is obtained from EDX of CPUID(EAX=0xb).
>Unfortunately, the value exposed to the host (and whether it's in sequential or
>non-sequential form) can vary from platform to platform (which BTW is why on
>Linux, core ID shouldn't really be used for any logic related to task placement
>- topology info should be used instead).
>From BMC perspective - we'll always get the non-sequential form.
>
>If we just apply the patch proposed by Zev, we'll end up being consistent on one
>set of platforms and inconsistent on other set of platforms.
>If we want to make things consistent, we need a different approach - either by
>obtaining additional information over PECI or by limiting the scope of the
>proposed change to specific platforms.
>
>Thanks
>-Iwona
>

Okay, I was sort of afraid of something like that.

Does PECI provide the necessary information to reliably map its 
(physical silicon I presume) core numbers to the logical numbers seen by 
the host OS?  The PECI specs I have don't seem to mention anything along 
those lines as far as I can see, though perhaps there are newer or more 
detailed ones I don't have access to.

If not, how difficult would it be to classify known CPU models by 
distinct core-numbering schemes to handle it "manually" in the driver?  
If the necessary information is available I could try to develop a patch 
for it.


Thanks,
Zev

