Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D451D6DCE25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjDJXdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJXdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:33:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4020E185;
        Mon, 10 Apr 2023 16:33:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ANVVci006187;
        Mon, 10 Apr 2023 23:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JWGCwAS2SPZcwfza4dJDZPfqNJEQn/jVjQYB6lof1wQ=;
 b=V0Fm5UeQ2OMo8kJvqrJv/56lZ2B4HszLUFFPhWKIa7VQGbOsYWhJhT9slmKd3/IXdpES
 YSiMbVhCXaottvBhDbyIXar/c5IQLe3fZyh/U5uxjpU4+aQnXOzmn5DR4fgrRJ+lZ6e4
 3vFhXGHo9oLWnyX+cKQf759NhOPwOIwbGpN3icBv6kgdxMJW6Iwv/5ZJu83dtGBsrwZB
 x07DTuhkWqkfQ53K0YLq/JE8qnU/XgbwaZWm+7VzlQL1UMgAq5k1GU/0Xq70tAJYkmje
 6DpFRKfeursfjLWxpXbPyNA96m2HueZlkwKkDCzkcE5tFdH7eCmlHnUdJRKDT4zGbOl4 XA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvj1ksag5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 23:32:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ANWqOQ014382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 23:32:52 GMT
Received: from [10.110.49.239] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 10 Apr
 2023 16:32:50 -0700
Message-ID: <ae44540f-8947-8efb-fb8d-45a84bd3fef3@quicinc.com>
Date:   Mon, 10 Apr 2023 16:32:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        "Matthias Maennich" <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
 <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
 <2023041015-lunar-dandelion-1b4e@gregkh>
Content-Language: en-US
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <2023041015-lunar-dandelion-1b4e@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UP2Oi11XV1DZUJx1uDYpt7-HiGAdaX9M
X-Proofpoint-ORIG-GUID: UP2Oi11XV1DZUJx1uDYpt7-HiGAdaX9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=986 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100205
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2023 11:45 AM, Greg Kroah-Hartman wrote:
> On Mon, Apr 10, 2023 at 07:03:05PM +0900, Masahiro Yamada wrote:
>> On Sat, Apr 8, 2023 at 5:35 AM John Moon <quic_johmoo@quicinc.com> wrote:
>>>
>>> While the kernel community has been good at maintaining backwards
>>> compatibility with kernel UAPIs, it would be helpful to have a tool
>>> to check if a commit introduces changes that break backwards
>>> compatibility.
>>>
>>> To that end, introduce check-uapi.sh: a simple shell script that
>>> checks for changes to UAPI headers using libabigail.
>>>
>>> libabigail is "a framework which aims at helping developers and
>>> software distributors to spot some ABI-related issues like interface
>>> incompatibility in ELF shared libraries by performing a static
>>> analysis of the ELF binaries at hand."
>>>
>>> The script uses one of libabigail's tools, "abidiff", to compile the
>>> changed header before and after the commit to detect any changes.
>>>
>>> abidiff "compares the ABI of two shared libraries in ELF format. It
>>> emits a meaningful report describing the differences between the two
>>> ABIs."
>>>
>>> The script also includes the ability to check the compatibility of
>>> all UAPI headers across commits. This allows developers to inspect
>>> the stability of the UAPIs over time.
>>>
>>> Signed-off-by: John Moon <quic_johmoo@quicinc.com>
>>
>>
>>
>> BTW, is there anybody (except the submitters) who loves this tool?
>> (or anybody who has ever evaluated this?)
> 
> I evaluated the first one, and yes, I do want this, but I haven't tested
> it out yet, sorry.
> 
> I get patches for header files all the time and hand-verifying that they
> don't break the abi is a pain at times
>

Agreed, this is the way we're using the tool internally. It's great as a 
quick spot-check on a change.

>> According to this tool, it looks like we broke a lot of UAPI
>> headers in the previous MW (between v6.2 and v6.3-rc1).
> 
> That's not ok, and needs to be fixed, otherwise this is useless as no
> one can rely on it at all.
> 

Right, there are several classes of false positives that we've 
documented and when examining thousands of commits at time, it'll flag 
many things.

For some comparison, if you run checkpatch on the same changeset 
(v6.2..v6.3-rc1), you get 995 errors and 7,313 warnings. Still, 
checkpatch is helpful for spot-checks.

"./scripts/check-uapi.sh -b v6.3-rc1 -p v6.2" flags 36 out of the 911 
files checked. Of those 36, 19 fell into the currently documented false 
positive categories:

Enum expansion: 17
Expanding into padded/reserved fields: 2

Beyond those, the tool appears to be flagging legitimate breakages.

Some fit into the definition of "intentional breakages" where support is 
being dropped or something is being refactored:

  File removals:
    - include/uapi/drm/i810_drm.h
    - include/uapi/drm/mga_drm.h
    - include/uapi/drm/r128_drm.h
    - include/uapi/drm/savage_drm.h
    - include/uapi/drm/sis_drm.h
    - include/uapi/drm/via_drm.h
    - include/uapi/linux/meye.h

  File moves:
    - include/uapi/misc/habanalabs.h

  Removal of struct:
    - include/uapi/linux/uuid.h (5e6a51787fef)
      - include/uapi/linux/mei.h (failed due to uuid.h)
      - include/uapi/linux/ublk_cmd.h (failed due to uuid.h)

Others do not seem to be intentional:

  Addition/use of flex arrays:
    - include/uapi/linux/rseq.h (f7b01bb0b57f)
    - include/uapi/scsi/scsi_bsg_mpi3mr.h (c6f2e6b6eaaf)

  Type change:
    - include/uapi/scsi/scsi_bsg_ufs.h (3f5145a615238)

  Additions into existing struct:
    - include/uapi/drm/amdgpu_drm.h (b299221faf9b)
    - include/uapi/linux/perf_event.h (09519ec3b19e)
    - include/uapi/linux/virtio_blk.h (95bfec41bd3d)

Is there something I'm missing that makes these changes false positives? 
If so, I'd be happy to add on to the documentation and work towards a 
way to filter them out.

In the mean time, we will start a thread on the libabigail mailing list 
to see if there's a way to add flags such as --ignore-enum-expansion, 
--ignore-expansion-into-reserved-fields, etc. Enum expansion seems to be 
making up the largest portion of false positives, so would be the best 
thing to filter out.

>> The script takes some time because it builds many objects
>> internally.
>>
>> However, once this script starts running, you must not hit Ctrl-C.
>> If you do it, your repository will be sprinkled with a ton
>> of untracked files.
> 
> That needs to be unwound and fixed.
> 
>> CAVEAT
>> This tool runs 'git checkout' a couple of times internally.
>> If you interrupt it, your worktree might be messed up.
> 
> ctrl-c can be properly caught and the git state needs to be restored for
> this to be able to be accepted.
>

Yes, this can be taken care of.

> thanks,
> 
> greg k-h
