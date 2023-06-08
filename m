Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF38728B92
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjFHXKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbjFHXKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:10:46 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B75B30C2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjoqRopW67Ds+wKZ55LJ6L3LgEJE52q8jXHXyCsFVU2Gn0KeGP5I4p0Dd2eXLJQPdNmkNfmZeeBzotUUUD9qDihWWEb6KPoTPomyOMrLnlkGfFGq93ZiHHHau/ziMcoLlczsC3a227jsj/NnnaTHWDIYo19CWkye0xOsSvB5MuTxmYPv7mUo+VQNv41lG2wm2XTOUgfhGID7vOYemLHx8fVZ+3grN+XE55Iwn9euemA6auYWrIxZ8bVrmO75aDKld1gGhcpiJCNkoWxZ1SiWAphg2fqI1BeOvzQMySbtQwscHXAR4LY0B3jv7m4LF+DpXgIaFihZik/3Jx6Xo/07ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30ovn0dE2MI+5v90BQkqxTk9fgY/JH7R3CdcoYtwNxA=;
 b=Vt2JJ/ObNZXxKaIOKAe0po/3gjFBx41vkhvT0tfVnR5090caVlZx+6pNT59HSsGswsUA4DWVKjWk2cSbH90yEsAHikE//6Dhap9TsJsv81/A66sH9iNCRp3KjNlaPnB9ryy3qK9IEFhfGCEo9KAejQaQw/rn44kdm6yQ4druKnJ0c/wGKNzHJhfG7np6HujAu5FscZoLAzQ7g7srkeMUHNkbjUN0PyU1PQRMzaocferoSj2edzpjwFZCUxCToOIwAGsErzKN+QQaZJj5dUbueiO4wckBCdryMLJpuLogZYZ79ORRI72eJQb7fq1jHzl0t0ayZkpksMdrBhuEoZ714Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30ovn0dE2MI+5v90BQkqxTk9fgY/JH7R3CdcoYtwNxA=;
 b=qtxjLsLsAIwXrvHELM8eMQN9OcEkBL0/LDptfczW/mgheehFDPJoV5dcCwR3EM18ABhwaYPJ6h7kQfwbcpNQrYbLp+d8b1A3JclQVC8Ah4zk+ly6tk7/XNvSoM9h+5IQ6yVUSvxqKr7s+WVLskgn+C+kzql8NrjUpyKvYNhsbrU=
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com (2603:10a6:208:145::23)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 23:10:42 +0000
Received: from AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::7aac:2f58:b7e3:2c24]) by AM0PR04MB6289.eurprd04.prod.outlook.com
 ([fe80::7aac:2f58:b7e3:2c24%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 23:10:42 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Nathan Chancellor <nathan@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH 4/6] bus: fsl-mc: fsl-mc-allocator: Improve error
 reporting
Thread-Topic: [PATCH 4/6] bus: fsl-mc: fsl-mc-allocator: Improve error
 reporting
Thread-Index: AQHZlJ98Oz9RTwIAQkWKphRxSM1C9a92K6+AgAtT7NCAAA9agIAABGng
Date:   Thu, 8 Jun 2023 23:10:42 +0000
Message-ID: <AM0PR04MB62894F383B97E4FFA6ED58118F50A@AM0PR04MB6289.eurprd04.prod.outlook.com>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
 <20230310224128.2638078-5-u.kleine-koenig@pengutronix.de>
 <20230601154101.GA2368233@dev-arch.thelio-3990X>
 <20230601165945.f7itlyso4rbp2nbb@pengutronix.de>
 <AM0PR04MB6289C7212F52C7A9DA4951D38F50A@AM0PR04MB6289.eurprd04.prod.outlook.com>
 <20230608225355.3raozoq3v6teft7q@pengutronix.de>
In-Reply-To: <20230608225355.3raozoq3v6teft7q@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6289:EE_|DB8PR04MB6907:EE_
x-ms-office365-filtering-correlation-id: 2eee5afd-79fd-43b1-be61-08db687594e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gsus/8gw2MdDzLHSOWvuqR06/JzR7JDoacOLe7Oh2GW5oOwg8f3SPn43UfIjkZLCwuR404KX/uonuigIE2FfhIiHAa9PJHLgrZvivJKwz7soL/gKY0z69ydeHDgj6armRWV+ctBXlUvSsFgyi95FyZZ1FKzKLBQo1xvjnj1kBp9Sl9rTc/Ig3ao7uuIUZM3a9xsvDuK/9WD3EJnkUE76VRyMOho3ngQP8RneCnPG3woZAdpMTHvDt97xEWYJ166gSfDojCPNYClv3Ko4KdLZZDE0tsNXuW/TdKcj7PGtTvCfngY34w/JNteyIjO+pQFNuEAQ0PEIkt5p1Z1IUoWQR4qIpUEY2ir9tfy4r6XOdPKOfnnRz1vBz5w5clGaShQ+ciQdfMIsLHMBOjRfruchUk77/WlolilK1/T6x95cPAvH2j0/ZdVt+UGkS2cgE1fNgRsb9pQmw5S8gx0LFaeklfwdk4F9WrnX+XZeL1CR6ptj6NrXWKLLEr4ZoVMReEqio0EKZGBd0dQvfSXcbThaa9o/jKK5VcDp+PtEUgQ6qOj7xiM6ztylCD0UkKcKrUAAdxlELdRYPBVMQ5qEhkNARONegGPd6/30Fpp61HkAb1M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6289.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(52536014)(5660300002)(122000001)(55236004)(53546011)(38070700005)(186003)(38100700002)(9686003)(6506007)(26005)(66574015)(83380400001)(54906003)(55016003)(33656002)(478600001)(2906002)(71200400001)(86362001)(966005)(7696005)(66446008)(66476007)(66556008)(66946007)(64756008)(8936002)(4326008)(6916009)(316002)(76116006)(8676002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H6Bg5ALv6rz+VvJRjqwmzXfYNWI24F3Gc/ekSPc49Kr3z3M85glNQEkr5e?=
 =?iso-8859-1?Q?FeSAOzA1NjRCncXNUQ5hjoOciXpiU/DPBTZGrp+7eXkdHwm5PiBKPEJwlL?=
 =?iso-8859-1?Q?RvZET1GFdac+WyOVJ08cZZFiTIOodcM/heCPQQIufB95UNfqUWHoZPho5e?=
 =?iso-8859-1?Q?zyuByhOT79nxDUk1eavFfrsv/yiTpg+Q8ZsbJ/4pFRF+NadlhCEV0VxO1W?=
 =?iso-8859-1?Q?0mipkRRJj0WqQWLBSxmbGUUtGSZHK04PtBXWqJGA4+cT8grlOIbXUBOa8L?=
 =?iso-8859-1?Q?JO2nNAUxndT+yZZQllCqXT5jsG5T+pAuExQ7Z8mKEAwLgCta2uWZubvcqd?=
 =?iso-8859-1?Q?DDK1E1Z7VVhv92fyyw3zV4TGTgIhPRDxuX9CtxwhFAR4Yac3K08Wfd9q/Z?=
 =?iso-8859-1?Q?yUJefPWqjutWFtEfqvXBOQ/65aJgt3G4B1bNprrl62mJlIQxMpUPF3ktEt?=
 =?iso-8859-1?Q?kg+H7mLMHgkLHOLcCz/ksVv1ljnZKnUp9zpLSXox/KcqVoEiA/dLwZB95f?=
 =?iso-8859-1?Q?fThpykFSk+dl19EFJbSQRCxmtrfoNju5oKGG9m5aXm2xFzduPMrHtB/Tdg?=
 =?iso-8859-1?Q?bBfTpC5VXy2UcyTemmnmMzyt68gc3Bt44x6loz7ADGbULzwvXjlQced2/B?=
 =?iso-8859-1?Q?aNOSp7XnZFJGa8EJBiqTIYdVgel0xRdOzbTXr3hcmCgsdV0upkgV7Bwj56?=
 =?iso-8859-1?Q?lmLYDnxifhMMzbp1dLCyvoKkHSi28QTwmiaxEN5IFIt5LGoZzOEA8PgEvk?=
 =?iso-8859-1?Q?2Yi5GO/pNgz0HawwHIfyTNbIdn2s4loCGLMPHlU853nsVYp5yqUilL+WyE?=
 =?iso-8859-1?Q?e+5l+5Kmwx3JC8UbH10BLRd7hus6+ZqDia5YOGPSyPzZOdmNFsMYqzZpG5?=
 =?iso-8859-1?Q?NF9STRBMFEJVjFCbuQmxoc7+ldhpwyjYOmE9tdAU2EyTIjcAEi9kmGZijb?=
 =?iso-8859-1?Q?NRf3XPKNa9d5gYdOl1iK4TfSKbbphBJJKGSKLRC1I5d+zJm/gaEPPRlF3Z?=
 =?iso-8859-1?Q?k1G8/XCUxhWop4mBftUlifIjy+darCGCGHxYkdCxoMEjQmemRBOVEUMfYk?=
 =?iso-8859-1?Q?H11BD4NwkbH7MrfVcpV2Sh4wtIEuwJOzXKzQj71rLDQRZiFo8kqdIQjxoJ?=
 =?iso-8859-1?Q?B8Iyko+MIraBxfkYZwZ8R0UNPmDNHKxydlFGLDWVTPBbQn/6lgOTfx7e42?=
 =?iso-8859-1?Q?y85osXn6qz4mjFRTeMXVM4XfAuHsqzZAB67MyXp3I/iz0Hm1alGsmktqOE?=
 =?iso-8859-1?Q?Wk1/a8QLJNBxq8RMVKnzUcUDlksN3Siy8xtfvSLpUMJo5mhuG2GFM4Aad+?=
 =?iso-8859-1?Q?10cSPzISeScrjz6MqCHL8v3T5IGk9jziqeCDPHW6wbzPkGQQ7b4jciyMqR?=
 =?iso-8859-1?Q?LzrAu8WsCXEEQvrBeWJ19ZtrK2BozUEaSZJJ5DNZiIQciHP5xZ4Hlkt+KD?=
 =?iso-8859-1?Q?vues0CDP5QL8gKLnZvrItoJfB/gfBmCcfP+VqyPPteK64mLGQ4SNPPAOFJ?=
 =?iso-8859-1?Q?U6rKkbqp7I/gQULXnqO0wSLXu3ljyrfcPnBxRD3jyVelrC/g0WwJ2u7w5T?=
 =?iso-8859-1?Q?DOYfn96MOAabt7nlIDW23KQuHRdkF/cL9JYcwFd+bIkx3rlvO4kTKjz9GH?=
 =?iso-8859-1?Q?LfH1wwZEvYPK4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6289.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eee5afd-79fd-43b1-be61-08db687594e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 23:10:42.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNqtAqOtKkhHfBxuJx+ujxHJ+I4MRebFoji+hptqKHfZe7kYeGAWXnCgAgUNkKbjDbgO3JnZ4Y0tlXDil3vC9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Thursday, June 8, 2023 5:54 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Nathan Chancellor <nathan@kernel.org>; kernel@pengutronix.de;
> llvm@lists.linux.dev; linux-kernel@vger.kernel.org; Stuart Yoder
> <stuyoder@gmail.com>; Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Subject: Re: [PATCH 4/6] bus: fsl-mc: fsl-mc-allocator: Improve error
> reporting
>=20
> Hello,
>=20
> On Thu, Jun 08, 2023 at 10:00:13PM +0000, Leo Li wrote:
> > > Hmm, clang seems to be right, and I just confirmed that gcc
> > > (arm-linux- gnueabihf-gcc (Debian 12.2.0-14) 12.2.0) doesn't emit a
> > > warning. :-\
> > >
> > > My approach would be:
> > >
> > > diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > > b/drivers/bus/fsl-mc/fsl-mc- allocator.c index
> > > 0ad68099684e..991273f956ce 100644
> > > --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > > +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > > @@ -103,14 +103,15 @@ static int __must_check
> > > fsl_mc_resource_pool_remove_device(struct fsl_mc_device
> > >  	struct fsl_mc_resource *resource;
> > >  	int error =3D -EINVAL;
> > >
> > > +	mc_bus_dev =3D to_fsl_mc_device(mc_dev->dev.parent);
> > > +	mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
> > > +
> > >  	resource =3D mc_dev->resource;
> > >  	if (!resource || resource->data !=3D mc_dev) {
> > >  		dev_err(&mc_bus_dev->dev, "resource mismatch\n");
> > >  		goto out;
> > >  	}
> > >
> > > -	mc_bus_dev =3D to_fsl_mc_device(mc_dev->dev.parent);
> > > -	mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
> > >  	res_pool =3D resource->parent_pool;
> > >  	if (res_pool !=3D &mc_bus->resource_pools[resource->type]) {
> > >  		dev_err(&mc_bus_dev->dev, "pool mismatch\n");
> > >
> > >
> > > Should I prepare a proper patch, or is it possible to squash this
> > > change into b3134039c5b3cf879841e3ec84c8cbf7675554ec?
> > >
> > > @Li Yang: Please advice.
> >
> > This looks fine.  Please send a new patch and I can squash it to the or=
iginal
> commit.
>=20
> I did send a proper patch already, see
>=20
> 	https://lore.kernel.org/all/20230605112025.80061-1-u.kleine-
> koenig@pengutronix.de
>=20
> You can apply that on top of the broken commit, or if you prefer also squ=
ash
> it into the offending commit. Note that in the above thread there is anot=
her
> fix for an older commit.

Thanks.  Both look good.  Applied for next.

Regards,
Leo
