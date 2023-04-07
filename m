Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284CB6DB0BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDGQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDGQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:36:31 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDD0B468;
        Fri,  7 Apr 2023 09:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQQyrLsw163YLDFx7V5w2IvUKlBYf+ZTnfo59pOh1tDkmTC3dYussMlVKHWWaZK7wquiZ6DRJtn9TESL5f9LXBsb7FuoBLzWDj5EFgFXM6hA0StsIYH58nr1pY9Zm1f8jjxhgCLZxg0ZhNeJHfkMEMgs/RUwUrhwBhD1jkv5H/qqgQFI5BKyxNjNXmTjKqDLF6HyNcvj/yL2oWdjKHuL3Iduac/LBhw2+GTzjjnJLm9OPTQi9cNEe/MM4pV6xmfI+ShMuuK/2X6MtC02oq3Z/mWNoZ0jb4kxNFqBFeirgmWlQS6ZiyvZznFzuBWh6qAyBtNmKPCZUq0Ajj2/b/Ph8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MII7TvrCbxbp2oiWaDoWMmxj7WVcLOrT7UMnoibtjU=;
 b=k7UnQCdTLlJtL09ujIO6WdFBQIQbXyJaXQiU75VJY9hLdxq1JoeHIzjYzbs+GrFOKOmt9gF2rNTIQlGIhet4HkH9kckeMWGt6LYBzF5PEQgr7sb5WD8OBrsPCChNwRRe0wF/ixRkfhtaBiZKTsHsQwwu4UErv+CJodsHKFUtH/xxWcLC/rxZvrKLsiJceoEFQIrcTurDumBTu89jhbJzHBFLX5cH1x2jE4ngnVHX+6ACg/bp1z+7f2qRGqMXMh5quh3XC9OfMVJWVWTssQWoizXsYoSWQlxW37JLUFNYqZ14Eo78l9t1rgfXKNeKu4XJ1OZGpgu9X856eLDUp2CAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MII7TvrCbxbp2oiWaDoWMmxj7WVcLOrT7UMnoibtjU=;
 b=AtWzgL37T/TK/uSZl3PKoxUvkoPCczMG5ngqB7J2aNbt6y+8zwkYk9sC2IJRGv07zskBCNHEWVA/Yl14JTE78NVR3Eb2cRdKM8QJ8Ug2R9YBxg81+CW5w0fkNZh3X5BtXpuX9CUyEK62c0Z4iEIsMa7y8xUutkfCz4pePfOGTmM=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 7 Apr
 2023 16:36:27 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.029; Fri, 7 Apr 2023
 16:36:27 +0000
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Thread-Topic: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Thread-Index: AQHZaWHdTHheYNHw2U+NzKt917d6YK8gClkL
Date:   Fri, 7 Apr 2023 16:36:26 +0000
Message-ID: <AM0PR04MB4723F78E9F09E82842CE4776D4969@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|PAXPR04MB9667:EE_
x-ms-office365-filtering-correlation-id: 46c3426a-43ec-40e8-19cf-08db37863baf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wi2yJPdfkoxbyeO2bueXzi1DGeb9MTzqnDJRfQIEa3JLwlT4EQxlsN4TuSHN9DzQE03I8gE6D5O2+Ua50GKmfFC61FaI6SuvEjsIiSmv8wsmJeM2wMDFfVFfLOZkPJOUD+sHoYeQVR88qQaQrMs+KqxGWawzgj+8r+UND99ayDa0WDjRhrQnXtwyp/7SEGw9/13XY3Fvzx73EvZWV9PLA0vGMtVoIA1isck+xcBkBvIBJPu0PEvyWhG9JTGXUwCkQZAL+ES4mk/F3t96bGeLK4lsSkbyEmjYUzHQ14Xc+luWN6LKCVb/+TpqJlZJcEd3Nzi/nswsbjhGmIVBAqsBCQ5VxlMyVPKo0K/n3dLu7lgdthueh6bX/EtEXd2sTcSF526CrZGRwnNfWmHKA90RCEHDsUAP4GXNdJBq9Jb42K5xkuZtR92D2OZgRECypqCEotGrXKqc8LMZR0VoCQztHqBx1NhOwYOIm6eEPxAya4Nxn0i9EZ5+XUaxQpuCxz/rNFJngeHlJVSwAt2WoZlBIZGnZCZgyuMSSwc+IbZxHc+CVZl3AnIb3W2FWb/JFKkYgoHmLSlap3WqtoB0F2mfStSuPMgkmQBuXGq4/ZibkELcJJOhQSGMUOxZoiPls+pA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4723.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(39830400003)(376002)(451199021)(558084003)(33656002)(86362001)(91956017)(76116006)(41300700001)(71200400001)(66946007)(316002)(38070700005)(110136005)(54906003)(478600001)(4326008)(7696005)(66556008)(66476007)(66446008)(64756008)(55016003)(8676002)(2906002)(8936002)(44832011)(5660300002)(52536014)(186003)(38100700002)(122000001)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YI1D7Wz7gTjBZs2OM+A05lxqSPYoyzfVhLZTCoEyRbAGFN2UZWZPgLpnEB?=
 =?iso-8859-1?Q?okfztxT5nmiIXcpHK2SZbhv4lh/jBlUB71AbcwJzdpVSDbAcxGm3c44nDu?=
 =?iso-8859-1?Q?F4nn+2zzqhItbEo5hIpdXmoPo/gK351fSEDex5pY3PbJEqLvV5G1uVYZ3+?=
 =?iso-8859-1?Q?BP8bMeuDapj/pfkI99f0u8f61VEOlWR/suxh+VdZ7H+Fda38mLJ+hV6ji4?=
 =?iso-8859-1?Q?fYfLpFpmAdTD3ygVU0f/6m236LM6qgSGXjPDm1sR42TIzAXu2P+M2RU5pd?=
 =?iso-8859-1?Q?nKqki15csm2oFu8urO88axbk64POFDde0Fr4yPK/xwkk6s6mrekb0MgnAA?=
 =?iso-8859-1?Q?Y3IA/DYZyZPGoFMK4Y1qKe304zOHBTCT2tqZqGdCzV6NtDwbMyGxFOgWFe?=
 =?iso-8859-1?Q?Qmn7JTDeC41AOB7/kuEgpL6N5JmBeU0mqG8tOW6ZU1ygG6o6QbMN8kQfpI?=
 =?iso-8859-1?Q?fITKeAV7Bf5TCrg/FJeESsnqKJ3DomFISfki82yGdyPrhjvQfyeTI6X9Jv?=
 =?iso-8859-1?Q?9j4dtzL6t6aOJyj4eim0cCKioYNjk8lNOlbmaDw6SUcB70Rkn63qaYpjfT?=
 =?iso-8859-1?Q?aN8HzWEwGAq4Q7Ojg4dZojQnyXqiFKQhQvlwKhXNyUKffmdfxMyn6MHpgq?=
 =?iso-8859-1?Q?HWy5VeFaOae2xvMw00Zon6UWLYI6F0XSQB4JGF3us9iSAXTLvroiWEQmWU?=
 =?iso-8859-1?Q?99lmKicVEfsnySjjRIjWgD/N9xFTlHU1LpdtyJsRpYO/q7BMoEA9Dq/hkz?=
 =?iso-8859-1?Q?yNbIBDcrRGSV/ORdrj+KM6jevAAkkHvRGK6MhhJpQCxG+Pvv+hMSPH9x81?=
 =?iso-8859-1?Q?WYWiwt2BMZcHR0RYWJ0dL+zi4QOYij3PM/OqfHa9ATVWs6NgPHSlVoRAZ7?=
 =?iso-8859-1?Q?HW25fQj+u3hEq3G72PJvvXV4H2EHf1TwuPUux7Vty3Fr0pX7L4ZistxqFV?=
 =?iso-8859-1?Q?KjkHvDDBZsdk+AlMnBcR9YV0cusnly04Ws/UOJlcIavcFqb7jqMP2NctRN?=
 =?iso-8859-1?Q?hglufVN9SYl5gICOSDQVlmxVNQKsEfsUNC496fYmPo3CedvY/sYkafE3nE?=
 =?iso-8859-1?Q?rKTABoJ2jY/lq8VMC1uiBJLSnSFqZ3PMledUfRTsYAjHCiHH2y66Tzmmvk?=
 =?iso-8859-1?Q?AdAd5P2lPLoes3NfJgFSPDfmFzZSa1wLTYAXgZs6Ztv2K6u26lh4AVkh3H?=
 =?iso-8859-1?Q?wkc0pmjMzUkAdjBIKVbIVx1MRzrtqHrTy3Ou8i9kkp2dECyuauXqeKISah?=
 =?iso-8859-1?Q?ipk+pNFE8bUNqDSUA1lY3bDzthJ1FXA0Tne9wtriSMriyGImxxwKYlnUO0?=
 =?iso-8859-1?Q?LdzFZpnJUhqjOeYCDUMRNxSJsD6u2aNrxQZA0bCA6dsRbuRCZUPFPe4s8Q?=
 =?iso-8859-1?Q?VH9IgB4Ixl4W9IDVhQehIAcFjg0syM4PLzFFy4FNKHbM4HTA25j3XDP3Ew?=
 =?iso-8859-1?Q?TaNEae7dL4EpLumgDhpnH+0IKEZGgO80JekynBjo8WAyvCprRF0kOvJPBT?=
 =?iso-8859-1?Q?O4mzoTC2XoSTTb3zri3hxuzGYKpMCxUh62euY0xVqxr32FdbhE9y70NgyX?=
 =?iso-8859-1?Q?/Ja0yAZqVWVcZXQr2sehsnxBOG+AibD4cAgQCXr8sSi5TmYFy0Q5n8TuI8?=
 =?iso-8859-1?Q?k43yDqlcEAdKbDAs7dN5Hu8+d9vka0hhOA+VExwSqcLoQeEjoH+6zXrgbB?=
 =?iso-8859-1?Q?tS1aQWOO1bgUG4v8f8syP8lok9hzBzPGObM9cfet?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c3426a-43ec-40e8-19cf-08db37863baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 16:36:26.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LP4aX0GmYxpiU0rkoiIce98zdnO9nx7JpDobFn5ifLRG0OiUpoYY6Ck7BNVj8Y2W5uDm7df0yz0y5ObaK5UOaJLOs5SUheTTavEQZj7sUOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667
X-Spam-Status: No, score=1.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Statically allocated array of pointed to hwmon_channel_info can be made=
=0A=
> const for safety.=0A=
> =0A=
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=0A=
> =0A=
=0A=
Thanks!=0A=
=0A=
Reviewed-by: Alvaro Karsz <alvaro.karsz@solid-run.com>=
