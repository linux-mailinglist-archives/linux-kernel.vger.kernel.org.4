Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB79718F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjFAAnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjFAAnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:43:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2DE123;
        Wed, 31 May 2023 17:43:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKIEYi032508;
        Thu, 1 Jun 2023 00:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=kgrZrmMdCGW4zNKNzukArbvw+ik9UIZSCqtlU1iZmRg=;
 b=T3PYg3ayunKdr2RiVkSN1BMAWYP5BdMOj8j7+pzk5JRXGwyxzexwmaBoiypOM/3guJ8t
 p+2uL/bTOQMVEpCP7S9PhPShXEfWVCQJa3zWu6zvesDWySrrWvKmWB+irU6eawNz9Y3B
 l6hTUJ1AJwTy2r9xSmyv/nBT/j6KXi/UyJogS+fNlpkMQwGfM8RCmrPrn3RDyK+8x9B3
 7NRMu6REUD/ei05YGcZ8jxinyJIvz9NYfEIR8ed6qzvudEvWvWPWkipIfjm2py07PQLm
 o0EjVT/Rsj4iCqT4Izmf6datyYfUyJiF0QzdbJ2/DtKomNnJJgyo8t1kXEDTuvR/sl9j FA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb97d72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:43:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VMsRoS003775;
        Thu, 1 Jun 2023 00:43:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ye2ea6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:43:32 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3510hV9H008516;
        Thu, 1 Jun 2023 00:43:32 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qv4ye2e6s-1;
        Thu, 01 Jun 2023 00:43:31 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] scsi: mpi3mr: Fix the type used for pointers to bitmap
Date:   Wed, 31 May 2023 20:43:10 -0400
Message-Id: <168558000059.2461197.2174919171880641930.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8bdf9148ce1a5d01aac11c46c8617b477813457e.1683473011.git.christophe.jaillet@wanadoo.fr>
References: <8bdf9148ce1a5d01aac11c46c8617b477813457e.1683473011.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=824
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010004
X-Proofpoint-GUID: T0gnqpk8oTm01hYHDRNJBwves-_unOzd
X-Proofpoint-ORIG-GUID: T0gnqpk8oTm01hYHDRNJBwves-_unOzd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 May 2023 17:23:49 +0200, Christophe JAILLET wrote:

> Bitmaps are "unsigned long[]", so better use "unsigned long *" instead of
> a plain "void *" when dealing with pointers to bitmaps.
> 
> This is more informative.
> 
> 

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: mpi3mr: Fix the type used for pointers to bitmap
      https://git.kernel.org/mkp/scsi/c/144679dfb584

-- 
Martin K. Petersen	Oracle Linux Engineering
