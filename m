Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0968225B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjAaCtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAaCtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:49:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E917425287;
        Mon, 30 Jan 2023 18:49:48 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V2V3UM021098;
        Tue, 31 Jan 2023 02:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BWcjC5DZ3idQSQAxRdqK3fIUmKR0z6P+iv+wHKcKKZU=;
 b=DiybgHbJhd8hyJF5ju2xguD+IYjdJ3r9uG3KkWvK8rl0AaMQ250mREgEdDlcx6PsBJaz
 EzyRlLPxlOwDbLaQvv13JuhCYMffrn0t1Rva40cWcnLa2SgIXomVJyy2YR1xzLlXjQEh
 vHw7rtyPrz5Hpcx7VuHBkp1xWsxdkwF0QhX51iFnBmlg5l7BhhyO/yDgc3Z1Omwdct8y
 BExas+jnR6pmUS+WKmdpN8vvkD86AWEdIxIs4EdePc5tpyS2MtOKTp3VMKMt77JGIF4Y
 yD2W6BxV0QAHbxnSTMYWzE5GfGvM+3TKSpXknh/7OK52/FBJzMMhShWjgXMRXOccMG16 yQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nejdm0uah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 02:49:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V2nfAJ016448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 02:49:41 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 18:49:40 -0800
Message-ID: <5f37bdef-5447-8def-7bb0-a498879abc4c@quicinc.com>
Date:   Tue, 31 Jan 2023 10:49:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5] trace: acquire buffer from temparary trace sequence
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <1675065249-23368-1-git-send-email-quic_linyyuan@quicinc.com>
 <28cd9aca-1945-ceed-2756-162132d576ef@quicinc.com>
 <20230130143041.713c4c7b@gandalf.local.home>
 <e2735a3a-4a9b-8b3a-0671-b3f56187cbe2@quicinc.com>
 <20230130213735.72cdcee4@gandalf.local.home>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20230130213735.72cdcee4@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VC6qKWC0c4KKGGg27GVlldL-4Sgg7LDf
X-Proofpoint-GUID: VC6qKWC0c4KKGGg27GVlldL-4Sgg7LDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_19,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=748 bulkscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310023
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/2023 10:37 AM, Steven Rostedt wrote:
> On Tue, 31 Jan 2023 10:06:22 +0800
> Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
>
>> yes, agree it will be safe for dwc3, but i don't know if any possible
>> hacker,
>>
>> as the function always return a valid pointer even when hacker input a
>> large size.
> But gives a nice big warning if that's the case. This is not something that
> can be modified by user input. We do not need to worry about
> kernel implementations that could overflow (and trigger a WARN_ON() when
> they do). Especially since the max size is greater than the max size of the
> content of an event.
>
> A lot of systems that worry about hackers enable "panic_on_warn" which
> means that if the WARN_ON() triggers, the machine will crash, which will at
> most cause a DOS, but not something people can use to hack into the machine
> with.


thanks, please help review the change.


>
> -- Steve
