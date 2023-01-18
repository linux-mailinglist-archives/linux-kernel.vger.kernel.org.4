Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3771671D41
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjARNPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjARNPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:15:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983994AA4C;
        Wed, 18 Jan 2023 04:39:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jomtmYduHNg99nB+fv4hKIXdtNOCBHBwIqPKioE1oqlUwJeTpYx+G71gLhUFciN7eFSK20VJfBlq9I5m29xcEuE0BC6EesbtAiwjv5dENu7VVxwhzVzUfQv1QIVsVTE+n0zIW6Gzd7xTK8V97xs49z8/hnGGK9oCad/Zu/CJMhRPnlhPEYC2C16tzRkO8LAYmyW4f5bhGzvIFArDW5WSPzErEkPJN2ZkrJsZOKmTXQEG42QSOTFMn88Sgrq5+La38dBPhNXNcrhwXKMmAqWTFbhjgd6grDXWUzhrsFW94A1FAyfJm+mVVyCqwrs9ZESFoZQXW+qkphwXlLC4WHkhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGXOcYsLFd2V8juXLlehiMc+8PY0tWMb7Nyfppjq7MQ=;
 b=PXT9MzorX+8wn76wyum8mDTbNfh5Wq7uZaAixapp7Z9q1YtomlLqiJicBaWaRsfFO18dxxDWGjYvl/WAFf2Ds+l46M+c3CXEZRzWWb47f585kIaGrceJXEPcbP59bhCPRynaUd8y0R6w0TZ+BxCcpPaEcVUl0E6QAsCoXhaskZs+XHqQqUaM83hLr7oDy+U3rVDYJ343EcWdY2gMcgDqGuAfOHCF+xvrFBWkq3TNGbQKGw/344WcnieIzr4MHDRgmipqXbNKIS11cZZTxECqPJEuyoaQTZMrIafouCZMISHw0TYithWgA0JQLqiBUCyoKr/LRIuW8et+ggymL4NQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGXOcYsLFd2V8juXLlehiMc+8PY0tWMb7Nyfppjq7MQ=;
 b=3q6PuYuFnFIaTyUt27awleZVYZORCPhtiRuXyfAwxsrbEWQDu35tA/2JzSD+5LyjtXm6YyPJy4a5iij4dwJjK11HIKvpGAGmns8wALHil0vp8+7Hy04P3qzhxthITHnyri1n+wDYPxHBzVNGyEpTCH4+55JNMjkchBXcKQ4N4S8=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 12:39:08 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 12:39:08 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "jeffrey.l.hugo@gmail.com" <jeffrey.l.hugo@gmail.com>,
        "saravanak@google.com" <saravanak@google.com>,
        "Michael.Srba@seznam.cz" <Michael.Srba@seznam.cz>,
        "mani@kernel.org" <mani@kernel.org>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 03/19] dt-bindings: bus: add CDX bus controller device
 tree bindings
Thread-Topic: [PATCH 03/19] dt-bindings: bus: add CDX bus controller device
 tree bindings
Thread-Index: AQHZKnmKvFQEkQFz/ECMo62YIPjOMa6i5IIAgADRRhA=
Date:   Wed, 18 Jan 2023 12:39:08 +0000
Message-ID: <DM6PR12MB3082BE8616F773B990146866E8C79@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-4-nipun.gupta@amd.com>
 <5ebee797-aa87-8db4-228c-dfe236ad32f8@linaro.org>
In-Reply-To: <5ebee797-aa87-8db4-228c-dfe236ad32f8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-18T12:39:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1a38841c-7a26-491b-b1bd-561de9d53a92;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3082:EE_|CH0PR12MB5139:EE_
x-ms-office365-filtering-correlation-id: b2e66483-0c54-41bd-c9c5-08daf950fe60
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QqRxXXPO8nRax3nUUrizbKgHy4Cpu85jwvb62C3wKl5LBJ2AdXNkosKYFgkuEtyV7+WPqFGR376NiAgbO5GYJEQdiB+dkYUk3nnIIHi8FGj4BhQ//DIEZmGkOIVWFYJXnZOK8KdXlS210zfpMAXhMeOW1kCXdVpIRjTYBN8LNWjTpN0OBsVqJNDBNhMQlxcG6PQpJEc9s15aLo8lnBhqDX6dzhuyQIXZuOnaM+nwuVLW4QZhdpeQ+D0frGVkcgjLELpoGOhWmpuG7PmuKIA2uTVP852N63dCvRiwxdrwLyo6grUzmZKpGVLltiIIZeIHTJ9g2+bJmyKfm/zn8yq7+YYFEj8gSysTeVCFfHWuOGVrjMB1gVO+p1Y0KYdqfmS/QE70bg4XJXKA6J6Ksq5SNQJq7noTjdDIl3hAD/+RBcPpQCabn1NwOwD6Vd9s9WcVcGxP2xz8/G7hn83X6b5rrtHxG6bB75gvvNP458knuHp455IGzSPDYqKriXpk82T/5ReWOTmnSbaDeIB3U/fYahT4SmNWJx6B2Qx2Eyb2G4hQ3bg46yIc/YMNtzK0zLYnF/ZSBZujvKqeplT01FFOQlgZ6worKxj0/Q9fHwFGIHvjMiMgkZgQFNwxvE005H+sHZlOsRGtT3Ugd7QpBH6tiqwigJoLeR3QrO3gw+Oq15p9hPTji9HP935ZeYbMfe0KD5rp46nQ3/9VsLKVDnPiOTTmoSDa+YiGZpvtFvD97XBLBTYoOS8ON1mPR32puTqqYoXa7l0lbPIxV7O5HdJ2J9dqQiE6M6J8Wo+5qnkUJ4g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(2906002)(52536014)(8936002)(7406005)(5660300002)(7416002)(66446008)(83380400001)(8676002)(64756008)(66476007)(66946007)(76116006)(66556008)(86362001)(4326008)(33656002)(54906003)(316002)(110136005)(71200400001)(41300700001)(7696005)(26005)(966005)(186003)(6506007)(53546011)(55016003)(9686003)(38070700005)(38100700002)(921005)(478600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3pvUXdDZ1BpdVU2UTJiaXRLdDB2SWtyOXhuYzlHS0xnYjB6NkhBYmxFNXMx?=
 =?utf-8?B?K1FzaldTVVZtajlkeUxGMllDRmw2RFJXNmZHTmpqRGlvdkhoU2ZCSXhldXRT?=
 =?utf-8?B?WkQweklMWFV4TVRRTFhUWjZMNXVQUkhnaGU1NHN1WnZieklKQ3hESGJkU3c4?=
 =?utf-8?B?SEpFOXJQbURsaGlRL3ZIbnVlSGwrUHFvYThyV2FmQjhpSS9IOXVGRk1wTm9V?=
 =?utf-8?B?YXhSSXd1M2NiM0t2RzMrWmQrendTYmZINGlIZldBOEhSQWhDSTNmZFdKNGZj?=
 =?utf-8?B?S1V0QzlnWjZQZmp6VkdjWGtPeWl1aHJ2RnpxdWgwRm5RUk9RczdaeFZhd254?=
 =?utf-8?B?TXB5MU9Ma0JmL1c2V0ZJYXBDN3MyaU9sMmNzVStzaXpacmNxNExUNk1nb1dt?=
 =?utf-8?B?cUZYVGpUT3lwblUzWjVVT1RLUVdHZGJGYkdJT2FZejhPNGtFNjhWZ0dQV05P?=
 =?utf-8?B?S1NCTVhkL3NVS1d4Q0xHTWN2aUJtMk1DQ1k1MlVkbG1heG95b3haSTdnYlBS?=
 =?utf-8?B?RGFvaGJGL1VJTHZ4RzN5QnhDSE5FNG1TSHB6TVliWjZjSzYxUmdGM01mbTNa?=
 =?utf-8?B?WjV6Q1B5SmM0V2h4Z2cwOWxEcG9NOGtFN2FhVnBoR1RnUzduRU9IVUs3dTlu?=
 =?utf-8?B?MFIxejY0L08rZmdVd1hUeklDMHlsMjlDOVVWcnJMajVnWTd5U2VtQ09GeXFO?=
 =?utf-8?B?T0JHaHZFM0Fsa1g4ZlZ1VVBlalM0U0ExTEZUOG95MzV1RERYNXpTOUVsTmVm?=
 =?utf-8?B?WG81QzhZNG8vRkt0Rys0b2xnMVNCQUp0YXd5Z0czemJXSjVncUQ4dUltUGZY?=
 =?utf-8?B?RnlVUGpVbjVRditsWUtNQmdNaXZ1MEx3NENRREh4TTBTSWJPQU52eUxUbXZ1?=
 =?utf-8?B?cUd6WE4raWhSMkpMNEVoNG5SaUN1c0tVT1RXeTdhSTNJRVpiN2luY3B4eWd5?=
 =?utf-8?B?VUxYZXlFeDVnSDJlK2Uzb1g4YmR5QlRkaEFCcHdGUFJwWDRNMGtxcDNiK0J1?=
 =?utf-8?B?bUh1bk9XaTJTQnNraVRBUWJ4QllHRDFXUVJSckZzRGlrZnBiZmkzQ0lUR2tD?=
 =?utf-8?B?bzdjWVkrQUJXN00zV25mRUpWamk4Vm16V1htMmlxc2krc3c0OThIV1Q0WXZ0?=
 =?utf-8?B?TUViQXhoL295cUFab1EvUDlQdWxvTkFqV0tUSG91WWNiQWtwTkp0b0FZWHBo?=
 =?utf-8?B?VFpURnJJbjBkZytIOFc0UGFHYXBnRWdEd2E1S08xdzVjS09sUVJtRVZ3K0FF?=
 =?utf-8?B?NUszVU80YW9WUGszZXlHVStNSFNEV0l5WkdCYTlCU0FUdnhianFGL05qUGRv?=
 =?utf-8?B?MTJQNUp2UUF3TzdQdURkUHpwSEdXbENlSWZzM01DZjk0MGNVNlRIdm82aVhh?=
 =?utf-8?B?eTQ0S0d1d2RPWVU2cVVuSmxodCtzWDk4d0c1dS9FZlB0VE5VVGVTYmZSbno1?=
 =?utf-8?B?SVI5MzhjSWp2R2RNM1g1UFh5VndLQmhNOVAxSmwwUmx2YUduYkR2djJNdXIy?=
 =?utf-8?B?LzY2R3lBdnlvbGZpdUNGTVdGSXFLNXNUTDdmelkzOEtPbnNyS0VrRGVoejBI?=
 =?utf-8?B?SUlQSnZaa01xNmdjUHl1QTJUbGNWNW80SmIvZFlHZ2g5K2RnYW1IRTdOaHU5?=
 =?utf-8?B?T2lYcWhxcTIzZzd5N3BkNVFqQ0F4ZUZkOS9KNnRRMEl5dzRabXdoMDVkRWxV?=
 =?utf-8?B?OGZHek9ndmMvdkJVK0ZqM3dFMmxEOUh2SlJrQTdYaWVnRWkzdDBBWnNnWHdC?=
 =?utf-8?B?elFtZlc2UTZVNXl0eEUweHRDU1hlYTJkYUx1b0pjRjRJM0duS21reTNhc3E1?=
 =?utf-8?B?aGZTU25ob2I5THN4dElET2pUcUFBUzUrRlFWZ0t4aysvRHFkUndnaEZocURt?=
 =?utf-8?B?N1ZndXMxTFhXZTV6Q1BNd2Fxd3NNdjlqV2ljRVY5cUQ5czdlVnNHNFA4SFA4?=
 =?utf-8?B?bTdvSzNtMGVSc2dGWW41dUJxNWt3cGlqbS9XTEtCR1NNTUtaZXhkNzZhOXVx?=
 =?utf-8?B?TVN4bkZuZ1lJVnhoNTltUVZjd1FzZU1SOW50ZkNIZVltSURrQVZsUWhaN1Q3?=
 =?utf-8?B?NUxVUEZ3aTRRaThTN1lXVC9hdFRyZ3B1VCtubnpHbHFyU0I2Znh0c01uVkJi?=
 =?utf-8?Q?3Ics=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e66483-0c54-41bd-c9c5-08daf950fe60
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 12:39:08.6333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoxNvTysDx/6f6XkshidRY8nqJOMKYSiDMPuNFAfDQSw0IgNd4AL3bMxZGRpOFeK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3ps
b3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAxNywgMjAyMyAxMToy
NCBQTQ0KPiBUbzogR3VwdGEsIE5pcHVuIDxOaXB1bi5HdXB0YUBhbWQuY29tPjsgcm9iaCtkdEBr
ZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnOw0KPiByYWZhZWxAa2VybmVsLm9yZzsgZXJpYy5hdWdlckByZWRo
YXQuY29tOyBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsNCj4gY29odWNrQHJlZGhhdC5jb207
IHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tOw0KPiBtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3Jn
OyBtYXpAa2VybmVsLm9yZzsgZi5mYWluZWxsaUBnbWFpbC5jb207DQo+IGplZmZyZXkubC5odWdv
QGdtYWlsLmNvbTsgc2FyYXZhbmFrQGdvb2dsZS5jb207IE1pY2hhZWwuU3JiYUBzZXpuYW0uY3o7
DQo+IG1hbmlAa2VybmVsLm9yZzsgeWlzaGFpaEBudmlkaWEuY29tOyBqZ2dAemllcGUuY2E7IGpn
Z0BudmlkaWEuY29tOw0KPiByb2Jpbi5tdXJwaHlAYXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnOyBq
b3JvQDhieXRlcy5vcmc7DQo+IG1hc2FoaXJveUBrZXJuZWwub3JnOyBuZGVzYXVsbmllcnNAZ29v
Z2xlLmNvbTsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
a2J1aWxkQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBva2F5YUBrZXJuZWwub3JnOyBBbmFu
ZCwgSGFycHJlZXQgPGhhcnByZWV0LmFuYW5kQGFtZC5jb20+OyBBZ2Fyd2FsLA0KPiBOaWtoaWwg
PG5pa2hpbC5hZ2Fyd2FsQGFtZC5jb20+OyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1k
LmNvbT47DQo+IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDAzLzE5XSBkdC1iaW5kaW5nczogYnVzOiBhZGQgQ0RYIGJ1cyBjb250cm9sbGVyIGRl
dmljZSB0cmVlDQo+IGJpbmRpbmdzDQo+IA0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2lu
YXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4g
b3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+IA0K
PiANCj4gT24gMTcvMDEvMjAyMyAxNDo0MSwgTmlwdW4gR3VwdGEgd3JvdGU6DQo+ID4gQWRkIGRl
dmljZSB0cmVlIGJpbmRpbmdzIGZvciBDRFggYnVzIGNvbnRyb2xsZXIuDQo+IA0KPiBTdWJqZWN0
OiBkcm9wIHNlY29uZC9sYXN0LCByZWR1bmRhbnQgImRldmljZSB0cmVlIGJpbmRpbmdzIi4gVGhl
DQo+ICJkdC1iaW5kaW5ncyIgcHJlZml4IGlzIGFscmVhZHkgc3RhdGluZyB0aGF0IHRoZXNlIGFy
ZSBiaW5kaW5ncy4NCg0KQWdyZWUuIFdpbGwgdXBkYXRlLg0KDQo+IA0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogTmlwdW4gR3VwdGEgPG5pcHVuLmd1cHRhQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4g
IC4uLi9iaW5kaW5ncy9idXMveGxueCxjZHhidXMtY29udHJvbGxlci55YW1sICB8IDY4ICsrKysr
KysrKysrKysrKysrKysNCj4gPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKykN
Cj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9idXMveGxueCxjZHhidXMtDQo+IGNvbnRyb2xsZXIueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9idXMveGxueCxjZHhidXMtDQo+
IGNvbnRyb2xsZXIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9idXMv
eGxueCxjZHhidXMtDQo+IGNvbnRyb2xsZXIueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5iMmYxODY4NjQwMjENCj4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2J1cy94bG54LGNk
eGJ1cy1jb250cm9sbGVyLnlhbWwNCj4gPiBAQCAtMCwwICsxLDY4IEBADQo+ID4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwg
MS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2J1
cy94bG54LGNkeGJ1cy1jb250cm9sbGVyLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IEFN
RCBDRFggYnVzIGNvbnRyb2xsZXINCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAg
Q0RYIGJ1cyBjb250cm9sbGVyIGZvciBBTUQgZGV2aWNlcyBpcyBpbXBsZW1lbnRlZCB0byBkeW5h
bWljYWxseQ0KPiA+ICsgIGRldGVjdCBDRFggYnVzIGFuZCBkZXZpY2VzIG9uIHRoZXNlIGJ1cyB1
c2luZyB0aGUgZmlybXdhcmUuDQo+ID4gKyAgVGhlIENEWCBidXMgbWFuYWdlcyBtdWx0aXBsZSBG
UEdBIGJhc2VkIGhhcmR3YXJlIGRldmljZXMsIHdoaWNoDQo+ID4gKyAgY2FuIHN1cHBvcnQgbmV0
d29yaywgY3J5cHRvIG9yIGFueSBvdGhlciBzcGVjaWFsaXplZCB0eXBlIG9mDQo+ID4gKyAgZGV2
aWNlcy4gVGhlc2UgRlBHQSBiYXNlZCBkZXZpY2VzIGNhbiBiZSBhZGRlZC9tb2RpZmllZCBkeW5h
bWljYWxseQ0KPiA+ICsgIG9uIHJ1bi10aW1lLg0KPiA+ICsNCj4gPiArICBBbGwgZGV2aWNlcyBv
biB0aGUgQ0RYIGJ1cyB3aWxsIGhhdmUgYSB1bmlxdWUgc3RyZWFtaWQgKGZvciBJT01NVSkNCj4g
PiArICBhbmQgYSB1bmlxdWUgZGV2aWNlIElEIChmb3IgTVNJKSBjb3JyZXNwb25kaW5nIHRvIGEg
cmVxdWVzdG9yIElEDQo+ID4gKyAgKG9uZSB0byBvbmUgYXNzb2NpYXRlZCB3aXRoIHRoZSBkZXZp
Y2UpLiBUaGUgc3RyZWFtaWQgYW5kIGRldmljZWlkDQo+ID4gKyAgYXJlIHVzZWQgdG8gY29uZmln
dXJlIFNNTVUgYW5kIEdJQy1JVFMgcmVzcGVjdGl2ZWx5Lg0KPiA+ICsNCj4gPiArICBpb21tdS1t
YXAgcHJvcGVydHkgaXMgdXNlZCB0byBkZWZpbmUgdGhlIHNldCBvZiBzdHJlYW0gaWRzDQo+ID4g
KyAgY29ycmVzcG9uZGluZyB0byBlYWNoIGRldmljZSBhbmQgdGhlIGFzc29jaWF0ZWQgSU9NTVUu
DQo+ID4gKw0KPiA+ICsgIFRoZSBNU0kgd3JpdGVzIGFyZSBhY2NvbXBhbmllZCBieSBzaWRlYmFu
ZCBkYXRhIChEZXZpY2UgSUQpLg0KPiA+ICsgIFRoZSBtc2ktbWFwIHByb3BlcnR5IGlzIHVzZWQg
dG8gYXNzb2NpYXRlIHRoZSBkZXZpY2VzIHdpdGggdGhlDQo+ID4gKyAgZGV2aWNlIElEIGFzIHdl
bGwgYXMgdGhlIGFzc29jaWF0ZWQgSVRTIGNvbnRyb2xsZXIuDQo+ID4gKw0KPiA+ICsgIHJwcm9j
IHByb3BlcnR5ICh4bG54LHJwcm9jKSBpcyB1c2VkIHRvIGlkZW50aWZ5IHRoZSByZW1vdGUgcHJv
Y2Vzc29yDQo+ID4gKyAgd2l0aCB3aGljaCBBUFUgKEFwcGxpY2F0aW9uIFByb2Nlc3NvciBVbml0
KSBpbnRlcmFjdHMgdG8gZmluZCBvdXQNCj4gPiArICB0aGUgYnVzIGFuZCBkZXZpY2UgY29uZmln
dXJhdGlvbi4NCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gTmlwdW4gR3VwdGEg
PG5pcHVuLmd1cHRhQGFtZC5jb20+DQo+ID4gKyAgLSBOaWtoaWwgQWdhcndhbCA8bmlraGlsLmFn
YXJ3YWxAYW1kLmNvbT4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJs
ZToNCj4gPiArICAgIGNvbnN0OiB4bG54LGNkeGJ1cy1jb250cm9sbGVyDQo+IA0KPiBUaGlzIG1p
c3NlcyBTb0Mgc3BlY2lmaWMgY29tcGF0aWJsZS4gRHJvcCAiYnVzIiAtIHJlZHVuZGFudC4gSSB3
b3VsZA0KPiBhbHNvIHNheSAtIGRyb3AgY29udHJvbGxlciAtIGRvIHlvdSBzZWUgYW55IG90aGVy
IGRldmljZXMgd2l0aCBzdWNoDQo+IGNvbXBhdGlibGUgbmFtaW5nPyBVc2UgbmFtaW5nIGNvbnNp
c3RlbnQgd2l0aCBvdGhlciBkZXZpY2VzIGluIHRoZQ0KPiBrZXJuZWwuIEp1c3Qgb3BlbiBzb21l
IGNvbnRyb2xsZXJzIC0gU1BJLCBJMkMgZXRjLiBhbmQgbG9vayB0aGVyZS4NCg0KTWFrZXMgc2Vu
c2UuIFdpbGwgdXNlICJ4bG54LGNkeCIgaW4gY29tcGF0aWJsZS4NCg0KPiANCj4gPiArDQo+ID4g
KyAgaW9tbXUtbWFwOiB0cnVlDQo+IA0KPiBObyBtYXNrPw0KDQpDdXJyZW50bHkgdGhlcmUgaXMg
bm8gdXNlIGZvciBpb21tdS1tYXAtbWFzayBhcyBSSUQncyBhcmUgb25lIHRvDQpvbmUgbWFwcGVk
IHN0cmVhbSBJRCdzLCBzbyB3ZSBoYXZlIG5vdCBhZGRlZCB0aGlzIG9wdGlvbmFsIHByb3BlcnR5
Lg0KDQo+IA0KPiA+ICsNCj4gPiArICBtc2ktbWFwOiB0cnVlDQo+ID4gKw0KPiA+ICsgIHhsbngs
cnByb2M6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9w
aGFuZGxlDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgcGhhbmRsZSB0byB0aGUg
cmVtb3RlcHJvY19yNSBycHJvYyBub2RlIHVzaW5nIHdoaWNoIEFQVSBpbnRlcmFjdHMNCj4gPiAr
ICAgICAgd2l0aCByZW1vdGUgcHJvY2Vzc29yLg0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4g
KyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSBpb21tdS1tYXANCj4gPiArICAtIG1zaS1tYXANCj4g
PiArICAtIHhsbngscnByb2MNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxz
ZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBjZHhidXMtY29u
dHJvbGxlciB7DQo+IA0KPiBOb2RlIG5hbWVzIHNob3VsZCBiZSBnZW5lcmljLCBzbyBqdXN0IGNk
eC4NCj4gaHR0cHM6Ly9kZXZpY2V0cmVlLXNwZWNpZmljYXRpb24ucmVhZHRoZWRvY3MuaW8vZW4v
bGF0ZXN0L2NoYXB0ZXIyLWRldmljZXRyZWUtDQo+IGJhc2ljcy5odG1sI2dlbmVyaWMtbmFtZXMt
cmVjb21tZW5kYXRpb24NCg0KU3VyZS4gV2lsbCB1cGRhdGUgdG8gY2R4Lg0KDQpUaGFua3MsDQpO
aXB1bg0KDQo+IA0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAieGxueCxjZHhidXMtY29udHJv
bGxlciI7DQo+ID4gKyAgICAgICAgLyogZGVmaW5lIG1hcCBmb3IgUklEcyAyNTAtMjU5ICovDQo+
ID4gKyAgICAgICAgaW9tbXUtbWFwID0gPDI1MCAmc21tdSAyNTAgMTA+Ow0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
