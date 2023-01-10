Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4EF6637F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 05:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjAJD7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjAJD7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:59:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC61F1EAE6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:59:52 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A1o7X5030908;
        Tue, 10 Jan 2023 03:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kV4pwHfhxRss3vSFOMQ0J/7ZFiqSYgg3xccuRzc2rmc=;
 b=tpvIto04HtjWtAWX6uKxaeuhpYgNbFlFjiDuu9KxR+aKXcM84tHJNZwbqAAe0J3BWlQS
 B5brLfr7qDG//CN6higQmzmgoICMDjYfaAKIOkFDsJ8ZGaBLf+yyNdSihsiaDZHGyseG
 uRuNr8u11T9uWrQx4LJJp1R/5WADCooaTxc+F4GawiNK8bO4Cl5DVoFR5udkNAzqC6QC
 zd7q/BHZLvQMmXqV2cj4pJJSzuMBV3D7uJNY5SLFRoVjunlucCiW/HmbNgmvOYcDCyWA
 xIWE37iRc644jZykPaGcEpbp7roLZAB+K1NlP8paI8eUqCj0sSIPRFqNB3nmDxprDPyk CA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n0ryaa9b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 03:59:39 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 309KWZrM013339;
        Tue, 10 Jan 2023 03:59:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3my00fm31x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 03:59:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30A3xYjt14287614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 03:59:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69B6E2004B;
        Tue, 10 Jan 2023 03:59:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7064E20040;
        Tue, 10 Jan 2023 03:59:33 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jan 2023 03:59:33 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 3B48E60213;
        Tue, 10 Jan 2023 14:59:27 +1100 (AEDT)
Message-ID: <5710fa2a1763fe82ca6ae95a1d3b4cc80be410f7.camel@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] powerpc/pseries: Implement secvars for dynamic
 secure boot
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        zohar@linux.ibm.com
Date:   Tue, 10 Jan 2023 14:59:26 +1100
In-Reply-To: <87zgawgcpa.fsf@mpe.ellerman.id.au>
References: <20221230042014.154483-1-ruscur@russell.cc>
         <20221230042014.154483-8-ruscur@russell.cc>
         <87zgawgcpa.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SxBlcy8mlxwd56EVhafbuV8UVLKLpQLW
X-Proofpoint-GUID: SxBlcy8mlxwd56EVhafbuV8UVLKLpQLW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_16,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=915 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100020
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-01-06 at 21:49 +1100, Michael Ellerman wrote:
>=20
> > +static int plpks_get_variable(const char *key, uint64_t key_len,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 u8 *data, uint64_t *data_size)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct plpks_var var =3D {0}=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 ucs2_namelen;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 *ucs2_name;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc =3D 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ucs2_namelen =3D get_ucs2nam=
e(key, &ucs2_name);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ucs2_namelen)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.name =3D ucs2_name;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.namelen =3D ucs2_namelen=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.os =3D PLPKS_VAR_LINUX;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D plpks_read_os_var(&va=
r);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto err;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*data_size =3D var.datalen +=
 sizeof(var.policy);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// We can be called with dat=
a =3D NULL to just get the object
> > size.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (data) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0memcpy(data, &var.policy, sizeof(var.policy));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0memcpy(data + sizeof(var.policy), var.data,
> > var.datalen);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> There's a lot of allocation and copying going on. The secvar-sysfs.c
> data_read() has kzalloc'ed data, but only after already doing the
> hcall
> to get the size. Then plpks_read_os_var() does an allocation for the
> hcall and then another allocation of the exact data size. Then
> data_read()
> does another copy into the sysfs supplied buffer.
>=20
> So to read a single variable we do the hcall twice, and allocate/copy
> the content of the variable 4 times?
>=20
> =C2=A0- Hypervisor into "output" in plpks_read_var().
> =C2=A0- "output" into "var->data" in plpks_read_var().
> =C2=A0- "var.data" into "data" in plpks_get_variable().
> =C2=A0- "data" into "buf" in data_read().
>=20
> As long as maxobjsize is < PAGE_SIZE I think we could do the hcall
> directly into "buf". Maybe we want to avoid writing into "buf"
> directly
> in case the hcall fails or something, but the other 3 copies seem
> unnecessary.

In the general case, I don't like passing buffer pointers straight from
parameters into hcalls, since the address has to be in the linear map,
and that's a detail I'd rather hide from callers. But otherwise, yes I
think we can probably shift to having the caller allocate the buffers.

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
