Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351EA692A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjBJWbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjBJWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:31:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E986C821A4;
        Fri, 10 Feb 2023 14:31:35 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ALd11l026130;
        Fri, 10 Feb 2023 22:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=qcppdkim1; bh=3rQq0M5c931UdY9o+/rvHh66nmcY55XG+xeXQsM0jW8=;
 b=fcfkfN1KgE5nUnkMKamgjfysPjMtx8nMYNirhDXJDIR1sTzFMYHmJlook38YkvZB8Ohy
 SsRlVOsaH5LnZIva0lMeyK1bnhD2esdD8Xpiz9Ijy3p7WZMmY54TXzYHCKyO0HKyXxU5
 mgYT5mMm4oYAteAL3pxHLnaOgaZqbKl3nd5ESg1mx9R3um3JL4kgCpB3RmiSRDjx0ivb
 rNYBdAV7G3yviqhdP3Q8NXlNrTHfGs6XrYw/t61qCWyVbgjWvo9ePCtd8gtjHB7iHlwv
 gtjSNyvVaYEE8hqIsXR9GrYqCQQaRi2qI4aKdWNu+RcWJ7Xgg4oOR6NTWA5sHqV7qoaP gA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nncxttcjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 22:31:09 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31AMV87B001702;
        Fri, 10 Feb 2023 22:31:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 3nmwfp2y40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 10 Feb 2023 22:31:08 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31AMV8GE001692;
        Fri, 10 Feb 2023 22:31:08 GMT
Received: from th-lint-014.qualcomm.com (th-lint-014.qualcomm.com [10.63.177.51])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 31AMV78j001691;
        Fri, 10 Feb 2023 22:31:08 +0000
Received: by th-lint-014.qualcomm.com (Postfix, from userid 455663)
        id B2AA2DA3; Fri, 10 Feb 2023 14:31:07 -0800 (PST)
From:   Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
To:     David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, will@kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>
Subject: [PATCH] psi: reduce min window size to 50ms
Date:   Fri, 10 Feb 2023 14:31:02 -0800
Message-Id: <8b7a3270fe253de1cd2b71473e29394409b2a0f7.1676067791.git.quic_sudaraja@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1676067791.git.quic_sudaraja@quicinc.com>
References: <cover.1676067791.git.quic_sudaraja@quicinc.com>
In-Reply-To: <cover.1676067791.git.quic_sudaraja@quicinc.com>
References: <cover.1676067791.git.quic_sudaraja@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kWrxcnxV7F0kx70P-NQNA-dawBSVIoHI
X-Proofpoint-GUID: kWrxcnxV7F0kx70P-NQNA-dawBSVIoHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=739
 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302100193
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few systems would require much finer-grained tracking of memory
pressure in the system using PSI mechanism. Reduce the minimum
allowable window size to be 50ms to increase the sampling rate
of PSI monitor for much faster response and reaction to memory
pressures in the system. With 50ms window size, the smallest
resolution of memory pressure that can be tracked is now 5ms.

Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ee2ecc0..6eabf27 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -160,7 +160,7 @@ __setup("psi=", setup_psi);
 #define EXP_300s	2034		/* 1/exp(2s/300s) */
 
 /* PSI trigger definitions */
-#define WINDOW_MIN_US 500000	/* Min window size is 500ms */
+#define WINDOW_MIN_US 50000	/* Min window size is 50ms */
 #define WINDOW_MAX_US 10000000	/* Max window size is 10s */
 #define UPDATES_PER_WINDOW 10	/* 10 updates per window */
 
-- 
2.7.4

