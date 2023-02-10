Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC7692A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjBJWbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjBJWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:31:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BE5812BB;
        Fri, 10 Feb 2023 14:31:31 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AMUrNN031176;
        Fri, 10 Feb 2023 22:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=MkvI06wbF2iEoA2yQ+QE2V1EHCz/T8GM9ZHcPtuergA=;
 b=jQYA57k2vHM6AfUiWj3u9TuNIl6H4MdZRymnHp4i2ccqb5Jsz4Vn+Gveu6tKOZxObwRM
 mRVMwSFyh19tt4q9U/t02u5Yr0oXVHTLxFei7B6COeqomArewdel/NBz5RoKJOtbIXTQ
 yrBoKp80sksJZWxrxAvbrDsj+/LZ8nT0CLj6PMkF4qG5ydiiPrN5YI7akQE0CPZE61+b
 FtvmKeSOF6/kIVrILsZmqXZ9Q6kUnDqDDYulUVHplUl2eYgBBOhRW2v3Prd4bFI8KNw8
 GpTcIjTWO3lu7R1DFzo6XE5wbq9p8lBIIllGRx/fiCSZ+aAKBLexaPi6MMDYJDb+vlOv 9A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nnhcm9wxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 22:31:07 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31AMSXOW019892;
        Fri, 10 Feb 2023 22:31:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3nnw550ss6-1;
        Fri, 10 Feb 2023 22:31:06 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31AMV6Zb023533;
        Fri, 10 Feb 2023 22:31:06 GMT
Received: from th-lint-014.qualcomm.com (th-lint-014.qualcomm.com [10.63.177.51])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 31AMV6rJ023532;
        Fri, 10 Feb 2023 22:31:06 +0000
Received: by th-lint-014.qualcomm.com (Postfix, from userid 455663)
        id 305CCDA3; Fri, 10 Feb 2023 14:31:06 -0800 (PST)
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
Date:   Fri, 10 Feb 2023 14:31:01 -0800
Message-Id: <cover.1676067791.git.quic_sudaraja@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H8PxvFsviHo53Lls_jkNirmHDp0KRN1Q
X-Proofpoint-ORIG-GUID: H8PxvFsviHo53Lls_jkNirmHDp0KRN1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=613 clxscore=1011 mlxscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100193
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PSI mechanism is useful tool to monitor pressure stall
information in the system. Currently, the minimum window size
is set to 500ms. May we know what is the rationale for this?

For lightweight systems such as Linux Embedded Systems, PSI
can be used to monitor and track memory pressure building up
in the system and respond quickly to such memory demands.
Example, the Linux Embedded Systems could be a secondary VM
system which requests for memory from Primary host. With 500ms
window size, the sampling period is 50ms (one-tenth of windwo
size). So the minimum amount of time the process needs to stall,
so that a PSI event can be generated and actions can be done
is 50ms. This reaction time can be much reduced by reducing the
sampling time (by reducing window size), so that responses to
such memory pressures in system can be serviced much quicker.

Please let us know your thoughts on reducing window size to 50ms.

Sudarshan Rajagopalan (1):
  psi: reduce min window size to 50ms

 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4

