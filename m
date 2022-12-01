Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00263E890
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiLADrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLADqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:46:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7796F9FA8C;
        Wed, 30 Nov 2022 19:46:04 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B11PAip017406;
        Thu, 1 Dec 2022 03:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=WEhVC477wNMw1d+bAnHN+IN4sbazPLMH070IA2JkQRI=;
 b=bPN5C7GwSEknP5lj//89W43OGi4b55fzKkS4mevBKhVYIb02gKnoVSFl8kCVCsqnIIYF
 QdzeSoc1MD3a7rODmHsk3DSlJCVWP6ApjV7c+Jy8Zg5mv8S9AfccZgMEhpFrD41im7MM
 kUvZErPJFOieCs7lap1RLfWDjPoJfRo7gYF8P9uIt4vHzrwGewFdtur+XFmM/4HgOTSv
 wb1wSJ2nAQ5W/K/H3RUVHeCGJwvZYIlgRXdmMRSQ4Esc4Jgi8PCCvfZbI3SXBjNyuSca
 Vdh0dPhk3jAx51gGxyAIPvwOx2pH7pLgWUmOimAuWVFlUpNKlC7n0EiQ8iM87Edrchn3 eQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y43epc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B12Vj5W007630;
        Thu, 1 Dec 2022 03:45:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2ctc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:52 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbpn033801;
        Thu, 1 Dec 2022 03:45:52 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-15;
        Thu, 01 Dec 2022 03:45:52 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Chris Leech <cleech@redhat.com>, linux-scsi@vger.kernel.org,
        Wenchao Hao <haowenchao@huawei.com>,
        Lee Duncan <lduncan@suse.com>, open-iscsi@googlegroups.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v3 0/2] Fix scsi device's iodone_cnt mismatch with iorequest_cnt
Date:   Thu,  1 Dec 2022 03:45:16 +0000
Message-Id: <166986602274.2101055.6269524051761428499.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123122137.150776-1-haowenchao@huawei.com>
References: <20221123122137.150776-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010022
X-Proofpoint-GUID: NY5ovK0SUI2ABWWDewUWpoaYcDKTdGgF
X-Proofpoint-ORIG-GUID: NY5ovK0SUI2ABWWDewUWpoaYcDKTdGgF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 20:21:35 +0800, Wenchao Hao wrote:

> Following scenario would make scsi_device's iodone_cnt mismatch with
> iorequest_cnt even if there is no request on this device any more.
> 
> 1. request timeout happened. If we do not retry the timeouted command,
>    this command would be finished in scsi_finish_command() which would
>    not increase the iodone_cnt; if the timeouted command is retried,
>    another increasement for iorequest_cnt would be performed, the
>    command might add iorequest_cnt for multiple times but iodone_cnt
>    only once. Increase iodone_cnt in scsi_timeout() can handle this
>    scenario.
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/2] scsi: increase scsi device's iodone_cnt in scsi_timeout()
      https://git.kernel.org/mkp/scsi/c/ec9780e48c77
[2/2] scsi: donot increase scsi_device's iorequest_cnt if dispatch failed
      https://git.kernel.org/mkp/scsi/c/cfee29ffb45b

-- 
Martin K. Petersen	Oracle Linux Engineering
