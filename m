Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857266BC6F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCPHV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCPHV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:21:56 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2070.outbound.protection.outlook.com [40.107.114.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5841C121;
        Thu, 16 Mar 2023 00:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLIH1z4f79WDBeK/bpI7C5131L/XlR1tbWgkYPiDDa9eqHU7dUtCGPSvPa161mInJWbKym8t0w9vqEvs75ngWIIKmw5Rz5ZkzmnAIxtEGXFCNlFKKMENQejAnqfVxlK9jYGBPI3v/OZ0EexXnX6Kre+JyEXu3qGm79hyMjQuDnw/8qa2YJjLndCbgZEQeOoQbpKYTWIPviJTfDxBpVBke/iqurX2OJtbnDkQs0qWmRdZXOkuYMbFtB8zXd4Rv6dMhzqtY9ZfvFsgLjF/jhVqKloHzipEuUeFbQ9JUslNEY6J0r25hRCdhMHStZqBoiR1VQ9SbA22iprOXgc9ae5mJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9B+ImLaBjXOTCKQ7t/rGXYLb/Z82o5B1C3qx6cpc8I=;
 b=BFBea+10Mqs466BL0fwC12Cjfio6LmuLTYBF3N4HQDd4o1E4UVVYT0NqRJe3DbufTDRnKPuA/OVZD+/frmwzxevGspp5x/QEWBYL3Z8rjETEw8y7iwBCwSWMj2HR2frHbNMR3HOM5HteMBTN4nbC2FormO0M2wpoMVrSmC4aGtZULimExQMqF75F+V7vzxjtGz49xRiyi4h4nTXVNlIUxAYpcFeeLVGO0Uc9SIzCLw+pJIiAFIGE+YlwCX8yHmrE3nVull/TaES0KYd1GEZX6H6Q761CANxXiZrZgo7ggvghQrAG0SVNw4UiH2OYmHgZYKR59bqFd29RMVlx5hPpJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9B+ImLaBjXOTCKQ7t/rGXYLb/Z82o5B1C3qx6cpc8I=;
 b=XkbPEkIFYZA6quUjuV1hxqEiLoJx5SBsetbsGEJwDjHS4G4qszw8ZbtPcwjmbPUcD7Ze+164lsqK5kqeTlC3uxZti5wAelEfap0j6iLAlGoQxaf7z/UYJ0ugg0hKP8egBpIfqQUsZYSGvBcv+bXMDKFuupshKkebSdOgrA73WXs=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYVPR01MB11118.jpnprd01.prod.outlook.com (2603:1096:400:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 07:21:49 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0%9]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 07:21:49 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "lvying6@huawei.com" <lvying6@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cuibixuan@linux.alibaba.com" <cuibixuan@linux.alibaba.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] ACPI: APEI: handle synchronous exceptions in task
 work
Thread-Topic: [PATCH v2 2/2] ACPI: APEI: handle synchronous exceptions in task
 work
Thread-Index: AQHZSmjf8tRHDMQWe0qCot6AHA4QcK79Gx4A
Date:   Thu, 16 Mar 2023 07:21:49 +0000
Message-ID: <20230316072148.GA364378@hori.linux.bs1.fc.nec.co.jp>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230227050315.5670-3-xueshuai@linux.alibaba.com>
In-Reply-To: <20230227050315.5670-3-xueshuai@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYVPR01MB11118:EE_
x-ms-office365-filtering-correlation-id: aa111827-8d3c-4a92-5393-08db25ef1b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85WP0+8kfGhnzGR3V/U8/jzv4/db3+5tYQZhA2cPcgoL8lodCqN6TBguOmrB1AT2Fk1jKSYlelRtHlqmXtyy1Grk4tc8stik2mr13Wi9m7Rgk3tNWlBOj5XQzx8a0bxW/EPsgkwN3FHsy2RDK1N77EVkk0hCnsGrFTHDIYuE/MVrmy51ZBCdychzb94D8nLcBDbgu6Blu2EeICFn5LYC8/5cyVe5KP0aNDW3lakpsMAJhamFdAjVbFQ3S28AUZXmABtkAkokCEGlYnQ0PCLyRLZZ701Wqsm1yZstBg3VEolfsMVT0buXta5a3A0Ghy1nu1fpQOy0uWzlzGAiD1BWKPaYuBBLReo5QMynkO+MoFjBPahAAS87RJkJEFYn72LvPV5zLA0ekwDNMLpPdWfD6ZCrKoprFmskbR0MbT3rvjeHB3EjUABhwoJiRyWMFZ1KnkPXHaM5zlp0n9AV/PQK2LY2NMBvZ/PBDisfsfvdymOsv+s+BO/LtD0qtE8QoiqvfTdvNDrrkFOZ7evC35EaFSzBDlq1vsX3VfXDpWrMhNDsr+U6xJul5YHtVK6BZkE90Az8dCyz6tLturfSGmz1sqCodwuiD7Y8KynonNJ0zkYe+r+pP6IOzLjziB57QGXGcUKZpR+HRHGbMK/WIT3ZoKNZyoB6gw8NoPQtXB8qGIa1/WL6arhkvb+NMjBAMRGtTXIfVuaV/qTUZy6HadvWRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199018)(2906002)(82960400001)(122000001)(5660300002)(83380400001)(7416002)(85182001)(6916009)(8936002)(41300700001)(64756008)(38070700005)(66476007)(316002)(76116006)(33656002)(4326008)(38100700002)(86362001)(54906003)(66446008)(66556008)(66946007)(478600001)(71200400001)(9686003)(8676002)(26005)(6512007)(186003)(1076003)(6486002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0hoSzZ3cnRaczkzd2VqQzh3d1ZOaXJHMy9LbjB5c0RVdStoT3lSU0ljOWZm?=
 =?utf-8?B?SVdVcUNiTXQvaEFxT053Qnd5bThCQnZMK1ZwdTR6OW13ZFhnSFBJTjU5a3Zr?=
 =?utf-8?B?VzRjSHlEeDQxd0NEVVlydmlLVUx3UVpnbVIrQVpBSVpyOWdqZjVXN1FlbTFp?=
 =?utf-8?B?TmhqUXRPSVVqQzM3ZkVsTmw1aUljRVV4aEEzN2tTZm5pdEdpaHpFRk1NbWs2?=
 =?utf-8?B?eWFheGlNWk82RUZ3am5JYkZrZDlHUVhmVGxNK3J6WUtQOFdjZlRqVzlLQjRy?=
 =?utf-8?B?cDJZS0xIc0wvUVU1WThhS2NsZWUwZUJXTWJQeGh1REhuRFVlYlg4QURoUXJx?=
 =?utf-8?B?QkkxaUNldmhLWXBZcjNEMXNMMmswVmtPWWQzZ0xYLzRmZG9MaEFrcnVvUVJq?=
 =?utf-8?B?QnZDc0pFZjYxU3o0R1kySVlJR2crZzNSRlA0WWg3U0oyVnpzN3g1NENDTFNy?=
 =?utf-8?B?NnVsRWh1OWJseWlIc1hieTNyZDlIWlpMWU9yZ21TWERtNmdhbGdoMVl0MTla?=
 =?utf-8?B?UkNKb1M4RDkwQmJHUXVPRGdOUGxBMW4vK1JaQ0JsaHRqdE9DMGhEVUd3VDh3?=
 =?utf-8?B?VUhBaUtpQytISjd1RUpodFlia1lNVzdhUERlRWpveFdZclEwR0VEYkFtUkln?=
 =?utf-8?B?YnN3M05scHFPVXhMcGw4S0dMODk1TnRXNUdZVUttbDB0cUkrTmdHMGFWdUk2?=
 =?utf-8?B?cnhhcys0ejIrRW9VbDRDRUc0aXkxVzlMNjA4WWdUUEFzZll4cjJhcWMxZWx5?=
 =?utf-8?B?ZEMrSnVyRE94bjZVaC9GN2pQV0ViVnh6MTk5Z0VNM1VZS1pSVkFob2FWWEJm?=
 =?utf-8?B?UENKWjR5K0kweEtTUStUOVJSdUo3c1BvcnZLSWVDTXB3WmRWQ3crQ0t6RXFY?=
 =?utf-8?B?Z2d0V2VpNDlTbXlxem92YjNOMDdtazZleFE1S2d1dzJNRnFuLzdsREFlTUNm?=
 =?utf-8?B?UFlCUEJHUkxhMkZiTjFjQ2JULzlxSkhxZ0xpMEdwSzJpSWFBWkVjSnF2SlRP?=
 =?utf-8?B?YU51SG1CL1JGZjVtWmZjTy9oNjVFdmp2Zk4rK0dCeDVpTnBINUJRYmZvMjcx?=
 =?utf-8?B?L1YzdThDc083SDZ2dlhSQy8xU0gvM0k2OEJncXdMTWc4bnE2Vk95QjJsSXgy?=
 =?utf-8?B?aTVTcCszRVB4WW1HQm9aU3B6V0puSWtxUVIwK3dPWDRZSGlDNkZJQWpIc3Nw?=
 =?utf-8?B?ZU9yN3JWMTZLK0VTOVFadVQxMU5kSmo1QkMxYUdyamdBenpMOTBqN2VFZmpR?=
 =?utf-8?B?a1BTMDQvZzNCN0gxamU0c0kwN1pJQWsrUll4T3ZydEFnWDRYbGUwVWduaTN0?=
 =?utf-8?B?QXduck5jSGxTS1pjRmY5MG1ybE9kdkpLdDhUenplN1V2WGhyZXorSDI1Ry9x?=
 =?utf-8?B?SUZRajlYS3Z1OHZGTnV0bG9iRWhTcmVldlVMRjFKb0Jra29JcExyc2dMeGpv?=
 =?utf-8?B?YVErNG1YQitkKzcrME1BditobmJRVmt0c1BPUVdtZW80VWFLZW5wdHk1MTNH?=
 =?utf-8?B?aUw2d1Z4S1ZrMmcva1RRdUlkenhuNFV3RFZma2VKM3BhV21OL3Y2WnE5VWZz?=
 =?utf-8?B?Mk9vRGFFRXY1MnpjR0YrSDR0QTNNOGdSSm5uVGNsKy9abzdQYlFmMUVsMm94?=
 =?utf-8?B?QmNDWXBoMTZvZ1RJcWYzWHJ5VVNxYml4T3A2cFpYOE9YN0JCWi92QW5lVUlX?=
 =?utf-8?B?eG9Ec2hNMXhNQUtNcHpCRkNLanJHSk5Db1VkemQxbWNnZUw4U0thWDJFN3Jw?=
 =?utf-8?B?NlBVTVB3dHJhVFNYeC83b2swc1orQUV2cWp4Y3hkeU9PUFVFUzF5bU1yN3F1?=
 =?utf-8?B?Q1R3b0hDODQzUS9xY1QyTnZCN3ZhT3doTXpqdVlsbjNOcVpPYXFxdEdja3Mv?=
 =?utf-8?B?dUpqLzhpSUxCZHpWZXBTVER6M0x4eUJpZllsbDVaaVZKaXlBdmdDbVMvOEdv?=
 =?utf-8?B?cHYvOGEyUlZ4amd3djRvcXNoMVVmaW9wRzZ4NmNVUnBrckV6bm0raFpablBL?=
 =?utf-8?B?SksvbEFzNDBhOXA1Uy84ZU8yMENyTkt1dzE2bVpJdEloNC9vTWFpYmZLRE5n?=
 =?utf-8?B?MXBObWVZdnBVdVVoUVBNdnM5MmRhandRM2hCSGtsUUJTUVN2ZVp3U01RVXlP?=
 =?utf-8?B?ZHJId1hIdHZhSTloOENJRHRsNUxZQ004cmtVWnI1aytNdEJZK2M0VUs3WGV0?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D97C59AFB91AE543ACF9DF8B38111D4C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa111827-8d3c-4a92-5393-08db25ef1b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 07:21:49.1641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNwrGrjTh2Z20RuT8mtdrGrC8k/nMBt/ArUtwrLK4kxu6i7eLrqkgqv8KNGQavL3uOvyjv0ZS9Ytl0Lc4jnU/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMjcsIDIwMjMgYXQgMDE6MDM6MTVQTSArMDgwMCwgU2h1YWkgWHVlIHdyb3Rl
Og0KPiBIYXJkd2FyZSBlcnJvcnMgY291bGQgYmUgc2lnbmFsZWQgYnkgc3luY2hyb25vdXMgaW50
ZXJydXB0LCBlLmcuICB3aGVuIGFuDQo+IGVycm9yIGlzIGRldGVjdGVkIGJ5IGEgYmFja2dyb3Vu
ZCBzY3J1YmJlciwgb3Igc2lnbmFsZWQgYnkgc3luY2hyb25vdXMNCj4gZXhjZXB0aW9uLCBlLmcu
IHdoZW4gYW4gdW5jb3JyZWN0ZWQgZXJyb3IgaXMgY29uc3VtZWQuIEJvdGggc3luY2hyb25vdXMg
YW5kDQo+IGFzeW5jaHJvbm91cyBlcnJvciBhcmUgcXVldWVkIGFuZCBoYW5kbGVkIGJ5IGEgZGVk
aWNhdGVkIGt0aHJlYWQgaW4NCj4gd29ya3F1ZXVlLg0KPiANCj4gY29tbWl0IDdmMTdiNGExMjFk
MCAoIkFDUEk6IEFQRUk6IEtpY2sgdGhlIG1lbW9yeV9mYWlsdXJlKCkgcXVldWUgZm9yDQo+IHN5
bmNocm9ub3VzIGVycm9ycyIpIGtlZXAgdHJhY2sgb2Ygd2hldGhlciBtZW1vcnlfZmFpbHVyZSgp
IHdvcmsgd2FzDQo+IHF1ZXVlZCwgYW5kIG1ha2UgdGFza193b3JrIHBlbmRpbmcgdG8gZmx1c2gg
b3V0IHRoZSB3b3JrcXVldWUgc28gdGhhdCB0aGUNCj4gd29yayBmb3Igc3luY2hyb25vdXMgZXJy
b3IgaXMgcHJvY2Vzc2VkIGJlZm9yZSByZXR1cm5pbmcgdG8gdXNlci1zcGFjZS4NCj4gVGhlIHRy
aWNrIGVuc3VyZXMgdGhhdCB0aGUgY29ycnVwdGVkIHBhZ2UgaXMgdW5tYXBwZWQgYW5kIHBvaXNv
bmVkLiBBbmQNCj4gYWZ0ZXIgcmV0dXJuaW5nIHRvIHVzZXItc3BhY2UsIHRoZSB0YXNrIHN0YXJ0
cyBhdCBjdXJyZW50IGluc3RydWN0aW9uIHdoaWNoDQo+IHRyaWdnZXJpbmcgYSBwYWdlIGZhdWx0
IGluIHdoaWNoIGtlcm5lbCB3aWxsIHNlbmQgU0lHQlVTIHRvIGN1cnJlbnQgcHJvY2Vzcw0KPiBk
dWUgdG8gVk1fRkFVTFRfSFdQT0lTT04uDQo+IA0KPiBIb3dldmVyLCB0aGUgbWVtb3J5IGZhaWx1
cmUgcmVjb3ZlcnkgZm9yIGh3cG9pc29uLWF3YXJlIG1lY2hhbmlzbXMgZG9lcyBub3QNCj4gd29y
ayBhcyBleHBlY3RlZC4gRm9yIGV4YW1wbGUsIGh3cG9pc29uLWF3YXJlIHVzZXItc3BhY2UgcHJv
Y2Vzc2VzIGxpa2UNCj4gUUVNVSByZWdpc3RlciB0aGVpciBjdXN0b21pemVkIFNJR0JVUyBoYW5k
bGVyIGFuZCBlbmFibGUgZWFybHkga2lsbCBtb2RlIGJ5DQo+IHNldGluZyBQRl9NQ0VfRUFSTFkg
YXQgaW5pdGlhbGl6YXRpb24uIFRoZW4gdGhlIGtlcm5lbCB3aWxsIGRpcmVjdHkgbm90aWZ5DQo+
IHRoZSBwcm9jZXNzIGJ5IHNlbmRpbmcgYSBTSUdCVVMgc2lnbmFsIGluIG1lbW9yeSBmYWlsdXJl
IHdpdGggd3JvbmcNCj4gc2lfY29kZTogdGhlIGFjdHVhbCB1c2VyLXNwYWNlIHByb2Nlc3MgYWNj
ZXNzaW5nIHRoZSBjb3JydXB0IG1lbW9yeQ0KPiBsb2NhdGlvbiwgYnV0IGl0cyBtZW1vcnkgZmFp
bHVyZSB3b3JrIGlzIGhhbmRsZWQgaW4gYSBrdGhyZWFkIGNvbnRleHQsIHNvDQo+IGl0IHdpbGwg
c2VuZCBTSUdCVVMgd2l0aCBCVVNfTUNFRVJSX0FPIHNpX2NvZGUgdG8gdGhlIGFjdHVhbCB1c2Vy
LXNwYWNlDQo+IHByb2Nlc3MgaW5zdGVhZCBvZiBCVVNfTUNFRVJSX0FSIGluIGtpbGxfcHJvYygp
Lg0KPiANCj4gVG8gdGhpcyBlbmQsIHNlcGFyYXRlIHN5bmNocm9ub3VzIGFuZCBhc3luY2hyb25v
dXMgZXJyb3IgaGFuZGxpbmcgaW50bw0KPiBkaWZmZXJlbnQgcGF0aHMgbGlrZSBYODYgcGxhdGZv
cm0gZG9lczoNCj4gDQo+IC0gdGFzayB3b3JrIGZvciBzeW5jaHJvbm91cyBlcnJvcnMuDQo+IC0g
YW5kIHdvcmtxdWV1ZSBmb3IgYXN5bmNocm9ub3VzIGVycm9ycy4NCj4gDQo+IFRoZW4gZm9yIHN5
bmNocm9ub3VzIGVycm9ycywgdGhlIGN1cnJlbnQgY29udGV4dCBpbiBtZW1vcnkgZmFpbHVyZSBp
cw0KPiBleGFjdGx5IGJlbG9uZ3MgdG8gdGhlIHRhc2sgY29uc3VtaW5nIHBvaXNvbiBkYXRhIGFu
ZCBpdCB3aWxsIHNlbmQgU0lCQlVTDQo+IHdpdGggcHJvcGVyIHNpX2NvZGUuDQo+IA0KPiBGaXhl
czogN2YxN2I0YTEyMWQwICgiQUNQSTogQVBFSTogS2ljayB0aGUgbWVtb3J5X2ZhaWx1cmUoKSBx
dWV1ZSBmb3Igc3luY2hyb25vdXMgZXJyb3JzIikNCj4gU2lnbmVkLW9mZi1ieTogU2h1YWkgWHVl
IDx4dWVzaHVhaUBsaW51eC5hbGliYWJhLmNvbT4NCi4uLg0KPiAgDQo+ICAvKg0KPiAtICogQ2Fs
bGVkIGFzIHRhc2tfd29yayBiZWZvcmUgcmV0dXJuaW5nIHRvIHVzZXItc3BhY2UuDQo+IC0gKiBF
bnN1cmUgYW55IHF1ZXVlZCB3b3JrIGhhcyBiZWVuIGRvbmUgYmVmb3JlIHdlIHJldHVybiB0byB0
aGUgY29udGV4dCB0aGF0DQo+IC0gKiB0cmlnZ2VyZWQgdGhlIG5vdGlmaWNhdGlvbi4NCj4gKyAq
IHN0cnVjdCBtY2VfdGFza193b3JrIC0gZm9yIHN5bmNocm9ub3VzIFJBUyBldmVudA0KDQpUaGlz
IHNlZW1zIHRvIGhhbmRsZSBzeW5jaHJvbm91cyBtZW1vcnkgZXJyb3JzLCBub3QgbGltaXRlZCB0
byBNQ0U/DQpTbyBuYW1pbmcgdGhpcyBzdHJ1Y3QgYXMgc3VjaCAobW9yZSBnZW5lcmFsbHkpIG1p
Z2h0IGJlIGJldHRlci4NCg0KPiArICoNCj4gKyAqIEB0d29yazogICAgICAgICAgICAgICAgY2Fs
bGJhY2tfaGVhZCBmb3IgdGFzayB3b3JrDQo+ICsgKiBAcGZuOiAgICAgICAgICAgICAgICAgIHBh
Z2UgZnJhbWUgbnVtYmVyIG9mIGNvcnJ1cHRlZCBwYWdlDQo+ICsgKiBAZmxhZ3M6ICAgICAgICAg
ICAgICAgIGZpbmUgdHVuZSBhY3Rpb24gdGFrZW4NCj4gKyAqDQo+ICsgKiBTdHJ1Y3R1cmUgdG8g
cGFzcyB0YXNrIHdvcmsgdG8gYmUgaGFuZGxlZCBiZWZvcmUNCj4gKyAqIHJldF90b191c2VyIHZp
YSB0YXNrX3dvcmtfYWRkKCkuDQo+ICAgKi8NCi4uLg0KDQo+ICB9DQo+ICANCj4gLXN0YXRpYyBi
b29sIGdoZXNfZG9fbWVtb3J5X2ZhaWx1cmUodTY0IHBoeXNpY2FsX2FkZHIsIGludCBmbGFncykN
Cj4gK3N0YXRpYyB2b2lkIGdoZXNfZG9fbWVtb3J5X2ZhaWx1cmUodTY0IHBoeXNpY2FsX2FkZHIs
IGludCBmbGFncykNCj4gIHsNCj4gIAl1bnNpZ25lZCBsb25nIHBmbjsNCj4gKwlzdHJ1Y3QgbWNl
X3Rhc2tfd29yayAqdHdjYjsNCj4gIA0KPiAgCWlmICghSVNfRU5BQkxFRChDT05GSUdfQUNQSV9B
UEVJX01FTU9SWV9GQUlMVVJFKSkNCj4gLQkJcmV0dXJuIGZhbHNlOw0KPiArCQlyZXR1cm47DQo+
ICANCj4gIAlwZm4gPSBQSFlTX1BGTihwaHlzaWNhbF9hZGRyKTsNCj4gIAlpZiAoIXBmbl92YWxp
ZChwZm4pICYmICFhcmNoX2lzX3BsYXRmb3JtX3BhZ2UocGh5c2ljYWxfYWRkcikpIHsNCj4gIAkJ
cHJfd2Fybl9yYXRlbGltaXRlZChGV19XQVJOIEdIRVNfUEZYDQo+ICAJCSJJbnZhbGlkIGFkZHJl
c3MgaW4gZ2VuZXJpYyBlcnJvciBkYXRhOiAlI2xseFxuIiwNCj4gIAkJcGh5c2ljYWxfYWRkcik7
DQo+IC0JCXJldHVybiBmYWxzZTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KPiArCWlmIChm
bGFncyA9PSBNRl9BQ1RJT05fUkVRVUlSRUQgJiYgY3VycmVudC0+bW0pIHsNCj4gKwkJdHdjYiA9
IGttYWxsb2Moc2l6ZW9mKCp0d2NiKSwgR0ZQX0FUT01JQyk7DQo+ICsJCWlmICghdHdjYikNCj4g
KwkJCXJldHVybjsNCg0KV2hlbiB0aGlzIGttYWxsb2MoKSBmYWlscywgdGhlIGVycm9yIGV2ZW50
IG1pZ2h0IGJlIHNpbGVudGx5IGRyb3BwZWQ/DQpJZiBzbywgc29tZSB3YXJuaW5nIG1lc3NhZ2Vz
IGNvdWxkIGJlIGhlbHBmdWwuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+ICsNCj4g
KwkJdHdjYi0+cGZuID0gcGZuOw0KPiArCQl0d2NiLT5mbGFncyA9IGZsYWdzOw0KPiArCQlpbml0
X3Rhc2tfd29yaygmdHdjYi0+dHdvcmssIG1lbW9yeV9mYWlsdXJlX2NiKTsNCj4gKwkJdGFza193
b3JrX2FkZChjdXJyZW50LCAmdHdjYi0+dHdvcmssIFRXQV9SRVNVTUUpOw0KPiArCQlyZXR1cm47
DQo+ICAJfQ0KPiAgDQo+ICAJbWVtb3J5X2ZhaWx1cmVfcXVldWUocGZuLCBmbGFncyk7
