Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0B6AF654
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCGUDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCGUCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:02:47 -0500
X-Greylist: delayed 935 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Mar 2023 12:01:00 PST
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD078A58
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:01:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678218270; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Sc5kAYJttgjUHM0dK8Um7PYql3nnW7dQPt/cWsYRAb00uQtlVLexTpVlQADl5t38iYRHk6A1xMXtDid+vMdSUty58HKk8SBpdToyK7CZH+v1WjTSr1kguAu8DK/HaGMoQiixV3/M/YuddS8DcHlN/ZA8hQvzJOJS+hRCq7+ZoZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1678218270; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=X5hIcBpmyHG0dpsjtHm3qTE9RjRkrr2sZkwKhqoD0cY=; 
        b=NKOTpqEyv1mm66ICziZWlXvxDtHgE5X5vFj1DLFRDUL/n2GLGgNqb5yzW0jLrd/b0dZb39lT5M9GQCSIINZw2Qf4d3085DL9gEiTDJXA6VrZJOJc2Omjo+LzHyTsfxFOek3WN+PlbK1hrtNCWcMtfgSqVAcN2ASqgtVHjTWWUeI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.50] (pool-98-113-67-206.nycmny.fios.verizon.net [98.113.67.206]) by mx.zoho.eu
        with SMTPS id 167821826760826.94495560300186; Tue, 7 Mar 2023 20:44:27 +0100 (CET)
Message-ID: <8f5ce378-9a83-454b-5b92-df530308c679@trained-monkey.org>
Date:   Tue, 7 Mar 2023 14:44:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [regression] Bug 217074 - upgrading to kernel 6.1.12 from 5.15.x
 can no longer assemble software raid0
Content-Language: en-US
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        NeilBrown <neilb@suse.de>
Cc:     Song Liu <song@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Jes.Sorensen@gmail.com, linux-raid <linux-raid@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nikolay Kichukov <hijacker@oldum.net>
References: <a13cd3b5-cc41-bf2f-c8ac-e031ad0d5dd7@leemhuis.info>
 <CAPhsuW7ZWthh0PZt71hQh1_51C0yMSpOqWYJKc_+VzzTmW_r5A@mail.gmail.com>
 <167805126796.8008.3635368722810568057@noble.neil.brown.name>
 <20230307095258.00001cb3@linux.intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20230307095258.00001cb3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 03:52, Mariusz Tkaczyk wrote:
> On Mon, 06 Mar 2023 08:21:07 +1100
> "NeilBrown" <neilb@suse.de> wrote:
> 
>> On Sat, 04 Mar 2023, Song Liu wrote:
>>> + Jes.
>>>
>>> It appeared to me that we can assemble the array if we have any of the
>>> following:
>>> 1. Enable CONFIG_BLOCK_LEGACY_AUTOLOAD;
>>> 2. Have a valid /etc/mdadm.conf;
>>> 3. Update mdadm to handle this case. (I tried some ugly hacks, which worked
>>> but weren't clean).
>>>
>>> Since we eventually would like to get rid of CONFIG_BLOCK_LEGACY_AUTOLOAD, I
>>> think we need mdadm to handle this properly. But the logistics might
>>> be complicated, as
>>> mdadm are shipped separately.
>>>
>>> Jes, what do you think about this? AFAICT, we need to update the logic in
>>> mdopen.c:create_mddev().  
>>
>> mdadm already handles this, but only if 
>>    CREATE names=yes
>> is present in /etc/mdadm.conf
> 
> Hi,
> 
> "CREATE names=yes" enforces creation of /dev/md_name arrays instead of
> /dev/mdXXX. It is a large change for users, too aggressive IMO. It will destroy
> many setups.

This is my concern too. I find a lot of people setup their box with md
and then keep it running, but they don't necessarily update it as
frequently as their laptop etc. This could cause some unpleasant
surprises down the road.

> To resolve it, we need is to use create_named_array() but respect old naming
> convention. We already have find_free_devnm(), and we are able to keep
> consistency because we can create 'mdXXX':
> 
> /sys/module/md_mod/parameters # echo md125 > new_array
> 
> /sys/module/md_mod/parameters # ll /sys/block/md125
> lrwxrwxrwx 1 root root 0 Mar  7 10:54 /sys/block/md125 ->
> ../devices/virtual/block/md125
> 
> That will require adjustments in mdadm, but I think that we can keep
> names the same way. I created the test for verification of base creation flows,
> we can use it to avoid regression:
> https://git.kernel.org/pub/scm/utils/mdadm/mdadm.git/tree/tests/00createnames
> 
> Thoughts?

I like this.

> BTW. I wanted to get rid of this legacy "create_on_open" from mdadm anyway but
> never had time to. If you agree, I can proceed with fixing it.

Oh yes

Cheers,
Jes

