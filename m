Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17156E249D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjDNNtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDNNs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:48:59 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC959ED5;
        Fri, 14 Apr 2023 06:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRp8ieon1zxnb69YHgyWelJLOtyaexsfV7m3k49oJatvTIOM2SRLn4XQXsul2dDkAKZzhJJbqvtZAMJgY6ZID2X6at68hUskjWHLDz3HgNNPbdiiuJ1ajiMrDartsrNiT0AzME8NleJIIv4X4iRyIAUQ0nZ73L5wBYc08cByJxhbm990fMkZrXtLRQHa1km0i74uL1nHqdFUbKdcdH7LbPcfI8vB9tymQm9jZA2z6FR8VJZkVu4ESggryPo9xsGl0U7szaRa2a7Y12Z54DoHH+Qbb480TuejbpdDtnLfyK1DaYo29Q5O1TVNxmDJoAdmSj8jky4/WhzAvU9oXEm3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TojN2yG3MItHXoTf/dzDBcpEbg0dT5DpaifPEuVu5Q4=;
 b=OdiMu48fR6cbwKbsvmCBA2K0YS+Mcl9fx7dgu8Rqm7V03liAoDCx+Qk9SX5ZIaJzMbNZIrgnm5MAjSfBfV71hO/iARrHo3zs59J0YYShruug5a5HOJOAF6mv7q1ESQPyhZvHI9It1H1Nl3U1296lapC8QuTheFmGi8jHDq4zPoOhTgiGu+d/ECMi8ODQJOQFoVbpiXXuRt1tV1Tv82aUfhs6tuUf6UhzP6NFiQAXNDKKl4MpBUuQRuGF8w5sYHcCkbUqxougM5itZhj3/wmHb3uXzfZEX9lHc+weplaNlokehBUNasDuWSMFps0AgKx0GV97pN+IjEGc1Uj+fLMQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xsightlabs.com; dmarc=pass action=none
 header.from=xsightlabs.com; dkim=pass header.d=xsightlabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TojN2yG3MItHXoTf/dzDBcpEbg0dT5DpaifPEuVu5Q4=;
 b=z66cjHtuTlhPGi/1ChoCIOhjyw7yJ18Jf7CaFvUPEnTgZxK+8ZS03WhCKa2YiBgbxa4cwhXsCg4ieBxATWGJJb1pC1sjBfVbQ8+fyIRV3UwolYDhHNgyilmP4dUDb+lI+vo6x1dyUUutgOCIebnYoPa2uZVFAYfsYMPCtMbIBvE=
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:446::5)
 by VI1P193MB0607.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:15b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 13:48:45 +0000
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::fd74:ebbb:46ac:8a82]) by AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::fd74:ebbb:46ac:8a82%4]) with mapi id 15.20.6298.028; Fri, 14 Apr 2023
 13:48:45 +0000
From:   Robbie King <robbiek@xsightlabs.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>,
        "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "huangdaode@huawei.com" <huangdaode@huawei.com>
Subject: RE: [PATCH v2 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
Thread-Topic: [PATCH v2 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
Thread-Index: AQHZVmXrfTRFQyNc3E2WN8mIgww8bK8OkxgAgAAQQYCAFUbqgIACccawgAPRhYCAANJw0A==
Date:   Fri, 14 Apr 2023 13:48:45 +0000
Message-ID: <AS8P193MB2335F1954BC345575A2C8829CA999@AS8P193MB2335.EURP193.PROD.OUTLOOK.COM>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230314111135.16520-1-lihuisong@huawei.com>
 <20230327113326.dgrb5ainl6mv7wr5@bogus>
 <570a6f6d-87cb-48ca-3bbc-cd1221bfa88c@huawei.com>
 <7ef4eec4-2cfb-6f66-a9b9-9c130a1b71d8@huawei.com>
 <AS8P193MB2335FA58943B305F97D2BACCCA9A9@AS8P193MB2335.EURP193.PROD.OUTLOOK.COM>
 <57c537d8-6728-2ffc-3421-accd79c1eddf@huawei.com>
In-Reply-To: <57c537d8-6728-2ffc-3421-accd79c1eddf@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 5cdbd96e-472e-472c-983e-2caadb25b99b
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xsightlabs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P193MB2335:EE_|VI1P193MB0607:EE_
x-ms-office365-filtering-correlation-id: b4d1a8d0-9378-442a-65ad-08db3ceef76b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s0h0IrEeWlvXrQJ+fMepH2cKsWWtceQpDf7+IPUw+CGFo1rMmSOsNbJnzRdcb8Qlw+N8Mi5BjIcHPLHNVuybOjPhLnAHCf7qcNw59QUMrOrZYLUy2ronoTwponymvhf5dHoCg9rD7EcI9ifASOWeVGIuHQF2Zt76XxWFauh85KeLezxGKj5kwGjtwwTiDpDta/U4jhdVp7NuQ0s8/DD2PwxT6EmcKl0Rkqfl09jJU1dbXuGegr4cRiHoa+xXLjTXBu3TCIANq1uCFVlSBqxIhoXcIORbx7OVzbuGoekEYR0GIkH7PNs9mj9wI6xFAGGUTOe759F3OiTZnx9l3xvPFTaioe+mp6jNLwEkusT4cxBe5/c3mqaEp9ZrV0H2Wv9UPqwtcrS8RRi6S0r6EK8htDW47l5CjJujNEu/1gO7YYUJZ9C+kFtxPwaCWievz2cozrYpOCIcjSyKKZB+oWtg3efL5Kvrm/5Zl0aH9lcP3zxQ6AZqmkNV7bbApqJSnY65dWuch1slC6eZ/+eDTx2AEQjK7I9PXKtvTKriY9jzGsi/LofrSVKg1227+JFLJqEFyk8aJ2YjvYlQFfAk7a3wbYZmJtjMfSq4bdaPAamDlDc5zBxznDojGHLaA2jrUOZX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2335.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39830400003)(396003)(376002)(451199021)(110136005)(53546011)(9686003)(26005)(6506007)(54906003)(55016003)(186003)(83380400001)(71200400001)(7696005)(5660300002)(33656002)(41300700001)(316002)(8936002)(8676002)(52536014)(38100700002)(38070700005)(86362001)(122000001)(478600001)(66946007)(4326008)(66446008)(76116006)(64756008)(66556008)(66476007)(2906002)(15650500001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVNGOWZHelVpSlM3QkxoV21MS1ppS0ErWnIrRFM5S2prM3pIeVVjTXVheXhn?=
 =?utf-8?B?VWhQdnhSWVh6WjJTRHpFcWpjT0N3TG10K3pCVXNhaWNlbFoya1VqZklsNklC?=
 =?utf-8?B?Zmt4bk9rbTg5MDVRLzQ5aElBN2J0NHNEcDZTVjZXQk1TaXBZVDBVQ0lLSXFK?=
 =?utf-8?B?KzRlazdjWlFqaVdoNjE4TU9jWTNyOUpUZUxjcmpEbW9rd29qenBES2tQOE1V?=
 =?utf-8?B?UmRIYUE1QjJZVW10K2dKdklZSXBxajFGMXNSZ1N6QmZveDBjcU9DRDdiWDFU?=
 =?utf-8?B?ZlRKSWdUOXJPTVI5TWQ3QWRZYVVLM2JWWlZSYk5wRzh6NG5OY1UySm9INjF6?=
 =?utf-8?B?aTNpc0ZIQ05Ocm9IdzRGWWllL2Z3eklQQ094L3VlbWgvQ2JRVWRNRVVMNjFh?=
 =?utf-8?B?a241WldZWXQwVk9hVVdnaDFaV3FFOEUvcEVPQnI4S2c2bmwydzhwd3pGYXAr?=
 =?utf-8?B?eWw1MldWV3VjRnJTS0lhZ09wOWRPc2JMSzNyeGs3YU9YRlZoWWZOK0pqdi9p?=
 =?utf-8?B?SUJ2c1QzN2kwZmNLS1pURk1xMXl4Uzh2RExzaW85S0c3MGRkQ0hDWm54bElv?=
 =?utf-8?B?UXdTZkd4dXQxb1VsUVd0ZEdtNGZvSFZlWlFxYXBIVXE2WXlFK0MzdTZCa1pU?=
 =?utf-8?B?Y3RublV5aXF0NE1TS1ZTbTZSYytjTjZnYTF5VEtTbHN1OEkrRmdlRkRNbGxN?=
 =?utf-8?B?eXhia3JENmdZOVllK2FndDZYeGo3bVF1YlBzSHBKM3JucUVDYmV5QURYU0NB?=
 =?utf-8?B?L01mZXBiQ3RQTXpIVHVPTTlGTS8wc0xzTk55M2Faa3c5WjdqQ3owV3BwYUdE?=
 =?utf-8?B?MWRURnJKaUVCVUVMMjR5anBIcTBoVGllaEkwakJnbHBGU1NBRVAyTVlQMVBs?=
 =?utf-8?B?dEFoUjJ5UGNBenVXZFM1bnBXVUZFbDRIZklvbVJGT1dnaHdRYWYxc1JMblFv?=
 =?utf-8?B?L1ZIUmpWOFBFOTlmU3RyZFdsZUNuZU9UUi9yT1NZb2lTOXZocTczSmZWVG5N?=
 =?utf-8?B?Rk1YT1pMWEdtN2w2S3ppOVloL3A3R0tEKzFVZ2xKZWFvRFZOcUhVbmVtTXZH?=
 =?utf-8?B?V2tPay9YKzFZeTZQNVhWRExZcjdzRFcrb1gvMm5YM2c1YkRTSE44KzN0YXg3?=
 =?utf-8?B?dzFMT0U3bEx1SEw2QWZCMEVlbzVCTlRVZFFoUDgyL2VkTmtsbVJuWGlvU0xq?=
 =?utf-8?B?b0VMcUdJYWUxL3FnSG1zUjlRZlp3QithRGlwV05maW4wTlBCb1NERVVlOE1k?=
 =?utf-8?B?TnE0T3NTOTd3a3l4NEoxVis1ZHpMblZzR09NZ21ORmIzS3E1MWRMemtFcDQ2?=
 =?utf-8?B?WENhRy9ySEpPajllbDhSRDJnM0RuVmFIYndacGI0Z0M0bzdGQVdlaWZTMVZl?=
 =?utf-8?B?WTBBTHN0MWZxdmdnSVBUaDVRUG81d1BFVkVJUXJtcE85Si93S0hnWHVGRkdK?=
 =?utf-8?B?N3QrQWREUCtDOExhWUZlTFZrZ2Q4dFdWci9pTXBpcERldUQvK2dOQndYd3Qx?=
 =?utf-8?B?M0ZwNXliOXdCRC80V28rZytJUVZoK0xEQU5Qbk1keUlZTnYvVEVKR2tRbjU0?=
 =?utf-8?B?YXdXZ2NQVTFTZkJLdVBiZWpzTXBzVnJaaGp2RU9SREZqS1JFT1dBNVBBRlFr?=
 =?utf-8?B?NHNmenhEZWxDT1BocFdIUmZac3MwRVFhY2tHRE50bi92TllQUVZyMGdRU3h2?=
 =?utf-8?B?alNRWkdWMExMOGljSjh3eFVkc0J6eFFNMzU3QStZeVdnS1VocVEyNFg2K3BK?=
 =?utf-8?B?SUZSMjdTL0ZZSlJsOUJMa1Z4ZThNR09scDNTOWNvc2V4Ti9SbDhZM0M3MWV5?=
 =?utf-8?B?Y3RESzVVc0xDSUhabUY3T3F5ZTU0YU1iWkRNdmV6aU9OSnFpQnAzQ3B2bHdE?=
 =?utf-8?B?L3pmYWdud0VDZFBGSkhQWC96SmhQQ2VJc0NXRmsxcDVSdTJndjN6Z3pmSUts?=
 =?utf-8?B?SFZFWUNjUTdXV3BQdGpML0E2aUh0WEJxVG03akpQMzN0czRUdlA0TCtMekxY?=
 =?utf-8?B?SUVLbndJRzl3eE9VS3FzdmVLbWdpTTRKbTlHNVp3WDlCMXhCcWdnQ3hNdVE0?=
 =?utf-8?B?MzRFbjZiTkV3cFRmWFdyL0hEVUV6VkdHcldZVTdkN203cnJjMEprUHB0K3N4?=
 =?utf-8?Q?yHLg7tGod9kFHVvBcuWoA9ljU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xsightlabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d1a8d0-9378-442a-65ad-08db3ceef76b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 13:48:45.3600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 646a3e34-83ea-4273-9177-ab01923abaa9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/uu5m+PJeGB7EmoC/tHWxvG9n/P8D2XydRe052OjK0p6yqeD1dDJOyub9dmd9eaK9Vl84FvXn4GGiVBXHjV2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P193MB0607
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIHRoZSBkZWxheS4gIEkgcmFuIG15IHNpbXBsZSBzdHJlc3MgdGVzdCBhZ2FpbnN0
IHRoZSBwYXRjaCBzZXQgYW5kDQpzYXcgbm8gaXNzdWVzLiAgRm9yIHRoZSByZWNvcmQgaXQgaXMg
Ynkgbm8gbWVhbnMgYSB0aG9yb3VnaCByZWdyZXNzaW9uLCBidXQgaXQNCmhhcyBpbGx1bWluYXRl
ZCBpc3N1ZXMgaW4gdGhlIHBhc3QuDQoNClRoZSB0ZXN0IGl0c2VsZiB1c2VzIGEgImhlYXJ0YmVh
dCIgbW9kdWxlIGluIHRoZSBTQ1AgZmlybXdhcmUgdGhhdCBnZW5lcmF0ZXMNCm5vdGlmaWNhdGlv
bnMgYXQgYSBwcm9ncmFtbWFibGUgaW50ZXJ2YWwuICBUaGUgc3RyZXNzIHRlc3QgaXMgc2ltcGx5
IGdlbmVyYXRpbmcNCnRoZXNlIGhlYXJ0YmVhdHMgKFNDUCB0byBBUCBub3RpZmljYXRpb25zKSB3
aGlsZSBhbHNvIGdlbmVyYXRpbmcgcHJvdG9jb2wgdmVyc2lvbg0KcXVlcmllcyAoQVAgdG8gU0NQ
KS4gIFRoZSBub3RpZmljYXRpb25zIGFyZSBzZXF1ZW5jZSBudW1iZXJlZCB0byB2ZXJpZnkgbm9u
ZSBhcmUNCmxvc3QsIGhvd2V2ZXIgU0NQIHRvIEFQIG5vdGlmaWNhdGlvbiBzdXBwb3J0IGRvZXMg
bm90IHN1cHBvcnQgU0NQIGdlbmVyYXRpbmcNCm5vdGlmaWNhdGlvbnMgZmFzdGVyIHRoYW4gdGhl
IEFQIGNhbiBwcm9jZXNzIHRoZW0sIHNvIHRoZSBoZWFydGJlYXQgcmF0ZSBtdXN0IGJlDQpyZWFz
b25hYmx5IHNsb3cgKG9uIHRoZSBvcmRlciBvZiAxMHMgb2YgbWlsbGxpc2Vjb25kcykuDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBsaWh1aXNvbmcgKEMpIDxsaWh1aXNvbmdA
aHVhd2VpLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgQXByaWwgMTMsIDIwMjMgOTowNSBQTQ0KVG86
IFJvYmJpZSBLaW5nIDxyb2JiaWVrQHhzaWdodGxhYnMuY29tPjsgU3VkZWVwIEhvbGxhIDxzdWRl
ZXAuaG9sbGFAYXJtLmNvbT4NCkNjOiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7IHJhZmFlbC5qLnd5c29j
a2lAaW50ZWwuY29tOyB3YW5naHVpcWlhbmdAaHVhd2VpLmNvbTsgemhhbmd6ZWt1bjExQGh1YXdl
aS5jb207IHdhbmd4aW9uZ2ZlbmcyQGh1YXdlaS5jb207IHRhbnhpYW9mZWlAaHVhd2VpLmNvbTsg
Z3VvaGFuanVuQGh1YXdlaS5jb207IHhpZXhpdXFpQGh1YXdlaS5jb207IHdhbmdrZWZlbmcud2Fu
Z0BodWF3ZWkuY29tOyBodWFuZ2Rhb2RlQGh1YXdlaS5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMC8yXSBtYWlsYm94OiBwY2M6IFN1cHBvcnQgcGxhdGZvcm0gbm90aWZpY2F0aW9uIGZvciB0
eXBlNCBhbmQgc2hhcmVkIGludGVycnVwdA0KDQoNCuWcqCAyMDIzLzQvMTEgMjI6NDcsIFJvYmJp
ZSBLaW5nIOWGmemBkzoNCj4gQXBvbG9naWVzLCBtaXNzZWQgZWFybGllciBlbWFpbHMuICBXaWxs
IG1ha2UgdGhpcyBhIHByaW9yaXR5IGZvciB0aGUgd2Vlay4NClRoYW5rcy4gTG9va2luZyBmb3J3
YXJkIHRvIHlvdSByZXBseS4NCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogbGlodWlzb25nIChDKSA8bGlodWlzb25nQGh1YXdlaS5jb20+DQo+IFNlbnQ6IFN1bmRheSwg
QXByaWwgOSwgMjAyMyA5OjI3IFBNDQo+IFRvOiBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBh
cm0uY29tPjsgUm9iYmllIEtpbmcgDQo+IDxyb2JiaWVrQHhzaWdodGxhYnMuY29tPg0KPiBDYzog
bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IA0KPiByYWZhZWxAa2VybmVsLm9yZzsgcmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb207IA0KPiB3
YW5naHVpcWlhbmdAaHVhd2VpLmNvbTsgemhhbmd6ZWt1bjExQGh1YXdlaS5jb207IA0KPiB3YW5n
eGlvbmdmZW5nMkBodWF3ZWkuY29tOyB0YW54aWFvZmVpQGh1YXdlaS5jb207IA0KPiBndW9oYW5q
dW5AaHVhd2VpLmNvbTsgeGlleGl1cWlAaHVhd2VpLmNvbTsgd2FuZ2tlZmVuZy53YW5nQGh1YXdl
aS5jb207IA0KPiBodWFuZ2Rhb2RlQGh1YXdlaS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAwLzJdIG1haWxib3g6IHBjYzogU3VwcG9ydCBwbGF0Zm9ybSANCj4gbm90aWZpY2F0aW9uIGZv
ciB0eXBlNCBhbmQgc2hhcmVkIGludGVycnVwdA0KPg0KPg0KPiDlnKggMjAyMy8zLzI3IDIwOjMx
LCBsaWh1aXNvbmcgKEMpIOWGmemBkzoNCj4+IOWcqCAyMDIzLzMvMjcgMTk6MzMsIFN1ZGVlcCBI
b2xsYSDlhpnpgZM6DQo+Pj4gT24gVHVlLCBNYXIgMTQsIDIwMjMgYXQgMDc6MTE6MzNQTSArMDgw
MCwgSHVpc29uZyBMaSB3cm90ZToNCj4+Pj4gUENDIHN1cHBvcnRzIHByb2Nlc3NpbmcgcGxhdGZv
cm0gbm90aWZpY2F0aW9uIGZvciBzbGF2ZSBzdWJzcGFjZXMgDQo+Pj4+IGFuZCBzaGFyZWQgaW50
ZXJydXB0IGZvciBtdWx0aXBsZSBzdWJzcGFjZXMuDQo+Pj4+DQo+Pj4gT3RoZXIgdGhhbiBhIHN1
cGVyIG1pbm9yIG5pdCBpbiB0aGUgcGF0Y2ggMS8yLCB0aGlzIGxvb2tzIGdvb2QgdG8gbWUuDQo+
Pj4gSXQgd291bGQgYmUgZ29vZCBpZiB3ZSBjYW4gZ2V0IHRlc3RlZC1ieSBmcm9tIFJvYmJpZSBL
aW5nIA0KPj4+IDxyb2JiaWVrQHhzaWdodGxhYnMuY29tPg0KPj4+DQo+Pj4gUmV2aWV3ZWQtYnk6
IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+DQo+PiBUaGFua3MgZm9yIHlvdXIg
cmV2aWV3LvCfmIENCj4+DQo+PiBAUm9iYmllIEtpbmcsIGNhbiB5b3UgZ2l2ZSB1cyBzb21lIGZl
ZWRiYWNrPw0KPj4gTG9va2luZyBmb3J3YXJkIHRvIHlvdSByZXBseS4NCj4+DQo+Pg0KPiBAUm9i
YmllIEtpbmcsIGtpbmRseSBwaW5nLg0K
