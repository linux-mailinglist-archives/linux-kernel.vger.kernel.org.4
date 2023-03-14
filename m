Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96B6B8D30
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCNIWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCNIWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:22:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA14212BA;
        Tue, 14 Mar 2023 01:20:49 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E8Dohr031151;
        Tue, 14 Mar 2023 08:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UGUuubsg8NM4Edel0CsIn+VForxMmGR6kLhZRgdCj2Q=;
 b=SgunEI/JBBK8dcMlpQDsqKkJcLynBHYyso4p/DqkKdBWEJldvcKfOsIWAR5qqwWE4SBv
 vfx8WYj5Iz6y8uUiQNlbARXtM2Lt6SeSvldd9eWGXl8/Z+pRbAGpUXBZu1bdi7svPv2k
 mC4xuA6vEPFebqJIYoifVs80k17ZT6eEcdu1FXmC6nzM7GdgW20Rk7IQ4zW4KbwHQDJr
 q7hSVjJAm+e0K9ls89eK+wKy9G5QRoUemfI/13OIf+L3Ig95rxmOdLaU12m3Dsy5cRxc
 +gMzCxSYqyKJpWTvOnInZayUKI41hjRi2yDBEF9ZFPpjeJfsCRWuTqpLZ0OuaVIDJ7KA ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pan7q068m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 08:20:44 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32E8FQUc004771;
        Tue, 14 Mar 2023 08:20:43 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pan7q067q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 08:20:43 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E6rY6L028663;
        Tue, 14 Mar 2023 08:20:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96mf28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 08:20:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32E8KcPL48300522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 08:20:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FFE52007B;
        Tue, 14 Mar 2023 08:20:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A46520077;
        Tue, 14 Mar 2023 08:20:38 +0000 (GMT)
Received: from [9.152.212.251] (unknown [9.152.212.251])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 08:20:38 +0000 (GMT)
Message-ID: <1ee6884a-2d92-68d9-0917-3ae4f5390714@linux.ibm.com>
Date:   Tue, 14 Mar 2023 09:20:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/6] tools/perf/json: Add cache metrics for s390 z16
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
 <20230313080201.2440201-2-tmricht@linux.ibm.com>
 <CAP-5=fW=xVYzkgQ4vUyzkiK-oQjUQ=hLwcLT6D8VjtVCXH5oSQ@mail.gmail.com>
 <ZA9sYL/re/aNVpo+@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <ZA9sYL/re/aNVpo+@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qq6uSS14nG4RQSyb2ZIKTRv6b6nQDpJ2
X-Proofpoint-ORIG-GUID: 6XtWFnT2JxSMhwJjaMoaTzxgNqEj51ZJ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_02,2023-03-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303140068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 19:33, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 13, 2023 at 08:22:44AM -0700, Ian Rogers escreveu:
>> On Mon, Mar 13, 2023 at 1:30 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>
>>> Add metrics for s390 z16
>>> - Percentage sourced from Level 2 cache
>>> - Percentage sourced from Level 3 on same chip cache
>>> - Percentage sourced from Level 4 Local cache on same book
>>> - Percentage sourced from Level 4 Remote cache on different book
>>> - Percentage sourced from memory
>>>
>>> For details about the formulas see this documentation:
>>> https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Formulas%20including%20z16%20-%20May%202022_1.pdf
>>>
>>> Outpuf after:
>>>  # ./perf stat -M l4rp -- dd if=/dev/zero of=/dev/null bs=10M count=10K
>>>  .... dd output deleted
>>>
>>>  Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=10M count=10K':
>>>
>>>                  0      IDCW_OFF_DRAWER_CHIP_HIT         #     0.00 l4rp
>>>            431,866      L1I_DIR_WRITES
>>>              2,395      IDCW_OFF_DRAWER_IV
>>>                  0      ICW_OFF_DRAWER
>>>                  0      IDCW_OFF_DRAWER_DRAWER_HIT
>>>              1,437      DCW_OFF_DRAWER
>>>        425,960,793      L1D_DIR_WRITES
>>>
>>>       12.165030699 seconds time elapsed
>>>
>>>        0.001037000 seconds user
>>>       12.162140000 seconds sys
>>>
>>>  #
>>>
>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
>>
>> Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks, applied the first two patches, please address the review
> suggestions for patches 3-6 and resubmit only those.
> 
> The patches will be in the public perf-tools-next branch later today.
> 
> - Arnaldo
> 

I would really prefer the current implementation without using "ScaleUnit": "100%"
The reason is that these formulars are given to me from the s390 Performance team.
They want to use the exact same formulars on all platforms running on s390
which includes z/OS and z/VM. This way they are sure to get the same numbers.

Hope this background info helps.

Thanks a lot.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

