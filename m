Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57237651C37
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiLTIPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTIPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:15:46 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2058.outbound.protection.outlook.com [40.107.12.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8E0DC7;
        Tue, 20 Dec 2022 00:15:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2IGkFLwgCGhNns8Nq6m+Nd8nUQFpTNIO0w5Q2D0zlW8LHjw6HfRD4AuwtnZmFM+UiWs7rqW28ClwmF8y2YAYt018imWBYiO7MOHHrCo0WFpK4Q0Hb1gNcIDhjfb1qSVrQpn/PoBPwtESKlTPa1725IQbpHooq5uXrAG+vrJRV2jLF7ge8zIUgB5Te+jEnBnJGZdGrtu9TrHMDv3Gr3MpcZQg5kZfVzvectbp79dkcA5+skXNkNYmLutMDuihJxWkaIyLV7yhEBU/jCdaZYY3bn99c4+sO1SRGK2IDdUE7u3wTZ1tNjre3j7eFhItIFTjVSr34zQ7LFaHvK+5Ej3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEM+qd8eZmtAZ0RHfiWDjE4FO7OtstlXC7CffkRtz4I=;
 b=QhOuk14IALv7LBU1W9xwhS7fJq2JUjVMFdperEjECr6mcUfcJF4phrbn7b3Oax9xt23hnU+RkAkDu/GHCwAnAdZ9zWQnIXOqqf6dt9d9b8NzvqKrk+fg1mOHomywWKqtymRmiJiVcI+rkB0lrbmkD9Ki4j4zNm5ftWjlxId+b171QDmQljY4yxxFllmaUoZ2eEWV/e1gAD6at5AfX0Lq8V/QntzlEHQfgndvvqO4gcMBHbyuEJekzqNjkF73RHkF7fXaXunwJM4T9p82IrLHZvknoINzrYIfAWRPBBPwLe7i5L9FdnwmAaiSQVCQQ4qrGcrnmMiKx1OB+ufd0I+VjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEM+qd8eZmtAZ0RHfiWDjE4FO7OtstlXC7CffkRtz4I=;
 b=OwEWzQAKBhGrrwSR1y1mQlPDkJA83FWBRZ0UQNqoilvJxwOlz+KneNVJbKXsbEc2qmudOZun23bqsOuBhzCmrx4t8wF3zYCQucWm35I3vngX6lXwEEf4aK0XW7TC/qEThugxyzeg6qZpNpDMKAs82Wy7fa7EVFEDQiaA+ZO2KiBr7dHYTrvakTnEz1vSAYQuuyY/Frm5VSw6WMJhiHoPclYFheE5o2Qlc93u4gKv6AI7pIlQAZo6OmWdqVhsOCAW83Ir2As/qYS6Y5p6MODXefflui9PMp4TZ6rrGv0z9qJec2uWOnjiTfMx0h+VO4Eb9BwoUHh3n6aSfMl6vUiPTA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3409.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 08:15:40 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 08:15:40 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
CC:     Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
Thread-Topic: [PATCH] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
Thread-Index: AQHZFD4z6jwauTYqOUu5AtvrHNKQoq52bgIA
Date:   Tue, 20 Dec 2022 08:15:40 +0000
Message-ID: <df75bb4e-6cf8-7f41-b053-9619c13d1c72@csgroup.eu>
References: <20221220063923.1937-1-thunder.leizhen@huawei.com>
In-Reply-To: <20221220063923.1937-1-thunder.leizhen@huawei.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3409:EE_
x-ms-office365-filtering-correlation-id: 46175840-13d3-469e-9d21-08dae2626213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6lu3TTjOSyux8rfWaQ+NlXF4FvnI7rTMxCuac6r9djF6UTjgAkFOnewZ5+qAFNEjSnnePEOX4zuvcUhFlTXQzggxlYZrvlmL8n706OBKR2BkQi3Qlkp+oDh2JmxFqF6hKHCqRx+xAnAK+08PztvciRWsx9IazyvRDhx1qnq4Ngasb8yEQnqG0tgGy1r+Ghj+WhCQtpnIV1AxVSaqQuF/bqj808SXKWa9woXJFRP2UlrZ0csr4oZAIk9V0ejP8WPquP9pbQHqhzOhKS5eIr56/8deLLiux3T3hmFz3VZEl00+lpMaRqevBVhRr+aRmjQhaW7Yn85y4R2tw/IjZMdQFqdTV4sTz2mFXTAj1whLBofx3KmgKqOonMVOwlI9f8oTgv86Gfh+y2jAFVLVL+DwMZMte9EZMjvMyFM4sRa+fZbKZqxzzv/FUaoeQ9p6FQso9l/Nog5QrH4rxddKbFjbaKuJ4IrqbNkILKtabdPQJ3LoRogPcoPZNEwZKRmocI0Y4VMF0YxfRlDzlXnaT+ka9WNH4urGMvZKKrZh0vWYhCH+fbtc266LYHP1WEWsIYtDtzecLvx+ZWl1DC3bhgl3W4kDrxRNev52gmqUixW+M14NfbM8sCNWhGA7SlQTsCx16Mh7xnpTKxkz+zi2R7HNglHNsoxge9H6vguwZLpnf9tym3gEgIuAQ2EsoOYqGBp6ZLpTZq/hZ1Om2z2mmggpn7/0aLqFXq80Wueiyo2EWpfxOz8531A7c/eWeJiTpcWFcNqVJJ+2P9ZTlUAJmrvkVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39850400004)(366004)(346002)(451199015)(66476007)(66446008)(76116006)(66556008)(64756008)(91956017)(31696002)(86362001)(66946007)(4326008)(8676002)(316002)(5660300002)(36756003)(8936002)(41300700001)(2616005)(6506007)(186003)(6512007)(66574015)(71200400001)(26005)(38070700005)(83380400001)(38100700002)(122000001)(6486002)(478600001)(44832011)(110136005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SElKNnpWODhlb2dWT3AydllvMlFDbE5xSEdsRGNzMmk4VDlxSThXRFZFeFJ1?=
 =?utf-8?B?Nm9EZ3FMUEFlOEQ3eHNRL1BoRGVqMllvYjMxNEZzY3dpVlZSd2VqSmFaajNE?=
 =?utf-8?B?dlpPNGFVQ0ZKd2E4WFlnMXltbldqa2F2VmdpcDE4aktpTDBlY0FWZ1dWL3Vq?=
 =?utf-8?B?SlhESFJVK094ZHVnelp4RnRnNWw2Y1NvdEtsbHh1Y3BRYm1QTitUNXl6WGxa?=
 =?utf-8?B?V3lpeVg1RHkrbWQzYkJ5Mk1XRUZFS2JiVDdKbkphYWtZUE5YbkZsbG9vQ29p?=
 =?utf-8?B?VVBTdDVuSmltMVliVVRLNW9VS2loVWJnZ0VrOTU5NWFUTm9mVVlFME10TUJV?=
 =?utf-8?B?Y1IyQTFVeUJPN2RncDY2TDZWbUZTVXloM0Y1cDkzVG54dWlNMlBSZ1V5RThF?=
 =?utf-8?B?MkI1NGM5RmdXT05WWHZwWjY5TUFQL1J0YklVZUp5RWtTMzhvN3grbnlVMGZs?=
 =?utf-8?B?MEJVc0Y4cWtTdkwzaGFMRnIrc01UVXpwVmQ3b3I4QWM1V0JyWXZWY1hlZEVD?=
 =?utf-8?B?a1hINFh6dlRpVjZ5QjBEQUJ3cXdqWFA4OVc0cEZySUdCV2VTMGRTUzN1aGZa?=
 =?utf-8?B?Y1orVWVSR1Jmd2R3MWpyRDhPRVhaRGVzbzc1clczb1huTHlDd2hFRGdQT0hN?=
 =?utf-8?B?SW5UdEEwWGU5ZDYwM3FkVGF4aWVPTVplVTE5UjZmd3QxbWFIZjRPQmkxcktI?=
 =?utf-8?B?alNZNkdmMGpsYzZobkFDbGxNQjFIS1RPNjMvZTVxRjcvSmZXQkREbjQyT29y?=
 =?utf-8?B?K21ucjVtS2YwYjkxYllZWHV3bjQrRHhDR0FwMFRtRC8xRExWNjRpYU9rMVA4?=
 =?utf-8?B?YUlqQXhNVmZIYWh5RGNRQkxKSlM1dTUwakJ3VnJhaVp3UXRIWDNtTUVRNHNW?=
 =?utf-8?B?aEFXelAwNngxQ3JkcXQyektsZkFGdnNaam1vdGdZOFgvQkMyV3RBZ0c3Ymc4?=
 =?utf-8?B?VmNXWGhacWNYeGROTDJaWGNlVlpKTlg0WlZpb3Evcmt0MjdFbUExUC8zVldn?=
 =?utf-8?B?dWg5cGJpTWpNaVNYU3c4cXNBN2NYc0FaNTdJK0J4YkNEcGl6U0JCWWQ5Zys2?=
 =?utf-8?B?azI1YkFPQklkNkxpMVR2YXg5UWpocWNYaVhnTFJWaVI5TVF2QlhpSXZSd3hj?=
 =?utf-8?B?OGh3dDhPZnlBU0xRdHVJdmlCNi9TTDN3NXhJZjRJM2t0NDAwT1MwVHBFYjU5?=
 =?utf-8?B?eDhDODFoZ2lLaGY4UlJ4K1E3WFpKcGtxUWthdUlScDB1YnI0ZXpJMWZyQ2U3?=
 =?utf-8?B?aWloNFgzUUIvK3VJWWRSUVQ4UFM1S0xMZ20wemNnNDJ2MlpHdHFzY1AycEZK?=
 =?utf-8?B?cVp3eGllTG84b3hCVUcxTlpFSHpMOUpPMmtoSW5KWm9LQUJtc3lnMkpvRmtx?=
 =?utf-8?B?Sis1Wmgvd1Q3MTNncDlOU1dMVDNPU0RvMVMyT2gwb0toVExwVXlnSzlZY1hs?=
 =?utf-8?B?Wmc1N3MrSjY4VVdtK09hZ3FuWDRva0lZZHh1RHY5SUpUL1l0REU3cnNxaVNL?=
 =?utf-8?B?MFZzQ1RFOHU4UDluMUgycG52MHZZZEptTk4rMkk1Z0ZKTlJvNFBUSEFMZUlJ?=
 =?utf-8?B?ZmIvdE5lUjJlMnVkODh5aUx1Qk1BaDQzSG9KY3Z5bS9VcXZncHAzcysyUGF1?=
 =?utf-8?B?Q1NaN3JucVR4VHVFY1ZDMk5TWElVNGR4UmhFZjY3YWY2RmUwQW5UdTUrYVBM?=
 =?utf-8?B?VFNvU043Nm9vcGhwbWZCT0hKU1UwTm4yWG1wajJNdEdhODdOS0NxOGJmNjZT?=
 =?utf-8?B?Wmx3ZUtWRXVQWHB0WlJTMGZyalQ3bVMrY1JxNW82aGdNSmcvd013YkdxbmxD?=
 =?utf-8?B?NThabldPSmlnWXNvUm50TGJmd1Q1K2R4M29rd21yeTQzcDVLaXNWVW1hWFZP?=
 =?utf-8?B?bHhwaFJucnRFZFNSeUtDWjhHYm5pQm5OV2Q3anpSelJzUmpBVExyKzRaenRU?=
 =?utf-8?B?VDh1ZFNBOHRxNjV3UHJRdFBQakNUTHhUOFZybEk0aFVEQzVFZ2xjejJRRW9u?=
 =?utf-8?B?eVIwN014QktRQWxEQVZhVnFEdkpFNVR1MkFlL0wwc3NtTWx5NWFDMndpek9Z?=
 =?utf-8?B?UWFVU2lndlpPL1RXb2lMMERGQ2NoT0dyTWJkWTNuNWdRT3lYeEE2OFFoUnQr?=
 =?utf-8?B?VC83aThvbTFLN0dhVmFqVkxNd2pMdGQrUTJ6blAyaUZxVUlZU3JYM2dlc0pZ?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD6CF934711A8045B5A05B5102E2FCC3@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 46175840-13d3-469e-9d21-08dae2626213
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 08:15:40.6159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDfYNih6FNqg4JZiNmQIStz49Un9LaC71P03GzA8JZzo9yvo01cae2wUMNESEmQ44gGyT0coPIKhlajFL4XVf1BRYkuOEW657xmJCi8cjNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3409
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIwLzEyLzIwMjIgw6AgMDc6MzksIFpoZW4gTGVpIGEgw6ljcml0wqA6DQo+IFtUNThd
IEJVRzogc2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20gaW52YWxpZCBjb250ZXh0IGF0IGtl
cm5lbC9rYWxsc3ltcy5jOjMwNQ0KPiBbVDU4XSBpbl9hdG9taWMoKTogMCwgaXJxc19kaXNhYmxl
ZCgpOiAxMjgsIG5vbl9ibG9jazogMCwgcGlkOiA1OCwgbmFtZToga2FsbHN5bXNfdGVzdA0KPiBb
VDU4XSBwcmVlbXB0X2NvdW50OiAwLCBleHBlY3RlZDogMA0KPiBbVDU4XSBSQ1UgbmVzdCBkZXB0
aDogMCwgZXhwZWN0ZWQ6IDANCj4gW1Q1OF0gbm8gbG9ja3MgaGVsZCBieSBrYWxsc3ltc190ZXN0
LzU4Lg0KPiBbVDU4XSBpcnEgZXZlbnQgc3RhbXA6IDE4ODk5OTA0DQo+IFtUNThdIGhhcmRpcnFz
IGxhc3QgZW5hYmxlZCBhdCAoMTg4OTk5MDMpOiBmaW5pc2hfdGFza19zd2l0Y2guaXNyYS4wIChj
b3JlLmM6PykNCj4gW1Q1OF0gaGFyZGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoMTg4OTk5MDQpOiB0
ZXN0X3BlcmZfa2FsbHN5bXNfb25fZWFjaF9zeW1ib2wgKGthbGxzeW1zX3NlbGZ0ZXN0LmM6PykN
Cj4gW1Q1OF0gc29mdGlycXMgbGFzdCBlbmFibGVkIGF0ICgxODg5OTg4Nik6IF9fZG9fc29mdGly
cSAoPz86PykNCj4gW1Q1OF0gc29mdGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoMTg4OTk4NzkpOiBf
X19fZG9fc29mdGlycSAoaXJxLmM6PykNCj4gW1Q1OF0gQ1BVOiAwIFBJRDogNTggQ29tbToga2Fs
bHN5bXNfdGVzdCBUYWludGVkOiBHIFQgIDYuMS4wLW5leHQtMjAyMjEyMTUgIzINCj4gW1Q1OF0g
SGFyZHdhcmUgbmFtZTogbGludXgsZHVtbXktdmlydCAoRFQpDQo+IFtUNThdIENhbGwgdHJhY2U6
DQo+IFtUNThdIGR1bXBfYmFja3RyYWNlICg/Pzo/KQ0KPiBbVDU4XSBzaG93X3N0YWNrICg/Pzo/
KQ0KPiBbVDU4XSBkdW1wX3N0YWNrX2x2bCAoPz86PykNCj4gW1Q1OF0gZHVtcF9zdGFjayAoPz86
PykNCj4gW1Q1OF0gX19taWdodF9yZXNjaGVkICg/Pzo/KQ0KPiBbVDU4XSBrYWxsc3ltc19vbl9l
YWNoX3N5bWJvbCAoPz86PykNCj4gW1Q1OF0gdGVzdF9wZXJmX2thbGxzeW1zX29uX2VhY2hfc3lt
Ym9sIChrYWxsc3ltc19zZWxmdGVzdC5jOj8pDQo+IFtUNThdIHRlc3RfZW50cnkgKGthbGxzeW1z
X3NlbGZ0ZXN0LmM6PykNCj4gW1Q1OF0ga3RocmVhZCAoa3RocmVhZC5jOj8pDQo+IFtUNThdIHJl
dF9mcm9tX2ZvcmsgKD8/Oj8pDQo+IFtUNThdIGthbGxzeW1zX3NlbGZ0ZXN0OiBrYWxsc3ltc19v
bl9lYWNoX3N5bWJvbCgpIHRyYXZlcnNlIGFsbDogNTc0NDMxMDg0MCBucw0KPiBbVDU4XSBrYWxs
c3ltc19zZWxmdGVzdDoga2FsbHN5bXNfb25fZWFjaF9tYXRjaF9zeW1ib2woKSB0cmF2ZXJzZSBh
bGw6IDExNjQ1ODAgbnMNCj4gW1Q1OF0ga2FsbHN5bXNfc2VsZnRlc3Q6IGZpbmlzaA0KPiANCj4g
RnVuY3Rpb25zIGthbGxzeW1zX29uX2VhY2hfc3ltYm9sKCkgYW5kIGthbGxzeW1zX29uX2VhY2hf
bWF0Y2hfc3ltYm9sKCkNCj4gY2FsbCB0aGUgdXNlci1yZWdpc3RlcmVkIGhvb2sgZnVuY3Rpb24g
Zm9yIGVhY2ggc3ltYm9sIHRoYXQgbWVldHMgdGhlDQo+IHJlcXVpcmVtZW50cy4gQmVjYXVzZSBp
dCBpcyB1bmNlcnRhaW4gaG93IGxvbmcgdGhhdCBob29rIGZ1bmN0aW9uIHdpbGwNCj4gZXhlY3V0
ZSwgdGhleSBjYWxsIGNvbmRfcmVzY2hlZCgpIHRvIGF2b2lkIGNvbnN1bWluZyBDUFUgcmVzb3Vy
Y2VzIGZvciBhDQo+IGxvbmcgdGltZS4gSG93ZXZlciwgaXJxcyBuZWVkIHRvIGJlIGRpc2FibGVk
IGR1cmluZyB0aGUgcGVyZm9ybWFuY2UgdGVzdA0KPiB0byBlbnN1cmUgdGhlIGFjY3VyYWN5IG9m
IHRlc3QgZGF0YS4gQmVjYXVzZSB0aGUgcGVyZm9ybWFuY2UgdGVzdCBob29rIGlzDQo+IHZlcnkg
Y2xlYXIsIHZlcnkgc2ltcGxlIGZ1bmN0aW9uLCBsZXQncyBkbyBub3QgY2FsbCBjb25kX3Jlc2No
ZWQoKSB3aGVuDQo+IENPTkZJR19LQUxMU1lNU19TRUxGVEVTVD15Lg0KDQpJIGRvbid0IHRoaW5r
IGl0IGlzIGFwcHJvcHJpYXRlIHRvIGNoYW5nZSB0aGUgYmVoYXZpb3VyIG9mIGEgY29yZSANCmZ1
bmN0aW9uIGJhc2VkIG9uIHdoZXRoZXIgYSBjb21waWxlIHRpbWUgb3B0aW9uIHJlbGF0ZWQgdG8g
dGVzdHMgaXMgDQpzZWxlY3RlZCBvciBub3QsIGJlY2F1c2UgeW91IHdpbGwgY2hhbmdlIHRoZSBi
ZWhhdmlvdXIgZm9yIGFsbCB1c2VycywgDQpub3Qgb25seSBmb3IgdGhlIHRlc3RzLg0KDQpJZiB0
aGUgcHJvYmxlbSBpcyB0aGF0IElSUXMgYXJlIGRpc2FibGVkLCBtYXliZSB0aGUgc29sdXRpb24g
aXMNCg0KCWlmICghaXJxc19kaXNhYmxlZCgpKQ0KCQljb25kX3Jlc2NoZWQoKTsNCg0KT3IgdHJ5
IHRvIGRpc2FibGUgdGhlIGNhbGwgdG8gY29uZF9yZXNjaGVkKCkgaW4gYSB3YXkgb3IgYW5vdGhl
ciBkdXJpbmcgDQp0aGUgcnVuIG9mIHNlbGZ0ZXN0cy4NCg0KPiANCj4gRml4ZXM6IDMwZjNiYjA5
Nzc4ZCAoImthbGxzeW1zOiBBZGQgc2VsZi10ZXN0IGZhY2lsaXR5IikNCj4gUmVwb3J0ZWQtYnk6
IEFuZGVycyBSb3hlbGwgPGFuZGVycy5yb3hlbGxAbGluYXJvLm9yZz4NCj4gU2lnbmVkLW9mZi1i
eTogWmhlbiBMZWkgPHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tPg0KPiAtLS0NCj4gICBrZXJu
ZWwva2FsbHN5bXMuYyB8IDYgKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwva2FsbHN5bXMu
YyBiL2tlcm5lbC9rYWxsc3ltcy5jDQo+IGluZGV4IDgzZjQ5OTE4MmM5YWEzMS4uYTQ5ZTM0NGE2
ODY1MTdiIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwva2FsbHN5bXMuYw0KPiArKysgYi9rZXJuZWwv
a2FsbHN5bXMuYw0KPiBAQCAtMzAyLDcgKzMwMiw4IEBAIGludCBrYWxsc3ltc19vbl9lYWNoX3N5
bWJvbChpbnQgKCpmbikodm9pZCAqLCBjb25zdCBjaGFyICosIHN0cnVjdCBtb2R1bGUgKiwNCj4g
ICAJCXJldCA9IGZuKGRhdGEsIG5hbWVidWYsIE5VTEwsIGthbGxzeW1zX3N5bV9hZGRyZXNzKGkp
KTsNCj4gICAJCWlmIChyZXQgIT0gMCkNCj4gICAJCQlyZXR1cm4gcmV0Ow0KPiAtCQljb25kX3Jl
c2NoZWQoKTsNCj4gKwkJaWYgKCFJU19FTkFCTEVEKENPTkZJR19LQUxMU1lNU19TRUxGVEVTVCkp
DQo+ICsJCQljb25kX3Jlc2NoZWQoKTsNCj4gICAJfQ0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+
IEBAIC0zMTksNyArMzIwLDggQEAgaW50IGthbGxzeW1zX29uX2VhY2hfbWF0Y2hfc3ltYm9sKGlu
dCAoKmZuKSh2b2lkICosIHVuc2lnbmVkIGxvbmcpLA0KPiAgIA0KPiAgIAlmb3IgKGkgPSBzdGFy
dDsgIXJldCAmJiBpIDw9IGVuZDsgaSsrKSB7DQo+ICAgCQlyZXQgPSBmbihkYXRhLCBrYWxsc3lt
c19zeW1fYWRkcmVzcyhnZXRfc3ltYm9sX3NlcShpKSkpOw0KPiAtCQljb25kX3Jlc2NoZWQoKTsN
Cj4gKwkJaWYgKCFJU19FTkFCTEVEKENPTkZJR19LQUxMU1lNU19TRUxGVEVTVCkpDQo+ICsJCQlj
b25kX3Jlc2NoZWQoKTsNCj4gICAJfQ0KPiAgIA0KPiAgIAlyZXR1cm4gcmV0Ow0K
