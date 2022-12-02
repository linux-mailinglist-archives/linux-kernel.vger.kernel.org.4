Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4070E63FDA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiLBBem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLBBek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:34:40 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B73D11CD;
        Thu,  1 Dec 2022 17:34:39 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B21DiEJ009769;
        Fri, 2 Dec 2022 01:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=nNFlj7IlbzH8Y0VxNQIQygN9uEj4JjNSylmNATnWK/c=;
 b=tofiYkTGLKHPkE2z+tV2skbXmR6fnfc5Aqj3noU6twa3Lv7UHecn2NbIe3iju0ltPWa6
 ngYJpNi0MwJf/xBCfg+k/0IvbAMLVzsgEl4FzVLiA1q5m24avThDg8uTIMuszHC7cT0N
 IoeIRcOCeVxszQKvIIP+Ko3okMiYTWTAdinpWC6KCOB2ztDO6eB2aExYVk8h3VKkTmCZ
 KMjargKqc+A9SeIZjlOk2h/N2OIZODuGItJT3EVZAiYPRg3idYLVtfB+OZ3HeSKjeZzJ
 vFh6YBsruIzI6IlpGFhV1fsHD4vgMxrv/UqpCmTbU0sy9UgwLTDqqmJdBfSmdUKZFWyk yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m77gw8cn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 01:33:54 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B21Urt6005339;
        Fri, 2 Dec 2022 01:33:54 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m77gw8cmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 01:33:54 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B21M2x0026576;
        Fri, 2 Dec 2022 01:33:52 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3m3ae9dyve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 01:33:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B21Xn0s49742160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Dec 2022 01:33:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EB10AE04D;
        Fri,  2 Dec 2022 01:33:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4752DAE045;
        Fri,  2 Dec 2022 01:33:49 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Dec 2022 01:33:49 +0000 (GMT)
Received: from li-0d7fa1cc-2c9d-11b2-a85c-aed20764436d.ibm.com (unknown [9.177.77.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 55CE66015C;
        Fri,  2 Dec 2022 12:33:38 +1100 (AEDT)
Message-ID: <3b13190d1f0bebd31c2e44a6a936e6d8f8e77892.camel@linux.ibm.com>
Subject: Re: linux-next: build failure after merge of the tip tree
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Christopher M. Riedl" <cmr@bluescreens.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Date:   Fri, 02 Dec 2022 12:33:34 +1100
In-Reply-To: <20221202112646.5813c34b@canb.auug.org.au>
References: <20221202112646.5813c34b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TGrNh6eul9A1mGnnAwFQ7tfR8i18utK0
X-Proofpoint-GUID: KF9HGiCVS8ewIwADp7ufNt1ae7uQNiTo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_14,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020010
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-02 at 11:26 +1100, Stephen Rothwell wrote:
> Though, I wonder if the powerpc tree should
> use mm_alloc() instead of copy_init_mm() as well?=C2=A0 The tip tree
> commit
> says:
>=20
> =C2=A0=C2=A0=C2=A0 Instead of duplicating init_mm, allocate a fresh mm. T=
he
> advantage is
> =C2=A0=C2=A0=C2=A0 that mm_alloc() has much simpler dependencies. Additio=
nally it
> makes
> =C2=A0=C2=A0=C2=A0 more conceptual sense, init_mm has no (and must not ha=
ve) user
> state
> =C2=A0=C2=A0=C2=A0 to duplicate.
>=20

Yes, that seems fine. All we need is that the page table isn't shared
and the kernel mappings are the same as in init_mm. It seems mm_alloc()
does this at some point.
