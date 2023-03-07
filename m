Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0906AD518
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCGC5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCGC5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:57:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39767804;
        Mon,  6 Mar 2023 18:57:44 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Nx6dc025156;
        Tue, 7 Mar 2023 02:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=Eg8+XSc33JayGA1Dp4RkW0lQK1WmRclosqC3P4LadzQ=;
 b=E5gfphtdiF7mu7AGgIswvE3OuYXBDAi2SOzZTFyy69DdD1z499Dcy/jUsrXHT4bHdbI1
 UDxQ6lCiYjyjsCVNeHOS1gho3N2UH2lz2q8ztFvDj2sw0WKSDbcKzGfTAVAnHSGlYiwt
 11GXYTvC/s48u1w1CdBnSn7nNc43KQQQ8VV6rc+UmzpARi87Ufsihnq7mYDAsqcaX+Wl
 /Q3vvMwoliXY+qkw679lUWF0G5IFAytJ2vXdM6q1GmGO/tYRkysRkx+bN8LrEINyn7UB
 kBEoroy/XD7QdiJIfyuQr9+TcwNH7U9A+XKrdWM7+r4LVRP8/KNv73VvBHfHqHI9LnBk 8g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn90tpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 02:57:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3270b9CC037036;
        Tue, 7 Mar 2023 02:57:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4txdvjk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 02:57:38 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3272vY2I009567;
        Tue, 7 Mar 2023 02:57:38 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p4txdvjhj-5;
        Tue, 07 Mar 2023 02:57:37 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jakob Koschel <jkl820.git@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] scsi: lpfc: avoid usage of list iterator variable after loop
Date:   Mon,  6 Mar 2023 21:57:22 -0500
Message-Id: <167815780213.2075334.18310848628648213797.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301-scsi-lpfc-avoid-list-iterator-after-loop-v1-1-325578ae7561@gmail.com>
References: <20230301-scsi-lpfc-avoid-list-iterator-after-loop-v1-1-325578ae7561@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=981 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070025
X-Proofpoint-GUID: 7PK1sJPnSdoTmQmaaX4ULEpWJQddtR_n
X-Proofpoint-ORIG-GUID: 7PK1sJPnSdoTmQmaaX4ULEpWJQddtR_n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023 18:19:14 +0100, Jakob Koschel wrote:

> If the &epd_pool->list is empty when executing
> lpfc_get_io_buf_from_expedite_pool() the function would return an
> invalid pointer. Even in the case if the list is guaranteed to be
> populated, the iterator variable should not be used after the loop to be
> more robust for future changes.
> 
> Linus proposed to avoid any use of the list iterator variable after the
> loop, in the attempt to move the list iterator variable declaration into
> the marcro to avoid any potential misuse after the loop [1].
> 
> [...]

Applied to 6.3/scsi-fixes, thanks!

[1/1] scsi: lpfc: avoid usage of list iterator variable after loop
      https://git.kernel.org/mkp/scsi/c/2850b23e9f9a

-- 
Martin K. Petersen	Oracle Linux Engineering
