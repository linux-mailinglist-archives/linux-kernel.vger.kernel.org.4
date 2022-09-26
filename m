Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BE15EA5AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbiIZMKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbiIZMJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:09:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590780536;
        Mon, 26 Sep 2022 03:56:42 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QAhbYw005070;
        Mon, 26 Sep 2022 10:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OGJKSlqoXKxoA/uCnsq1KdUnfrdyKrqCAxO0X7OqO6g=;
 b=brgd3d4QC5mZEdjULZPHjchuKI38BKW6xFci0oN11Kx8WEIbfwgZURmy/3cbD+l5qjCB
 bJqur8uYh1peHvCY8pfrqk3p9epK58S6DlsEziCryolsR4qIHEiRLgqitgEjIVrld1z3
 5SpV0wc3qgrpIZN40YFlXBb+D6q4WA2njsLamFijJRhbSPaEBaW2p9O3OKOmIXB78vTN
 8ReDjSJkHKKMx0t/kiFbhG48BJvPzHWce7JiCxP9gjSeVPCuy4U0UdLVz04xezSGmo70
 Yl17EHZYDTqPt+B/a3y2Fa7l8KBZsx5l7H7XHtIYV7K41rG/4J/pO4gBsI5+qCZ5gaqa RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3juak088yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 10:55:27 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28QAjQ4N012595;
        Mon, 26 Sep 2022 10:55:27 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3juak088xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 10:55:26 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28QAotgF004185;
        Mon, 26 Sep 2022 10:55:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3jssh91qdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 10:55:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28QAtMNK48562464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 10:55:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C7C5A404D;
        Mon, 26 Sep 2022 10:55:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB2BBA4055;
        Mon, 26 Sep 2022 10:55:21 +0000 (GMT)
Received: from [9.171.20.172] (unknown [9.171.20.172])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 10:55:21 +0000 (GMT)
Message-ID: <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
Date:   Mon, 26 Sep 2022 12:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
To:     peterz@infradead.org
Cc:     bigeasy@linutronix.de, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        oleg@redhat.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        tj@kernel.org, vincent.guittot@linaro.org, will@kernel.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
In-Reply-To: <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HzaczBsYMJGf_VysS-3qYL8JHjQ_2EYG
X-Proofpoint-ORIG-GUID: vHIBNoK6fiYBzfNDEGQjdW0OoGLEWa3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260067
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 26.09.22 um 10:06 schrieb Christian Borntraeger:
> 
> 
> Am 23.09.22 um 09:53 schrieb Christian Borntraeger:
>> Am 23.09.22 um 09:21 schrieb Christian Borntraeger:
>>> Peter,
>>>
>>> as a heads-up. This commit (bisected and verified) triggers a
>>> regression in our KVM on s390x CI. The symptom is that a specific
>>> testcase (start a guest with next kernel and a poky ramdisk,
>>> then ssh via vsock into the guest and run the reboot command) now
>>> takes much longer (300 instead of 20 seconds). From a first look
>>> it seems that the sshd takes very long to end during shutdown
>>> but I have not looked into that yet.
>>> Any quick idea?
>>>
>>> Christian
>>
>> the sshd seems to hang in virtio-serial (not vsock).
> 
> FWIW, sshd does not seem to hang, instead it seems to busy loop in
> wait_port_writable calling into the scheduler over and over again.

-#define TASK_FREEZABLE                 0x00002000
+#define TASK_FREEZABLE                 0x00000000

"Fixes" the issue. Just have to find out which of users is responsible.
