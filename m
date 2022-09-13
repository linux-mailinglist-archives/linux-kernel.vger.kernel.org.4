Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC41B5B675C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIMF3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIMF3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:29:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C154CA30;
        Mon, 12 Sep 2022 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663046961; x=1694582961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KNgBxkYFH4A1BZ8UCfdos1hNrZrbOs8WZdEWRvIz3sY=;
  b=SFxDHpFCPVoukLslgX27bam/vn+nf/AEK2ZHTx0L271fXEbhs2IPnL2A
   OqflFLhFQuPD5HVQMA576PC4zG9XqElhRagC0SXYTwaLp1apWUHaAEszF
   D91dZKKO7D1vamd5h2m0O0y7kP9qcaB/JiAU40jXcv9RLXmOJCv9Rzl3k
   /TtyIpqwEyNNFufh2JxhvSNzrXoCAMJWSVV8gE7ZPh2WdcZUbJQYOT8dR
   B85bxJ2xRbqYt+3t7ByEz89kvnj6ySvV/L3iKaHv7qt5mibeVf5uM+DGD
   bbh22wlNKSySz+jojgNg8U5e7eqOaB7gH4Fl+9cpguPYdBub9PqOueVns
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="180240668"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2022 22:29:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 12 Sep 2022 22:29:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 12 Sep 2022 22:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOmxUn/tDiPY9+eruYx5lIk/2BPDiw77nerm/YM+VT4MiGq3sHrtDvQh2BK2zvy7X6FRWZzHkLgpiy9h1xZ45eNXld4D7fNAI6FDoyFCE+znT8p69mtgSIG0geAm7YiUEmgGV7HZXdUgK5l4rPvK+AwsX66x/2gdFi8zb3lyaPw8A4DjzAUxhUhe7TNsxHm/Opetzrque+mWQJPKuoXXhDil5gNbsB7DnNA+Dp06iwZyx+iON2BMDgRHDEzKdM285G6ObSErY1scEzR1I4HlCYoyyRbei4onJBcLXuR9LvZuLt2LDiYTvNZ3wUjraluK93hYzIw9guaruVYsP9Timg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNgBxkYFH4A1BZ8UCfdos1hNrZrbOs8WZdEWRvIz3sY=;
 b=X849wUwxmmne7ZZ1d0VG6pcWPdBSqI/Bo6XKUEQJJSiIvqoqxDZb84wyLhGzfpTMqk/L9R+C28XJpvpTTrjTlDfTNy4dczrBmtYr7pucVjh9rzNrMXmsKvS95PDXflJ8qjY9gy/ejHi6nvLG4LzLuz1VYzOcYmr5ShMuwRhj/SMY5W5pcohZtEofrWtJlziTvVnOLAzEewKwIAunaOrf+ONuLDXwAxU2QyXApGqk6bjz7GYwauYJPccA7VeAXVcwAIVLb1CpNYF/YertgJn76DEsJ9aVCKa4Fm7Zbrvf7/AKzwCae6v6BN1zl+OuQL/6oBL/K1CO24F9BbLkze9/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNgBxkYFH4A1BZ8UCfdos1hNrZrbOs8WZdEWRvIz3sY=;
 b=Id68EUW1vbCxjBkJfd7wfks25Kc4djeAPTNr0LbWjEWP3AiVB6yjp5EcbF1Ze7xZZ82bdFyZ0sY51jSia1gaNpVoRtXuEZDGutaJEodeNjt3iy+SZ9uxELzbtn0jrnlmhoQ0pJ0UBk+LU6DsuQ0q4TiQNDbCebBfsgcAsRKSFuI=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CH3PR11MB7249.namprd11.prod.outlook.com (2603:10b6:610:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 05:29:07 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f851:80cd:172b:4b1c]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f851:80cd:172b:4b1c%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 05:29:07 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <lee@kernel.org>, <robh+dt@kernel.org>, <Sergiu.Moga@microchip.com>
Subject: RE: [RESEND PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Topic: [RESEND PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Index: AQHYw5S351ZiP2+bvEqYZuXgNIsbDK3WCUwAgACWniCABNh4sIAALv0AgAAK+AA=
Date:   Tue, 13 Sep 2022 05:29:07 +0000
Message-ID: <CO1PR11MB48650B395FB6A4D94B51CE0792479@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
 <20220908150658.1839520-2-kavyasree.kotagiri@microchip.com>
 <1662671776.565921.3355400.nullmailer@robh.at.kernel.org>
 <SA2PR11MB48742AF8A0C9BC6D32D57A2892439@SA2PR11MB4874.namprd11.prod.outlook.com>
 <CO1PR11MB48654A4239AB7A760193497992449@CO1PR11MB4865.namprd11.prod.outlook.com>
 <eea8e746-6561-71ca-12f0-d010a0672edf@linaro.org>
In-Reply-To: <eea8e746-6561-71ca-12f0-d010a0672edf@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4865:EE_|CH3PR11MB7249:EE_
x-ms-office365-filtering-correlation-id: 61989793-850e-4acd-9f75-08da9548e159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q+sR7wSOzQmGco+X/gqRw5vWOYaNRYbORpJNrK/4QmOaK7jyGSYWqxbmu3r2lqJwMtQ3guHeUe0YrG32ObhXRfZ/TRPdQ7DjlVCn1KdrhZkbekU8NtwjTpvg6HsptDvU6mOn/wPtdSX58OEorktui4UcHyzot4J4K0cPbnfFoCI9ipj1HoDyNopaNuYPtE1zQSS46MZxsb4G9NsSOenC6RX5c36jgeirq43wAVu1NMMyHszQfRr684xg8ud4xPBN+OmgLsokpVykoPccwOdJ/SvTOXsuPc3WXfYYpuGlU86gV+XnoZ/G/MDQuiFkJLbkvQ+MXVNoBqwKrC3Eh/Y1bbUOFpZIUzjXrNM1YJ944Al6uGtriLNOhUbsQVc4Tdr2/VfgIHjLR49emSqY+VoK4EsTs4/A/MYTCIZEIrLA54go9h3wPnVsNlcvmLtv4D7o9wiIrJRe2NUBJCaQuqe0rdBHbnWRc2G4AaBvEtnvZjIri/3v2Og2gxXf9pzDr9TBWDkcDYVylvf3pVEUFa16aD8SlykBBaZk1xTimdju5sMmdodMtVT3E4fK+Q0U5crnKtxpBKtCF+rUEcy8f31crh1ALR7w+gR2iCzTj/BZFm6Y2pVbxNtSTn9fMILDIJQ6AXqt84hdnuaKB2K8GwRk55uGKN7kqBq6Zez8+MizknE4XTkpdGk0aGvBlkD9q2sXz9Lw+y9q4fcjY4HDCPieLFRhQOqRKhcbY61bNcfTCAaGs/f6aVh8u521rIo4EvxJrtFyClkhUDSgPNiS+hmocqX+oQUENlphKWq9DA71L6c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(9686003)(110136005)(55016003)(8936002)(966005)(52536014)(66476007)(76116006)(107886003)(478600001)(316002)(71200400001)(2906002)(41300700001)(54906003)(86362001)(83380400001)(64756008)(38100700002)(122000001)(4326008)(7696005)(6506007)(5660300002)(26005)(4744005)(38070700005)(186003)(33656002)(8676002)(66446008)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFNnMTYwTXpXUG1JcDNVMnZiQVVzVVpKeTBpZWt4blQ3VlV2V0VJWTAyK1o5?=
 =?utf-8?B?M1oyRWxyUUZaL1pvK0ZlZmRVNFBWVzNNRXBoQm5lNC8rZ1BHdXd3ZEpZTyty?=
 =?utf-8?B?MkdNU204YlNIcjg4Ty94dlRUYWZkUlBKMENCRGhGS1Zna3Z5b0VUb21KSFlJ?=
 =?utf-8?B?WDZyMmVJYUd3RGQ1ODkydmdFNWEyNXo3S0duZEsvYnM1c2JleHZQS0xLNTJF?=
 =?utf-8?B?S2lueTBOSzUyaFJHZHlYVDQ4bUtCdnlSdEpoYmMwY2syMHU1TEZnWnVOS09u?=
 =?utf-8?B?NFZRZUROdnlTVmtYb1l5dUx4S3ZPRDNRTmw4Q2g1STZMZUw5RTVlNHFzR2ph?=
 =?utf-8?B?Vktwc1FYY0ZGeWZMMnIzcE1KMG0zdHduNTlWL21GR2d0ZnV2SXk2K0REYmJw?=
 =?utf-8?B?cXQ4UkxaRHNDaEtwb09KbjRYb3p1T25iV3ZWTGozUlVxSzN1TGtMVDE0N2lo?=
 =?utf-8?B?cmVZTnQ0K2kxZmRySmRoWjhDdHhqMVZyZzZ5Vmd2NWNqMTl5K2ozNk1oTk4x?=
 =?utf-8?B?WW05eVQ5Rk5hNk53ZC9BTUpmMytZTzhpY3c4MFpsWmZPS0hieU80L2wzTDND?=
 =?utf-8?B?eWJyU3pzTEJqOXd2VWZraC8zUTJ3R2dkOTlRL0VWSkhTTmM2VmVYNWdSUW0v?=
 =?utf-8?B?TW54T0cyRW5XamRtOVpONmVYVDB6bXNPdCtIeDZ2OExCWm1yWWlpUEVpbnZz?=
 =?utf-8?B?MlVJRTZYc2tHRkowOWZSQ0JrcnFIQldBSWtxN05zR2tKVDN3N3Q3eEw2VG5a?=
 =?utf-8?B?RzlBTlNGYXA1OUhyRjNyVDhJdkFkSDJ0UmdBcTU3K0hheFFTdFBQOGQxU2cw?=
 =?utf-8?B?Vmk1OEJxcWZ2QzV3bWdhS0pUeGE2dGxKTkVKalNkayttL1M4YmtTTFhXVkVE?=
 =?utf-8?B?VjUwclowME52UkFrc25DS0J5Mm9BSk1YWVQyYjJzWWFYUzMvMDQzc1JyUDE0?=
 =?utf-8?B?YWw1OXV2MGhMQ1ZkM08xVm5HQld0UFRERTRsVGpjWjltZXBWQ084Rlg1NTU1?=
 =?utf-8?B?SFR2NE5sRThra2Q5bHZtd0I0K3hQVW5kK1pBMHJrbHgzK21OWXlvV0pockFa?=
 =?utf-8?B?Zm1QU0VZM0JwLzFyMUtDWmwzUnlkSnlzbVorSHRVMWQ0U3BqaGYvWW1GTzV3?=
 =?utf-8?B?WHB3UjcyOFc3VnZhOTJFOCt6TzljS0oxdVJJaTM2S2F0MXEzZS9mUTlSeDZ2?=
 =?utf-8?B?Qm5UYk4wRFJaRGJCNzFJT1cyYkpqK2NXYXNzUmsyTWovWW9XTjFRYzFWanhI?=
 =?utf-8?B?K215WDFhR2ppcGRFUFRIMEVPaUpqRmZpQUVHNkp0ak5rRjZNUDVXSysvTXZj?=
 =?utf-8?B?NWFWVjRQNUJyTFdSM2hKR0NPSDFPa2U5K1k1LzlMNnYwaEMveWZDM1pJNnNp?=
 =?utf-8?B?dGtOOWFWK3BPbUNIT3BwMU1PVTkweGdpMFNTSzF4Ym1SUlVPRGtZUGpaNXhw?=
 =?utf-8?B?S1ZXNCsxNjdpQ0V6dDhUWG50dzBianpkR0hEdUpXamptMklsZHU0d2hyc0w3?=
 =?utf-8?B?ME9sNXlQMlN0SnV1ZHRpeGdqRFZVU3pHTCtOcUtYeGdhRll2SWtUR3BzYUE0?=
 =?utf-8?B?clpGNzZBTWF5cTh4Z21oSFhFTnRoc2k1Uko5SFBaQ0hYVXFnR2Z4ZkFTNmZh?=
 =?utf-8?B?dEVKdEVxZ1c5ZkdSSzhoekk1bVZ4di9uRmZ0OGQzR3BiamVabHRiSTBWdVhW?=
 =?utf-8?B?dEpuYVhqcktwbnI3aWh6MzZpTFV6SkdtR05mUE5nY3dLSU5WbHNGZ2swT2hP?=
 =?utf-8?B?QlJFVWtsTXRBcU9CNW1vdUpvTjlMaFRRb1VpS0VlcFM5dGJzWGI5d2piWUhO?=
 =?utf-8?B?aUE2dXBQMGJuRVhEQThSZG8rZmR5Q29qN2tLckozT2tWZUh6Tkk3dUNXY2Ev?=
 =?utf-8?B?WmJXK0JIVHAvV1c3dkxDUHgxa0JoMVpmTGJVbHFhdEh4SUZiNG1FM3JuV0Vz?=
 =?utf-8?B?YlhnQ2syT1llZkpYMm5KV1VlZHA2djNKcE5TUTc4Y2NWY2RIUzNqbmtYbk1w?=
 =?utf-8?B?T3h0MDlvTW9mWmZNZmFKbHJiYmJ5SGZMV3lQUG1VZWIwbVlvckhCOFhWVFcr?=
 =?utf-8?B?YzVDbW1CcXVFTVpsOVZvMU5EWHFHbkZyK2xsSjF4UCt2a3R2eWFTbFpDTE1E?=
 =?utf-8?B?U2xFN25hUUs4dXlFU1U1RExtbitjaWVIUnRiSVYzTVFUWFRBaDJPbUVOT05I?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61989793-850e-4acd-9f75-08da9548e159
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 05:29:07.6652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1Ne40PaSA2+BUKhDPOxPBViRbZPyhEJe4Ej50O1wqGAOeKXVI9LsxLUUFQkaEjaDroJ7yvwr7q7BnHY7BWjrOyQWnc0xlZg+2uUkt+3ARuL1dR8X2kfTNqbQ/W0+imY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7249
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4gZmxleGNvbUBmYzAxODAwMDogc3BpQDQwMDogVW5ldmFsdWF0ZWQgcHJvcGVydGllcyBh
cmUgbm90IGFsbG93ZWQNCj4gPj4gKCdkbWEtDQo+ID4+PiBuYW1lcycsICdkbWFzJyB3ZXJlIHVu
ZXhwZWN0ZWQpDQo+ID4+PiAgICAgICAgIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEta2l6Ym94My1o
cy5kdGINCj4gPj4+ICAgICAgICAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyN19zb20x
X2VrLmR0Yg0KPiA+Pj4gICAgICAgICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDI3X3ds
c29tMV9lay5kdGINCj4gPj4+ICAgICAgICAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQy
X2ljcC5kdGINCj4gPj4+ICAgICAgICAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyX3B0
Y19lay5kdGINCj4gPj4+ICAgICAgICAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyX3hw
bGFpbmVkLmR0Yg0KPiA+Pg0KPiA+PiBkbWEgcHJvcGVydGllcyBmb3Igc3BpIG5vZGUgaXMgYWxy
ZWFkeSBiZWluZyBjb3ZlcmVkIGJ5IFNlcmdpdSBpbiBiZWxvdw0KPiA+PiBwYXRjaDoNCj4gPj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9iNDYyNTUyNi04ZjliLWFkYTgtZjg1NC0NCj4g
Pj4gNzUxYTQ4NTQ1NTc2QGxpbmFyby5vcmcvDQo+ID4+DQo+ID4gSGkgUm9iLCBQbGVhc2UgbGV0
IG1lIGtub3cgeW91ciBjb21tZW50cy4NCj4gDQo+IHRoaXMgbWVhbnMgaXQgY2Fubm90IGJlIGN1
cnJlbnRseSB0ZXN0ZWQuIEFyZSB5b3Ugc3VyZSB0aGF0IHRoZXJlIGFyZSBubw0KPiB3YXJuaW5n
cyBpbiBhbGwgRFRCcyB3aXRoIHlvdXIgcGF0Y2hlcz8NCj4gDQpZZXMsIEkgcmFuIGR0YnNfY2hl
Y2suIEkgZG9u4oCZdCBzZWUgYW55IHdhcm5pbmdzLg0KDQpUaGFua3MsDQpLYXZ5YQ0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
