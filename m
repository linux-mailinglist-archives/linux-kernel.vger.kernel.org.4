Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEAA5EB69D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiI0BB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiI0BBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:01:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3692F60;
        Mon, 26 Sep 2022 18:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+ZY113CLM5u286eJoj7WqUm/nHdvzCe3oYfoCvAZ8Jx63RrON8FUQ1ulBFNCv+WzDSQy/ZWzHdOjL8e8tTQK1tFVGT59agexYtKaQZyNpMELcbijaNAf04gYcDgGZP/LBWLiVNp1qYAL6AQFpCf16xXQ9RbHQEgPpkUWmt8l5EFN4NIkfbmI0o+cF39KOojmd1c3G8ZsEoDJEcYspOwT3HkpM5c0/tEukSLxNhZm9GmwIDFAHaxZyD/9YPkNBUXo4Xc/iGhPs3nL0RIb3JGoHhHCeqx/6Q996YfMXHouGa484TlQ2QXOdCokhBXzFd678aEORyqJj3hrhbc6+yi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfC1edG1QGgLkt+ja9AJK0CbV82czZLHJg0B4M8OQBw=;
 b=X+Q0vtFlnivSoIN6UrpmJDZ/kW/cN3uPX99ZfCWuYblrZZt6KuRr3/L2nCz10pPvoMqj4gI8pYcbRPggUObzD2bCbPDJak0lbcgORRjJlItbXyAgO4CKLWQvJTtQuzNsuld62TxYMgGBPzAmIjalNq3fdm7l6sr0w189RZOKS/mSt7BuXdIo8KloqLg1cIpbWWQYYJxloxsXhMDE7+64ydzDIH1L3nXTahO64yzKMxhq4W6XHl/1qLQ1IBFXnlrQy1lFmxnVm0Ryb+Tr28bgMNKc+EISly1bbgiPsK5r9HCQbNU9SKIaszzEcZmj5SzDUCIqcvVHho9V6pKI4qL16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfC1edG1QGgLkt+ja9AJK0CbV82czZLHJg0B4M8OQBw=;
 b=YizPJ0KNBeCC2lE+e2A70MNYBTf2A0mrIP+0ONyioHRLX4nO9eVy8lrWIGM23u1j6xeKdK0WQCjh6N6M67P58BGq/LNbD/gwS9gACR0kWylUAqJxY+4U5G0z5p1bUznrqCYsYuLuXpNSWuN5QEn6b21xO9GYNzTl/ZV7tptNu661Se+1KoZRDSu3ZohObHzN4Jc5kJwkw4sFrJUUwgyZU9g+eazZOFVwW5zLuwFgrYUu7CWWJYrwsEkPVo64XNtS+5j2Ha8Nr1t49/57xyDJhZe4+WUAFvxrW7RbFJSC0qlzqloq7fobLhCs6BoZ5iYYqtN2AQkditVXC0tsOi1uWg==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SI2PR06MB5386.apcprd06.prod.outlook.com (2603:1096:4:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 01:01:19 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 01:01:19 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liming Wu <liming.wu@jaguarmicro.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Thread-Topic: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Thread-Index: AQHYz8icdCaFSgSJiUmKEzpcev4wOq3xYiMAgAEXIpA=
Date:   Tue, 27 Sep 2022 01:01:18 +0000
Message-ID: <TY2PR06MB342474BBB331FF36D5DF89C785559@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20220924034854.323-1-angus.chen@jaguarmicro.com>
 <YzFg1H9k+rL34FVj@infradead.org>
In-Reply-To: <YzFg1H9k+rL34FVj@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|SI2PR06MB5386:EE_
x-ms-office365-filtering-correlation-id: 544564f6-fdb3-40dd-4618-08daa023c974
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uEgnSPbEZuIA1OJaI9mUFOzyg0yhxGumNamXNEgvGLV+nb7dpvUW56ItGcyPxsUgLMHEArukx0ko6EM1nFFEtvUXznunE3feUbXDnPFNrCF34fgsLr0HyifYM6BrSI6R3fgsH6sp2FLeq6rVYpR+Yicp7XLuN3Qve5vfWcpQtTY+/vFyU6PjktjysWyDGPt3b5XIdkEVkjtKFM6uwNSOu54vKYe+Kj267FLHkjXa6q27ktIIxi9A+Lzvsa3Dsj+5doUy7FIJxo54ROCwm3EjtE54EaNmzSYWU1qbkV5AA5MLoeaec5Q4gWZcOWU1s2shsCL0/j3W/k2lIkLf0yP2/UrYAEF7gl2wQ1NIa3i0EM2bLyxXvsU+pjj14vU5rTc6n0ntrmA5apmPMOqRoqR3nmBaZfeHSzcImCa7KhMF/HfpOciKVIAOJhLdrC/iZS8ZXowsnLSvSMmHM7uwEVUq0uh+BgvmEEocqg8F8E2HGYsPrqrCTEP7nWl5J9GBmexncHlC2Ax32WPnL+3TnTtwq1FELnZGb/Mdt85HZcxZ4Hm77/M3kF3MzN8T5sm8QfGfMC3SAeykx5UU4SXUaDQgU8igBs5wSWdawcQ1suVkoe/MnNeDhZ8nDxsJCXHJ9osElC0jEh0IW81IQMzBa+z6MId0CcqqQg17AbIndYrgY/vqjIHDbmJ5nV6Xk6Nvu5rLH/nNqPGQe65CGjAlUMEv/63a141MJdMkaDzfCmw0GIAZ3k2AHZeU4SvrLBzOcuVERggy4A3aqwwwqHHC7e1DRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(39840400004)(346002)(396003)(451199015)(478600001)(71200400001)(6506007)(41300700001)(7696005)(83380400001)(9686003)(186003)(5660300002)(2906002)(26005)(30864003)(55016003)(44832011)(52536014)(6916009)(54906003)(64756008)(8936002)(66476007)(66446008)(66556008)(66946007)(76116006)(4326008)(8676002)(316002)(38100700002)(86362001)(38070700005)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VjljdjRsVWhXbmh6MFRmeWpPemhiZzJXa3NMdlgrYmFJTkxZd0gzYkpu?=
 =?iso-2022-jp?B?TzJZUHBueldWcG13RWJWTU94bHowekhSaVVwUU5CbVMzL2w0aHBxMDVs?=
 =?iso-2022-jp?B?c1VqN2NwQk40S1FwUlR2SWI0enhwbmxsSXNOLzYza2k0VEFQTlNMZzNa?=
 =?iso-2022-jp?B?ME5CMGNNY0Z5MU1hbnJzclI4M0hwaXhIT3VLNTlzN0wwbm9URWIwblV1?=
 =?iso-2022-jp?B?aGprQTBvUFNFelJhMHphRDlsTHlReVhnbnRyd05SMUhiZitKS1VCbnVs?=
 =?iso-2022-jp?B?Z05zZmFPRysyR2FDSms1dmw5TzdwWjYwNTN6M2RVaHk3bVRkZjFMYm5J?=
 =?iso-2022-jp?B?SWU3RklEeWcwUkpYS2FuV2ljV3J0TEh3dTZzNDY2dUkydEx5ZmxlYkxo?=
 =?iso-2022-jp?B?M1BxUjVQNk02dHExVkJOamlWWHVIOEU5ckIrckpma0xqMHJwbHhlQ3gy?=
 =?iso-2022-jp?B?dlU0ZzQxUnJCUTVYL0wwQUQrdEdPakVaOUdNSkxvb2pMZzVJUm9NODZu?=
 =?iso-2022-jp?B?bVBwWE5QT3UyNG9saDVXYXl2WHJTRjRmTVJqcnlRQjYycitUY3JPQzR0?=
 =?iso-2022-jp?B?V0t3R2JNTzJ6UlFLZkJKY1pEWVFZeXVNZ3dRMTRXRUkxWkR1aEpJZXln?=
 =?iso-2022-jp?B?enJReDd1MGd6NHd4QzVXbHhNL0FYRnJocHBmOWg4b29DWVRncDVaMGZG?=
 =?iso-2022-jp?B?TlNSZm5GVzlaMXY1Y1RGcHc5bEJnY2s2OHo0T3U0SE4rKzRnRVlUUld3?=
 =?iso-2022-jp?B?VXp2dUhyVHBRZnlwNnJhSlM3NjRTR0hXQWV1TlNWZnUrYlE3VU5XWGRz?=
 =?iso-2022-jp?B?NDJBZTRnVlU2VGFMejNEdWVzSXVpdnJiN01INi9Vek40ZVRVSythN3c1?=
 =?iso-2022-jp?B?aEdINmxwdnE5QStyWEFkWUpIbm5wcGVjdC9jL1NvZ1dkYlpZcHF1V1Bh?=
 =?iso-2022-jp?B?WGMvL0dTTXNheFk1amhxcG52LzRHdEplajBybU9tTUwwMEl5RWRQbXA5?=
 =?iso-2022-jp?B?bmdQdER3ZkRTK2VRcTFFcE1xZDVIOXh3d2FtaDJnQkw5YWtnbnVyUllv?=
 =?iso-2022-jp?B?OCt4bXp6VDJLbmUzNTZPZUs0V2lMeENRa3AycVZLaUdkY0w5eEJvUksx?=
 =?iso-2022-jp?B?NzRISTlGcktkSFp0YnQ3VElNK1JyU3YwbGcwZ1IySUJXUkxFMTdYSHhV?=
 =?iso-2022-jp?B?d0x1ZXBkVHVvQUpZRGgrOUIrazY3Q1hFS200cWQxaW1FZVc3blU1UVA3?=
 =?iso-2022-jp?B?SjV5aGhLK05nWE5zeGROK2lQc1R6ZFM1a1FJL2JaZ1ZDYWtzVkc0Qk9H?=
 =?iso-2022-jp?B?bUdyMTF1cWNHaU8veEJTYXlXeEhUem14UE5HNlJkWVNvZzFxNkplRG5E?=
 =?iso-2022-jp?B?TUMzZ1ZvRHFFVkhrWW5DKzYvWWExamYreGtjcnRDVkxrWTFvUEM5VU4w?=
 =?iso-2022-jp?B?TGcvaEU3cEdjelhucFlIam9GNDNqZTRXTHJIcktXSEk4V0xPM2dQaVVP?=
 =?iso-2022-jp?B?ZEV6VXZRZzNIM3E2RFRtaDc2VFBIeVUzRkozWEpOZlpQc3ZTaWljYSs0?=
 =?iso-2022-jp?B?S1dNa3R6WFZNa1ZIMHJ0czcvcFBldGYwTWlPQ016eXIwM0I5Y2NVdzYz?=
 =?iso-2022-jp?B?QnZMOTZDMzVwS1EycmZsUGpSNHFYRGo0Z09jc1hRWHVsWE8rVXRWQlRC?=
 =?iso-2022-jp?B?N1lWZzlTdGtJaXJodDNPT0RVZXg2UGs4VGVIY3lHd29GSW13V0xhSVVp?=
 =?iso-2022-jp?B?LzVtRjdSUVd6Ylh5UGFDNGhoOTFURVRYa1NlM21ObzFnUkxlaGVtYXU1?=
 =?iso-2022-jp?B?eXZIQzVDa1NjYVE2c3NHVjFxa1lzWldkeUJUR1J3alpjc2krOVQvRjlk?=
 =?iso-2022-jp?B?N0UvaEd3MkVhUzV6ZWVuVTU3TWpVT3JxNVRvWSsxN2d6ZmJLMkFyN3JQ?=
 =?iso-2022-jp?B?NUtJeGhHOEgxejhHdXNvNGtqSk1MMGxYTU1Ta0s5OTdTeVpTRDdhTm5R?=
 =?iso-2022-jp?B?dS9iNHVreVFpL0VrbTVwclpRSkxoaUZWUlFmT0lUZnNlRVBGVTVQaERs?=
 =?iso-2022-jp?B?WXdheFNYVWMzMGI2S080YlZucjBPVVVxOEJaMG9VSGxiNlVPTk9SNUpt?=
 =?iso-2022-jp?B?Yzd6UWxsSmpXV1k3eXVLVHBqSlNET0NBNCs4Z2NuRzZSdU53Y3piV29K?=
 =?iso-2022-jp?B?dzRnUXBJeTFxVXhTaU1LWFdlZFdYZ1Ewbi9VVDlqSDJneG84bWJNdllD?=
 =?iso-2022-jp?B?bWQ1Z2NUeGdtMnVCNFRpL0N2clB3eG5GeTNHUUpldnUzSENTKzh2UHhz?=
 =?iso-2022-jp?B?eW8wOA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544564f6-fdb3-40dd-4618-08daa023c974
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 01:01:19.0017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9Nam5Av9lTg32EX4xqmvPEPIvwq/fBTTB85QFEa+7rHxoSujiX/FQRogQ4iMg8O9dRZRtZef9MW9u2mP3fiK3GJln2gPn65RSxqD5uXZh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Sat, Sep 24, 2022 at 11:48:54AM +0800, Angus Chen wrote:
> > The background is that we use dpu in cloud computing,the arch is x86,80
> > cores.We will have a lots of virtio devices,like 512 or more.
> > When we probe about 200 virtio_blk devices,it will fail and
> > the stack is print as follows:
>=20
> I don't think managed irqs are your problem here, but only a symptom.
> Why is the timer irq allowed to be shared with PCI irqs to start with?
>=20
Thanks=1B$B!$=1B(Bbecause the virtio_net devices we realized is just supppr=
t msix,not support intx irq.
So the intx irq is zero by default.
Even if we have initialized the intx,we will fail also if the irq capacity =
is exhausted.

The function vp_find_vqs use msix to init first.=20

/* the config->find_vqs() implementation */
int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
        struct virtqueue *vqs[], vq_callback_t *callbacks[],
        const char * const names[], const bool *ctx,
        struct irq_affinity *desc)
{
    int err;

    /* Try MSI-X with one vector per queue. */
    err =3D vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, =
desc);
    if (!err)
        return 0;
    /* Fallback: MSI-X with one vector for config, one shared for queues. *=
/
    err =3D vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,=
 desc);
    if (!err)
        return 0;
    /* Finally fall back to regular interrupts. */
    return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
}

So I think the key resson is one virtio_blk device use 80 irqs capacity if =
it use automatic IRQ affinity.

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
> >
> ---end quoted text---
