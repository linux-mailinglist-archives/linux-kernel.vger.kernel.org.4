Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273866393B1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 04:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiKZD17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 22:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiKZD1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:27:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE0B11837;
        Fri, 25 Nov 2022 19:27:51 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ1vdkE020171;
        Sat, 26 Nov 2022 03:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=m6KHJuOIeWbW3FNEPlj/1DnHECg3pQAj0KPYHsZWyo4=;
 b=bqqUKtL3prx9RkHZQ/FbCsxzHO2TVxxLwofhl7WyxEf5LV5q1FXOhakI0q/e8cTQwYUh
 q91oVCoea47/sEnNQENG74zE/Qyi2+tvFSbW6rHCtTm4z15GieYdARjhIl55v5tKD5Lk
 H7IsdjqMZeVZw2JYASYovxXWgAcjeLUigsSvpqJ9wMItUjpXjVip6girxw+VCdpZmZaT
 6WeG8FnUmP1b+0HGKANMXlaEiSlNgcn/q8ANpJT4Su4AfqfH6jxflITrS8wSFTfwJMwZ
 6X93pxsROx7t7iOIu0QwjW3Sn+QFPhxpt347cwm0W72KwEgFE6Kedb9KynzS+OH1Iucy 8A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2g1ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:27:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQ1XWdk007337;
        Sat, 26 Nov 2022 03:27:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3988b80b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:27:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AQ3RhsT028327;
        Sat, 26 Nov 2022 03:27:44 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3m3988b7y9-4;
        Sat, 26 Nov 2022 03:27:44 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH][next] scsi: bfa: Replace one-element array with flexible-array member
Date:   Sat, 26 Nov 2022 03:27:35 +0000
Message-Id: <166943312547.1684293.4109491775873711686.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y3P1rEEBq7HzJygq@work>
References: <Y3P1rEEBq7HzJygq@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=853 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211260024
X-Proofpoint-GUID: cVSRcpvB2mow_RUikDVZmEFMplyT-GIw
X-Proofpoint-ORIG-GUID: cVSRcpvB2mow_RUikDVZmEFMplyT-GIw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 14:25:16 -0600, Gustavo A. R. Silva wrote:

> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct fdmi_attr_s.
> 
> Important to mention is that doing a build before/after this patch results
> in no binary output differences.
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: bfa: Replace one-element array with flexible-array member
      https://git.kernel.org/mkp/scsi/c/c4c5fa35563a

-- 
Martin K. Petersen	Oracle Linux Engineering
