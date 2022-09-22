Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F85E6ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiIVVuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiIVVuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:50:04 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA14F64E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663883403; x=1695419403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=er09uNXC0UOU0KonSbZPN8xSrNWI41anaBAXb0hrDDA=;
  b=itKqp6+t1s7zoMQEkfuxqCKgNkuE1RuqL3OyCT6LklyjGBKwLzyhAroA
   eft83kOUoQe4l0Zh3ba3KBscAJTFD+7EALP3rVk4GhPFaGJSOsoRATclB
   RFzjhGhxBMdC+wSZeWLc3ExDObAAxXeYGeCXsvERXea/fSgb2B6Z1WEzU
   Phbz7UDizY9QyzGGdZFHBPJxW2WghvTrXLRd4ecONHCxkD8CoikSiAHec
   ZSd46cR6gdTu+DLlCBCc+zWw5kgk69RMDmYgwnFrLLyw7P4f7izeey2Wq
   WJ0hpmM+fKfYPSU/m9g/DbTkZjj0L1O5T3sCSFIBZfj0kx3B08zJeuOeo
   A==;
X-IronPort-AV: E=Sophos;i="5.93,337,1654531200"; 
   d="scan'208";a="324163632"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2022 05:50:01 +0800
IronPort-SDR: XB/Uo/gsv+Qb1BjqrvxPuNu6I9bkEX0dcQ8KG6Mb+UoB31WXVXl+i4d4g7IGbN/7i03pZeha7C
 K4prYl9Teqpc5NPJDPhcDxrk435Xh25/Zh9oWnY6vZr5uqTdT7pgnL8i/IlHXpB2lvtgiJH1SX
 Q1RPJK/1/3E+M2M/9y56VuiKnPn+L2Shc4vNLdAPbUJVbTQHMYUxALh83Q+IvejSCpYo/CKdb7
 y5r8347Dh7EoUd3aonL0JygVnVeX/qTb9uQB7IE6UcpKXMrspYvf+djSCuSezDLoylYwkdhyNJ
 2XMVPmJoZu3jp1FST9Qr/wHy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2022 14:10:04 -0700
IronPort-SDR: DzKlSa/y/PfK44NDSPON25ASuNI/oZCMP/4F21toC2i//9BxOPgVOZC/KwAM7UdQv6gC4z5qn/
 v76jih8UfZ24823Ful61rjpgdeiGfawoDWHZXa8N0PQy+BzLqUq5IcVWAgsA29d7mt2tR+7GQT
 4CkP11/0R1+e5QtuK/aJL83nOwDeEvbMLr44H6YsZ4NuYl/4+mFlQjcmWyTmG+A9EHkztPVSfo
 WCWilsw2RC5RMpFsC1q7ATaoJuupSPg7jwSE3OA0jXvh3Ia3knmY4h+2plZVjJT+kKX3958ffh
 THQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2022 14:50:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MYTTh68r8z1RwvT
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:50:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663883398; x=1666475399; bh=er09uNXC0UOU0KonSbZPN8xSrNWI41anaBA
        Xb0hrDDA=; b=rz2GcA7s2bJgUXchSnXZVFCNcJUGWCPkCS3MbwuKvU08r9AyzdQ
        IpGIMiLbX6cxjTb09M/N1cgll93w2/oxxj8/Ud2zKTDugZwtwfGgvodFSAFnAP+h
        62Ec4kZjXy0vn47e0KvweHBK/Jg4lBdwKCoeeOkaftRCW9lC5M2VMiD1oZFMLgMQ
        R6y9bS2apjeadQVN64Xdven2aaTMIAzLRcuKtgSc5DRcxyEUmEv9fxeSWDq2PM8V
        rzTvnW5v5pJwHL0oyi8nYgTn/qml0MCDAJ2MD6dnMUpFwLH8FuYX7WrvKbk+tSw2
        3pxsjnL/649ooLjlse7rgUFrG7Ow7Q5t1JA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WLgutaWiMGyj for <linux-kernel@vger.kernel.org>;
        Thu, 22 Sep 2022 14:49:58 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MYTTX6yjsz1RvLy;
        Thu, 22 Sep 2022 14:49:52 -0700 (PDT)
Message-ID: <860fb643-8a1a-225e-13e7-e68a4b6f3842@opensource.wdc.com>
Date:   Fri, 23 Sep 2022 06:49:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone sizes]
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
        bvanassche@acm.org, pankydev8@gmail.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Johannes.Thumshirn@wdc.com, jaegeuk@kernel.org,
        matias.bjorling@wdc.com
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com> <YytJhEywBhqcr7MX@redhat.com>
 <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
 <Yyy5XUUWGkU8B3IP@redhat.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yyy5XUUWGkU8B3IP@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 04:37, Mike Snitzer wrote:
> On Wed, Sep 21 2022 at  7:55P -0400,
> Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
> 
>> On 9/22/22 02:27, Mike Snitzer wrote:
>>> On Tue, Sep 20 2022 at  5:11P -0400,
>>> Pankaj Raghav <p.raghav@samsung.com> wrote:
>>>
>>>> - Background and Motivation:
>>>>
>>>> The zone storage implementation in Linux, introduced since v4.10, first
>>>> targetted SMR drives which have a power of 2 (po2) zone size alignment
>>>> requirement. The po2 zone size was further imposed implicitly by the
>>>> block layer's blk_queue_chunk_sectors(), used to prevent IO merging
>>>> across chunks beyond the specified size, since v3.16 through commit
>>>> 762380ad9322 ("block: add notion of a chunk size for request merging").
>>>> But this same general block layer po2 requirement for blk_queue_chunk_sectors()
>>>> was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_sectors'
>>>> to be non-power-of-2").
>>>>
>>>> NAND, which is the media used in newer zoned storage devices, does not
>>>> naturally align to po2. In these devices, zone capacity(cap) is not the
>>>> same as the po2 zone size. When the zone cap != zone size, then unmapped
>>>> LBAs are introduced to cover the space between the zone cap and zone size.
>>>> po2 requirement does not make sense for these type of zone storage devices.
>>>> This patch series aims to remove these unmapped LBAs for zoned devices when
>>>> zone cap is npo2. This is done by relaxing the po2 zone size constraint
>>>> in the kernel and allowing zoned device with npo2 zone sizes if zone cap
>>>> == zone size.
>>>>
>>>> Removing the po2 requirement from zone storage should be possible
>>>> now provided that no userspace regression and no performance regressions are
>>>> introduced. Stop-gap patches have been already merged into f2fs-tools to
>>>> proactively not allow npo2 zone sizes until proper support is added [1].
>>>>
>>>> There were two efforts previously to add support to npo2 devices: 1) via
>>>> device level emulation [2] but that was rejected with a final conclusion
>>>> to add support for non po2 zoned device in the complete stack[3] 2)
>>>> adding support to the complete stack by removing the constraint in the
>>>> block layer and NVMe layer with support to btrfs, zonefs, etc which was
>>>> rejected with a conclusion to add a dm target for FS support [0]
>>>> to reduce the regression impact.
>>>>
>>>> This series adds support to npo2 zoned devices in the block and nvme
>>>> layer and a new **dm target** is added: dm-po2zoned-target. This new
>>>> target will be initially used for filesystems such as btrfs and
>>>> f2fs until native npo2 zone support is added.
>>>
>>> As this patchset nears the point of being "ready for merge" and DM's
>>> "zoned" oriented targets are multiplying, I need to understand: where
>>> are we collectively going?  How long are we expecting to support the
>>> "stop-gap zoned storage" layers we've constructed?
>>>
>>> I know https://zonedstorage.io/docs/introduction exists... but it
>>> _seems_ stale given the emergence of ZNS and new permutations of zoned
>>> hardware. Maybe that isn't quite fair (it does cover A LOT!) but I'm
>>> still left wanting (e.g. "bring it all home for me!")...
>>>
>>> Damien, as the most "zoned storage" oriented engineer I know, can you
>>> please kick things off by shedding light on where Linux is now, and
>>> where it's going, for "zoned storage"?
>>
>> Let me first start with what we have seen so far with deployments in the
>> field.
> 
> <snip>
> 
> Thanks for all your insights on zoned storage, very appreciated!
> 
>>> In addition, it was my understanding that WDC had yet another zoned DM
>>> target called "dm-zap" that is for ZNS based devices... It's all a bit
>>> messy in my head (that's on me for not keeping up, but I think we need
>>> a recap!)
>>
>> Since the ZNS specification does not define conventional zones, dm-zoned
>> cannot be used as a standalone DM target (read: single block device) with
>> NVMe zoned block devices. Furthermore, due to its block mapping scheme,
>> dm-zoned does not support devices with zones that have a capacity lower
>> than the zone size. So ZNS is really a big *no* for dm-zoned. dm-zap is a
>> prototype and in a nutshell is the equivalent of dm-zoned for ZNS. dm-zap
>> can deal with the smaller zone capacity and does not require conventional
>> zones. We are not trying to push for dm-zap to be merged for now as we are
>> still evaluating its potential use cases. We also have a different but
>> functionally equivalent approach implemented as a block device driver that
>> we are evaluating internally.
>>
>> Given the above mentioned usage pattern we have seen so far for zoned
>> storage, it is not yet clear if something like dm-zap for ZNS is needed
>> beside some niche use cases.
> 
> OK, good to know.  I do think dm-zoned should be trained to _not_
> allow use with ZNS NVMe devices (maybe that is in place and I just
> missed it?).  Because there is some confusion with at least one
> customer that is asserting dm-zoned is somehow enabling them to use
> ZNS NVMe devices!

dm-zoned checks for conventional zones and also that all zones have a zone
capacity that is equal to the zone size. The first point puts ZNS out but
a second regular drive can be used to emulate conventional zones. However,
the second point (zone cap < zone size) is pretty much a given with ZNS
and so rules it out.

If anything, we should also add a check on the max number of active zones,
which is also a limitation that ZNS drives have, unlike SMR drives. Since
dm-zoned does not handle active zones at all, any drive with a limit
should be excluded. I will send patches for that.
> 
> Maybe they somehow don't _need_ conventional zones (writes are handled
> by some other layer? and dm-zoned access is confined to read only)!?
> And might they also be using ZNS NVMe devices to do _not_ have a
> zone capacity lower than the zone size?

It is a possibility. Indeed, if the ZNS drive has:
1) zone capacity equal to zone size
2) a second regular drive is used to emulate conventional zones
3) no limit on the max number of active zones

Then dm-zoned will work just fine. But again, I seriously doubt that point
(3) holds. And we should check that upfront in dm-zoned ctr.

> Or maybe they are mistaken and we should ask more specific questions
> of them?

Getting the exact drive characteristics (zone size, capacity and zone
resource limits) will tell you if dm-zoned can work or not.

-- 
Damien Le Moal
Western Digital Research

