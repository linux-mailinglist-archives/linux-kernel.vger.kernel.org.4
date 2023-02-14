Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3226963EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjBNMxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjBNMxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:53:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D021A2D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:53:31 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E5d3Xe014886;
        Tue, 14 Feb 2023 12:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=zehFsAhHoBrT3wPJAhlchQvE+e0/uYpQajpllFs2EdA=;
 b=WdyZTjq5+X41keiJcFpWmLAvnivRPZ6TP14Eqh+0nJthSjxLid+TkwkK9SPVxVWEygrE
 5FRSdbIcDcef+zF8TFhuLWCqfMpbWmtM6QhbmWAsIENiY/BxiTDvAZdeLkjYN79F61mH
 OhUY7UEsNTq0Z1uo3meGd+dwMu66QDgCU0DxS1G0m4WnewWZCqCMi90tznizLvdv98e1
 jSSpSbZafSAmn+XpYm3AtE/pLJknR0i0zlgqhd7S+04m151nxha4+pf/8GpPoOFJnu2V
 AEh0TQX9e0c1mZy76+fQZ0YZoFpaeaowcLcgAyLgSH8KHO4tScgBgNDKbV5xsdQMExNA ow== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtv0a4fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 12:52:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ECqZ4C009759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 12:52:35 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 04:52:31 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V7 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for shmem files
Date:   Tue, 14 Feb 2023 18:21:48 +0530
Message-ID: <cover.1676378702.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qu7VaSJ_EvicX5Dg2RYpO0-BsGxL423S
X-Proofpoint-ORIG-GUID: Qu7VaSJ_EvicX5Dg2RYpO0-BsGxL423S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_07,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=294 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
advices to shmem files which can be helpful for the drivers who may want
to manage the pages of shmem files on their own, like, that are created
through shmem_file_setup[_with_mnt]().

Changes in V7:
 -- Use folio based interface, shmem_read_folio(), for FADV_WILLNEED.
 -- Don't swap the SHM_LOCK'ed pages. 

Changes in V6:
 -- Replaced the pages with folio's for shmem changes.
 -- https://lore.kernel.org/all/cover.1675690847.git.quic_charante@quicinc.com/

Changes in V5:
 -- Moved the 'endbyte' calculations to a header function for use by shmem_fadvise().
 -- Addressed comments from suren.
 -- No changes in resend. Retested on the latest tip.
 -- https://lore.kernel.org/all/cover.1648706231.git.quic_charante@quicinc.com/

Changes in V4:
  -- Changed the code to use reclaim_pages() to writeout the shmem pages to swap and then reclaim.
  -- Addressed comments from Mark Hemment and Matthew.
  -- fadvise() on shmem file may even unmap a page.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1644572051-24091-1-git-send-email-quic_charante@quicinc.com/

Changes in V3:
  -- Considered THP pages while doing FADVISE_[DONT|WILL]NEED, identified by Matthew.
  -- xarray used properly, as identified by Matthew.
  -- Excluded mapped pages as it requires unmapping and the man pages of fadvise don't talk about them.
  -- RESEND: Fixed the compilation issue when CONFIG_TMPFS is not defined.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1641488717-13865-1-git-send-email-quic_charante@quicinc.com/

Changes in V2:
  -- Rearranged the code to not to sleep with rcu_lock while using xas_() functionality.
  -- Addressed the comments from Suren.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1638442253-1591-1-git-send-email-quic_charante@quicinc.com/

changes in V1:
  -- Created the interface for fadvise(2) to work on shmem files.
  -- https://patchwork.kernel.org/project/linux-mm/patch/1633701982-22302-1-git-send-email-charante@codeaurora.org/


Charan Teja Kalla (2):
  mm: fadvise: move 'endbyte' calculations to helper function
  mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem

 mm/fadvise.c  |  11 +-----
 mm/internal.h |  21 +++++++++++
 mm/shmem.c    | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 10 deletions(-)

-- 
2.7.4

