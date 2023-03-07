Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E7D6ADC06
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCGKde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCGKdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:33:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA046195;
        Tue,  7 Mar 2023 02:32:32 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3278kgIu028652;
        Tue, 7 Mar 2023 10:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pp1; bh=+pkEcBhDX7653P4CgydRWh+nO8hBvA2oBpE7vIGSOY8=;
 b=jKrHW8txiPnT4lgmdT/ergByxJ+ttompPYwaSualxsvkt/Hl/PDUfSwtdObvPluh5nA2
 bBeAohQ9B2sWlia3RViKmTGHFvfn8UhqmCPlL/Pi8qeB8oRenfw3tmiyqMVl/CEAxD7Q
 QhrgDzLX59fO3U+AllTuMasUeE/uA3Is5rMgSwiF1g/yCQ9Nill85HhX2DacVt/pQKG0
 dF8SYwqg+MYjPByBdfS9WaYv9C6ShNIUo7UBZ52ctbqe6CJ3CZdkcp7WxWMnXRAFrikm
 lw71hhhBAaRufOCASa+h7xtnqvIbtMJxXNvvNLPpEpAB7xb+KzD4M1Iw0My6QcMhYafG lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4ysekr19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 10:32:21 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3279uCiQ028541;
        Tue, 7 Mar 2023 10:32:21 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4ysekr07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 10:32:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3271Ojd2005745;
        Tue, 7 Mar 2023 10:32:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p41brc3j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 10:32:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 327AWGCD39059878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 10:32:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EA4320043;
        Tue,  7 Mar 2023 10:32:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F4C920040;
        Tue,  7 Mar 2023 10:32:14 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Tue,  7 Mar 2023 10:32:14 +0000 (GMT)
Date:   Tue, 7 Mar 2023 16:02:13 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Lee Duncan <leeman.duncan@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Duncan <lduncan@suse.com>, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
Message-ID: <20230307103213.GA1005120@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
 <88927435-ae58-c24b-e7b7-b675985de433@leemhuis.info>
 <86D685F2-D411-460B-A09B-6BE942372F0A@gmail.com>
 <yq1zg8pl1nq.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <yq1zg8pl1nq.fsf@ca-mkp.ca.oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oaQB3v3l3wz0LKU3agbe5k4sXfoFBVSn
X-Proofpoint-GUID: eRvwFxqcGhOo7TEa-KxFXtMofFzJRTyl
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_04,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin K. Petersen <martin.petersen@oracle.com> [2023-03-06 21:54:42]:

Hi Martin,
> 
> Lee,
> 
> > I really prefer specifically listing ???offending??? hardware, rather than
> > automatically covering for it.
> 
> Would the following patch work?
> 

Yes, this patch also works atleast for me.

> Martin
> 
> ---8<---
> 
> Subject: [PATCH] scsi: core: Add BLIST_NO_VPD_SIZE for some VDASD
> 
> Some storage, such as AIX VDASD (virtual storage) and IBM 2076 (front
> end) do not like commit c92a6b5d6335 ("scsi: core: Query VPD size
> before getting full page").
> 
> That commit changed getting SCSI VPD pages so that we now read just
> enough of the page to get the actual page size, then read the whole
> page in a second read. The problem is that the above mentioned
> hardware returns zero for the page size, because of a firmware
> error. In such cases, until the firmware is fixed, this new blacklist
> flag says to revert to the original method of reading the VPD pages,
> i.e. try to read as a whole buffer's worth on the first try.
> 
> [mkp: reworked somewhat]
> 
> Link: https://lore.kernel.org/r/20220928181350.9948-1-leeman.duncan@gmail.com
> Fixes: c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")
> Reported-by: Martin Wilck <mwilck@suse.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Lee Duncan <lduncan@suse.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 9feb0323bc44..dff1d692e756 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -326,6 +326,9 @@ static int scsi_get_vpd_size(struct scsi_device *sdev, u8 page)
>  	unsigned char vpd_header[SCSI_VPD_HEADER_SIZE] __aligned(4);
>  	int result;
>  
> +	if (sdev->no_vpd_size)
> +		return SCSI_DEFAULT_VPD_LEN;
> +
>  	/*
>  	 * Fetch the VPD page header to find out how big the page
>  	 * is. This is done to prevent problems on legacy devices
> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> index c7080454aea9..bc9d280417f6 100644
> --- a/drivers/scsi/scsi_devinfo.c
> +++ b/drivers/scsi/scsi_devinfo.c
> @@ -134,7 +134,7 @@ static struct {
>  	{"3PARdata", "VV", NULL, BLIST_REPORTLUN2},
>  	{"ADAPTEC", "AACRAID", NULL, BLIST_FORCELUN},
>  	{"ADAPTEC", "Adaptec 5400S", NULL, BLIST_FORCELUN},
> -	{"AIX", "VDASD", NULL, BLIST_TRY_VPD_PAGES},
> +	{"AIX", "VDASD", NULL, BLIST_TRY_VPD_PAGES | BLIST_NO_VPD_SIZE},
>  	{"AFT PRO", "-IX CF", "0.0>", BLIST_FORCELUN},
>  	{"BELKIN", "USB 2 HS-CF", "1.95",  BLIST_FORCELUN | BLIST_INQUIRY_36},
>  	{"BROWNIE", "1200U3P", NULL, BLIST_NOREPORTLUN},
> @@ -188,6 +188,7 @@ static struct {
>  	{"HPE", "OPEN-", "*", BLIST_REPORTLUN2 | BLIST_TRY_VPD_PAGES},
>  	{"IBM", "AuSaV1S2", NULL, BLIST_FORCELUN},
>  	{"IBM", "ProFibre 4000R", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
> +	{"IBM", "2076", NULL, BLIST_NO_VPD_SIZE},
>  	{"IBM", "2105", NULL, BLIST_RETRY_HWERROR},
>  	{"iomega", "jaz 1GB", "J.86", BLIST_NOTQ | BLIST_NOLUN},
>  	{"IOMEGA", "ZIP", NULL, BLIST_NOTQ | BLIST_NOLUN},
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index f9b18fdc7b3c..6042a5587bc3 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1055,6 +1055,9 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
>  	else if (*bflags & BLIST_SKIP_VPD_PAGES)
>  		sdev->skip_vpd_pages = 1;
>  
> +	if (*bflags & BLIST_NO_VPD_SIZE)
> +		sdev->no_vpd_size = 1;
> +
>  	transport_configure_device(&sdev->sdev_gendev);
>  
>  	if (sdev->host->hostt->slave_configure) {
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index 3642b8e3928b..15169d75c251 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -145,6 +145,7 @@ struct scsi_device {
>  	const char * model;		/* ... after scan; point to static string */
>  	const char * rev;		/* ... "nullnullnullnull" before scan */
>  
> +#define SCSI_DEFAULT_VPD_LEN	255	/* default SCSI VPD page size (max) */
>  	struct scsi_vpd __rcu *vpd_pg0;
>  	struct scsi_vpd __rcu *vpd_pg83;
>  	struct scsi_vpd __rcu *vpd_pg80;
> @@ -215,6 +216,7 @@ struct scsi_device {
>  					 * creation time */
>  	unsigned ignore_media_change:1; /* Ignore MEDIA CHANGE on resume */
>  	unsigned silence_suspend:1;	/* Do not print runtime PM related messages */
> +	unsigned no_vpd_size:1;		/* No VPD size reported in header */
>  
>  	unsigned int queue_stopped;	/* request queue is quiesced */
>  	bool offline_already;		/* Device offline message logged */
> diff --git a/include/scsi/scsi_devinfo.h b/include/scsi/scsi_devinfo.h
> index 5d14adae21c7..6b548dc2c496 100644
> --- a/include/scsi/scsi_devinfo.h
> +++ b/include/scsi/scsi_devinfo.h
> @@ -32,7 +32,8 @@
>  #define BLIST_IGN_MEDIA_CHANGE	((__force blist_flags_t)(1ULL << 11))
>  /* do not do automatic start on add */
>  #define BLIST_NOSTARTONADD	((__force blist_flags_t)(1ULL << 12))
> -#define __BLIST_UNUSED_13	((__force blist_flags_t)(1ULL << 13))
> +/* do not ask for VPD page size first on some broken targets */
> +#define BLIST_NO_VPD_SIZE	((__force blist_flags_t)(1ULL << 13))
>  #define __BLIST_UNUSED_14	((__force blist_flags_t)(1ULL << 14))
>  #define __BLIST_UNUSED_15	((__force blist_flags_t)(1ULL << 15))
>  #define __BLIST_UNUSED_16	((__force blist_flags_t)(1ULL << 16))
> @@ -74,8 +75,7 @@
>  #define __BLIST_HIGH_UNUSED (~(__BLIST_LAST_USED | \
>  			       (__force blist_flags_t) \
>  			       ((__force __u64)__BLIST_LAST_USED - 1ULL)))
> -#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_13 | \
> -			     __BLIST_UNUSED_14 | \
> +#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_14 | \
>  			     __BLIST_UNUSED_15 | \
>  			     __BLIST_UNUSED_16 | \
>  			     __BLIST_UNUSED_24 | \

-- 
Thanks and Regards
Srikar Dronamraju
