Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9636BE91A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCQMUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCQMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:19:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2097.outbound.protection.outlook.com [40.107.113.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B36914220;
        Fri, 17 Mar 2023 05:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgCVcmuy6BwckQ4r6TTfTvwLDncLdYCvGHZaRZ5wBTi+Mon84oxViGbdZhJJJTDxMiXlfkO3EOZ2FYzabos5CdXI4Py7viJkubf5hcVP+OA7VDbVjEHV3fhqNX7iKilAamq/xLPIUCsDb8QQODoSwE7sc9ut8wZEaZXaJtxpWabp/di6O3FT/p112b6k1i1jXUvN1aHHds2LKAmrfjSdVUFvNtXbCcptBJd/DC+6cTJ06d8QxNIA45F7+6tcMRF1GYvp/g4cba5ay1yPuoDHwkFBnPgslasFG/pcSWJPvXmXk6ZDhBk7gD788gkmmWZHOsOfQgInqTn6dXTPwx5ISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CURcBLnaqfKvvZpp9hKaZY7/xGfwu1NZGJWLu2LjXks=;
 b=FOh+Yc75vwlZ0STWb5ErU5BajolwWXcrepMcMCRrVWYrJ5m1vXVkgg1nKFDj2LMkrVdyrafY+9TcsB5i7cJQum03SbBpv0UdvrNk5i4T7fDdDuL/TwHmNlDS4S8pU3v4lgKxwrUKlvSvD2i+bBBGnpgPoGU9NSyGbgzgUMbp9kQchWoJfDSZ0kjEfUZ15mCQAmJi3+GEhJLv/HD9aJHgTGmXLdeW7/DzpPVrAj6UyxEc2msBVtxltX9qiQiuSJKFf95PzJ58Iuj2AJBxkkBJi8VwqvYnivo9V3p7kx76jU9fxKR/QXUgB69iULodVPzuKgcwWZe5xk8S0sJoV7BHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CURcBLnaqfKvvZpp9hKaZY7/xGfwu1NZGJWLu2LjXks=;
 b=H5S7INOC2jMj+24LkZDNhyc299mqikneXVhRJ/f/BkXn7lxAGpMhWXmBJblmIpkFsQe4FH5c2H52vAtmod3dxOYuGe7Prqfl69Ad04br55OZkRfJODRO/VXbdon6c1DvY9+rkyf3pb1SgQi4v/hQoyiMHYlgVJooaM63Af8eIto=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by OS7PR01MB11823.jpnprd01.prod.outlook.com (2603:1096:604:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 12:19:53 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::e342:5c46:e5d3:d8f7]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::e342:5c46:e5d3:d8f7%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 12:19:53 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Zheng Wang <zyytlz.wz@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "phil.edworthy@renesas.com" <phil.edworthy@renesas.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Subject: RE: [PATCH v9] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in  renesas_usb3_remove due to race condition
Thread-Topic: [PATCH v9] usb: gadget: udc: renesas_usb3: Fix use after free
 bug in  renesas_usb3_remove due to race condition
Thread-Index: AQHZWLaq7vZqB9iNWEOEZaM4fcXiLq7+4vTQ
Date:   Fri, 17 Mar 2023 12:19:53 +0000
Message-ID: <OSYPR01MB5334DA88B0881C50E819A19CD8BD9@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230317095505.2599838-1-zyytlz.wz@163.com>
In-Reply-To: <20230317095505.2599838-1-zyytlz.wz@163.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|OS7PR01MB11823:EE_
x-ms-office365-filtering-correlation-id: 837de4fd-db4d-4ba6-1e26-08db26e1e9e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZpEgF7eb9LuH8O5u8wWASLKq8YlQRIOi/uI7gnP0oMrm7QPDJJc4OHL24nB7gS2lb78UtA45mI7TrXAOnM36cLjZHr4npEoUre+zUndFkbGXHoZpd/NevxYCLYr9EJhaqsj2xhrjnxZMG6vy6RJIxvFBP6ukJZWs62Uk93GDTReNdZeGDndYo3JclfjlBMVeVqkL1zaFkpXOakq/VHJlxLdlOwBfE4xCqWed8WPbeq0dhLRV53BEicspNQ0bwQjy6uNgIAuZ6S5zGXnVhc0Hkpa6XMs0B3ajfHJuQ/jOA27hmZyoro3cB6BrdgdyVw/2hb46U70J+zq9mQ/SOTeLfzwWSyv8vLOF5EJJe3KpEq5jHamCcZxJnyf8HZkGpObKuWLfmFyNy2QG+k4Z+DMiXXSgWI5HpFo8oYl50Lk0o8GegaDskRCfDPMuOygoyWrxC1cr3QQOsADQsqYphyj6ieN9jr4gTybBEQXOVLfwglq1GCxxLXeKsPYNWaqNqoCK18hsdXTvm90FPneX9OVAEACUvlcPdJquhyw4CtVdYh/DPkoFEUFm1C8W3okZSAmanGjzwVGSjyxbhwA1RDvlTAFZU/ZOyu/qBFgpFJbuup+BVp7vIh67ujhDzI55zMv3qU/PGe88pC0HfqOIvE5Q/fRbbZeqiksjp4kceAad3U7qBubl9endQrBlZPmdCClq/lhI/Fh4WwJWy26PfXlOkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199018)(52536014)(41300700001)(8936002)(5660300002)(2906002)(122000001)(86362001)(33656002)(38100700002)(478600001)(7696005)(55016003)(76116006)(66946007)(71200400001)(8676002)(64756008)(66556008)(66476007)(66446008)(38070700005)(316002)(4326008)(110136005)(54906003)(83380400001)(9686003)(26005)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3KGGqXFlNZPHalN3MwItDJKiLgMLP/Tt35kB76VXbBYK3GwhAYW3Hh6vdnhO?=
 =?us-ascii?Q?c68ppn1HZc8GzanBqpWhrHYBwfbA1mVie0jFUs6ObCqO2q4+Pity2E63ysw3?=
 =?us-ascii?Q?wlr/8XTbqBxpZvnPaZbK4PNgPCH2q6EbQNNe0WpyO18za2evUJIf9277Do0V?=
 =?us-ascii?Q?Go3mW1NTzDBmcXlz2+GTD+kKCnjExZUj7I9E/YsK14lBgz6plZG7YXyeEBvW?=
 =?us-ascii?Q?HPv4HovYBUPSfRKHEYz5gnoLM920xn7VNcPkW1SoQ6SZs57tlFrDLter2eCA?=
 =?us-ascii?Q?PEOa1Ell4XzoZSaY9g4bpeWtFkgaTf63RDOw9bKWm3g49Yluqj7phYsCOEI4?=
 =?us-ascii?Q?29z/sYgFJnN4yN7AH6aZGuEXRocR3lgUb6wEmDEjrijqMKMMhWedgDzrGbZA?=
 =?us-ascii?Q?UU2D+bvHNE5NCw/31AI5SggmkTyL8wI7RwCpUH0VyHo4PtuH8VHsdHFbqSH/?=
 =?us-ascii?Q?tm/aqgpLtzUy7Y9BA0GCCxVlH3a55AfOhyGFX1lzICmmDLJQhOhVXDAItiAP?=
 =?us-ascii?Q?cZfwHG/n0BLLqB3gr1nn3xRIZHZDbD867gC6iB+L8vOmB/cP8h0BmLN2SiNq?=
 =?us-ascii?Q?uK8IZhHZQ7VfVcISRzcwd8uKjisRNmYt8LLZK02TSN3uWFRlDgMrueu/rsQ9?=
 =?us-ascii?Q?HW3V9ZtaFyBkhxezKYpFeXgtsJYgqzChX8YTdJgJHkhNXEJoufPUjRL3A6iZ?=
 =?us-ascii?Q?TDhxvSj/qADFOXsO+ffydotO3j9BHAGTF07aPH4X04UGs55Qg8aa6+WHm6oA?=
 =?us-ascii?Q?NKJA350bqpnMKN8PQ6h/GozdRRpE7CKftY9ICSh4T6NDFfgmw4eGemMy01YV?=
 =?us-ascii?Q?uax0SbXbPHgZzG0u+jH8/lUR8tnQcA8RfM6VjghMB9sqjGEPO5i1F9Sji+qh?=
 =?us-ascii?Q?GMVbItctFkxrlfW7p4AOR+pXC7jLnUpEpjvTt2IUWPdTkWSzVgADklZPtK8U?=
 =?us-ascii?Q?P1nYNv+jZ3VeVZGalyKr/m2W5xCVWVZ9SLZev5kJrgAa4FJnO9kVjmMfybGS?=
 =?us-ascii?Q?21OpjsvWGNAVAJwvptFR8/F97CuJhm8gnUsMCrxKakZioX2fRBH9YqXhPOrw?=
 =?us-ascii?Q?kP8dts8xGVdv9XD/w33Xcgr5I+xwKRZZAqg533v9W9UYAra4E5sLJF2f16+o?=
 =?us-ascii?Q?vUj3YMZMQLkNd4YncUepcyRMHbXLxK07WfVMDJ2VZe7emZYNkv4gZNRD9hK7?=
 =?us-ascii?Q?V8vaKlEy4u5D2EzWny/dfo00HLbkyttXfnNivQgKZ6ngCPBVGDwuA0OsnmDE?=
 =?us-ascii?Q?Vgq1Ya4xeyv/WF4GPHhaMRspJkWw5i/gPjxme+u2LmqqQzzNj3QeDZdvjkdl?=
 =?us-ascii?Q?xS/oKnThGituWrWo0uubAFV7Ruhn8xuJJ30oPIStJNCB4Fjj8xy91nzEXo+7?=
 =?us-ascii?Q?ZvjzeALoqaTbi3qxMOwlV1xD0omGPP4qkAdxUWLAq10THznApcrThArVkrZP?=
 =?us-ascii?Q?sYsV87iFZ1DIrb5Sv6f+I4q3OISiwOyKZVM8v44DT+F7AppYHF62Z4A2wzCn?=
 =?us-ascii?Q?RniEg6itULTh9SMiJc3ihGt6a7zdz9aXfye4diRCnxoTVPLf4/E4Vcpwl8ho?=
 =?us-ascii?Q?U0jdRKxJsgyJDQAMAfmLez1GYRd9X7mpImKRkzJE1/fqCitMvQLJC0um6EUb?=
 =?us-ascii?Q?UQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837de4fd-db4d-4ba6-1e26-08db26e1e9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 12:19:53.5863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzVhdCWe3BCtRVZ8ya52Sidc9i5uGOIVNxGQrQehE6voTBhgf7N0erAI28bAKwQrFDa4MjYq3lqN6J28/rmyoB4kqZw2BClj2YdxbEs78w3b4pt9ZccYpXbCq4Q/+cAe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11823
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

> From: Zheng Wang <zyytlz.wz@163.com>, Sent: Friday, March 17, 2023 6:55 P=
M
>=20
> In renesas_usb3_probe, role_work is bound with renesas_usb3_role_work.
> renesas_usb3_start will be called to start the work.
>=20
> If we remove the driver which will call usbhs_remove, there may be
> an unfinished work. The possible sequence is as follows:
>=20
> CPU0                  			CPU1
>=20
>                     			 renesas_usb3_role_work
> renesas_usb3_remove
> usb_role_switch_unregister
> device_unregister
> kfree(sw)
> //free usb3->role_sw
>                     			 usb_role_switch_set_role
>                     			 //use usb3->role_sw
>=20
> The usb3->role_sw could be freed under such circumstance and use in usb_r=
ole_switch_set_role.

The checkpatch.pl said:
---
./scripts/checkpatch.pl this.patch
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars p=
er line)
#75:
The usb3->role_sw could be freed under such circumstance and use in usb_rol=
e_switch_set_role.

total: 0 errors, 1 warnings, 7 lines checked
---

> This bug was found by static analysis. And note that removing a driver is=
 a root-only operation, and should never
> happen in normal case. But the attacker can directly remove the device wh=
ich will also triggering remove function.

I think you should fix them about 75 chars per line) too.

And, I don't know why "attacker" is related to this issue.
I think "the root user" is better than "attacker".

Best regards,
Yoshihiro Shimoda

> Fix it by canceling the work before cleanup in the renesas_usb3_remove.
>=20
> Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb=
 role switch")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> v9:
> - append with more information suggested by Greg KH
> v8:
> - replace | with spaces to make line up suggested by Greg KH
> v7:
> - add more details about how the bug was found suggested by Shuah
> v6:
> - beautify the format and add note suggested by Greg KH
> v5:
> - fix typo
> v4:
> - add Reviewed-by label and resubmit v4 suggested by Greg KH
> v3:
> - modify the commit message to make it clearer suggested by Yoshihiro Shi=
moda
> v2:
> - fix typo, use clearer commit message and only cancel the UAF-related wo=
rk suggested by Yoshihiro Shimoda
> ---
>  drivers/usb/gadget/udc/renesas_usb3.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/u=
dc/renesas_usb3.c
> index bee6bceafc4f..a301af66bd91 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -2661,6 +2661,7 @@ static int renesas_usb3_remove(struct platform_devi=
ce *pdev)
>  	debugfs_remove_recursive(usb3->dentry);
>  	device_remove_file(&pdev->dev, &dev_attr_role);
>=20
> +	cancel_work_sync(&usb3->role_work);
>  	usb_role_switch_unregister(usb3->role_sw);
>=20
>  	usb_del_gadget_udc(&usb3->gadget);
> --
> 2.25.1

