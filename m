Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9517167B081
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjAYLAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYLAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:00:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9219436FE7;
        Wed, 25 Jan 2023 03:00:42 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P9Dxvb006477;
        Wed, 25 Jan 2023 11:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=PV97j+QpGtIXyVnJleYyfcWoFSAMpegJ7+MrYuplsz4=;
 b=c22xrO8UF3Oj/J0XO82E2PvTh+ZiHP0o16b4C+J/g/BGpUYhTCpvN9jkYD3u11f+VRE0
 Hcpos6E9xH3oY8s+Akt0H/6v4R8IttLlnH0h7cYYEWfkklKMevSa1HH+hBrZfHkB82NB
 WorVqf4H8sGg42S0cLZu7Rx37ne3kXO3cfrTnpi/tR0aaWBKdDEQm5P27Nf/cw9yP6tS
 3QPyn77Ff4JYRS07z9zEqFhFCU3n6dO7zitVzeTgwgEkphcKNrynElNy5Ry+wiOLvd8I
 wnoQ6LqNrT/JYFfx1vVRkXLi1P3hmVhNuqF7Bv23bt8ellcJYW1tvUHzbD/03kItVzkS Nw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naakpkdup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 11:00:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30ONDDT2028677;
        Wed, 25 Jan 2023 11:00:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afd0gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 11:00:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PB01BW18022796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 11:00:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDBEE20043;
        Wed, 25 Jan 2023 11:00:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93D2220040;
        Wed, 25 Jan 2023 11:00:01 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jan 2023 11:00:01 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 15/49] ipc/shm: Use the vma iterator for munmap calls
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
        <20230120162650.984577-16-Liam.Howlett@oracle.com>
Date:   Wed, 25 Jan 2023 12:00:01 +0100
In-Reply-To: <20230120162650.984577-16-Liam.Howlett@oracle.com> (Liam
        R. Howlett's message of "Fri, 20 Jan 2023 11:26:16 -0500")
Message-ID: <yt9dh6wec21a.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1SF-VQ8XaTMWXdqnAj0gHluE9UzoDteO
X-Proofpoint-GUID: 1SF-VQ8XaTMWXdqnAj0gHluE9UzoDteO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_05,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

"Liam R. Howlett" <Liam.Howlett@oracle.com> writes:

> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Pass through the vma iterator to do_vmi_munmap() to handle the iterator
> state internally
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  ipc/shm.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

git bisect says this breaks the shm* testcase in ltp on (at least) s390:

# ./test.sh
tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
shmat01.c:124: TPASS: shmat() succeeded to attach NULL address
shmat01.c:92: TFAIL: shmat() failed: EINVAL (22)
shmat01.c:92: TFAIL: shmat() failed: EINVAL (22)
shmat01.c:92: TFAIL: shmat() failed: EINVAL (22)

Summary:
passed   1
failed   3
broken   0
skipped  0
warnings 0

#

Can you take a look? Thanks!

reverting the above commit fixes the issue.

Thanks,
Sven
