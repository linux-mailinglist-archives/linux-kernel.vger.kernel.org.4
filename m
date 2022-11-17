Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D312462D37A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiKQGa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbiKQGao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:30:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FD2654F5;
        Wed, 16 Nov 2022 22:30:43 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH6DpYf012440;
        Thu, 17 Nov 2022 06:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=lsPssmad/2OKMG9PBKUb6Gr7P3GFl7GpUMlPs+Vy6H8=;
 b=B4SE8KsZ2HHaa4ywr8lt0SGmCfH5OYuU0YKDZfBfOtTkinZa3li99uTuSmUBi5il11Jm
 QDF5UZd84uHV1Mx6Me9zv7XfpUyogUGiTWh2dD1wgAxGTOsEsghKUObpKh5+weq9SZnU
 GWE3t8NP4sFRSL6Pm7XaIUHxG4bGJvxmDwVWoQnX+BhOyvhTHKQJ60Qn+cvzeKXKV12d
 SWc7e4ILxHNZaz7uw453nPwz6R5xKvfOcGK0We4xWzG7a1iDefGhwm8cLA2MYnFm0ots
 wj8/RnN3ahoFPfFPLaxgC0SvpxN//3ZN74ElnV/7PYvjlrecPz3/+CZBV3nseMaZA7Oi hw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwfgerbbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 06:30:37 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AH6M13k002750;
        Thu, 17 Nov 2022 06:30:35 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3kt3495ae4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 06:30:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AH6UWLk16712130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 06:30:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5A09A4054;
        Thu, 17 Nov 2022 06:30:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D045A4060;
        Thu, 17 Nov 2022 06:30:32 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Nov 2022 06:30:32 +0000 (GMT)
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
        <yt9dzgcsiu4p.fsf@linux.ibm.com>
        <20221115134139.GI4001@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 17 Nov 2022 07:30:32 +0100
In-Reply-To: <20221115134139.GI4001@paulmck-ThinkPad-P17-Gen-1> (Paul
        E. McKenney's message of "Tue, 15 Nov 2022 05:41:39 -0800")
Message-ID: <yt9dr0y29jp3.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xx48Qoq1H6rdKtSjVvuggAQH2GYOe2pv
X-Proofpoint-ORIG-GUID: xx48Qoq1H6rdKtSjVvuggAQH2GYOe2pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_02,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=361 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170045
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

>> > Yes, rcutorture has lower-level checks for CPUs being hotplugged
>> > behind its back.  Which might be sufficient.  But this patch is in
>> > response to something bad happening if the CPU is also not present in
>> > the cpu_present_mask.  Would that same bad thing happen if rcutorture saw
>> > the CPU in cpu_online_mask, but by the time it attempted to CPU-hotplug
>> > it, that CPU was gone not just from cpu_online_mask, but also from
>> > cpu_present_mask?
>> >
>> > Or are CPUs never removed from cpu_present_mask?
>> 
>> In the current implementation CPUs can only be added to the
>> cpu_present_mask, but never removed. This might change in the future
>> when we get support from firmware for that, but the current s390 code
>> doesn't do that.
>
> Very good!
>
> Then could the patch please check that bits are never removed?
> That way the code will complain should firmware support be added.
>
> 							Thanx, Paul

I'm not sure whether i fully understand that. If the CPU could
be removed from the system and the cpu_present_mask, that could
happen at any time. So i don't see how we should check about that?

Regards
Sven
