Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4770C6F5496
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjECJXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjECJXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:23:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4213C4ED3;
        Wed,  3 May 2023 02:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEvyTgjWAZHHqpuW4Sa5PjkNhk6yW4zOctk3xDKal1b7y2x8Kta1hwWO+TSs92DVECA4PHPu65JC2F7q7jb5yprx3+ynk/8qTWhD3pJ57nHj7uFOid58A8dTVDHEVPH5+r1BWVjiDSrwFpSONkXyyO5ICR1E+wtZ8yxMXgaNixbc7pp/kLcotuwaNpn96i/IqHVbVQ7mZhb0yF4KCoI+oxKYGpaODzKo3jhLImcLMOKzcpSMAPjY4DNEWpuZvGTtxuwLtI7pO9liCzfkfGOqcF6IQOiEf/GJxgPFLAuFajzC1S08AVCuKztdxjkuy/5jOBk9a+G/qlFFcTzStf6scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCb8I/vmdLXVdB21Neuy3SaEz6A7ED35dzkxpXebrzU=;
 b=bKX3vGFOKUzljBoMArMZDinl4V+wQXFLGn8P/LxOP786lKFYxNXn1pABx+/LkW9c603fO18rNVP8hBrXxqpHKAoohYSx2vPOEjmF049yxENA7zI8CugTao3FL+y1WJoDOK+347NvgV6ovGApa/GlJlQu/voTVNv4RJMWT3uNTRcM6x7QyMZ6qq/+6+bdO2z4vkWZ5/tKud3lnbegH/K1BDlRYIYlFJe25tazZjPBgew4FEmwuYf/wTc8Y+p6IIBahdq0Q0sCGud02cYJOQvgBYKK9ZxOPG6dq+R9rMExxH4bV+vK65U9TYhTBOitoDxdsId5iSLdnLj+NffZoABUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCb8I/vmdLXVdB21Neuy3SaEz6A7ED35dzkxpXebrzU=;
 b=UzpoU2DdUm5sK5xLkTkIQy77fWd8rx8PptGKcRrnn4u2aHeTiNZeLSAUHIcdnUi7743vqfuDnfH4rjVlvnyyUd/vNfQA+xLxYyIXZLTm6ZeBGjY0WOv+HeTpfVFq1hjACsOvUv66/duZjfcgCHWm0B8DAfYziF0VPuD5OWoQ/CJnEOYfUew9PbaIu69K+TMFyn39E/vStJ7jSYVN7RHBKrbTiEu8hfww3mwZdUL9gp31ajRLQSx5/xm+IMecfH0Mt6fysEwIFlMy9qr2YjXqmX2F86gv173XfKyEEvnhWy4+SedbP3NgUTnRA76Cy07zND4XRqzDiUp23Zr8UEmKuQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 09:23:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 09:23:30 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 02/12] nvme: Do not hard code device size for
 dd test
Thread-Topic: [PATCH blktests v3 02/12] nvme: Do not hard code device size for
 dd test
Thread-Index: AQHZfZW2mKqujzGhVEGR3W65vcjAGK9IRq0A
Date:   Wed, 3 May 2023 09:23:30 +0000
Message-ID: <9fe561f2-10c6-71f7-5086-fcbd5fe71c0e@nvidia.com>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-3-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5217:EE_
x-ms-office365-filtering-correlation-id: 7eedeb73-a97a-4d91-13ba-08db4bb80f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JumFCRFhiNw1uo/mgnv3b7ZmZwURPDWWvHzegx0qZ5qZPrFWcSsrQN/V3egIo5fQmANa6SaH7OLV+EtCwGgn13hHd0cTmrXgroDQPpkKNCDYgdEGJyOibVHa3A0AE9gB9I6EozmDCGgCuhA9tm4sQul6YHR1F+EQ0mr3ZprPZYVWplvkqi51hXK1fRUPHD5osdrL2SUl7CIFAbIYZB0XicxBjNGMGP6jP0ysdfgrLzpTd1YOSp6wQbFDeZP2KfF5Zy3heakouuWYkg3ErD46RTRAXY0d9DL+CINT0a+vxJrumMFmnzgUfwWDWMXWbB93eo3yf1pAc1+VlReA3kSTVRUukF2+rWLmfXwIoRsBteWwolxYYK6suDmhZMGdqvxPwDMsUwXBweFUxTXMjq9qkxLc/F0CTEvJxWxjNDZ0ziqkRqVstpXsdmvQQsaT0tHniZTXZnwsok9YYJVdp+D4a9MGsMD0aO7FnrAQoW2n0y7sPE/dVHi7byLKzJ9UMWzVr6K9xEVvBIavQ/VtY5haRpdCvBTwAoCQSQVaX30c/T4rLV6aJvD+PWupgb0zZh6GV3S6Lf8VSGRfIc8KlkXuAt7MyOsHg0sO3foKJ2x/S3U2kTsmX2sk5aW4vXhtWO4Z4wHyVsGOFMmb4HjgTq/DidT0j6gYL9bsMOO2JPsyUM/gIqVek8lL4IfgkcYyqv5M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(31686004)(6486002)(76116006)(66556008)(66476007)(66446008)(64756008)(4326008)(66946007)(71200400001)(478600001)(91956017)(316002)(54906003)(110136005)(558084003)(31696002)(36756003)(86362001)(83380400001)(53546011)(6506007)(6512007)(8676002)(8936002)(5660300002)(2906002)(41300700001)(38100700002)(38070700005)(186003)(122000001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkhVRS81YXV6dm91SVViUTlJSlZHOVpNNDYxa2s3N01QMEZMbEd6ckZ3OGNU?=
 =?utf-8?B?Z1dGVXlKYzY1RWtXd3ZJYlhEOFdhYkdybk90Qm5pUUJDVU5YVDJMMEwraUlo?=
 =?utf-8?B?a1YvbUxpUUlmVG1VZU96ODFCcTJGQUJ1REJWM2I2Snp1NkdGM09aL1hDRnFx?=
 =?utf-8?B?cVRpOXNFSldsaEpmQmxZR1pKb2hENkk4M1Jocml6UW5KRUY0RDBWeUJMODVG?=
 =?utf-8?B?QVRQTTBsdVMzN0FzSmo2WkxaQUsyamxJUDBuUGJSMDFxMUhzbmFBK1ZZaS85?=
 =?utf-8?B?WWNQVWx6eVBHK29pZDhhaWZ0QVF6S25vbUhxcDN6Um8xQk9EY1lsY3VuUE94?=
 =?utf-8?B?UlYyektOVnhvSTVnT0czeFRyWmxlK3pOS3g4Qkg4aERPdTFYNmdmWFkwaWtU?=
 =?utf-8?B?RVJ6bitxT2RRdUxRZzRRcFgyM1kvWE1TZWs3ZDVCYzkrVDJ5TSttV0hpMVpQ?=
 =?utf-8?B?b2FXbEJwQ2ZWN09zcGwxWm91TjFvK21RVXplL2ErekVSb1NsUkF6SUZNR0F3?=
 =?utf-8?B?OEVYOVRWR0puWEVuamxwdm9vVEk0enpOcVp0cHg4S1kvWEVMekNKdVV3R3hm?=
 =?utf-8?B?YmtSWXp2WTJ2endwQzNLYjllU3VKOGVTbm04R0hMME1QVEt5SEhYaDZ1T01Q?=
 =?utf-8?B?SFlCdGtqZ3FxZERhOXd0VDR5eVBmRitsQUJaWEFoWmN2RzA5Y0FWaE1aa05X?=
 =?utf-8?B?TFEzNTlHRm9uYmk2bUNiL1pSK1dVM0ZQSmYyaitpdFlZcUJ0bUdJT1RISlpE?=
 =?utf-8?B?d2xIT3RoS3U1Lzg0NGV5MEUya0JRYmgxWkpIM1VBVno0aDhKUTJYK3V3RldW?=
 =?utf-8?B?YnZEU2x6eWxxYVhCTis5cHJvUzlWSFBrTFE0eW9zY2JXOTBxbkVHTGhEREVs?=
 =?utf-8?B?dDBrQ011ZUl6T2Z5NWgwZHVramg2QlZZcWF0cjlHZ250TUlsaE0vL3BnSlN1?=
 =?utf-8?B?N3dTOXRRZjY3OUtUYnhBWWc4eS9WSDNiR0c3RFN0ak54b2xKYzk1YnRCNU9z?=
 =?utf-8?B?Y2VrRHNhZmdKdTYxbVBjM041RStMQThyaThkbDdhSTlTK1Zla2svNTJIZUJU?=
 =?utf-8?B?ZmF5Nm9WUWRvOGRqMWpXWnBlVHN1OXR2cURSanJqUHkrL3R4TGt2eTYycmtO?=
 =?utf-8?B?cUlXa0dTdE40bC9OZEpRV21kdTloNHpjUnlUcGZIQjlLdUwzV0IrdlhYb2VI?=
 =?utf-8?B?UFB0NGt1b01LZmpxbENaTmNUN2VBRy83ckUzbEhpQmh1RS8rQmljUk55S0E3?=
 =?utf-8?B?MUdUciszR2lrc1Z3dDBXY29nazBCTUY0ZUN3Ym9reHlwRmVmM0ViR1ZYNGRG?=
 =?utf-8?B?c2RWNlFZdjQzb1Y0WVgveEVEaUxFWndieUY0cmRsRldSaU1pQWwyQWVZNzk0?=
 =?utf-8?B?QklOL21TV1dCbHdFUGZlR2VNWTcxTHBvcW5qSzBqMjZQblp0bGFFaG5Pd25p?=
 =?utf-8?B?MStYUUZ6V3RGeWtsdm5KMGN5TFZKUVF5ZlVCT1kvc1Axb2dodUdSeGZGZitz?=
 =?utf-8?B?aXF6OWZxTVp5OHB3UE9mYzg5Sk9TZWxBZXRRbUwrV0ZGL3ZOMTlIclp1YkFx?=
 =?utf-8?B?Nm5KQUp3RjJyZU92VjRSSlFzRDE4dGVhdDNXM2lXQjNpMyt4T05SR0krdGpY?=
 =?utf-8?B?VmZuNnNYRTFIS2JLMi9OQTlqeXc4a0N2Ukh1K2I0cDBNTGVCamFzbTJueHR6?=
 =?utf-8?B?OXRjUmhyOEFadS95eTB1NmRwNVZyOEt6a2xmeFQzdE9DeTlkQ2pibCtaYXkx?=
 =?utf-8?B?dkVGcnNaWXozVEkxR1pjZkpsNStsK3R3MTdaMFVraytRZk5GZW5ncUlLaktl?=
 =?utf-8?B?VHArYmxXdjJtbGJjNkI2dHBqZnV0ZEJ1TGRCclpQRk5sQjY4WXZDM29pRnlC?=
 =?utf-8?B?RytVZXR5dktwM0FIclEwRC9rUnVacG1MUnp3QXpnSEV5YklVd3czeXZMMHZD?=
 =?utf-8?B?QkhIamtDRjJETUxMNFYvZDJjMGVnV0EyWWRYUlZEa0RYVGJ6M2dFaXluVGpC?=
 =?utf-8?B?bjBIaGZUZCt6VkdXK2Z3aWZZM0tJTDFyOVdSUnVudXFLUENEYStEVE41ZW8w?=
 =?utf-8?B?dHNpZy9haVFLeGZkL0Y2R1ZBcm9CNTRiakdFN01JMldkaTJoR2t3Skt3SUh0?=
 =?utf-8?B?YitvenVqcXdTdjVhYlI2UzIwOEdaS2F4UktwTGM2SmVkRjRDRmU5ampGV2cx?=
 =?utf-8?Q?jKQ8oluaxxK3ywhrNOlJ1qXR7z+9Jq6PIe8r0NaToyB5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB4CE10F8CAB5D4E91BC3264A1B0B1C3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eedeb73-a97a-4d91-13ba-08db4bb80f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 09:23:30.5625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDgmD/i96WdgqkzhKD2qT/y7fr42t7VcPMPTFlrN1Xt/eBAsrV1Zx9p3nRukpYs+e6mbVWG9KbG4mYYW5MZrbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIzIDAxOjAyLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBSZWFkIHRoZSBibG9jayBk
ZXZpY2Ugc2l6ZXMgaW5zdGVhZCBoYXJkIGNvZGluZyB0aGVtLA0KPiBzbyB0aGF0IHRoZSBkZXZp
Y2Ugc2l6ZSBjYW4gYmUgY29uZmlndXJhYmxlIGluIGZ1dHVyZS4NCj4NCj4gUmV2aWV3ZWQtYnk6
IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwg
V2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+IC0tLQ0KPiAgIA0KDQpMb29rcyBnb29kLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoN
Cg0K
