Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF993610C43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJ1Icl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJ1Icd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:32:33 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D1C17250C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666945953; x=1698481953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yGry/pWRS/1GiHAkDYvoBhKHjVKsf3tr/q6GIlXe/Vw=;
  b=O1d9Zg+MH5yoVm0jEBUkiuMupdstBorTVI5JtZCrUGO+brSUOnuB+MWy
   VJ95sXjidxjjRCVpxYevLNECmwaToPKd5Urohw5UYdFFjWtH+yF55iVeT
   kZlinAL+qMKp0JCwODt4t9uHFKtPezb3CvviwY65XN5SBDEzhZCJwD1QM
   zi6TDvjcA6y+S0f0EasFGk7iwrxQ4jvpWp9Nw+0dcEkAYae1lRBVYclG6
   k2cWBL0jNaEEGzxRKPyEzN6N7WtrjHunaTjCSyGgLk0Lo8PJyiUIB/A7f
   EqV0pISaqY8zCmDIaVsuRD6A4hENjXM99KWpUCcxEP4X4L8D3p8rfHdFI
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="215312272"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 16:32:30 +0800
IronPort-SDR: v0ezxqZwsoO3WESLl94/Tla/pLnvVwa7mAyb9HmSPL2JPeUYkA6a7+rZEKkaQWj6U7j082q6Vf
 pK3BZTDUrzU+SPrUphUadqFf0tN0+8QlhvDfhrGF2dsPMxdq+40NqrHUMCTfNO0H1BVuK61uoq
 eG0yo/STcc73LXf7IX1X+F1/61+Pw2mJffwY0KfqdXmU2i4/bFs3ZzUtjxx09oAqQy49jUuKJ8
 Oiu83QCjp9qo86TolAvy4w+tnaZhQqiaGC55n+HedXg33aHQyVJ7S1b/oW5Y4k0/KyJJ7BF3a/
 kC8CkP5kK3MlKcP4nbEA99Xe
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 00:51:50 -0700
IronPort-SDR: n6fxHrUlovb24PAoaFuxz+3ejpokf64cKBpR7guB4OGt1LHQd09osZhib78JD5Bij5W12T55gK
 DL++ueOiIKTcepHOdCYCmBoRV9zuiX/Vil3hzIQmyJMcoCw+M/fM43NGG/uS1x9hH6czjBnyqA
 lQ117x0VYJqhAbGkx3dMAXMioWHtow6LDf3Edmh3vrK2DMxxfwkBz6c4WulFnMY9TD9R+Hn8Rz
 re22tEhQCskhpl+NTbGbiZp1v0eAcwqPAFtFHhAl0TwSUnUVwz7eX/FVeERWwDwnXN/cZ+LpQP
 WSY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 01:26:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzFxx52YWz1Rx15
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:26:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666945588; x=1669537589; bh=yGry/pWRS/1GiHAkDYvoBhKHjVKsf3tr/q6
        GIlXe/Vw=; b=q5Sx/LtWSabxkzRGhwH2yAohQhHudeTrjwQgdk6dltsjzS9sU3h
        a6Tg3+16AlYQl+2o9vWTB9MribElyzuensUFfRWBCW16VLO1j72U4XrwTyIFZm0J
        7DWWAPxXiYP2co3w6i7Ci6CAGW3He/l14M7oia7xBpfnymCDpGQ4EJxmt896Q5Wx
        xpnC7xQIeVIHMUZFIDPJClDfbRosOJvpQ2YLJIdfxSyCYWIxiCYtpvQBgGHRtwIC
        A03UIkSEVBX2K/qYjBYtV7Fe1SAvCC5eaj0eTHyFENS11v/S0IrvRrBww3Pp3SVM
        z7JYCHwGZ4lHnjRH0UbcQ6UhDWuA+e8rbJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SAKAEaRd3YUf for <linux-kernel@vger.kernel.org>;
        Fri, 28 Oct 2022 01:26:28 -0700 (PDT)
Received: from [10.225.163.15] (unknown [10.225.163.15])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzFxs52r9z1RvLy;
        Fri, 28 Oct 2022 01:26:25 -0700 (PDT)
Message-ID: <0bb40ab2-2e80-44a5-79c2-fa4bfe2560d1@opensource.wdc.com>
Date:   Fri, 28 Oct 2022 17:26:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
        jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, john.garry2@mail.dcu.ie
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <3ef0347f-f3e2-cf08-2b27-f65a7afe82a2@suse.de>
 <ea0be367-a4e0-3cc2-c4c7-04d8db1714cd@huawei.com>
 <07028dac-d6cc-d707-db08-b92c365a6220@opensource.wdc.com>
 <a3fe8284-d002-36b0-7e09-67f132353088@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a3fe8284-d002-36b0-7e09-67f132353088@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 17:14, John Garry wrote:
> On 27/10/2022 23:35, Damien Le Moal wrote:
>>> At what stage do you want to send these commands? The tags for the shost
>>> are not setup until scsi_add_host() -> scsi_mq_setup_tags() is called,
>>> so can't expect blk-mq to manage reserved tags before then.
>>>
>>> If you are required to send commands prior to scsi_add_host(), then I
>>> suppose the low-level driver still needs to manage tags until the shost
>>> is ready. I guess that some very simple scheme can be used, like always
>>> use tag 0, since most probe is done serially per-host. But that's not a
>>> case which I have had to deal with yet.
>> In libata case, ata_dev_configure() will cause a lot of
>> ata_exec_internal_sg() calls for IDENTIFY and various READ LOG commands.
>> That is all done with non-ncq commands, which means that we do not require
>> a hw tag. But given that you are changing ata_exec_internal_sg() to call
>> alloc_request + blk_execute_rq_nowait(), how would these work without a
>> tag, at least a soft one ? Or we would need to keep the current code to
>> use ata_qc_issue() directly for probe time ? That will look very ugly...
>>
> 
> I am not sure if there is really a problem. So libata/libsas allocs the 
> shost quite early, and that is before we try using 
> ata_exec_internal_sg(). Also note that I added patch "ata: libata-scsi: 
> Allocate sdev early in port probe" so that we have ata_device.sdev ready 
> before issuing ata_exec_internal_sg() (sorry if I'm stating the obvious).
> 
> I think Hannes' issue is that some SCSI HBA driver needs to send 
> "internal" commands to probe the HW for info, and this would be before 
> shost is ready. He can tell us more.

OK. Understood.

> 
> Thanks,
> John

-- 
Damien Le Moal
Western Digital Research

