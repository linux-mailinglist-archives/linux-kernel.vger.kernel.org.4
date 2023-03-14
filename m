Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4E46B8DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCNI6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCNI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:58:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7269030D1;
        Tue, 14 Mar 2023 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678784280; x=1710320280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e6s1TMoZZTACSJmvxTnBC46ALPwq3I5yUCTKoFRA9AU=;
  b=DEdCY+7BK0M/3woduuREFKNu6XliHoGdoD0Rwoj1WOhgGYCrpw7YD+nY
   mOp7dlLxha3gLQD3fYC32qhgncNPv0BhHCeAHxiUnJ+egoY6UcHCSCZqi
   nIdjj9aBqYCtVH7jK7PTgq0bbkuRsy/qehyXfidFbLaw5YicXxf7eWDal
   nNlitoRyiszHzFMwYROXfMNBz4bQUnBhNyayfdEjhijha5U4V2JDNg4g+
   2R4AYZZIA/ca4t6DYDTY8UDLUVsrAtA5pOsJTd8qez/Kt3tWX66/S/UtS
   IskQ9CSJ5xjmG64Q0QcmQKjPRDHZKjLZ9UZe1ZRBwZ55b868i/QJSs597
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334849276"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="334849276"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 01:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="628971935"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="628971935"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.221.17])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 01:57:56 -0700
Message-ID: <ed864feb-fdac-1aae-3f8b-f6e66f3e7598@intel.com>
Date:   Tue, 14 Mar 2023 10:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bean Huo <huobean@gmail.com>
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <54cee7de4ab7479db74b21e64e5f53cf@hyperstone.com>
 <CAPDyKFq-qToEX+qiuHirNbcuedii_f0KKuHiPAv7+tydrUTpqQ@mail.gmail.com>
 <4a2c5b752968496ca72966f80e148d47@hyperstone.com>
 <3effa855-1668-db9f-7d38-2c3352ea6ef1@intel.com>
 <CAPDyKFpVZaHA0jPBa=uxLSCzcUTZujUzJvh1oqar6NbBHg9wtQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFpVZaHA0jPBa=uxLSCzcUTZujUzJvh1oqar6NbBHg9wtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/23 09:56, Ulf Hansson wrote:
> On Mon, 13 Mar 2023 at 17:56, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 10/03/23 19:06, Christian Löhle wrote:
>>>
>>>>>
>>>>> I have benchmarked the FUA/Cache behavior a bit.
>>>>> I don't have an actual filesystem benchmark that does what I wanted and is easy to port to the target so I used:
>>>>>
>>>>> # call with
>>>>> # for loop in {1..3}; do sudo dd if=/dev/urandom bs=1M
>>>>> of=/dev/mmcblk2; done; for loop in {1..5}; do time
>>>>> ./filesystembenchmark.sh; umount /mnt; done
>>>>> mkfs.ext4 -F /dev/mmcblk2
>>>>> mount /dev/mmcblk2 /mnt
>>>>> for i in {1..3}
>>>>> do
>>>>> cp -r linux-6.2.2 /mnt/$i
>>>>> done
>>>>> for i in {1..3}
>>>>> do
>>>>> rm -r /mnt/$i
>>>>> done
>>>>> for i in {1..3}
>>>>> do
>>>>> cp -r linux-6.2.2 /mnt/$i
>>>>> done
>>>>>
>>>>>
>>>>> I found a couple of DUTs that I can link, I also tested one industrial card.
>>>>>
>>>>> DUT1: blue PCB Foresee eMMC
>>>>> https://pine64.com/product/32gb-emmc-module/
>>>>> DUT2: green PCB SiliconGo eMMC
>>>>> Couldn't find that one online anymore unfortunately
>>>>> DUT3: orange hardkernel PCB 8GB
>>>>> https://www.hardkernel.com/shop/8gb-emmc-module-c2-android/
>>>>> DUT4: orange hardkernel PCB white dot
>>>>> https://rlx.sk/en/odroid/3198-16gb-emmc-50-module-xu3-android-for-odro
>>>>> id-xu3.html
>>>>> DUT5: Industrial card
>>>>
>>>> Thanks a lot for helping out with testing! Much appreciated!
>>>
>>> No problem, glad to be of help.
>>>
>>>>
>>>>>
>>>>>
>>>>> The test issued 461 DO_REL_WR during one of the iterations for DUT5
>>>>>
>>>>> DUT1:
>>>>> Cache, no FUA:
>>>>> 13:04.49
>>>>> 13:13.82
>>>>> 13:30.59
>>>>> 13:28:13
>>>>> 13:20:64
>>>>> FUA:
>>>>> 13:30.32
>>>>> 13:36.26
>>>>> 13:10.86
>>>>> 13:32.52
>>>>> 13:48.59
>>>>>
>>>>> DUT2:
>>>>> FUA:
>>>>> 8:11.24
>>>>> 7:47.73
>>>>> 7:48.00
>>>>> 7:48.18
>>>>> 7:47.38
>>>>> Cache, no FUA:
>>>>> 8:10.30
>>>>> 7:48.97
>>>>> 7:48.47
>>>>> 7:47.93
>>>>> 7:44.18
>>>>>
>>>>> DUT3:
>>>>> Cache, no FUA:
>>>>> 7:02.82
>>>>> 6:58.94
>>>>> 7:03.20
>>>>> 7:00.27
>>>>> 7:00.88
>>>>> FUA:
>>>>> 7:05.43
>>>>> 7:03.44
>>>>> 7:04.82
>>>>> 7:03.26
>>>>> 7:04.74
>>>>>
>>>>> DUT4:
>>>>> FUA:
>>>>> 7:23.92
>>>>> 7:20.15
>>>>> 7:20.52
>>>>> 7:19.10
>>>>> 7:20.71
>>>>> Cache, no FUA:
>>>>> 7:20.23
>>>>> 7:20.48
>>>>> 7:19.94
>>>>> 7:18.90
>>>>> 7:19.88
>>>>
>>>> Without going into the details of the above, it seems like for DUT1, DUT2, DUT3 and DUT4 there a good reasons to why we should move forward with $subject patch.
>>>>
>>>> Do you agree?
>>>
>>> That is a good question, that's why I just posted the data without further comment from my side.
>>> I was honestly expecting the difference to be much higher, given the original patch.
>>> If this is representative for most cards, you would require quite an unusual workload to actually notice the difference IMO.
>>> If there are cards where the difference is much more significant then of course a quirk would be nicer.
>>> On the other side I don't see why not and any improvement is a good one?
>>>
>>>>
>>>>>
>>>>> Cache, no FUA:
>>>>> 7:19.36
>>>>> 7:02.11
>>>>> 7:01.53
>>>>> 7:01.35
>>>>> 7:00.37
>>>>> Cache, no FUA CQE:
>>>>> 7:17.55
>>>>> 7:00.73
>>>>> 6:59.25
>>>>> 6:58.44
>>>>> 6:58.60
>>>>> FUA:
>>>>> 7:15.10
>>>>> 6:58.99
>>>>> 6:58.94
>>>>> 6:59.17
>>>>> 6:60.00
>>>>> FUA CQE:
>>>>> 7:11.03
>>>>> 6:58.04
>>>>> 6:56.89
>>>>> 6:56.43
>>>>> 6:56:28
>>>>>
>>>>> If anyone has any comments or disagrees with the benchmark, or has a specific eMMC to test, let me know.
>>>>
>>>> If I understand correctly, for DUT5, it seems like using FUA may be slightly better than just cache-flushing, right?
>>>
>>> That is correct, I specifically tested with this card as under the assumption that reliable write is without much additional cost, the DCMD would be slightly worse for performance and SYNC a bit worse.
>>>
>>>>
>>>> For CQE, it seems like FUA could be slightly even better, at least for DUT5.  Do you know if REQ_OP_FLUSH translates into MMC_ISSUE_DCMD or MMC_ISSUE_SYNC for your case? See mmc_cqe_issue_type().
>>> It is SYNC (this is sdhci-of-arasan on rk3399, no DCMD), but even SYNC is not too bad here it seems, could of course be worse if the workload was less sequential.
>>>
>>>>
>>>> When it comes to CQE, maybe Adrian have some additional thoughts around this? Perhaps we should keep using REQ_FUA, if we have CQE?
>>> Sure, I'm also interested in Adrian's take on this.
>>
>> Testing an arbitrary system and looking only at individual I/Os,
>> which may not be representative of any use-case, resulted in
>> FUA always winning, see below.
>>
>> All values are approximate and in microseconds.
>>
>>                 With FUA                Without FUA
>>
>> With CQE        Reliable Write  350     Write   125
>>                                         Flush   300
>>                 Total           350             425
>>
>> Without CQE     Reliable Write  350     Write   125
>>                 CMD13           100     CMD13   100
>>                                         Flush   300
>>                                         CMD13   100
>>                 Total           450             625
>>
>> FYI the test I was doing was:
>>
>>   # cat test.sh
>>         #!/bin/sh
>>
>>         echo "hi" > /mnt/mmc/hi.txt
>>
>>         sync
>>
>>
>>   # perf record --no-bpf-event -e mmc:* -a -- ./test.sh
>>   # perf script --ns --deltatime
>>
>>
>> The conclusion in this case would seem to be that CQE
>> makes the case for removing FUA less bad.
>>
>> Perhaps CQE is more common in newer eMMCs which in turn
>> have better FUA implementations.
> 
> Very interesting data - and thanks for helping out with tests!
> 
> A few observations and thoughts from the above.
> 
> 1)
> A "normal" use case would probably include additional writes (regular
> writes) and I guess that could impact the flushing behavior. Maybe the
> flushing becomes less heavy, if the device internally/occasionally
> needs to flush its cache anyway? Or - maybe it doesn't matter at all,
> because the reliable writes are triggering the cache to be flushed
> too.

The sync is presumably causing an EXT4 journal commit which
seems to use REQ_PREFLUSH and REQ_FUA. That is:
	Flush (the journal to media)
	Write (the commit record) (FUA)
So it does a flush anyway.  The no-FUA case is:
	Flush (the journal to media)
	Write (the commit record)
	Flush (the commit record)

> 
> 2)
> Assuming that a reliable write is triggering the internal cache to be
> flushed too, then we need less number of commands to be sent/acked to
> the eMMC - compared to not using FUA. This means less protocol
> overhead when using FUA - and perhaps that's what your tests is
> actually telling us?

There is definitely less protocol overhead because the no-FUA
case has to do an extra CMD6 (flush) and CMD13.

Note also, in this case auto-CMD23 is being used, which is why
is is not listed.

Using an older system (no CQE but also auto-CMD23), resulted
in a win for no-FUA:

		With FUA		Without FUA

		Reliable Write	1200	Write	 850
		CMD13		 100	CMD13	 100
					Flush	 120
					CMD13	  65
		Total		1300		1135


