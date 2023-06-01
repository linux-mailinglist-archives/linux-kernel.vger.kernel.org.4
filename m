Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18BC718FA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFAAo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAAoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:44:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111EB180;
        Wed, 31 May 2023 17:44:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKMq59032547;
        Thu, 1 Jun 2023 00:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=DwlCJOrdcwDOpNkwjccWqX8sLlYnPGR/xoGvu6B5/Jo=;
 b=ThA2s8vBavRkrnImgl8oR90Jf1oH1xFKNJNqqAQ7/a9yy11S446TXYma8Iov7VV7TUTz
 BmcmZ1hd4jZcmmF7vfKHxJOmyKB+++2X1qzDq2cKl6s1hQAaNyeHvE9UVQvtmFU8HlaD
 bBdyFUOZvKKqPkbmEZFsKvhatm7mLLoyD36jaTu0xd1/C/SMw8BVry2Ru8PJcEzRUhKn
 x2m2uGPAdOYh8XIXfF9NjkDvwIPAtyvgjolFZTF1C616Be+FuwFwLwGp+ocLqOEgL8SK
 4WBahuC/foID0jV+4ubt2bXT+f8GHqKOzRNejZ/CO3CwRwMKizIQqB5qkB3Ymp84wdmd 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb97d74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:43:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VNQ8NO004399;
        Thu, 1 Jun 2023 00:43:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ye2eb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:43:34 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3510hV9N008516;
        Thu, 1 Jun 2023 00:43:34 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qv4ye2e6s-4;
        Thu, 01 Jun 2023 00:43:34 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Gerd Knorr <kraxel@bytesex.org>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>, dc395x@twibble.org,
        James Smart <james.smart@broadcom.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        megaraidlinux.pdl@broadcom.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 00/11] Documentation/scsi: organize SCSI docs & make more readable
Date:   Wed, 31 May 2023 20:43:13 -0400
Message-Id: <168558000067.2461197.10750328689572620807.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518212749.18266-1-rdunlap@infradead.org>
References: <20230518212749.18266-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010004
X-Proofpoint-GUID: YOalXPWJ9zyKACfXifjcLWKGlvVbE_3r
X-Proofpoint-ORIG-GUID: YOalXPWJ9zyKACfXifjcLWKGlvVbE_3r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 14:27:38 -0700, Randy Dunlap wrote:

> Organize the SCSI documentation into categories instead of
> alphabetically by filename.
> 
> Modify several of the document chapter headings so that they are
> shorter and easier to find.
> 
> Make several updates to the scsi-generic driver documentation.
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[01/11] Docs/scsi: organize the SCSI documentation
        https://git.kernel.org/mkp/scsi/c/682b07d2ff54
[02/11] Docs/scsi: introduction: multiple cleanups
        https://git.kernel.org/mkp/scsi/c/c4e672ac8c49
[03/11] Docs/scsi: arcmsr: use a chapter heading for clarity
        https://git.kernel.org/mkp/scsi/c/1d3e21238f50
[04/11] Docs/scsi: scsi-changer: shorten the chapter heading
        https://git.kernel.org/mkp/scsi/c/a292835f69c6
[05/11] Docs/scsi: dc395x: shorten the chapter heading
        https://git.kernel.org/mkp/scsi/c/573a43f26d80
[06/11] Docs/scsi: scsi_fc_transport: fix typo in heading
        https://git.kernel.org/mkp/scsi/c/66fcd6026c71
[07/11] Docs/scsi: scsi-generic: multiple cleanups
        https://git.kernel.org/mkp/scsi/c/8ebddfeef518
[08/11] Docs/scsi: g_NCR5380: shorten chapter heading
        https://git.kernel.org/mkp/scsi/c/b636a0297e4f
[09/11] Docs/scsi: megaraid: clarify chapter heading
        https://git.kernel.org/mkp/scsi/c/0176d3395a3a
[10/11] Docs/scsi: ncr53c8xx: shorten chapter heading
        https://git.kernel.org/mkp/scsi/c/7c891fe3db3a
[11/11] Docs/scsi: sym53c8xx_2: shorten chapter heading
        https://git.kernel.org/mkp/scsi/c/f047d1e38bdf

-- 
Martin K. Petersen	Oracle Linux Engineering
