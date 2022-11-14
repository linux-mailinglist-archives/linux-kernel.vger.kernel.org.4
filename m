Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D1C628409
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiKNPfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiKNPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:35:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4F0A449;
        Mon, 14 Nov 2022 07:35:16 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEFBfPN025386;
        Mon, 14 Nov 2022 15:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=XFxuVRSSX1AGXqt9LSkXJUwlBCgGJWsykDUlpBSUWhw=;
 b=lMF30RwQpGcxY5/RL1+vG5AvSYxJzc80E/wOIXKNpq9cKpXwFaB6y9jStgZ2eWyHskDQ
 Zve2r+FCt7fxypaLi+J3oINObItbOyrywFcy128qSpRzqFaxZl/CzC6mEGRDCxCqRge6
 G7tDPSfKM/LGXiKr5Xol5rQrUVgcLAetkuUlz63447wyfeTkQHXoGJHfYLOqkQDGLcsb
 EOVD7zYwNJerC46ccQDhOPVrFgIlXe2aVVLP6nv8H7VVOEJlOGxwDOcwWBHt3sHgxmO8
 JSTlNRozZrCx/2Wlv2V5ifoKnhwD28PxvZtCW0GYK8KYSV7vJyjHGEhq9Mze+/qqBq+W Mw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kur3s0n6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 15:35:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEFKJG8028541;
        Mon, 14 Nov 2022 15:35:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3kt2rjat01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 15:35:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEFZ6j266847180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 15:35:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBD2942042;
        Mon, 14 Nov 2022 15:35:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A83724203F;
        Mon, 14 Nov 2022 15:35:06 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Nov 2022 15:35:06 +0000 (GMT)
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
Date:   Mon, 14 Nov 2022 16:35:06 +0100
In-Reply-To: <20221111185331.GA725751@paulmck-ThinkPad-P17-Gen-1> (Paul
        E. McKenney's message of "Fri, 11 Nov 2022 10:53:31 -0800")
Message-ID: <yt9dtu31k0r9.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Cbqd1CFX1MrPirG9A0EqFT1FFcSmkJrh
X-Proofpoint-GUID: Cbqd1CFX1MrPirG9A0EqFT1FFcSmkJrh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=478 spamscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Fri, Nov 11, 2022 at 01:51:24PM +0100, Sven Schnelle wrote:
>> A CPU listed in the possible mask doesn't have to be present, in
>> which case it would crash the kernel in torture_online_all().
>> To prevent this use a for_each_present() loop.
>> 
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>
> Looks good to me!  Any reason for no mailing list on CC?

No, my fault. I setup get_maintainer.pl to be called from git
send-email, but looks like i did it wrong :-)

> Ah, and any synchronization required in case it is possible for a CPU
> to leave the cpu_present_mask?  Or can they only be added?

Hmm... I think the main question is, whether it is ok for a cpu to be
removed from the system when rcutorture is running? In both cases it
would disappear from the cpu online mask, so i don't think the patch
would change the behaviour. But i can check and send additional patches
if there are other places that needs adjustment.

Regards
Sven
