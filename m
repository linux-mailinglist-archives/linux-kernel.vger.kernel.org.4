Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D9D705F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjEQFp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEQFpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:45:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315EC124;
        Tue, 16 May 2023 22:45:52 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H5AYC6025820;
        Wed, 17 May 2023 05:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=Ch3xh7mGkrtELFwHxM1Vk7sYFwQyV1aLAg/nUzwmb3A=;
 b=bQSz+ZzTg2qhby676iOfrtKsC0QT8KaV/azhnMPRmBjpXKMZzOTKRRfyePxGIaghGIjn
 i/pITx7wYY/n1kDzj8KppUqCFn83GCkEswgLKibPVn+kESuGm7yUVjzRCDf/Jm1Ng/w6
 m/kwIYSkgdgGdmzu0fkXPhxQBOawTVA2z0MyqOf5zAy1XglMPO7SDg5ClxqiesURYih0
 +h9teqPvufD6oKumcedaEGDkq+f/GZQNvj7PuMcUmdxr8gyO40C6+eZ4RnU+W8h3wP/I
 R84Q91uODDCeh9TwCJn10R7r37rGN8zu4lR0tlVzEmwt7fi/aIsZVR8q8zlwruDlo2PJ Nw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmqpjj1wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 05:45:39 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34H4owVp018130;
        Wed, 17 May 2023 05:45:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3qj264snjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 05:45:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34H5jYHK45351454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 05:45:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C2C62004B;
        Wed, 17 May 2023 05:45:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1DF720043;
        Wed, 17 May 2023 05:45:32 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 17 May 2023 05:45:32 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>, linux-s390@vger.kernel.org,
        hca@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] entry: move the exit path to header files
References: <20230516133810.171487-1-svens@linux.ibm.com>
        <20230516133810.171487-2-svens@linux.ibm.com>
        <20230516164221.GA2602133@hirez.programming.kicks-ass.net>
Date:   Wed, 17 May 2023 07:45:32 +0200
In-Reply-To: <20230516164221.GA2602133@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 16 May 2023 18:42:21 +0200")
Message-ID: <yt9dmt23lddv.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -zfBKaU5eKsFIrY8RXJoZLRVE80iW7fD
X-Proofpoint-GUID: -zfBKaU5eKsFIrY8RXJoZLRVE80iW7fD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=822 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, May 16, 2023 at 03:38:09PM +0200, Sven Schnelle wrote:
>> @@ -465,4 +470,175 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
>>   */
>>  void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
>>  
>> +static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>> +					    unsigned long ti_work)
>
> Should these things not grow __always_inline/inline when moved into a header?

Yes, indeed. I missed that while doing a quick move of the functions for
testing. I'll fix that when doing a proper patch set for submission.

>> +{
>
>> +}
>> +
>> +
>> +static void exit_to_user_mode_prepare(struct pt_regs *regs)
>
> idem
>
>> +{
>
>> +}
>
>> +static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>
> and more..
>
>> +{
>
>> +}
>> +
