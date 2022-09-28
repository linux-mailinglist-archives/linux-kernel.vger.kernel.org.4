Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421B35ED3FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 06:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiI1EqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 00:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiI1EqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 00:46:08 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2065.outbound.protection.outlook.com [40.107.255.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828687EFE7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 21:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJICSWpWINbHkNmJo0/NxcD+O+llNWAC05Deser2vRiKCX/m7gn+sinSIme/tebEhNbkh9p2VXPZaXx60DrOjXGiZRDg/efBT8mP8oh/O9/wfoI+VZwvl/0j6slLNqoBBjavDO6YB5PFmoIZlaz1JZnb2Zp5obvljJW9QTbf3I6GMPq+g3n2kpfKXC+2baSogQwK7Dki0aBgTpgpwkSy9Iwqz0n59ybFiVronfJZcMpXDH0tsJbTV5RRvu/WOAJP8K6drnmxFkOJlonQe2cm7u3moA7EmaucmfFvwy/7bg1KvgZPF1eTb6pdE4KezcxoDNHMd+VhhKPhWSvhenxzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjsjZQIgd8sjQDsPmbY7VIbr7lTdevyi+b0NpkjMuSQ=;
 b=Wqc4dl9xI1eR4GoXvJwqn/a2DsMxfBMeeWvWS5y2sRjjcXHEVX58S0b6E6U0PyPpFvmvbB3QTXLK1ALtQL+f0qOsdRm/Bq17G8am0wiV63zfS7aS8G189gBs2B9zGiVUF7HaXGPpiXdkDggfa/R27POFpE5m7XK8NwQ+SHSynZFQ46ba4UXP6aorJeeoqc3p2wHG2fHmXrzEf8gAXp/JhIEMBDqX+x02O/djfQWMQjSmhhWfDQMyB2c86vpbhtETsKbpqfvqC0CCbPks7cdzpOrOmr+c1nfFvfLHR7yFlnCinuOTjGkMiQUbYyig96tH+H3pbvKElQjhqjXW90Yp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjsjZQIgd8sjQDsPmbY7VIbr7lTdevyi+b0NpkjMuSQ=;
 b=EYbed3+qBS1xc5SouStwsIVRjP9fIVPHifaCrQY99srUqrF296oAkhubz0hbq/d4KlhX3uq3cm7d622FK+0g3lJauQie1f1OOL0E2PxpSBx0znUgkadOeQv3Qak1w/DLkXFaDjsILQyu1xFp1zwhrtuYPYs+XbJC3uwF5lqEGZM7A1PyQNbI5S5l7dFwLyTpIiB57l1rcg0vpH2YehFmjRIozabO/k40N7pBvaniGbh2BgvsEdsVmZsMDl3dFyaev6X5d8BOsCjBIScnqvVovcp6ucVwgFVXJGL7n0YWvrK89oA5K2pLZY5SnmObD4rB8HQC6D+nGb0lAMjLnoTcoA==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR0601MB3892.apcprd06.prod.outlook.com (2603:1096:820:32::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 04:46:01 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 04:46:01 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] virtio_pci: avoid to request intx irq if irq is zero
Thread-Topic: [PATCH] virtio_pci: avoid to request intx irq if irq is zero
Thread-Index: AQHY0u56Rn+dmsnse0+KLnrihtFzA630OIyAgAAKJ6A=
Date:   Wed, 28 Sep 2022 04:46:01 +0000
Message-ID: <TY2PR06MB3424CF33CAB7C9236C97FA0785549@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20220928035706.419-1-angus.chen@jaguarmicro.com>
 <20220928000228-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220928000228-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|KL1PR0601MB3892:EE_
x-ms-office365-filtering-correlation-id: d13eed9d-86ff-4a69-5b32-08daa10c5832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vW8bu74DBWI0yCZv538mMfSBDnqrcP/levyF/Hax33z79QyV7ob7fSVzYYF1lDuH3x2JaoXZ2Ui8v4vC4rlVp4RQy0q2vRMCmZWgGhgfz3oMGdkljSy8ura5nYrAHGt0sroz9pbgQj4dwAYaxiXTNYDfKPXGmEatLax+hOEI8p9KyjrjvgLDZzzSp2DGdtIqhzkVQwZ1r+jjGyXqczLRZSNtaEsq+Zo1m9s7K+yWG1gzlvSzjgKESpg+h5aIIgdQ/OGMA/mh0YNzGIU3gB10QMRncynR0ZP4qSe6SQiO5myEqYsFFHQD/nQZ9kDIcRsO3WZfLpLWf3r6+q8MGpreAzpcIT+HocPrg3t3zbMsDZ1+jJjEHqVPn7FqCoNPir0kqw04nuvXwrRsfIIBNmOwwka48aq9D6UVE9RYyAGO1Q1w7cgvDasAfEeT/lO2xh4vtvWNbapJMjDmxpTlI/fcCGXuRpDLkELAmTkCRTgT6gkOSHSHRCMwJTXza3VBtNc5SQMSytD24XJ5yyHvhUraBsPYj25XDvQ7q9/IFNAdF7VkK1s5RATiJ9e/WcbeTbyorapjfrb4E7VGBid1g2xRfVcBI9iyz54RczRQ3TWpGdVbPYc5ZaS4E3UymPiSgCUwvBGUeInd2WTjKPuFG6HuTmuyxoD+yw+C2DlEBtVNDcSf90AF7arxRm+Ps91/IYZixuMRuiI7NCzL9ZRC3NWlc4TcBwl3t59sZ5Fo1oookACmFiR7/1mKXXUtxX+2cH7Mv0hWp8ib7fEdJkKa9foofQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(396003)(39840400004)(451199015)(6506007)(66556008)(76116006)(186003)(4326008)(64756008)(66446008)(8676002)(66476007)(53546011)(6916009)(26005)(54906003)(9686003)(33656002)(316002)(122000001)(2906002)(7696005)(5660300002)(38070700005)(38100700002)(44832011)(41300700001)(55016003)(86362001)(66946007)(52536014)(8936002)(83380400001)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BSDfiysGMv0BzHVoKpeghuVcklzcGdzYqbpLLY2byfav94rQ7MQa3s9GT+Ge?=
 =?us-ascii?Q?Moo/TAx1Suxpg2Ppvd6jpdpn2bWSmpRSbZ5ns/j/+eBOefgfsOzhVrpkL9q9?=
 =?us-ascii?Q?/kh7GSel68O3udp+GLGkhco+PGpOT47jK+YLM+WIt8z2cOlKdbcwObFiaG4G?=
 =?us-ascii?Q?XRHVMWTcVIIjt0H/KP3I7A3CL/USSC0DSO/BUo5hmtzT0DUoTXFGKYfefeQg?=
 =?us-ascii?Q?Wn9IDICX2tdBBEIz09AGNjvY0ffE+6Yeo/JOrcpgzZtfXq1GLahpCOIvUiu7?=
 =?us-ascii?Q?VlcO69YWB1zdr3PAe7CjGKkWTiWhsfMul74an0/64f+wb+f/LrtMwPGM1PVR?=
 =?us-ascii?Q?uhXuIXq8aE41s9lSBxdCp6jqg34zx1Xlr3uioMld3JB/5ECCx1kV7ETk5DfF?=
 =?us-ascii?Q?dBhQCaCFPofVcQdGiBsDo/DY8zTVm/0YDdUDU7knYHb+imfufY1orQoB7HNs?=
 =?us-ascii?Q?CQMD4imNQ0uP/kEfhK3J8ct+DGH3wdy6Y42IoBK/n/6/pjMjvymdUeG1cPPz?=
 =?us-ascii?Q?lJMB5/hN48+XhYQyBAJfH/FDFGawXEzL1/xug05oSZ3L7CaKE8Hzl3FGjzAp?=
 =?us-ascii?Q?V2MAeNGEUHY0MtwluG22VnbX7trB8f+wNGmjoPse/E5q3p93ElmzbkGSNS7u?=
 =?us-ascii?Q?Iwipgpzzpka8cz2+118iXhTWk0rSN9+WvYpfUTA7Muoivrv3XQuL17OZ7qgH?=
 =?us-ascii?Q?XAQN+5EQfKxtj0LROCejzGithlLijOkDxV2xDnJoDFppSVltkbvBJZNT0Ge7?=
 =?us-ascii?Q?yfFw6970EVk1gnpmiIqaRrhRsH3+NHVFpIEPt+xBcNeQ3ug2Any+Mw8zAr3y?=
 =?us-ascii?Q?ncK74P4Oi8wcTkCkkC9qXceifKt/EWtoNX+1dArFO/NxvLcXnWquo6fOm+sl?=
 =?us-ascii?Q?CVH4rYZU+hVE1be5wus66oHs0EuhhPBqcZO7NT/ISjAAtI5nnVsVkvbK/G83?=
 =?us-ascii?Q?5heiIL16ZmM5X1cWioXxNULd58BBPuhMN2FFMfEU5i4grX6pccwzn9kDLRFn?=
 =?us-ascii?Q?6JMNHq4ByBV2yT0WnFv/N67jcTJbPpJa9HGIHqXqdjcyC5n/xcZmuIfFYmoS?=
 =?us-ascii?Q?h68P52lpwBhQ9hpj1fuX2Snj3vVHUme0BIpyT2jCvg76Mfs4pbNpWJ3WsZoC?=
 =?us-ascii?Q?HmkDDiHzfuhBR67DmlB4V30rGsAos58mtdL4rB+FWka5WpM8bEaeS3EwB8zY?=
 =?us-ascii?Q?9oDup4MSbwDpos95hC3bapI8A3jmxPRbVfa9+TYEIvaH1bQRjADW0cJDbLwH?=
 =?us-ascii?Q?kiUhzuBymbECR+5BJtG1cC1jUj4DnvcMHxqBJVEl9PgqW++BeqYiB47G9scI?=
 =?us-ascii?Q?lF34NI6aUn15fgG9wI7mBlFa+A99iAkpy0cRLwtAk92xr6fnOBsap5zp8sVn?=
 =?us-ascii?Q?mKY9mNoPUeXhW0mcAFo1MMWhTZ8FtjT9/AGEVwKhR26fJxgYyKUaKfVqQIlN?=
 =?us-ascii?Q?hggN9bYUVplSrbnp+3yJy8EQp4tREClHxaOZwtDzYKmvak6kksf7YqcigcbC?=
 =?us-ascii?Q?ASohY1DWYiIux4eNeDvzrSxJgB/91FHtBK9y+VlaEP8JiuURvdz6UW5RGLxw?=
 =?us-ascii?Q?bDVLO57P2HshgRQsvk7Nx+pjlL/ZqXOO89T90M1nGTbo90SCPcC2Waj0A8y+?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13eed9d-86ff-4a69-5b32-08daa10c5832
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 04:46:01.7096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B21GJwagd9vbDnF0PRVO3bK6Rw00CMLIglgHzuU2n+fu2WIVnX4YbAS7FGRXO/5m0FyWZkgxLMvVEkX8Bi3CgP2CCaWGEKgbt+uorGwm1G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3892
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
> Sent: Wednesday, September 28, 2022 12:03 PM
> To: Angus Chen <angus.chen@jaguarmicro.com>
> Cc: jasowang@redhat.com; virtualization@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] virtio_pci: avoid to request intx irq if irq is zero
>=20
> On Wed, Sep 28, 2022 at 11:57:06AM +0800, Angus Chen wrote:
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
> > The log :
> > "genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer=
)"
> > was print because of the irq 0 is used by timer exclusive,and when
> > vp_find_vqs call vp_find_vqs_msix and return false twice for
> > whatever reason,then it will call vp_find_vqs_intx for the last try.
> > Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
> > flag IRQF_SHARED,we will get a backtrace like above.
> >
> > When the pci device is vf,the intx
> > is not allowed and it will be 0.Even if the pci device is a pf,
> > we should remind that
> > irq 0 is almost be reserved or used for some device fixed
>=20
>=20
> Where does it say irq 0 is reserved on all platforms?
> I am not sure this is right.
>=20
>=20
> > like timer in x86 without IRQF_SHARED,so we can avoid call it.
> >
> > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c
> b/drivers/virtio/virtio_pci_common.c
> > index ad258a9d3b9f..3208a2b149b9 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -362,6 +362,9 @@ static int vp_find_vqs_intx(struct virtio_device *v=
dev,
> unsigned int nvqs,
> >  	struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> >  	int i, err, queue_idx =3D 0;
> >
> > +	if (vp_dev->pci_dev->irq =3D=3D 0)
> > +		return -EINVAL;
> > +
>=20
>=20
> Pls read the PCI spec:
>=20
> Interrupt Pin
> The Interrupt Pin register tells which interrupt pin the device (or devic=
e function)
> uses. A
> value of 1 corresponds to INTA#. A value of 2 corresponds to INTB#. A val=
ue of 3
> corresponds to INTC#. A value of 4 corresponds to INTD#. Devices (or devi=
ce
> functions)
> that do not use an interrupt pin must put a 0 in this register.
>=20
>=20
> Please check vp_dev->pci_dev->pin accordingly.
Ok,I will send this for next version.thank you.
>=20
>=20
>=20
>=20
> >  	vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
> >  	if (!vp_dev->vqs)
> >  		return -ENOMEM;
> > --
> > 2.17.1

