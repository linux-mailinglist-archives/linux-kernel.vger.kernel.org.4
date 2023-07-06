Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A02749B4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjGFMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjGFMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:01:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128381BC9;
        Thu,  6 Jul 2023 05:01:03 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Bkvwv025204;
        Thu, 6 Jul 2023 12:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MgFgLExdzOXDVINyezCyX4yUENhWZqwwJnX9EcPhS+k=;
 b=d3CSNkTMZVngjGCaLvJJPXSAen9vba8RcNfFRRVUAD/pT7TV5QKQ4dVSy6QmtbvEsiqo
 D3F1WdlkIcMI2eeKX7Ql78v5rCvyQFW2hcmj2vi9B7oliTUscB31+d4wGTQz+49hE4mI
 Cec+KlyjO/7iPFh++dBdygNMX1DLG2Dslkn9M0vBiTUTsw7cATLgFpLFP3AH8yPeG+Q4
 HdD/svUhr3V1nKW6KTykfH3UkOwZ0lJ0QIcAGYc4WNFAcHHFYSyTpAmmmKIFqLtlUbjG
 vTdUefIDHQkRdNjCB6Q5ZKi7QbnRa0lfs6hDnK1wBS2LuryQnmKqszhZynICJ3P39jQN 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnw1uga63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 12:01:01 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 366BrYrf013547;
        Thu, 6 Jul 2023 12:01:00 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnw1uga1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 12:00:58 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3660IFFs012401;
        Thu, 6 Jul 2023 12:00:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4ua9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 12:00:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 366C0qA860686700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jul 2023 12:00:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3089D20043;
        Thu,  6 Jul 2023 12:00:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60A1A2004D;
        Thu,  6 Jul 2023 12:00:51 +0000 (GMT)
Received: from [9.171.3.14] (unknown [9.171.3.14])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jul 2023 12:00:51 +0000 (GMT)
Message-ID: <bf41a4c062f2b7f7fb63bdee2c4ef1333c624393.camel@linux.ibm.com>
Subject: Re: [PATCH net] s390/ism: Fix locking for forwarding of IRQs and
 events to clients
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Julian Ruess <julianr@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 14:00:51 +0200
In-Reply-To: <c6835aae95dd18da35795d2231e9326e0d21b60b.camel@redhat.com>
References: <20230705121722.2700998-1-schnelle@linux.ibm.com>
         <c6835aae95dd18da35795d2231e9326e0d21b60b.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tWzEmQdFitVBYpCA-AFhCw9nIldilkBJ
X-Proofpoint-ORIG-GUID: s_wrybLu8I4tGK9XkCtwr6o9M0-244VQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=575 clxscore=1015 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-06 at 12:47 +0200, Paolo Abeni wrote:
> On Wed, 2023-07-05 at 14:17 +0200, Niklas Schnelle wrote:
> > The clients array references all registered clients and is protected by
> > the clients_lock. Besides its use as general list of clients the client=
s
> > array is accessed in ism_handle_irq() to forward IRQs and events to
> > clients. This use in an interrupt handler thus requires all code that
> > takes the clients_lock to be IRQ save.
> >=20
> > This is problematic since the add() and remove() callbacks which are
> > called for all clients when an ISM device is added or removed cannot be
> > called directly while iterating over the clients array and holding the
> > clients_lock since clients need to allocate and/or take mutexes in thes=
e
> > callbacks. To deal with this the calls get pushed to workqueues with
> > additional housekeeping to be able to wait for the completion outside
> > the clients_lock.
> >=20
> > Moreover while the clients_lock is taken in the IRQ handler when callin=
g
> > handle_event() it is incorrectly not held during the
> > client->handle_irq() call and for the preceding clients[] access. This
> > leaves the clients array unprotected. Similarly the accesses to
> > ism->sba_client_arr[] in ism_register_dmb() and ism_unregister_dmb() ar=
e
> > also not protected by any lock. This is especially problematic as the
> > the client ID from the ism->sba_client_arr[] is not checked against
> > NO_CLIENT.
> >=20
> > Instead of expanding the use of the clients_lock further add a separate
> > array in struct ism_dev which references clients subscribed to the
> > device's events and IRQs. This array is protected by ism->lock which is
> > already taken in ism_handle_irq() and can be taken outside the IRQ
> > handler when adding/removing subscribers or the accessing
> > ism->sba_client_arr[].
> >=20
> > With the clients_lock no longer accessed from IRQ context it is turned
> > into a mutex and the add and remove workqueues plus their housekeeping
> > can be removed in favor of simple direct calls.
> >=20
> > Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
> > Tested-by: Julian Ruess <julianr@linux.ibm.com>
> > Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> > Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> > Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > Note: I realize this is a rather large patch. So I'd understand if it's=
 not
> > acceptable as is and needs to be broken up. That said it removes more l=
ines
> > than it adds and the complexity of the resulting code is in my opinion =
reduced.
>=20
> This is indeed unusually large for a -net patch. IMHO it would be
> better split it in 2 separated patches: 1 introducing the ism->lock and
> one turning the clients_lock in a mutex. The series should still target
> -net, but should be more easily reviewable.
>=20
> Thanks,
>=20
> Paolo
>=20

Sounds reasonable. Patch 1 would introduce and use the ism->subs[]
array under the ism->lock and also protect the ism->sba_client_arr[]
under that lock. Patch 2 would then turn clients_lock into a mutex and
remove the workqueues. I think strictly speaking the second one then
isn't a fix but let's see. @Alexandra, Wenjia, Julian I'll drop your R-
bs as its a larger rework but I hope to end up at the same code after
both patches so should be easy to re-revievie for you.

Thanks,
Niklas
