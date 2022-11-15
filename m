Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E6F62920E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiKOG4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKOG4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:56:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA4A639D;
        Mon, 14 Nov 2022 22:56:02 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF6ftTF025471;
        Tue, 15 Nov 2022 06:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=ptfk3Z0aqUjuwRhWp6fIEl22ZV3Y4VjXJ7dcnTyeahg=;
 b=bpPrJGJ5QN8KUpe5SthbwpQTBWDXuTDuGCapYYJTKJys4zuhgydm3OV0Lr+f+QR/5ODd
 sXd6Z5tBgUaNVJusUjJ8W3w15D77vyjjEBHqsHse1S6Fnl4Q87HZz1SmOPne/oBj7ZJo
 yhch2xtQ4vqEzXUt8pbhgkxF3MBDec8C8aHSjU9as3wF1WvlnB6GilAYdZ+1kcGrBLcS
 C7OE0CQ/otVjNrmeFOEp/i8a9A5u5yJbvvZSA+N3PhZIWPv/+yyeYypIj988kVfgxydy
 rztmIBmK6+kG5x46+0sOrMkUQOizydBdEN04KWb0JcZGD+sz33LXHGz0Z0Agrhw0N6w9 hg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kv5qqg948-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 06:55:55 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AF6pBWs013869;
        Tue, 15 Nov 2022 06:55:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3kt349at5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 06:55:53 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AF6uUVW49742294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 06:56:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C748B4C044;
        Tue, 15 Nov 2022 06:55:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9323A4C040;
        Tue, 15 Nov 2022 06:55:50 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Nov 2022 06:55:50 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 1/2] torture: use for_each_present() loop in
 torture_online_all()
References: <20221111125126.3319474-1-svens@linux.ibm.com>
        <20221111125126.3319474-2-svens@linux.ibm.com>
        <20221111185331.GA725751@paulmck-ThinkPad-P17-Gen-1>
        <yt9dtu31k0r9.fsf@linux.ibm.com>
        <20221114163009.GE4001@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 15 Nov 2022 07:55:50 +0100
In-Reply-To: <20221114163009.GE4001@paulmck-ThinkPad-P17-Gen-1> (Paul
        E. McKenney's message of "Mon, 14 Nov 2022 08:30:09 -0800")
Message-ID: <yt9dzgcsiu4p.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0artusJ36xUPpeRK3PcNy5KwTH7iJp1T
X-Proofpoint-ORIG-GUID: 0artusJ36xUPpeRK3PcNy5KwTH7iJp1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_02,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=488 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Mon, Nov 14, 2022 at 04:35:06PM +0100, Sven Schnelle wrote:
>> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> 
>> > On Fri, Nov 11, 2022 at 01:51:24PM +0100, Sven Schnelle wrote:
>> >> A CPU listed in the possible mask doesn't have to be present, in
>> >> which case it would crash the kernel in torture_online_all().
>> >> To prevent this use a for_each_present() loop.
>> >> 
>> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> >
>> > Looks good to me!  Any reason for no mailing list on CC?
>> 
>> No, my fault. I setup get_maintainer.pl to be called from git
>> send-email, but looks like i did it wrong :-)
>
> Been there, done that!  ;-)
>
>> > Ah, and any synchronization required in case it is possible for a CPU
>> > to leave the cpu_present_mask?  Or can they only be added?
>> 
>> Hmm... I think the main question is, whether it is ok for a cpu to be
>> removed from the system when rcutorture is running? In both cases it
>> would disappear from the cpu online mask, so i don't think the patch
>> would change the behaviour. But i can check and send additional patches
>> if there are other places that needs adjustment.
>
> Yes, rcutorture has lower-level checks for CPUs being hotplugged
> behind its back.  Which might be sufficient.  But this patch is in
> response to something bad happening if the CPU is also not present in
> the cpu_present_mask.  Would that same bad thing happen if rcutorture saw
> the CPU in cpu_online_mask, but by the time it attempted to CPU-hotplug
> it, that CPU was gone not just from cpu_online_mask, but also from
> cpu_present_mask?
>
> Or are CPUs never removed from cpu_present_mask?

In the current implementation CPUs can only be added to the
cpu_present_mask, but never removed. This might change in the future
when we get support from firmware for that, but the current s390 code
doesn't do that.

Regards
Sven
