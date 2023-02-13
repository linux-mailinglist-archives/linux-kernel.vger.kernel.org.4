Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F7D693EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBMHHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjBMHH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:07:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB8113CC;
        Sun, 12 Feb 2023 23:07:27 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D5SmvN005673;
        Mon, 13 Feb 2023 07:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Wsb6Db5CHCaUNvoObhKvjgBoSUgH9x04OKVVg4UMbLg=;
 b=c43YMDIMNxX9XQ0uHsr4p0cev6TQj7+kiVbANNhlCPGwylr0My3a6yaTmRumjvCMtK6f
 kPJdKW7eMvNa8vbpNvtC3GYddZC3pQ/7vpCzia4qvXG8iIvteg0a7jxqtnLhRM7edYr7
 UgKlw6lIdn0d8rUIKsnY5NY5iR6dKzzAPRV9JoR0iNf2ywK+ISLfmDr7BqXVa7tjDCkb
 I3La6QkxIOlQALH4JYgxkzoNxs9PfsQzRGYA6ye4amek8uB5o8e4rLgB4pUST0ESOZRV
 QsmIgxTBlxJ1fyeV0IEbZU5ka+hHdcNYvZxrqBvgVOqKRHV8TY2+1qtTwuCMhlqIuNMU hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq5c92jws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:07:18 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31D6oXvR005668;
        Mon, 13 Feb 2023 07:07:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq5c92jw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:07:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31CIPFwo011341;
        Mon, 13 Feb 2023 07:07:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6t98t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:07:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31D77Ccn44368380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 07:07:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF1232004B;
        Mon, 13 Feb 2023 07:07:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AB9020040;
        Mon, 13 Feb 2023 07:07:12 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Feb 2023 07:07:12 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8FDE5602EB;
        Mon, 13 Feb 2023 18:07:10 +1100 (AEDT)
Message-ID: <c706add87f230c12d41dc5f74789ed18f43fa9d5.camel@linux.ibm.com>
Subject: Re: [PATCH v6 24/26] powerpc/pseries: Implement secvars for dynamic
 secure boot
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Michael Ellerman <michaele@au1.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, ruscur@russell.cc, joel@jms.id.au,
        bgray@linux.ibm.com, brking@linux.ibm.com, gcwilson@linux.ibm.com
Date:   Mon, 13 Feb 2023 18:07:10 +1100
In-Reply-To: <87y1p2uodm.fsf@mpe.ellerman.id.au>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
         <20230210080401.345462-25-ajd@linux.ibm.com>
         <f35e9ba1-5fdb-4cfa-5b41-cc55307dcd45@linux.ibm.com>
         <a63276d5-1be4-b140-6a4a-4ad4efa60eda@linux.ibm.com>
         <b928627ce5a2d90b0ad33d89ce48ec19a2655111.camel@linux.ibm.com>
         <87y1p2uodm.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RXstHH5b_uAxGVLS8OTaZ5SMyJsaoYg4
X-Proofpoint-ORIG-GUID: 6qvCpwV6YpGDwA3qxiqIhw2mujZYLkDk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-02-13 at 16:26 +1100, Michael Ellerman wrote:
> Andrew Donnellan <ajd@linux.ibm.com> writes:
> > On Fri, 2023-02-10 at 16:28 -0500, Stefan Berger wrote:
> > > > > +err:
> > > > > +=C2=A0=C2=A0=C2=A0 kfree(var.data);
> > > >=20
> > > > remove the kfree()
> > >=20
> > > Actually don't remove it but it should probably be
> > >=20
> > > if (var.data !=3D &version)
> > > =C2=A0=C2=A0=C2=A0=C2=A0 kfree(var.data);
> > >=20
> >=20
> > Argh, thanks for catching this.
> >=20
> > I don't think the condition is needed - we can assume the var.data
> > is
> > unmodified.
> >=20
> > mpe, are you able to fix this up in merge?
>=20
> Yeah, can you reply here with the delta you want applied.
>=20
> cheers


diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c
b/arch/powerpc/platforms/pseries/plpks-secvar.c
index 98d0f2b31e0d..bdfe63bc8705 100644
--- a/arch/powerpc/platforms/pseries/plpks-secvar.c
+++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
@@ -135,7 +135,7 @@ static int plpks_set_variable(const char *key, u64
key_len, u8 *data,
 		goto err;
 	var.namelen =3D rc * 2;
=20
-	memcpy(&flags, data, sizeof(flags));
+	flags =3D cpu_to_be64p((__u64 *)data);
=20
 	var.datalen =3D data_size - sizeof(flags);
 	var.data =3D data + sizeof(flags);
@@ -184,7 +184,6 @@ static ssize_t plpks_secvar_format(char *buf,
size_t bufsize)
 	ret =3D snprintf(buf, bufsize, "ibm,plpks-sb-v%hhu", version);
=20
 err:
-	kfree(var.data);
 	return ret;
 }
=20



--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
