Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3884465CD7B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjADHHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjADHHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:07:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C7E17592
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:07:06 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3046qRor012996;
        Wed, 4 Jan 2023 07:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Fiq+4hzRaHWk1SCZUFiR+trgSossCWrgCo/YF4qmnP8=;
 b=W4W/dpTXKLGSuIyrQuxDsjx/eYjJc2lPgLZCVsL654Bb4PnuBBVMpuMEa/Ec8g4wNu74
 oTjZMqABufwS+axRPF34XZStOhnO6r9suLLkAvIHVY+ru/84b/8sHsjma0isyjZMkVu+
 O43x+avdEAehuuvH+hDopYqw500qV4HLOJ2F2Czp/pH63fAxAQM3HVZjFO4Nt9bTcHNL
 phmGcrG86+7lvgOoDZDNo/zShkkHPh/loxvyfpidWmghZx2tf7tZ7GRTyrRwJLAqDGl0
 d5dlqWlppVgXopPHD1ELvja2RFJOQvVtkTFbe8Mu+tDMYTqPz2qcMR9L5mwztjcGfK0J 7g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjk2qnac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 07:06:57 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303MIgqJ001428;
        Wed, 4 Jan 2023 07:06:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mtcbfcvuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 07:06:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30476qSC44892586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jan 2023 07:06:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57B862004B;
        Wed,  4 Jan 2023 07:06:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDEBD20049;
        Wed,  4 Jan 2023 07:06:51 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jan 2023 07:06:51 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 7A5D260060;
        Wed,  4 Jan 2023 18:06:46 +1100 (AEDT)
Message-ID: <97f07422a32799ec1a09356430b03faef73d3cdd.camel@linux.ibm.com>
Subject: Re: [PATCH] drivers/misc/ocxl/context.c : eliminate unnecessary
 type conversions
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Dong Chuanjian <chuanjian@nfschina.com>, fbarrat@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Jan 2023 18:06:46 +1100
In-Reply-To: <20221226025145.4363-1-chuanjian@nfschina.com>
References: <20221226025145.4363-1-chuanjian@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KsmrSkjSV5WG5Sv3mdF7rhr-AxgHADbD
X-Proofpoint-GUID: KsmrSkjSV5WG5Sv3mdF7rhr-AxgHADbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_04,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=857 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1011 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-12-26 at 10:51 +0800, Dong Chuanjian wrote:
> remove unnecessary void* type casting.
>=20
> Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>


[+linuxppc-dev, which was misspelled in the original email]

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

>=20
> diff --git a/drivers/misc/ocxl/context.c
> b/drivers/misc/ocxl/context.c
> index 9eb0d93b01c6..d6e081812300 100644
> --- a/drivers/misc/ocxl/context.c
> +++ b/drivers/misc/ocxl/context.c
> @@ -55,7 +55,7 @@ EXPORT_SYMBOL_GPL(ocxl_context_alloc);
> =C2=A0 */
> =C2=A0static void xsl_fault_error(void *data, u64 addr, u64 dsisr)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ocxl_context *ctx =3D (=
struct ocxl_context *) data;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ocxl_context *ctx =3D d=
ata;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&ctx->xsl_erro=
r_lock);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ctx->xsl_error.addr =3D a=
ddr;

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
