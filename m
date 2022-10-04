Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39DC5F3C28
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJDEfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJDEfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:35:52 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on0614.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e18::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4CD2F3AD;
        Mon,  3 Oct 2022 21:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lS3epz0Xzg+7Hqv8pkElEgMbEFgBvl2hr29rZpUevz8HHqeFN0JQpb/0/JiS9YEbxicpegmGtspCKQUBHBApzhKTwsyX2RDvwonPMjOikdr44VEQF8c4jYvO9w8bCLreaYI65BgT09yDvyFicdOzR80I5dv3BycDuRlDaArlu3wEnX+uio8vu7oge+7S/r5GJ3QCAm+5cFl3FjRDcd7zOfUrNx4kb1kJ4lKBe1bPS8ihGXlXKdf3BUb3SoGFnr8ZyrN1F47dar4xC13bH6zGnnJOL9rO1Z5uOSNyAz8KfD4CmJnGN0a2jypspyd+3OpTjLiwTw1m8llKmZZyl/RENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g5wgM6793DwXTQUCuGhfl1RJU808qhrdy0qwg7G6Yg=;
 b=dX99jjhainB7sm/0XYghjiIAbSMT4UzlrGN0hJrsMVsrzSmtGUjk4es1Df5++JXux24hXdwjk5BKk1DjQdwRzdRAyxOlshatKAyX+ITbUcFHGm/8JcqGKVBVHQNr1f3TwiCxPqwFZBuff3MJp2yKvzOpmk5CCjkbaD2rDGJb4H9Tg0wjK80Iw0arX09pT1RoOZ+1i5DF5q2SdsMVRNmhJIYFsSNo2GpmmxQQ8f9SpwcQRr0Pnbrq2PDWqx/QIOgZKRuhGF4OnUHLJ8BQlPpF4QSBi2JmLd4dRKkp/ruemVxWiQXgdGmz6fQ3xnvYHNyOUAKRDJcJslPtAAK2Q7m+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g5wgM6793DwXTQUCuGhfl1RJU808qhrdy0qwg7G6Yg=;
 b=A+oOn+ZkDoiXe0fuMHzxLQhaHPtGxFI53c2iQEahYQES5OhGO6ufd298rpN/KoY4JjyX5QG8mXXmoUMON1abqIEE6I700xwy5bmCg5T9KInE5xzmCg9RVMl9OrLt6mCdk9CSy1tVYYWw5Y2hZdyDpK6PWlv/G4f+OC1GtxxpvnBBlBElVrt0FIhyFlocFXNgOblT8XKu+Icpg14LNNG54h6IZo00S1oc6v00vshXM03nBuMExPfRTejF/bt8HGnWVbWnx4tDRggdHpTrL3I8k5kqCdSLp+341ckGSP13E6KR87J3hMZ4FJ4NgeF5Za8/0K/BwDRGhY55qX2dHkyxdQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3225.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 4 Oct
 2022 04:35:44 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%5]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 04:35:43 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: remove redundant module_sysfs_initialized
 variable
Thread-Topic: [PATCH] module: remove redundant module_sysfs_initialized
 variable
Thread-Index: AQHY0/yEs1No0D9xZEij+IG8gNErGq39WvoAgABSjoA=
Date:   Tue, 4 Oct 2022 04:35:43 +0000
Message-ID: <4f4a62a2-4395-420f-0a20-e84c06b8c3ed@csgroup.eu>
References: <20220929121039.702873-1-linux@rasmusvillemoes.dk>
 <Yzty2iIZgv7NQrqL@bombadil.infradead.org>
In-Reply-To: <Yzty2iIZgv7NQrqL@bombadil.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB3225:EE_
x-ms-office365-filtering-correlation-id: 0da799f1-4f08-4e32-7514-08daa5c1e66b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aH7ugPtwSc3XDdl2AXfXpH4DKTLSMJItysGaNV55LtQp6FZvQIj+NTcwap8AXwdtZ9sDfkOcU1YSEe5a3mmvcirXHKPlDXPZU3zPTuxaEYl1FUrznD4BWP1T6jEtPYOtXcoT6IOKlc7SAmyYW1QZqc1GAVBzJQufyrZYEMyvz3muDHwgqaWbZPHx+CulEwezxoOsEdo0sLqjUBpkUV9iEdwC29IbaDVojvHHjUwEDmI/7Q3gefi0f6SfB8ZT7/PGPrgSwvRAysj5/IGA7jz+xT79GLq3b/E4wy+jlnrr6K6JEKj2l985zHS6oyRccCJXqlnwE06e9kWER19N0SnbFITnDrKd1UYOPPLUOOCH/8bvkD9Pu52gmo2g36rHEL0zU7iajbMdgntDJctDZoJaiOsKU7IYlav8c6JZLzUtjL5L+VFdgDzvQKopeyZlOffaTplISXNMR7uYmB/On1/AWgBmOJGNdGaMwdl1cIJsebUMeffjWB9UP1bp1I/8+VuVeVdc/liaXQO5Bs4CU+R9BwcZdxXuekQAmNhzo5qHUpNMDNxinHw+xeZibN5HynIIeIlwyOTjeroM84h6HQOhc0JwzqOjiGBxqtdYD+/VieS7YrodtpUM4PscD3FuuCm2SHhxIBtJnhb6CN5h6BqgxHNRDm88fhn54uIfMu8dOmDLpaMBcXYdFsl6Bcvi+Sj8VuP+7nByMROOg7sa+QUfNUCkIS5ZfKmsWWDBOyW1wCcJRe1SV8/+ava/zMjYIV5nH4g5wSv2PK9YbM9y4evLIShKDZe1LLEH/bjsq5aasvjAiVIl+m9132FG81W1iyR88FvtVdUmH2SyZeb01nvlYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199015)(38100700002)(2616005)(186003)(31686004)(71200400001)(2906002)(122000001)(38070700005)(44832011)(6486002)(4744005)(54906003)(4326008)(86362001)(110136005)(8936002)(31696002)(316002)(91956017)(76116006)(64756008)(41300700001)(66476007)(8676002)(66446008)(66946007)(66556008)(36756003)(478600001)(6512007)(5660300002)(26005)(66574015)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K204Y0RvS3BYSFpwL0NZa1BVdnhYMm1SbCt6ZU4yU3NsODhENGlmbjNEYkNm?=
 =?utf-8?B?Y0hrNEg2ODg2cmZQdTZtOVVSUmVLNXR1TFRwWEROdzZ3L3Nnb1JMRFRDWHVV?=
 =?utf-8?B?VEhjSno1ZXk0YldxRGNzcTMxaFA0TUp4MWxES3BSZzNiZGpROGx2clpXMGFy?=
 =?utf-8?B?L0xCd1VkY0xJbm1wVFFsVHpPSWkvRkx5RVNYKzJ1OGhTMlkxeWZraGFUNVVE?=
 =?utf-8?B?RGJVbkFWMHFzVGU1MDJPdkJrY0Q4RkV6M1ZCSWR0M3FSM1NKZ282eG9YY2JK?=
 =?utf-8?B?UUF0YUxqMUF0Ymd5Nm9qUCswUU5NSVAxYmFnbDRlSmxuMmhoZzBIL2lFL3BD?=
 =?utf-8?B?c2lkZ1BPZWdLbmhzN01ZVjhaL3JSUE8zYlhFYnFmR2xxMXpYVmM3VzFlL3BR?=
 =?utf-8?B?Z0hVZDhzbmZYa2twNzRzZWdVRFZWRGpRUkQwT0lFT1VoeUNPa1MwVWxjS1gw?=
 =?utf-8?B?eXFkV0sraGE1ZVg3Ui9rWXlKRHpycTdObUEweHZqNm90czFZU0l1VDJlZkNS?=
 =?utf-8?B?RkZ3ZzJ1NU9CVU4zbjhucXZtNm0wSW00Y2dydGIwTTdKQXB0N0hOdm9kcENy?=
 =?utf-8?B?NWE4aG9POXFaZ2RUc3hXK1lMb3ppQXhvLzU3N0tkaEphYjEvaERnWXpIdXlv?=
 =?utf-8?B?Q29PcDRFWVJLS1d3Z2FvVHM2R2kwaHZLVFh1SVh5OE9wTnFpNHN2dmdsbVpF?=
 =?utf-8?B?dmEwRkRmZXMvVkdvZ2NRdDBSZ20vLytIVlZzbG9md2xCWGFZcm1iYk95NDBG?=
 =?utf-8?B?cm9neHhibGRWOWFNWUZHSlprWWJDRkVWVUJ6cTU5UHhwMGhBc3JFL1NBN1VK?=
 =?utf-8?B?b1ZJbEdqUis4SDNhdUNDN3pkY3l4V1BiL3g0UFNrVTNQaksvVkxIZnY5RFZi?=
 =?utf-8?B?T0wzdjNtSFcwTzNVL0x6ekF2R2Joc0x0MzRkQTRudGo5RVRTNitONk9ZRWhL?=
 =?utf-8?B?UnZWWmMzU3Zqc1pFc3FxbWRXdDF3TFVvc2pFbmQwdm9Kc3JBVFNud0g1Mlor?=
 =?utf-8?B?K3oxSGZpb3QyZGhxNGVtRzB5dEZUQzJkVWtJR3dWcXZTSFp6NWlhbU90bFJN?=
 =?utf-8?B?bTkvbzBJYnB4TXNsT01tRnlyVEp4VytNVzFXeXVuWWFEMzRhR1FqY3BkcC9n?=
 =?utf-8?B?U1VpNElYU0FPYy9LQk9tWS9hcUhnSXhLZ1BTclRzbkFkalNvZytzYlhYREIr?=
 =?utf-8?B?cG1kU2FwcTd5SnRjbEQwSmhJeG0yWS9wdEF0WXNseEY1Tm1JQVc4WXpkSjRY?=
 =?utf-8?B?N2lkWmtoT0RVbWVudGZBTis4MExPSVJiR29jRnFwYUVYUkpoUk9TVWN1T2J3?=
 =?utf-8?B?OVk2WFdWU0tQdGhBM1Z4NG1tRXRoZ3lyY3JSWUFSeXp4UEtMQXdTZDh6USt1?=
 =?utf-8?B?UlRqUTJ1em1uVjdVNC83T041SDJObzNraUdscU80QUkra0JHdHpSYUxQSVRQ?=
 =?utf-8?B?N0tBaTAzU2ZYUEdvVXh1cnNld3ZxTVl6b3Q2ejI5VWNmdFZNNkMwM0VGRXdK?=
 =?utf-8?B?L1ZxaTVTdXc2Y1J3MmJIL05WcDFMRFUyb1J2TWxHcjJjVmNNM1RQbnBta3RG?=
 =?utf-8?B?c21OOG1TQUhCZ3B1ajhUYlYraTZKVWtaYjZ4aU9DSjdIc2l6ci9NQ05yNURt?=
 =?utf-8?B?SzJVNnErbElJb2svdFZEeWp1Q3AvTHpaM3BFYndRdGUvdExwTTBCMjluVFVi?=
 =?utf-8?B?UDJiSjlWY2dKTnE5NjlwTWtJTjNoVERrWWRCSEZWbndIbE0rWXdmOHU2dmxB?=
 =?utf-8?B?NjkwbUg0OGhKVHlYa3JzVThWUWc3VHBMZ0xoTkhnWHRxMzd0WEFmcGZmNnRT?=
 =?utf-8?B?b2ovZkdldTFmTXhiZUZkWUZkVjVNKzJpQkFjTVVRTnlzc2duMlNyU21ESlF4?=
 =?utf-8?B?TVd4NFpmZlZZdGFNWDdvbHJ3YWhPRmRjRXM1azdsbkY5Q1l5eVAweERlbXF5?=
 =?utf-8?B?aEwrVFdrZkdaSGNNcnlUN2dyWlh1QzRMbS9JZEIrbkhQbG1qaW5zQXVWQTlC?=
 =?utf-8?B?Q05BaEhoempMOHdkdkxvU3h5dHJOcVEyRzBZemtPL3E5YitTaEdpNHdvMWZP?=
 =?utf-8?B?WGhNR0FoWjZPaFBPMThGc1BhTWpRSVY1TFlHZnNyVWNZN2xOcHNad0dONWp3?=
 =?utf-8?B?d21QUWtUTXhIbnpPZW4zbHFxUGxPMG01RlVCbkgzc0Y1ZDk4RU9NQ3l5NnVK?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5F08058A8F77F4C971302FD3970765B@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da799f1-4f08-4e32-7514-08daa5c1e66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 04:35:43.9107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNZzf7Jrtn9VG6NpNOFg9ONT2f8Y7h4Cb3aXLu9kQ2FIrLazTK1TD2rp/X2JmTwv1dWSm1vjQSofjtQRovq01FeGGv2dDI5Pdve2LDPpKAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3225
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA0LzEwLzIwMjIgw6AgMDE6NDAsIEx1aXMgQ2hhbWJlcmxhaW4gYSDDqWNyaXTCoDoN
Cj4gT24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDI6MTA6MzlQTSArMDIwMCwgUmFzbXVzIFZpbGxl
bW9lcyB3cm90ZToNCj4+IFRoZSB2YXJpYWJsZSBtb2R1bGVfc3lzZnNfaW5pdGlhbGl6ZWQgaXMg
dXNlZCBmb3IgY2hlY2tpbmcgd2hldGhlcg0KPj4gbW9kdWxlX2tzZXQgaGFzIGJlZW4gaW5pdGlh
bGl6ZWQuIENoZWNraW5nIG1vZHVsZV9rc2V0IGl0c2VsZiB3b3Jrcw0KPj4ganVzdCBmaW5lIGZv
ciB0aGF0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFJhc211cyBWaWxsZW1vZXMgPGxpbnV4QHJh
c211c3ZpbGxlbW9lcy5kaz4NCj4gDQo+IExvb2tzIHByZXR0eSBzYW5lIHRvIG1lLCB0aGFua3Mh
IEknbGwgcXVldWUgdGhpcyB1cCBmb3IgNi4yDQo+IGFzIHdlIGRpZG4ndCBnZXQgYSBjaGFuY2Ug
dG8gc3BpbiB0ZXN0IHRoaXMgZm9yIDYuMSBvbiBsaW51eC1uZXh0Lg0KPiANCg0KTWF5YmUgeW91
IGNhbiBtZW50aW9uIHRoYXQgdGhpcyBpcyBhIGxlZnRvdmVyIGZyb20gY29tbWl0IDc0MDVjMWUx
NWVkZiANCigia3NldDogY29udmVydCAvc3lzL21vZHVsZSB0byB1c2Uga3NldF9jcmVhdGUiKQ0K
DQpDaHJpc3RvcGhl
