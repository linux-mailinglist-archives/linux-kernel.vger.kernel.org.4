Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780B767A7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjAYApe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjAYApc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:45:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27334AA6C;
        Tue, 24 Jan 2023 16:45:30 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OLRBns027197;
        Wed, 25 Jan 2023 00:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=H03eYmyGEROq9vsq7tIFQliUIeCvTRDLi/flje0uI1E=;
 b=rcvj90jHXMGusE7bd4DIaX0si3IaHFEpaAZBQshKnGJdCKBzgI/CQ7rHA5eGHZvQX3ON
 K8SnwwQuj6+/gUn/ljTyIPvXMCezOcsm7/fILPBBtQ2UhUYXrrVATrKU776jvwB3kJ84
 MQS1hkpi7cmxYV6UhB6Z0mPoiRRk28xCL1QM2Q1Gf/iNhy3EomwWIFixafk1/qQ8EHz5
 AJslxIhgGurN9urM7MNpcULxhdTEf480sNOMxOUnOPO3J10O870fqM96Ogug5J5Q0/XH
 4hrrWSl6bnjspdLcWzATb+OqwaKXnboZdwK6lTStw5eBIufy9NcFBxGEqTrnCDXOQ75S hg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nabufe4yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 00:45:17 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30OFtUHm015320;
        Wed, 25 Jan 2023 00:45:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6b5af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 00:45:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30P0jDxj22086256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 00:45:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C2DC20040;
        Wed, 25 Jan 2023 00:45:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4A5A20043;
        Wed, 25 Jan 2023 00:45:12 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 00:45:12 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 30829605F1;
        Wed, 25 Jan 2023 11:45:09 +1100 (AEDT)
Message-ID: <f8351bc887f8f95063f5e301f78755ef608a76a0.camel@linux.ibm.com>
Subject: Re: [PATCH v4 24/24] integrity/powerpc: Support loading keys from
 pseries secvar
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, mpe@ellerman.id.au, gjoyce@linux.ibm.com,
        sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        joel@jms.id.au
Date:   Wed, 25 Jan 2023 11:45:08 +1100
In-Reply-To: <57dca1ea3ef66bc0935bdd1dab4536f1151f4004.camel@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-25-ajd@linux.ibm.com>
         <57dca1ea3ef66bc0935bdd1dab4536f1151f4004.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oD1Spg5gcsRbhjst3Fj-QbmPqUNYwWRd
X-Proofpoint-ORIG-GUID: oD1Spg5gcsRbhjst3Fj-QbmPqUNYwWRd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_17,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=731 bulkscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250001
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-24 at 10:14 -0500, Mimi Zohar wrote:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* The following only applie=
s for the edk2-compat backend.
> > */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0node =3D of_find_compatible_=
node(NULL, NULL, "ibm,edk2-
> > compat-v1");
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!node)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len =3D secvar_ops->format(b=
uf, 32);
>=20
> "powerpc/secvar: Handle format string in the consumer"=C2=A0 defines
> opal_secvar_format() for the object format "ibm,secvar-backend".=C2=A0
> Here
> shouldn't it being returning the format for "ibm,edk2-compat-v1"?

opal_secvar_format() doesn't return "ibm,secvar-backend", it searches
for the device tree node named "ibm,secvar-backend", then reads and
returns the contents of the property "format" under that node.

The expected content of the format property is "ibm,edk2-compat-v1".

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
