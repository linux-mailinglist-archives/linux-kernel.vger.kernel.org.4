Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE36C9A81
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 06:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjC0EWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 00:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjC0EWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 00:22:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B9746B7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 21:22:37 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R2VAR6019849;
        Mon, 27 Mar 2023 04:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=x+nkVH5X1xbXP2STnQdsIs6we5idVPglFNbNT+oCZBU=;
 b=NGdSx/Wl07/B3Lx5ahUYWGCqzL2LGQ1N02GvHT0c5nyIGKW8hCnjsspKd64FDTdeTLzR
 /sRhq608yvTXu5kgcfqdKCgHGm59h5ccyh4gZDth5liz4nKvBXV2gSu/Vfpv+YStWXlj
 wWBL4njoh5QeDapKII/vU3Kt4hJOmEDVLOow+0LqGXyYbA6orAHtJ2TLI3dC4MlmJXyQ
 ZGxpdKc1G8rZ9uBhGWFvM3wQDXMjDn3r8Od8WFxqkKX4v0Y3uazchwLJ87ACHea49bKw
 GhZ0T6G1xLPI/m0yfEMHGQjt1pou5DwPlnm91OtbTBhOZBmhLTlZZQAWKcudayZNEirc Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pjahs50v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 04:22:21 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32R4JNJY023003;
        Mon, 27 Mar 2023 04:22:21 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pjahs50ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 04:22:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32QG1Q4l028889;
        Mon, 27 Mar 2023 04:22:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3phr7fj9ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 04:22:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32R4MFc846399802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 04:22:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92D522004B;
        Mon, 27 Mar 2023 04:22:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4A8020040;
        Mon, 27 Mar 2023 04:22:12 +0000 (GMT)
Received: from [9.43.36.124] (unknown [9.43.36.124])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Mar 2023 04:22:12 +0000 (GMT)
Message-ID: <a21aa4e1-506a-916c-03bd-39d7403c7941@linux.ibm.com>
Date:   Mon, 27 Mar 2023 09:52:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: perf tools power9 JSON files build breakage on ubuntu 18.04 cross
 build
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
References: <ZBxP77deq7ikTxwG@kernel.org>
Content-Language: en-US
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <ZBxP77deq7ikTxwG@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ya3Y1osuSgBTj2FWlyxuE5Obmj3NBv-1
X-Proofpoint-ORIG-GUID: 8vbKFSX2PP0V2De_L527-HruOj3vxEqA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270034
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/23 18:41, Arnaldo Carvalho de Melo wrote:
> Exception processing pmu-events/arch/powerpc/power9/other.json
> Traceback (most recent call last):
>   File "pmu-events/jevents.py", line 997, in <module>
>     main()
>   File "pmu-events/jevents.py", line 979, in main
>     ftw(arch_path, [], preprocess_one_file)
>   File "pmu-events/jevents.py", line 935, in ftw
>     ftw(item.path, parents + [item.name], action)
>   File "pmu-events/jevents.py", line 933, in ftw
>     action(parents, item)
>   File "pmu-events/jevents.py", line 514, in preprocess_one_file
>     for event in read_json_events(item.path, topic):
>   File "pmu-events/jevents.py", line 388, in read_json_events
>     events = json.load(open(path), object_hook=JsonEvent)
>   File "/usr/lib/python3.6/json/__init__.py", line 296, in load
>     return loads(fp.read(),
>   File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
>     return codecs.ascii_decode(input, self.errors)[0]
> UnicodeDecodeError: 'ascii' codec can't decode byte 0xc2 in position 55090: ordinal not in range(128)
>   CC      /tmp/build/perf/tests/expr.o
> pmu-events/Build:35: recipe for target '/tmp/build/perf/pmu-events/pmu-events.c' failed
> make[3]: *** [/tmp/build/perf/pmu-events/pmu-events.c] Error 1
> make[3]: *** Deleting file '/tmp/build/perf/pmu-events/pmu-events.c'
> Makefile.perf:679: recipe for target '/tmp/build/perf/pmu-events/pmu-events-in.o' failed
> make[2]: *** [/tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
> 
> 
> Now jevents is an opt-out feature so I'm noticing these problems.

Hi Arnaldo,
    Thanks for raising it. I will check this issue.

Thanks,
Kajol Jain

> 
> A similar fix for s390 was accepted today:
> 
> 
> https://lore.kernel.org/r/20230323122532.2305847-1-tmricht@linux.ibm.com
> https://lore.kernel.org/r/ZBwkl77/I31AQk12@osiris
