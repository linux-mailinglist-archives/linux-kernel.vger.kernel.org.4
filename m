Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6616732D28
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244982AbjFPKOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244776AbjFPKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:14:02 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70711B2;
        Fri, 16 Jun 2023 03:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8XLXG3FP5XZ3uCMmgNxvhyRbZuAJ2nEGo0JEpr7lbHFiQ3HXrb02e8TsTJLRNDd2oG4hLuHvknpb7iubQkhVF66fMiUzPD7lrtVX2wa3QwwHKic/0oJ6BqaffuQ1MV1yQgc4C6/ScTotI7AyfNEeHFrqMPrSMdRrxkWU6G1A9/O4iYtzUxjamMSazn6E4EITN3pRfu3i6CYslY443/warSuNBtFBo0UivnafN9Nv3RGQMalbo4YcUS4xVDvmQlK6s80Xe1x1uwE54lpCOyer336fj4fQM3zQouzQQWnBSx80buBpnOBlWknQXzOiq0D73YmIVg+nPAJb4JztFoDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulTCCgW6XKfbygFCvpDhB8olwPnmIkGIldK8SnMx544=;
 b=E7OIEPT/U0EGYX1wUb6RUUQ6ieTzCr+kz1jcNIyEy1XlZqBGvaFQZgPzRx2jSgqMjOBTMKfHipGcpaVKBODeZ80PIXG8vZE20irSSpEANtrSdv3QrlIeoKnBPdUA7zXP8FzqwsH9Ab0XoNBn2EHYln16Sq31UOXi1G81y4kQwoyne6TFDZ8gwXwYF+1RMIb+zOFde8cGUiyutcbjH+6H3N417O8qCksIirBjRYx9Th+oqO2k4+s8SvkSiHeIBG8trTT6etr/AzfUJE0dLYYSuwvXuonsUZo0W1Dzs98SsMJmGOvYlkY4j/0stS5kBEov8ivcAtaSxPsWtV0XZS/14g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulTCCgW6XKfbygFCvpDhB8olwPnmIkGIldK8SnMx544=;
 b=ylqn6MmWy376CHgR34ObyHo7TuJuVRBouho2wpWvdPv8wzUSrz1xpX0IEkBjVcv52w1Th721Tyn2AHQSYZdBqGVYl26xCy8t5Vm/bhP5kCdXhpV0RuaPr1+dZ/+qJdTuw7Z9U+Mb+uQejn+nIq7vBLx3GpCdy2Jtt021PDtqPDE=
Received: from PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Fri, 16 Jun
 2023 10:13:56 +0000
Received: from PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::5abb:a70f:abff:f6c0]) by PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::5abb:a70f:abff:f6c0%7]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 10:13:56 +0000
From:   "Goud, Srinivas" <srinivas.goud@amd.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "gcnu.goud@gmail.com" <gcnu.goud@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFtQQVRDSCAxLzNdIGR0LWJpbmRpbmdzOiBjYW46IHhpbGlueF9jYW46?=
 =?utf-8?B?IEFkZCBFQ0MgcHJvcGVydHkg4oCYeGxueCxoYXMtZWNj4oCZ?=
Thread-Topic: =?utf-8?B?W1BBVENIIDEvM10gZHQtYmluZGluZ3M6IGNhbjogeGlsaW54X2NhbjogQWRk?=
 =?utf-8?B?IEVDQyBwcm9wZXJ0eSDigJh4bG54LGhhcy1lY2PigJk=?=
Thread-Index: AQHZnSMWoqaiQCN5yUSuy0pK7+H7EK+IXdSAgAG1alCAABRNAIADEPrw
Date:   Fri, 16 Jun 2023 10:13:56 +0000
Message-ID: <PH8PR12MB6675D75114C7EE280235BE8CE158A@PH8PR12MB6675.namprd12.prod.outlook.com>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <1686570177-2836108-2-git-send-email-srinivas.goud@amd.com>
 <20230613-outskirts-dove-e3e39b096647-mkl@pengutronix.de>
 <PH8PR12MB667577C4800ED8E82C36D57DE15AA@PH8PR12MB6675.namprd12.prod.outlook.com>
 <d12e3d8b-20e8-48bb-84d0-3fe7d3502c83@kernel.org>
In-Reply-To: <d12e3d8b-20e8-48bb-84d0-3fe7d3502c83@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6675:EE_|PH7PR12MB5593:EE_
x-ms-office365-filtering-correlation-id: 813491a3-1fea-466d-3557-08db6e5264eb
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hh62pLPZUJ2i6rlzs8wwhUAOQ/Rpr1ni+DQyWyhru0jSFsZTIbHGMhiEbe+Re2365WmDQSlX/5Gn5wHbsGBer+ngOeRPfCmAQ4Ipfo824dctkJYN94VbEy2ltVaWKxuUvpQ/RFVt3uHKC3ZwzSzk6EY+jL0wWiZoO/KxqQhZZqP+4NOLUUH589LypyHE9IsqQ2xreNmFftSdaUDfwS4VLHD1+OFQK2TtWhEQOfV9rf6uXiH5X1Ul2VPQgHDQ+gYrXg7akTdkb+QVEGliHSEoSllBRM4shctaGkA59uM7rb4nwZAt3KaX7uo1focX8dRxtTdhhTqXp589CPxThrzgRc55kk/pb4ZQYv2Rv/csrZFJSqBxxKzN7HBHwmU7OC0kWmG9g0NIR97qdTKZy2Es6WLccVca/uI9catXLNghBTDFGMDuoVfArTz2OCOYZiw+aU//SUM9K3T486FG0C9EuGQ2IaZ9xn2fZ7mNfl9F488thg2to6jb60DOh5zc+NDWfsLImdWW/QITujd1fHzY1JYrs42eKxLWyqcvA2X6IpICYBn4wWEfm85MYRiW14qByVdUdFfXyh0fbfNY/740eBbEueG+Ag0xyGtqvwKGXqOdyLrntxLv52WK7msh/Yyy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6675.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(83380400001)(7416002)(33656002)(55016003)(122000001)(8936002)(86362001)(66476007)(38070700005)(66946007)(2906002)(52536014)(41300700001)(66446008)(316002)(66556008)(478600001)(5660300002)(4326008)(38100700002)(64756008)(76116006)(7696005)(71200400001)(110136005)(54906003)(186003)(6506007)(26005)(53546011)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWRQY21HTm1Cb29Hc1NOblRta0xWUUNQUG9vS3dVMGtDV09VQnVlQ0V4Z3dP?=
 =?utf-8?B?emw3bkJuams5OFlSWUxSczVkNE1UKzlYR2hzVjRJbE41b0VFWDFITXVrSDhk?=
 =?utf-8?B?OHpyeGY3NmpFdElyc1NtdlRjS3FLMklQYzlROUdzWlZId3hEbjVmQTNScXpI?=
 =?utf-8?B?VTE5Q0tEUWEvR3U0U21yUlp3YWx3TThJWi8zRHA0bGF3NkFObmFvdWt0TmNk?=
 =?utf-8?B?VlhmRmRoMVV3cThOaUduaUpjbWEvS3NqVW5QNW8reDdROWkybDZBaUREN0p4?=
 =?utf-8?B?M2sxaWZ0TEFVaXdlNTZ2OHUzSXoxZTZRYmtudDM4Z2hjWUpKZzJhaWRuL1Ix?=
 =?utf-8?B?RFJ1ZWRTVkZIeHJRZS9FWjg4cklqZlJOTUlDSGdVMk9MVFpIN20vdTZkdDJl?=
 =?utf-8?B?QituQ0h1ZTg3Qlpzd3d0aisyY2Zla1FYcnBMd0NCQjUwTEN1UW0wQUl4TCtV?=
 =?utf-8?B?czlVeXFwaHVmK0dlU2lad1NZRm16VE5yWXBvdFZxN1BKS3RGL1ZVRTBCNUla?=
 =?utf-8?B?Q1RCZjRtUHQ1cy83dk9iMXBmS1lNWnh1QTV4UzlIeWhyMzBYL0luUWI1L2hI?=
 =?utf-8?B?K3JNTDZpbEo1dExzYjBDSEl6dE9vMlBwREtIbzltWDVieEtrVENMK1FiTkRi?=
 =?utf-8?B?MCtkMGtINGd1RTU2RWYvNzFmMWszV0M2ckVzVS9xSG90Y1ZmcUtsT2ZDWC9V?=
 =?utf-8?B?a0tId0lXamIyVTY2WWNZa2JITUhLSWxvZjJFajdJNzg2NTEzQjk1M09tdDUv?=
 =?utf-8?B?cGVQRFF4a21BcmUyaWRNdUxnVzBINDYrOFduTWhQOVZWY05VWENSU0ZQU2p2?=
 =?utf-8?B?ZGp4azRNbjhnVk9tcmVlQUZQcGw1Vkk1RkxleStxUmtYeUxWYXpwVjA3OTM1?=
 =?utf-8?B?U1dxYlowWUZnd2VGbW5MVjFWU094U0ptMnQ3RW9LTUhuNmo0ODVuSVltSXZK?=
 =?utf-8?B?SlJSUm5QQVdOd2Y5SmwwSkFEQ2pFRHR0YmgySVFlcFFjdERxclhZSVdPMjR4?=
 =?utf-8?B?NnRJNGQ5aUIwZDZvUzhiK0x1ZkNYaXlYQTlMYk1tRi9TMU1yb0taS1cxUk43?=
 =?utf-8?B?QzVuUm13QUxmWkZZbEVsdzlkYzgrdWVnM25Od3pXb1FQVFlsRnA0MXE2V3Rl?=
 =?utf-8?B?Rk8rcjFJSi95SDRiM0M5TG1RTzdmQVE1dzlTKzgycXhYY1NCb3dtNnVYalli?=
 =?utf-8?B?VWFSOEc1Njl6M3M2UVdFOXZTUkpOZDFhaGVrTjZkVFNlTFZESUp3bWdvdEls?=
 =?utf-8?B?NjZMMXhad0xwa0t5UXNKQU45UXB1eFlmT1JkWVdtcGx1c09aN0NMaktFbnE5?=
 =?utf-8?B?aVM4dmxHTGJ4QTEyRWpBeThKTjEwTDJ4ZjdSdGR2bVhmWG1RSlRSdm0rYVlU?=
 =?utf-8?B?ZHdaajBlRmpDaThIb1o4VHhQbXNlbkRuZHR6K01Fd0x6UDBnV2NxZ1lldHUw?=
 =?utf-8?B?bnowa0VaUk9ZTENoQ1pyWnNyWEwzb2FBR3dvOGtHbTY1cU9wS1EvQ3hWY082?=
 =?utf-8?B?Tmo1ZkMzUWhyQzBZamVFbHdudjBBN2NQemhYcnpzRytkUW9xRU5ZT0FmajlB?=
 =?utf-8?B?QWpXUjNITDJPRHdROEl4ZlhiL0ZTVTRQKzVoT3ozVDlUSjVzVkt1Yks4VHZi?=
 =?utf-8?B?dWVKSk04eC9qT2FWYUtjb3BFbjlVamR4ZUcrNjJhS2FGTGZQcmJmYTVQdWxC?=
 =?utf-8?B?Zjkxc2RZMXJjck93cStoM2NYeUpsbnd2Ym5DYy9mT0xWT0NsRmI1d1p2Sk9Y?=
 =?utf-8?B?SUxMM1hrajhkVDlkaGNweE8zZDJxWndDdVZNVmRGS0JydFBUZHdOQkk1NDlM?=
 =?utf-8?B?eE0zbFQxUTNsbC9VTlRJQlVDU2RkcEI4OTEySmJ5MEFWWU1DbEpEVDlaVlBT?=
 =?utf-8?B?bTAzV0FPY1JwOU1uM3VOb2FOTCt1ZGp2bTA1MUsxUmFNYndoRHBpMFRNNE5L?=
 =?utf-8?B?allZNXZlSEdZajA2bXVTdzdlZUYxR0EwamdGeUU4eE92Q1dBN2NneVBCdmQy?=
 =?utf-8?B?Wi9ITGZKVW5WMk84YWp6R2pSRjRLek44TFRWOE9NcWdUSEhJYWhGK1FYZ2dM?=
 =?utf-8?B?ZlBNL2xoZkJ1TGxzS0wvMTRJeHZxTlBmZ1dLVlgyTmwxTGVteVR4YVo3c0t2?=
 =?utf-8?Q?+J0o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813491a3-1fea-466d-3557-08db6e5264eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 10:13:56.2380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BqrScRnDHJVXNkJiaJ4AeHfj5xRVoE3xykXE2cwlHe4n25Mjx6iu4oOoLLu1B3dJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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

SGkNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPlNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxNCwgMjAyMyA0
OjQxIFBNDQo+VG86IEdvdWQsIFNyaW5pdmFzIDxzcmluaXZhcy5nb3VkQGFtZC5jb20+OyBNYXJj
IEtsZWluZS1CdWRkZQ0KPjxta2xAcGVuZ3V0cm9uaXguZGU+DQo+Q2M6IHdnQGdyYW5kZWdnZXIu
Y29tOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPmt1YmFAa2Vy
bmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGdjbnUuZ291ZEBnbWFpbC5jb207IGdpdCAoQU1E
LQ0KPlhpbGlueCkgPGdpdEBhbWQuY29tPjsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207IGxpbnV4
LWNhbkB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSCAx
LzNdIGR0LWJpbmRpbmdzOiBjYW46IHhpbGlueF9jYW46IEFkZCBFQ0MgcHJvcGVydHkNCj7igJh4
bG54LGhhcy1lY2PigJkNCj4NCj5PbiAxNC8wNi8yMDIzIDEyOjIyLCBHb3VkLCBTcmluaXZhcyB3
cm90ZToNCj4+IEhpLA0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZy
b206IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+Pj4gU2VudDogVHVl
c2RheSwgSnVuZSAxMywgMjAyMyAxOjIzIFBNDQo+Pj4gVG86IEdvdWQsIFNyaW5pdmFzIDxzcmlu
aXZhcy5nb3VkQGFtZC5jb20+DQo+Pj4gQ2M6IHdnQGdyYW5kZWdnZXIuY29tOyBkYXZlbUBkYXZl
bWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPj4+IGt1YmFAa2VybmVsLm9yZzsgcGFi
ZW5pQHJlZGhhdC5jb207IGdjbnUuZ291ZEBnbWFpbC5jb207IGdpdCAoQU1ELQ0KPj4+IFhpbGlu
eCkgPGdpdEBhbWQuY29tPjsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207DQo+Pj4gbGludXgtY2Fu
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
Pj4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+PiBTdWJqZWN0OiBSZTogW1BBVENI
IDEvM10gZHQtYmluZGluZ3M6IGNhbjogeGlsaW54X2NhbjogQWRkIEVDQw0KPj4+IHByb3BlcnR5
IOKAmHhsbngsaGFzLWVjY+KAmQ0KPj4+DQo+Pj4gT24gMTIuMDYuMjAyMyAxNzoxMjo1NSwgU3Jp
bml2YXMgR291ZCB3cm90ZToNCj4+Pj4gRUNDIGZlYXR1cmUgYWRkZWQgdG8gVHggYW5kIFJ4IEZJ
Rk/igJlzIGZvciBYaWxpbnggQ0FOIENvbnRyb2xsZXIuDQo+Pj4+IFBhcnQgb2YgdGhpcyBmZWF0
dXJlIGNvbmZpZ3VyYXRpb24gYW5kIGNvdW50ZXIgcmVnaXN0ZXJzIGFkZGVkIGluIElQDQo+Pj4+
IGZvciAxYml0LzJiaXQgRUNDIGVycm9ycy4NCj4+Pj4gUGxlYXNlIGZpbmQgbW9yZSBkZXRhaWxz
IGluIFBHMDk2IHY1LjEgZG9jdW1lbnQuDQo+Pj4+DQo+Pj4+IHhsbngsaGFzLWVjYyBpcyBvcHRp
b25hbCBwcm9wZXJ0eSBhbmQgYWRkZWQgdG8gWGlsaW54IENBTiBDb250cm9sbGVyDQo+Pj4+IG5v
ZGUgaWYgRUNDIGJsb2NrIGVuYWJsZWQgaW4gdGhlIEhXLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBTcmluaXZhcyBHb3VkIDxzcmluaXZhcy5nb3VkQGFtZC5jb20+DQo+Pj4NCj4+PiBJcyB0
aGVyZSBhIHdheSB0byBpbnRyb3NwZWN0IHRoZSBJUCBjb3JlIHRvIGNoZWNrIGlmIHRoaXMgZmVh
dHVyZSBpcyBjb21waWxlZCBpbj8NCj4+IFRoZXJlIGlzIG5vIHdheShJUCByZWdpc3RlcnMpIHRv
IGluZGljYXRlIHdoZXRoZXIgRUNDIGZlYXR1cmUgaXMgZW5hYmxlZCBvcg0KPm5vdC4NCj4NCj5J
c24ndCB0aGlzIHRoZW4gZGVkdWN0aWJsZSBmcm9tIGNvbXBhdGlibGU/IFlvdXIgYmluZGluZyBj
bGFpbXMgaXQgaXMgb25seSBmb3INCj5BWEkgQ0FOLCBzbyB4bG54LGF4aS1jYW4tMS4wMC5hLCBl
dmVuIHRob3VnaCB5b3UgZGlkIG5vdCByZXN0cmljdCBpdCBpbiB0aGUNCj5iaW5kaW5nLg0KQWdy
ZWUgaXQgaXMgb25seSBmb3IgQVhJIENBTih4bG54LGF4aS1jYW4tMS4wMC5hKSBidXQgRUNDIGZl
YXR1cmUgaXMNCmNvbmZpZ3VyYWJsZSBvcHRpb24gdG8gdGhlIHVzZXIuDQpFQ0MgaXMgYWRkZWQg
YXMgb3B0aW9uYWwgY29uZmlndXJhdGlvbihlbmFibGUvZGlzYWJsZSkgZmVhdHVyZSANCnRvIHRo
ZSBleGlzdGluZyBBWEkgQ0FOLg0KDQpUaGFua3MsDQpTcmluaXZhcw0K
