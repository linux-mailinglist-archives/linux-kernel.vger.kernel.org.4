Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458C65ED4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiI1GWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiI1GWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:22:08 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2067.outbound.protection.outlook.com [40.107.255.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19B1127540
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:21:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui7zg3SWlMoSqvzCWOHdOs/2RZDSCB/kCeDGVN/jstuQBaF0/tI/Zoxr+0osXMprl11b1doUqla1DHZJjbcKVFd+PgDuvzkXeL2kGnNuPt6Jb5g/G506h4mkTi2jJ3z6DWVMGCJTxEXzDw48qE6uWfYAP6lk6jvTrPTdAtPsdlm2yWmp4+MmjClncdMnyoQ6IFfiup/8eE6nq0aQ4L2kZPo5P0SGKHBkOTeLlHGv6RCGyVp7uDnohi+gJJevWi2iRP8tc+UlNM+JzinPAGCJU9FWRUSbY0q/a3FRAo/aeQmLXFRs/Y32DPIBIi+khrPa8BNCNtOuhmX1BtY4GAYbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JM15/nn18kYCaEfy0kWzxP5oPiJgcm0aJmtM4Wr/R9A=;
 b=nzSv4fKgNH3nwfQh1vRBHhDcLlMUs0YycwutizaJT3hhOq4HAVIfFHZX4DuSiyNgBf1RBeDZs2wqSHQw8CQs+mbwO8nmYhPg8ZeL5gvuj9c4Okd+YGuJ8wOvc/lKeNn+T/F2TPzoY/mT5P9YHceP9/YQzv+V4q3dQM5VakNaZMEFGAxiXl/OyCaftM4+ZP+2sFGPX82XgdiznYuZMLYmX2ks0km+AFLoB5ihXCmXfYFOyhoW53azafVjjN0+WWFYiUA64SO9FtH3OtM0lHzg61mI+cYvB6fK7VHpE1KIJPOK8j2t/iitisDqTGm9gmfd3JKLcfHXeYj2kgWVr/XJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM15/nn18kYCaEfy0kWzxP5oPiJgcm0aJmtM4Wr/R9A=;
 b=FjB2npCwDl6N1XP7dj0Wt+M3c9acz9CeO/lnW10Q/kANDSjjZl46FaLl3TyWbl9M2ACELkB0d3nPTJUAg8SPiVDFUP7RvP64VHgyGexWuVHPEa8GPiJ9GTD0KpBWb2pXC89+K6j+LkskJWCXfNND1xywqSYml+W64uwYKWaoZBOKgEradGSSnAeTXZgmoGAQkV8rQ9VcjXajTGC6QhRSfv7KAoYqKJH1J21GiJ8PyV2ffjDVhGMMFMrHsIj2xTiXIOJC8hc7uX2fhrFoHMm+VMs8wcLkyN5Jb0mzY84anwpdTTX9ekEyYZRYURL1OjtXSdQ4ays4Nd7v/7znikenQw==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR0601MB4082.apcprd06.prod.outlook.com (2603:1096:820:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 06:21:55 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 06:21:55 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] virtio_pci: avoid to request intx irq if pin is zero
Thread-Topic: [PATCH v2] virtio_pci: avoid to request intx irq if pin is zero
Thread-Index: AQHY0vw+pJS/g0YHfE+CXD9R5mchJq30WOyAgAAEeVA=
Date:   Wed, 28 Sep 2022 06:21:55 +0000
Message-ID: <TY2PR06MB342404A53CC618307B61246C85549@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20220928053522.440-1-angus.chen@jaguarmicro.com>
 <20220928015402-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220928015402-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|KL1PR0601MB4082:EE_
x-ms-office365-filtering-correlation-id: 82598032-ced6-43c5-b954-08daa119bd84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gx5RLdeIe0dmdgaQrXkSk5+EB2pMUO1ggUs/SyNUKoh26xqFED5tyEsRciGWwTB5YdQ8ycutIUDEvcnmMwZf7yVnodKLAnZ/wyyY9kcjFeI78Z+TXnc/BgB4frftCcDqN9B+dozwqm4cpum/fmeRGfQL6VYiKJXEHWFhVio+JIsuZEibCXCX/3jq9d9XCxXjCsicPmT2R4VtLS9pg3huQXOMKTRCwhZE1Xt5zttoyzkg7G47q8lUuJsWW+2zaP26BiiuLLFpefGHK360YjFmXHP99vJASVtSHlUinjGA7luaHuDvsqOy2AK5nsV7BgAC29Ydk3cmFFJM5WKD/7XFuco8qJ4ceb73eODhZI5eg8NStBx+NfspCrFIkVgW5kh8TxRcmhrTnTlyAUQXz3Im7d5zGk6H5Zs/hJ/Rz4jzBieqWMkwUSgCyjQU3RufThsTnNpCP0SC7saZE5rNY03ifkFMP8Juk4RDerPZMAYSfafOCVef5fcMEoreSmw7k9kfU+lheAaz+puQ7rv2iJ9jtRleVv9J2F1w0qCBgUZFQa7/N2Lz5P2ySgOlH2rVfb3mtbCdXl7eOoGyQdlY8ZfLxS9VaoEFZKUbauk/tpCfC8YXiUnHTgBwfaIOp6WBSYDULq+CLIVeNlz2q5HGY3JkvQZuK0jPJBbPBlA4AjUvmoyDx+TKd81CfYdwdhVf6qNgmJ3c0L7w6sdPA7mZ153EJ2u5VdBdiAx1jLCGME17bKe/Jkn5T9/AZq0mEL2UttEQir5HdyftDJTQYC6AmGGMnsXilAor/Og75XocLeI8luI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(39840400004)(396003)(376002)(451199015)(122000001)(44832011)(66446008)(33656002)(71200400001)(55016003)(2906002)(38070700005)(8676002)(8936002)(41300700001)(4326008)(38100700002)(66946007)(66556008)(53546011)(66476007)(26005)(64756008)(9686003)(76116006)(5660300002)(54906003)(7696005)(6506007)(86362001)(6916009)(316002)(186003)(52536014)(83380400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DnP93EzDDcDLEK//u++iRe6h+Xs3qYth/3v0OcdSdGPSOFXJObQ95xKe1jS5?=
 =?us-ascii?Q?NdRfmlo8RFVW6dLJqp8iUtPDFs8cZ2ORgfAxRUj5DkdpQytm+2j4xU6GOKRY?=
 =?us-ascii?Q?6skkJZK3WVH+HeJNz4dWpSnqzb0zDewlXjE2ONg8RO+T+x2wPqYRX7wp4Gkg?=
 =?us-ascii?Q?V0PkxcirY/bx2LmV96ZH/xKB/JMdhj2M3gB9SJHMlXikP9tgRDTPYVsFbG6L?=
 =?us-ascii?Q?730RLaOg5mOkgu1sddNr0AoAUm1RoRt65eouB4YyMluIqJdkmD/aISWIplFU?=
 =?us-ascii?Q?+4xiZXWDKvELK3vewyPgUdPDBKoOu7UFbfv24LlHBrCgu6ajJO7N2nrXOVG7?=
 =?us-ascii?Q?EjF+AU5rC/z9iADRufybPpTTPwImkMtZoPgOF+5o70YLQzuP23iHqGLQRyvF?=
 =?us-ascii?Q?bAw3syvk/T2qRVp8VXwnPSs3QJWSm5xt9t/M3WFioQDlHA2Tl8aNNadWnAL/?=
 =?us-ascii?Q?UqePPVDgKynSI11FQpMI//hjQ+n0Q36R4ez1G8XSbZBHfU/s40REN6GwxCm8?=
 =?us-ascii?Q?eSNx4bKzctyP8ZSJ1V7qRCz0jSGRr55Fq0KZmlq1Tc2LJYJC8sY0Ltvbc4gZ?=
 =?us-ascii?Q?2BU8w0C0DodwvDo2YXBSB2pR3L4YiYT4bHggBGBs9yRSjiZWrn+9k7HRD2mL?=
 =?us-ascii?Q?T7PlPVU0K8ajO+r6MM/U5MzFNfuCGpFqnmhADMGFaaxTfapEbv9R2IxQMPM9?=
 =?us-ascii?Q?chl4OKT3IcngIZKk+/7YrL0cbDWQgJ7CUeD0+H55ls9LUNCCEdMz9K0U4OWP?=
 =?us-ascii?Q?A96Smx/7TooU8lU7DfEJYF2zO15vRClcd6oUWOjND+RDJ8ZezgfAGHCLjDkA?=
 =?us-ascii?Q?QnkPjLLZAN4g0UD8N7dIo1WAXuIWq5uQAepauk8C6/Sm45Uh2Rf5PVscxPcs?=
 =?us-ascii?Q?8QncjYScqL+fl5pH6bds2YYGmG40c12d0xUzoD9RvzTkjJHmNagpuAWhxOSW?=
 =?us-ascii?Q?w+vQG0UgpdWZgQCkRDLrizfM/bxQSDroa6ITM4wN+updkm8b6AF6KPB6hKEM?=
 =?us-ascii?Q?QqwZ0qIcJ32wgC9KvKXAbzzjUk3bAO2VgJuHKno7W8WGxJsxfROiQgedAGMX?=
 =?us-ascii?Q?GBWC4cdXuBzRngkUpebtxBVUGVf/keA1i8B6X87It2uwY/+QIRqy1bDMZiWh?=
 =?us-ascii?Q?CTJpJ1SbqX0wA+tCHLGcdB+EaapFYULfP6ljriMKugrUPGHOdwS46Zo2eu6O?=
 =?us-ascii?Q?/Qsqc0RuR50Evn/IASHJvHvtMJgSiCZ270e2oexZUIxZQyYwnIxWavUe2svu?=
 =?us-ascii?Q?qwO/3OYnGvJzR9q7QLO9znfB0t8wMKdtItJ4VUaQU6tlSxo6EzYL7ohJhQ3E?=
 =?us-ascii?Q?OLgSA2shsmWUNDe7KcJy64LD46UmCYnHpgnVzhFQ9PSnOFDUSo7GKWnDtig3?=
 =?us-ascii?Q?pVV4vAfKpt4RikCyZgSjr5nsH5mkbTqp/CIhnJmz01NZ/VefXEf3/0m7bQQf?=
 =?us-ascii?Q?ZL985NDeLZ+9ca/R2L4sfWMAcr25OhVs//gfJTPXtELMcfJ9NKNr/OAe5ZDb?=
 =?us-ascii?Q?qvLpkIe2BFg62jshGqB36r7EAhsAvg9Ea/gvNUhvDu0vWi6a0LxxmFAMD24B?=
 =?us-ascii?Q?mDMHxz6q/YzmBgxf4QXCafiZr9/oJYFaxVOwf3w/HZPB3kpC4j/Jj+zZzTKM?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82598032-ced6-43c5-b954-08daa119bd84
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 06:21:55.2036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SiC8X8Q743mW01jQWBCvF+CP9dB8lM860HIzKmtdlkutPszus+yxqnmoYdRNjVXCAe7XMjIDav62jl+b5gSSuMdnyqUaCSrrJZAG8XE9mNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4082
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
> Sent: Wednesday, September 28, 2022 1:59 PM
> To: Angus Chen <angus.chen@jaguarmicro.com>
> Cc: jasowang@redhat.com; virtualization@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] virtio_pci: avoid to request intx irq if pin is z=
ero
>=20
> Thanks! More minor issues to address
>=20
> On Wed, Sep 28, 2022 at 01:35:22PM +0800, Angus Chen wrote:
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
> > according to PCI spec , Devices (or device functions)
> > that do not use an interrupt pin must put a 0 in this register.
>=20
> Pls add quotes and add "Interrupt Pin:" to make it clear in which registe=
r.
>=20
> > So if vp_dev->pci_dev->pin is zero, maybe we should not request legacy
> > interrupt.
>=20
> and drop "maybe" here pls. I guess it sounds impolite to you but
> as the patch author you get to make the tough decisions :)
>=20
> >
> > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > v2:
> > - Decide whether to request an intx interrupt by pin instead of irq
> > - suggested by mst
> >
> >
> v1:https://lore.kernel.org/virtualization/20220928000228-mutt-send-email-=
mst
> @kernel.org/T/#u
> >
> >  drivers/virtio/virtio_pci_common.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c
> b/drivers/virtio/virtio_pci_common.c
> > index ad258a9d3b9f..81225e503e69 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -362,6 +362,9 @@ static int vp_find_vqs_intx(struct virtio_device *v=
dev,
> unsigned int nvqs,
> >  	struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> >  	int i, err, queue_idx =3D 0;
> >
> > +	if (vp_dev->pci_dev->pin =3D=3D 0)
> > +		return -EINVAL;
> > +
>=20
> Pls use !pin for brevity.
Yes,that looks better.
>=20
> >  	vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
> >  	if (!vp_dev->vqs)
> >  		return -ENOMEM;
>=20
>=20
> So, this is mostly ok. The only issue is this:
>=20
>=20
> int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>                 struct virtqueue *vqs[], vq_callback_t *callbacks[],
>                 const char * const names[], const bool *ctx,
>                 struct irq_affinity *desc)
> {
>         int err;
>=20
>         /* Try MSI-X with one vector per queue. */
>         err =3D vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true,=
 ctx,
> desc);
>         if (!err)
>                 return 0;
>         /* Fallback: MSI-X with one vector for config, one shared for que=
ues.
> */
>         err =3D vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false=
, ctx,
> desc);
>         if (!err)
>                 return 0;
>         /* Finally fall back to regular interrupts. */
>         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> }
>=20
>=20
> So the real source of failure to use msix, will be overwritten in err by =
EINVAL.
>=20
> How about moving the "if" to vp_find_vqs?
> E.g.
> 	/* Is there an interrupt pin? If not give up. */
> 	if (!vdev->pci_dev->pin)
> 		return err;
>=20
OK. vp_find_vqs_intx is staic and it only be called by vp_find_vqs, and it =
will avoids a single press into the stack .
I will send this in another version.
>=20
> > --
> > 2.17.1

