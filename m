Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B836B35C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjCJE4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCJE4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:56:36 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2094.outbound.protection.outlook.com [40.107.114.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD973E91AA;
        Thu,  9 Mar 2023 20:56:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgqfBLhYb4C9MzjvV3wGavM1Bx5CsSdQAalEbv/+4Fou1TwzUkxDTUKiwD+YEw9RnC4l16jroqFHn7wVLIehQK8+yFpGD1XxN6TeRR44aES+Nx6Yp089Wco1y783bgHgpfnarrF90hPfFgyH8vVSn7vtbh5m+ue+Yao7TY40dx2Qs1C8qa+gFAmH3tTZ9RR/cKPc1jvkYX9GVb4bFglDEJkwhTjh0Nab/Ij39SRrmjvceLFMsDvOR1+gfkD2qcnal5A1hrn6fIU92CY9SjEek012M8kfwjUwfxjzS9mL0vn1lXN9mIkAlNZysz0IKE9VCjwXtumR8q+Ijax/Ina/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZd7OINjSoEPEj6kqGhS5GmcoNsY0W6btJnZsLygLBA=;
 b=THWyoKIV5ZjiFReylAyUDmdBxYxd4Yvdo6YKRT1QXUC93sGizeKAWQmBfDIBVvG/kkIdt+97cFCjpNFU4YDfYn/GudOR2lJTvOxjY9qKUh6fhFOlEE+po5YFSkqP/el7zEFd7v73nrX0GZlKX5B3xgIh2CIe+ZAjfpvkZXKKWDMCWPmFP7b4Z+EF+APgL9ay8AsIEAHu2d6yyPTGBbF0SixDl+WbtmFlSyR2FM7pPIw15uh4hzFQBYaRTr+6k8lmsRGwKIa6u1KHnP7p7eBVIymu46yQnKhaPeYV6gwB+ycxMxQZwJC8ED+3mmMbaxDpeCz5n9EkQXN7QoMjs7Ykzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZd7OINjSoEPEj6kqGhS5GmcoNsY0W6btJnZsLygLBA=;
 b=Ng2YJUzW3yzlpBzdP5ai3aN6cTWTEYmp8Az6vl37/yp8pqOfpd3ubu53PY1JgNcAucQkfDS6wkSmYFRf/KmOTCSbkUu04UFN3/XDmgxT4ZBT+NcWU7juPeaazU4Lk8r0+gGUU+Qe346+91gdEWigCC0PLTjzoeuuknwx9EFWHH8=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB8583.jpnprd01.prod.outlook.com
 (2603:1096:400:13a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 04:56:31 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%5]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 04:56:31 +0000
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
Subject: RE: [PATCH]  usb: gadget: udc: renesas_usb3: Fix use after free bug
 in renesas_usb3_remove due to race condition
Thread-Topic: [PATCH]  usb: gadget: udc: renesas_usb3: Fix use after free bug
 in renesas_usb3_remove due to race condition
Thread-Index: AQHZUr39MlZtZyaKY0ew3UxiZBCn+67zcgAw
Date:   Fri, 10 Mar 2023 04:56:31 +0000
Message-ID: <TYBPR01MB53412E8BDBB67C38E0B5E80CD8BA9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230309193020.374950-1-zyytlz.wz@163.com>
In-Reply-To: <20230309193020.374950-1-zyytlz.wz@163.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB8583:EE_
x-ms-office365-filtering-correlation-id: 8ddf461c-b3a0-43e4-8afd-08db2123d0b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5G/nGcLn94GOV4EF2PFQyKO9jSnSqepKfukvffHPcjIYn9LG49hDku0JsnPOEW3C8Q+Hy/kWVpzg2Ae/Qw5yRPjJq7FmRwiBd/Yh8yR3l/JylSH0dvY2XyhgFMdyuKnOp1/sufzgcVANj2ORLY6GbcsaNmDvMEakH8JAg7CW8VzL2yQab2IarIjIaKsKrLfJgSueh8+81DyYpzV4K+feoUGZWeurDgWd55aFOny2kxq7dTTAB3S806DOjuARUosQeN2oqNX4/kyXEZxcewydxf92VYEkxYD5Mb0oq36PrKBQpgU/LRQC56eW9Af7K2o0zBYLcIsyGT8ZekIaSWF6bqGBJUC6oSu71uVnVnsIU7fCQlgHwwemugASR/5fUzb7WhLmEwRGHCl5FjdDkXh7d8T1VQ3lPf5JRtbd0SPEsadv4XI4PZjG2SCyTxe2cAPf+LVs7JGbYXp9eJ5kq0Vmm07HNduJxfku7epvrMVAkg6YB4/PRmbNuTGpXtngBzWzy3bTTw1ljbTwc881NOELOo5d3rfPz2gQtX5wVeGuN0DFGodRL1kURKaMYCI7Ct6OS+AIUArFIRQ/A6/nSO8YTEXMrvyxYihab8Wi1j05qNbsZV89Vt2F7LUHVCapaiDenvHb8pzQxWYjYFiVm1axrSM+RP2WU7G9w9dahuNMMsNeKcG8xwOksRRU9+e4TixotSBFOK0X/HceCfeq+HyIOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199018)(478600001)(86362001)(54906003)(110136005)(33656002)(71200400001)(7696005)(9686003)(186003)(6506007)(26005)(122000001)(55016003)(38070700005)(38100700002)(64756008)(2906002)(52536014)(5660300002)(8936002)(66446008)(66476007)(66556008)(4326008)(41300700001)(8676002)(66946007)(76116006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gJK3J5v11SDF96fkxC3o39fV0CfeR4KDUJiXLPWCd3Ad4kv2QNO30iG0xBTl?=
 =?us-ascii?Q?LIi5POZes5DhK0fsAVlRhmn7UmnsH8g+AAKlKDchVVcd5gTRinnuUekT4owc?=
 =?us-ascii?Q?Wi4i7UM8andi8VF5uHcf+Oug++CSmqkxLDFOoLK7dxmMaq0FMVp5DJMS/1P4?=
 =?us-ascii?Q?K5hbcSYVjK+mdLjqQgeofVzXsTVCcpwnwkYE7rlqX3B5rpwc/hyZXBbhJXOv?=
 =?us-ascii?Q?XW9sK/blBm8+L0CzW9EGxky2XZlG14b7QRW0XEfputSEw/siF65zjaNczXvy?=
 =?us-ascii?Q?EVUbCPOQ4LZIniFEP59dJLtCoO42ZgOyUa4jvgt+Stn+H/ZzM06n/j00WyGX?=
 =?us-ascii?Q?vPRcl2Gi8gwXA3SCkSi7D94HYerp+wEEvvhahooneIcI7DFJVGPCe5D91p4+?=
 =?us-ascii?Q?i8Ne3v6pKGM90bjsVB1jYlmmUovHm/vxHXb/SO8lOAsyULZv1sp0IuIdWgaX?=
 =?us-ascii?Q?ZduzPtMhzf2BQhDyr7Cwf3v9pM6dGjM3P9ftYMWsqsVqYen7WTWSEfXOqHEG?=
 =?us-ascii?Q?wuMZCbGAY55tdQn9VpNPQSJDdTcld7u+Anbx1qq5QgbGQ9DWpAszgQx0d14z?=
 =?us-ascii?Q?gkgGzILhxCbHUCBRFqcIproHOEVJZ8LuCFREGPHCKPMbybelkz2YfU5Mx7Xc?=
 =?us-ascii?Q?PABTv2NRT+wQNQzAKyw9HW+v/OQ6EwcLezNOGMaRuLJ/CUbmqTxMtIeChL7j?=
 =?us-ascii?Q?7IbT8p+/2snC9hK/n09REVU9NTp/UN3KXFdxlOFUxESMjHKpVSElIro5WU7P?=
 =?us-ascii?Q?fsjzm2eIcgBMDLryy5QXgKHqA7ZMKorhEwfUlpgYBp/75v6hzegRNhD6hNJs?=
 =?us-ascii?Q?+yncuOFiSwCjuLXq8ktQfz9kJpkcyu5Q+pgtFajCleyAMpUJtSuU9yM/LUGc?=
 =?us-ascii?Q?jXzoiy01nfTVTKVGM24g/R01zrH7vz40blnisiGtilpqOzirHT4H4RgiSXlt?=
 =?us-ascii?Q?7O6AnjXpfaj6DTJCvi6aVcvLVwEDAVErcKIhSTwSMx8ZxvvEcH1Dly6bvjub?=
 =?us-ascii?Q?gCqGLc74jqTpsXVt+yNAQoAV0nCIMbmSyZDA1HE2NQ4SVd7343EK1ovy2ONn?=
 =?us-ascii?Q?JTRl14LRpYmHujlFDcckIHxJ/n5K6OKzeLcsa1LzGT91I68/M4FyynsrQMOj?=
 =?us-ascii?Q?/+F23SRd22FP+TzjL495hdECCSidMnTTqno2YBCMl90IzdwCJ+pPWnqA85ut?=
 =?us-ascii?Q?LK8kVULlT3zNQD8Hq6IOk8rusp47jH+0lNJgCLEjqqtNfnrS3Q32wt/k2qj+?=
 =?us-ascii?Q?HsrVgIES3XS6RdVa3GQDc5zuePHUHaRKKYcaDTjSBvKjZIPkktbH9IZF1U2f?=
 =?us-ascii?Q?1s4y+oJUNP352FJuJzPHEWpNfdAb/r/7T7U9YLjeYQpFm49rAx7JYExdTDfh?=
 =?us-ascii?Q?9dj7W7bxm+T36c/7Rw8OQ9gee/jQQSugueS6JTPFd6fH3GoGne63DtY/qi80?=
 =?us-ascii?Q?44outWGJNkGgwwU67J3G/0ptDuXr0fVQu5a61QEDSpK/qxDxvuTGT7qD+qEM?=
 =?us-ascii?Q?j2EkSkp5+DFAisKWaqiaLhWtxxG883TARrijaObQBjwoV/gGzFBzCl+L2b3n?=
 =?us-ascii?Q?SNhawtYkdbG2JCwI/rZy7QuaWfqe+z30786Yc8vfUUewztsmVz6C533o+F6h?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddf461c-b3a0-43e4-8afd-08db2123d0b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 04:56:31.2071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/jc2GFD/6pxDtk3P5SQj7/ng1P0Gno4u4UdBi78lgtQThfqNVYL7JdGmho89XMQpbhvfXtXLRsfUZNhsSpjXXi9lM3B2T84M+X8X0f47b8O3GsCo2EsclDBZWd16rr5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8583
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

> From: Zheng Wang, Sent: Friday, March 10, 2023 4:30 AM
>=20
> In renesas_usb3_probe, &usb3->role_work is bound with
> renesas_usb3_role_work. renesas_usb3_start will be called
> to start the work.
>=20
> If we remove the module which will call renesas_usb3_remove
>   to make cleanup, there may be a unfinished work. The possible
>   sequence is as follows:

Thank you for the patch!
I think we should remove double spaces like below. (Also "an" unfinished):

-----
If we remove the module which will call renesas_usb3_remove
to make cleanup, there may be an unfinished work. The possible
sequence is as follows:
-----

> Fix it by canceling the work before cleanup in the renesas_usb3_remove
>=20
> CPU0                  CPUc1

s/CPUc1/CPU1/


>                     |renesas_usb3_role_work
> renesas_usb3_remove      |
> usb_role_switch_unregister  |
> device_unregister   |
> kfree(sw);  	    |
> free usb3->role_sw  |
>                     |   usb_role_switch_set_role
>                     |   //use usb3->role_sw

Adding a blank line here is better, I think.

> Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb=
 role switch")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/usb/gadget/udc/renesas_usb3.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/u=
dc/renesas_usb3.c
> index bee6bceafc4f..23b5f1706d25 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -2658,6 +2658,8 @@ static int renesas_usb3_remove(struct platform_devi=
ce *pdev)
>  {
>  	struct renesas_usb3 *usb3 =3D platform_get_drvdata(pdev);
>=20
> +	cancel_work_sync(&usb3->extcon_work);

IIUC, this work is not related to the issue.
But, what do you think?
If so, adding this should be a separate patch with the following Fixes tag:

Fixes: 3b68e7ca3888 ("usb: gadget: udc: renesas_usb3: add extcon support")

Best regards,
Yoshihiro Shimoda

> +	cancel_work_sync(&usb3->role_work);
>  	debugfs_remove_recursive(usb3->dentry);
>  	device_remove_file(&pdev->dev, &dev_attr_role);
>=20
> --
> 2.25.1

