Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D56718FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjFAAnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjFAAns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:43:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B4213E;
        Wed, 31 May 2023 17:43:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJqsqI023425;
        Thu, 1 Jun 2023 00:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=QmtHVEbSQeEd5HAXMSbTKWQp7aWIqyHo+SoSvmX/oIo=;
 b=lQW+FNZwMjsXj3NLSh2wqK7bkF/rmS1/YKSCAKrzdU9WrkBRqM2jFqRYVc1349vWXcrE
 vy48lqATSqvcSHr0sAWTYeuPj0VGaDTYDzQTlee+2x6OXVg1pkm9P9c6q4a8Vo2Dw5qe
 qScD708fSQC/PgQP3wnbSFkxOtGr52CmU4J7y0/nGjnfvpYUBBVkusxsrhGhpjwItMYE
 0SCzxXiUEheeq9v7tsohbxHNM2dbCwhctI0+NhkPog4L51aAgSXHfDr3TUESk2VHudEp
 84Brj/8qNgR51IyzCRO+D0E4J1jxvXrHEO29BjemnYhBL7f+OPfipXailItwP28GXOmN Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9yhpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:43:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VN5cKm003733;
        Thu, 1 Jun 2023 00:43:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ye2eb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:43:34 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3510hV9P008516;
        Thu, 1 Jun 2023 00:43:34 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qv4ye2e6s-5;
        Thu, 01 Jun 2023 00:43:34 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Yuchen Yang <u202114568@hust.edu.cn>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: scsi: 3w-xxxx: Add error handling for initialization failure in `tw_probe`
Date:   Wed, 31 May 2023 20:43:14 -0400
Message-Id: <168558000056.2461197.15799717979637584727.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230505141259.7730-1-u202114568@hust.edu.cn>
References: <20230505141259.7730-1-u202114568@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=617
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010004
X-Proofpoint-GUID: Y8u0jIA-KJ22owMxzJLVjnGV84gxiRR7
X-Proofpoint-ORIG-GUID: Y8u0jIA-KJ22owMxzJLVjnGV84gxiRR7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 May 2023 22:12:55 +0800, Yuchen Yang wrote:

> Smatch complains that:
> tw_probe() warn: missing error code 'retval'
> 
> This patch adds error checking to `tw_probe` function to handle
> initialization failure. If `tw_reset_sequence` function returns a
> non-zero value, the function will return an `-EINVAL` error code
> to indicate the initialization failure.
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/1] drivers: scsi: 3w-xxxx: Add error handling for initialization failure in `tw_probe`
      https://git.kernel.org/mkp/scsi/c/2e2fe5ac695a

-- 
Martin K. Petersen	Oracle Linux Engineering
