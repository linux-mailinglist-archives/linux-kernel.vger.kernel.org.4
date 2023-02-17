Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF069ACC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBQNnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBQNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:43:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEABC64C;
        Fri, 17 Feb 2023 05:43:16 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HBSBpI026152;
        Fri, 17 Feb 2023 13:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FX6OG/CBxkvvnAoWR0XG3eztHnQoT40IABl8eSUBPRc=;
 b=X6akyBgr/c8PSlHFgaYBozmyli2oJyVvZeArt8dqlxNl/fjhYq5skrQKdJRVEvHA9K8R
 BnNZTgui/ta2TnQEWKCddQtPi33QLXqTyNoruksiXhpG1R1GWwBybInudCLAY5Ao10T5
 IFlV1T7GsHOW81cROCjrt2YRo1nIcdmDpq4rQP8loFyPQyy5YG+jjR3CLjGXkhXAwo/H
 GXmGyGfs6X+NxmkQHGsRXUgwagHRPvTRs98EylX0/zkER8um4KV7DK9uL0BDrlfRoaAr
 7fk/a2SKB5qrHgnYIT5LSYskKKRZ17TqRrnJLjzA3z+ELVEzjFsM6EYLFlhG6nHosgGY og== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nt8qwr863-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 13:43:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HDhAtN002142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 13:43:10 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 05:43:07 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <borrello@diag.uniroma1.it>
CC:     <c.giuffrida@vu.nl>, <h.j.bos@vu.nl>, <jkl820.git@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing/probe: trace_probe_primary_from_call(): checked list_first_entry
Date:   Fri, 17 Feb 2023 19:12:40 +0530
Message-ID: <1676641360-22701-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20230128-list-entry-null-check-v1-1-8bde6a3da2ef@diag.uniroma1.it>
References: <20230128-list-entry-null-check-v1-1-8bde6a3da2ef@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZibXNj6qZo_llj3g6YNsdm6izdZhEf6y
X-Proofpoint-ORIG-GUID: ZibXNj6qZo_llj3g6YNsdm6izdZhEf6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170123
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>All callers of trace_probe_primary_from_call() check the return
>value to be non NULL. However, the function returns
>list_first_entry(&tpe->probes, ...) which can never be NULL.
>Additionally, it does not check for the list being possibly empty,
>possibly causing a type confusion on empty lists.
>Use list_first_entry_or_null() which solves both problems.
>
>Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
>Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
>---
> kernel/trace/trace_probe.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
>index 23acfd1c3812..f6b565dced56 100644
>--- a/kernel/trace/trace_probe.h
>+++ b/kernel/trace/trace_probe.h
>@@ -307,7 +307,7 @@ trace_probe_primary_from_call(struct trace_event_call *call)
> {
> 	struct trace_probe_event *tpe = trace_probe_event_from_call(call);
> 
>-	return list_first_entry(&tpe->probes, struct trace_probe, list);
>+	return list_first_entry_or_null(&tpe->probes, struct trace_probe, list);
> }

Nice catch !!

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> 
> static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)
