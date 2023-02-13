Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9572B693EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjBMHG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBMHG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:06:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA1DC14F;
        Sun, 12 Feb 2023 23:06:55 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D5H9DB023820;
        Mon, 13 Feb 2023 07:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qWEsjfSLm20NR7cgu39EiHHZE+a5Ptdfs1rUWc2ZQGs=;
 b=tLxoYTtm1xfLzpt/C33zO1FF85kivIj0Z9X5/mCqOYOgU9m6d9b6sEVTcm0SlNRL+kDn
 ntL0JZyUbSEUGTWk/6HejMzx51SD0u5Tw6VhjzjSbU9LEe7IsgGN/oaC3bmNVZyBC/yW
 LuuGzg3RRQYNJBBNZbGVOBrXbD5Dd/iE1jUUTkIfH1WlNjTh28q7FHiXJYdsS38HViTC
 lORwdP4g43JGs2BHIbNKJZybFav70nmJNK9a2O1fg73lnCBxncus5A66SO7qO6bfgLe8
 E//BMGV/JabSob/ZfaLoUneyjKgsPPGnDwsIQI4vzmBJtm5MUGVv0yoS8AN+ldBn599U Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq4ftb4jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:06:44 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31D6w7er003800;
        Mon, 13 Feb 2023 07:06:44 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq4ftb4hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:06:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31CIH0qt017758;
        Mon, 13 Feb 2023 07:06:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6j8mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:06:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31D76ds015860402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 07:06:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A21D72004D;
        Mon, 13 Feb 2023 07:06:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28DF920040;
        Mon, 13 Feb 2023 07:06:39 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Feb 2023 07:06:39 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 3E80C60418;
        Mon, 13 Feb 2023 18:06:37 +1100 (AEDT)
Message-ID: <6a7d93a51d19e0cec28b2169d1ab0262148ff717.camel@linux.ibm.com>
Subject: Re: [PATCH v6 24/26] powerpc/pseries: Implement secvars for dynamic
 secure boot
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
Date:   Mon, 13 Feb 2023 18:06:36 +1100
In-Reply-To: <f35e9ba1-5fdb-4cfa-5b41-cc55307dcd45@linux.ibm.com>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
         <20230210080401.345462-25-ajd@linux.ibm.com>
         <f35e9ba1-5fdb-4cfa-5b41-cc55307dcd45@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: poTtsvcm-YPlY9HrCe3JDzzg6sEAZ6bL
X-Proofpoint-ORIG-GUID: f0dY8lXzRFscAF21b2e9zPbht2vgGy0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=820 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-02-10 at 16:23 -0500, Stefan Berger wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy(&flags, data, sizeof(=
flags));
>=20
> conversion from bytestream to integer: I think in this case it would
> be better to use
>=20
> flags =3D cpu_to_be64p((__u64*)data);
>=20
> so that the flags always in hypervisor/big endian format

Thanks for catching this - it turns out we weren't properly testing the
one flag that exists (append vs replace) in our test script, so I
didn't notice this.

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
