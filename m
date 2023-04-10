Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DEA6DC3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjDJGw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 02:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDJGwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 02:52:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBBB359C;
        Sun,  9 Apr 2023 23:52:54 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33A5p4ep032584;
        Mon, 10 Apr 2023 06:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=AdTqV1LnkiqTJqJ3WLEqQ1447PfvQcPkkAZmyMzUECM=;
 b=TZJTWHqhDWONIW/RrFP19pMLIS3bYl1uoeHo8sog5OP1ePfd7rXTtTetpeb80sqBKoEK
 kWj4F7W1wpgKKbNX+TC9QpDbXKgwE6gsjUbvT1OqDI3ttXGTB3p6stMFQyeUKZIB8DQE
 ylPy3Gn5aOzuO0jPKWIuTYT82z49e62AV/7ZqfAZB4KLYRlvQIlrX4a27mZGu7lInTfa
 1Wkq6kDl+Fu5yNHcmYCi3hsPdUIf+u6L5aaZvKZiYBLQ7eY0B5dnm4r4gU71BKwvV/Zg
 YFJ9pMblYLHkwP/j+obfI9W4LZPu2NiYytdX0Bz4mb/VaR4Nnw1+ycsywQIao3/YGNyr pg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pu0c32ceu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 06:52:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33A6qIgx014557
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 06:52:18 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 9 Apr 2023 23:52:15 -0700
Date:   Mon, 10 Apr 2023 12:22:11 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yifan Li <yifan2.li@intel.com>
Subject: Re: [PATCH] PM: hibernate: Do not get block device exclusively in
 test_resume mode
Message-ID: <20230410065211.GA3638819@hu-pkondeti-hyd.qualcomm.com>
References: <20230401165540.322665-1-yu.c.chen@intel.com>
 <CAJZ5v0j704JoCPTrDO1jTHwP1+8NVdLk7hym5036uFcfo7YHXQ@mail.gmail.com>
 <ZC4zMv1SCiUMbcqs@chenyu5-mobl1>
 <CAJZ5v0j5PWsF6zCCVMRW59WevYLvWiBk82U4MpxqWdFnAcrqrQ@mail.gmail.com>
 <ZDLL0SI87x9a/qvB@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDLL0SI87x9a/qvB@chenyu5-mobl1>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rNXBgaVzK-LtG0Dzx_oMXSqrFDAnFZqm
X-Proofpoint-ORIG-GUID: rNXBgaVzK-LtG0Dzx_oMXSqrFDAnFZqm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_04,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100058
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2023 at 10:29:37PM +0800, Chen Yu wrote:
> On 2023-04-06 at 12:02:01 +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 6, 2023 at 4:49 AM Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > Hi Rafael,
> > > On 2023-04-05 at 20:37:32 +0200, Rafael J. Wysocki wrote:
> > > > On Sat, Apr 1, 2023 at 10:59 AM Chen Yu <yu.c.chen@intel.com> wrote:
> > > > >
> > > > > The system refused to do a test_resume because it found that the
> > > > > swap device has already been taken by someone else. Specificly,
> > > > > the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
> > > > > do this check.
> > > > >
> > > > > Steps to reproduce:
> > > > >  dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo |
> > > > >        awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
> > > > >  mkswap /swapfile
> > > > >  swapon /swapfile
> > > > >  swap-offset /swapfile
> > > > >  echo 34816 > /sys/power/resume_offset
> > > > >  echo test_resume > /sys/power/disk
> > > > >  echo disk > /sys/power/state
> > > > >
> > > > >  PM: Using 3 thread(s) for compression
> > > > >  PM: Compressing and saving image data (293150 pages)...
> > > > >  PM: Image saving progress:   0%
> > > > >  PM: Image saving progress:  10%
> > > > >  ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > > > >  ata1.00: configured for UDMA/100
> > > > >  ata2: SATA link down (SStatus 0 SControl 300)
> > > > >  ata5: SATA link down (SStatus 0 SControl 300)
> > > > >  ata6: SATA link down (SStatus 0 SControl 300)
> > > > >  ata3: SATA link down (SStatus 0 SControl 300)
> > > > >  ata4: SATA link down (SStatus 0 SControl 300)
> > > > >  PM: Image saving progress:  20%
> > > > >  PM: Image saving progress:  30%
> > > > >  PM: Image saving progress:  40%
> > > > >  PM: Image saving progress:  50%
> > > > >  pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
> > > > >  PM: Image saving progress:  60%
> > > > >  PM: Image saving progress:  70%
> > > > >  PM: Image saving progress:  80%
> > > > >  PM: Image saving progress:  90%
> > > > >  PM: Image saving done
> > > > >  PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
> > > > >  PM: S|
> > > > >  PM: hibernation: Basic memory bitmaps freed
> > > > >  PM: Image not found (code -16)
> > > > >
> > > > > This is because when using the swapfile as the hibernation storage,
> > > > > the block device where the swapfile is located has already been mounted
> > > > > by the OS distribution(usually been mounted as the rootfs). This is not
> > > > > an issue for normal hibernation, because software_resume()->swsusp_check()
> > > > > happens before the block device(rootfs) mount. But it is a problem for the
> > > > > test_resume mode. Because when test_resume happens, the block device has
> > > > > been mounted already.
> > > > >
> > > > > Thus remove the FMODE_EXCL for test_resume mode. This would not be a
> > > > > problem because in test_resume stage, the processes have already been
> > > > > frozen, and the race condition described in
> > > > > Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > > > > is unlikely to happen.
> > > > >
> > > > > Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > > > > Reported-by: Yifan Li <yifan2.li@intel.com>
> > > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > > ---
> > > > >  kernel/power/hibernate.c | 18 +++++++++++-------
> > > > >  kernel/power/power.h     |  2 +-
> > > > >  kernel/power/swap.c      | 10 +++++++---
> > > > >  3 files changed, 19 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > > > index 793c55a2becb..f50456e72f0a 100644
> > > > > --- a/kernel/power/hibernate.c
> > > > > +++ b/kernel/power/hibernate.c
> > > > > @@ -683,22 +683,26 @@ static void power_down(void)
> > > > >                 cpu_relax();
> > > > >  }
> > > > >
> > > > > -static int load_image_and_restore(void)
> > > > > +static int load_image_and_restore(bool safe)
> > > >
> > > > It is not very clear why the argument is called "safe".
> > > >
> > > > Either this needs to be explained in a comment, or I would just call
> > > > it "exclusive" and rework the checks accordingly.
> > > >
> > > OK, I can change it to "exclusive". Pavan proposed to add a global
> > > variable snapshot_testing to indicate that the system is in test_resume mode,
> > > and we can check this flag to decide whether to open the block device
> > > exclusively or not. Then we don't have to add parameter for load_image_and_restore()
> > > nor swsusp_check(). Could you please give advice whether this is applicable?
> > 
> > Well, in that case, why don't you simply check pm_test_level?
> >
> After rethink about this further, it seems that the global variable snapshot_testing
> can not present the race condition described in 39fbef4b0f77 in a corner case, if
> we do like this:
> 
>      1. echo test_resume > /sys/power/disk
>      2. mkfs.ext4 -O mmp  /dev/sda -b 1024
>      3. mount /dev/sda /home/test
>      4. echo "/dev/sda" > /sys/power/resume
>  
> We will still see the kernel crash, because in step4, the software_resume()
> will open swap device non-exclusively because step1 has enabled snapshot_testing.
> 
> That is to say, to avoid the race condition, we should let software_resume() open
> the swap device exclusively no matter what the hibernation mode is.
> 
> Maybe fall back to add "exclusive" flag for load_image_and_restore()
> and swsusp_check() is simpler.
> 
> Pavan, what do you think?
> 
Right, If we directly use (hibernation_mode == HIBERNATION_TEST_RESUME)
condition, it would be a problem. I was saying, snapshot_test which
is a local variable in hibernate() needs to be made global so that
block device open / close can use flags approriately. Onething I did not
like was passing flags to swsusp_close(). Thats the reason for me
to cache the flags while opening the block device and using it in
the swsusp_close().

Thanks,
Pavan
