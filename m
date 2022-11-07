Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C956A61FEE1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiKGTq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKGTqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:46:47 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1B228E27
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:46:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlWcpHsyU34xE5c8q1TtUsTvT6gmvuiH0oa4Lsvfs+sxAolPsQLi8jY0WOaOyRBTk3Y6SMzWsxA8vsADTaW+pBPEjsfyatB0Zq6D9tKB8u1sFfDjb1qHHAnExjbmJfjCO2wuIBPjjCSi9tNlS7ejwRbfuX8v1lAU3HS0CvGVbaEr0NcQtG8Iv8ZCOXgP6EtkrXKhKL6dewCizci0YvUmmQjL5TjJOYJLEUZbtpRmZxw2bRzDwh0mVIrCdZAUbjx0+e7sGcr/sH3IpWEkucZN1h6eKeAp+icNh18dGZa0S8jRe5WIa3hRZULIfq9/91ZJMEDHkxDD/9oBCUbwmBXSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHUY/F4Wz8ywA2IPH8xD6wCstJrWs0sE9pTzQgTus2Y=;
 b=cA+Uyu6jIDLdkai+xeEaGkDhNrMhkQ7fsTSDX1f1gfg/P+2srFfIdb5QQuMOtXZ3MsyNjrjBLZ+Mip/xkzK0QaiSb488vU0ZrgI7LVv2Fk9pcHMIJhvQ1ss+xpWzB+j6G5ay3xDE/PKT6AsnIHNho//PJ7DD8PiCsFrf2fQZNKxnyhRXF/b7fcbIO0P8/0MWv24IVOYoJ/3WeP1MJuqbWYAPXTilgQdWrC3QnpVQ/rTDTI43MUrw5FYjnhepPHAV+wJCJR/8/JBm9qk85M5fA3LGlc01ZcvhxSC0WDyHnb4rQRDch0spfe5j/VwQl7tXy5eJ8teqmT30F/6H67bmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHUY/F4Wz8ywA2IPH8xD6wCstJrWs0sE9pTzQgTus2Y=;
 b=qcE0vgezFRMBoBBBhO7KbVU1cXcaPoxTmKaQOIYgRG3OQL82icJb1fD+6pV8ABjbcV03sZLIX7iCDN4KhSCOzdpShpuBExnjRIsy79OvL73bRYJykB9GYkuLGoPKQS4IDEMa+41yALNyVhO0oSWLI44JZUtxowetQAyT/NeU5j8=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by SJ0PR05MB7504.namprd05.prod.outlook.com (2603:10b6:a03:28d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9; Mon, 7 Nov
 2022 19:46:42 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::583a:1fa0:a4de:d596]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::583a:1fa0:a4de:d596%5]) with mapi id 15.20.5791.017; Mon, 7 Nov 2022
 19:46:42 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     Alexander Potapenko <glider@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "georgezhang@vmware.com" <georgezhang@vmware.com>,
        Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "syzbot+39be4da489ed2493ba25@syzkaller.appspotmail.com" 
        <syzbot+39be4da489ed2493ba25@syzkaller.appspotmail.com>
Subject: Re: [PATCH] misc/vmw_vmci: fix an infoleak in
 vmci_host_do_receive_datagram()
Thread-Topic: [PATCH] misc/vmw_vmci: fix an infoleak in
 vmci_host_do_receive_datagram()
Thread-Index: AQHY8HccmPEqSy5Tt0iqpaQK6n1bVa4z4mKA
Date:   Mon, 7 Nov 2022 19:46:42 +0000
Message-ID: <86C4301A-585C-40EF-9939-DAE5671DF5BF@vmware.com>
References: <20221104175849.2782567-1-glider@google.com>
In-Reply-To: <20221104175849.2782567-1-glider@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB3960:EE_|SJ0PR05MB7504:EE_
x-ms-office365-filtering-correlation-id: 8e950573-bae6-4893-6dd3-08dac0f8cb4e
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6OaefH/XSpUao/2uwutDogs3/+bEhI1yNsG7GEqVXLCSl/AY7YfpmsSzXGwSLNMMslbtcrCOZoP0M94NIF18eFgP74mJvJlgmJSh7+vlKhouHZIBB9tXkxoKvB01o7JUe3hGF8nMWmKSOwPSYJsMH94lNo5HXryIh3GpclobC6SyU84DVnJDPxCt+A0IbUNvm388wesIvUTPEJkPKJMMLkUUWoYJqkGPhXZ1yHGRru0OGwL3J4lo/MVP8ydFLrdXq7JB1UuhuPTSEj57n55WyHs2SPO14Skx+dSRxvOrriSwN6RjrAk3udXlhCqmMF5bIGBclAtBaThc2XSLsnSRCHsc9Z3W3NiZJRGcmzNOvzCzTt/wAnmOgrUy1WiQBgdm8NiWO0yLfFuBg4U7mYSSVyfUBz85r3vIN4M4LdndMBKkmh6p74LFJbkoLlWfPY5RKHXRJesHF7daiNTK7bCHvZ4wIKAAfrUkUnQi1m3bnRTJABI4b3iqZDtdslyDcFo/MiHThy/eXwlmd+r4Cl6j71/vSM/2m6ZnXSJDXJ9bGelr5ZTmwHcKd4BgZRTG9QEroFsnc5VPbQB0j+JfM2TjE9HVExf/SS21UoHn55QUHZDaVu+uCFMUz1+MzH+QVbsUuimfQzdhmZAgERY8D3r00UQ1MovIG1m1fD7hJ7dmz9AXWzoSZIdrb5FaSR3lvZXV+/iZcRH5C90DyFSy53EzzvNAPrdzPhTm83Zkw/Kno5q0oCZdgxCNwLvRIw3COHrKp4sbzxCJtlHjtwVO/SxxsAgiZz3xkNNsCsrtxkVmPho=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB3960.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(6486002)(6512007)(5660300002)(33656002)(41300700001)(36756003)(478600001)(66556008)(64756008)(8676002)(4326008)(76116006)(66946007)(53546011)(6506007)(8936002)(66476007)(38070700005)(122000001)(38100700002)(66446008)(2616005)(86362001)(186003)(2906002)(83380400001)(6916009)(54906003)(71200400001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WTaV/anXbg2khPqGBbuP+yJs0FjmrMs/+hhVEWD4TpWyNUUQ+9PgPa9BEu3q?=
 =?us-ascii?Q?v8OyOzH7CGQJKXgoG0VNBUA3/aK7GHSAmgP6gFHt7NygWo8b0HYiBqJEcn5M?=
 =?us-ascii?Q?D3BsHnn/Fc+7U7L3FpWR7E3J/fQu9ZZC2NlsvdLbu4OzRGs6DCcLKDFitFNM?=
 =?us-ascii?Q?v34ooI3pXbmXiYG7bLAO4IeiCFtqxYyjxTTMVnJvzaKydZQBNZdLOXFyQJI/?=
 =?us-ascii?Q?FtuVq3K5ptEMvGMYHmwZo03Bw3CywE46ujNN3A6z1cF52p6EDYXanypW5t1+?=
 =?us-ascii?Q?lf3GoVEYaXNGIzX6xUQd+cmZ1vzlQ4QzbU/qE7UeFerV5ZUAU3E71Y8zOV2/?=
 =?us-ascii?Q?ZQ7yody0qI3NopZs6/1shs7oeBr6k67ZsVLvGQxZpJfIvuZiUSe/xIxv0R97?=
 =?us-ascii?Q?2Oh6wAq/QUuRhWy482uJBaKVHg4HM5AfKZBEEsgjSCOEATJksZ5cT7YuBmOL?=
 =?us-ascii?Q?xZiZ+hYNymoQDdGLiKqgs07w8ZFIIalm/pJNVRQLl3IbJ8I+mkpOGjsPGw2k?=
 =?us-ascii?Q?HpxUrTY2mkwgDMmRBNvshAKW7NX1Wytc4CjUZKdP2Lq9rq23ugSAnjrJDYSF?=
 =?us-ascii?Q?8/7dT7RpZ9q7UoMrgbEl6MXdsBBCKCHRc8DSGLo0U3Gk9LCp3njOJiPmKLif?=
 =?us-ascii?Q?von3JbwxAuF1bHvWeDoOXd1Wnpj5jNBUhLmLsN7CS+rdTLHb1uQnMM5XCSc2?=
 =?us-ascii?Q?Jd7GdswwlwxeafmFvNqz9JPTxA3GNX0o9xSk1uDNBHFztBnUtRHYD/5Ui8yT?=
 =?us-ascii?Q?mCZXJ81MIGUHmP6DvGw/73Q8a+2MmSYsbQbU1SPxu7tY3CqLcbLU+BAxO0O5?=
 =?us-ascii?Q?gFLJ+o3Mucp1c8ti9EEBKQSbEh9jJw7HsIiAb4Op9DDm8pv98SlcV6dZOzL3?=
 =?us-ascii?Q?0+zjNiOjehxCuuIMJtreVKE7LFDGdFzloA+ArHhAe+iI4ii5O+slSyOCO+9i?=
 =?us-ascii?Q?IqSnwURYSGM4u2LNQ7f13U1cB3Dxb9QdVgmTvi4egmzPLGkSNhuhJDsuWjgY?=
 =?us-ascii?Q?4k2BAmjuw20Izk6YqEbrWInRllVZPW4046qS/xYYa+c/ApG0i3apHpLW6PAV?=
 =?us-ascii?Q?DiyoybM93zrzBk8Aa/GpneCCi56WkL7tBERrE9n2Al4zH82adBdf6xPH186L?=
 =?us-ascii?Q?9rKvP1YTLT0CeXhrDCDKTxOg3rqTE1qG8WvBV1eM7/UxsI1+Pb4/yJuJZ+mL?=
 =?us-ascii?Q?LK/WaNx5XqFeJeR0ThnjBI/AyqHO0RyuEVStUDz/UO9u4wPPUYwfNdtDtAbd?=
 =?us-ascii?Q?03SbaksaUp/ytEr8/OdNnzrzJpdQ2wWNqQnkume/YlYAOgjtXa99suNjm7Xw?=
 =?us-ascii?Q?OD5zPF0lv9sOzP5o8symEWkcIVbjtteL0PbZLeJq1yy94znSDpQ3aeL0oCLW?=
 =?us-ascii?Q?ckssK7FpDdr+HOVbaOIthOSJ4schAlB+ZFdUjZjsXlCBlsX0LzhgYXgCCroU?=
 =?us-ascii?Q?RcFyrB2vuGnGOyk5zcsH132FjRJPFQzjE4FhNZhNylcHna10+H8IdQbmuFH2?=
 =?us-ascii?Q?Zy0HJFqBWSJRISu9K0DB9h1nyCMUQ21rJ6hLyx5B/HF0m/aYPRK7PeA52ms1?=
 =?us-ascii?Q?5X+LSWTxskVwkv1a8uZZW4TbN6qD63L5AvkI2mnDEsD6uEy2zaCUAb2e2+Lx?=
 =?us-ascii?Q?8D3UiRAU2IvoiQIiSSquf5GyQV+VLfKkvUwxCe/jLAlH?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2EF84F93573E44A847C2B4E89E40C65@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e950573-bae6-4893-6dd3-08dac0f8cb4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 19:46:42.1527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4khaBSjFWzljjyspOOzFOP5CynA77x8V3Q5q2qErunInX+IX+HOE+43NMQEoQATuHpGlxfZzYO7Ju/OsUf9ICw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7504
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 4, 2022, at 10:58 AM, Alexander Potapenko <glider@google.com> wrot=
e:
>=20
> `struct vmci_event_qp` allocated by qp_notify_peer() contains padding,
> which may carry uninitialized data to the userspace, as observed by
> KMSAN:
>=20
>  BUG: KMSAN: kernel-infoleak in instrument_copy_to_user ./include/linux/i=
nstrumented.h:121
>   instrument_copy_to_user ./include/linux/instrumented.h:121
>   _copy_to_user+0x5f/0xb0 lib/usercopy.c:33
>   copy_to_user ./include/linux/uaccess.h:169
>   vmci_host_do_receive_datagram drivers/misc/vmw_vmci/vmci_host.c:431
>   vmci_host_unlocked_ioctl+0x33d/0x43d0 drivers/misc/vmw_vmci/vmci_host.c=
:925
>   vfs_ioctl fs/ioctl.c:51
>  ...
>=20
>  Uninit was stored to memory at:
>   kmemdup+0x74/0xb0 mm/util.c:131
>   dg_dispatch_as_host drivers/misc/vmw_vmci/vmci_datagram.c:271
>   vmci_datagram_dispatch+0x4f8/0xfc0 drivers/misc/vmw_vmci/vmci_datagram.=
c:339
>   qp_notify_peer+0x19a/0x290 drivers/misc/vmw_vmci/vmci_queue_pair.c:1479
>   qp_broker_attach drivers/misc/vmw_vmci/vmci_queue_pair.c:1662
>   qp_broker_alloc+0x2977/0x2f30 drivers/misc/vmw_vmci/vmci_queue_pair.c:1=
750
>   vmci_qp_broker_alloc+0x96/0xd0 drivers/misc/vmw_vmci/vmci_queue_pair.c:=
1940
>   vmci_host_do_alloc_queuepair drivers/misc/vmw_vmci/vmci_host.c:488
>   vmci_host_unlocked_ioctl+0x24fd/0x43d0 drivers/misc/vmw_vmci/vmci_host.=
c:927
>  ...
>=20
>  Local variable ev created at:
>   qp_notify_peer+0x54/0x290 drivers/misc/vmw_vmci/vmci_queue_pair.c:1456
>   qp_broker_attach drivers/misc/vmw_vmci/vmci_queue_pair.c:1662
>   qp_broker_alloc+0x2977/0x2f30 drivers/misc/vmw_vmci/vmci_queue_pair.c:1=
750
>=20
>  Bytes 28-31 of 48 are uninitialized
>  Memory access of size 48 starts at ffff888035155e00
>  Data copied to user address 0000000020000100
>=20
> Use memset() to prevent the infoleaks.
>=20
> Also speculatively fix qp_notify_peer_local(), which may suffer from the
> same problem.
>=20

Thanks for the fix!

Regards,
Vishnu

> Reported-by: syzbot+39be4da489ed2493ba25@syzkaller.appspotmail.com
> Fixes: 06164d2b72aa ("VMCI: queue pairs implementation.")
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>

> ---
> drivers/misc/vmw_vmci/vmci_queue_pair.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_v=
mci/vmci_queue_pair.c
> index e71068f7759b3..844264e1b88cc 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -854,6 +854,7 @@ static int qp_notify_peer_local(bool attach, struct v=
mci_handle handle)
> 	u32 context_id =3D vmci_get_context_id();
> 	struct vmci_event_qp ev;
>=20
> +	memset(&ev, 0, sizeof(ev));
> 	ev.msg.hdr.dst =3D vmci_make_handle(context_id, VMCI_EVENT_HANDLER);
> 	ev.msg.hdr.src =3D vmci_make_handle(VMCI_HYPERVISOR_CONTEXT_ID,
> 					  VMCI_CONTEXT_RESOURCE_ID);
> @@ -1467,6 +1468,7 @@ static int qp_notify_peer(bool attach,
> 	 * kernel.
> 	 */
>=20
> +	memset(&ev, 0, sizeof(ev));
> 	ev.msg.hdr.dst =3D vmci_make_handle(peer_id, VMCI_EVENT_HANDLER);
> 	ev.msg.hdr.src =3D vmci_make_handle(VMCI_HYPERVISOR_CONTEXT_ID,
> 					  VMCI_CONTEXT_RESOURCE_ID);
> --=20
> 2.38.1.431.g37b22c650d-goog
>=20

