Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F8C661DF5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 05:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjAIEnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 23:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjAIEnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:43:12 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C0DE
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 20:43:11 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30910R3C032597;
        Mon, 9 Jan 2023 04:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JBrQde9rOtZz9fKbYFXFSMenQlvD0s405CZyXKLk6l8=;
 b=IjurN9B8tEs8ogFlR02xY2q4SdXN66noBMv+/lxxAZAQ2tVPj02sZfYBA+7CsLN6cEnc
 nWkafumvDTNSyyZ+JhgHLoomkk0NnJ1poxqN2S2Hl7ua49lHd4BC8pp128pIKG9MEntz
 pF2YKdEStDkbGWDptZiaUOk64SY23hhhyhpc2iTMp+dE/nW2udTh3UuSNCYiKkStGCK1
 9dq34svvpHIbSKaJ1Ly+3toQfDTkqDtJMsaY8ZEIU4QSHjjBzMsRd8JMy4jU/R14UDt5
 H+cS4g4DKBlwWW55E3SIuJsSKeHMUcempeGuUQbl/hfx6RD7BH2Tq4FUs1xg5RDMatDh ng== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3myjdm3u8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 04:42:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 308FkYGW000526;
        Mon, 9 Jan 2023 04:42:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3my0c6jbna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 04:42:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3094gtBj23921178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jan 2023 04:42:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38D4820049;
        Mon,  9 Jan 2023 04:42:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFA5520043;
        Mon,  9 Jan 2023 04:42:54 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jan 2023 04:42:54 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2786E600D2;
        Mon,  9 Jan 2023 15:42:52 +1100 (AEDT)
Message-ID: <bad773e9224ea1ced3ca4068363a35c7fc315d96.camel@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] powerpc/pseries: Implement secvars for dynamic
 secure boot
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        zohar@linux.ibm.com, mpe@ellerman.id.au
Date:   Mon, 09 Jan 2023 15:42:51 +1100
In-Reply-To: <dcd26f6df2fc1c3ef01b39cc418ffd090b830aae.camel@russell.cc>
References: <20221230042014.154483-1-ruscur@russell.cc>
         <20221230042014.154483-8-ruscur@russell.cc>
         <8b1183aa0e84363545a956118c970220670a636d.camel@linux.ibm.com>
         <dcd26f6df2fc1c3ef01b39cc418ffd090b830aae.camel@russell.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CDs-ryFBPcSmqTnq45NNoKmJMkmb_xui
X-Proofpoint-ORIG-GUID: CDs-ryFBPcSmqTnq45NNoKmJMkmb_xui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=808 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-01-06 at 17:49 +1100, Russell Currey wrote:
> >=20
> > > + */
> >=20
> > Inconsistent comment style
>=20
> True, I'm using // for multi-line comments in other places.=C2=A0 I think
> my
> brain decided that this one was too long for that, but I'll make the
> other multi-line comments similarly old-fashioned for consistency.

Sigh, I was trying to encourage you to move into the future...

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
