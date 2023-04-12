Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566456DE93E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDLCFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDLCFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:05:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D52359A;
        Tue, 11 Apr 2023 19:05:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BLUciZ005413;
        Wed, 12 Apr 2023 02:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=W8vGydgUvjrCywwSbWtn1UNryyg3b13UX0vMQmMhLTQ=;
 b=qNU9Ny9HS5RQPrJEGKAbL9WBkgBwFB2Rn51e5hwa1GwR4W0OXrGWkUkGeOG27LTKEoM+
 thvorJXL2V3nPcZlAPCBCg4E0F2MC5wExhNxp90wJfBrQ4tZlDJ6yP8gfvyYknXaV8M2
 RZ8uCuvMf5OjtPuqaAOKfx9/Fia9KAnF7dB7+M87PwT4/hfTpilsffjFDcXyestz7PSm
 z5mpcduIEs16QwsrxM9cZA+8dyddBtRC/3bn07owoSSX8kcnA7azce9AY998dnQhG7Yt
 pG16zqKl0lDs3ngkxQUG0VrLsEF3B36Dzu3KHx7ThpjeBrmtqh5ZUNXnHm6l9kdVq3JT EA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0e7evcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 02:05:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNngHl008122;
        Wed, 12 Apr 2023 02:05:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwc54tu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 02:05:00 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33C24xeQ031283;
        Wed, 12 Apr 2023 02:05:00 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3puwc54tqc-3;
        Wed, 12 Apr 2023 02:05:00 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org
Subject: Re: [PATCH v3 00/11] Fix shost command overloading issues
Date:   Tue, 11 Apr 2023 22:04:43 -0400
Message-Id: <168126077058.185856.3052034580683985910.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120016
X-Proofpoint-ORIG-GUID: NtY46ePqS2Ota4-hgPsDNZzHSHkJG8Tc
X-Proofpoint-GUID: NtY46ePqS2Ota4-hgPsDNZzHSHkJG8Tc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 07:42:59 +0000, John Garry wrote:

> It's easy to get scsi_debug to error on throughput testing when we have
> multiple shosts:
> 
> $ lsscsi
> [7:0:0:0]       disk    Linux   scsi_debug      0191
> [0:0:0:0]       disk    Linux   scsi_debug      0191
> 
> [...]

Applied to 6.4/scsi-queue, thanks!

[01/11] scsi: scsi_debug: Fix check for sdev queue full
        https://git.kernel.org/mkp/scsi/c/6500d2045d52
[02/11] scsi: scsi_debug: Don't iter all shosts in clear_luns_changed_on_target()
        https://git.kernel.org/mkp/scsi/c/00f9d622e8b2
[03/11] scsi: scsi_debug: Change shost list lock to a mutex
        https://git.kernel.org/mkp/scsi/c/0aaa3fad4fd9
[04/11] scsi: scsi_debug: Protect block_unblock_all_queues() with mutex
        https://git.kernel.org/mkp/scsi/c/25b80b2c7582
[05/11] scsi: scsi_debug: Use scsi_block_requests() to block queues
        https://git.kernel.org/mkp/scsi/c/a0473bf31df5
[06/11] scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd
        https://git.kernel.org/mkp/scsi/c/1107c7b24ee3
[07/11] scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in sdebug_blk_mq_poll()
        https://git.kernel.org/mkp/scsi/c/600d9ead3936
[08/11] scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in stop_all_queued()
        https://git.kernel.org/mkp/scsi/c/9c559c9b4748
[09/11] scsi: scsi_debug: Use scsi_host_busy() in delay_store() and ndelay_store()
        https://git.kernel.org/mkp/scsi/c/12f3eef016ea
[10/11] scsi: scsi_debug: Only allow sdebug_max_queue be modified when no shosts
        https://git.kernel.org/mkp/scsi/c/57f7225a4fe2
[11/11] scsi: scsi_debug: Drop sdebug_queue
        https://git.kernel.org/mkp/scsi/c/f1437cd1e535

-- 
Martin K. Petersen	Oracle Linux Engineering
