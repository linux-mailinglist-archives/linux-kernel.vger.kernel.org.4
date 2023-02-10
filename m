Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4374869153C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBJAOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjBJAOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:14:43 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4845EBC6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:14:42 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id B72BB531;
        Thu,  9 Feb 2023 16:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1675988082;
        bh=8xr4JKGBtjyVH8iE2NnTKRsloX6eBPwF8GAnW6Ulnpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xr0NVsslTOaBHj0kdFLggaRt57QQfNKAc5tjhyVgF3e39jzTUBPNB+vIgT1/QBjac
         A2TDVhnuXkMdkMLDmDF3y9b2TpPzP3HiUTvIQtMHhOZ6jbf+VRL5rfo1uNuD8noVUl
         RWATlaxOzuch2oZ7GTZjxlADwlteGtzDDhYlQeBk=
Date:   Thu, 9 Feb 2023 16:14:40 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Iwona Winiarska <iwona.winiarska@intel.com>,
        openbmc@lists.ozlabs.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [RFC PATCH] hwmon: (peci/cputemp) Number cores as seen by host
 system
Message-ID: <Y+WMcCukyTvPcN2F@hatter.bewilderbeest.net>
References: <20230209011632.32668-1-zev@bewilderbeest.net>
 <20230209175001.GA667937@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230209175001.GA667937@roeck-us.net>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        SUBJ_AS_SEEN autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 09:50:01AM PST, Guenter Roeck wrote:
>On Wed, Feb 08, 2023 at 05:16:32PM -0800, Zev Weiss wrote:
>> While porting OpenBMC to a new platform with a Xeon Gold 6314U CPU
>> (Ice Lake, 32 cores), I discovered that the core numbering used by the
>> PECI interface appears to correspond to the cores that are present in
>> the physical silicon, rather than those that are actually enabled and
>> usable by the host OS (i.e. it includes cores that the chip was
>> manufactured with but later had fused off).
>>
>> Thus far the cputemp driver has transparently exposed that numbering
>> to userspace in its 'tempX_label' sysfs files, making the core numbers
>> it reported not align with the core numbering used by the host system,
>> which seems like an unfortunate source of confusion.
>>
>> We can instead use a separate counter to label the cores in a
>> contiguous fashion (0 through numcores-1) so that the core numbering
>> reported by the PECI cputemp driver matches the numbering seen by the
>> host.
>>
>
>I don't really have an opinion if this change is desirable or not.
>I suspect one could argue either way. I'l definitely want to see
>feedback from others. Any comments or thoughts, anyone ?
>

Agreed, I'd definitely like to get some input from Intel folks on this.

Though since I realize my initial email didn't quite explain this 
explicitly, I should probably clarify with an example how weird the 
numbering can get with the existing code -- on the 32-core CPU I'm 
working with at the moment, the tempX_label files produce the following 
core numbers:

     Core 0
     Core 1
     Core 2
     Core 3
     Core 4
     Core 5
     Core 6
     Core 7
     Core 8
     Core 9
     Core 11
     Core 12
     Core 13
     Core 14
     Core 15
     Core 18
     Core 20
     Core 22
     Core 23
     Core 24
     Core 26
     Core 27
     Core 28
     Core 29
     Core 30
     Core 31
     Core 33
     Core 34
     Core 35
     Core 36
     Core 38
     Core 39

i.e. it's not just a different permutation of the expected core numbers, 
we end up with gaps (e.g. the nonexistence of core 10), and core numbers 
well in excess of the number of cores the processor really "has" (e.g.  
number 39) -- all of which seems like a rather confusing thing to see in 
your BMC's sensor readings.


Thanks,
Zev

