Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F44F6ABFE8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCFMwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCFMwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:52:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E02BEE7;
        Mon,  6 Mar 2023 04:52:17 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32652YAr022938;
        Mon, 6 Mar 2023 12:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Q2jlX39BuxHZUxqQJCS0V6f2hdX5HmqoSngiobuaRUY=;
 b=e7dPY+2A/UXgMVinv++xA2oPvr7o9MoIwvDjp+6hkgRkmr81HbKifPENVsIZzL9pViPR
 nSkKALuiRnd3qtvwHckMokjCyBYhmVHThvBHdfO28/GBSRhpF2PtbfjA9MmZqqrDkJhl
 cdnHVo0DHzs+RVoSYpQzUwnhoIf/NaGzADqfvlo+Rd8N6xSL067KDuGICVi2yzQOSrKB
 Bgai041uVA4EvhchhqBU9eox1yeilv4O9LW9gc9qN+9wbSYGv6Hojij8LwYpi2Tr9FbR
 V7k+31EcXtC1up2cWSgu9XN/C9SdcEoTGi+R+VV9Jww7aweNiNJNVgF9RWN0mPmY6P/L oA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p41j6cpkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 12:52:05 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326Cq40t016393
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 12:52:04 GMT
Received: from [10.204.79.110] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 04:52:01 -0800
Message-ID: <7a812676-086d-60d2-2cc4-9a9c5f0a872f@quicinc.com>
Date:   Mon, 6 Mar 2023 18:21:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace event
Content-Language: en-US
To:     Douglas RAILLARD <douglas.raillard@arm.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230306122549.236561-1-douglas.raillard@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SG11kEEpxNNCpC5ZFUIcNq_iAqTUDJSS
X-Proofpoint-ORIG-GUID: SG11kEEpxNNCpC5ZFUIcNq_iAqTUDJSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_05,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=722 clxscore=1011 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/2023 5:55 PM, Douglas RAILLARD wrote:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Fix the nid_t field so that its size is correctly reported in the text
> format embedded in trace.dat files. As it stands, it is reported as
> being of size 4:
> 
>          field:nid_t nid[3];     offset:24;      size:4; signed:0;
> 
> Instead of 12:
> 
>          field:nid_t nid[3];     offset:24;      size:12;        signed:0;
> 
> This also fixes the reported offset of subsequent fields so that they
> match with the actual struct layout.
> 
> 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>   include/trace/events/f2fs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 31d994e6b4ca..8d053838d6cf 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -512,7 +512,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
>   	TP_STRUCT__entry(
>   		__field(dev_t,	dev)
>   		__field(ino_t,	ino)
> -		__field(nid_t,	nid[3])
> +		__array(nid_t,	nid, 3)


Good catch.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

>   		__field(int,	depth)
>   		__field(int,	err)
>   	),
