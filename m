Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EED6DE93B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjDLCET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDLCER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:04:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5213530EB;
        Tue, 11 Apr 2023 19:04:17 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BLXO0K017666;
        Wed, 12 Apr 2023 02:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=Q8BLUQf7SHZwIVz8OOtsQt7yfrvm0z9C2RLZWH0HCCo=;
 b=rXYy8Shv/xj8xJwe/QdSprNVQpGhe3MvakqVjUojYDnFsrTiXQuNtoX+I8xT97XEqsEa
 ogwohM7HTZYKzLqEYmnFDXkXzTdiSapff3EI3lbrS4IP0GUg4x35eJRpX3VHMluomdaF
 9xH4GQdvE88QoQ5WCXoHg/qOBEaw87fxVm+DS++hsnXNM1ilAfaKiJrBFpYMohuSGcIA
 dCe0pTt76IP3lM0zOqI7B8gs89yrZ6pRttLhL7MCQoBHYwUYjTSgR4ABiT40QcXWFKvD
 nY3fiYxyj5N8IdVqtoCa0QqvHcYcMbseUaLXxuMqtkjKxPkl64eLK+u9U+8AGb/KgYGv lA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bvxy01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 02:04:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNje9U009839;
        Wed, 12 Apr 2023 02:04:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw87v96n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 02:04:01 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33C2403F019209;
        Wed, 12 Apr 2023 02:04:00 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3puw87v95p-1;
        Wed, 12 Apr 2023 02:04:00 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ding Hui <dinghui@sangfor.com.cn>,
        Michal Kolar <mich.k@seznam.cz>
Subject: Re: [PATCH] scsi: ses: Handle enclosure with just a primary component gracefully
Date:   Tue, 11 Apr 2023 22:03:53 -0400
Message-Id: <168126415947.297921.4051580681016869443.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <nycvar.YFH.7.76.2304042122270.29760@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2304042122270.29760@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=624
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120016
X-Proofpoint-GUID: yh7Y4bETTYsh5JubF2P3rkbvDb1CTlCQ
X-Proofpoint-ORIG-GUID: yh7Y4bETTYsh5JubF2P3rkbvDb1CTlCQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2023 21:23:42 +0200, Jiri Kosina wrote:

> This reverts 3fe97ff3d9493 ("scsi: ses: Don't attach if enclosure has no
> components") and introduces proper handling of case where there are no detected
> secondary components, but primary component (enumerated in num_enclosures)
> does exist. That fix was originally proposed by Ding Hui <dinghui@sangfor.com.cn>.
> 
> Completely ignoring devices that have one primary enclosure and no secondary one
> results in ses_intf_add() bailing completely
> 
> [...]

Applied to 6.3/scsi-fixes, thanks!

[1/1] scsi: ses: Handle enclosure with just a primary component gracefully
      https://git.kernel.org/mkp/scsi/c/c8e22b7a1694

-- 
Martin K. Petersen	Oracle Linux Engineering
