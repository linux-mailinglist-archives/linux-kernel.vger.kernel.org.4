Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58836AD708
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCGF6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCGF6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:58:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD48222F3;
        Mon,  6 Mar 2023 21:58:39 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3273XQvw028291;
        Tue, 7 Mar 2023 05:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YSk2JfujQ7pKzr0/Jvn/SP+mczXYFolop0M+4smjxzY=;
 b=XE11J0QgsZnMtEVkTTGHa75DqGfXWVe7exZrRIURfMjWSATyRXpzZHD2HJr3No3zyFGx
 Q0fHw2xBnjxhe7nXjvP1FjQDP92eaPQDjGe/x4ExVzdUCSq/AQ6kcTZk3tMKLVhkQOnC
 dI6vzqJI32Ox4xI8oYDSfgYLwab7GP8iofy+AD+25d0m47ERUASVYRoKtDJodJ/L0kak
 SsMd1DaQSdqzQHdpjRqAeb/65iHK2T/u1E7MPKA34C5yLfqFdnPKwLPuMEAt9jwDQK9P
 QsXog0dInShuorUy/VqsbReuw8eups9aYLjN9grk+FwrzNWUmlV2IJBsFycjeEyWuwbh RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p5p4wvuhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 05:58:29 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3275oQLv018680;
        Tue, 7 Mar 2023 05:58:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p5p4wvuhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 05:58:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3270nqTW007531;
        Tue, 7 Mar 2023 05:58:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p4188bs5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 05:58:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3275wOIc23134532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 05:58:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8177220043;
        Tue,  7 Mar 2023 05:58:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0078620040;
        Tue,  7 Mar 2023 05:58:24 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Mar 2023 05:58:23 +0000 (GMT)
Received: from [10.61.2.107] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 41F1D60112;
        Tue,  7 Mar 2023 16:58:22 +1100 (AEDT)
Message-ID: <6702ec00b1ee44b140da85644ea1f965f5d9e42b.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 07/13] powerpc/dexcr: Add sysctl entry for SBHE
 system override
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     ajd@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, cmr@bluescreens.de
Date:   Tue, 07 Mar 2023 16:58:22 +1100
In-Reply-To: <CQZWKF2U2GVM.1X6AAD3SM05D6@bobo>
References: <20221128024458.46121-1-bgray@linux.ibm.com>
         <20221128024458.46121-8-bgray@linux.ibm.com>
         <CQZWKF2U2GVM.1X6AAD3SM05D6@bobo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5oARyNwTO8ytGJp9yoRxAWqj6npxLkUu
X-Proofpoint-GUID: gS3locDvbk1OZHtfZB2RRdu13bQ9POgy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-07 at 15:30 +1000, Nicholas Piggin wrote:
> On Mon Nov 28, 2022 at 12:44 PM AEST, Benjamin Gray wrote:
> > The DEXCR Speculative Branch Hint Enable (SBHE) aspect controls
> > whether
> > the hints provided by BO field of Branch instructions are obeyed
> > during
> > speculative execution.
> >=20
> > SBHE behaviour per ISA 3.1B:
> >=20
> > 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0The hints provided by BO field of=
 Branch instructions may
> > be
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ignored during speculat=
ive execution
> >=20
> > 1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0The hints provided by BO field of=
 Branch instructions are
> > obeyed
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0during speculative exec=
ution
> >=20
> > Add a sysctl entry to allow changing this aspect globally in the
> > system
> > at runtime:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/proc/sys/kernel/specul=
ative_branch_hint_enable
> >=20
> > Three values are supported:
> >=20
> > -1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Disable DEXCR SBHE sysctl override
> > =C2=A00:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Override and set DEXCR[SBHE] aspe=
ct to 0
> > =C2=A01:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Override and set DEXCR[SBHE] aspe=
ct to 1
> >=20
> > Internally, introduces a mechanism to apply arbitrary system wide
> > overrides on top of the prctl() config.
>=20
> Why have an override for this, and not others?
>=20

Should be in the commit message of course, but this aspect bleeds over
to other processes, so a user may wish to prevent all processes from
changing the value. The other aspects are probably only relevant to
their own process, though the implementation here should support
arbitrary system wide overrides.

