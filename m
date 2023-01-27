Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728D767DCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjA0DXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjA0DXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:23:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D974A45;
        Thu, 26 Jan 2023 19:23:23 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R0NY0C007533;
        Fri, 27 Jan 2023 03:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=3bFCp52HYNGoANttniclXRjnAoZxtRItZb3E4P416g4=;
 b=s1vHSPazrFkLTSb0WiX9P/SyV5H4feM2KEEHXVlJeo5YxAtA0Ko2Rl4MDNife0H0hKCf
 TLtM/dKLbvWl3nlQqJqPw4cVQ3zb13Hd5wNqLPBvOUQR3ab9H46BRmdnNsGj/bxLxP1b
 UOEym3yZCx+CgIIRnQ5gilJEzAh1F/VSJuBymdVJMvepAN8XpwusNJtf9rJ66wNmku4q
 KiPEEiDjvkW/9yp5K07GCCLadGrJux5N52Ve7vdGlGiq2eZyPae4cM8x8DY1dew1J4AW
 Peo9teOKpDxPUaDRPIhDIZVArfSueeEhAMjnbAoI85zJm1Ca6Xjce/dfBTs5nkFdVa9s JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883cby80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30R36aoE006639;
        Fri, 27 Jan 2023 03:23:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g8nxqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:09 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30R3N7eg036358;
        Fri, 27 Jan 2023 03:23:08 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3n86g8nxpp-2;
        Fri, 27 Jan 2023 03:23:08 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Saurav Kashyap <skashyap@marvell.com>,
        Tom Rix <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qla2xxx: fix printk format string
Date:   Thu, 26 Jan 2023 22:22:55 -0500
Message-Id: <167478863289.3972592.8275488978063279225.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230117170029.2387516-1-arnd@kernel.org>
References: <20230117170029.2387516-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=785 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270029
X-Proofpoint-ORIG-GUID: gr0kSce90-QiwRIeUh0SSZQOZWNQtU9T
X-Proofpoint-GUID: gr0kSce90-QiwRIeUh0SSZQOZWNQtU9T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 18:00:15 +0100, Arnd Bergmann wrote:

> Printing a size_t value that is the result of the sizeof() operator requires
> using the %z format string modifier to avoid a warning on 32-bit architectures:
> 
> drivers/scsi/qla2xxx/qla_mid.c: In function 'qla_create_buf_pool':
> drivers/scsi/qla2xxx/qla_mid.c:1094:51: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Werror=format=]
>  1094 |                     "Failed to allocate buf_map(%ld).\n", sz * sizeof(unsigned long));
>       |                                                 ~~^       ~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                                   |          |
>       |                                                   long int   unsigned int
>       |                                                 %d
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/1] qla2xxx: fix printk format string
      https://git.kernel.org/mkp/scsi/c/d794a23113b1

-- 
Martin K. Petersen	Oracle Linux Engineering
