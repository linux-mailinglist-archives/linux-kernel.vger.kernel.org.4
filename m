Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB26DE407
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDKShe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKShc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:37:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4E3A98;
        Tue, 11 Apr 2023 11:37:30 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BHCUb6008150;
        Tue, 11 Apr 2023 18:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oJe2Li55wC5pjAdZ7BIhyOmj3PqDZqQ1WfnBAszZ1TA=;
 b=WfbIawjvAGvsMU8ukUfgdIcRsYI5KYc9IqrG/IJBRAtb8oPCOqrklV1RNgHUrM0m8k7t
 6PCQoviGzAMhWwUAV5euL3SP7v47++spd5oYNJg0abDTKAhzcQRbfgMrD04pAuVBZ3N/
 eLyz0zxqsKUN+4gBXqwuCcv749inak6sjjFGd9vfNVZlMnEYYJDBLXzq/tyLxFzPe9BU
 D0FhAhCa4eKz6pOCZzqLTh02jK/05zth47iejBHzNDzsgszthTvhKJgkUhXCepV6Ji3e
 jJX/h6cWof84po37zOFTrr+16q7ejbHx8SUwjx+3yNu7xPC2z3qcjrgI40XuwNIJgEE1 /g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pw0jpsrnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 18:36:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BIaogG020184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 18:36:50 GMT
Received: from [10.110.49.239] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 11:36:49 -0700
Message-ID: <bcdcee9b-f213-bc3c-d300-92a1e0138187@quicinc.com>
Date:   Tue, 11 Apr 2023 11:36:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
 <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
 <2023041015-lunar-dandelion-1b4e@gregkh>
 <ae44540f-8947-8efb-fb8d-45a84bd3fef3@quicinc.com>
 <2023041136-donator-faceplate-5f91@gregkh>
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <2023041136-donator-faceplate-5f91@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hlN2L9npwgxOYiye6LLp0KUxZ8pjtuci
X-Proofpoint-ORIG-GUID: hlN2L9npwgxOYiye6LLp0KUxZ8pjtuci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_11,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304110169
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2023 11:34 PM, Greg Kroah-Hartman wrote:
> On Mon, Apr 10, 2023 at 04:32:49PM -0700, John Moon wrote:
>>>> According to this tool, it looks like we broke a lot of UAPI
>>>> headers in the previous MW (between v6.2 and v6.3-rc1).
>>>
>>> That's not ok, and needs to be fixed, otherwise this is useless as no
>>> one can rely on it at all.
>>>
>>
>> Right, there are several classes of false positives that we've documented
>> and when examining thousands of commits at time, it'll flag many things.
>>
>> For some comparison, if you run checkpatch on the same changeset
>> (v6.2..v6.3-rc1), you get 995 errors and 7,313 warnings. Still, checkpatch
>> is helpful for spot-checks.
> 
> checkpatch.pl does not matter, it is a "hint", and many patches
> explicitly ignore it (think about patches in the staging tree, you could
> fix up one checkpatch issue for a line, but ignore another one as you
> are not supposed to mix them up.)
> 
> Also for some subsystems, checkpatch does not matter because their
> codebase is old and follows different rules.  And in some places,
> checkpatch is just wrong, because it's a perl script and can not really
> parse code.
> 
> So NEVER use that as a comparison to the user/kernel abi please.  It's a
> false comparison.
>

Fair enough. I was just trying to frame this tool as a "hint" as well. :)

>>
>> Others do not seem to be intentional:
>>
>>   Addition/use of flex arrays:
>>     - include/uapi/linux/rseq.h (f7b01bb0b57f)
>>     - include/uapi/scsi/scsi_bsg_mpi3mr.h (c6f2e6b6eaaf)
> 
> That is not a breakage, that's a tool problem.
> 
>>   Type change:
>>     - include/uapi/scsi/scsi_bsg_ufs.h (3f5145a615238)
> 
> Again, not a real breakage, size is still the same.
>

Would you find the tool more useful if it simply filtered out all 
instances where the size of the type did not change? This would filter 
out the following which the tool currently flags:

- enum expansions
- reserved field expansions
- expansions of a struct with a flex array at the end
- type changes
- re-ordering of existing members
- ...others?

These changes aren't _always_ safe, but if you assume the kernel 
developer is doing something reasonable, then maybe it's okay. Maybe we 
could hide these checks behind something like a "--pedantic" flag?

This logic is actually trivial to add. Filtering out issues where the 
type size stays the same brings us down to 14 failures in that same MW 
changeset. 8 of them are file removals and the 6 remaining flags are 
additions to existing structs or intentional removals of APIs.

LMK what you think and I can work this into a v6 patch.

>>   Additions into existing struct:
>>     - include/uapi/drm/amdgpu_drm.h (b299221faf9b)
>>     - include/uapi/linux/perf_event.h (09519ec3b19e)
>>     - include/uapi/linux/virtio_blk.h (95bfec41bd3d)
> 
> Adding data to the end of a structure is a well-known way to extend the
> api, in SOME instances if it is used properly.
> 
> So again, not a break.
>

I don't know of a way the tool could be smart enough to decide if the 
additions are done properly in the proper instances. Seems appropriate 
that the tool would flag these changes for closer human review.

Thanks,
John
