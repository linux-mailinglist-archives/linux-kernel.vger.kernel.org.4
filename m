Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C84674D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 07:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjATGUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 01:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjATGUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 01:20:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF6981990;
        Thu, 19 Jan 2023 22:20:30 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K65R0D023947;
        Fri, 20 Jan 2023 06:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=aXKU39OQSaaTWLJC/8fawztHomaVSmHxM7RXlYvCrik=;
 b=BzesppLCkekQqNZFjnhRJX/o7JPv9ECwVqQHSGvJagj7SNdHUBowdbIe7e73xrKEOSkG
 vVgytirZv68oS915r5XadFdac089zsCzkOTyzpqq8JNnNSCqZxRXLi3luC+tkYuIFIY6
 Xejmh1KGVyJHdIiURBu6W4en2qFL8SATWTF4K9uYhfTG77Fpqtn2juwHsSa4yXGhYosB
 GNEJdTrDIaO+2PDI9YdQ4+Yf8a6O8wKWEGcmyuu65szcTzbldHTQc0t5lKURqu86ofKL
 rMRYS/FQmX50NRvxLb0WJXZndGp1M4FVSiclXFYKsYV64H/GF+P9LsUSk/D2w1l2odK+ Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7ncrr9u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 06:20:24 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30K65ZNC024749;
        Fri, 20 Jan 2023 06:20:23 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7ncrr9tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 06:20:23 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30K63wGR002145;
        Fri, 20 Jan 2023 06:20:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3n3m16ngq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 06:20:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30K6KJJS45416740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 06:20:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 391862004B;
        Fri, 20 Jan 2023 06:20:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B048C20040;
        Fri, 20 Jan 2023 06:20:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jan 2023 06:20:18 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 36414602EB;
        Fri, 20 Jan 2023 17:20:15 +1100 (AEDT)
Message-ID: <4466f0800b912d287c1f4c8a4454bf841b819537.camel@linux.ibm.com>
Subject: Re: [PATCH v3 08/24] powerpc/secvar: Allow backend to populate
 static list of variable names
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, gcwilson@linux.ibm.com
Date:   Fri, 20 Jan 2023 17:20:14 +1100
In-Reply-To: <CPVRLZNI6WWQ.1AZVH3NCPCOYL@bobo>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
         <20230118061049.1006141-9-ajd@linux.ibm.com>
         <CPVRLZNI6WWQ.1AZVH3NCPCOYL@bobo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aHrPUNO-Ia3zFPlc5RxsVvgdddwL6PGR
X-Proofpoint-GUID: e8XN44HRcOR7wIHSB5opgMG6MT6l5ANr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_03,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-19 at 11:10 +1000, Nicholas Piggin wrote:
> > diff --git a/arch/powerpc/include/asm/secvar.h
> > b/arch/powerpc/include/asm/secvar.h
> > index ebf95386d720..c8bee1834b54 100644
> > --- a/arch/powerpc/include/asm/secvar.h
> > +++ b/arch/powerpc/include/asm/secvar.h
> > @@ -23,6 +23,10 @@ struct secvar_operations {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t (*format)(char =
*buf);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*max_size)(u64 *ma=
x_size);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct attribute =
**config_attrs;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// NULL-terminated array of =
fixed variable names
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// Only used if get_next() i=
sn't provided
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char * const *var_name=
s;
>=20
> The other way you could go is provide a sysfs_init() ops call here,
> and export the add_var as a library function that backends can use.

True, I think I'll keep it as is for now but I'll have a think about
whether to do that in a later patch.

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
