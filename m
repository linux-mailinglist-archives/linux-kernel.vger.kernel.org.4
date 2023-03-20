Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF78B6C1A25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjCTPsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjCTPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:47:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671D13501;
        Mon, 20 Mar 2023 08:39:07 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KFHSFe022310;
        Mon, 20 Mar 2023 15:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=tF9DPR4BziRpIYNIxnHYz1rUjU1J1WPHeaPCtVN4Vy0=;
 b=H4ehmhdJR7vvqAhDkTDpDUy6pvdFwBfibNmi9y8msPYVIt6vt5PKMwfY2qgEkibBgjpV
 T054dBChtf7ChrcrxZttx/NZ3+0C8YB1hBetfc/+kr0tqm6A0N7sD7y2+3ZsBUcADfJN
 Vxl7AMy+EKN/JEuT6edr0R/wgjBvZ3GiIAfzpW1AB0cgnCBvAWM4Gp4z5WIAWilxKmW/
 KCakSYDRuuOiktmqvAoWjjGbtcN06/y6UybPhN260gFFE/OG/sNEDAaJ728BINJBPKXv
 Blu2Ekiz1sCWNaM+9bSDQ6jKX6hJkXAtR1j3Xc4aONug65o3JLselHC/4f66AItLXTb1 xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pdqf3546u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:38:54 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32KENu8h008070;
        Mon, 20 Mar 2023 15:38:54 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pdqf3546m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:38:54 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KF8i3C024217;
        Mon, 20 Mar 2023 15:38:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3pd4x70x2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:38:52 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KFcppB63504820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 15:38:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87D7058043;
        Mon, 20 Mar 2023 15:38:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EA375805D;
        Mon, 20 Mar 2023 15:38:51 +0000 (GMT)
Received: from localhost (unknown [9.211.100.146])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Mar 2023 15:38:51 +0000 (GMT)
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
In-Reply-To: <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de>
 <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de>
 <87v8iz75ck.fsf@linux.ibm.com>
 <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de>
Date:   Mon, 20 Mar 2023 10:38:50 -0500
Message-ID: <87pm9377qt.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F9folt-ke6hPsK5kwyUnxRyoAE_QFa5l
X-Proofpoint-ORIG-GUID: oHG_wXOFkuavUcnxh9y4s7Bxzj34q6ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_10,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=587 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Elfring <Markus.Elfring@web.de> writes:
>>>>> The label =E2=80=9Cout_err=E2=80=9D was used to jump to another point=
er check despite of
>>>>> the detail in the implementation of the function =E2=80=9CpSeries_rec=
onfig_add_node=E2=80=9D
>>>>> that it was determined already that the corresponding variable contai=
ned
>>>>> a null pointer (because of a failed function call in two cases).
>>>>>
>>>>> 1. Thus return directly after a call of the function =E2=80=9Ckzalloc=
=E2=80=9D failed.
>>>>>
>>>>> 2. Use more appropriate labels instead.
>>>>>
>>>>> 3. Delete a redundant check.
>>>>>
>>>>> 4. Omit an explicit initialisation for the local variable =E2=80=9Cer=
r=E2=80=9D.
>>>>>
>>>>> This issue was detected by using the Coccinelle software.
>>>> Is there a correctness or safety issue here?
>>> I got the impression that the application of only a single label like =
=E2=80=9Cout_err=E2=80=9D
>>> resulted in improvable implementation details.
>> I don't understand what you're trying to say here.
>
> What does hinder you to understand the presented change description better
> at the moment?
>
>
>> It doesn't seem to answer my question.
>
>
> I hope that my answer will trigger further helpful considerations.

I don't consider this response constructive, but I want to get this back
on track. It's been brought to my attention that there is in fact a
crash bug in this function's error path:

	np->parent =3D pseries_of_derive_parent(path);
	if (IS_ERR(np->parent)) {
		err =3D PTR_ERR(np->parent);
		goto out_err;
	}
...
out_err:
	if (np) {
		of_node_put(np->parent);

np->parent can be an encoded error value, we don't want to of_node_put()
that.

I believe the patch as written happens to fix the issue. Will you please
write it up as a bug fix and resubmit?
