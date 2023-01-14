Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936A866A8D9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 04:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjANDHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 22:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjANDHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 22:07:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E4988DDC;
        Fri, 13 Jan 2023 19:07:12 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30E2XZ2d004680;
        Sat, 14 Jan 2023 03:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=pSfaRZNwViSEgIVHhPBSS0C4uARiD6bTU/ABVDS7xSc=;
 b=C0nQ9khgkwky2BgftbqAC+mq85RFTiKcGp/PVyZqyFOvVtiw2bw+lHYkXyVw52TLLVFE
 pVzC+hDfy+4X3LbRDhQ+2/SPKW6M/klp5RVDH22GPdc7YNivocjjf9qCRq62flypLDwL
 X5kJ4HCUsk93QCiiRVZYVSTyVVIVZ8OL/tGsHLe8AmwXpj9FqSFOVWMPGtF04qArw6x5
 hXLuQb7HaXIoR0tptydOuXpWp1GL3oEVzyrrhLX9lk5O7JjsHAzFPn/hP3SxU4pIyIJE
 yxWFKduTg+uychK+YAo3YQYLjEHo1uLYkRk5b9j7ulRnbMm17SUetFeO9BqijCKo03qX 4A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3av80w3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 03:07:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30E2xINQ018723;
        Sat, 14 Jan 2023 03:07:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n3m3d85t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 03:07:06 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30E375hF035466;
        Sat, 14 Jan 2023 03:07:06 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n3m3d85sp-3;
        Sat, 14 Jan 2023 03:07:06 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: mvumi: Replace 1-element arrays with flexible array members
Date:   Fri, 13 Jan 2023 22:06:41 -0500
Message-Id: <167366469093.3069139.11214997988333083540.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230105011143.never.569-kees@kernel.org>
References: <20230105011143.never.569-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_12,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301140019
X-Proofpoint-ORIG-GUID: p861WBleCQRQv33qb1kuV0EBCiXaJlUy
X-Proofpoint-GUID: p861WBleCQRQv33qb1kuV0EBCiXaJlUy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jan 2023 17:11:50 -0800, Kees Cook wrote:

> One-element arrays (and multi-element arrays being treated as
> dynamically sized) are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten the
> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> 
> Replace one-element arrays with flexible-array member in struct
> mvumi_msg_frame, struct mvumi_rsp_frame, and struct mvumi_hs_header,
> adjusting the explicit sizing calculations at the same time.
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/1] scsi: mvumi: Replace 1-element arrays with flexible array members
      https://git.kernel.org/mkp/scsi/c/201e0a7c7f36

-- 
Martin K. Petersen	Oracle Linux Engineering
