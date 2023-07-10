Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC45674DC6F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjGJR1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjGJR1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:27:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8017E183;
        Mon, 10 Jul 2023 10:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWh9RO4YNVTelZto2ko8HYddOeMV6vrLxnI8fCWVuSTmFFtDpFJ0uQsvRQLrrH5LTbhJ4sXXhZNeanr70ewfHTrPxSsiGi7oKmBMo3/oIZmYmLztaQOyWc3OdJNNphp/+agM+Jpit4eQ5gHgRBfFHscZUYCVQwO70t92dFakVKZPmIrCETYDZpz2Qgqo7sCp9IfbWg1t2EvFIrNoREwD/zzgGo4vM8bQRsyP7YUCaKyMFZwBGRwkDkruAs5uEqauiETyzsbj6YwCCty9jbfgJdxGJdBzsMlCKWr0ChvOLI4+groot+uM9b5Vs/TQU8z6nbrONzJdL14ZGiyQJdzCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUg0zXeUudZ2yYg+Hvn3YaMA9NrAAW54/CGfkp+Baz4=;
 b=n/8VwbbEs+aHsoZKjckT/vEtg7bHlB6NgMWsnNlwtliXw2XSPLN91cv2pMnDXOwd3sIMyjx4qzikFuTWFQLZbtu9WCKn4FvuclKOwsDgbeoaXACn5F/VIV7C25w+GDlkqTxqPx8S8Pc7fgbKs1i1L2W2Tmns5XILsiZ1pgkG/EbVQQOVImgoywhIT2pHFb4YsYB+XcZO9b5/bzc6G/WowKe9ok4YPRon/TMu8mq6iEXOKIxLjQSDXOPej0tffLPUpfbFJ0wFXCYzzQXg9czzgh1+TsB0OfJk/bePvz6xDO+xNdNBXlYo2Qd9xS9vYYlQCUXI5zwdMIF/YljqaS+yPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUg0zXeUudZ2yYg+Hvn3YaMA9NrAAW54/CGfkp+Baz4=;
 b=pOPf2R4QdDtIpuqzZKHMWeOuZVXgY6QE+DsVu7Kj+ZY1JlN8AbEeC/hVTYksrDNxoABk9AfYySG5QhOfV85JBbWsXnCwmRho7anejhUQJnlPATI2L0eODPayKnYZCPssvZk0OsX3jJsQxBNvqV4Z3YrNICF1SLueXX+VxcnAlIPf87eaNLaH9eA8FHl2GBnaH7JvNYNSJd6bHrGjLifYc0OfHW0TIELm3Zc4HCmYHa5a7BphiG1hd3+2KiSH1a47LFPMrQOuuKDCT70+RCfxUE6KR4hSskePSa6pUnTu9bLf/yrEVhVBjGG7DGgAE53I76Hsf6HNs1mcKDwZ2ftUvA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 10 Jul
 2023 17:26:55 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ee7e:9411:ca2b:85e]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ee7e:9411:ca2b:85e%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 17:26:55 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] gpio: mmio: fix calculation of bgpio_bits
Thread-Topic: [PATCH v1] gpio: mmio: fix calculation of bgpio_bits
Thread-Index: AQHZXcoi7FLBwG/JU0q3FmEUxUR5K68J1scAgKoUF6A=
Date:   Mon, 10 Jul 2023 17:26:55 +0000
Message-ID: <CH2PR12MB38951D4AC0D3C373E17FDDBFD730A@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230323205733.20763-1-asmaa@nvidia.com>
 <CAHp75Vd4m79RhG-_KLRNzr0SPzphG07fOiTWwmGCfx8Lz=+6Vg@mail.gmail.com>
In-Reply-To: <CAHp75Vd4m79RhG-_KLRNzr0SPzphG07fOiTWwmGCfx8Lz=+6Vg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|SN7PR12MB6839:EE_
x-ms-office365-filtering-correlation-id: dc7f8efb-51e4-454d-26c8-08db816adb9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: asEqWiJwKaGDk1vdH7RmE+Q+zwwxUY8DdMKGRTB2lD9tvXJGRP4DUGXlvvflRmUFrSLTXBCEN2exKiDUfDBU9SFewv+qt/TeyUXzyIzvUBKcy58Zw175oB2LmtYqMKAIeJiTGtiFYhLb7FaJMf7hW32L0oFaZ+sK+iaZXrrVVbIQUGBXJIcEYV6qZSDFesx90Ab1x4GkuOW+i0LWYgVwkR/QbZEnHd6ujtEQ794ApYirzCIeHFFpb1t9sKavhFOQpzE1Mn54i5XMZ99Xu6PiaQQfJxzIa0cDsfRJNOupGFbJbeVBJPUgolVW8xzYMDK2Dnff8UkIG7RJyrFAJgIsRRDZPqI4dMCDkbB2ZvvJqmaO0zfQxyn+vTArv3iPfk2KO8PuaEWI+qMlZtXCiCYMErUo6p41dLkC8QWleZMLG8L/QI2XTBCnYLSL1iOrA4A6SlpJjulp5pWZN0m20WDN9pxCPVLPT5I6JC9YZIzSaPF7UpN9p2EK94B/QTZ8nHK+xw1Fa0WuRxT+dnyG6v08s31JxfcN+80lvWySrU5z+7dLz8E9P8ThQNFCajKiHbUxg8q7XJ3PjYHWZhacvB88wVt9Cyoo+Ozc6QL24wvMX1G5fy0WXc+GeD+JYfv6sAzG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(38070700005)(558084003)(33656002)(54906003)(6506007)(478600001)(41300700001)(8676002)(38100700002)(122000001)(110136005)(86362001)(316002)(7696005)(52536014)(8936002)(5660300002)(9686003)(26005)(55016003)(2906002)(186003)(66446008)(64756008)(66556008)(66946007)(71200400001)(66476007)(76116006)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1ZUWWFleklKMjltWE44OUMyMURsdCtOL25vK01Hd251aHRhek9pTVE5U0lC?=
 =?utf-8?B?aEdPNjhtd0VBcldYVkhBd3FDeVlLSk5TZTB5QzNRZ3lvNlZVWEtpTXprOEhQ?=
 =?utf-8?B?SnAxTE8zdU1MMjZHaXhZbEVqTStXTjN0ZUxsdE95SnVVa1gzOENNL2Q2SW9Y?=
 =?utf-8?B?dFNzcHpWYU1PMGlvNzhFYk14algyV2JSaU44WHZmR2UrRzU3MkJiZ2E1VVQy?=
 =?utf-8?B?cEJPdTlBU1c1ZXJCWE5iZTB6RWRLNE1LdmV3aERyTk01WkdHWEs0UCs2VFBY?=
 =?utf-8?B?UDY0b2ZFN1FrNjBUZ3YvN25QZHdQSVVqMzlwU0krRHRkQUVKU2dhbDNNbjUz?=
 =?utf-8?B?ckNIUFNYMzhxWDkvaTFxY09YOVNOUktoYlRGTU5qSG9mNVVtc3NWL3RkSWdv?=
 =?utf-8?B?OEJiNlVSWHRyZ1dlQzllUE81SC9zOHhxWFVMU1N2YjBJVkI3MGpldmpWb1Vi?=
 =?utf-8?B?OVRmZ0EzRlJsS1RNVitPTGNDUCs2amVzRkFBSGdYM3pISXU2dUN2TTZsMjhJ?=
 =?utf-8?B?TlBpZjduRkZIdlYySWM4RERvY05EREtiL2FKb0ZReWZIQ1ZZOGFZTG8wdjA0?=
 =?utf-8?B?ZXNRK0JRbUQzclF4YnFFcW4wekg3K202a0ZpTzNQTFV2VmtpS2E5K2dNWVE1?=
 =?utf-8?B?ZkJEelF0WG9NTXU1S2J0UlRhYWpkMmJKaUJBSjI1V3JPVnJqeFNxY21ZVjRk?=
 =?utf-8?B?M2p4UnJvMjFLK2dkcWdFWjlPVVJFZVJHdi83Tm5kM2lWRXp6WlVpRCtoalpY?=
 =?utf-8?B?QTNDZ2ptY1RWelNkR1dpOUtHUlNNNnNRRUdhYzd2ZGl3Ry9xaks0RU8vMlZu?=
 =?utf-8?B?anR4VjBIczd5UzFDWUpGVmw5VGNrcExteVAvVUNDY2oxRjdqUkROMmNPMllm?=
 =?utf-8?B?ZDFKci9pWklKd2F6S3VNeGplczNYSkx4YlF0VEk1VjljUHhib0NSclVKNVkw?=
 =?utf-8?B?eEs0Si9tbGtJZ1hoSDZ3TkxJRVRNdUc1OUo4d2I5WEZOcnBjK1NwTWFBV1RI?=
 =?utf-8?B?cXVUdFFmYjAyck9hMUlKbEx3Tm1GbWNyYUt5K2Z1Wm5meUtaYkl2UDROTlVY?=
 =?utf-8?B?WHVJYTJQdFFlOFFFaDZCUlFvSkxsZXJxS2d6dlFucWE3d09hMUc3OE9iQUha?=
 =?utf-8?B?N3pwV1hkaFRNRlBUWXZBN3ZnZXFmVURTYm04Z3RqZTZoVlZJR1g2WkVDb2VQ?=
 =?utf-8?B?YWxzMENxZkVSbDAxLzlITGlPcVRUb3FZUmt4TDBZWmorc1pzbW9tUC9xQWdJ?=
 =?utf-8?B?alk4dGdlaWxabXVvdDFIaGRKL3I0dVZjRUNBV1pmUkhtQVptSUlTbGJtWW50?=
 =?utf-8?B?bGZkaTVCblk1UTR6TUJpQ05Gb0RWcjQ2K1ZKMHRBZkdMY3NTRW5GUHVoUnJV?=
 =?utf-8?B?WjlBcCtDaFNXdG9FS0srbU1obld3N2JielJxSVk0NXlSb0l1MkJ4Ukt4RVg4?=
 =?utf-8?B?SFJDNVB2cnFOVG90NG9Qd1h0Zk03WUpKUjI1M09mVmU5VVlsNUhUWTdNTElM?=
 =?utf-8?B?d3NLdnY2YWtFNjVHYmFZUGt6L2JhbmUwdTd1UkxkeW85bks0SXhDdVpiY2tv?=
 =?utf-8?B?Z095anh4TkxmNEFQUHcwL01GN1BYaC9Vd0R4SGxtMUJubE1sMC9wNGlQRTFF?=
 =?utf-8?B?bzByaTRvZnVlK2kvRmdIdXErNUV0NUtieFhGRG4zeDdpSEY2K3dNbTZFa2FJ?=
 =?utf-8?B?RmpuWHRaZGlWbjVtczlYeC9GK1Z0RzhydWw0VER5WFAyWS9zM1duSVFRZ2VV?=
 =?utf-8?B?MkJsV1YvYVJzQXN1ZERjendwQVFjanhGZlZ4Z1pwTVZ4dms5YlB1UHIxZVAy?=
 =?utf-8?B?aS8xMzI4WDRieWRNR1VQRVVVb1dHdFZIbEJsV3g5UXhneXZZZWFRNlNQTk16?=
 =?utf-8?B?OE1BNVFGVlRIemorQzlsOGFBOHl0YTRzaTlLS2s2WlJRVWFtYUp1R0tnUXdj?=
 =?utf-8?B?R21BUXVpbVY2bGFONHJWbDB5b0srekwyb2wvN20xdHY0R0pJUTBFWnNOcUY4?=
 =?utf-8?B?OWxYTFlvRTZtTFpJTHdlY29lSDNBTG4rcFhkME42RTBpUnNlV2FVWFBJUFE0?=
 =?utf-8?B?N3NGOVR6cHFGY3hBeVNxQWpGUVhZUjZZaTk5eWFLNmZOc2pCWU9HQndLTGRK?=
 =?utf-8?Q?w4V0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7f8efb-51e4-454d-26c8-08db816adb9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 17:26:55.3402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3x4NClaAq+pG7dYqDGdIl4QdJ2OJsFn5uMtAkf1NEhiqH8k0smGDe2FKMzzzK/8Vkps84n0Z+KNvqd9UQsF7FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29t
Pg0KPiANCkhpIEJhcnQsDQoNCkNvdWxkIHlvdSBwbGVhc2UgYWRkIHRoaXMgcGF0Y2ggdG8gdGhl
IHRyZWU/DQoNClRoYW5rcy4NCkFzbWFhDQo=
