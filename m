Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BB7648E05
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLJJk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:40:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D68D16486
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:40:27 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BA7MCRL012497;
        Sat, 10 Dec 2022 09:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=7wdxXQ/YDjdGrXtTIVKFloGT0vkP/vqgAOXwNSGgSe0=;
 b=nJ1aHC3HRw3Zeq/Qq0S2t9PYo9mFrs9/nTBctpvBBabgWTrA9T0WLH8rHfAb2iZW5AfX
 aiPuFIShuQXvz+QgXcv3Er3NRZl1bID+6aVambvjsrwhDGTx5La1R9EszTohJRz3MG7Z
 Yk3hZ926gQBTdGEXy8p6byUHrPTzj5Eyvb6ffxJGTHs2hkYUomG0b242Tp3NZLGAriKW
 4oGRhwxSWrudcBM+U/1Vot3s8YFlYGufGDJVXYbAKcOTSD/kQ/useXIxhE4K1seLEGIQ
 BgebmrEScLDw4OxgzD+kcrO2NKz/dvJZeMAt9IuECiFka90eXWBFvBGRB8RsNXT6zSs0 +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mchw754hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Dec 2022 09:39:50 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BA9TAhs019422;
        Sat, 10 Dec 2022 09:39:49 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mchw754h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Dec 2022 09:39:49 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2BA4LYLv029523;
        Sat, 10 Dec 2022 09:39:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3mchcer7xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Dec 2022 09:39:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BA9dijs47513982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Dec 2022 09:39:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A49620049;
        Sat, 10 Dec 2022 09:39:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46B2D20040;
        Sat, 10 Dec 2022 09:39:44 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 10 Dec 2022 09:39:44 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nolibc: add support for s390
References: <20221209141939.3634586-1-svens@linux.ibm.com>
        <20221209141939.3634586-3-svens@linux.ibm.com>
        <20221210090728.GB21743@1wt.eu> <yt9dmt7vtxf3.fsf@linux.ibm.com>
        <20221210093734.GE21743@1wt.eu>
Date:   Sat, 10 Dec 2022 10:39:43 +0100
In-Reply-To: <20221210093734.GE21743@1wt.eu> (Willy Tarreau's message of "Sat,
        10 Dec 2022 10:37:34 +0100")
Message-ID: <yt9dilijtx5s.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oJ52od8cfO7lGkTbv66RHw8YUSNRfjIV
X-Proofpoint-GUID: I0Zc0CFAgduK_-7_FLBcPMi8zQ-NFa99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-10_02,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 adultscore=0 mlxlogscore=689 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212100084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> On Sat, Dec 10, 2022 at 10:34:08AM +0100, Sven Schnelle wrote:
>> So it should be:
>> 
>> >> +#elif defined(__s390x__)
>> >> +#include "arch-s390.h"
>> 
>> I'm fine with both - either you fixing it up or me sending a v2.
>
> As you like. If you prefer to rename the file to s390x as your colleague
> suggested, I'll then ask you to send a v2. Otherwise either Paul or I can
> drop that 'x' in the #include.

Just drop the 'x'. Thanks! :)
