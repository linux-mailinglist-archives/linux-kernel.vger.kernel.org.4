Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398BD65CC6E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 05:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjADEqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 23:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjADEp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 23:45:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D44F175B6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:45:57 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3040ulGl022581;
        Wed, 4 Jan 2023 04:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JvZkHHC50ArPzIGww/ALYR9ijpNf5d0ylA9p+lduP3A=;
 b=k6EkSKFm4lqn1lnsOo2AIp/KE/z2MyTcq2DjwEI6IqvY3quiVhktAttwEIcMpmV/FN0F
 WFk24EEiBL8ftlT+C9kXCW+D9Cb003H+u6vn+bgrEYpeqR62p5A1aNXFwv8KM9+fINl8
 9sWvcenZttUePkcbtc2A9z6aMH9OqwYRuRxuVpFY1QLGTb06rTcYNq8Cqw0D22ato81x
 qpsVEZVUIV2+s9stNE0qk2BgaVVq4yzktu5m/ocQ4mUiB/HiZIuxSu8Z8zStHtjEkcR7
 Lb4v9KBSDtm8LiSPxlU7Gp7JuZU4eEsK68qec280VQUuH2v8Z6wZvGgCviIyJNgEc3NG 4A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjd7dskx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 04:45:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303Mfu2E001927;
        Wed, 4 Jan 2023 04:45:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6cqya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 04:45:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3044jc3P40894966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jan 2023 04:45:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7FB32004E;
        Wed,  4 Jan 2023 04:45:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38A3A20049;
        Wed,  4 Jan 2023 04:45:38 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jan 2023 04:45:38 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 41E2A60060;
        Wed,  4 Jan 2023 15:45:33 +1100 (AEDT)
Message-ID: <d9b726fad8a4c543f278a9156f81475f5e8fab5c.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/7] powerpc/pseries: Log hcall return codes for
 PLPKS debug
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        zohar@linux.ibm.com, mpe@ellerman.id.au
Date:   Wed, 04 Jan 2023 15:45:22 +1100
In-Reply-To: <20221230042014.154483-2-ruscur@russell.cc>
References: <20221230042014.154483-1-ruscur@russell.cc>
         <20221230042014.154483-2-ruscur@russell.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fejRzh6aIMZblR1-7xZ5jZFha_mNc3xx
X-Proofpoint-GUID: fejRzh6aIMZblR1-7xZ5jZFha_mNc3xx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_02,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-30 at 15:20 +1100, Russell Currey wrote:
> The plpks code converts hypervisor return codes into their Linux
> equivalents so that users can understand them.=C2=A0 Having access to the
> original return codes is really useful for debugging, so add a
> pr_debug() so we don't lose information from the conversion.
>=20
> Signed-off-by: Russell Currey <ruscur@russell.cc>

This is indeed useful to have.

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Tested-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
> =C2=A0arch/powerpc/platforms/pseries/plpks.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/pseries/plpks.c
> b/arch/powerpc/platforms/pseries/plpks.c
> index 9e4401aabf4f..820218eb894f 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -131,6 +131,8 @@ static int pseries_status_to_err(int rc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0err =3D -EINVAL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("Converted hypervisor=
 code %d to Linux %d\n", rc,
> err);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return err;
> =C2=A0}
> =C2=A0

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
