Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC64D626E96
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 09:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiKMIv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 03:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiKMIvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 03:51:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204E13D75
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 00:51:42 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AD8nkjR039083;
        Sun, 13 Nov 2022 08:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zYXKdQKcR2j7x8Ifo8hnkIpJpIWAo3z7o0zmDJdO57Y=;
 b=mdo9wdrwT6ezTQWFKDusQmx2WJUy6jmVKODmg3xRY8zE5WcODwXGVwea8jGlRNiifjpv
 rVxitgjsRxr+UGDNUaSItWA8Wpqjz2atAzpDBQvyOBhU/eQtUc9q1/mMmHO/5P2ev6yQ
 a4BPYR9VOHR4qPeEXYRbOIlfuqQYO+KebvgiHI+N+3G54fzjaK2trfMdz0SBBmDNzmxt
 0WoM4ScIu/JZfI9a/tDHj8vIM1EO1j8CXFCybGHnvgZd21buUiIVU7rJbs3QEHfJX8fs
 t/gR58jlgQ2LqVPNmR3Kea1WcRRBH037HNaMMRKY1QGLxXqueylHSNPgHEwOA1jNIUIV 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ktwds00xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 08:51:12 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AD8oVXv001507;
        Sun, 13 Nov 2022 08:51:12 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ktwds00uj-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 08:51:12 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AD7pAC7013780;
        Sun, 13 Nov 2022 07:56:32 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3kt3498kqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 07:56:32 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AD7uWsE21496372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 07:56:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDAE05805A;
        Sun, 13 Nov 2022 07:56:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34C8158051;
        Sun, 13 Nov 2022 07:56:22 +0000 (GMT)
Received: from [9.160.60.23] (unknown [9.160.60.23])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 13 Nov 2022 07:56:21 +0000 (GMT)
Message-ID: <34112324-de67-55eb-92bc-181a98c4311c@linux.vnet.ibm.com>
Date:   Sun, 13 Nov 2022 13:26:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 0/9] Add latency priority for CFS class
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
From:   shrikanth suresh hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20221028093403.6673-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2CDum0LG8NnAnEXZU0lbY_CFEhSiqxcK
X-Proofpoint-GUID: uMDDQf1TnZepwe486maGytKiZkd28nPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-13_05,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 mlxlogscore=833
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211130054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This patchset restarts the work about adding a latency priority to describe
> the latency tolerance of cfs tasks.
>
>
Hi Vincent.
  
Tested the patches on the power10 machine. It is 80 core system with SMT=8. i.e
total of 640 cpus. on the large workload which mainly interacts with the
database there is minor improvement of 3-5%.

the method followed is creating a cgroup, assigning a latency nice value of -20,
-10, 0 and adding the tasks to procs of the cgroup. outside of cgroup, stress-ng
load is running and it is not set any latency value. stress-ng --cpu=768 -l 50

with microbenchmarks, hackbench the values are more or less the same. for large
process pool of 60, there is 10% improvement. schbench tail latencies show
significant improvement with low and medium load upto 256 groups. only 512
groups shows a slight decline.

Hackbench (Iterations or N=50)
Process             6.1_Base        6.1_Latency_Nice
10                      0.13            0.14
20                      0.18            0.18
30                      0.24            0.25
40                      0.34            0.33
50                      0.40            0.41
60                      0.53            0.49

schbench (Iterations or N=5)

Groups: 1
                     6.1_Base        6.1_Latency_Nice
50.0th:                 10.8             9.8
75.0th:                 12.4            11.4
90.0th:                 14.2            13.2
95.0th:                 15.6            14.6
99.0th:                 27.8            19.0
99.5th:                 38.0            21.6
99.9th:                 66.2            25.4

Groups: 2
                     6.1_Base        6.1_Latency_Nice
50.0th:                 11.2            10.8
75.0th:                 13.2            12.4
90.0th:                 15.0            15.0
95.0th:                 16.6            16.6
99.0th:                 22.4            22.8
99.5th:                 23.8            27.8
99.9th:                 30.2            45.6

Groups: 4
                     6.1_Base        6.1_Latency_Nice
50.0th:                 13.8            11.2
75.0th:                 16.0            13.2
90.0th:                 18.6            15.2
95.0th:                 20.4            16.6
99.0th:                 28.8            21.6
99.5th:                 48.8            25.2
99.9th:                900.2            47.0

Groups: 8
                     6.1_Base        6.1_Latency_Nice
50.0th:                 17.8            14.4
75.0th:                 21.8            17.2
90.0th:                 25.4            20.4
95.0th:                 28.0            22.4
99.0th:                 52.8            28.4
99.5th:                156.4            32.6
99.9th:               1990.2            52.0

Groups: 16
                     6.1_Base        6.1_Latency_Nice
50.0th:                 26.0            21.0
75.0th:                 33.0            27.8
90.0th:                 39.6            34.4
95.0th:                 43.4            38.6
99.0th:                 66.8            48.8
99.5th:                170.6            60.6
99.9th:               3308.8           201.6

Groups: 32
                     6.1_Base        6.1_Latency_Nice
50.0th:                 40.8            38.6
75.0th:                 55.4            52.8
90.0th:                 67.0            64.2
95.0th:                 74.2            71.6
99.0th:                106.0            90.0
99.5th:                323.8           133.0
99.9th:               4789.6           459.2

Groups: 64
                     6.1_Base        6.1_Latency_Nice
50.0th:                 72.6            68.2
75.0th:                103.4            97.8
90.0th:                127.6           120.0
95.0th:                141.2           132.0
99.0th:                343.4           158.4
99.5th:               1609.0           180.8
99.9th:               6571.2           686.6

Groups: 128
                     6.1_Base        6.1_Latency_Nice
50.0th:                147.2           147.2
75.0th:                216.4           217.2
90.0th:                268.4           268.2
95.0th:                300.6           294.8
99.0th:               3500.0           638.6
99.5th:               5995.2          2522.8
99.9th:              10390.4          9451.2

Groups: 256
                     6.1_Base        6.1_Latency_Nice
50.0th:                340.8           333.2
75.0th:                551.8           530.2
90.0th:               3528.4          1919.2
95.0th:               7312.8          5558.4
99.0th:              14630.4         12912.0
99.5th:              17955.2         14950.4
99.9th:              23059.2         20230.4

Groups: 512
                     6.1_Base        6.1_Latency_Nice
50.0th:               1021.8           990.6
75.0th:               9545.6         10044.8
90.0th:              20972.8         21638.4
95.0th:              29971.2         30291.2
99.0th:              42355.2         46707.2
99.5th:              48550.4         52057.6
99.9th:              58867.2         60147.2

Tested-by: shrikanth Hegde <sshegde@linux.vnet.ibm.com>

