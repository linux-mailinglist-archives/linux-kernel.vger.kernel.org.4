Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8037682391
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjAaE7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 23:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjAaE7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 23:59:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E40241DF;
        Mon, 30 Jan 2023 20:59:48 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V3SN9E008527;
        Tue, 31 Jan 2023 04:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wlMJXzrCIk5B0AHkwcOuR+joMYc0NjdgBAZECJjEgKA=;
 b=LLc6ZDnsfBKMBfY6CSIp8SbCoH7i7tK/qDSqPP8D2bBjfvloDLpDk1lnrPxt0gPX2L8k
 Bw6fLN++ttsUHI0JjvzLY+2Zk68cUW1NDY2L686482A/nOfjOeKfyrfSEtnG2vmNDZOe
 D0zfPFoGzh3Biu1VDUQDS0UHA3fiUQqFvDNEjcCu3Lg/Qt0flNYIeFUoyC3qm+v9O2OL
 mRC2ZZeDztlqaiYbwAiwxghSqXziAEARlaPJPH/miQKdoFrNYE5eJTKvcut+3tO47KEG
 e39PTji3RsaJmiqZ84AWXvxnWiGzXtBSoelHJS3x6xwjUHv8gIQ8WxWM2k9O2BH4YanU XA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3netx4g5y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 04:59:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V4xiDL011173
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 04:59:44 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 20:59:43 -0800
Message-ID: <18f9ceaa-d62d-3456-efff-30ce778a1b61@quicinc.com>
Date:   Tue, 31 Jan 2023 12:59:40 +0800
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
 <5f37bdef-5447-8def-7bb0-a498879abc4c@quicinc.com>
 <20230130225807.54446779@gandalf.local.home>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20230130225807.54446779@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KcgHCwPpS5_-5MViuoDugaqZ7yjxXzXf
X-Proofpoint-GUID: KcgHCwPpS5_-5MViuoDugaqZ7yjxXzXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_01,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=696 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310045
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/2023 11:58 AM, Steven Rostedt wrote:
> On Tue, 31 Jan 2023 10:49:37 +0800
> Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
>
>>> A lot of systems that worry about hackers enable "panic_on_warn" which
>>> means that if the WARN_ON() triggers, the machine will crash, which will at
>>> most cause a DOS, but not something people can use to hack into the machine
>>> with.
>>
>> thanks, please help review the change.
> I'm fine with it. I can pull this into my tree (after it goes through all
> my testing with the other patches in queue).


thanks, once it merged into mainline, I will send patch for related modules.


