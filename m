Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AD25EA852
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiIZOYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiIZOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:23:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4878D18D0E9;
        Mon, 26 Sep 2022 05:33:02 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QAgGR2040377;
        Mon, 26 Sep 2022 12:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LwYe0rqnIwkPr/6i34zbZrq42JrO4q9+e/lsvkT4moU=;
 b=hvhVPKQN1FEJWOPSo8YHe2vB4Edyjc8NAnzkgCunOr02abENXcy0nhFfhDVQC2a5OdGi
 2/BZwXgiPgvAY4OW3ZXAvRXU2y4bCmY8tuBP6aJ28k+e0jH8gc6r/ZNsNilj1g23BOML
 nPPpmnkixH2xpttfDEmxVOLNPxz9n99ECRK6NwNa1uNNITzi370mVDYtCGW15fncK8U+
 HuXu+w87roMtE0H6WNI1AJ/ORASSQQtTay4gYRqedHx6rwlQXv4bVfB5pD5ehgoSVwgI
 B4+1fqZTh6T3eqB6fyzmy9zprGc3M7e94yLW1KUVD+8A6rJ2AUiJdCik33fy2htsOsSD Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juaj9u48j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 12:32:31 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28QBg1iF035764;
        Mon, 26 Sep 2022 12:32:30 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juaj9u47k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 12:32:30 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28QCLRAx028467;
        Mon, 26 Sep 2022 12:32:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3jssh8st30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 12:32:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28QCWP4T50659810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 12:32:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD4C2A405B;
        Mon, 26 Sep 2022 12:32:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03EE4A4064;
        Mon, 26 Sep 2022 12:32:25 +0000 (GMT)
Received: from [9.171.20.172] (unknown [9.171.20.172])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 12:32:24 +0000 (GMT)
Message-ID: <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
Date:   Mon, 26 Sep 2022 14:32:24 +0200
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
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Amit Shah <amit@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
In-Reply-To: <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _396JyvztbuSkpeimeTAG1CEme02xONc
X-Proofpoint-ORIG-GUID: pMmy3F52peTfAA4qOM_y04VF95GksKs4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260079
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 26.09.22 um 12:55 schrieb Christian Borntraeger:
> 
> 
> Am 26.09.22 um 10:06 schrieb Christian Borntraeger:
>>
>>
>> Am 23.09.22 um 09:53 schrieb Christian Borntraeger:
>>> Am 23.09.22 um 09:21 schrieb Christian Borntraeger:
>>>> Peter,
>>>>
>>>> as a heads-up. This commit (bisected and verified) triggers a
>>>> regression in our KVM on s390x CI. The symptom is that a specific
>>>> testcase (start a guest with next kernel and a poky ramdisk,
>>>> then ssh via vsock into the guest and run the reboot command) now
>>>> takes much longer (300 instead of 20 seconds). From a first look
>>>> it seems that the sshd takes very long to end during shutdown
>>>> but I have not looked into that yet.
>>>> Any quick idea?
>>>>
>>>> Christian
>>>
>>> the sshd seems to hang in virtio-serial (not vsock).
>>
>> FWIW, sshd does not seem to hang, instead it seems to busy loop in
>> wait_port_writable calling into the scheduler over and over again.
> 
> -#define TASK_FREEZABLE                 0x00002000
> +#define TASK_FREEZABLE                 0x00000000
> 
> "Fixes" the issue. Just have to find out which of users is responsible.

So it seems that my initial test was not good enough.

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9fa3c76a267f..e93df4f735fe 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -790,7 +790,7 @@ static int wait_port_writable(struct port *port, bool nonblock)
                 if (nonblock)
                         return -EAGAIN;
  
-               ret = wait_event_freezable(port->waitqueue,
+               ret = wait_event_interruptible(port->waitqueue,
                                            !will_write_block(port));
                 if (ret < 0)
                         return ret;

Does fix the problem.
My initial test was the following

--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -790,10 +790,8 @@ static int wait_port_writable(struct port *port, bool nonblock)
                 if (nonblock)
                         return -EAGAIN;
  
-               ret = wait_event_freezable(port->waitqueue,
+               wait_event(port->waitqueue,
                                            !will_write_block(port));
-               if (ret < 0)
-                       return ret;
         }
         /* Port got hot-unplugged. */
         if (!port->guest_connected)

and obviously it did not provide an exit path.
