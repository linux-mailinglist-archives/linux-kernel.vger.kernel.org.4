Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EE074AF81
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjGGLIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjGGLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:08:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890891FEC;
        Fri,  7 Jul 2023 04:08:29 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367B2baS014186;
        Fri, 7 Jul 2023 11:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EpRAyCO+/Pk6iS660rd4amRtT5eCYg13goVm7Mo2YQo=;
 b=Z2PLjzy0G6o9nlrt3Bedgr5Yr/DY9M2bLwH1A7TWQUYj8XceYWz/JQObc8cjHlQ1v5xf
 ly4N2kfWPZjHitiiISOrsUNOJPPL8rqJjRBeJ2AcvIeoNmcQzq1+JuJg0kwZaR0FU33v
 bZFMpXhe9kn2GX1EtE9HGOS7oUABG/90/GW+nUeNVeKcVJeLteOAzE+DdRN4x/dOQMlh
 39oWLNSfkqzhKXJx7DcbK+0+r7lW3GZG4V7HaB8LWfgqxp0ffjgtszsDDXNpDIn6mUwM
 Dovo+yIm/yvbzCBos3JWOk0br2VBnFa/+p5QodvtnOFdQqdgjwTGpnbbiZE6WJa557X5 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rphg204kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 11:08:27 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367B2noU014621;
        Fri, 7 Jul 2023 11:08:27 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rphg204hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 11:08:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3676glVl002157;
        Fri, 7 Jul 2023 11:08:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde3y1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 11:08:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367B8Lqw22872678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 11:08:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15BC420040;
        Fri,  7 Jul 2023 11:08:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAAA720043;
        Fri,  7 Jul 2023 11:08:19 +0000 (GMT)
Received: from [9.171.85.13] (unknown [9.171.85.13])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 11:08:19 +0000 (GMT)
Message-ID: <bbe4755e3d48216abc3ba3f69de65fae71140ed6.camel@linux.ibm.com>
Subject: Re: [PATCH net v2 1/3] s390/ism: Fix locking for forwarding of IRQs
 and events to clients
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Jul 2023 13:08:19 +0200
In-Reply-To: <20230707104359.3324039-2-schnelle@linux.ibm.com>
References: <20230707104359.3324039-1-schnelle@linux.ibm.com>
         <20230707104359.3324039-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6yeKUNSurNLmTJfZNPfWvRpBMbmbFGL3
X-Proofpoint-GUID: CkC9CItBgXrDNoe-JubZFDYbv_FYElhc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_06,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=444 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 12:43 +0200, Niklas Schnelle wrote:
> The clients array references all registered clients and is protected by
> the clients_lock. Besides its use as general list of clients the clients
> array is accessed in ism_handle_irq() to forward ISM device events to
> clients.
>=20
> While the clients_lock is taken in the IRQ handler when calling
> handle_event() it is however incorrectly not held during the
> client->handle_irq() call and for the preceding clients[] access leaving
> it unprotected against concurrent client (un-)registration.
>=20
> Furthermore the accesses to ism->sba_client_arr[] in ism_register_dmb()
> and ism_unregister_dmb() are not protected by any lock. This is
> especially problematic as the client ID from the ism->sba_client_arr[]
> is not checked against NO_CLIENT and neither is the client pointer
> checked.
>=20
> Instead of expanding the use of the clients_lock further add a separate
> array in struct ism_dev which references clients subscribed to the
> device's events and IRQs. This array is protected by ism->lock which is
> already taken in ism_handle_irq() and can be taken outside the IRQ
> handler when adding/removing subscribers or the accessing
> ism->sba_client_arr[]. This also means that the clients_lock is no
> longer taken in IRQ context.
>=20
> Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

Sorry for the mess. My get_maintainers.pl to-cmd setup in git send-
email stumbled over the cover letter and so the cover letter was not
sent to the right people/lists messing up the "in-reply-to" references.
So I had to resend it.

Thanks
Niklas
