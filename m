Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EE763E885
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLADqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLADqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:46:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4319B9F485;
        Wed, 30 Nov 2022 19:45:58 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1297Hh022941;
        Thu, 1 Dec 2022 03:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=E3oSv37GEd3ziErG13c7JSDdYOMAG0ny9Fwi0GjMsyE=;
 b=GYpZF4DFjxPwXqW5nzKvU7BYXLF9y169n7PfQ79rd7Jd6diDteyRXPKaqAb8Vn0j76B4
 HpfIiBX9su5V3QEWuGnLqzgKzhfeXDNlWazijdyu6XaTD+z/Er9RFBAetiZxf9+avM5O
 GXHDq0dVoCmdRFC4d4HBqOV9Z1TiF7qCcj7a3VhQr3s3EXxAqa6UjBpCnXeUwIi5d+M2
 y0p4PTBbaZZdolHonrq8OI/md457a2rZoP5P6Wqqrp8gBz6Sq8KCWVVpV/8yTm86jL9P
 xyoERw4koMWgG7nluvwYO5sEvum+qh6IZKole08rvZOIpPxL7KtDR0Hu8YV0l5yyPfxG ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xhtbnqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B1149H1007732;
        Thu, 1 Dec 2022 03:45:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2cu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbpp033801;
        Thu, 1 Dec 2022 03:45:53 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-16;
        Thu, 01 Dec 2022 03:45:53 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        dgilbert@interlog.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        error27@gmail.com, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org, harshit.m.mogalapalli@gmail.com,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH] scsi: scsi_debug: Fix a warning in resp_report_zones()
Date:   Thu,  1 Dec 2022 03:45:17 +0000
Message-Id: <166986602284.2101055.17478772586173934593.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112070612.2121535-1-harshit.m.mogalapalli@oracle.com>
References: <20221112070612.2121535-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=894 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010022
X-Proofpoint-GUID: 8SFQ-8Uz0Ft2Hh7FY8cY5Ai2y2-jH33y
X-Proofpoint-ORIG-GUID: 8SFQ-8Uz0Ft2Hh7FY8cY5Ai2y2-jH33y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 23:06:12 -0800, Harshit Mogalapalli wrote:

> As 'alloc_len' is user controlled data, if user tries to allocate memory
> larger than(>=) MAX_ORDER, then kcalloc() will fail, it creates a stack
> trace and messes up dmesg with a warning.
> 
> Add __GFP_NOWARN in order to avoid too large allocation warning.
> This is detected by static analysis using smatch.
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: scsi_debug: Fix a warning in resp_report_zones()
      https://git.kernel.org/mkp/scsi/c/07f2ca139d9a

-- 
Martin K. Petersen	Oracle Linux Engineering
