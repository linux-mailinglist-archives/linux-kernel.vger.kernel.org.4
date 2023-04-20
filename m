Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C36E8A91
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjDTGlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjDTGlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:41:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50869F;
        Wed, 19 Apr 2023 23:41:41 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K5ORex029612;
        Thu, 20 Apr 2023 06:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MkwLPhcXNE7rKgBs4lGpG3L+FtxzGE6kaVUZYN01psA=;
 b=b03E0RQIc5eDMnAeYdTzoH7UtHSXzGIZelGy8K8OH/Nh3fRrRzIqk4RqyRrlbJgiBtBq
 i1In4SDG1+/l8RMldRaZzNYmYnz0UP14N9MYKysHBbyWfSM6znMUalg3r3NEj7dMpUXD
 XgzbjFYndgKAZcbOkY+a4DldjUrN1dqPKeXdvf3S7tY6C2hPxJEdkXDc2DnFtP7Up68v
 DEN+BKzeeaQsfTRwwaM6STCq6OcVoLCfXvqLIljx50RUq3shh5UpFKWdvTPDD1Qa966o
 zA8vVUleyA6AojacSK5f1gK/wssCVWj1fiD0pinOEvCNICSxsVmya7SfD80jv49RkYPA gw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2nn817hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 06:41:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33K6fWTf031983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 06:41:32 GMT
Received: from [10.216.56.220] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 19 Apr
 2023 23:41:27 -0700
Message-ID: <647f915e-b08a-1bc9-2082-70140521a644@quicinc.com>
Date:   Thu, 20 Apr 2023 12:11:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/3] cpuidle: psci: Move enabling OSI mode after power
 domains creation
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <andersson@kernel.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <wingers@google.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <sudeep.holla@arm.com>,
        <jwerner@chromium.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>
References: <20230414055502.23920-1-quic_mkshah@quicinc.com>
 <20230414055502.23920-3-quic_mkshah@quicinc.com>
 <CAPDyKFo5UhOca-DvOKOZWcBrcK8ONdSO8-M=8fE6kkwkPuoCww@mail.gmail.com>
Content-Language: en-US
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <CAPDyKFo5UhOca-DvOKOZWcBrcK8ONdSO8-M=8fE6kkwkPuoCww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jI25yhL8WYhwE9m6jERkG-YkoLoZfoSm
X-Proofpoint-GUID: jI25yhL8WYhwE9m6jERkG-YkoLoZfoSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_03,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=886
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200053
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On 4/18/2023 1:42 PM, Ulf Hansson wrote:
> O
>
>          /* Bail out if not using the hierarchical CPU topology. */
>          if (!pd_count)
> -               goto no_pd;
> +               goto remove_pd;
> We should return 0 here instead, right?
right. will fix in next revision.
>>          /* Link genpd masters/subdomains to model the CPU topology. */
>>          ret = dt_idle_pd_init_topology(np);
>>          if (ret)
>> -               goto remove_pd;
>> +               goto remove_pd_topology;
> This looks wrong to me. Shouldn't we continue to goto the "remove_pd"
> label for this error path?
We should need to remove already added subdomains via 
of_genpd_add_subdomain() if one of them fails.
So this look ok to me.
>
>> +
>> +       /* let's try to enable OSI. */
>> +       ret = psci_set_osi_mode(use_osi);
>> +       if (ret)
>> +               goto remove_pd_topology;
>>
>>          pr_info("Initialized CPU PM domain topology using %s mode\n",
>>                  use_osi ? "OSI" : "PC");
>>          return 0;
>>
>> -put_node:
>> -       of_node_put(node);
>> +remove_pd_topology:
>> +       dt_idle_pd_remove_topology(np);
>>   remove_pd:
>>          psci_pd_remove();
>> +put_node:
>> +       of_node_put(node);
> This of_node_put() should only be called if we break the
> "for_each_child_of_node" loop above because of an error, I think.
> Perhaps it's cleaner to just move this within the loop?
yes will move inside loop.

Thanks,
Maulik
