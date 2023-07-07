Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E0274B2C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjGGOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGGOJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:09:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294592724;
        Fri,  7 Jul 2023 07:09:17 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367E5LO0030616;
        Fri, 7 Jul 2023 14:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WP+aDYQCMiQoLxOSTdmYncJ2HhDH6cvv4gluci3VNBY=;
 b=P4VC7ea8wugV4R+1oGl0tAgeFnwXNDwXB7q6cz7AcC5xkiFO1JtGNo65LRuISLFqBP9J
 PJFNj6sbyZYeQYUpZUBiBn5pBjRimNTE9iuGxRCBQf7c6Zq9SR94uchg2VFdhjaBWpNo
 jY2PhTzZfml3KYhj/xDw3OUuA9vjnwFX139qigYBe3av7ZxfwnhtrTBRNa+V1iHLgDBN
 mCJCKIL+WTANANvllQZsoYgw/qu0FB0ywSclfCz82MdDEGoPorJ+TRzjqaZPLZN2L36V
 cWVsR2pByG0RLtilHZI4WMT4KT9GnBnpRbnAD1xpTGRvCZ+24fv+OU/rzhDHFUZI3KPs 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpm5h03ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 14:09:05 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367E6tD5004051;
        Fri, 7 Jul 2023 14:09:04 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpm5h03bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 14:09:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3677Rtuf000704;
        Fri, 7 Jul 2023 14:09:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4v1t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 14:09:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367E8x2w18088486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 14:08:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16AAE2004B;
        Fri,  7 Jul 2023 14:08:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8653320040;
        Fri,  7 Jul 2023 14:08:58 +0000 (GMT)
Received: from [9.171.85.13] (unknown [9.171.85.13])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 14:08:58 +0000 (GMT)
Message-ID: <1f6e3432f8626d8f3d2de99e7f2f51c1fdf4e58c.camel@linux.ibm.com>
Subject: Re: [PATCH net v2 1/3] s390/ism: Fix locking for forwarding of IRQs
 and events to clients
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Jul 2023 16:08:58 +0200
In-Reply-To: <8ec43fe6-218c-189f-4a90-73e482a0c5ff@linux.ibm.com>
References: <20230707105622.3332261-1-schnelle@linux.ibm.com>
         <20230707105622.3332261-2-schnelle@linux.ibm.com>
         <8ec43fe6-218c-189f-4a90-73e482a0c5ff@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xWMWUQAhh9Zpub-YQrgtSRWEpABfv7YL
X-Proofpoint-GUID: VUM-j-B8HsF6V94jRfKi7eRS1zEG34ns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307070130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 15:37 +0200, Alexandra Winter wrote:
>=20
> On 07.07.23 12:56, Niklas Schnelle wrote:
> [...]
> > Instead of expanding the use of the clients_lock further add a separate
> > array in struct ism_dev which references clients subscribed to the
> > device's events and IRQs. This array is protected by ism->lock which is
> > already taken in ism_handle_irq() and can be taken outside the IRQ
> > handler when adding/removing subscribers or the accessing
>=20
> 				typo? s/the accessing/accessing the/g
>=20
> > ism->sba_client_arr[]. This also means that the clients_lock is no
> > longer taken in IRQ context.
> >=20
>=20
> [...]
>=20
> > @@ -554,6 +577,7 @@ static void ism_dev_add_work_func(struct work_struc=
t *work)
> >  						 add_work);
> > =20
> >  	client->add(client->tgt_ism);
> > +	ism_setup_forwarding(client, client->tgt_ism);
> >  	atomic_dec(&client->tgt_ism->add_dev_cnt);
> >  	wake_up(&client->tgt_ism->waitq);
> >  }
> > @@ -691,7 +715,11 @@ static void ism_dev_remove_work_func(struct work_s=
truct *work)
> >  {
> >  	struct ism_client *client =3D container_of(work, struct ism_client,
> >  						 remove_work);
> > +	unsigned long flags;
> > =20
> > +	spin_lock_irqsave(&client->tgt_ism->lock, flags);
> > +	client->tgt_ism->subs[client->id] =3D NULL;
> > +	spin_unlock_irqrestore(&client->tgt_ism->lock, flags);
> >  	client->remove(client->tgt_ism);
> >  	atomic_dec(&client->tgt_ism->free_clients_cnt);
> >  	wake_up(&client->tgt_ism->waitq);
>=20
> I am not sure I like the new split. here you fix ism_dev_add_work_func() =
and ism_dev_remove_work_func(),
> that you remove in the next patch. But looks functionally ok to me.
>=20
>=20
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

Thanks for your review. Yeah it's the price we pay for working
intermediate states. I think if you hadn't already invested the time to
look at the conmbined patch it might still be easier to review the
split patches.
