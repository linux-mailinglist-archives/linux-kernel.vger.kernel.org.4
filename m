Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49956C4DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjCVOjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjCVOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:26 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C663A867
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fx+PO4hBhBKU10bQKuw8QWJPV//spgoyYIQQxiQkFxiC2UiJtGkN0dYvYpk4GStihI5VTDB+DsJD60yb7eAv0i/qIj7iun1ssFI3PcEMbBQ21FSzEb/sStB8uk5RLiZSyL3jGYP7uh7dMyiEzQY0G64t58lCEEohNJUMcHPODkhdieWKqtC4fsGgWu6zYLE8yJ86MF262sr4P8TQUMDE7sSuK41HO+DTpW2nwyzS6KreuhXodJ2jPXIjnPrVE2X134B/2UNjLD27niv2BLuSrNJHkfQZmpKJhH4yXkCEqSe7lCM8vQcxr+8DcbbPAkXdUU/BjOC6qM+k9zp3zsQmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh33j60LZNZft/Yb3K7Ya+eBCjn8RconzzEEnLttb9s=;
 b=U/M3pYSNJ2H5NMi5Yx5e40YXxXdStH27cl2ZvDnG/ObsRq2tSqea883GjkRcCPPfI6CCZT/D5zpg2g/owYerKY0gRz8o8MhqBA78w/vtb5qpbdmNcReiX7oxhGGXinjzrDJ+HtXo5vnPru3VZQaAbREn1VgvgsbPeFglMY7KK//LjDBoDgHQmWekOwHroYVWYVOUR9DG/R821v5hIfpH4Y5zf5G4HPcryORe/ItNLV6/ZN1P1bAgNZGxZdRbJK8g7GzP91kOdjnU4aPPcIYqLDOiazGTWlOPmx+bOprzBsnT8dtHBw2NnYSd+cfzr3NYiw1LWelmry+F2MrFpP4qzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh33j60LZNZft/Yb3K7Ya+eBCjn8RconzzEEnLttb9s=;
 b=VQkzI45USlVA9Ls9cFv7UzMLmpowzd0RnnJHcY5SRQSyjTiW8AN63majytGadcSezcuco6ESEtdbEU4u03i6+CAdPvFAzjM6chagX8fh0yAQQt34bX3xapZgImL7pT8ldmO5Mf9OBH0ouW67Em3RE2Q56e8aU5/OGCseIrP3HkU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3738.namprd21.prod.outlook.com (2603:10b6:208:3e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.0; Wed, 22 Mar
 2023 14:39:16 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6254.004; Wed, 22 Mar 2023
 14:39:15 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] swiotlb: Track and report io_tlb_used high water mark
 in debugfs
Thread-Topic: [PATCH 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Index: AQHZSsqBvZ0VzOjXp060Wl3Ny5iqr68G+oEAgAADtnA=
Date:   Wed, 22 Mar 2023 14:39:15 +0000
Message-ID: <BYAPR21MB16887D69A1E3E2622E32224CD7869@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1677516106-85971-1-git-send-email-mikelley@microsoft.com>
 <SA1PR21MB1335022D514B2232953D43A9BF869@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB1335022D514B2232953D43A9BF869@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ac2d93b9-de41-41a3-a4f7-46e48cd0a71f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-22T08:58:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3738:EE_
x-ms-office365-filtering-correlation-id: 33d176a7-216c-4589-98f4-08db2ae3361f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BmyhOnydsk0wH3eoVuhY7kVRJu6lNQnWLeVnqj1Noa4Kvna/yuqDZcN4iqeUqNjYefV4xAVkUtv7HqJhxjYW6xqwShooJVfJ7kRwwVUF9b4p3ddyl+3nXsNY1zM/igiIS11ZAxVSAk3S1kh5D9l82A6E3sGmKD8+YiwRPCGGncHxtOpNmV+6c7tb50Q6Z+LU2GoOosNN3rYUHGM1xUTyYAlishTDJuZnb4BUISuz4STZlvd8GBfOsfYtswhUIhbX3AjgAnclIgj27elgUQUt3W8fHLf31IcnqAw/3VyF3gOvNB9j0g0L6qlUpVxqI1BZQ5Opu6kUtBq5yNS4k+EYCf9D6lH249TVfnW8Zxf0lQDskKga0eBqfic3XKZxsbN3SKfmRQizcJZqzTvkpadBGSfH8XxAC2ndXg0UQ0GqHce1nrjjjcZy73EIi9EbVQVrbb7qglyB9gWKr+0ow5O7J55bXmGWyhS5yZX8ociWI8aq1AxCnd8Hxg1kJgBEbVpnUVLPaC7SAyRkoACOiImXQn5YEB2bCkLnQ8UbG95+eTX+6e3/Yo8iIfXmLpW0QVfqBEqy/k/K5aIZN1Wuqw4kLRSqMWH0ItWrLGCmsfLwE1oET/mY++I6UDhrc88fecoJGxGl/83nNtNeuINARjxazf02kKYPLg2J5t4VOGvkbFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199018)(82960400001)(86362001)(82950400001)(71200400001)(7696005)(38100700002)(38070700005)(2906002)(55016003)(83380400001)(52536014)(8990500004)(9686003)(186003)(26005)(8936002)(6506007)(122000001)(41300700001)(5660300002)(110136005)(478600001)(33656002)(64756008)(10290500003)(66556008)(76116006)(66446008)(66476007)(66946007)(316002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mIcCEVTdSCVJITNGgIhoeosqnL4JTkALLJy9879s/rX1gCxUOoR8Jbf16i5z?=
 =?us-ascii?Q?Adw5HDGwshEouEicomdVTQlXx1NRR22+Ult5UynYlNzfmi98v0dzqA11ghdd?=
 =?us-ascii?Q?VWAIvW7u1ApL0mHX0wWqN1f/v2beckDspMbJfjX05yW8EHftjHTrAhZrEYrb?=
 =?us-ascii?Q?ylUgoFRbEUSnSviRxhec91pFtKXykgK9SZfm9VCRKfCsjiNaVQKxHhZAiY9V?=
 =?us-ascii?Q?3LKZ++jtukrD9dyRumDXwKK54RhL0Fv/9UG4hNVfv1KBZyit63Bes3z9kDao?=
 =?us-ascii?Q?qORxZnsKx3OIFp0gGjxby/YGoc/J+YruI0vxys1cS3OJ/9M1ONx4+Wb5goWu?=
 =?us-ascii?Q?r3wAlJ2SXsvS594kD0R128Sva2VXByo1Q5UglG5M9eXou0pED9gyb/Jycg4y?=
 =?us-ascii?Q?cvw9fF0drWeHW26xWrmNm5UU/7hBGaZZuMmiT5sXICHOVz+U2ZjGZUTo2nPK?=
 =?us-ascii?Q?9poCLlekMY0XD8ZdnWzmi2QBjI6bkssyKwjs0bIa4FKS84oDu9BYcji2qXnZ?=
 =?us-ascii?Q?UPWlbB/a9YgFqlEvOz7cfmoU7Vo1QuZ7aroKOmIAvltCyLLytJsvOnD6+j7/?=
 =?us-ascii?Q?qDsg0qr233Pjhik4kl56ZmZQm/ovu+1djrdiuGwHkM0P84ESV1iCNK43nVwc?=
 =?us-ascii?Q?wgeitMcDlY646aZ4JgASgFcvUgVT5djFyuLMmq1npCa5YClwSxtO29jYNoRw?=
 =?us-ascii?Q?iiBTOKSoFpkjD2Ijm7gTIirfLBS8+dI9VZzM0gTsoXCfTk8YDF2exeArJvQ1?=
 =?us-ascii?Q?LsAYol+8+s6Eh4Up+ksBfiUqXf8LkQcckiKu1lhG7H0Jym6kbIIWlr+O8MUQ?=
 =?us-ascii?Q?uBAuAswAuDnEuQTvx083qqL+GaFnnJGpWWu0ptnMiksrfaGqNBXywV9vtKU7?=
 =?us-ascii?Q?kyFZOmL8xJyF6ZZZqFvctwq3K2izkhcByEmkGDaS/0eSr3uEtvmV70qfON4M?=
 =?us-ascii?Q?jKV4P2t6iCkFmk0ePtQpz2BoyU4BuRhq9oYDgxF4Hx9Mc61mneSBNehbQ1eV?=
 =?us-ascii?Q?cOcBrxV42GPGY+Jxerbu6HvdTCYhHL6609ylFnb1vHBV0IotM37mx3mYXeOM?=
 =?us-ascii?Q?hBCN1xjDPFFZeOqfRH1x9FABkABT6Frsnwmw47+iaKLhHQ6ecKct1N6CQyDo?=
 =?us-ascii?Q?GXto4/k/9imqSvjY62ukiuibqy/1ZZl/IlOvu7pjkHmb2qBB4c33OOrCizM8?=
 =?us-ascii?Q?fy6tpquy2TM64XKZDk1dLEKNHN6XbGxdeLVTa603qthXmU7Q5UcsFSgf0pYe?=
 =?us-ascii?Q?lrMCFnq3ZIT9Se+UUXkFUotgHOohpTryX1zFYk35VopFueU5o6xZU0D1Ecl6?=
 =?us-ascii?Q?Y4sfjEkRhluY79wkNbxYJMKNGWjYhmTvZsQB7149GFKJbsSelWV9nUMr5ZGi?=
 =?us-ascii?Q?vU51wJVK06eroarpL+pItpSFm7KFPfrzEopRSwFawM822NQXbxEkYhrt1bSx?=
 =?us-ascii?Q?pENWDupi0LdqbQ2iWi1J4zw57WyKEHyhdW9IAsGHHiFMlFSVPmpBDcLiskTR?=
 =?us-ascii?Q?qU71XbsSoVGljPQcAKJ5b08eiRF9jecE0PxLO6NDqEXIHhOeQu/3yPdX9Xk5?=
 =?us-ascii?Q?KCJxQx0UaQUvkaaK2yWSjrNzqLJ2QJEewqrIf8EVpkPM/8cByNezYsxHEz6V?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d176a7-216c-4589-98f4-08db2ae3361f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 14:39:15.6848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3o2LsAU4kgpO25geG1mrqg4rAcX64gVIQAVjkDk/yJz1Fn/n8bXoghY4fR9HvaBxPlnbn5VBZM1fil/A0bTcBBXBPqeUWJ3Y2sN7H0hnOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3738
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, March 22, 2023 7:10=
 AM
>=20
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Sent: Monday, February 27, 2023 8:42 AM
> >  ...
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > @@ -76,6 +76,9 @@ struct io_tlb_slot {
> >  static unsigned long default_nslabs =3D IO_TLB_DEFAULT_SIZE >> IO_TLB_=
SHIFT;
> >  static unsigned long default_nareas;
> >
> > +static atomic_long_t total_used =3D ATOMIC_LONG_INIT(0);
> > +static atomic_long_t used_hiwater =3D ATOMIC_LONG_INIT(0);
> >  ...
> > @@ -594,6 +597,7 @@ static int swiotlb_do_find_slots(struct device *dev=
, int
> > area_index,
> >  	unsigned long flags;
> >  	unsigned int slot_base;
> >  	unsigned int slot_index;
> > +	unsigned long old_hiwater, new_used;
> > ...
> > @@ -663,6 +667,14 @@ static int swiotlb_do_find_slots(struct device *de=
v, int
> > area_index,
> >  		area->index =3D 0;
> >  	area->used +=3D nslots;
> >  	spin_unlock_irqrestore(&area->lock, flags);
> > +
> > +	new_used =3D atomic_long_add_return(nslots, &total_used);
> > +	old_hiwater =3D atomic_long_read(&used_hiwater);
> > +	do {
> > +		if (new_used <=3D old_hiwater)
> > +			break;
> > +	} while (!atomic_long_try_cmpxchg(&used_hiwater, &old_hiwater, new_us=
ed));
>=20
> Here 'old_hiwater' is not updated in the loop, which looks suspicious to =
me.

Actually, it *is* updated in the loop.  The atomic_long_try_cmpxchg()
function updates old_hiwater to the current value if the exchange
fails.  The address of old_hiwater is passed as the argument, and
not just the value, so that it can be updated.  See the documentation
for "CMPXCHG vs TRY_CMPXCHG" in Documentation/atomic_t.txt,
which includes a usage example.

> Imagine the below scenario:
>=20
> Initially total_used is 0, used_hiwater is 0.
>=20
> Thread A: total_used =3D 10; new_used =3D 10; old_hiwater =3D 0;
> Thread B: total_used =3D 20; new_used =3D 20; old_hiwater =3D 0;
>=20
> Thread A enters the 'do' loop:
> used_hiwater is 0; old_hiwater is 0, so used_hiwater =3D 10, and we
> exit from the loop.
>=20
> Thread B enters the 'do' loop:
> new_used is 20, old_hiwater *always* is 0, used_hiwater is 10;
> because used_hiwater always doesn't equal old_hiwater,
> atomic_long_try_cmpxchg() always returns 0, and we get stuck in
> the loop forever.
>=20
> I think the line
> +	old_hiwater =3D atomic_long_read(&used_hiwater);
> should be moved into the loop to resolve the issue.
>=20
> > +static int io_tlb_hiwater_set(void *data, u64 val)
> > +{
> > +	/* Write of any value resets high water mark to zero */
>=20
> Maybe it's better if we return -EINVAL when 'val' isn't 0 ?

Yes, that would probably be clearer, to prevent someone from
thinking they could reset the value to something non-zero.  We
*could* allow resetting the value to something non-zero, but I
don't see a real use case for that.

Thanks for the review ....

Michael

>=20
> > +	atomic_long_set(&used_hiwater, 0);
> > +	return 0;
> > +}
