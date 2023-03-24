Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7225C6C7F09
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjCXNnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCXNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:43:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500F51BDA;
        Fri, 24 Mar 2023 06:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4jSe1y6jAMH3miHeKq+SnbBu4hidj17TWmES7VU3XlRAOuT1gGWWQVqFOpdRqx0CGq7BQUqni2mYrigiYoh51DYvFGGuGLwz7WzsVJfOEktK/z42YXqtPW5cv5YYDzfPwYdDB2Ar0Kv4gc4luyjTALT22qEZa1CVXhWPyYtl2QIRqyKzrN32EFmeyCREiScsCiEJd+rdnbgjYEvKE9OkIlAgv/HV1tKX+yO9IS/yHEhIDFdwnb1xzIwu1VPv8iz44SO4fgOQzU3hv+ZkKnQbV8zaQbxUp6u8o5uxNib2l0hjdEiGPpiFM6AI4dQAfVmiLsm1tCGkLfEE/vfwRibqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3fQY1mz4PuN3glvWIjGMLSz95NYA8gP/rwTZhXcjFI=;
 b=JqxKCfYEla3uEooaw9AMChpWcmXBrTa7w05giyIppSAtBrXTj6A1rmx1QtSXmliaiMbyEA6g8qZy70eA6T2pXLiij9EX1c77n0Iz5trRTIwULNDNC1BAB2St2CR8NItp+NRen/XgquMoLXHwmsFKLdwUVQLSLJKR7SF2krv5G6tcgiwMNJvo1kl0e5EH5Vg8CnUHLRUj4gxgVwUM0n8uKpXrPOfAb+gFa05w5pm2nv9HEXgONO/6n2UhFIDNdTfFHieEvXajh3ef+VBkmIuEEpaagjEf++CexjhdsKzN8QR8EkwkCde9UNXbCqKhSsYaWipPA9yBEBESupRZrXQCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3fQY1mz4PuN3glvWIjGMLSz95NYA8gP/rwTZhXcjFI=;
 b=Sn/MCkJydPvaWLeqEU6VzG1Ilr0NO/3VkNApSYNhXz2SERDKPs7H0Hr5SX72bkjTtoia/ofDWdayy57TxSNhgxDjAxkjSUIGeWFpWpIzDAcb1m6oURJYv6tYOFkN3N2YJJpX51LQazCMzGczq+td5ok/HS6Jds2Lotww37D3vKRFVEAX9Ymz32NK+zHanK+YVtk1k6nCOu9GDTpPhTp4z/1/jA66fjvlPsCZdS/4smN9bsHWF+nxt5aSY1LVuP355PtHwyu/EPiLKq1UkmzvU1Aipd8+FCuDJ2pJGk99cM5CqPIXFHIo3MjEijOQyHvhCUokyufbdUfsSmZSifZnaw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 13:43:39 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a%4]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 13:43:38 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] gpio: mmio: fix calculation of bgpio_bits
Thread-Topic: [PATCH v1] gpio: mmio: fix calculation of bgpio_bits
Thread-Index: AQHZXcoi7FLBwG/JU0q3FmEUxUR5K68J1scAgAAAmwCAABoLMA==
Date:   Fri, 24 Mar 2023 13:43:38 +0000
Message-ID: <CH2PR12MB3895A52BAB0E8CAB16F58B6FD7849@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230323205733.20763-1-asmaa@nvidia.com>
 <CAHp75Vd4m79RhG-_KLRNzr0SPzphG07fOiTWwmGCfx8Lz=+6Vg@mail.gmail.com>
 <CAHp75VcJf-peTtFA9xP28OYUCzGCeG-4Uw2aHLMrM0Sx5RoKvg@mail.gmail.com>
In-Reply-To: <CAHp75VcJf-peTtFA9xP28OYUCzGCeG-4Uw2aHLMrM0Sx5RoKvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|SN7PR12MB7911:EE_
x-ms-office365-filtering-correlation-id: 721f79f9-407b-4f34-be0a-08db2c6dc60d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zz0/jL66YUW/MNBqW4aGWQmxERSHoioq+jYudce4Ps9M4qc9exXbLMzQrg0Q/iMWW8AfdPlgPFK7JbEjs9vetlQ8r+7Wkp4mNq+6RVkeCvkdcc7KzgRh/BUvvVgM5Fc7r67ScSmZohckUrQaT+NJG5/+Mezpd43G84d0WtKkgzr0AqGYMR412XSkc3ry1gKS6c89VCTCNZOL50Nm1Xq6CQi+Xh+0TNKZWSETOShoFFyGwMEff0CTD3+rxaUPLXlnObRdBq/ynK6uxAQm/EWbSK56Dt1MLmqXZjqKeXDdpDTbfb1ZDCeA44Ynpj7D3sMe/ibePEtARN6X6bT+tOhPdTIUcwmk6CTDpifHkxz5GM3zAZ1jifUq5W+Mm12zmSvIgkxzZ/Es7byybXdU826gAsoPHQKZPJeM6Te8j9vKLtJyXW+ylt50r2qFpI7kUPf1xiN+YRLAS4RQSdB4raafQTxvVxkqkSZGItSRgoTO8QbBfDnVbX1VT4KSINttyOYyc4egb6FXmpxxtpYQzrSfyTn84O2Go61ueGjNlL501Wd/WaVM2PMGYkDti4HNJwG/OCTWlmifrq/jRPjIwgCmNdXQw5zrozvc8qL2tTvFEKe8AblKliuH5XdZ15cPB4AWR+UOJQJQcGlGaa97yUQxhn+S2SnXQPA7c7NMsjCvm0zVUPIzoVEGM+XEtvOgp//i8CCV+XMDEktQikLE/0roGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199018)(122000001)(9686003)(478600001)(2906002)(6916009)(316002)(8676002)(4326008)(4744005)(71200400001)(5660300002)(186003)(38100700002)(38070700005)(83380400001)(52536014)(8936002)(26005)(6506007)(33656002)(41300700001)(7696005)(54906003)(66946007)(76116006)(64756008)(86362001)(66476007)(66556008)(66446008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXNWT2dXbVdIbnMxUFRXaVMzb0pLQzZQT3RqZTZGZmNTZFZ0S3FtOE9ab0xD?=
 =?utf-8?B?cE1GN2RIQVhqUWlYVGZ1QzcvR1FnTjh2dFVtcVBUejlSU3kreXRZUjU2VDNQ?=
 =?utf-8?B?UFpncEFMYTEwOUlDVjFHOHV5Sk45Z1I0dGMyOFJXNEdBbGVWRlJ6QTB3bjMx?=
 =?utf-8?B?KzF6UjB4Y0w4RDE4WURKNm5LK1B3QzdVN3dCcEZ2b2RIK0djMy9jQmdSVWFF?=
 =?utf-8?B?djdiaGFjL29oOVkxQVMyQTJHaGh4bXAvK3ZkTGVwdjFkaUQ5ZTNUUHdpQ3dG?=
 =?utf-8?B?TWFYT1pLdTVKdTBlaFBweExwcXpUV01VejJMUFlJTXNFcEFEZXo1MG1acmhD?=
 =?utf-8?B?blk3dlFEUWl1UUlWanFrWGhvak53UzZqK2ZpYjJTZEtPYk9LRVBIY1BDaS9R?=
 =?utf-8?B?dVA4RmdtbjVrTDR2OWlJOXk1SkdBclF4bUo5LytxVlpWdzhZTm8vVTRRai8z?=
 =?utf-8?B?ZE8zUzlRYnhyblRoMHYvbkxQek80TXplWWNBQVE2RG5wVDZlL3NIZnR1aFBZ?=
 =?utf-8?B?RVJwL25hNUxPenViM0ZPNG12Qkx4aUtJb09ScnpneEIvS3hvYWhxQlQ1MjJu?=
 =?utf-8?B?VXRwNVMvd0QzY0txOFRZSGlGVFpZY0NheVBDYnl0R2NDUFJGczYzSUNLcGFt?=
 =?utf-8?B?cTBTWkJybmZ6R0VsRFpDQTdQcGJuQWdRWXcwa2ZnbmErTENpeldrTUxFMFZU?=
 =?utf-8?B?ZjJqbUFyTUROczVhQit0Sko1V2syS0tWQWR5WENBb2drbExncVUrSzZiaTEw?=
 =?utf-8?B?T3dhYWdOSmJhdjlwSTdRSzgrbys5ZjFlUldKZ05KTWpQa2JETm9vRWpOZVZm?=
 =?utf-8?B?QzJkeEZ3bEMrMk4wa2dBZSt0dUx6QjhZYTl1Y0w4aWxUVFZzQnJhOTJhcjBY?=
 =?utf-8?B?cGducE50VFZnTlNCNEI1U0FrWmFTTFBXRnVieUNtYThpSHhYNFhlUkZrdzRO?=
 =?utf-8?B?R3VKMTFCTHdOZVhNL3R0aEJzRmI3S3JCNkI4L1BlL1d3YnJBSXlvN0EwQk91?=
 =?utf-8?B?eGxjV3RmSGtDdTl5WGZheHlVM3Q0U1Z6T2ErRlRFOEtibFBwb21kMloreTha?=
 =?utf-8?B?YXRJYmxvL0FZSjhpVXJKZnVleTAyRWwreUY5a2h6Y2Z6L0FaRTRuTDA3K0VD?=
 =?utf-8?B?bkd0UDFsajdlQlRmYUpnYXlndzlkSjNrUDhJRGJyY1F0blFKbnJ1Z1YzQk1r?=
 =?utf-8?B?dmkrQUVDbCtoUkxsR2dheHU5RlZ0SEx4amJqUUVkMTU5Tk5JVFRmV1NSdFhw?=
 =?utf-8?B?Q09rZCtZWTdOdjZzRTBNNnJXRDh5OTZhZGN0dzdkTndqM1lqQWtSZS9OejBj?=
 =?utf-8?B?VFc2U29kNFAwbyt5a3N4Z1AyaDVKTVJkMEdYdUsyV1dFK052WjdhQzBhR2h5?=
 =?utf-8?B?WEJZbXBEWkRWRFlLV1FkQ2NxL2dJUDEvOXJ2dlFoM1lwRFlrakJ4d2pRdFEy?=
 =?utf-8?B?Q3Z1eEVCUU1qOENBMlZwN1N3M05RUUJlc0VuMDlRb2xSc3l3T1h1UWdjVlNN?=
 =?utf-8?B?ckU5TjM3NXFQTHVoU004d1dDeHRCTFljS3d5S1NEVFdxQmNocnBiMjdLcm9H?=
 =?utf-8?B?RXdKK2o2SFRlenZ2ODZacEMwcGp4V29yS0trZnJ5ZUh2cGY2L3R4WDJvZ2pu?=
 =?utf-8?B?aE9yUmQ3Wk90ektKbVZySHRETjRBam95UTVxVWtyQ3R3LzZjS3FVZWQ2aDdw?=
 =?utf-8?B?cnp2SXFUSDBXSHdCT1NtUzdRa2xXU1Jqajl5MzIwU29FaVdtT0lkT3RON21R?=
 =?utf-8?B?cTRKcys3NU91eVo5VE1uZGpnM1VYcHJ4TUV3MXl0dFBvY0RzK0d5cmVkNGsv?=
 =?utf-8?B?Rnora3h6YXJXeUFwanNRWTkrWUI2ZFJXQXRNbkgyY1QxZkJ0ckhkNTl3a2ta?=
 =?utf-8?B?Q001UVdualdmQnhZTE9zSzNtVFJrVWpkMFdlSS8vUGxxTExzV3gzM2ptZ05S?=
 =?utf-8?B?UVVwazZOUlhCOTRGYkxyQWhUdkgxTVlGVlJJNFJ5ZXZkWGFuVHdMM3Rrb3c3?=
 =?utf-8?B?V1Z3QnVmUE51UUlPVGtpdGg4OU55cEhQUExpZ1NqUmFoRmdERzZFeFBOWXFu?=
 =?utf-8?B?bFkyN0k5YnpKUWZPdDU2K3EybjJ4c2VTV05lc0JPcEV5Zjk4c29iS3FXYWJR?=
 =?utf-8?Q?3ZsY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721f79f9-407b-4f34-be0a-08db2c6dc60d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 13:43:38.8747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1OI6kjHSYR5RjOV5ZviPpZDqXISzxeSHSvwexRvThCH6miJKLj3pDG+v7gywEdYq0BMNle/hyH3xJ2EjMkzrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4NCj4gPiA+IElmIHRoZSAibmdwaW9zIiBwcm9wZXJ0eSBpcyBzcGVjaWZpZWQsIGJncGlv
X2JpdHMgaXMgY2FsY3VsYXRlZCBhcw0KPiA+ID4gdGhlIHJvdW5kIHVwIHZhbHVlIG9mIG5ncGlv
LiBBdCB0aGUgbW9tZW50LCB0aGUgb25seSByZXF1aXJlbWVudA0KPiA+ID4gc3BlY2lmaWVkIGlz
IHRoYXQgdGhlIHJvdW5kIHVwIHZhbHVlIG11c3QgYmUgYSBtdWx0aXBsZSBvZiA4IGJ1dCBpdA0K
PiA+ID4gc2hvdWxkIGFsc28gYmUgYSBwb3dlciBvZiAyIGJlY2F1c2Ugd2UgcHJvdmlkZSBhY2Nl
c3NvcnMgYmFzZWQgb24NCj4gPiA+IHRoZSBiYW5rIHNpemUgaW4gYmdwaW9fc2V0dXBfYWNjZXNz
b3JzKCkuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZj
aGVua29AZ21haWwuY29tPg0KPiANCj4gQnR3LCBJIGRvIG5vdCBzZWUgdGhlIGluaXRpYWwgcGF0
Y2ggaW4gQmFydCdzIHRyZWUuIEkgc3VwcG9zZSB5b3UgbWF5IHNpbXBseQ0KPiBzZW5kIGEgdjUg
b2YgdGhlIG9yaWdpbmFsIG9uZSB3aXRoIHRoaXMgZml4IGFwcGxpZWQgaW5wbGFjZS4NCj4gDQpZ
ZXMgSSB3YXMgbm90IGFibGUgdG8gZmluZCBpdCBvbiBhbnkgYnJhbmNoIHlldCBzbyBJIGp1c3Qg
c2VudCB0aGlzIHBhdGNoIGJhc2VkIHRoZSBvdGhlciBvbmUuDQo=
