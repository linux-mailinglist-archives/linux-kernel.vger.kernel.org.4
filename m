Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1999B698FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBPJZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBPJZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:25:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0819227BA;
        Thu, 16 Feb 2023 01:25:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDjlh2Ea5fdQoyNCVnKBvkxLn7GBaWZuB0OcuTJKcs+Z1RJp+AKIhKlvGYmoBWYU+dWS32lMQ+MOnN4DXEdSsB+jNAjpDg2ji6uUobQT/QOloNohznmBmyfmhbKte8pIVL90H3ygCqdMPKX6sIltnkZSej4VoZGoz8DbS+mYLmu+rSFueC8pOk+gu/tbukCkyZA5lpnrw2PmTTJ8t8Q0DtkBnYGX/6p6zE2b8A+bNU7t1vzIihH0Pi4OwAEtDfqhxINYQOJNbtZYmxUz5kwMxw/6vvDP7UlMeOkXgS9EQEGa4eEGLrM7x/Wud/En/1SNg88/Hil+OVf85F/CkPPBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUfXYBR7mW5olX6CiLZ97hbDK2CbD17PsuvjBq4u4iY=;
 b=Mq1FEzURN8QYOsK2jwQMlaIvR9Fp0JFj524pLfilIYTEKI+29reXm+jlQTHDyXnOma6GY+btiORr8U2igvFgSRckcoNMJKbQQHg8S1FrH9cBdMr3XiE3XdclRNzAoNnBhsPvu9WyeTmdIqB1lIUU+bct2mDurqJz9US1rvv2OtvDzevqDV9PdlhW1ULucHztvySECMfzKZWywpPJSKi4iSUBdcD3+jmsp+3CZUMX+JIs7m9jZU2xKlLwFfI7uAV41XQtAUHx/LDYKbcyWZyve2TWddH5Cony7AGTubN6P3pEmQvdiR9g8yJR2Gdi3r8U9rc6kxnzrkFRKjqhGboKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUfXYBR7mW5olX6CiLZ97hbDK2CbD17PsuvjBq4u4iY=;
 b=zFWOjB++G51nOs6cdQ788URCXTvB00MXHk928ySV9stOsgtnMoxl3al7KdJRiayX70eGhV6GHgj1yfUNtbUZ5csANb+2hx2vzgKJKPyfY0GHiTh8x+wLF+BdPyqN9uikUeoXzq0t0I2CLouk8XUftiujGvJrICdo0KxcfAIM+A8=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 09:25:38 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::882:91b4:9e16:6d84]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::882:91b4:9e16:6d84%5]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 09:25:38 +0000
From:   "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
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
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v7 0/7] add support for CDX bus
Thread-Topic: [PATCH v7 0/7] add support for CDX bus
Thread-Index: AQHZNU/R42HTbcoQU0eH7h5/0tPKpa7QC+7ggAFYMQCAAADFYA==
Date:   Thu, 16 Feb 2023 09:25:38 +0000
Message-ID: <BL1PR12MB5333B8FB7324E6F35E7516359DA09@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20230131084049.23698-1-nipun.gupta@amd.com>
 <BL1PR12MB533354263F0C9A8D5234272E9DA39@BL1PR12MB5333.namprd12.prod.outlook.com>
 <fb380316-c8c5-104b-3054-a504f0fed6c0@linaro.org>
In-Reply-To: <fb380316-c8c5-104b-3054-a504f0fed6c0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=02b8d9b6-ca30-4893-883e-1008d90ca07b;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-02-16T09:19:40Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|PH7PR12MB6811:EE_
x-ms-office365-filtering-correlation-id: 1f9a6243-ff18-48b7-2655-08db0fffc425
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5mYpxZPs7kLu1V83CXO4UGQEKe/DJKcwtl3bP5h0xzEaZUlg4Kp8/Wk5QKV9jyf7CAc0GbolD/+aL3gWIxrdMCqY3pQLWz6y3wuIdBbjx+byEXvzX5k3mANF3WiRRh9HMK7QkGu1F/sC472Tnka4YPSF/rF6K5z53NPZbCyPM3bWcX/bjrEUWu7c8Zjp8JG7ckQe8sUY3Fk0NKAx3NwWRH1KmPgdHEo1hyI6u0ReT91ymioXx9mnORI+yN2L+jRHtFGHRXvr800Z33mUlmjEA26a8TJ/dSuQggDc7TKjd0r+t0lkXKosTnZs3yrRhCpeLemFdAizyIo7nVZUkpT7N83yg6clvuZvudbCLy6XvPR4MJ9NlRi7jyoyDYlZmKyOqjdLWMiyo3s8KGogp7USWW1WQ4xOhCF6RzTuJJZwjjdbyYJYPZXjWjOZO4/kFUanW7+kYqPU5MliCTYZV53gNL3dwvuWTFFq6oigEaiXoG0zGvTCiG43N1WnXLC1WUIi7jXXdKLv7cyMVKXZrlx7HCLhhUukXpszBXyOwsZq6FZp1Jg1Vd1wwwIObsYiDHK3CZwYNmrrWiM/pPE1aE/KfESzyGZlfTTied2Lpi+04LwXxEXBD/OcswakNADj1hodGCtZaVQmHFOczPS8MGzxpYcXwDFKWxdgvzme7E4qSm/agMqK/nJjwNJg8W9ZQoLuiXUDWY3a2W1G9NaH5WuqEYj6sJOyHijLMTVGq4yvck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199018)(66446008)(64756008)(76116006)(66556008)(66476007)(38070700005)(83380400001)(8676002)(921005)(4326008)(41300700001)(38100700002)(66946007)(52536014)(316002)(8936002)(54906003)(7416002)(7406005)(4744005)(110136005)(5660300002)(122000001)(7696005)(33656002)(86362001)(2906002)(71200400001)(26005)(55016003)(186003)(478600001)(9686003)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1BNNUpwVWpOckhtaS9aYXgwVG9MMjhQUWp5S0w2dmJ2Tms2Y1FHY0kyQ0pK?=
 =?utf-8?B?WHRTWVJMbS9RVzhFS2o0M2hxZ0dqK3I5S3ZjODh5UVZ3YTQ1OHhuUC9jUnNr?=
 =?utf-8?B?M2puRFZtdXF5TGNCcXA5cTVWbmNTcWtvWU9MRDIyckhXdkxqZThjc1BPWG9B?=
 =?utf-8?B?ZFB4M0NuaHJmM2t3SEJIei9WdTNvRjd3UlJiU2JZWEtTdEhuZWNYV3hOL0RW?=
 =?utf-8?B?V3dPMlRhcldKK3FBL282WjdFQktGVmlEbDRsWkRaOStrdzliZmxyckxOaFJW?=
 =?utf-8?B?MWpDa1l1K3YyQ2FkMFZTbTFhRTFhZC9oa0VaYWVBZm9Ta3NuNmZnRFo4ZEdu?=
 =?utf-8?B?enZqT1QrWC95VXU3bEhGVVJLTFV5RWJWRlNBcHRITzdVcm9SMndWczF0K05v?=
 =?utf-8?B?Ulk2MEYyRHZ5WWxXYlRtc24vVHFsalZDUmpoM3lJc09BWUM2SjFPbVFWbDFV?=
 =?utf-8?B?bmZaNURBR0ZNUTRQOVB2K1RZUlFNY1kvbGpJQ2Zib2xMdDE1ejVONDZ2ZE9G?=
 =?utf-8?B?Z00yY2M2MzUxQ3ZUZUZpbFdXWFRrcEY3R1JiVnpYVEdQMXJEbU95MWZDNU4y?=
 =?utf-8?B?WURURDhHZjExWjNHNnlnNWYzcENrNUJPWHdna3NkNVVKUTR1R05taFBLb2xh?=
 =?utf-8?B?a1FxNVl1TjNLLzVTTzlha3N2b0lqSEJNVzJxZEFnb2QwRi8xamVpWGs5RzBG?=
 =?utf-8?B?WHFGdlg0bnpZa0d4d1g2Zzh1T1MwQjJlSnRpakdzNE9UajJFWjBBWWI1cUZh?=
 =?utf-8?B?OGdsU1g3MTIzd0xvcUlsWDBPYWhZU3hFRkJTOXdoSlZYL0NoaWx0NXV4b1gr?=
 =?utf-8?B?Ynh5dHNTa2ZBK3BabVBEN0lIL3ZhL2hDOUozcEk3MmNnaW5WcXovVGZ6RjZ3?=
 =?utf-8?B?SkhHaGovSzRGcjlPSllUdDZUdVJPZU5YQVEwaHFZdzNaQVR3OGdTNWJRUkk2?=
 =?utf-8?B?NDRNNHpBNHVCMC9Eb05ZNWtjMFZyNFpzeVptQjNIaFk2aExIdGtjKzBLdnFM?=
 =?utf-8?B?NklrY1lLL3F1R2ZXUE4rRS94MEFNZXhsb1kwM0pqMzF1bWRTb0hyQTNsTTgw?=
 =?utf-8?B?aUNhNG5qc05ncE9uMlIxSDlTZXFGUnBYdTlyTlpWcUlzTGxZUk90QnpyamJQ?=
 =?utf-8?B?Yno4RHFXVkRCQW56c2VwVURpTGpjWTE0MUVLcCtTMGRCV3hPeDFHSjYzY1Vp?=
 =?utf-8?B?ZjFZajNYMHZtdTNrb2owcXNrUzFjNGN6SmhyWmVSQjg5TVZvVmxFWW1IcXFa?=
 =?utf-8?B?eUVMeVJzWTBseFIyeFc4T2FZak5GY3JZcUg0N2lIOXUzMTJBUE1LOHB0d0p1?=
 =?utf-8?B?aGMvZXRLSmlsR0cwR3hiWS9GNWZRQUJkS1lONnQvV0p5Q1Jwa3U3Nnl1YlFi?=
 =?utf-8?B?WVRmejczbnVKckNWZ3B4aGxUc0laN0hhUmVFNE01Q2czQThsV24vU0pQVkFK?=
 =?utf-8?B?RlR2ZkRKVmZjYUZZV243VzFkTzhiWkFnSS9NN0lFM2Q1WkYydWdZVDhTR0Zx?=
 =?utf-8?B?cmw5a2gzd2JKNkd6T28wQTJJY0tQSXpyZlEyeEtpOVRueTNrYkl1L2h2aHlE?=
 =?utf-8?B?Nm0zM0dYbExWT0Vra2VoYTR6QkkrbnNHTG9laVVObm01ODZsZUlZNFJDMm9o?=
 =?utf-8?B?aWgrcTlaQms2MzRDVmRGZld5dzZXRmYxd09qUjRiZ21HMHFoc1lJa0l1SDNu?=
 =?utf-8?B?c2tqeXE3aWo5Y255aC9QaUl1MGs3VlZkMWc3RjVzbi9uSjRtNGZCVDBjOGJw?=
 =?utf-8?B?Umh6elZRNUJ5WWJYZExxNjFRS0NHUDVWU21wc2d4dncrZkZIMGxQaXoxbEND?=
 =?utf-8?B?TGRlWjNKcjljT2JpUUtsVVhKTUpyc1ZVMTNPRzl1QTY3YkZrd0V3UEx6Vlky?=
 =?utf-8?B?ZnhyeXpzSXViUGpHZk9uS1lLY1p1YkcrTjA2Y2xWelpEZjRHeW03UEhFTnNy?=
 =?utf-8?B?RktINDdJQ3pWaGc3bDBvTC9ORUlJaVU1R0dXNVlmMk1oY1ZFV0JrS1UzNTkr?=
 =?utf-8?B?T2FoVFBYRmxRaWFmM24wa1BINDdUN2xialFNMVNOMkpzY2l4ZExHYlFkMzZh?=
 =?utf-8?B?anN0cWtaTW5kSW9JblM2UDhRVm1ITHhNRElQTVhOOWxVVzVJYmxaejhFbkVE?=
 =?utf-8?Q?txxM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9a6243-ff18-48b7-2655-08db0fffc425
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 09:25:38.4746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcgWk7YLI8dNEz013hbmfDTa1VFh9K+A5zt1FtXumN8TXhiZIrFDY1kKWQAOlFd/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gMTUvMDIvMjAyMyAxMzo1MiwgQWdhcndhbCwgTmlraGlsIHdyb3RlOg0KPiA+IFtB
TUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5lcmFsXQ0KPiANCj4gV2Uga2VlcCBzZWVpbmcgdGhp
cyBpbiBvdXIgbWFpbGJveGVzLCBzbyBJIHdvbmRlciAtIHdoYXQgZG9lcyBpdCBtZWFuPw0KPiBU
aGF0IGZvbGxvd2luZyBlbWFpbCBpcyBhbiBvZmZpY2lhbCBzdGF0ZW1lbnQgZnJvbSBBTUQgYW5k
IHlvdSByZXByZXNlbnQgdGhlDQo+IGNvbXBhbnk/DQpNeSBhcG9sb2dpZXMuIEl0IGlzIHRoZSBk
ZWZhdWx0IG1haWxib3ggY29uZmlndXJhdGlvbi4gSSB3aWxsIGdldCBpdCBmaXhlZC4NCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
