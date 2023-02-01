Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090FB67DC94
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjA0DVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjA0DVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:21:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF90936FC0;
        Thu, 26 Jan 2023 19:21:02 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R0daMf019307;
        Fri, 27 Jan 2023 03:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hRtKMDNOJZCWPaOA+pcd2NPeR9mTV+fIY08wzjAhk/o=;
 b=V5qOGEb0MhzCj8lDwaK3fv2nHKRHykFr5f33kdIw2S8Lz9CzYnCyjcrTn6clBpT9Z8Ln
 NqyEJPvOmBC6FiMzKNn3YcfaBRaAfCuNDr0SxJn0LVWNkBRS2QZYiSHiyAgKKOYw/kAZ
 Cn3qWjT+rFzVpgRlynWKVNdpengF6ffOTz5jFnzCMRZqKcl92t7gBCOjyNTAV5Zh9PIB
 aTfW3oejCilhxF1PP73kRGi1kRqarsM9BfYHSl6TERtyoOEhki9QTIUgCnNClENPv/Ek
 vkPYUAbSJ6zByr031Vp3pkpwnYap6nUsqnHS4sJOmizlJEj3zqfXl0IJW7X2VpX007Ba MA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nc372bn2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 03:20:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QBMXvm010330;
        Fri, 27 Jan 2023 03:20:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6q17t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 03:20:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30R3KfkI43385334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:20:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D39FB20043;
        Fri, 27 Jan 2023 03:20:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5608720040;
        Fri, 27 Jan 2023 03:20:41 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 03:20:41 +0000 (GMT)
Received: from [9.192.255.228] (unknown [9.192.255.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 7437360425;
        Fri, 27 Jan 2023 14:20:37 +1100 (AEDT)
Message-ID: <2de207dadb936f25db123ae2d02aea91a9841656.camel@linux.ibm.com>
Subject: Re: [PATCH v4 02/24] powerpc/pseries: Fix alignment of PLPKS
 structures and buffers
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Segher Boessenkool'" <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>,
        "erichte@linux.ibm.com" <erichte@linux.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "sudhakar@linux.ibm.com" <sudhakar@linux.ibm.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "bgray@linux.ibm.com" <bgray@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "gcwilson@linux.ibm.com" <gcwilson@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date:   Fri, 27 Jan 2023 14:20:37 +1100
In-Reply-To: <5118edd7f1f445afa1812d2b9b62dd4f@AcuMS.aculab.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-3-ajd@linux.ibm.com>
         <87pmb2pxpa.fsf@mpe.ellerman.id.au>
         <20230126171925.GN25951@gate.crashing.org>
         <5118edd7f1f445afa1812d2b9b62dd4f@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RH7n1wJMGdJfXyigP1OFY3W1fdGCKevp
X-Proofpoint-GUID: RH7n1wJMGdJfXyigP1OFY3W1fdGCKevp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=871 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270026
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-26 at 17:31 +0000, David Laight wrote:
> Changing the size to kzalloc() doesn't help.
> The alignment depends on the allocator and is only required to have
> a relatively small alignment (ARCH_MINALIGN?) regardless of the size.
>=20
> IIRC one of the allocators adds a small header to every item.
> It won't return 16 byte aligned items at all.

I'm relying on the behaviour described in Documentation/core-
api/memory-allocation.rst:

    The address of a chunk allocated with kmalloc is aligned to at
    least ARCH_KMALLOC_MINALIGN bytes. For sizes which are a power of
    two, the alignment is also guaranteed to be at least the respective
    size.

Is this wrong?


Andrew

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
