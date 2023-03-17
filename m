Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BE16BED27
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCQPlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCQPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:41:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D333D0B9;
        Fri, 17 Mar 2023 08:41:49 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HFSWgK014392;
        Fri, 17 Mar 2023 15:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CdMh8Da9qkxn8nG2HWX1Om/OpyHxK6jJUh5AAuUVOYQ=;
 b=J0ZFWBPiJvoqxnGw7LmkuPEHhP9mNkih4i7as373N535qKOdLpOgk8LJkM5JFeKfgHHF
 KPIR5MCK1a8tp5tYd/LqMNCHmVFpwsF2V4PISAgfGR7EqW04AgnYR4gAIb3rQmg3BGVt
 IYrIs5JZM5jaTsBaHPrgBFGlfZ9dCUsweUtYm0P3xP9h+ElK68XQws+ldPDsQAPZGdUx
 CID4je4xmuay1+3+LYcLNDAVYRprJjWVEltDFhAEY4vI3QRS353zI2hB9nNfIT7LFxep
 EnkZRPdwdYAAS7r7iagJdzLbT30b4+HNk//e38Lrc4unPTItHO2ozEwfZS65AuuFE83o qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pctvqgb6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 15:41:35 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32HFSpSp019205;
        Fri, 17 Mar 2023 15:41:34 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pctvqgb5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 15:41:34 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32HDpXZo002789;
        Fri, 17 Mar 2023 15:41:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pbs53990r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 15:41:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32HFfVfq31982232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 15:41:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0BD558059;
        Fri, 17 Mar 2023 15:41:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9AFF5805B;
        Fri, 17 Mar 2023 15:41:31 +0000 (GMT)
Received: from localhost (unknown [9.163.4.251])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Mar 2023 15:41:31 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: Re: powerpc/pseries: Fix exception handling in
 pSeries_reconfig_add_node()
In-Reply-To: <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de>
 <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de>
Date:   Fri, 17 Mar 2023 10:41:31 -0500
Message-ID: <87v8iz75ck.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VAnCAZbvkGVP7qumF8JkX5udQ_eHDj6e
X-Proofpoint-ORIG-GUID: reTzuusy-TiznGKUgMe0DpjY9hsBVW0w
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_10,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Elfring <Markus.Elfring@web.de> writes:
>>> The label =E2=80=9Cout_err=E2=80=9D was used to jump to another pointer=
 check despite of
>>> the detail in the implementation of the function =E2=80=9CpSeries_recon=
fig_add_node=E2=80=9D
>>> that it was determined already that the corresponding variable contained
>>> a null pointer (because of a failed function call in two cases).
>>>
>>> 1. Thus return directly after a call of the function =E2=80=9Ckzalloc=
=E2=80=9D failed.
>>>
>>> 2. Use more appropriate labels instead.
>>>
>>> 3. Delete a redundant check.
>>>
>>> 4. Omit an explicit initialisation for the local variable =E2=80=9Cerr=
=E2=80=9D.
>>>
>>> This issue was detected by using the Coccinelle software.
>> Is there a correctness or safety issue here?
>
> I got the impression that the application of only a single label like =E2=
=80=9Cout_err=E2=80=9D
> resulted in improvable implementation details.

I don't understand what you're trying to say here. It doesn't seem to
answer my question.

>> The subject uses the word "fix" but the commit message doesn't seem to i=
dentify one.
>
> Can you find the proposed adjustments reasonable?

In the absence of a bug fix or an improvement in readability, not
really, sorry. It adds to the function more goto labels and another
return, apparently to avoid checks that are sometimes redundant (but not
incorrect) at the C source code level. An optimizing compiler doesn't
necessarily arrange the generated code in the same way.

>> Can you share how Coccinelle is being invoked and its output?
>
> Please take another look at available information sources.
> https://lore.kernel.org/cocci/f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de/

I wasn't cc'd on this and I'm not subscribed to any lists in the
recipients for that message, so not sure how I would take "another"
look. :-)
