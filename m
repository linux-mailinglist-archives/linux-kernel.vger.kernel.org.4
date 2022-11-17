Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35B162E44E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbiKQSav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbiKQSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:30:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D3B8514D;
        Thu, 17 Nov 2022 10:30:04 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHIG5xK007355;
        Thu, 17 Nov 2022 18:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=JqMYj8vijzaHfrpJqHR/LutMp1F/I434SgJbdoISHjo=;
 b=WtQvDHy1pGtqVFm/s6bY1TMnpWQnsBw4Oq4cO7wa7kABBO2f0dzNgj3NfOCvpOQI8ZK2
 eSi3/A1cvy3LyWE2Ji4wzhvSc00eZTvvP0J81tAgxAZsixGjws/PeTyG1NA1a6HpqX+C
 Eabg1IOpXBzyN/DwOXvvpifILdHX1VbA7NcnGZO8c3I+vVe4Hr07QHt/ST+GEusHqEb+
 s/2nZeLOHfdacwfTV8ayvwxDzYgKpOaLB9ep0KXAywBpfD9uypQDUACMSeIhejefJzs0
 /Crg8Giu00Djc6pryQ60VeDsHyTQmUkdJDxkrsgSalHFTJGCPdtU5SkdbhxylxMY7wW4 6w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3nsa6p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHGbS5010856;
        Thu, 17 Nov 2022 18:29:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kab0ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:29:44 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHITapN022894;
        Thu, 17 Nov 2022 18:29:43 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kab0gb-12;
        Thu, 17 Nov 2022 18:29:43 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        target-devel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        patches@lists.linux.dev, linux-scsi@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: elx: libefc: Fix second parameter type in state callbacks
Date:   Thu, 17 Nov 2022 13:29:34 -0500
Message-Id: <166870943118.1584889.8464452752977836109.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221102161906.2781508-1-nathan@kernel.org>
References: <20221102161906.2781508-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170133
X-Proofpoint-GUID: YpdVMiVtlcP3MPz2xy3gC8cNHM2Ygyu9
X-Proofpoint-ORIG-GUID: YpdVMiVtlcP3MPz2xy3gC8cNHM2Ygyu9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 09:19:06 -0700, Nathan Chancellor wrote:

> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/1] scsi: elx: libefc: Fix second parameter type in state callbacks
      https://git.kernel.org/mkp/scsi/c/3d75e766b58a

-- 
Martin K. Petersen	Oracle Linux Engineering
