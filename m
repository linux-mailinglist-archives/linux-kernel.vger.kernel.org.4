Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC4A6091B1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 09:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiJWHps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 03:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJWHpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 03:45:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38986C12A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:45:45 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29N7Bu9L011244;
        Sun, 23 Oct 2022 07:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=DdL19aftCDBh/ECvqp1xFc1VEI20ljr9INS5cargBb4=;
 b=irpbEY9lqgTNw547IzrJQq2C5Ww1BlkGrsPwQLVrRYihAtOJyNmN6G4iyGSiZsEAPY3A
 oTJfmMlB4rcHjSPA897bhNscG0+E/vOUR/A4vmQt7al1gRNK9efHvSXGbgNM5RVqfB4a
 gOrjm5nlgCwFcvJ2RL/npt0MCRZv/FGcCMoaE/pHsctlYaySJubq+uPFcTqdSbTHsgBv
 UD9E3XyvXTf7w7U/4AeGIWtaYTY2/+xz3ZLE5ixtsiLA+8WDtkAR/ioCIwhplGdQrX8P
 8S0E4NXzhipwXeOMbxvrUDe7J3CrhhW38nnXIhur7/P/93R4NWxUJfGYd7/uYArBWWlx ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kd10srjbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Oct 2022 07:45:20 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29N7f9x3018456;
        Sun, 23 Oct 2022 07:45:20 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kd10srjb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Oct 2022 07:45:20 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29N7aPVO008215;
        Sun, 23 Oct 2022 07:45:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3kc8591e8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Oct 2022 07:45:17 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29N7jFs465601918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Oct 2022 07:45:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B04511C04A;
        Sun, 23 Oct 2022 07:45:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E34D11C04C;
        Sun, 23 Oct 2022 07:45:14 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.82.233])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 23 Oct 2022 07:45:14 +0000 (GMT)
Date:   Sun, 23 Oct 2022 09:45:13 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [PATCH RFC v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Message-ID: <Y1TxCTq5gxh4fIEd@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221003232033.3404802-1-jstultz@google.com>
 <20221003232033.3404802-3-jstultz@google.com>
 <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
 <Y0+/SAWUNRnhIW9b@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCpQuQn_84yqErF2noAYDwdwNJQF-pr4JKVp1eZzH=+f9w@mail.gmail.com>
 <Y1FDegctcU2LrYGT@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <Y1Q3vYjlFt/Imu5w@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Q3vYjlFt/Imu5w@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nKJVCwofD17k3BUzqOOe-C-aWODyeKIm
X-Proofpoint-GUID: e2PCv9anuV48p5jqlTX0k-a6iHr73z1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=840 lowpriorityscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210230047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 06:34:37PM +0000, Joel Fernandes wrote:
> > In my reading of your approach if you find a way to additionally
> > indicate long softirqs being handled by the remote ksoftirqd, it
> > would cover all obvious/not-corner cases.
> 
> How will that help? The long softirq executing inside ksoftirqd will disable
> preemption and prevent any RT task from executing.

Right. So the check to deem a remote CPU unfit would (logically) look like this:

(active | pending | ksoftirqd) & LONG_SOFTIRQ_MASK

> Did I miss something?

Or me :)

> thanks,
> 
>  - Joel
> 
