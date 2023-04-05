Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919B46D74E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbjDEHAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbjDEHA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:00:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABE84699;
        Wed,  5 Apr 2023 00:00:26 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3353g7FC017906;
        Wed, 5 Apr 2023 07:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=WhX9kyf59A7W1aOb1gcxDDuy8pHkui7xJb5gVdN4KKA=;
 b=j7vLHUr6/2Hh7TOLlgCJTlyv5Ao3J8nuurYRft3juUaFw28ROP3oaa9fXtTc516A/gUy
 GQywL/GxTz4Ai1E4YjfgIsseWxjgBCUqGcT5V0sM2wZ+G8XxThmJpX8I7zgha0u2LSlc
 3Le2s43ueGWavzc42C6tDuQH00BlnqFZCKYssVpqXu6n0aQrpNfZed0Lr1TxeM8RmNRS
 pRzHLAYl9Hz4va70VJh8Y3N596xaGX9eRm2hSiYD1gh4ihI/1t1n1pLZ4Ot+a8BSQBtO
 uJY9zoLh2a6/BjprunY2R6Bx+njS//T9DUXMBoAMnOW0N+DVOrB3lcjy08yeTq3YK3QR Yg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prnvg21cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 07:00:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335706Bk018385
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 07:00:06 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 00:00:04 -0700
Date:   Wed, 5 Apr 2023 12:30:00 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yifan Li <yifan2.li@intel.com>
Subject: Re: [PATCH] PM: hibernate: Do not get block device exclusively in
 test_resume mode
Message-ID: <20230405070000.GA720822@hu-pkondeti-hyd.qualcomm.com>
References: <20230401165540.322665-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230401165540.322665-1-yu.c.chen@intel.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WiKE9azftCmlOVHp8v1s51x7PXTTbXMa
X-Proofpoint-ORIG-GUID: WiKE9azftCmlOVHp8v1s51x7PXTTbXMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_02,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050064
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 12:55:40AM +0800, Chen Yu wrote:
> The system refused to do a test_resume because it found that the
> swap device has already been taken by someone else. Specificly,
> the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
> do this check.
> 
> Steps to reproduce:
>  dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo | 
>        awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
>  mkswap /swapfile
>  swapon /swapfile
>  swap-offset /swapfile
>  echo 34816 > /sys/power/resume_offset
>  echo test_resume > /sys/power/disk
>  echo disk > /sys/power/state
> 
>  PM: Using 3 thread(s) for compression
>  PM: Compressing and saving image data (293150 pages)...
>  PM: Image saving progress:   0%
>  PM: Image saving progress:  10%
>  ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  ata1.00: configured for UDMA/100
>  ata2: SATA link down (SStatus 0 SControl 300)
>  ata5: SATA link down (SStatus 0 SControl 300)
>  ata6: SATA link down (SStatus 0 SControl 300)
>  ata3: SATA link down (SStatus 0 SControl 300)
>  ata4: SATA link down (SStatus 0 SControl 300)
>  PM: Image saving progress:  20%
>  PM: Image saving progress:  30%
>  PM: Image saving progress:  40%
>  PM: Image saving progress:  50%
>  pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
>  PM: Image saving progress:  60%
>  PM: Image saving progress:  70%
>  PM: Image saving progress:  80%
>  PM: Image saving progress:  90%
>  PM: Image saving done
>  PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
>  PM: S|
>  PM: hibernation: Basic memory bitmaps freed
>  PM: Image not found (code -16)
> 
> This is because when using the swapfile as the hibernation storage,
> the block device where the swapfile is located has already been mounted
> by the OS distribution(usually been mounted as the rootfs). This is not
> an issue for normal hibernation, because software_resume()->swsusp_check()
> happens before the block device(rootfs) mount. But it is a problem for the
> test_resume mode. Because when test_resume happens, the block device has
> been mounted already.
> 
> Thus remove the FMODE_EXCL for test_resume mode. This would not be a
> problem because in test_resume stage, the processes have already been
> frozen, and the race condition described in
> Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> is unlikely to happen.
> 
> Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> Reported-by: Yifan Li <yifan2.li@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/power/hibernate.c | 18 +++++++++++-------
>  kernel/power/power.h     |  2 +-
>  kernel/power/swap.c      | 10 +++++++---
>  3 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 793c55a2becb..f50456e72f0a 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -683,22 +683,26 @@ static void power_down(void)
>  		cpu_relax();
>  }
>  
> -static int load_image_and_restore(void)
> +static int load_image_and_restore(bool safe)
>  {
> +	fmode_t mode = FMODE_READ;
>  	int error;
>  	unsigned int flags;
>  
>  	pm_pr_dbg("Loading hibernation image.\n");
>  
> +	if (!safe)
> +		mode |= FMODE_EXCL;
> +
>  	lock_device_hotplug();
>  	error = create_basic_memory_bitmaps();
>  	if (error) {
> -		swsusp_close(FMODE_READ | FMODE_EXCL);
> +		swsusp_close(mode);
>  		goto Unlock;
>  	}
>  
>  	error = swsusp_read(&flags);
> -	swsusp_close(FMODE_READ | FMODE_EXCL);
> +	swsusp_close(mode);
>  	if (!error)
>  		error = hibernation_restore(flags & SF_PLATFORM_MODE);
>  
> @@ -785,9 +789,9 @@ int hibernate(void)
>  	unlock_device_hotplug();
>  	if (snapshot_test) {
>  		pm_pr_dbg("Checking hibernation image\n");
> -		error = swsusp_check();
> +		error = swsusp_check(true);
>  		if (!error)
> -			error = load_image_and_restore();
> +			error = load_image_and_restore(true);
>  	}
>  	thaw_processes();
>  
> @@ -983,7 +987,7 @@ static int software_resume(void)
>  		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
>  
>  	pm_pr_dbg("Looking for hibernation image.\n");
> -	error = swsusp_check();
> +	error = swsusp_check(false);
>  	if (error)
>  		goto Unlock;
>  
> @@ -1011,7 +1015,7 @@ static int software_resume(void)
>  		goto Close_Finish;
>  	}
>  
> -	error = load_image_and_restore();
> +	error = load_image_and_restore(false);
>  	thaw_processes();
>   Finish:
>  	pm_notifier_call_chain(PM_POST_RESTORE);
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index b4f433943209..66a7595ad3e7 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -173,7 +173,7 @@ extern int swsusp_swap_in_use(void);
>  #define SF_HW_SIG		8
>  
>  /* kernel/power/hibernate.c */
> -extern int swsusp_check(void);
> +extern int swsusp_check(bool safe);
>  extern void swsusp_free(void);
>  extern int swsusp_read(unsigned int *flags_p);
>  extern int swsusp_write(unsigned int flags);
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 36a1df48280c..1be0257da8ab 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1514,13 +1514,17 @@ int swsusp_read(unsigned int *flags_p)
>   *      swsusp_check - Check for swsusp signature in the resume device
>   */
>  
> -int swsusp_check(void)
> +int swsusp_check(bool safe)
>  {
> +	fmode_t mode = FMODE_READ;
>  	int error;
>  	void *holder;
>  
> +	if (!safe)
> +		mode |= FMODE_EXCL;
> +
>  	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
> -					    FMODE_READ | FMODE_EXCL, &holder);
> +					    mode, &holder);
>  	if (!IS_ERR(hib_resume_bdev)) {
>  		set_blocksize(hib_resume_bdev, PAGE_SIZE);
>  		clear_page(swsusp_header);
> @@ -1547,7 +1551,7 @@ int swsusp_check(void)
>  
>  put:
>  		if (error)
> -			blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
> +			blkdev_put(hib_resume_bdev, mode);
>  		else
>  			pr_debug("Image signature found, resuming\n");
>  	} else {

The patch looks good to me and it works. I have just one
question/comment.

What is "safe" here? Because I worked on this problem [1], so I
understood it. but it is not very clear / explicit. One approach I
thought would be to the codepaths aware of "test_resume" via a
global variable called "snapshot_testing" similar to freezer_test_done.
if snapshot_testing is true, don't use exclusive flags.

Thanks,
Pavan

