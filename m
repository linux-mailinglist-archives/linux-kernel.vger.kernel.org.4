Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8423567364F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjASLEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjASLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:04:18 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED7E8697;
        Thu, 19 Jan 2023 03:04:03 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JB3YvI020930;
        Thu, 19 Jan 2023 11:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=p7+tDIUczXm2hNnJv1jrE/wZ/DyIB+QCJXRJEJrRQME=;
 b=ZhWHr2uSXcUQ0UdIzpFMiOUqECKma+beANl7ysmL3ewbmmRhSqC83JncaJuHdAqbS+Uh
 /yRHyp3RP3qCTcMTig5/QV/DgJImI0pilUBEE7pC6Vt/GSUEPiEVaTfi6jXko6D2EWfg
 FExaKkOuUaAuVD2ix8SsLdGWAI368sApm82Dx0ySKAEO3wHZEhM69BSCijDZz2Rvb37H
 +Co9YKuxHNbRo4lfngyLLSQQJHmBGyeEPD99+fNfLc3+F20TpyQA8VkFypg1jJda/FRy
 DuVi1UyBi191utApXh2Z/fJeEyPUl2qqxwpepYYVvuxblQmMiKSz2vUkAhKc3y62HHi0 4g== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n74ng80a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 11:03:51 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J2TJXV029613;
        Thu, 19 Jan 2023 11:03:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n3knfcsw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 11:03:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JB3j8j46793064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 11:03:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D96FE2004B;
        Thu, 19 Jan 2023 11:03:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A212D20040;
        Thu, 19 Jan 2023 11:03:44 +0000 (GMT)
Received: from [9.171.48.94] (unknown [9.171.48.94])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 11:03:44 +0000 (GMT)
Message-ID: <a623049fb595480ffdf1130bbe800d79705cef03.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/7] s390/pci: Use dma-iommu layer
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Thu, 19 Jan 2023 12:03:44 +0100
In-Reply-To: <71b9e85d-960f-7403-0113-135746127f3b@linux.ibm.com>
References: <20230104120543.308933-1-schnelle@linux.ibm.com>
         <20230104120543.308933-5-schnelle@linux.ibm.com>
         <71b9e85d-960f-7403-0113-135746127f3b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qk4YpQUfMoRPN6V_Q70OQ9TcYAlKI_hs
X-Proofpoint-ORIG-GUID: qk4YpQUfMoRPN6V_Q70OQ9TcYAlKI_hs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_08,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=774
 spamscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > > > > > > > > > > > =C2=A0
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > =C2=A0static char *pci_sw_names[] =3D {
> > > > > > > > > > > > > > > > - "Allocated pages",
> > > > > > > > > > > > > > > > +/* TODO "Allocated pages", */
> > > > > > > >=20
> > > > > > > > ? Forgot to finish this?

Definitely forgot to remove the TODO. I think my latest plan was to
just remove this counter. With the DMA API conversion the
dma_map_ops.alloc and dma_map_ops.free move to common code and I don't
see how we could differentiate these from map/unmap on our side. I'm
not sure how helpful this counter really is either. If you're
interested in how many pages are mapped long term I think it makes more
sense to look at the difference between mapped and unmapped pages. What
do you think?
> > > > > > >=20
