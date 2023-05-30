Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6FB716FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjE3VgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjE3VgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:36:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2022F107;
        Tue, 30 May 2023 14:36:16 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UKw4U2014360;
        Tue, 30 May 2023 21:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=UByZt3BOG36ECmN9s52g2/qD1nBdXGz7bPV+jFA7FfQ=;
 b=gRgw0y4kQc5iemPZRDoz7tGaY1rLZQ5UyxFuEiUr+Tv2zjo9N4Xk4XnYk//1UlCkKUmY
 TqxOLf/oWgVy2x1IVvXKd22S+U2JPWuQPAZp/ROwC303+zPjqFALwUhQnCW8V8rEwzw9
 pLEMFBYCbj3yhBm7WE1CYJL3Dd7i5SR8IZPeIVVm07LCZe0XXmp1zDvyiH5C5Y4aD4xz
 NpwK84QUn2XVceDt/OAmk0BhxtGB/MkOn0kuFvuTd0qhj9Hek76BlMMv6QSchQS7m8CI
 cc4DCFbIWnmHwWhUpVC8VjVKN6wTAma7Of4SBpp63pJNPUNZKbzteiwosLoqMAn24D0D 5w== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwn3wwuws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 21:36:10 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34UKZcVh016822;
        Tue, 30 May 2023 21:36:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3qu9g6hw00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 21:36:09 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34ULa8aW22151440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 21:36:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B577E58057;
        Tue, 30 May 2023 21:36:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C51DE5805D;
        Tue, 30 May 2023 21:36:07 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.61.55.64])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 21:36:07 +0000 (GMT)
Message-ID: <fe0739cbe279cf9db2ebff1146e7ae540cc1ad6c.camel@linux.ibm.com>
Subject: Re: [PATCH][next] scsi: lpfc: Avoid -Wstringop-overflow warning
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Tue, 30 May 2023 17:36:06 -0400
In-Reply-To: <ZHZq7AV9Q2WG1xRB@work>
References: <ZHZq7AV9Q2WG1xRB@work>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qOOh9oSLmdL0lqNAuTLdQPGb642CRbjP
X-Proofpoint-GUID: qOOh9oSLmdL0lqNAuTLdQPGb642CRbjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_16,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 adultscore=0 mlxlogscore=761
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300175
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-30 at 15:30 -0600, Gustavo A. R. Silva wrote:
> Avoid confusing the compiler about possible negative sizes.
> Use size_t instead of int for variables size and copied.
> 
> Address the following warning found with GCC-13:
> In function ‘lpfc_debugfs_ras_log_data’,
>     inlined from ‘lpfc_debugfs_ras_log_open’ at
> drivers/scsi/lpfc/lpfc_debugfs.c:2271:15:
> drivers/scsi/lpfc/lpfc_debugfs.c:2210:25: warning: ‘memcpy’ specified
> bound between 18446744071562067968 and 18446744073709551615 exceeds
> maximum object size 9223372036854775807 [-Wstringop-overflow=]
>  2210 |                         memcpy(buffer + copied, dmabuf->virt,
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  2211 |                                size - copied - 1);
>       |                                ~~~~~~~~~~~~~~~~~~
> 

This looks like a compiler bug to me and your workaround would have us
using unsigned types everywhere for sizes, which seems wrong.  There
are calls which return size or error for which we have ssize_t and that
type has to be usable in things like memcpy, so the compiler must be
fixed or the warning disabled.

James

