Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A5E65CD82
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjADHMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjADHMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:12:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6FFCF4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:12:43 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3043i5pR031819;
        Wed, 4 Jan 2023 07:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wXuiVhprhbSkxfTvr8SMwzWiFu1aEfLSYrTGgr3E51s=;
 b=Sv6ksr+ZqFQwk0S5jkBzUC+MK7yiamypfblN+5df3ybX5p0PZMFd0jeo8iyDlqztcnm3
 aZ7xBUeHDVlVvvNdyPo1YVzH9GZeqXOY6e7YMokHIAyzK0Z6iRYVeNUVS8yUY1+VqrmM
 zP3JsB86X4LxYmsYW5hSOR6sgI+3Jwioo/fUQ+UphGCGr8ZpVqirQ41+a0ubhtaRJ7Ke
 eq03PnL3n3LMhjolCeJ/cdBSdf72aR0pIEIvZZDThg6xWUt4GFSkMFp20t9MxmTp3kXp
 bb0LInH45Fd/F2EG6FxGDa2hL8z3bQsesk9ALwRXUmDVmSfZb02bj1piKnsFMUxtes0G UQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvh8q1qfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 07:12:34 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303N6lEY001543;
        Wed, 4 Jan 2023 07:12:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mtcbfcw17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 07:12:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3047CUMq45154678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jan 2023 07:12:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C9DC2004B;
        Wed,  4 Jan 2023 07:12:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 000A620043;
        Wed,  4 Jan 2023 07:12:29 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jan 2023 07:12:29 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 4FB6B60060;
        Wed,  4 Jan 2023 18:12:28 +1100 (AEDT)
Message-ID: <f3081bfd9bb08914797186382bf5c9cd5140d2ad.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/7] powerpc/secvar: Use sysfs_emit() instead of
 sprintf()
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        zohar@linux.ibm.com, mpe@ellerman.id.au
Date:   Wed, 04 Jan 2023 18:12:28 +1100
In-Reply-To: <20221230042014.154483-4-ruscur@russell.cc>
References: <20221230042014.154483-1-ruscur@russell.cc>
         <20221230042014.154483-4-ruscur@russell.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X4ja3kInASJfL0ZrtZJhsMAw_3eESbJ7
X-Proofpoint-ORIG-GUID: X4ja3kInASJfL0ZrtZJhsMAw_3eESbJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_04,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=871
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-30 at 15:20 +1100, Russell Currey wrote:
> The secvar format string and object size sysfs files are both ASCII
> text, and should use sysfs_emit().=C2=A0 No functional change.
>=20
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

LGTM

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
> v2: new
>=20
> =C2=A0arch/powerpc/kernel/secvar-sysfs.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/secvar-sysfs.c
> b/arch/powerpc/kernel/secvar-sysfs.c
> index 1ee4640a2641..02e9fee1552e 100644
> --- a/arch/powerpc/kernel/secvar-sysfs.c
> +++ b/arch/powerpc/kernel/secvar-sysfs.c
> @@ -35,7 +35,7 @@ static ssize_t format_show(struct kobject *kobj,
> struct kobj_attribute *attr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D sprintf(buf, "%s\n", fo=
rmat);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D sysfs_emit(buf, "%s\n",=
 format);
> =C2=A0
> =C2=A0out:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of_node_put(node);
> @@ -57,7 +57,7 @@ static ssize_t size_show(struct kobject *kobj,
> struct kobj_attribute *attr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "%llu\n", =
dsize);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sysfs_emit(buf, "%llu\n=
", dsize);
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t data_read(struct file *filep, struct kobject *kobj,

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
