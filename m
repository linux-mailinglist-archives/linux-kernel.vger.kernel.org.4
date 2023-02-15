Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F98697925
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjBOJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjBOJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:40:39 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9CA23D85;
        Wed, 15 Feb 2023 01:40:28 -0800 (PST)
Received: from host86-157-192-115.range86-157.btcentralplus.com ([86.157.192.115] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1pSEH4-0009mu-Bn;
        Wed, 15 Feb 2023 09:40:26 +0000
Message-ID: <cbce8455-ed12-4bfa-427e-4dd54f19dca9@youngman.org.uk>
Date:   Wed, 15 Feb 2023 09:40:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [dm-devel] RAID4 with no striping mode request
To:     Roger Heflin <rogerheflin@gmail.com>,
        Heinz Mauelshagen <heinzm@redhat.com>
Cc:     Kyle Sanderson <kyle.leet@gmail.com>, linux-raid@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
References: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
 <25578.37401.314298.238192@quad.stoffel.home>
 <CACsaVZJ-5y7U5xqwL9bof69EKbTk+wrHWFcBFYyP_BwVSt+CNA@mail.gmail.com>
 <CAM23Vxr8LkkcVDFfW1=qEYGgo7JG1qx62eWSV4WOw4_MnD+TZA@mail.gmail.com>
 <CAAMCDeeHxMBoVkNYAyssjgjo4=FYd2NonS-mqC7OUEL89B9Cig@mail.gmail.com>
Content-Language: en-GB
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <CAAMCDeeHxMBoVkNYAyssjgjo4=FYd2NonS-mqC7OUEL89B9Cig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 22:28, Roger Heflin wrote:
> On Tue, Feb 14, 2023 at 3:27 PM Heinz Mauelshagen <heinzm@redhat.com> wrote:
>>
> 
>>
>>
>> ...which is RAID1 plus a parity disk which seems superfluous as you achieve (N-1)
>> resilience against single device failures already without the later.
>>
>> What would you need such parity disk for?
>>
>> Heinz
>>
> 
> I thought that at first too, but threw that idea out as it did not
> make much sense.
> 
> What he appears to want is 8 linear non-striped data disks + a parity disk.
> 
> Such that you can lose any one data disk and parity can rebuild that
> disk.  And if you lose several data diskis, then you have intact
> non-striped data for the remaining disks.

But all your lost disks are lost (until you rebuild parity. The lost 
disks are still lost, but you won't lose any more, unless lightning 
strikes twice).
> 
> It would almost seem that you would need to put a separate filesystem
> on each data disk/section (or have a filesystem that is redundant
> enough to survive) otherwise losing an entire data disk would leave
> the filesystem in a mess..
> 
> So N filesystems + a parity disk for the data on the N separate
> filesystems.   And each write needs you to read the data from the disk
> you are writing to, and the parity and recalculate the new parity and
> write out the data and new parity.
> 
> If the parity disk was an SSD it would be fast enough, but if parity
> was an SSD I would expect it to get used up/burned out from all of
> parity being re-written for each write on each disk unless you bought
> an expensive high-write ssd.

I think even cheap SSDs are okay now ...
> 
> The only advantage of the setup is that if you lose too many disks you
> still have some data.
> 
> It is not clear to me that it would be any cheaper if parity needs to
> be a normal ssd's (since ssds are about 4x the price/gb and high-write
> ones are even more) than a classic bunch of mirrors, or even say a 4
> disks raid6 where you can lose any 2 and still have data.

The only (claimed) advantage of the setup is that you can mix and match 
disk sizes. Personally, I'd just raid-0 the smaller disks to get a whole 
bunch of volumes roughly equal to the largest disk, raid-5 or -6 those 
together, and put LVM on the top.

Probably split two disks out to mirror as my / partition away from the 
main /home raid/lvm.

This scheme is just too hare-brained imho.

(Oh, and if one drive fails and the others carry on writing, you run the 
serious risk of screwing up parity and losing your lost disk, anyway. 
It's just not robust in the face of glitches ...)

Cheers,
Wol

