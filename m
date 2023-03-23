Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77936C6468
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCWKG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCWKGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:06:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B311A;
        Thu, 23 Mar 2023 03:06:25 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N9KsHO030295;
        Thu, 23 Mar 2023 10:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=YMCzFX0wFvPyV9Du8i5juA6LlfSqGiBnejH4z9vM26A=;
 b=ibl/rwpDu6CHODKSAFVcT2MfOqNGisHHhJE1m7uF1+94dVgblqq8J3qeAogmbXq2deYk
 yPofq+xwTY9dKbe6kcAS4FpiWjdFBthz4Bfi3n5NTRWhXoAT7l1rZXWc4l1n0rxbK1fh
 c7XvUK4+plTSekS/vuKKxeIU26GbkaEJ37Ir+Pg9fE1+nIFcpL2Aj40XMxJTuOWwLG0I
 5HFLnTTwe4sKNCSq4rqnuVyk2taX60ykgbjvjxfaqiDLKskuk8Wcum1LSDnxqHLGVGKs
 7NUP2ZqzcBHzQBOo6ohHRGw68PxpI0wSbgVwA0F816eWzLssuayOIQzDP0hUr0leHaun bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgm2b91y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:06:22 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32N9q9kc024217;
        Thu, 23 Mar 2023 10:06:21 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgm2b91xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:06:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32N8kn84022299;
        Thu, 23 Mar 2023 10:06:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pd4x6f6rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:06:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NA6FeA45941404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 10:06:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE3F320065;
        Thu, 23 Mar 2023 10:06:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B1FE20071;
        Thu, 23 Mar 2023 10:06:15 +0000 (GMT)
Received: from osiris (unknown [9.152.212.90])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Mar 2023 10:06:15 +0000 (GMT)
Date:   Thu, 23 Mar 2023 11:06:15 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH 2/6] tools/perf/json: Add cache metrics for s390 z16
Message-ID: <ZBwkl77/I31AQk12@osiris>
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
 <20230313080201.2440201-2-tmricht@linux.ibm.com>
 <CAP-5=fW=xVYzkgQ4vUyzkiK-oQjUQ=hLwcLT6D8VjtVCXH5oSQ@mail.gmail.com>
 <ZA9sYL/re/aNVpo+@kernel.org>
 <1ee6884a-2d92-68d9-0917-3ae4f5390714@linux.ibm.com>
 <CAP-5=fUtJsvAtrhe4xESoQc8U15WJ8BWREbH51OKoA218uJLzw@mail.gmail.com>
 <ZBDo2GiuUTrHhd2L@kernel.org>
 <ZBtsNTt6Fbp1Lg3t@kernel.org>
 <9632bc6c-276e-d0d6-b6d9-efe91fe3a1e2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9632bc6c-276e-d0d6-b6d9-efe91fe3a1e2@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xkflmBt1FXyCFrLF4_WeGFxEVgEOtcLF
X-Proofpoint-ORIG-GUID: 4pggtU434zgXYtdwaBcUmSDNu2tDufoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=773
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230075
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:51:16AM +0100, Thomas Richter wrote:
> On 3/22/23 21:59, Arnaldo Carvalho de Melo wrote:
> > While trying to cross build to s390 on:
> > 
> > ubuntu:18.04
> > 
> > using python3
> >  
> > 
> >    CC      /tmp/build/perf/tests/parse-events.o
> > Exception processing pmu-events/arch/s390/cf_z16/extended.json
> > Traceback (most recent call last):
> >   File "pmu-events/jevents.py", line 997, in <module>
> >     main()
> >   File "pmu-events/jevents.py", line 979, in main
> >     ftw(arch_path, [], preprocess_one_file)
> >   File "pmu-events/jevents.py", line 935, in ftw
> >     ftw(item.path, parents + [item.name], action)
> >   File "pmu-events/jevents.py", line 933, in ftw
> >     action(parents, item)
> >   File "pmu-events/jevents.py", line 514, in preprocess_one_file
> >     for event in read_json_events(item.path, topic):
> >   File "pmu-events/jevents.py", line 388, in read_json_events
> >     events = json.load(open(path), object_hook=JsonEvent)
> >   File "/usr/lib/python3.6/json/__init__.py", line 296, in load
> >     return loads(fp.read(),
> >   File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
> >     return codecs.ascii_decode(input, self.errors)[0]
> > UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 4271: ordinal not in range(128)
> > 
> >
> 
> Hmmm, this is very strange. After reading this mail I installed Ubuntu 18.04
> on my s390 system. The build works fine, no errors at all.
> 
> 
> # pmu-events/jevents.py s390 all pmu-events/arch pmu-events/pmu-events.c
> # ll pmu-events/pmu-events.c
> -rw-r--r-- 1 root root 317284 Mar 23 10:46 pmu-events/pmu-events.c
> #
> 
> The file has the correct contents and the build works fine too.
> # make 

The file contains UTF-8 characters, which were already present before
your patch. Guess you need to provide an addon patch which converts to
plain ASCII.
