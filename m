Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855376F160E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345505AbjD1KxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjD1KxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:53:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49E6211C;
        Fri, 28 Apr 2023 03:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1NWgtZ0GXvUAILGOVvLWnEh9H2fJf/idq1no09kW0yUXCOzH52LcYPrRqGqQZhX2vIlVxsBZNbjkOL2jeFa1Qnq/SjUvBae+w9fU+ruVEDUIM97K4dPl4xIEuRX3nUfyD0BsppASa4ozfh7PQQzmy9QpkxdXjZPRTahNhppU4Fx4lQ8vBq1F5qtyodzl2o3A1GlQh7n+q1UQwXz648XbrWUzmCQyBAsRyx/6MSuvH9jOKPWBi6OejuGVfeqrTDcSIOMy7ZqH5rH15x7wiozydChtPiUMYlNtjJN4QRmc9ts+lenn4jjEUTp5bizCKPudvg4MHiDQspW/S4ggVrb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVvwChBsIZk9SMUBaNjJTIdfKnZk+DvN3bmBk0aHa0w=;
 b=REEz2akZbDfxNNNK7qQps0aHeJWJUFiHh7vwAEBF6IY6LR5DpuIQmWqwfoFzvqncxN73yM45mQMPosAlps/wQ7cGBhxVhfAycCUwZpW8D+7gSK8p5a4y+zLItT3ZVd90gQ9dEw8eiKBxsYbrqTW3ApmKSoCkghc6hHH5lF7x6fxEc6sr8RcHHnH2WK5G5PcY72J0RhagKzQ/5uyjehc/24X5jNSlCbwSpEsk/6eEPoq2mdAbWyMwH5WUmh2td35GUXxrHX5CQoNXeJAMcjpZldCtEL61MdJLhewebFGtPcXYaCkF49V3cXQFjJI150Dm19riCJXIeM+/xO1cvjRMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVvwChBsIZk9SMUBaNjJTIdfKnZk+DvN3bmBk0aHa0w=;
 b=uXs4GTsHNvwLs4L5255EB7z0LjSHyFxM3PMCcTaehoS2rdzvtct7RnrwIAUuidUGFUiTVS8Plsc21WUbthrN9moGssPew/zYbdXXwEfiyYXjaLYfseQOES+s0wUlYyjgPCKNWKmNaiStjOGkKLzMdTdFhMyToqZ3D6mI8e0YhIc=
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Fri, 28 Apr 2023 10:53:12 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c%5]) with mapi id 15.20.6340.023; Fri, 28 Apr 2023
 10:53:12 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Cascon, Pablo" <pablo.cascon@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v10 4/7] cdx: add MCDI protocol interface for firmware
 interaction
Thread-Topic: [PATCH v10 4/7] cdx: add MCDI protocol interface for firmware
 interaction
Thread-Index: AQHZVa+TJcCTWN6hGUeBrMCK1vQX8K9Ap2OAgAAsMJA=
Date:   Fri, 28 Apr 2023 10:53:11 +0000
Message-ID: <CH3PR12MB83085CE44374A0A37E860B66E86B9@CH3PR12MB8308.namprd12.prod.outlook.com>
References: <20230313132636.31850-1-nipun.gupta@amd.com>
 <20230313132636.31850-5-nipun.gupta@amd.com>
 <CAMuHMdWTCdQagFFANygMgA8D0sWaoGxWv2AjibC3vwSd0UxuRw@mail.gmail.com>
In-Reply-To: <CAMuHMdWTCdQagFFANygMgA8D0sWaoGxWv2AjibC3vwSd0UxuRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=f3681018-be54-4566-aba3-9346e8ae08f6;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-04-28T10:52:13Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8308:EE_|DS7PR12MB5886:EE_
x-ms-office365-filtering-correlation-id: 5fff80d5-d0fb-4e22-dcb9-08db47d6c2b9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SBiyf884QQzXO6kO6Mbo6fAK22G0ZwfVTBJYPutqomgEan/JusAQQ+mHFmeayhyIOxCAlSqsCZUZdYn4rdWMJP5lX5Vpr9Kl4DKw7WHki+AR1uVcJDK3xQHemy3XQ9kZzFdjKzMYgJABa/s2mZhFFOOhMAqgq/pUHnVeID8qSc3bnmKdlmM6N24Ft3XD8AY5VKuT8qJQmGpS4Xtyztd3Q8RYo+f32QrSA+1LM3Ea0X86l0+G+Fxt4ZpQx00gV8sQsTaVS4MPr0OZXI8Zpp1Akhg81Ba/0VxRgCIRJkr/zLOgR1BLZJ/9jL/g8g5W1mQuRU6m669ul/V/h72U9/yGtaFo2tS8tdBEU1dXCewwB6ad4fgEojcY7yyV3R3p1bApojUiDwdn1tcRpQ94Jw29OWHG2cOiM0JNIkrBa5jpvRggX7aK/VbOrZJYDBIP/t5ZYOyiUybq3dAhGB6nPwA7cUIMC9KmI0moQuhyyR7GQkZ64IdEZxCG6uUHrypRhI2FHjA0aLa3FzMWcPQ1pwYsGbLLSkJG4t7SqXYzya9CSHsDlFG2jvy8PD/jr0+AYXr0VI21tXVTBGW5H05n7POYDFiiVigbngfXlPB3RVgm4TU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(41300700001)(316002)(478600001)(122000001)(8676002)(2906002)(38100700002)(54906003)(38070700005)(71200400001)(7696005)(86362001)(64756008)(66446008)(66476007)(66556008)(8936002)(83380400001)(66946007)(7406005)(33656002)(7416002)(5660300002)(52536014)(76116006)(966005)(4326008)(6916009)(26005)(53546011)(9686003)(6506007)(55016003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SStxeGFUcGFpV25lNy83V2JxcnExTnZ5a2N5RDJBVVVoVEx3b0hORFF0ejJE?=
 =?utf-8?B?cUJFVEw5cS9xU2J6amtvUVJrMTdWTXpLRktzcGJSdlViOE44VFFiYUpzcXJv?=
 =?utf-8?B?RWtrNUpqSXl0Qnd0OEF6c1RsU0RrY2J3NWUrSkwyTDczU3BOZFdSWEt5M29q?=
 =?utf-8?B?N1Y4cURXZGkzSjVFTTZ0bzVKSWtrQjJkVmtVRGZ5NkpiYUNDMEl5MUlndjNv?=
 =?utf-8?B?NFhNK25LQmdqUkc4VEJVaVZYWTB3WTh5ajdtQ0o2WXdSTm5sL2RXZ0E5VVJu?=
 =?utf-8?B?ZkdTQ3YrYnhNQTltWWxIbDdIQ3A3cC95cURRTWFQQnVxMXZIOTdJajFFTHg0?=
 =?utf-8?B?S3R3d1VLQmd0b0g0NUFRenpYMDIyNFNWQnA0N0I5ZE9FazZpdGFPRnllK20y?=
 =?utf-8?B?RjVWeUpQRENxUUhmMVJEMHhMWDVMdnJiK2R3c1BjZjNhMTd5aS8yYnFOZ1BE?=
 =?utf-8?B?bjB0VnV5MDdyYWxtT25DMnBlWmljT3BvN0QwK0tOQU8rTnRLQjdTa0xwOWht?=
 =?utf-8?B?V0dsYWsxSDdCd0JvdUk0QURWTkpVMUxTdCt2Wk01V2FKRXI5RVN2MnlsNzRX?=
 =?utf-8?B?dXhkclNTbGJEeUV6UmJ3S2RPV09vdGNoNk03WVRzbXp0UFBEclBERzRGR2xn?=
 =?utf-8?B?N3ZHWE4rYjV6d09hY0FnbjFEK0c0WGYvQTE0SmExVlE5MzhKeWZWaVlhaC9i?=
 =?utf-8?B?eVE3ZnZuWVpWUGRLZmczNHgrblJKK0pTZDQwTzJ6RzlCbzdNMjExQmhXQmpH?=
 =?utf-8?B?aVEvTGJjSGFWS3pmUXhMZEV5NS9MelExTG54eG4zSUFjbDhWUXlrOFIrdmVz?=
 =?utf-8?B?QWxVQkozdEtIZ2dmT2xKTVUzdFVuY255c3Mvd3hIZUxFY25icEdoVVI2ekJK?=
 =?utf-8?B?RXoxRHNBbS9rZ3JvaW1ram0xdjIvMlFUZGpUYUV3dG91dWZHUkNoWm81WW9P?=
 =?utf-8?B?Z21yRGtZRVltM011R3IyKzMrSEttUWFtS0UxblRHNEZJKzVadkdqUWoyVnRC?=
 =?utf-8?B?R2psdEcrVU9MMGp4L0dsREdyVkdyMHI4dzcrblVwZDMydDhsNjBHTGNRbXov?=
 =?utf-8?B?MzhGT0RMWnhTQWk5bVBqeWk5T2orTWVua2Nwc3FDK1pmTHZWRXlpUjUwTSs1?=
 =?utf-8?B?QUk0MVdFU1BXQzdZSmN1K3lodGZaRlJ1MC9vRWE4NVFkSm1nU3JzUC9qSjR1?=
 =?utf-8?B?bmwvRjMzSXdmTlhic2xiM3JreEY3aDNqa2NLZTlobGI2TjVSdFZPeFdUcllz?=
 =?utf-8?B?dnIwTXd5ZC9aQWJJVkZld0VWVk9Odk03MU81YzJjbXV2QnNOeWdGQ0FwWDI2?=
 =?utf-8?B?cThFQTFXKzV0U1NBWXB1bGN4bXlNTnFDa1dQbnJmKzRMeUF1RFdVRDJITjlN?=
 =?utf-8?B?ZUd3U3ZiVHFSa0hYOUwzV1gyTEpuNWtTR1Y3YzdZRm4xR2cyMzFNcld0QS9Z?=
 =?utf-8?B?dHJuTGc3aDFlNDRHNVArS2twYW5sM1U5UiszSUQwTDFSWHZaMHE0YjA5c1FV?=
 =?utf-8?B?QitZK0RVVzY0NjNLSG54bDQ3TTNZck1kK09IVHJaQzBnZnF3bVgzeXFtaVNt?=
 =?utf-8?B?TU5YLzlZMDhqV2lsdG1GeVVPUUQ1c1BPakVETG1qcjBVdXQ4REd2blJSQ1F0?=
 =?utf-8?B?QVpaLy9MOVFva2d1aGd3cklTV2I4YmNNaCtwOHJBS1JTM2U5V0pDWUZxT1NZ?=
 =?utf-8?B?dSsraXVnRm1tZndZdU4xU2NFRnVDM3BxUDREdEVzUklsR2dHMVRVVmhzZzll?=
 =?utf-8?B?djZtNWU1RWlvc0RtWlJpTzBpQ0RxVHJmdjREMkdqcE04YVpWMXo1YXpmMk1J?=
 =?utf-8?B?MmVFVnVwMnJGSFgvdmR0endpVmE1MEdCNmkvSUJUUXhOdmk4ZDVyS0JuNjZB?=
 =?utf-8?B?Z2hkRGxzdVpsOFlvcHM4K2hHVC9lbXNScEZ2RlZWK1licW5iQkxyZ2ZNSXRJ?=
 =?utf-8?B?eWVTdWcwUFhrLzA0a2JEOUk5TVl4bnBOT2NrR3FYaHZPbUJNSmY5RXMwUTBq?=
 =?utf-8?B?NzZITXR3NEVCRnBzZWk1OGFQWEpsVFpGZDkxbFdjbTZCMUtpbG1pUEtqQ1Ru?=
 =?utf-8?B?RS8xNklvL1g3QVUzMWFob014R01JWlQyeUhqYngwekVYY1M3ajlTb0lSWTRE?=
 =?utf-8?Q?x77U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fff80d5-d0fb-4e22-dcb9-08db47d6c2b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 10:53:11.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frFiROxUDIEQ3+R0jiz4tAkpiLX60HcT1EkGyvvaijm5WEtGVUDmmaiZAlzEG0rD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYXJtLWtlcm5l
bCA8bGludXgtYXJtLWtlcm5lbC1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmc+IE9uDQo+IEJl
aGFsZiBPZiBHZWVydCBVeXR0ZXJob2V2ZW4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAyOCwgMjAy
MyAxOjQ0IFBNDQo+IFRvOiBHdXB0YSwgTmlwdW4gPE5pcHVuLkd1cHRhQGFtZC5jb20+DQo+IENj
OiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsN
Cj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHJhZmFlbEBrZXJuZWwub3JnOyBlcmljLmF1
Z2VyQHJlZGhhdC5jb207DQo+IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBjb2h1Y2tAcmVk
aGF0LmNvbTsNCj4gc29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb207IG1jaGVoYWIraHVhd2VpQGtl
cm5lbC5vcmc7IG1hekBrZXJuZWwub3JnOw0KPiBmLmZhaW5lbGxpQGdtYWlsLmNvbTsgamVmZnJl
eS5sLmh1Z29AZ21haWwuY29tOyBzYXJhdmFuYWtAZ29vZ2xlLmNvbTsNCj4gTWljaGFlbC5TcmJh
QHNlem5hbS5jejsgbWFuaUBrZXJuZWwub3JnOyB5aXNoYWloQG52aWRpYS5jb207DQo+IGpnZ0B6
aWVwZS5jYTsgamdnQG52aWRpYS5jb207IHJvYmluLm11cnBoeUBhcm0uY29tOyB3aWxsQGtlcm5l
bC5vcmc7DQo+IGpvcm9AOGJ5dGVzLm9yZzsgbWFzYWhpcm95QGtlcm5lbC5vcmc7IG5kZXNhdWxu
aWVyc0Bnb29nbGUuY29tOw0KPiByZHVubGFwQGluZnJhZGVhZC5vcmc7IGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbTsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgta2J1aWxkQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBva2F5YUBrZXJuZWwub3JnOw0KPiBBbmFu
ZCwgSGFycHJlZXQgPGhhcnByZWV0LmFuYW5kQGFtZC5jb20+OyBBZ2Fyd2FsLCBOaWtoaWwNCj4g
PG5pa2hpbC5hZ2Fyd2FsQGFtZC5jb20+OyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1k
LmNvbT47IEphbnNlbg0KPiBWYW4gVnV1cmVuLCBQaWV0ZXIgPHBpZXRlci5qYW5zZW4tdmFuLXZ1
dXJlbkBhbWQuY29tPjsgQ2FzY29uLCBQYWJsbw0KPiA8cGFibG8uY2FzY29uQGFtZC5jb20+OyBn
aXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAg
NC83XSBjZHg6IGFkZCBNQ0RJIHByb3RvY29sIGludGVyZmFjZSBmb3IgZmlybXdhcmUNCj4gaW50
ZXJhY3Rpb24NCj4gDQo+IA0KPiBIaSBOaXB1biwNCj4gDQo+IE9uIE1vbiwgTWFyIDEzLCAyMDIz
IGF0IDI6MjjigK9QTSBOaXB1biBHdXB0YSA8bmlwdW4uZ3VwdGFAYW1kLmNvbT4NCj4gd3JvdGU6
DQo+ID4gVGhlIE1DREkgKE1hbmFnZW1lbnQgQ1BVIERyaXZlciBJbnRlcmZhY2UpIGlzIHVzZWQg
YXMgYQ0KPiA+IHByb3RvY29sIHRvIGNvbW11bmljYXRlIHdpdGggdGhlIFJQVSBmaXJtd2FyZS4g
SXQgaGFzDQo+ID4gcHJlLWRlZmluZWQgc2V0IG9mIG1lc3NhZ2VzIGZvciBkaWZmZXJlbnQgbWVz
c2FnZSBleGNoYW5nZXMNCj4gPiBiZXR3ZWVuIEFQVSBhbmQgUlBVLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUHVuZWV0IEd1cHRhIDxwdW5lZXQuZ3VwdGFAYW1kLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBOaXB1biBHdXB0YSA8bmlwdW4uZ3VwdGFAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBUYXJhayBSZWRkeSA8dGFyYWsucmVkZHlAYW1kLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTog
UGlldGVyIEphbnNlbiB2YW4gVnV1cmVuIDxwaWV0ZXIuamFuc2VuLXZhbi12dXVyZW5AYW1kLmNv
bT4NCj4gPiBUZXN0ZWQtYnk6IE5pa2hpbCBBZ2Fyd2FsIDxuaWtoaWwuYWdhcndhbEBhbWQuY29t
Pg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLCB3aGljaCBpcyBub3cgY29tbWl0IGViOTZi
NzQwMTkyYjJhMDkgKCJjZHg6DQo+IGFkZCBNQ0RJIHByb3RvY29sIGludGVyZmFjZSBmb3IgZmly
bXdhcmUgaW50ZXJhY3Rpb24iKSB1cHN0cmVhbS4NCj4gDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL2RyaXZlcnMvY2R4L2NvbnRyb2xsZXIvS2NvbmZpZw0KPiA+IEBAIC0wLDAgKzEsMjAg
QEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ID4gKyMN
Cj4gPiArIyBDRFggY29udHJvbGxlciBjb25maWd1cmF0aW9uDQo+ID4gKyMNCj4gPiArIyBDb3B5
cmlnaHQgKEMpIDIwMjItMjAyMywgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLg0KPiA+ICsj
DQo+ID4gKw0KPiA+ICtpZiBDRFhfQlVTDQo+ID4gKw0KPiA+ICtjb25maWcgTUNESV9MT0dHSU5H
DQo+ID4gKyAgICAgICBib29sICJNQ0RJIExvZ2dpbmcgZm9yIHRoZSBDRFggY29udHJvbGxlciIN
Cj4gPiArICAgICAgIGRlcGVuZHMgb24gQ0RYX0NPTlRST0xMRVINCj4gPiArICAgICAgIGhlbHAN
Cj4gPiArICAgICAgICAgRW5hYmxlIE1DREkgTG9nZ2luZyBmb3INCj4gPiArICAgICAgICAgdGhl
IENEWCBDb250cm9sbGVyIGZvciBkZWJ1Zw0KPiA+ICsgICAgICAgICBwdXJwb3NlLg0KPiA+ICsN
Cj4gPiArICAgICAgICAgSWYgdW5zdXJlLCBzYXkgTi4NCj4gPiArDQo+ID4gK2VuZGlmDQo+IA0K
PiBBcyB0aGVyZSBhbHNvIGV4aXN0IGNvbmZpZyBzeW1ib2xzIFNGQ19NQ0RJX0xPR0dJTkcgYW5k
DQo+IFNGQ19TSUVOQV9NQ0RJX0xPR0dJTkcsIHBlcmhhcHMgTUNESV9MT0dHSU5HIGlzIHRvbyBn
ZW5lcmljLCBhbmQNCj4gc2hvdWxkDQo+IGJlIHJlbmFtZWQgdG8gQ0RYX01DRElfTE9HR0lORz8N
Cg0KU3VyZSwgd2Ugd2lsbCBhZGQgYSBwYXRjaCB0byByZW5hbWUgdGhpcy4NCg0KVGhhbmtzLA0K
TmlwdW4NCg0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3Mg
bG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4g
DQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNh
bGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0
cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo+IA0KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsDQo=
