Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7BB63E893
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLADrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiLADqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:46:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A895D9FA98;
        Wed, 30 Nov 2022 19:46:04 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B13PNEk016224;
        Thu, 1 Dec 2022 03:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=UXyg/kgp4bRzcwagMs14aIUmuAO+kQipvhdvaRUdh6Q=;
 b=Iii7f4tsK8AcqFu2qivs2FmU8SpOjuGy7SOtLsvbYmMVsPFCY1YPS2b7Q03SJLNH0poZ
 08pYteJzKEQlv5eoQVQ8FxaQ/5Gns71LShN47yUb4nLP0vNKje915vcstV9Gp9BR0x4W
 I3jbS4Gl243vhZgJDHQfEE5seMcAnlBJE+GWRTcu3tJaM3pX4bUFNek4ei2ujYjziJZm
 OuN29FH+VN/nhkLE3rnnNJ5cvPNu9S4zcZFzOz4R1E7cB54RtMFsYWX3rfJPhh94DTK/
 6ZadhxgcUda2Btw1cx9LLFHggvu+Q+VV4oQ814p3Ub8MNwTA76k3iUe/P6UbXerBXh43 JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemjjp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B12qGq9007611;
        Thu, 1 Dec 2022 03:45:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398a2cvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 03:45:56 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B13jbpw033801;
        Thu, 1 Dec 2022 03:45:56 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3m398a2cjs-19;
        Thu, 01 Dec 2022 03:45:56 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-scsi@vger.kernel.org, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM,
        dave.hansen@linux.intel.com
Subject: Re: [PATCHv2] scsi: Fix get_user() in call sg_scsi_ioctl()
Date:   Thu,  1 Dec 2022 03:45:20 +0000
Message-Id: <166986602299.2101055.4152803267481265665.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117232304.1544-1-kirill.shutemov@linux.intel.com>
References: <20221117232304.1544-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=929 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010022
X-Proofpoint-ORIG-GUID: t1fto81yKR0FhKyNxnkRZtovgU0Y5d3l
X-Proofpoint-GUID: t1fto81yKR0FhKyNxnkRZtovgU0Y5d3l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 02:23:04 +0300, Kirill A. Shutemov wrote:

> get_user() expects the pointer to be pointer-to-simple-variable type,
> but sic->data is array of 'unsigned char'. It violates get_user()
> contracts.
> 
> Explicitly take pointer to the first element of the array. It matches
> current behaviour.
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: Fix get_user() in call sg_scsi_ioctl()
      https://git.kernel.org/mkp/scsi/c/4e80eef45ad7

-- 
Martin K. Petersen	Oracle Linux Engineering
