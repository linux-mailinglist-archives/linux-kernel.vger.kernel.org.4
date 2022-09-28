Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942575ED6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiI1Ht7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiI1HtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:49:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2044.outbound.protection.outlook.com [40.107.255.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DD11A83B;
        Wed, 28 Sep 2022 00:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMHYLruveHkYKrXvcAH7wJ0APEmopf0ad0HOs5tHLIH4U/Vpce4CBs7wW43L3r6kMljwEsGev4mk83Co2dVLF8iiwekaE+DFyWYJ0k2qiY0eM2C7Cd6P51Eonwc34nuvIZ1aeKQRYo1/6MyaKchIUu/6R2Z7GPMBHS0yS4UjrWP5SUe1dbfhtEA353NulUiEfg5RKdn4t8PgCpFabxxEIs39CBHBvXUaBIx19p8lU+I+nn3tlYOGALnRgs2+eGf8nsNkKtM/9hTWzd9HslcD+yCEPcbI7etl8Nau+2Gc47wwfi5b5capXoYIe33Erfonnc1tkWo77fMQBPsQ82j4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgK7fo9lfQocok3UyVxgKIyGR4bfjrNX61EvN2Su2yw=;
 b=Cq17VqF1uCdzmHfMktqouvJg8pkdna7HsND7eVMObRBytIKxQfBQl3y+lil0Oj/lcroc6cy5EoKUSP3stG2Q4NqzLloe3d36y8+7hUTin3UePoNAw2InR2HrXkbK2pZnTf9pcQDloQMa9Tq+6RMlAyxJ83gJEJgbCDn7xphqzlNsZYvqGtcuZwNqkG/DkwjZ09PwYbCX6tY7Fnwa6iHB+b73/c9Ui9TiasbvaVX+PsN8WfBGLGPxD2zf2+EdaJukkATwhRBySEoylB0XpcygUWFt4lnriFH7cmcUZ+ExeQfLx54hnAAbE2JzGyRP/s5tqXpc8F36uYwIFi5tuxhF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgK7fo9lfQocok3UyVxgKIyGR4bfjrNX61EvN2Su2yw=;
 b=L82Ws+4OrYoHEniKWKY2qquKUXbnZE+xtnEXqaHXM/3FC0WCRqjpUGZCHvosPsYQ8JQM5WKkPDziqEAYjQH18NBv7mUEag78Ztn9PybV8CTXN9VKG8pwFC7VTW06g0p9TDl+fzAggPKRdj0sYnldG0OAx1fmpFWanTlWNoX2WaoLqFVDk8LNm9nHAmIhQcnoh50c16EM0KWbAcsa5dRvBqMNhpVf1SaYuvyr56Rykc5btfm6FWwA10r2ZS7iMlS4Gwie9NAIlpZyeueo9i/JkVsSHpA0x11+rXjco0rLkor3i8P9w4+Oya63d3N2+eaWQme/jUTLNrUv+wMHQlV2jA==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR0601MB4180.apcprd06.prod.outlook.com (2603:1096:820:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 07:47:25 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 07:47:24 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liming Wu <liming.wu@jaguarmicro.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Thread-Topic: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Thread-Index: AQHYz8icdCaFSgSJiUmKEzpcev4wOq30ZEwAgAAXBsA=
Date:   Wed, 28 Sep 2022 07:47:24 +0000
Message-ID: <TY2PR06MB342434BFB27C24627EEEECBC85549@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20220924034854.323-1-angus.chen@jaguarmicro.com>
 <YzPm4hCx4xBuR3o9@T590>
In-Reply-To: <YzPm4hCx4xBuR3o9@T590>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|KL1PR0601MB4180:EE_
x-ms-office365-filtering-correlation-id: cc6a19fa-90d3-41fe-8cde-08daa125aef8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzAn5ZcBEA4SVv0NjLHtZIZSSkg4oQPenMeu2jyjDaYHzpjdQQPZF67kEQjVkID7Y3/S9DuYCrft9+KtPkKMgDve/01SIOC/w5unQI7ZpzK+bQJxzC/D2BXFqrTm6pDzn5mm9iyaUhkMMbQ6uQ4gQ5TvUUs/xpQ66XxUeoWxTjraDoYE1hlFUKJQZZJNjSFszRlV5VqMoKcwjiQgPur4CZg4WC54fotn01M16sOPVJF92x60WaeYKpfdd9695HaF3OlAjignT6OXiHZQ3Uuxyg5tfC3uJeV9RkSTriafslnfbpqF2yM5mT6LlnJv1zD8pDaNidiLtnHjbqf2VaRgqomSv/qxLvs64sphcmi57AEx99NYBv/VAA1l5Z4hP081+GwSDnyWgwTyYgCbQNyY8yZjMhWWc6OfwWznlisETyiiyWgEswAXQy5qUTWZYZ2q9ON7uKGujOiDkPlzg0kITayPyH9/R3192j+dsJBNJul6Xf7KzU7/4zESOzSnTgGl9oZq1+cA6LHWaFO+v7Id+yBpifUCsWunkqk0ukPBUwqlp4EM/Nx06+f7dxLl4y1BtOWjd8PMgkfLHqiEJvUYDMLeey67GdO8nQb2FvDZDzHz98ugfElUbco7XpL2pZQwQsPAMeGrSog/ekz3uR4sdeDo9G1Ojb3uAWG2LnK68GY1GL48tz7jEK8mjt/UotdiVSzMPLgHjXvp/vrgVUO3gp/XXsWcjWPqTEjQsF5FBuEVadCj6suJ+XCPrX/JM/WLJHynY9lWX6vORh80RQXszg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39840400004)(366004)(396003)(84040400005)(451199015)(478600001)(71200400001)(53546011)(6506007)(7696005)(186003)(316002)(33656002)(6916009)(122000001)(2906002)(52536014)(38070700005)(54906003)(38100700002)(83380400001)(26005)(9686003)(55016003)(41300700001)(8676002)(4326008)(66946007)(66556008)(8936002)(5660300002)(64756008)(30864003)(44832011)(66446008)(66476007)(86362001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JQriqGf5jHP37BQ0o/wdU0itWj2ONkGFTVVS75trfY+Q0CT9ABYSNdgvsaBy?=
 =?us-ascii?Q?wYGLiJ64Vf+mzVb8383yA/1hZ9Chgd+0tgPwfR+SX254cYqRDj+ypqp9Jovv?=
 =?us-ascii?Q?GpiYWExyTrdga3PQTp6c1+Wp3SHwcxCWyU1efxf/jdU1W1b9JTy2PJt/pcLw?=
 =?us-ascii?Q?JThSFi0/jCY+NMHULY4QX5RsE/Q6fmE5S1CNzJNkG7Zm+JX6Mh/N5xO4pvrO?=
 =?us-ascii?Q?WcvCMgL6u1U16axIaNFP5afCBXNOsmx7thE2N+oEPBHb4+OC9uQgnw0BT8ZG?=
 =?us-ascii?Q?bweIGYP19kO2L2IECxkhiGo8qYlQXO1fd522lSigBp0M+OQ66efLxs/w+Zdb?=
 =?us-ascii?Q?eynH4ZtIF/WUN5WPSP6v9DbrERBEV7c/XEzzMTxKPF5ekKlOzz3gRSL+p1uX?=
 =?us-ascii?Q?0ksukqpkTVtCB6ODmqwcA5YrUDyx7mkHkDs+IzM9MPFrZPtenuP/dRCISPmC?=
 =?us-ascii?Q?Nj3R7Bz9zo9MjrBThjCfT8RVYP/jEi0yFjp+dDInfr3SZRFLqUj8zLz7+rE1?=
 =?us-ascii?Q?P2GIzTV9mYvrTCq2N32yRznwX/XfgrSFPaNmZr2Am+CA3wRB1bwH3SSlUVBt?=
 =?us-ascii?Q?95mOgmm4eoiOL35BuDuJU1gQmCc/k7mqAtLl4WvLc3lViF9baqO4VoqwqiE5?=
 =?us-ascii?Q?NeNkhuIHmkCK0buTlpDqkUmBYAZZCBxh8ewpVHSYlXM3np1DDDdS17PdqOOI?=
 =?us-ascii?Q?ji5XBCDOlIZsszOyHeeFUQU5Mh6kH3IwB+GYfvgE9/jyeUrdsXy1yaV11/VB?=
 =?us-ascii?Q?iLaBSRD6XftQTsDgzwh/iTrZPPjmUF8eUmV7UAR2IgJUnKAzLF4Z9LgNDeJ8?=
 =?us-ascii?Q?SUg86TFBy2QVIZO87gVw+RFELfnJfULFpihYwEBDi7G7QCm2s5AhsHl9qUUp?=
 =?us-ascii?Q?gTVEkblYjBjYnCoyGLq5Pf9s7ks8tnck/vFHb2SwmrX+l9MoRZRZUMyy/CFH?=
 =?us-ascii?Q?314BDROd/upwNUJhQJT8WaN26NI0TlaLjLX2Xj0eSDwOfr4wX8mZe2iCjblW?=
 =?us-ascii?Q?GJH6GIe34nrOcpGki2XppJ3ociv02A+7utKF/u+qVAahmH/e5bgcP54uIf4i?=
 =?us-ascii?Q?UXSx9quR5OAPA33vVnhq4409eZNWpvPTZmgEv7AQGW8QdbYtWFXW4K7PS4cz?=
 =?us-ascii?Q?Z5LXWYfPC4GFMwNgiP0SGDk6racIAO53LrU2pFjlr79sZyjQW+tPfUj5WqbV?=
 =?us-ascii?Q?haA9QI4UaItynoO/gej5595aaa7JWeve3g7oN9AulyvQFGCd6QdSLVVR0R/5?=
 =?us-ascii?Q?jbIIO9JJcOxyTtzOxuejans8kuQ2de0yZ2AZ3xuJJF1bmISWBFvTnhAIn6wX?=
 =?us-ascii?Q?2KSMjL0y/JTvwF7G0VnjxTjs6+OGLdxxx2GgTEF5RuFl2uRbP6Zb/9xg9naS?=
 =?us-ascii?Q?/+D9nmzwqYa7Wy2+knivO962W37PBJq1n3vx1QHODmHB6bsa8XbRDiCxyPH8?=
 =?us-ascii?Q?V63DryYe+owTQqtzkaDSaU6Bq/HT4u1vd4dFt5Ix6EjwOFO86eT0MALmUrd8?=
 =?us-ascii?Q?atfQTItG+0+l7SVpGr/0bW1lgrNLlOJQFeQowsGWwoew9W9dqYgYBj2EpIhd?=
 =?us-ascii?Q?QUCbWWN0vGA+GCSu9M+Co5btEBwbV0s1arO8zaTTykFXXcCoBXJjo9Jgj1tb?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6a19fa-90d3-41fe-8cde-08daa125aef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 07:47:24.7576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1tGLA4awOosSLdDQ5jMURIio58h6UA3sFm0V6H+e0Ip9S/tVAzpaIfp6uy0uIGBxPYGznEtM+NxczWcUu6r6ee+y9XTDPG44CY9gai6DkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ming Lei <ming.lei@redhat.com>
> Sent: Wednesday, September 28, 2022 2:17 PM
> To: Angus Chen <angus.chen@jaguarmicro.com>
> Cc: jasowang@redhat.com; mst@redhat.com; pbonzini@redhat.com;
> axboe@kernel.dk; virtualization@lists.linux-foundation.org;
> linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; Liming Wu
> <liming.wu@jaguarmicro.com>; Thomas Gleixner <tglx@linutronix.de>
> Subject: Re: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED =
in
> init_rq
>=20
> On Sat, Sep 24, 2022 at 11:48:54AM +0800, Angus Chen wrote:
> > The background is that we use dpu in cloud computing,the arch is x86,80
> > cores.We will have a lots of virtio devices,like 512 or more.
> > When we probe about 200 virtio_blk devices,it will fail and
> > the stack is print as follows:
> >
> > [25338.485128] virtio-pci 0000:b3:00.0: virtio_pci: leaving for legacy =
driver
> > [25338.496174] genirq: Flags mismatch irq 0. 00000080 (virtio418) vs.
> 00015a00 (timer)
> > [25338.503822] CPU: 20 PID: 5431 Comm: kworker/20:0 Kdump: loaded
> Tainted: G           OE    --------- -  - 4.18.0-305.30.1.el8.x86_64
> > [25338.516403] Hardware name: Inspur NF5280M5/YZMB-00882-10E, BIOS
> 4.1.21 08/25/2021
> > [25338.523881] Workqueue: events work_for_cpu_fn
> > [25338.528235] Call Trace:
> > [25338.530687]  dump_stack+0x5c/0x80
> > [25338.534000]  __setup_irq.cold.53+0x7c/0xd3
> > [25338.538098]  request_threaded_irq+0xf5/0x160
> > [25338.542371]  vp_find_vqs+0xc7/0x190
> > [25338.545866]  init_vq+0x17c/0x2e0 [virtio_blk]
> > [25338.550223]  ? ncpus_cmp_func+0x10/0x10
> > [25338.554061]  virtblk_probe+0xe6/0x8a0 [virtio_blk]
> > [25338.558846]  virtio_dev_probe+0x158/0x1f0
> > [25338.562861]  really_probe+0x255/0x4a0
> > [25338.566524]  ? __driver_attach_async_helper+0x90/0x90
> > [25338.571567]  driver_probe_device+0x49/0xc0
> > [25338.575660]  bus_for_each_drv+0x79/0xc0
> > [25338.579499]  __device_attach+0xdc/0x160
> > [25338.583337]  bus_probe_device+0x9d/0xb0
> > [25338.587167]  device_add+0x418/0x780
> > [25338.590654]  register_virtio_device+0x9e/0xe0
> > [25338.595011]  virtio_pci_probe+0xb3/0x140
> > [25338.598941]  local_pci_probe+0x41/0x90
> > [25338.602689]  work_for_cpu_fn+0x16/0x20
> > [25338.606443]  process_one_work+0x1a7/0x360
> > [25338.610456]  ? create_worker+0x1a0/0x1a0
> > [25338.614381]  worker_thread+0x1cf/0x390
> > [25338.618132]  ? create_worker+0x1a0/0x1a0
> > [25338.622051]  kthread+0x116/0x130
> > [25338.625283]  ? kthread_flush_work_fn+0x10/0x10
> > [25338.629731]  ret_from_fork+0x1f/0x40
> > [25338.633395] virtio_blk: probe of virtio418 failed with error -16
> >
> > After I did some work of this stack,took stap and crash to get more
> > information,I found that the auto irq_affinity affect this.
> > When "vp_find_vqs" call "vp_find_vqs_msix" failed,it will be go back
> > to call vp_find_vqs_msix again with ctx be false, and when it failed ag=
ain,
> > we will call vp_find_vqs_intx,if the vp_dev->pci_dev->irq is zero,
> > we will get a backtrace like above.
> >
> > The log :
> > "genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer=
)"
> > was print because of the irq 0 is used by timer exclusive,and when
> > vp_find_vqs called vp_find_vqs_msix and return false twice,then it will
> > call vp_find_vqs_intx for the last try.
> > Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
> > flag IRQF_SHARED.
> >
> > without config CONFIG_GENERIC_IRQ_DEBUGFS,
> > I found that we called vp_find_vqs_msix failed twice because of
> > the irq resource was exhausted.
> >
> > crash> irq_domain.name,parent 0xffff9bff87d4dec0
> >   name =3D 0xffff9bff87c1fd60 "INTEL-IR-MSI-1-2"
> >   parent =3D 0xffff9bff87400000
> > crash> irq_domain.name,parent 0xffff9bff87400000
> >   name =3D 0xffff9bff87c24300 "INTEL-IR-1"
> >   parent =3D 0xffff9bff87c6c900
> > crash> irq_domain.name,parent 0xffff9bff87c6c900
> >   name =3D 0xffff9bff87c3ecd0 "VECTOR"
> >   parent =3D 0x0----------------------the highest level
> >
> > and stap irq_matrix_alloc_managed get return value -ENOSPC.
> >
> > When no virtio_blk device probe,the vctor_matrix is:
> > crash>  p *vector_matrix
> > $1 =3D {
> >   matrix_bits =3D 256,
> >   alloc_start =3D 32,
> >   alloc_end =3D 236,
> >   alloc_size =3D 204,
> >   global_available =3D 15593,
> >   global_reserved =3D 149,
> >   systembits_inalloc =3D 3,
> >   total_allocated =3D 409,
> >   online_maps =3D 80,
> >   maps =3D 0x2ff20,
> >   scratch_map =3D {1161063342014463, 0, 1, 18446726481523507200,
> >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
> >   system_map =3D {1125904739729407, 0, 1, 18446726481523507200,
> >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
> > }
> >
> > When the dump stack occur,the vector_matrix of system is exhausted.
> > crash> p *vector_matrix
> > $82 =3D {
> >   matrix_bits =3D 256,
> >   alloc_start =3D 32,
> >   alloc_end =3D 236,
> >   alloc_size =3D 204,
> >   global_available =3D 0,//caq:irq left
> >   global_reserved =3D 151,
> >   systembits_inalloc =3D 3,
> >   total_allocated =3D 1922,//caq:irq that allocated
> >   online_maps =3D 80,
> >   maps =3D 0x2ff20,
> >   scratch_map =3D {18446744069952503807, 18446744073709551615,
> >  18446744073709551615, 18446735277616529407, 0, 0, 0, 0, 0,
> >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
> >   system_map =3D {1125904739729407, 0, 1, 18446726481523507200,
> >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
> > }
> >
> > And we tested the virtio_blk device which request irq success,
> > we found that in a system with 80 cores and two numa ,one
> > virtio_blk device with just two data queues consume 81 irqs capacity,
> > Although it just only three irqs in /proc/interrupt,80 irqs capacity
> > is effected by function "irq_build_affinity_masks" with 2*40.
>=20
> irq_build_affinity_masks() is just for spreading CPUs among the two
> vectors, nothing to do with your issue.
Yes, What I mean is that 80 irqs capacity composed of 2*40 is effected by i=
rq_build_affinity_masks.
>=20
> Your issue should be related with irq matrix code, which manages effectiv=
e
> cpu allocation for irq vector, nothing to do with irq_build_affinity_mask=
s().
Yes,I read the matrix code,and don't know fix it better.
>=20
> Cc Thomas.
>=20
> >
> > before one virtio_blk device hotplug out:
> > crash> p *vector_matrix
> > $2 =3D {
> >   matrix_bits =3D 256,
> >   alloc_start =3D 32,
> >   alloc_end =3D 236,
> >   alloc_size =3D 204,
> >   global_available =3D 15215,
> >   global_reserved =3D 150,
> >   systembits_inalloc =3D 3,
> >   total_allocated =3D 553,
> >   online_maps =3D 80,
> >   maps =3D 0x2ff20,
> >   scratch_map =3D {1179746449752063, 0, 1, 18446726481523507200, 0, 0, =
0,
> >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> >  0, 0, 0, 0, 0},
> >   system_map =3D {1125904739729407, 0, 1, 18446726481523507200, 0, 0, 0=
,
> >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> >  0, 0, 0, 0, 0}
> > }
> >
> > after one virtio_blk device hotplug out:
> > crash> p *vector_matrix
> > $3 =3D {
> >   matrix_bits =3D 256,
> >   alloc_start =3D 32,
> >   alloc_end =3D 236,
> >   alloc_size =3D 204,
> >   global_available =3D 15296,---it increase 81,include 1 config irq.
> >   global_reserved =3D 150,
> >   systembits_inalloc =3D 3,
> >   total_allocated =3D 550,------it just decrease 3.
> >   online_maps =3D 80,
> >   maps =3D 0x2ff20,
> >   scratch_map =3D {481036337152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> >  0, 0, 0, 0},
> >   system_map =3D {1125904739729407, 0, 1, 18446726481523507200, 0, 0, 0=
,
> >  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> >  0, 0, 0, 0, 0}
> > }
> >
> > We test the new kernel also,it occur the same result.
> > [Fri Sep 23 04:51:42 2022] genirq: Flags mismatch irq 0. 00000080 (virt=
io608)
> vs. 00015a00 (timer)
> > [Fri Sep 23 04:51:42 2022] CPU: 0 PID: 5749 Comm: kworker/0:0 Kdump:
> loaded Tainted: G        W  OE      6.0.0-rc6+ #5
> > [Fri Sep 23 04:51:42 2022] Hardware name: Inspur
> NF5280M5/YZMB-00882-10E, BIOS 4.1.19 06/16/2021
> > [Fri Sep 23 04:51:42 2022] Workqueue: events work_for_cpu_fn
> > [Fri Sep 23 04:51:42 2022] Call Trace:
> > [Fri Sep 23 04:51:42 2022]  <TASK>
> > [Fri Sep 23 04:51:42 2022]  dump_stack_lvl+0x33/0x46
> > [Fri Sep 23 04:51:42 2022]  __setup_irq+0x705/0x770
> > [Fri Sep 23 04:51:42 2022]  request_threaded_irq+0x109/0x170
> > [Fri Sep 23 04:51:42 2022]  vp_find_vqs+0xc4/0x190
> > [Fri Sep 23 04:51:42 2022]  init_vqs+0x348/0x580 [virtio_net]
> > [Fri Sep 23 04:51:42 2022]  virtnet_probe+0x54d/0xa80 [virtio_net]
> > [Fri Sep 23 04:51:42 2022]  virtio_dev_probe+0x19c/0x240
> > [Fri Sep 23 04:51:42 2022]  really_probe+0x106/0x3e0
> > [Fri Sep 23 04:51:42 2022]  ? pm_runtime_barrier+0x4f/0xa0
> > [Fri Sep 23 04:51:42 2022]  __driver_probe_device+0x79/0x170
> > [Fri Sep 23 04:51:42 2022]  driver_probe_device+0x1f/0xa0
> > [Fri Sep 23 04:51:42 2022]  __device_attach_driver+0x85/0x110
> > [Fri Sep 23 04:51:42 2022]  ? driver_allows_async_probing+0x60/0x60
> > [Fri Sep 23 04:51:42 2022]  ? driver_allows_async_probing+0x60/0x60
> > [Fri Sep 23 04:51:42 2022]  bus_for_each_drv+0x67/0xb0
> > [Fri Sep 23 04:51:42 2022]  __device_attach+0xe9/0x1b0
> > [Fri Sep 23 04:51:42 2022]  bus_probe_device+0x87/0xa0
> > [Fri Sep 23 04:51:42 2022]  device_add+0x59f/0x950
> > [Fri Sep 23 04:51:42 2022]  ? dev_set_name+0x4e/0x70
> > [Fri Sep 23 04:51:42 2022]  register_virtio_device+0xac/0xf0
> > [Fri Sep 23 04:51:42 2022]  virtio_pci_probe+0x101/0x170
> > [Fri Sep 23 04:51:42 2022]  local_pci_probe+0x42/0xa0
> > [Fri Sep 23 04:51:42 2022]  work_for_cpu_fn+0x13/0x20
> > [Fri Sep 23 04:51:42 2022]  process_one_work+0x1c2/0x3d0
> > [Fri Sep 23 04:51:42 2022]  ? process_one_work+0x3d0/0x3d0
> > [Fri Sep 23 04:51:42 2022]  worker_thread+0x1b9/0x360
> > [Fri Sep 23 04:51:42 2022]  ? process_one_work+0x3d0/0x3d0
> > [Fri Sep 23 04:51:42 2022]  kthread+0xe6/0x110
> > [Fri Sep 23 04:51:42 2022]  ? kthread_complete_and_exit+0x20/0x20
> > [Fri Sep 23 04:51:42 2022]  ret_from_fork+0x1f/0x30
> > [Fri Sep 23 04:51:42 2022]  </TASK>
> > [Fri Sep 23 04:51:43 2022] virtio_net: probe of virtio608 failed with e=
rror -16
> >
> > Fixes: ad71473d9c43 ("virtio_blk: use virtio IRQ affinity")
> > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > Tested-by: Liming Wu <liming.wu@jaguarmicro.com>
> > ---
> >  drivers/block/virtio_blk.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index a8bcf3f664af..075de30a9bb4 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -513,7 +513,6 @@ static int init_vq(struct virtio_blk *vblk)
> >  	struct virtqueue **vqs;
> >  	unsigned short num_vqs;
> >  	struct virtio_device *vdev =3D vblk->vdev;
> > -	struct irq_affinity desc =3D { 0, };
> >
> >  	err =3D virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> >  				   struct virtio_blk_config, num_queues,
> > @@ -548,7 +547,7 @@ static int init_vq(struct virtio_blk *vblk)
> >  	}
> >
> >  	/* Discover virtqueues and write information to configuration.  */
> > -	err =3D virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &desc);
> > +	err =3D virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, NULL);
> >  	if (err)
> >  		goto out;
>=20
> This patch isn't good since blk-mq's queue mapping depends on managed
> irq affinity, and this way breaks queue mapping.
Agree ,can you help me with more suggestions?
Thank you.=20
>=20
>=20
> Thanks,
> Ming

