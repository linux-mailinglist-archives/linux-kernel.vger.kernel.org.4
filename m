Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BEC6B7823
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCMM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCMM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:56:55 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2137.outbound.protection.outlook.com [40.107.114.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D51664D7;
        Mon, 13 Mar 2023 05:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2MT45ZCiBOPzK4EaKjEQH3vWVf0E4gg7B7OZOPhjLJeVR2Q6xFWLc1V5u24huOOE5golxh7geqNP0H61ooUMuqUhmAw3nnbAhhCUl8z3K6zUpIS5GuY+8jzLtuTS/NY+5bxhHRTc/I7ViOyej5CsKz1SRm0iElp9rOOAUYLxIMzK7A263hDFHq315NYMEMMSRn9XiG7STd/q3W2quLIqIRchk76vc3pbFReN/LIMWJy1qKpVWFUt6g02g3l5x7yz6TyynUavfm2L3qUQZ5tILymtCchQmH6gLP3YjeiIJCnYqULqss4plborXEG/oXCVlzwk9CHt9CL4G9pC4EgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmZzhPpPxnFTzolxSVF7Kk0z8z+VZy0beRCWsdiZNtA=;
 b=WqApZX9moObmtBBF+TJrL/dbEVsN010R1NsPHUI4CbYMG/h6qz1FsspTEX8UadwvKd5d3EB/ADwMIf3I345xEpmhAYJ+Rkz/H21lVRBm6t3LfYSTBB7MEuTF5sGUYwFWuRKi5UiaP4RXjsb2EVI9mnT6ylmCTyYSKjpfsMtpLKtuv6kC1FFcyk29Fs6Ac/wNvEaBTkDtOzG/7oCQvNmzzJaClucTeo8uey11uN1Z6FVsUy7498u60SLVMemL+KdEsQeA/kk5K398U5lZN3AFLXfXsH8LxdkLdA7g/GVtDtIuMtCswJo94y6c1zLaEHacZseqVWPB/bj/OrfyJ9XURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmZzhPpPxnFTzolxSVF7Kk0z8z+VZy0beRCWsdiZNtA=;
 b=G6u0yB03W/Li11WU/VFgtOQ5Xn1bXOb6SEGfAXfLyMshzNgnTgQzM/5itq9mHkCV1BPBo1ABBK+kKLNHWmf3hZEwpjgLvIl8vw90U6Vbbo+G6y3VNZho/Nx7AVMJ5KIrxRBD6eRDNN+1HpmMfYSDnongaOicbiQ4wF6FgjCfgrI=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB6250.jpnprd01.prod.outlook.com
 (2603:1096:402:3c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 12:56:48 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 12:56:48 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Zheng Wang <zyytlz.wz@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "phil.edworthy@renesas.com" <phil.edworthy@renesas.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Subject: RE: [PATCH v3] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in  renesas_usb3_remove due to race condition
Thread-Topic: [PATCH v3] usb: gadget: udc: renesas_usb3: Fix use after free
 bug in  renesas_usb3_remove due to race condition
Thread-Index: AQHZVZEdW+W5M3Z71EqjjJv1gN1jx674qyxw
Date:   Mon, 13 Mar 2023 12:56:48 +0000
Message-ID: <TYBPR01MB5341E00031218B3868145C58D8B99@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230313094852.3344288-1-zyytlz.wz@163.com>
In-Reply-To: <20230313094852.3344288-1-zyytlz.wz@163.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB6250:EE_
x-ms-office365-filtering-correlation-id: 62bb4af5-182a-4aad-eda2-08db23c2689b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +8PRqy67vIhKjXUlgt7cz5+Umfu4toHfYQg2Hp5M4NDMKHGFMP71kGrH/d36/R0+gVEpYdT2j6tAudvgcYpfYBXYya6lcsqYaTeC9/GmQSpeCT6Gv98Xzz2+/sO+1zXIW3FxI9jv/u+leQKi31KnqmWlOHHJf33oy1+njivxH8QSUC3Ptg29iTc0crFUjz4fsgqI+S5LreyfL1s+q43pZ8TUFl8wkUlIRXJXXCNQJ7HwaVVvaegwx+XJVJ2kdOMB1wdBAxVbb0jl/6O+KgEAsBGGzc5oTFjIhLrltTcaZNxb60bKEK3LQiW7f720z3opFL52LPqLk4IOnyTcVFiKuamb9KT7E968EyrbAYCjnE9dVqj/itBlWdfriDWIY0qEwJDGNx0Vj7wO1oyg80YD9HXsQY6zDVuJy0SEd3ABOQfxu6Fq9jNt9WiDdLWCp17mUp2ptiWtiGapWb1EbP6Ki1xcoXGRpZgmh1dN8rshUKpEbKRVZGso+acei6rT1TaqyKUuoCnaGQVyDr03X0emj+0J/dTFgPipfsgHfFOPhldc69rm0C4FvnpIsJVssr9aeh5ry1pnmkkDokYs3PAemcz573K3wGeyjoSOpbflZ45FhBeKetgPYI+ll8UPuhxr29Mwlg9PQS6yPh+Gyp8EZaQm59ofItr/HiF3Gwysb/UskLKvbALqIv+HooAU+d5KJvvEX1hsc0TaR6gSobTSwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199018)(186003)(9686003)(6506007)(8936002)(83380400001)(52536014)(38070700005)(38100700002)(5660300002)(64756008)(66446008)(66476007)(66556008)(4326008)(33656002)(8676002)(7696005)(55016003)(71200400001)(2906002)(76116006)(66946007)(41300700001)(122000001)(478600001)(316002)(54906003)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?po15MCCub0SGst02TAA8h4/ULha3ifW6zStFTzUMEvmnreMiWB677w1O4hLE?=
 =?us-ascii?Q?h43B6NQAb2DKW0/b7OHlgW5qJhqan7rZ2WuxFFXkmG6BeswWFBmJ3oRcjpgR?=
 =?us-ascii?Q?jqi9Gd830rcny6xFRrSiJt1K/+F8iCgaE8kx/Y+dj4NbC5bLU9s5dwiMSr0v?=
 =?us-ascii?Q?fpeA599mHZqO5Wozy9TDpzM9URmOuDGMWnOwPJ8LxWSewS9XZaYh6+W25/sh?=
 =?us-ascii?Q?MOJKVrwOL7YCbHfzvvcM01mevOpPx8XRlkYgZLb88YJ+ap2BzAiX2DCqmD+P?=
 =?us-ascii?Q?dotkdAC9glc/AIWdaGFbh91qY+4khM8VLNtAkP5L4iLlAFP39YGEvH/zLErz?=
 =?us-ascii?Q?a4dTRwqt8GFJIdfy3D61OTBTgNcOz0lmgbitsFPd1oqIhBkYjICj4wXu0ikg?=
 =?us-ascii?Q?ZNvcXtuN9dwoLFuiszAKTc2gVLZmU6zXPbtgA2EeFnkRoaAX3EjScO/Pn2AL?=
 =?us-ascii?Q?n3jG0UfKKUgtCjFH1sRcXArPy2V4AudtqTvSlbC//Zz6qbv0X3q4Rb8faRhe?=
 =?us-ascii?Q?MqJyuMBTRElD4I+vRd2G9hI4zsMkKA0Uob/lkCoSvmLEULXFGazW39Ojw5n/?=
 =?us-ascii?Q?b92nTSPVSRdpPgSxIRQt/KcFRwD6Llkg6sVI+CfUW6qjYlZQ+zgrFKAx1p6O?=
 =?us-ascii?Q?kJJG1rH4G/CLMoZ1LfNzYOo6/8whcjnwSfFX3quOAMDaopH0uu2EeaFYHlvj?=
 =?us-ascii?Q?YyITxvd3KVBtvHMHIL/cbGRXW6ZhLCHv1JxThrEp9ObEpm/8MG3nA29i3rfX?=
 =?us-ascii?Q?71sK1uH8XUf/GtmJ7rihifNzO9a7OwPtgJG+s5MYa0szsvGmZ2nfxwukZ6/H?=
 =?us-ascii?Q?+kMnmTvZtMJgaecgSV62pNju2m8eai9P49OA3OLrosWDkdi7fSUWk1YfLYq5?=
 =?us-ascii?Q?U7q5Kz5hrrlYUF3KBkth8h4Mxcua4OQaMgJcxAHgTYsHdPqGyxFTyZpBfZPj?=
 =?us-ascii?Q?KPZFtxmwm2iORoPKx4t9oYy36z4twoK1xJWRGh9VtZW7sbNWKnj0UeXo0FFT?=
 =?us-ascii?Q?08VNlfLxy91l+IzJX9uGPSjvpX8QCCYv7QtsTs5TYjEX6zwy+SzeCD5tlL+K?=
 =?us-ascii?Q?oluhgPMMiX007FLj0QrsX5olUP6vyAd8kz3x59T3gnm07law+Uee5w7sJdEv?=
 =?us-ascii?Q?Q3aPII6/ydfp+MTsMm4SqW1IzHLoXyZzAyjhO+PFk6BnSsK7Wt7Cx6PO4ksv?=
 =?us-ascii?Q?ARDcVf/zxfVH4l5kypQN/TcoeYracSBwvRX7PQl6zGBsFZqHu8N+U0AtkZC/?=
 =?us-ascii?Q?3jeOy14p+0WzLQZiVblyzJVoV/aWyliilVCv+MG0CxNLuLdi5hV2hiZF2dnB?=
 =?us-ascii?Q?CGMuq6LTxWHlqcUWumsbLiBDkSzzGnU7XHUSz34ybC7QdqKPIbzB1wfGnLFA?=
 =?us-ascii?Q?KTVDN4DYPUn6pCCR6sdBu6vTY0aA/4S9QgNtyXfTidsGHXFaX+/o/HSCUAl4?=
 =?us-ascii?Q?AAUpaKKvpG1bgLzn2/t+MR1Rg3LmyVOIIsQMvBes2ihpgrtuUy+N5a6SiEz/?=
 =?us-ascii?Q?AEmGViooOJcu9JOsAJxAkR2QtZWrOZIHqxvPRYvnEbEzqVkw6xQ1s1K59+G7?=
 =?us-ascii?Q?Uktb8+TtEAZZQReRrWrsDPIQryAtO5sCfhVTAtTFV7MswYwdEnWTHMFHy7iW?=
 =?us-ascii?Q?2QrjRENQI4mRoJ3rwbG/REicDQe2UI7ouSXzW9c/U5UuBPZdGymAadhNSIR4?=
 =?us-ascii?Q?HN1lOQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bb4af5-182a-4aad-eda2-08db23c2689b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 12:56:48.8577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJK46aLYiARK8Ba2LFk12NgV3NdR1GkZ3+LIoCIYq9epTYN4eXfpEt76N2bBrapAQrZnu26QBSnG/4TRUr3SkL1rPgRbWNXXbLcv8FxoE4mL9e6kwoFF/msqlmbf8mDc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6250
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

> From: Zheng Wang, Sent: Monday, March 13, 2023 6:49 PM
>=20
> In renesas_usb3_probe, &usb3->role_work is bound with
> renesas_usb3_role_work. renesas_usb3_start will be called
> to start the work.
>=20
> If we remove the driver which will call usbhs_remove, there may be
> an unfinished work. The possible sequence is as follows:
>=20
> Fix it by canceling the work before cleanup in the renesas_usb3_remove
>=20
> CPU0                  CPU1
>=20
>                     |renesas_usb3_role_work
> renesas_usb3_remove |
> usb_role_switch_unregister  |
> device_unregister   |
> kfree(sw)  	     |
> free usb3->role_sw  |
>                     |   usb_role_switch_set_role
>                     |   //use usb3->role_sw
>=20
> Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb=
 role switch")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
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

