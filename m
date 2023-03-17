Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6156BEEE6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCQQxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjCQQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:52:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67799B06CF;
        Fri, 17 Mar 2023 09:52:51 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HEwqQ8020323;
        Fri, 17 Mar 2023 16:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=h8CQp6+iDtm9xUAsI4h9p4NSx/w9aaH83EG+p9E7o4E=;
 b=ERElVEZTgBBo3qZCD79YO/gjby2BjRYUp9sJVszQFiATdN3gRa2MK/3J4J+2/2SU1QDu
 Hf7p1j+4BCEwYxRxbCT/qbRnIcHgJ8x/1xjlNHW9fFOYSmjBYbHh/EdFcqMB0C2UepN/
 X/nyxp+YqkkdApjEvNwzfUZ5xR/1LdeIHxDoJltGncMWeznqiKVoO0+ZQeICOGNNlQQU
 GFQbk3apDc77QFWZTVW/Rnfi67ceFCnKwOAgTdc+m1MLgf2e7amKwjHfX2hLfhs5P5nN
 Xh6cTV9SMnEeySla9SbiK4prexkUyxB+nITo8SpEZSWQhnlQDf3dMussKvEmqvDLPp1s Lg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pctetk4r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 16:52:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32H6Ytg0029187;
        Fri, 17 Mar 2023 16:52:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pbskt2e80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 16:52:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32HGqfHv55968178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 16:52:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0237C2004B;
        Fri, 17 Mar 2023 16:52:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D3F820040;
        Fri, 17 Mar 2023 16:52:40 +0000 (GMT)
Received: from [9.171.87.24] (unknown [9.171.87.24])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Mar 2023 16:52:40 +0000 (GMT)
Message-ID: <8f17a884-09d2-b6a1-7ced-77dd4b4f21a5@linux.ibm.com>
Date:   Fri, 17 Mar 2023 17:52:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH for-next] scsi: Implement host state statistics
Content-Language: en-US
To:     "Seymour, Shane M" <shane.seymour@hpe.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <DM4PR84MB1373DCD07EABD28D88129C50FDBF9@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
 <ZBFnYwtr+2bfjvcY@kroah.com>
 <DM4PR84MB13737BE099BF599DF83617DBFDBF9@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
From:   Steffen Maier <maier@linux.ibm.com>
In-Reply-To: <DM4PR84MB13737BE099BF599DF83617DBFDBF9@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lAloHn_hzzGVQjWWlB4znDzOpmgvgTpW
X-Proofpoint-ORIG-GUID: lAloHn_hzzGVQjWWlB4znDzOpmgvgTpW
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_10,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 23:41, Seymour, Shane M wrote:
>> On Wed, Mar 15, 2023 at 06:08:19AM +0000, Seymour, Shane M wrote:
>>> The following patch implements host state statistics via sysfs. The intent
>>> is to allow user space to see the state changes and be able to report when
>>> a host changes state. The files do not separate out the time spent into
>>> each state but only into three:
>>
>> Why does userspace care about these things at all?  What tool needs them
>> and what can userspace do with the information?
>>
> 
> In enterprise setups you may a significant number of LUNs presented to a
> system (100s to 1000s) via a single HBA (usually via FC). Having a HBA going
> into error handling causes issues. Every time a host goes into SCSI EH all
> I/O to that host is blocked until SCSI EH completes. That means waiting for
> every I/O to either complete or timeout before starting any recovery
> processing.
> 
> At this time there is no way for anything outside of the kernel to know if a
> HBA is having any issues. The cause of those issues can vary significantly,
> just two examples:
> 
> 1) Storage end point issues
> 2) SAN issues (e.g. laser transmit power at any point in the SAN)
> 
> My experience with downstream distros is that nobody seems to notice the
> noise that SCSI EH produces (LUN, device, bus, host resets) and we see it
> when we get a vmcore and have to try and work out what caused an I/O hang.

I hear you. Especially, the fact that the very desirable asynchronous aborts 
and even eh with escalations seems pretty much silent as long as a SCSI command 
succeeds within one of the allowed retries. I suspect this was done in order 
not to unsettle users by showing intermediate recovery, which can still lead to 
successful I/O eventually.

FWIW, at some point we figured out a nice scsi_logging_level of 4605, in order 
to see any problems with lun probing ("why don't I get my volume in Linux?") or 
timeouts/aborts/eh ("why are things so slow?") without producing kernel 
messages for regular good I/O. Of course, it's not set by default, but can be 
dynamically set if one suspects such problems.

> I wanted to be more proactive in warning users that you've got a potential
> storage issue you need to look at. It won't help when you have a sudden
> massive issue but if you have an issue that is slowly getting worse over
> a period of time you will at least get some warning.
> 
>>>
>>> A (GPLv2) program called hostmond will be released in a few months that
>>> will monitor these interfaces and report (local host only via syslog(3C))
>>> when hosts change state.
>>
>> We kind of need to see this before the kernel changes can be accepted
>> for obvious reasons, what is preventing that from happening now?
> 
> If you don't mind I'll answer this in my reply to James' email soon since
> he commented about this.
> 
>>
>> Please always use sysfs_emit() instead of the crazy scnprintf() for
>> sysfs entries.
> 
> No problem I can make that change.
> 
>>
>> u32 is a kernel type, not uint32_t please, but I don't know what the
>> scsi layer is used to.
> 
> No problem I can make that change.
> 
>>
>> thanks,
>>
>> greg k-h
> 
> Thank you for your willingness to provide feedback.
> 
> Shane

-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z and LinuxONE

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschaeftsfuehrung: David Faller
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

