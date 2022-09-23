Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC22C5E7EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiIWPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiIWPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:40:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD49A4049;
        Fri, 23 Sep 2022 08:40:13 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NFA3tD020827;
        Fri, 23 Sep 2022 15:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=SYgDvLRIZ2rybNNjwg6Qx9GnXQMCfYTiJQeSJ5jWKj8=;
 b=siyua8s9hD3cnB8zhuOFcAtu8kH0xxUJeBnb2CcF2gWScBQK6FjnDYH2WmrSuATH+mbp
 VhFHkhjWygsFx7yy0v4saBwp4gBqz88R2bIfIZLtxP2SO7KY0+ImwhHVXXFxKAN1abg8
 tJq6sGiBUGeXESu3md83Fb3MGH5xqUvPqi73RKnOZ3+PbRNNzRttE2UH3IdTPKWc9qiJ
 WgG1gZfYOZepyM8kgtttl1bGypg4sRlVx/F7cYvXzI6IBjEJZeoBGK9mwLAX6ECuBP01
 aaU95NIPosQtkSOKBn+5fJndzZnpryBJ/h0viZF+PQWTXzy/KTA2vvsOCDHgq3NiKk/n yQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jsad22qgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 15:39:54 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28NFa5w1005868;
        Fri, 23 Sep 2022 15:39:52 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 3jn5va0js7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 15:39:52 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28NFdqsi10748480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 15:39:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E25958068;
        Fri, 23 Sep 2022 15:39:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61ED158052;
        Fri, 23 Sep 2022 15:39:51 +0000 (GMT)
Received: from localhost (unknown [9.211.104.104])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 23 Sep 2022 15:39:51 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Moore <paul@paul-moore.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        ajd@linux.ibm.com, gcwilson@linux.ibm.com, nayna@linux.ibm.com
Subject: Re: [PATCH 2/2] powerpc/rtas: block error injection when locked down
In-Reply-To: <87wn9uzhqr.fsf@mpe.ellerman.id.au>
References: <20220922193817.106041-1-nathanl@linux.ibm.com>
 <20220922193817.106041-3-nathanl@linux.ibm.com>
 <CAHC9VhTWMFbCxQFAEJZzS3Kd5cSFigmvHac5y5ypVU7TqRqpTA@mail.gmail.com>
 <87wn9uzhqr.fsf@mpe.ellerman.id.au>
Date:   Fri, 23 Sep 2022 10:39:51 -0500
Message-ID: <878rmaqeuw.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9bdKl-1XTTu54M3WgVVl7zqQrMHqUo0F
X-Proofpoint-GUID: 9bdKl-1XTTu54M3WgVVl7zqQrMHqUo0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209230101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Paul Moore <paul@paul-moore.com> writes:
>> On Thu, Sep 22, 2022 at 3:38 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>>>
>>> The error injection facility on pseries VMs allows corruption of
>>> arbitrary guest memory, potentially enabling a sufficiently privileged
>>> user to disable lockdown or perform other modifications of the running
>>> kernel via the rtas syscall.
>>>
>>> Block the PAPR error injection facility from being opened or called
>>> when locked down.
>>>
>>> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
>>> ---
>>>  arch/powerpc/kernel/rtas.c | 25 ++++++++++++++++++++++++-
>>>  include/linux/security.h   |  1 +
>>>  security/security.c        |  1 +
>>>  3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> ...
>>
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index 1ca8dbacd3cc..b5d5138ae66a 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -123,6 +123,7 @@ enum lockdown_reason {
>>>         LOCKDOWN_BPF_WRITE_USER,
>>>         LOCKDOWN_DBG_WRITE_KERNEL,
>>>         LOCKDOWN_DEVICE_TREE,
>>> +       LOCKDOWN_RTAS_ERROR_INJECTION,
>>
>> With the understanding that I've never heard of RTAS until now, are
>> there any other RTAS events that would require a lockdown reason?  As
>> a follow up, is it important to distinguish between different RTAS
>> lockdown reasons?

1. Not to my current knowledge.
2. Yes, I think so, see below.

>>
>> I'm trying to determine if we can just call it LOCKDOWN_RTAS.
>
> Yes I think we should.
>
> Currently it only locks down the error injection calls, not all of RTAS.
>
> But firmware can/will add new RTAS calls in future, so it's always
> possible something will need to be added to the list of things that need
> to be blocked during lockdown.
>
> So I think calling it LOCKDOWN_RTAS would be more general and future
> proof, and can be read to mean "lockdown the parts of RTAS that need
> to be locked down".

RTAS provides callable interfaces for a broad variety of functions,
including device configuration, halt/reboot/suspend, CPU online/offline,
NVRAM access, firmware upgrade, platform diagnostic data retrieval, and
others.

Currently I don't know of other RTAS-provided functions that should be
restricted. But if we were to add more, then -- in answer to Paul -- yes
I think it would be important to have distinct reasons and
messages. Taking the point of view of someone diagnosing lockdown denial
messages and relating them to kernel code and user space activity, I
would rather we err toward specificity.

Also: LOCKDOWN_RTAS_ERROR_INJECTION is proposed for lockdown's integrity
mode. But consider that future RTAS-related additions could be proposed
for confidentiality mode, which is more restrictive. (A plausible
example could be platform dump retrieval.) We would need at least two
RTAS reasons and one wouldn't suffice.

So a single RTAS catch-all lockdown reason doesn't appeal to me, but
lockdown reasons and messages aren't ABI (right?) and we could
eventually change whatever decision we reach here. So if you both still
prefer a single LOCKDOWN_RTAS reason, I can do that for v2.

That said, I could see a case for instead adding
LOCKDOWN_HW_ERROR_INJECTION (without the RTAS), to indicate restriction
of hardware- or platform-level error injection. I was a little surprised
to find that an error injection reason doesn't already exist for the
ACPI-based facility (drivers/acpi/apei/einj.c), but since the user
interface is debugfs-based I suppose it's already restricted in practice
by LOCKDOWN_DEBUGFS.
