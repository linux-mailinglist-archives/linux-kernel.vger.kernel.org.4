Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C81267AADE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbjAYH2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjAYH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:28:02 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA121E2A4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:27:59 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P7OXQb005783;
        Wed, 25 Jan 2023 07:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=FfhVjFCYsJ7dAlAMtp/34XlGJFtHr6re2RiJOsHNLGg=;
 b=LL+hoXimFDg7XgnRP7HNG7peBxxa4Lk9s/+dlusdxfJ0opDC5BAkOSX9NHf2vFMCBsp1
 uHzFGGN7pXKFN9EwWQXa8Jx7r8QrBHfXxgpg0YNaE8q8mwOysrHlHS2OKag+5/RQePBe
 NweMQylOz0IZqwdU+irh4l2HFPhhU1xN916UvUCkYxBhlu6RRyf88JyMUIWB+S/OQSP4
 KvN09MsYQFnhZuYAOq2chVT0GYL+yh+2X3nz06H68Cit/SXWFdxMtY/Z7rzHI3SXizCy
 /Vd9hX4b+pyBqsSIIQHMcKRR7IXP0JRZBIa1q3yse7H+xVOYihW9kGVvsYM+8mgAdX/3 jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vcfxrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:27:43 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30P7K44t012765;
        Wed, 25 Jan 2023 07:27:43 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vcfxr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:27:43 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30P0hr78004576;
        Wed, 25 Jan 2023 07:27:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n87afbg31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:27:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30P7RcdH43713006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 07:27:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE1D42004B;
        Wed, 25 Jan 2023 07:27:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0369420043;
        Wed, 25 Jan 2023 07:27:38 +0000 (GMT)
Received: from localhost (unknown [9.43.44.248])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 07:27:37 +0000 (GMT)
Date:   Wed, 25 Jan 2023 12:57:35 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: arch/powerpc/kernel/head_85xx.o: warning: objtool:
 .head.text+0x1a6c: unannotated intra-function call
To:     kernel test robot <lkp@intel.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com
References: <202301161955.38kK6ksW-lkp@intel.com>
        <b2273730-f885-7658-7ec4-12fb5bfc515b@linux.ibm.com>
In-Reply-To: <b2273730-f885-7658-7ec4-12fb5bfc515b@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1674631223.9e09lbzzb6.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: diT2iJU4YjmWzYK-pl-jDh7d03PW7NzN
X-Proofpoint-ORIG-GUID: dVxg2tl4LVOhYt4gQaRSdeIE_d5GI_xr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_02,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1011 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sathvika Vasireddy wrote:
>=20
>>>> arch/powerpc/kvm/booke.o: warning: objtool: kvmppc_fill_pt_regs+0x30: =
unannotated intra-function call
>=20
> As an attempt to fix it, I tried expanding ANNOTATE_INTRA_FUNCTION_CALL=20
> macro to indicate that the branch target is valid. It then threw another=20
> warning (arch/powerpc/kvm/booke.o: warning: objtool:=20
> kvmppc_fill_pt_regs+0x38: intra_function_call not a direct call). The=20
> below diff just removes the warnings for me, but I'm not very sure if=20
> this is the best way to fix the objtool warnings seen with this=20
> particular file. Please let me know if there are any better ways to fix i=
t.
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 0dce93ccaadf..b6a413824b98 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -917,7 +917,9 @@ static void kvmppc_fill_pt_regs(struct pt_regs *regs)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm("mr %0, 1" : "=3Dr"(r1));
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm("mflr %0" : "=3Dr"(lr));
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm("mfmsr %0" : "=3Dr"(msr))=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm(".pushsection .discard.intra_fu=
nction_calls; .long 999f;=20
> .popsection; 999:");
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm("bl 1f; 1: mflr %0" : "=
=3Dr"(ip));

I don't think you can assume that there won't be anything in between two=20
asm statements. Does it work if you combine both the above asm=20
statements into a single one?

Even if that works, I don't think it is good to expand the macro here. =20
That asm statement looks to be trying to grab the current nip. I don't=20
know enough about that code, and someone who knows more about KVM may be=20
able to help, but it looks like we should be able to simply set 'ip' to=20
the address of kvmppc_fill_pt_regs()?


- Naveen

