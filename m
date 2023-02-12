Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D09C693792
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 14:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjBLN1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 08:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBLN1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 08:27:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2961114A;
        Sun, 12 Feb 2023 05:27:30 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CAg2Lh020026;
        Sun, 12 Feb 2023 13:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ge2f+CLxTLaSllPP1w10FqHkZwVFe/vUAIxQlEc3438=;
 b=HojE2cEeJgxmewflO8zaH7VSmyxsIziXh51FGAWzy5iEZTp1Bn7NgLt242uNlHrXmRPw
 lN3hReCWj08io7SNvYxvBLLXD30Cr0TyffLXp5qfSWAwDDHLsAebtM5V+ojgQdb74dPe
 JOgv2FJpQdZ5BeC87DVkb1nUL9hfKvjgtWmWB5tzKreh4uKpVEmWWMTcrGQp+HNyLmYm
 BeELkgAgiPOm//y+9pwFKd8x8hivOTBXnDHn+79t2YyE2hOpT8GZzPFoGr9DqKFScP3Q
 yUNFb3FKt3ZlMMRkNZPE1z6as+UZhizwocFqkJYK4orYURlfGSmModSXNE4eEUQ4tZlZ Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3npxkaj3k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 13:27:15 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31CDKbbb029275;
        Sun, 12 Feb 2023 13:27:14 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3npxkaj3jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 13:27:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31BM3GAl029819;
        Sun, 12 Feb 2023 13:27:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3np29fhjsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Feb 2023 13:27:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31CDR9ww41943544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Feb 2023 13:27:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB68820043;
        Sun, 12 Feb 2023 13:27:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47A4320040;
        Sun, 12 Feb 2023 13:27:09 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 12 Feb 2023 13:27:09 +0000 (GMT)
Received: from [9.43.187.72] (unknown [9.43.187.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 46BF8600BA;
        Mon, 13 Feb 2023 00:26:59 +1100 (AEDT)
Message-ID: <12489e5124f4873c534eb92bcf4b11f510d27855.camel@linux.ibm.com>
Subject: Re: [PATCH v6 21/26] powerpc/pseries: Clarify warning when PLPKS
 password already set
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
Date:   Mon, 13 Feb 2023 00:26:51 +1100
In-Reply-To: <0e5f3dcd-ac0a-902e-f9fb-b2178cd17a99@linux.ibm.com>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
         <20230210080401.345462-22-ajd@linux.ibm.com>
         <0e5f3dcd-ac0a-902e-f9fb-b2178cd17a99@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7fZlMhwgrOUXB6pNWrEtlyWehpw_qZ-8
X-Proofpoint-ORIG-GUID: lfJrqdBAb0Bb8k1o14Jygnu3Rf8wvy_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=925
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302120115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-02-10 at 15:47 -0500, Stefan Berger wrote:
>=20
>=20
> On 2/10/23 03:03, Andrew Donnellan wrote:
> > When the H_PKS_GEN_PASSWORD hcall returns H_IN_USE, operations that
> > require
> > authentication (i.e. anything other than reading a world-readable
> > variable)
> > will not work.
> >=20
> > The current error message doesn't explain this clearly enough.
> > Reword it
> > to emphasise that authenticated operations will fail.
>=20
> typo: -> emphasize

This commit message was written in en_AU. ;)

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
