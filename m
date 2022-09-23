Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC45E7540
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiIWHyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiIWHyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:54:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AA312BD96;
        Fri, 23 Sep 2022 00:54:21 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N7ko8o013477;
        Fri, 23 Sep 2022 07:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xru8EpbOsZOrnsqDwIx5q7qNMwFA9Y27nBatTqmbAzo=;
 b=cjgA0TyfAPHGFwxrH4jpfwOoRYIrU7/jf0okUB89km8Y0EgsDLFbE8MhsNkhygzKoGJj
 iXS9hIp1WjBfqZtSaUxD/COiaJTHMzh59ulqrlJDeCBn20SdGv/J6NwgKNdx0yfb4bBd
 +AzxYnk3nRkBTmIWnZHZ+hFoCZiQQwArUVM48piJQfGIPYeO5sHkZ70JyUNrvc3kKv3x
 x4ClqGsM2jN4vQvzUXy7GFhZEfY3BhrVZXd4Ky5YcY5fLSyaoQiUbOHT40SOGRkkLqvv
 YlcnkjuWFoycmHuWyttbBvJxfuQAeuxdUi7nZgNLCAp56cZKRwGFzTvBjTDRib3aHbx4 oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3js6vj35bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 07:53:52 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28N7jopd022453;
        Fri, 23 Sep 2022 07:53:52 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3js6vj35b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 07:53:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28N7qJiq009525;
        Fri, 23 Sep 2022 07:53:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3jn5v97nhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 07:53:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28N7nhFG30408998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 07:49:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F85811C05B;
        Fri, 23 Sep 2022 07:53:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3C4111C04C;
        Fri, 23 Sep 2022 07:53:46 +0000 (GMT)
Received: from [9.171.42.226] (unknown [9.171.42.226])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Sep 2022 07:53:46 +0000 (GMT)
Message-ID: <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
Date:   Fri, 23 Sep 2022 09:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Content-Language: en-US
To:     peterz@infradead.org
Cc:     bigeasy@linutronix.de, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        oleg@redhat.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        tj@kernel.org, vincent.guittot@linaro.org, will@kernel.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220923072104.2013212-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: it4ya3OjUUX3ce6kI4LWcLyr-7AH0ZbQ
X-Proofpoint-GUID: ApwnX1bSNphaXeTYpDXcUZeDA79quPwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 mlxlogscore=937 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209230047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.09.22 um 09:21 schrieb Christian Borntraeger:
> Peter,
> 
> as a heads-up. This commit (bisected and verified) triggers a
> regression in our KVM on s390x CI. The symptom is that a specific
> testcase (start a guest with next kernel and a poky ramdisk,
> then ssh via vsock into the guest and run the reboot command) now
> takes much longer (300 instead of 20 seconds). From a first look
> it seems that the sshd takes very long to end during shutdown
> but I have not looked into that yet.
> Any quick idea?
> 
> Christian

the sshd seems to hang in virtio-serial (not vsock).

PID: 237      TASK: 81d1a100          CPU: 1    COMMAND: "sshd"
  LOWCORE INFO:
   -psw      : 0x0404e00180000000 0x0000000131ceb136
   -function : __list_add_valid at 131ceb136
   -prefix   : 0x00410000
   -cpu timer: 0x7fffffd3ec4f33d4
   -clock cmp: 0x2639f08006283e00
   -general registers:
      0x00000008dcea2dce 0x00000001387d44b8
      0x0000000081d1a228 0x00000001387d44b8
      0x00000001387d44b8 0x00000001387d44b8
      0x00000001387d3800 0x00000001387d3700
      0x0000000081d1a100 0x00000001387d44b8
      0x00000001387d44b8 0x0000000081d1a228
      0x0000000081d1a100 0x0000000081d1a100
      0x0000000131608b32 0x00000380004b7aa8
   -access registers:
      0x000003ff 0x8fff5870 0000000000 0000000000
      0000000000 0000000000 0000000000 0000000000
      0000000000 0000000000 0000000000 0000000000
      0000000000 0000000000 0000000000 0000000000
   -control registers:
      0x00a0000014966a10 0x0000000133348007
      0x00000000028c6140 000000000000000000
      0x000000000000ffff 0x00000000028c6140
      0x0000000033000000 0x0000000081f001c7
      0x0000000000008000 000000000000000000
      000000000000000000 000000000000000000
      000000000000000000 0x0000000133348007
      0x00000000db000000 0x00000000028c6000
   -floating point registers:
      0x000003ffb82a9761 0x0000006400000000
      0x000003ffb82a345c 000000000000000000
      0x0000000000007fff 0x000003ffe22fe000
      000000000000000000 0x000003ffe22fa51c
      0x000003ffb81889c0 000000000000000000
      0x000002aa3ce2b470 000000000000000000
      000000000000000000 000000000000000000
      000000000000000000 000000000000000000

  #0 [380004b7b00] pick_next_task at 1315f2088
  #1 [380004b7b98] __schedule at 13215e954
  #2 [380004b7c08] schedule at 13215eeea
  #3 [380004b7c38] wait_port_writable at 3ff80149b2e [virtio_console]
  #4 [380004b7cc0] port_fops_write at 3ff8014a282 [virtio_console]
  #5 [380004b7d40] vfs_write at 131889e3c
  #6 [380004b7e00] ksys_write at 13188a2e8
  #7 [380004b7e50] __do_syscall at 13215761c
  #8 [380004b7e98] system_call at 132166332
  PSW:  0705000180000000 000003ff8f8f3a2a (user space)
  GPRS: 0000000000000015 000003ff00000000 ffffffffffffffda 000002aa02fc68a0
        0000000000000015 0000000000000015 0000000000000000 000002aa02fc68a0
        0000000000000004 000003ff8f8f3a08 0000000000000015 0000000000000000
        000003ff8ffa9f58 0000000000000000 000002aa02365b20 000003ffdf4798d0
