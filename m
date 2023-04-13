Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3ED6E0D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjDMMUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDMMTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:19:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B65F59ED;
        Thu, 13 Apr 2023 05:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baL34Ycg+ruWpFgre4B+Wtq7xkUhyBeIurBkZvP7/1RvXBtE9qX8BpxjY/pp2C0gtizR2GQ2g2MoYxjEz3+0PX5itlmE137icVWayaAMHPBplrk6b282bObxS6CdQbLtz2y2DWrsswB6WZt2Iwmf6o2wi0TU9lpgOEHPQtUSYTdC7ZKnrwjSNImaUYfMSyYM+xE/zmWM6Jeq4ZddoIaDK2dlBTlChIfNg1akDAFxdDtB0QPyXJJ++rroBL9jvuhVha9eEzyUKfF9q730d7i5fos2D3OwFj6zxhLJpD4dLAMC0Atl80rNLVHF/OY4ZrBs/U9QeehopQNuG1WWiTQ4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTp6zH9eSlPzu+4y7fHNMQsNRk8XCzcWq4wog8jb0Xw=;
 b=Mk3qjAJZofzv6m0VopbCLEgowKjco4SkMDbmz6EOOdcC98rFRs7LAKRPl4d7qVQd7Yp2t727rJ/ZtB+Augo8CAc2tWXxY9zjmYa1UDuJncFx7nq7cAEcMZtG8bR/zeWL9oVnnOLycCDaJvjqD9QpO7KtnT5EujLH2PsdBdcMQVI3Xu46dNj2mNu/gCSjpch2zb8ANtcWL0RgVClPRJ9zF/UI4USGcvHX1jKTb5+a+lT3EBLYMv2TmSgRPB8TsF4n712lIqxRGmTqK8GHJoxozPHKmaqHMyd64zM9JByUSVhS6CGNR92cbiYT9CIMVLwpEIb3rnG4+S+gCMy8/demhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTp6zH9eSlPzu+4y7fHNMQsNRk8XCzcWq4wog8jb0Xw=;
 b=biDPU28WklldxuG20E0DvcVR9LwWZyuCplrq7cPHRjHeQQPFQaIfhhy9e4C/HH/I1Nq3I+L5kjuoLo5mSFAU+nRtXMzmJUtZgw7bYasDPUiGq9qn8BZ0J6QjLD/coztCLIeLAcBeFMesgIvie71znNdMA66jdNRQhjELD+bq+Z0=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11689.jpnprd01.prod.outlook.com
 (2603:1096:400:372::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 12:19:44 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 12:19:44 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Zheng Wang <zyytlz.wz@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Subject: RE: [RESEND PATCH] usb: renesas_usbhs: Fix use after free bug in
 usbhs_remove due to race condition
Thread-Topic: [RESEND PATCH] usb: renesas_usbhs: Fix use after free bug in
 usbhs_remove due to race condition
Thread-Index: AQHZbdydGLUAyDfN4E2IecDn5BDiuq8pJMhQ
Date:   Thu, 13 Apr 2023 12:19:44 +0000
Message-ID: <TYBPR01MB5341FED435E5533E4B60B10CD8989@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230413074926.239605-1-zyytlz.wz@163.com>
In-Reply-To: <20230413074926.239605-1-zyytlz.wz@163.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11689:EE_
x-ms-office365-filtering-correlation-id: cd199afc-2e97-4b39-86c6-08db3c195dc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TpuvtZZY3XAG/vtjPXqGim5LmJRx9VzyRrZbDkdxb3UF5J0FdqMUSH+47QxHu562Z88Xw9PD+GeK3gFtGeicTA0ZkfgCNYEets6gGHwmIZkF0BlStc4nZUmdxF/DzFld8TN5sCmKKJKpjofYAOXk7b9u0PfsoxoAwA2YZ5AsxmaT91wfWAv84DlxD5rJfCcG41MPx2oQaS39OgIG0EnCkb80KdtKD4mUwYuY/KVlV5u6rLjoPN9OBfdGP9ixwyp6PZqZwc/Dk5ZUzSFNrzDPtl4zhMqAZUJpgA90VKXUMcVyACeepABC6GMu8UWAKED4Iuk1Wg9yqCaNxxZhWeAU+DFh0/3JItvJiE47SMwzo0W5nQNalKa+kwjvrt9k93x/hwcsgbWTWiguWxq7KlQadF4rFYUO80dpc1CQQBAsQScthkZabl6epIWT0T8HoT2klM6szK3J7DPRP81Z6+JjoO5OD0DpglUZuuSBU8h8DIM5AOyTiisCkaAAv2nJNS7XPOn3kTDstLdV28BJGfhKBraaYm+4DgbjyY+l0Pge1cwwdQ8DiPwFsXENwm0s2J9uINuriGITQV9cJuXRHKjniLBeMJBMMtbk/QfBCqXyyI4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(316002)(38100700002)(4326008)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(5660300002)(41300700001)(52536014)(7696005)(71200400001)(966005)(86362001)(54906003)(6506007)(186003)(9686003)(38070700005)(2906002)(8676002)(8936002)(55016003)(478600001)(33656002)(122000001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L7sQtPepsaxS+jn8O8etH2oX4ZOS9JIKvjclNJZY+R+mS78wH1YmuDJamIvK?=
 =?us-ascii?Q?RcBmNxq3pun7XIPFSat6EljlEh31IihrTn76MVQsBg2PylAxgJi0oAAVFQOZ?=
 =?us-ascii?Q?DbhO2GWKsQhXvaCBpXOCno2MSmGlTXqnZ2NFhpxc0pAVUYkQasJ5U97lRf4M?=
 =?us-ascii?Q?FcEKr1waumCk53YLJvU/a3gABRVT+v8t3QMA6UnfcrkTWKHgfTu0Zpam/BGt?=
 =?us-ascii?Q?YJFfiWWx1S6EDlnJQPXQ0//q0uuIjBz+DEYfkEBCt/XrrgO5jPgTQXDPILNk?=
 =?us-ascii?Q?A3eRP05OyzjIIdHjAAEBLmtuks/TWSgK5HEOZDhuOmgWMX2YUlSe+iFamXQh?=
 =?us-ascii?Q?4IYASs6mgxeryqtPyK/B5RJssOISPOqtB/komem5qBfj2SYRL5ZV0rIRCqsd?=
 =?us-ascii?Q?OouMFmAiXdLNn5M6meId29N/jYbhI9rZI+JWOJZ0Ihm7TBtXMxGp6eONjJ7h?=
 =?us-ascii?Q?BEbb+dY4EfikL14kwPZxUAfYRCv86bJcYRkConjvhKGfBi82uqXdLl0Rg7RT?=
 =?us-ascii?Q?mQyEjA9HWxAfhmEx0hHG3osJqiHPN2fOkugvlcQOzVFWyrLJpeSyEJIEc9Jd?=
 =?us-ascii?Q?WqseCqr0VKUXP5s8RYB5+xvsTxP+v7WJ1UT+/x2IW0sqpelg4GE7gDwF7r4p?=
 =?us-ascii?Q?64AZD1ysit6SPNByPffvViry0Tw46smIEyJAnVRIHuHvC3Up38YCzpP7IG1S?=
 =?us-ascii?Q?3OtvCkaS84/64cFf+Zb11qmS53jspb4ZG4Xdw/LUxanlkDfNu8iHTep0PuX0?=
 =?us-ascii?Q?sX6+wWOP5zxCpS34w1TROWPXm2J2zCSo23R5WJBCAcRmtiTjrSjzUKAcpAkF?=
 =?us-ascii?Q?TG6yUFnmT0k+UZrgfjfzLCxc4metG9UR5SSSKP3DS4wzw9VBERHGqjZ37ScF?=
 =?us-ascii?Q?7vD/wUT82NiWn+d7ndrWpN3rr0qHld2vixoieUc12UNh4L8VcOHCjzWgDSG1?=
 =?us-ascii?Q?zcY0ozb16oBOff9etXGg98g2nuiHL+Mnof38cUkxQsPk8bX7g674qZBPQlGE?=
 =?us-ascii?Q?ORZNjpeP4m/+2eYGr5B6bGJBgGVU1uuIdcQM+hAb+JwAq92z2RuLYhZoZRh3?=
 =?us-ascii?Q?vAlqQ17a77weSaZemAvw67nQmp1yidewDnGqjbCkeC8PObuFtNn6vhInozrz?=
 =?us-ascii?Q?JfXZkkdINApphfip/ej3hiFXo5Ia3N+KK173U4Mn/1sc/EhGrwb4d6X4g3k1?=
 =?us-ascii?Q?ulnDk553scm1JmNXubLEUKpx5OPBmO4MmhliNJ9x0Hrlq3RylSjTVlOv6viS?=
 =?us-ascii?Q?9QVg7ZrYtJdGt44JOBJ2K0AczvWbujCfmxPo8q5auufKKy5JQeQ57bPmx88I?=
 =?us-ascii?Q?N47NbPjxyjjSzePyvM9jfvmQiH01ZEIYy+1gYlJ/Hg9ifbfbOBRV2y7I5xRX?=
 =?us-ascii?Q?zP6cHFh6t9HhuObOSu7DDJjqomOs+n9oUKlY2SbPG0BvK/QqGr8QyZBgCu/n?=
 =?us-ascii?Q?8uoZO+LQi8KAQ7QXTNBhidrBKrlcIZ03wsk5KijX0LVRX+2OSiLJUNhH/74J?=
 =?us-ascii?Q?7kFPYTPkPGp+PogDAjz4ZYgLYQJrIisVvnjsgsLvwwaRR7L6YuIS7qIynqps?=
 =?us-ascii?Q?R9LA0RyFgvENt9RtP5CAE8P3Jnf8RQmI/93wLsDinpCwbcqjjcS2iJygr249?=
 =?us-ascii?Q?qeeCugBrnJAPY2vww58g1N4gd41L9W5xxu4NYdzvJtpQW9LT4w9aY7qlRsZ3?=
 =?us-ascii?Q?a7sAtQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd199afc-2e97-4b39-86c6-08db3c195dc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 12:19:44.7279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5SnbuoF8Kwm/WKWK/AUJaG17THowktMVQuUrvqMhJXLCCWE1xC8iJTg11QYPXefrd09x6MRqIE29+GHbwOehT0Gq7ZRlpAy3ubL9CPJntPmtwxNboiunt7dwQsNZi0K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Zheng Wang, Sent: Thursday, April 13, 2023 4:49 PM
>=20
> In usbhs_probe, &priv->notify_hotplug_work is bound with
> usbhsc_notify_hotplug. It will be started then.
>=20
> If we remove the driver which will call usbhs_remove
>   to make cleanup, there may be a unfinished work.
>=20
> The possible sequence is as follows:
>=20
> Fix it by finishing the work before cleanup in the usbhs_remove
>=20
> CPU0                  CPU1
>=20
>                     |usbhsc_notify_hotplug
> usbhs_remove         |
> usbhs_mod_remove     |
> usbhs_mod_gadget_remove|
> kfree(gpriv);       |
>                     |usbhsc_hotplug
>                     |usbhs_mod_call start
>                     |usbhsg_start
>                     |usbhsg_try_start
>                     |//use gpriv

Thank you for the patch!

You should adjust the figure like followings because Greg mentioned it on o=
ther patch [1].
-----
CPU0                      CPU1

                        | usbhsc_notify_hotplug
usbhs_remove            |
usbhs_mod_remove        |
usbhs_mod_gadget_remove |
kfree(gpriv);           |
                        | usbhsc_hotplug
                        | usbhs_mod_call start
                        | usbhsg_start
                        | usbhsg_try_start
                        | //use gpriv
-----

[1]
https://lore.kernel.org/lkml/ZBNCam0XjWehrF3c@kroah.com/

Best regards,
Yoshihiro Shimoda

> Fixes: bc57381e6347 ("usb: renesas_usbhs: use delayed_work instead of wor=
k_struct")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/usb/renesas_usbhs/common.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usb=
hs/common.c
> index 96f3939a65e2..17a0987ef4f5 100644
> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c
> @@ -768,6 +768,7 @@ static int usbhs_remove(struct platform_device *pdev)
>=20
>  	dev_dbg(&pdev->dev, "usb remove\n");
>=20
> +	cancel_delayed_work_sync(&priv->notify_hotplug_work);
>  	/* power off */
>  	if (!usbhs_get_dparam(priv, runtime_pwctrl))
>  		usbhsc_power_ctrl(priv, 0);
> --
> 2.25.1

