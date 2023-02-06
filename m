Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FA168BFF0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBFOWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:22:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1201C271F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:22:31 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316CBGsb012728;
        Mon, 6 Feb 2023 14:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=z16qL464jjHlCAViTyAzYRDp++e/SOG/2UVptENsEGo=;
 b=E0+YTtowsmFGO5B3QrtTDOpLH+ZuSmQdDMhwEcPZFQad0tTzCP+nbF4MNgVmiFeEnD7M
 ijpaRh/ZgHRG34zD5ngFk+1BpocHidpSZFF815pbCALDrge35Lrpt43At+GMsWMDz9n9
 qyvMrGl1IBvikbe6kay3EZhIuHR4ZF8qlRcQ+HnoQZH9iQk22IMrLCmda+/eWka9HCbF
 OI3Jyi9mX42wMzHZTcTbe256vSqhY5eybcsw6T0zo0z2KiyIFy5iu+sO7ZoxNnWYE7wg
 JD3hoZrfW94+Vv4pFT6ctz0B/h3Iwv4iernFFqdg7bWy5pwPuRA8EmIvyDZR6tDhc+h7 EA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhg4rkp5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:22:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316EM9Te003936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 14:22:09 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 6 Feb 2023 06:22:04 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        <mhocko@suse.com>, <vbabka@suse.cz>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V6 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for shmem files
Date:   Mon, 6 Feb 2023 19:51:31 +0530
Message-ID: <cover.1675690847.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9s_6ra1D45UOIxe7M8KVQxPNMCSfwB9y
X-Proofpoint-GUID: 9s_6ra1D45UOIxe7M8KVQxPNMCSfwB9y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=432 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060123
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
advices to shmem files which can be helpful for the drivers who may want
to manage the pages of shmem files on their own, like, that are created
through shmem_file_setup[_with_mnt]().

Changes in V6:
 -- Replaced the pages with folio's for shmem changes.

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
 mm/shmem.c    | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 10 deletions(-)

-- 
2.7.4

