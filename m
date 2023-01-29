Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923AB680121
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 20:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjA2THJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 14:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2THH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 14:07:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC976B2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 11:07:06 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TEB7JE012480;
        Sun, 29 Jan 2023 19:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7BSGijmSC50cLGmQiF9MSmmmRm6TlU5pfEDUl6oMaU0=;
 b=dtfKMN7iNBH4um7mN7KQjiddnULBjVXeuIxXaFN/Y68TDW2grRqaOzeuaXDgOxS6xUM7
 OduNAOBojBwHlHohawS0xyBaKbcbdyu7Iyrg/0lHEuIRWS9HKl8tVpLmn7qXtIOVUNz+
 mwUAbHUVXkZaCWLLGN683idbOsEKf2QunxRpzYsaNV21xsB0gmg1UD5Yp8wTsg5mDm96
 UWVnwWKYOQYrj3MNiBSZL5slnBOTUPW4l0gumx69BNYINr9GVgfQbGuAUlKzcb+rlwHU
 yqR5Yc1EMi3sPwC88F1nR5kmvK/NVZkT7dUdKvDGFHU8kpSxLz45VztfETeI6LyAkO03 AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddv159wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:07:05 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30TImU0M024407;
        Sun, 29 Jan 2023 19:07:05 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddv159vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:07:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30T4X6ha013356;
        Sun, 29 Jan 2023 19:07:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ncvty9d2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:07:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30TJ70No44433664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 19:07:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DED5C20043;
        Sun, 29 Jan 2023 19:07:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89FF120040;
        Sun, 29 Jan 2023 19:07:00 +0000 (GMT)
Received: from [9.179.11.57] (unknown [9.179.11.57])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 29 Jan 2023 19:07:00 +0000 (GMT)
Message-ID: <d4ae0db51f721234321d50aa8363cc061690a6d6.camel@linux.ibm.com>
Subject: Re: [PATCH] lib/zlib: remove redundation assignement of avail_in
 dfltcc_gdht()
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Tom Rix <trix@redhat.com>, zaslonko@linux.ibm.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 29 Jan 2023 20:07:00 +0100
In-Reply-To: <20230128165048.1245792-1-trix@redhat.com>
References: <20230128165048.1245792-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q2WUmVlYV7twxuVihUwlC_hfajhBpE1o
X-Proofpoint-GUID: a8TFDMo4_tuwStNry0oK2-dupfMLM57E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-01-28 at 08:50 -0800, Tom Rix wrote:
> cppcheck reports
> lib/zlib_dfltcc/dfltcc_deflate.c:65:21: warning: Redundant assignment
> of 'avail_in' to itself. [selfAssignment]
> =C2=A0=C2=A0=C2=A0 size_t avail_in =3D avail_in =3D strm->avail_in;
>=20
> Only setting avail_in once is needed.
>=20
> Fixes: aa5b395b69b6 ("lib/zlib: add s390 hardware support for kernel
> zlib_deflate")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> =C2=A0lib/zlib_dfltcc/dfltcc_deflate.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/zlib_dfltcc/dfltcc_deflate.c
> b/lib/zlib_dfltcc/dfltcc_deflate.c
> index 80924f067c24..b732b6d9e35d 100644
> --- a/lib/zlib_dfltcc/dfltcc_deflate.c
> +++ b/lib/zlib_dfltcc/dfltcc_deflate.c
> @@ -62,7 +62,7 @@ static void dfltcc_gdht(
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 deflate_state *state =3D (deflate_state *)strm->=
state;
> =C2=A0=C2=A0=C2=A0=C2=A0 struct dfltcc_param_v0 *param =3D &GET_DFLTCC_ST=
ATE(state)->param;
> -=C2=A0=C2=A0=C2=A0 size_t avail_in =3D avail_in =3D strm->avail_in;
> +=C2=A0=C2=A0=C2=A0 size_t avail_in =3D strm->avail_in;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 dfltcc(DFLTCC_GDHT,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 param,=
 NULL, NULL,

Thanks for spotting this!

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
