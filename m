Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53BC65CD7F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjADHKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjADHKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:10:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3C317592
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:10:45 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3044eevf005526;
        Wed, 4 Jan 2023 07:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9VQSJWFpAcrYY8s1Byv//ly8sqdyP4J2gMGZMasy1q4=;
 b=QcATKQDTeffhIDf/5Ei/5HBHlJjbQiZndI0Mnd3imTkrb1vUTGaKkUCfNoZk95otQyj5
 M8Ffo0rSpItedAwsLjNn7Oq0bPt28bzYfdkmPgS5FXqzBPbEG4a43KQi+hXoXoDTf/is
 xKVP7Aa7XbMfEyhZi2D78A6Uzn6R+osayhTAnRZYAuaJKgVJZKVnaSx+5UaerUNdwtOQ
 bSyVRqy/gfAicRqWXHZ2+u2aeQNlfRo1KAyMFUBcyBxYaNz0tkLQHPwvbF6OICyAgNTv
 IuoQFg9i62mik2VCFiqcGk8T4H6nUp+Z8Mokw6bzITtyFjEmVXidA85QxUZhZGGbjrEb AQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvefjcjgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 07:10:35 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3041eEah001601;
        Wed, 4 Jan 2023 07:10:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6bj6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 07:10:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3047AUWx47055152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jan 2023 07:10:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF1E320040;
        Wed,  4 Jan 2023 07:10:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4338620043;
        Wed,  4 Jan 2023 07:10:30 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jan 2023 07:10:30 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 9522A60060;
        Wed,  4 Jan 2023 18:10:28 +1100 (AEDT)
Message-ID: <0daecda189cdafc89f4576b7d1da1ca219abe93d.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/7] powerpc/secvar: WARN_ON_ONCE() if multiple
 secvar ops are set
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        zohar@linux.ibm.com, mpe@ellerman.id.au
Date:   Wed, 04 Jan 2023 18:10:28 +1100
In-Reply-To: <20221230042014.154483-3-ruscur@russell.cc>
References: <20221230042014.154483-1-ruscur@russell.cc>
         <20221230042014.154483-3-ruscur@russell.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OAoMTL6HpYjg6rmANkvZg6sep01oRpz0
X-Proofpoint-GUID: OAoMTL6HpYjg6rmANkvZg6sep01oRpz0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_04,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-30 at 15:20 +1100, Russell Currey wrote:
> The secvar code only supports one consumer at a time.
>=20
> Multiple consumers aren't possible at this point in time, but we'd
> want
> it to be obvious if it ever could happen.
>=20
> Signed-off-by: Russell Currey <ruscur@russell.cc>

This seems sensible - there aren't any cases where set_secvar_ops()
should be called twice.

> ---
> =C2=A0arch/powerpc/kernel/secvar-ops.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/secvar-ops.c
> b/arch/powerpc/kernel/secvar-ops.c
> index 6a29777d6a2d..aa1b2adc2710 100644
> --- a/arch/powerpc/kernel/secvar-ops.c
> +++ b/arch/powerpc/kernel/secvar-ops.c
> @@ -8,10 +8,12 @@
> =C2=A0
> =C2=A0#include <linux/cache.h>
> =C2=A0#include <asm/secvar.h>
> +#include <asm/bug.h>
> =C2=A0
> -const struct secvar_operations *secvar_ops __ro_after_init;
> +const struct secvar_operations *secvar_ops __ro_after_init =3D NULL;

I think this is implicitly NULL, but it's fine to make it explicit.

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

> =C2=A0
> =C2=A0void set_secvar_ops(const struct secvar_operations *ops)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WARN_ON_ONCE(secvar_ops);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0secvar_ops =3D ops;
> =C2=A0}

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
