Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B875ED371
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiI1DZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiI1DZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:25:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2082.outbound.protection.outlook.com [40.107.215.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5157926540;
        Tue, 27 Sep 2022 20:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiEbbAy1B/vVqj/Wg4IlS76JIEIAA7s6Y/ISOTF+Zs/Po+DvKkYpwa0twiwxHmiCVBxzH6KwtQ2C+zYRBqQApz98uPFSCDnj7sb7xwsUscnwZviO1JkLM75OrCaI7uSlt21ls7h8RnLWwTczaPp/rhYRFz0QP3+qT3aLoOhfcSXm03mPgCKGpPIczFDAulOU3Id/GI/abEcJGDRcQ8Ua9RaoPuAu5haIlJ7BNDSfP9vUpYRYVluLkojJCpq+tXATEg3jC2tWDWyFRWK4dgSbaVPlVE1lEjW58IjnnKfzYzEjnYjKEBaTIob62QXGZq1PVHR3CgLX9p2UzorHje5Hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGVzgAA/GI7EeT2Vn3DIUrNsNVkkkEbTNzouF16FQ7E=;
 b=MyaHtzdLWgy9Z0izSS0jLIEsdKyi9/FSR5HUThaDnXr9W28/1n0BDJMLiT8YUGgPHn73qbPdSFF401+dXY4w8MKpqpIB/0shzqYdQsY0a+VxHbYPl59Dv+SACVUtClRL67U6LEdHOOAXakJMoIbby572w+bicA26jP5lUHP1KDykuX7DWU9Igx02xUohzfgzSpSmhCfzEyENnAirAXIUUzkFGHOKBa2zj1hyRzqizgilSv71HLGcUaIUM7/JBk9Q09oIyxG0cnEK2KkolZ74Z5bzQtUVeRmDdbZZo0vLpo+vfSuTrTAe85HyhSot5SBGcZ+h3vM34j8L0TXx+7NA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGVzgAA/GI7EeT2Vn3DIUrNsNVkkkEbTNzouF16FQ7E=;
 b=eRvhnMQ9bJL9KBABunXFivxPMk0TtOo3co9NACeSiS8MzpRnncE4C8PxDF3kJXVP/E/JZjf+QoDBF/wg3dRp4Kar2iTnCAzJ6WrdLP5sx/FtBxMsR+Eu2mh9EAo4LUx9q2yb3oiGR6AzeoeUsFwpPkorHQ7Yyt2HX+Q/VyUb9oiOtWvRtytgiFEXTVmaeicXdp7gySKbGFScZKelb22Xn4nSV97yNch/RddU0NOZiJi4HNe2kX6YPx0VK0ToSMVvzROto4DOchMwWma9HmrRbPEXwnjTzwCwvka5B6U8GqXzYKHugV2fQflgwytnDsm/U9naLGoAYVlD9PKrB2dxNQ==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SEYPR06MB6130.apcprd06.prod.outlook.com (2603:1096:101:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 03:25:13 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 03:25:12 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liming Wu <liming.wu@jaguarmicro.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Thread-Topic: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Thread-Index: AQHYz8icdCaFSgSJiUmKEzpcev4wOq3zxRsAgABvD5A=
Date:   Wed, 28 Sep 2022 03:25:12 +0000
Message-ID: <TY2PR06MB3424C2AD8F7AC77DA83FB4C685549@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20220924034854.323-1-angus.chen@jaguarmicro.com>
 <20220927163723-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220927163723-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|SEYPR06MB6130:EE_
x-ms-office365-filtering-correlation-id: 602266b4-c831-4ec3-35e2-08daa1010de3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYTCjShdPCIvYgAKz+N6JhmGK06qV/JmmGhF51F0Rq9sIGOP8F+p5E6Vw7ldFk67fOqiZbGX+CbOJLYvj9RFSbfgykTIsjPPeLFC7OrEqc66W5MA5c8ThFR+OE2s/3eB4DpSOCEWXHFvQsaB7FIV2Fh6a51rKnpjA2oN7sJDwXfbg8NBvt5HszY4vs0Pw/d82IIdEqNLn9gq8YaWHdHWojfUJtArTv7mS0K5+OQCxxEH78Fgj0Mwiz7UuZVkwKI5BtkC0/ZirbXx15ESdV27U8bsKKhyLRpBx4VxfH/0rebrUBn0usCed6yc7KUO0yhXhQIeysAi4UAyVYuiZOwHa1b4vQtPr1m9h5Xw66UZzTbpDs4OCc3FQKzGzcgnoDsOkpit5vABn+Taemb4zWuAyEsvRXSzCBdW0KWWB2aEm2f6VcqYtMQP8LjyanyLzaEnGIF+cWaXJ43nzgJNI/YG8nTge2H+mUO3blsWoNZQ87uV4ZcIoQi4XT7lJ6UwgScd8+Awp1nPyh87KeBkZnU7o7S+kKEPiUAcQ1IEznmZojNnKB3PxiuyjeuGEAjGBnvdCjsbDCNsWjRWmUJR+PYBUgtgMaiUGxk5X9NJMA1y+O96sXxRvqQ5E2rQ/YehI14CsIJnZaKsUxb/a+9XjF9xet90s+FbJwho3TtgpACn+2VOWeDknssDhBX30Iy8x9ai6Ie+7BlOQQJIaJcvelOYFjgI48oLsIgXLqyMNucLIkInKM8hFyJD/vq86rwiwU6i0be8pwq5ebg/+ivGJH/Jqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39840400004)(376002)(346002)(451199015)(52536014)(83380400001)(38070700005)(86362001)(66446008)(122000001)(38100700002)(30864003)(8936002)(186003)(44832011)(4326008)(2906002)(76116006)(66556008)(5660300002)(41300700001)(64756008)(6916009)(7696005)(55016003)(66946007)(54906003)(71200400001)(8676002)(478600001)(6506007)(53546011)(26005)(66476007)(9686003)(316002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?66nHXNUgwlIZC8DgvrYCa1X6mUCWI3AP+tX0kDFRtab6K8KhvMBtOwYtc7Nb?=
 =?us-ascii?Q?xiYRemurymD8bC51dp/kI6mdlDrbALvAw6QNhMjyZTqZlxZV6srJV7BHoOO2?=
 =?us-ascii?Q?9jEUnxAa2pmdpoitvOUD64LGEqm2RFumTG7GNpG0x83xlzESMXHCW329S1Zl?=
 =?us-ascii?Q?HdWx9ZCVNzFm6npR3/azxVJ8uu8HYvkjLvBYR2Smr3z1KZ4iZtcKXQjh6pF2?=
 =?us-ascii?Q?Ag+vSWQiE7NzpEQFXIN1nDVRcRR8AT4Oj8l73PgR5Ky9FIstK5qwI6Ajr/2l?=
 =?us-ascii?Q?rCpeMH0ppNhZgnGgE91mzEdIMEFOtBA0HCIUsvCa5d69ewe4mzhBDdny8Yp9?=
 =?us-ascii?Q?YU+4FFwLKyH4OUqUDvCmzEthJjkxCjYqG+9IF4sBZfpOi9dladb2ugL1WIA3?=
 =?us-ascii?Q?3/0gGRn69to0J3lHjuqEOwP8uBeCFDApPZ7mNWnmnP36cRymB0YM6VOdg+FP?=
 =?us-ascii?Q?T5QWu3keyQNZazFNUE44whLS39BsA4FwJwEKfHTMU3HjhkCLcaFvRO2ZTnEW?=
 =?us-ascii?Q?CuVqkmSAghPDJiwuR4Kl2bK4bruyuCaPKlvZb90x6efaB/bi/Qs6pTfZQq76?=
 =?us-ascii?Q?9vCUdETpLq4x8F7RhkVANkREC2gdOz0TGNFxl89HJ20BlV/O2ZzBZ57BkUDE?=
 =?us-ascii?Q?VkZV+VpPL+vFTXOZlilKrVwKeoj1wryqBBo1eEJzNZAhwVKE5XHxK80IkGyj?=
 =?us-ascii?Q?kt7X+CnoYTj+XZQWfPDBxLraRQrCAT9EMFKys0ioqudPOve5HkeOJMlzL1tB?=
 =?us-ascii?Q?5C9vxIiRoNSzgeMJ7rTV9MdJxm+CvGSORvpBmKk6zN3BVLRLw1hHAezx0iem?=
 =?us-ascii?Q?L5j+50OWejn1Q5117W9q91v1jT/GfFggX+75YitdSrXf5vY5t3i2Iv/e2I0s?=
 =?us-ascii?Q?XI1QT9HEGhScVealU2+G1vKB7RwZRvIFQkg9xhOxDYqt6pRE1vjPVGOvbKEc?=
 =?us-ascii?Q?pT/jUWW8TlPMn29i5Os+OVBzQe1SVys2jOb07YbVWbh4DDkcMitJUk9n7bFO?=
 =?us-ascii?Q?mm+/6gzCrko3nr39usAVyHqOp2YUaeREzcfExNs5J8LbDwQknCUvpz7N68GH?=
 =?us-ascii?Q?ZS/4BTwiZG2mO69jOmUUGHWgtD6dJ0gJR78VhWk49U9y8sjaj4U6QRUGrYDg?=
 =?us-ascii?Q?C4R33eF/8+o4ryyo6/GcDNSEmenetsDAWFRMfNNyRWSQN0lBH6P//h2ADJJg?=
 =?us-ascii?Q?ZzCh2SYN3PE8pr1pAb15Z33/WHDU5rKNmJuSFcWn6ms8Tms35pVtMjpTsJJ0?=
 =?us-ascii?Q?MBGdBRiUp8K2zjsLTT2ghigxrfM7HQoAsVhOD4wWKvV2RDD7bdsEmsA9IxWJ?=
 =?us-ascii?Q?sA2z06xjbU7vSKKJUbu0ivGYqtLp9QF77O+1y5eINwOb6mi3Kpp/frhxlkVa?=
 =?us-ascii?Q?59hULgAUXPLcVCMQkwWeYAL0p3QT3MkJUOIOSChnf1yBcBzN90fnsjsJS2L6?=
 =?us-ascii?Q?/kpNK+WtDlCdi1LvETv6dWWcuVd4U75ihLxQN8xP60i0ZL0+MRUk2Qbyn0hX?=
 =?us-ascii?Q?hBolDR3zedTqXaGNu91e0U4GEP10ryzU7VLrJYqjLNG8iPAVr/VZHKgLWQTW?=
 =?us-ascii?Q?0UznohKMxIXPxo8V4lsgHiPBwioAYSqMTT47bHpZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602266b4-c831-4ec3-35e2-08daa1010de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 03:25:12.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKC11Ft04yMm58dAVolkbZ6G96EDF1sWLea1ucISb9N/q8hUF/T5777MY1m1lx1jdfYH094lDMAtYyonCx63K8/XaUGbCob8qjzyhREorvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6130
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
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, September 28, 2022 4:47 AM
> To: Angus Chen <angus.chen@jaguarmicro.com>
> Cc: jasowang@redhat.com; pbonzini@redhat.com; axboe@kernel.dk;
> virtualization@lists.linux-foundation.org; linux-block@vger.kernel.org;
> linux-kernel@vger.kernel.org; Liming Wu <liming.wu@jaguarmicro.com>;
> stefanha@redhat.com; Christoph Hellwig <hch@lst.de>
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
>=20
> First this is a bug. We can fix that so it will fail more cleanly.
>=20
> We should check pci_dev->pin and if 0 do not try to use INT#x
> at all.
Yes, I will send a patch for this only.
Thank you.
> It will still fail, just with a nicer backtrace.
>=20
>=20
>=20
>=20
> > without config CONFIG_GENERIC_IRQ_DEBUGFS,
> > I found that we called vp_find_vqs_msix failed twice because of
> > the irq resource was exhausted.
>=20
> I see. I don't know enough about how this work, but roughly
> I think the issue is at a high level
>=20
> - because of auto affinity, we try to reserve an interrupt on all CPUs
> - as there are 512 devices with a single vector per VQ we would
>   have no issue as they would be spread between CPUs,
>   but allocating on all CPUs fails.
>=20
>=20
> I don't think the issue should be fixed at blk level - it is not
> blk specifix - but yes this looks like a problem.
> Christoph, any idea?
>=20
>=20
>=20
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
> >
> > --
> > 2.17.1

