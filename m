Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6E66B7126
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCMI20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjCMI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:28:18 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2103.outbound.protection.outlook.com [40.107.114.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A8EE07B;
        Mon, 13 Mar 2023 01:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diYX42g7HLp/ThlDPyndmXwlB4Ny4HJl7g8nCssHPAIWlhAg+hfYAJwyv+yxULzj+FsXEZMRbVPIow7hevJlp7VOuK1l3CAJaCD/jdQhG1D+ZSHC00suaZP6PZqYfXtvgAIOOEvnKktLjScOtJkm6tZnO2OSgcsFsgN5fynEYsER6SQWgM6NTwT9h6XsW9i5+jBXSlqsX5ksb6xNBdtcF434D9dvgQeSkH1etJewEvllbp9ZK46i/bDRc29mAbdllQ2MY2INMnPlYnkhWltPdTfeFXf4PCxfXqm6ZE6bQetx82S6/3jSD5Kqkcv/yVetCDoXHFHQI6p+tJzwb7bUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM5R6tSbrJ/EE3oBNtkWG8DH0NRw9fi48+vKxgbLr3g=;
 b=HgHf6s+9H8w27/9QTUkv4bln9zg4Pn0niEWHkdl1U9O53nNiZ8os0TgNADby68eBgUlGQ7RSJhXfFuk8bqDRqtAumfmwwnwvXHGwH45FGxNj5uEci+beJx1iSOzKDSgRz4k1lc5vGCvD8l4+NMI8oise8qr99CBkPL4+PxXcGlGostCPWCSAu3RsciKgN9zPwfghxYoVng0c8N1rAhDnDRqhMam2bK6gkIlBwJR9gG49eYOtSpbJOqosAf1ACgtXqJDzotQAeAaEf3JkCWX/Kv4V5mCdFExG2+yQbG5V5bqHPTcK8c2+U1o0ktYRUfD0KYhD4aTYIKxzf5H0XN6XSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OM5R6tSbrJ/EE3oBNtkWG8DH0NRw9fi48+vKxgbLr3g=;
 b=lk/N1fXWvtO4khDSKTtQHrsNpdINqTtMd6rcGzlfSW1Fg+tJNCXzO1S9IOw5u64fIUX/zazd2W8pq4xriGWxH9wFOiD0x+PsiQzZ0Ou9w4T4skSuaO0sQP8x9G4uQJuecexOMJZZ1xNg9DlavIrIYx+VzjqPDegjgjdhYSEXh/s=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB9310.jpnprd01.prod.outlook.com
 (2603:1096:400:1a2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:28:10 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:28:10 +0000
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
Subject: RE: [PATCH v2] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in  renesas_usb3_remove due to race condition
Thread-Topic: [PATCH v2] usb: gadget: udc: renesas_usb3: Fix use after free
 bug in  renesas_usb3_remove due to race condition
Thread-Index: AQHZVDR2THolCoYEwku28jB5uor0Ta74YeXg
Date:   Mon, 13 Mar 2023 08:28:09 +0000
Message-ID: <TYBPR01MB534196428158C2D79A910E07D8B99@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230311161242.3773432-1-zyytlz.wz@163.com>
In-Reply-To: <20230311161242.3773432-1-zyytlz.wz@163.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB9310:EE_
x-ms-office365-filtering-correlation-id: bf3b9e88-f12c-47c4-ca06-08db239ce108
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RRSHPWZjM9KOK0mDNKccC7toDEHjZBVS2NOHNdG0vlrpsNeLJyI4LsQHbl2G+sofdds59Bach1bKqbUqHexT2hzNh/lWGIEqHWv43Enep3ilylv0CrzxL3vbLDKpZyiyjpu8z2UWOhzgGtSt6oZQyv+13ouDAFJMEU5Mro/7jWJ9AnjUXsGS3C5/KVtgC/skbjOfPK55M/BdtW1SP/mUHnyO3Gjs9e8pJaSxwsnBpLYfPyRw/OcsUU03d1STOX/FPNRXwRjNHou5u+YaihnwDcGMW7gWyT50uVFqkbyy3He0BB7FNdLfZaFi1+itmIRtkkwtIMhutY583S4YkM4iDiy/ntqyf+WAyIWavZZ1OzD/K3TlwnAPXWe1yGE/WO6goCZ6w6WpzfkUqC2m94xVtbvT+c/1cUPH6ClM/ZZ0UhjcyYgdO+sjywrE4lu1Pqo2GheNbslj4PXgARCHDvAk89bJMGgRGaLbzKfCUx5eV6NR7yGclc6orf5/kd/EfQgB8WN/oS27PMF66GruYsQythSpJpD9fJ5cXFKzXky/dMZql/MSXQbAXHaiu9/2g5rtJYVUZv1CWq3p1CaeYgLnSPgELdPkBSczKBzB6+4osEck06aSPkSneLa+aqmS72Tm6kpanruKZZIiSlMdSd0K9pcvE+4VjHMvumcl9nUBGq0+knl/YVSTWvsQS4ejJqhdzNtP8RlfazTiGNJ3Nb4Qyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199018)(86362001)(33656002)(38070700005)(38100700002)(122000001)(2906002)(52536014)(5660300002)(8936002)(55016003)(7696005)(4326008)(6506007)(186003)(83380400001)(9686003)(316002)(110136005)(54906003)(66446008)(66556008)(66476007)(8676002)(66946007)(64756008)(478600001)(71200400001)(76116006)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lY8gNmDa2oigykxvWeM+aOPm08RAq26uYYmhOYWCaSU3GCno/jYiSdVz5a+O?=
 =?us-ascii?Q?AXO9oqAYsx2i5uPGyCnIxisjrNwjdlNvz7Y9zkVrDyOlEMHQ4q//esegV1Nw?=
 =?us-ascii?Q?APuVxp3foCnV/boo7nwxjBpC/v3XsOPR0u/rHuoi2wuJQO2zBFAulnkygaVc?=
 =?us-ascii?Q?c1qXP2Jx8Wl1MCtjpYbFUk4l+4/HEAfNe92uKex67XzEw3qFRKMLSH57qt9S?=
 =?us-ascii?Q?y/8fmu9HAKPOlIATupOk4lIWwLm6jln9vXN7dYFOzNuw8OpDuZSB0AZOEVFU?=
 =?us-ascii?Q?GMRwCjSmj1n0dgzE48kBzMYFZhpdooj4v6fiRMPqvXbC+ZO+k/dqDuMNex4M?=
 =?us-ascii?Q?owDJTk/M3RPzQe9kt8OBEEQwYnnByhmBMTPnJfA3YO2GJBB4MgXeWSwBqMyA?=
 =?us-ascii?Q?i17KDL9QiVUp/Ku1Q5+Vnop2CRnmFoDiY/JxWcTqYoAeGBtp/St2jMTcQnyb?=
 =?us-ascii?Q?xKlBM+R3A49WzhU1SwVWwPtQNy6o210nQGU67NH1nRlJdI8toLKizXca4jds?=
 =?us-ascii?Q?ifxsFleJqihtOXVbaZk2iQsRJFL7feHE63tJRry+Vaao9yNr926bQFPw6FDj?=
 =?us-ascii?Q?I29FaVn+3L47vm+zZQ3q6XAXwmD5EIVi4tmyQ3vb8g0adO99HCZbcekYWSwD?=
 =?us-ascii?Q?6HypIzLHcXNxWiJY2fuKmglfHFgARiGNtYfCUfTTs7I/awJ/SSKBYOowBjLB?=
 =?us-ascii?Q?fBZ4nvfayjsKmCIpuADm++HShTWZfOr53AH9xPiu+TwFr9UbIXaTa5LePcX4?=
 =?us-ascii?Q?pCl/m7w/SNe2DeFhaoSm9nHSlNNgnde4gl+AYgOSD6xTis3bFQSQCIsfTcBj?=
 =?us-ascii?Q?Vo0RjEgtussW+y8JRKxPEYpPdt1kRdLxPHpshI96fKaVWlHK5RVgmocDN0oZ?=
 =?us-ascii?Q?v0EoBTn4wYh1KypDOGVIcdiay9r5czWrk+ekgfGGyJub1pCaZktBcY0au84T?=
 =?us-ascii?Q?r20XqCr0h9Vy2dkgQtdglbUtvoM0fQjF90JIuzXsFi/aTVFHmjU1Q8fTrHl3?=
 =?us-ascii?Q?vuSpVQXnKEepbHuL33LEfpeR8wcbzpy7kImW7+q7g8zPVRqohEHwZ0vTig/x?=
 =?us-ascii?Q?Wslnye67MzJuF9wc3iJxNkgfi+TSn9UaCb8CYogJxgJXchzScP8wfJETgCxv?=
 =?us-ascii?Q?GYN0qiHvdywMYKD0D44+SKV76rU/PMW9oOxK8k4t6EaJfYkapj1A7n32ZTv7?=
 =?us-ascii?Q?7EV4CLjkOnUzXf88bnbH2PgBJxwwOpJxKAn2o9G3f4jnxIB9mSC/8Z49NnLz?=
 =?us-ascii?Q?nm9UMsqzUZDI3rfOn7fHz+zPKRKrN9CvN/pNarwxJindHC6aqpRfiG2qONtE?=
 =?us-ascii?Q?u+N0NtQ6ziZipikRMGe2re8Z+UQX+dDXgcUJKYPDgucYqp+wGckQwSQEnyea?=
 =?us-ascii?Q?CFvnflHL3RngfcjqmCFzv/VTKI7ksreazTqFr5/ckFtSLuYxhDuOFToXWPKT?=
 =?us-ascii?Q?it1R10sndVKKpEv6yR+4tR8ez0mqnTko9hTNJAgWQdETqBwYY1aAjXTYLI1R?=
 =?us-ascii?Q?QBs8yZ9q1+NYh+Cn578R0ePu8UVRAtrzwka4Lc/RijemZvvMr1mrEq/Vc6d9?=
 =?us-ascii?Q?wBGc77xvX67w5/Xba7ROtp/JGKMWf141n5pF6Wb+qOvxA0z+0Z7MAJhD8xCy?=
 =?us-ascii?Q?immTe0RVST2gU2cULymQmQWFPzGhCSlrie4K7EbOMpUkGNhZTFTy9Z/YXINs?=
 =?us-ascii?Q?gQQ6kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3b9e88-f12c-47c4-ca06-08db239ce108
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 08:28:10.0220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9TeiMQV25qbgtV/aJ5s4M+dusNns5vGVm1eCxo4k6pnJGZc3GZHGzjbpx5UaeqpHytyOCJvDO+QosJAN1HFoILjuAGTWDNFx1lhG/ZBHEt/+zbcM8TUZX4NSMn0lF/iS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9310
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

> From: Zheng Wang, Sent: Sunday, March 12, 2023 1:13 AM
>=20
> In renesas_usb3_probe, &usb3->role_work is bound with
> renesas_usb3_role_work. renesas_usb3_start will be called
> to start the work.
>=20
> to make cleanup, there may be an unfinished work. The possible
> sequence is as follows:

Why do you remove the following description on this v2 patch?
-----
If we remove the driver which will call usbhs_remove
-----
I think this description is helpful to understand.

Best regards,
Yoshihiro Shimoda

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
> ---
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

