Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55FF714769
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjE2Jrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjE2Jrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:47:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454BDDE;
        Mon, 29 May 2023 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685353635; x=1716889635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8D8e840ueqqpISZ3nYz+Nq8Ot6uq+GjsuUKQXDbWiWI=;
  b=kueVZIlF7N92YOSg4LDkn4djLXImpp5a+myllgWKPKNpZicg7BYHbD1Z
   884KWbQ61dkboEdb/PeJ87v/m6pok/xvM4tbIVZGFPfZgFyHDOp7BbcTi
   yCR7GfijZIQsYezBAPvmb2+1Foy9nppKhrhoT4WjNi2S3+X/LM5Ivr2ea
   jklpZo7Q1USNBcicMO5VsHhMhWOTMEcMo/3Lac/bP0idHPip6seO8qoAF
   BzK4k7i6w5UvXNt7rhJqsnMNuWITz7byrOVtqndZJRudiQ31rmik5ETQn
   v0BABP2cf/FlIr0uXf80YXt8+zfp3wGRTlTZVvfCSqan8Ww8N7xmFmNhC
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="217764703"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 02:47:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 02:47:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 02:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eyb2iNgxNafvDqOArlMYGDHsZbOZ22Kvbem+kd67byoEcaqCGcRJ2FZrgSoBczvESz5/Y70FYMPgKgDHjVKMJvzfnexYPCZX7IIywsf6i1WIJntZDhDLkxcIYBKA7qr9yEFBScxZZOBr4QRkya1Uz3iEku+OsQtMdxBPHMk7oVtQmJRms1Hxu69uV8fuEwQG0dLoWwHU/aKMCDUnZ0WcWgRtrJ8/VvpSjHYVBVHIV7wTmbhMYcOHz53g9vh/Wqfo9Rw2lhgLaQriYnBNKoUSvMa8BvdNOgKRx3P65bfEliwGw5vlo8vgIVsUStuA0Bw6ONLF2KJKJB5pVw0Sk1G1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8LS9IuaovTSZ2T7Rdn+e2EYBDFV5HBLxw9REVrsUew=;
 b=HAFB4fwCcoe0LvqyHfxtIVPjBurJ0vEbhiTvNQv5SDd8Y2MtEDh7C8nSsmEu/GEqkzEy6rTRQadhnmp89iDS2pYrJI2mjk3ofniA3rL/qNViqID+slvkUWfBPHt6GbnJ03aeh1B6K50AC1/G45fYywHiG+37ytmwTJoWldBHsoVnbstaTBrYalBXN9cEtvKDhoqlaxcY93HcmvlFlqGIh7JVIkZFM988s+GZ8uS7W4LVR7bjDmhfg+T+zeRQCDxiv4YuY/utIAYnMlvlHTXV/EGEzoj6JGN30CwwsxKBTpvKi0IQ4rMJB1MzMEJv7dI/MMZ1ZAo0aI+3XOdHLGvTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8LS9IuaovTSZ2T7Rdn+e2EYBDFV5HBLxw9REVrsUew=;
 b=uBz4ev61JFOC/oKIrqJA2hpojbozuOvbCHVXWQ6KoxNgsC0NFMLmiEo1YVeIAReDe1C499VDZLw5VFCznDQFacHRssGjDTx0ivdnogwF00SHe4M902caRxDJ8KUvWg3RVGiww94plkuyfNPho83Fwi2SR+4nA8OgZkwm1btLxuo=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by LV2PR11MB5998.namprd11.prod.outlook.com (2603:10b6:408:17e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:47:10 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::1706:e90d:6498:57af]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::1706:e90d:6498:57af%5]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 09:47:10 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <harshit.m.mogalapalli@oracle.com>
CC:     <error27@gmail.com>, <dan.carpenter@linaro.org>,
        <kernel-janitors@vger.kernel.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <VaibhaavRam.TL@microchip.com>
Subject: RE: [PATCH] misc: microchip: pci1xxxx: Fix error handling in
 gp_aux_bus_probe()
Thread-Topic: [PATCH] misc: microchip: pci1xxxx: Fix error handling in
 gp_aux_bus_probe()
Thread-Index: AQHZiaaShOw8rdGJgk+41GVNKCKV4q9xD/Zg
Date:   Mon, 29 May 2023 09:47:09 +0000
Message-ID: <BN8PR11MB366842432B7B3564E491AFC2E94A9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20230518163333.1355445-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230518163333.1355445-1-harshit.m.mogalapalli@oracle.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|LV2PR11MB5998:EE_
x-ms-office365-filtering-correlation-id: aeff5121-0785-44b7-ffa8-08db6029ac19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yhogAJ5q7TFBRsgDlcdeke0eFSOeu5MdKzA6iLAh/Lsu4s0lxCUGOsrM/QvCJ9WYR2NXvI66dWnkDRKARAP8jAcZhFslmIwTfHGIcEin8hRa2x3UMPRhmBHg1nUwQtLefTdlaitQJdwnvMPb8rLTX+HfaVKII3AUHgrJ9SMuCr2Dn4Lx2TOYT1SFnD7FgIYLHworNmO/IAyCyRktIc+OJ/xU2we95KaiyaFzNcDzXbhfQqEtVzBEnb1QboP4uZigkYe+qslRn3ag7iJ8kzYQ0Gbj0dEjP8OHTO2KXQIGs5gl5cC/etdREWDiksAzF/9O6yQvyA8wAUNECFBcBLjZ/S01ucSkTPQqBQiZzyCkzD70BsvD/efjWXByFLJpqdLq6BWumjBb7N/kW4JFdx2OIlM3J9QKn92UxzcDCOgB3RIu1uFYPqqfJ+LwiZSOr20xloFgWaAJS0vBpqW5eMDHIjUud4B3Jvssjn+1hL777QtlB5BM9FS2qrlo+oZz1xRb6dDIlTG/RnctzG7xjEywnCS/KLIum+6dRsbI1gOEdDbmFeOqrKBbemfzPTCjQh/ETTWfh0MyrRmeW/+nOpmECzmL5H2yCAocDIwJzAiVGYAT06L1oGa4hZWZjQNyjZINCAgy4+Mrj36qnhDI+g/XqruozXW1g8u86Vwqr9ylpPraV4Y7hXjQ19G4IUI/JzxgivYFDfHgRbOUqQEQ7T7c6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(38100700002)(122000001)(41300700001)(38070700005)(316002)(6916009)(4326008)(33656002)(71200400001)(86362001)(8676002)(8936002)(2906002)(7696005)(52536014)(107886003)(66946007)(76116006)(9686003)(66446008)(66556008)(66476007)(64756008)(54906003)(6506007)(26005)(83380400001)(478600001)(5660300002)(186003)(55016003)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZnOAHfRO+X7NOcLp5YKvorfFsgxWALmAfZXy0pwBBvnYEpk/cvDKfUf46paP?=
 =?us-ascii?Q?pt+6LnjWQ9lNJ2a+A0LaPfqfnB7yyPHjCnVo3wF/VqQu02ZVzPRIEcmRqKGw?=
 =?us-ascii?Q?wEns/Aofo0H5i04i/Fopq0B8iXGt51ij6mR+XaErpxRW7wXCVLkOMAZc/6X8?=
 =?us-ascii?Q?sjplXW/miO/J2pGixo1O/cSE3S+1Qkr3wo7VamUmyPEPzm6Eow3Zxin77ivj?=
 =?us-ascii?Q?N95Fo126DQDsnvWR3rvxCFsWxBYi8AgkK9pJoA1muwELcFgZHiW8oh59GOFn?=
 =?us-ascii?Q?bGD5MUXa8yiWLfMgGx1v2YtL4dscn2PYPAuV/4RHiwk4EpxozAShhCW4Fogo?=
 =?us-ascii?Q?y7TCnPQHEkhE/Z9Bg4NH3Qh7pLr28ahccCpfiNXK/4+xMmtqCt3sni4oPy76?=
 =?us-ascii?Q?8rgq9dMeLCCLrKXr4jex8J5IAV6t9YF0kTdkzCOFMKDiq1tkWvYY01hWR/ur?=
 =?us-ascii?Q?CUDfQU64Bnz53LaM7KciL7gImsQ9TqMYD8OwUi3/2eS2XC945pbwT9wXMpwg?=
 =?us-ascii?Q?uZkYOO77udKPW5ZrdRnBmKbaPg3rVjvgdRLrhWZCpsFWvqnpx9HYFCFHfDc6?=
 =?us-ascii?Q?SjxTemIxyHKrI0MutTu5PWw4TL4LQYOpJXuS/L2wW3GVi9hGiF7VhZy8g/5z?=
 =?us-ascii?Q?BnLEC1Rl6R3UOuxOnuiIeadbh8OGRlqAcDIrOCZ288dQcSR8UbQRi0q1iCKT?=
 =?us-ascii?Q?o/ysVUeutP9ALsafEB7P58Z8H/wD8MwCVqPd70zCeyoOIC7wiBpbozvRZzNA?=
 =?us-ascii?Q?zrkizfniqKgwQjrpzC3P5P6/UWvDYJm0PB8nsqhbWSCD+hadsNHID6WPvHwd?=
 =?us-ascii?Q?bt9P4f+/U8iSa8mULIvCk63A3QmTLeXSHR+AIv1XjvmE3GTywpI/zVMB83EZ?=
 =?us-ascii?Q?bFbjdYm8fROQ22PcuenA+R3dBWb6Qw3bpAMY1WXo2Ro3bu/W7efWOM1Gw07g?=
 =?us-ascii?Q?Wmhm2peBv9aWYcLZ5KD391UMJwvwCkHbb8PwGmpHvN1lQxbbZvAYKn+w1vYT?=
 =?us-ascii?Q?2SbicL5hM5H33A/v5Ft92biYL628e5CwKkjjlcpVBs2DCXCF/Y8FC5GmYaJj?=
 =?us-ascii?Q?lt9uyIQme/zxoccktS4AHOShO1o4yiN45orTRYkILGJykpokNPm483/xrH28?=
 =?us-ascii?Q?s1ktTPx5YZQYMyI+bm/m//vhIR5ZHvvfA5YVdjvq9KaYI+sOf0InZ19RE6Ql?=
 =?us-ascii?Q?UUujsJn1auRnJPx+CSUBoGF+7dyovhGa7QY+Wpp81htsItGjkpF/D0YZwd6V?=
 =?us-ascii?Q?SQ8lmLHFay7KaaCrj2H4Oww9BD31qYOWp1cQQX2ZlfSgPDH0cQcwwsRULJb5?=
 =?us-ascii?Q?ZSSgIvSgrwhHaiB97N7yIvQjq17O9AOpI40aKeR6Xsl3TZYJdSLvy3RJJNrl?=
 =?us-ascii?Q?2YQ2iwG8yAIlowpiqPhIhfDpGyWS+AzEeV88vwQpJ2iTUVMw3k1jdQBiEChY?=
 =?us-ascii?Q?HeK/RV5kW/sjJRhoyG0gaZxbolirmgCF15pZCIrCSV6dhmrpc56vp47nipMV?=
 =?us-ascii?Q?AsLFY7BASVDCx8bHnpA56YvwmM70T9NQ+DmN6+Qz/QHNMmGHPUbFbDEih0wi?=
 =?us-ascii?Q?PQ+HdeGO6Y/WSruZxhRBJdgUlqV6q1bd+0sYM2hcdgyh3dn9jY8W2b4IG5hK?=
 =?us-ascii?Q?yeZQwzoTMFd2GY7zMdzONZk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeff5121-0785-44b7-ffa8-08db6029ac19
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 09:47:09.9746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYBzX2rsRb0negR+iVWvucjqo25TrSXVyugtw8zAz3H1+y/pfU3RMrFf3mAA+3y3TY+ZHoMizdWl5jGEu0z07xaeXgAxOy3kVkXxDT4oKJ9E1HFzByGRCmN5urYK2hTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5998
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Sent: Thursday, May 18, 2023 10:04 PM
>=20
> Smatch warns:
>         drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:73
>         gp_aux_bus_probe() warn: missing unwind goto?
>=20
> Apart from above warning that smatch warns, we have other issues with thi=
s
> function.
>=20
> 1. The call to auxiliary_device_add() needs a matching call to
>    auxiliary_device_delete(). When memory allocation for
>    "aux_bus->aux_device_wrapper[1]" fails we should also delete
>    auxiliary device for "aux_device_wrapper[0]".
> 2. In the error path when auxiliary_device_uninit() is called, it
>    does trigger the release function --> gp_auxiliary_device_release(),
>    this release function has the following:
>=20
>         ida_free(&gp_client_ida, aux_device_wrapper->aux_dev.id);
>         kfree(aux_device_wrapper);
>=20
>    so few error paths have double frees. Eg: The goto label
>    "err_aux_dev_add_0" first calls auxiliary_device_uninit() which also
>    does an ida_free(), so when the control reaches "err_aux_dev_init_0"
>    it will be a double free there.
>=20
> Re-write the error handling code. Clean up manually before the
> auxiliary_device_init() calls succeed and use gotos to clean up after the=
y
> succeed. Also change the goto label names to follow freeing the last thin=
g to
> make it more readable.
Thank You Harshit ! I reviewed your changes.
But I need some time to apply the changes and test them.
I will let you know as soon as we make progress.
>=20
> Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus drive=
r for
> the PIO function in the multi-function endpoint of pci1xxxx device.")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Only compile tested, from static analysis.

Regards,
Kumar

