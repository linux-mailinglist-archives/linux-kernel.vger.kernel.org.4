Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2356E83CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjDSVcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjDSVcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:32:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA89020;
        Wed, 19 Apr 2023 14:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beY+TdvxUGDVe6X4G4PByQgg1CgoK/4y9TYWl8NK6b5CiPJ/2fkCPVC45Wn0QiJQrzzwXZOpbB8QJ3B7LRd5cgX6I8iUOYc8Xln8+rxupPnbp8nDkcBqD5pQbDmlJVqgY0jU17e/ngZrPs+D/IaCYhFEq7vIJqkMjE7rXgYtt1NKJhLVxDNxqFM7eJWl6MGdeFPqUEf+/B4BVcLSqhdiTC6OPiXwMpmgoaTO8bvu3+EzD3CQGuvFfG/Cz3a6QsYkMJaNh0Zii4aNzb56DK3AG5gup4setjp0bdB2GnaS80ZIeDC0JUDvRjMHOay3hAmuBoAhAgNFJwqLdEHIMKtvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF+rDFIo+anCEfl86PzJRzNDuMLgbWlCx9+Pd6RN38k=;
 b=RLrLe81/B2hICWxpqN2xZM+Pm7mSgtLIjoongxUpCojrk0m/Nj+49tS/+Y9BLXtoIiwJkVJDL+ntqcC3ktyxB6aCtdnrOIWh9IKfBCJcKuPNUAQ4HpHHJZl2QCVYqV1U0q9QGin8zegPkcEjOQs+AYgfhoNnMM+n9rbi9z25PCkbZ3BPQviOqw/9uX7Oe27eUnFKZVVnBg8SLrFyAjlb/VrLv+opuCNZ/G2AruLOokC1d5EM2v2eDuByRZAMyX8DqJTucm/LrLEW3avzDLoxo8c7RIdgxCldNb0x0jk3gc5VNf/21NvE8nUP4lDMbbEC0sr0Mmt35jLrCLyA3ajk1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF+rDFIo+anCEfl86PzJRzNDuMLgbWlCx9+Pd6RN38k=;
 b=ufJelxXvruDAgx3YtY0xiWKZ1BnIcKNIHDfyFnCdk3ZOt1wL1HK2YMGS4UhYEz9gz9t/gEptnySLvcQF9pk7+CYmyhwfVIzwXNhC8i9rLNmV2QsyIyck+PnfKMRG8CT7kCqCufgSuUzO+FMIWRCr+ANoF8PY0BBucTfukOJFd+noQ9VxBD0SkVP+ToKAiEPFaoAYBpQMmwV72kAkZF6drskesqqHf15W+/WzAprxHBlbKkB5o5+znTZuqSIbHiDuzHFGLwSANi9lHZZJEvfPYLht9slnfTbq1h2qF3iGi5bgO1NHvj8qiwT3BnZEF2TsSIg2leQSZDrKYZXjR4RjrQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 21:31:42 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%5]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 21:31:41 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Thread-Topic: [RFC v1 0/1] nvme testsuite runtime optimization
Thread-Index: AQHZcpzgQRAsytyJiEWmAIUqEW+1V68yXyyAgAAEQwCAAMQAgA==
Date:   Wed, 19 Apr 2023 21:31:41 +0000
Message-ID: <8b948844-3cdc-d64c-6b58-9ab118cfb98e@nvidia.com>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
 <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
In-Reply-To: <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4956:EE_
x-ms-office365-filtering-correlation-id: 32a96d18-e1a6-40f7-d02d-08db411d7784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pfDhguTfVy8M7zFkMZIPADl5L6nBdEcQP+ul7zNPJcQXNl49ZnewZcA2HsRzHCyDJRXvItbI0aypyAkmbGFPdreKT4w81bNnXdGpqJmikUiwvtxFDNrmZonMIhZjbzMrZp939cmYdo3nAIOchyBSrOaRwaow3BC8RhElVNozjwAvtlyDc654iwcenw8W5+ugLRjcfax1q/WhPte7t7eEM0eFFqFWf+VuTH9M/LsoUQhGh9imGortpzE75Tz4q0mea0XQ+X8hg5Q8xotluYTAdVEsF+gDBLBVg3nL/365ZpsfgmRKRr7+semd+zmZYP3veREQkxFwGrpHlNNUuFL9OBLddhvoqUZeuRW64S8lbmAtETzpKitS3wK2EG/kKk/p+yDWbEmr0wRCrIZ+mfLEPQqAfXLUr5uEUb1/5O+roCjbiQDzmDEtphHB/65XOHjVJSKU7LSAYf3vyttfKBI6k1AI1w6N8Siodrc2WPPpLM9BMBJM/5+Qprp9UzWN6yxFLnf2pq5h5JWwtlC+rKE1p/vo/8LONLiRfCz5hLHjPD6Yx6xiLGEV5CQUPfZP6/k6Qz8YMBFlAj3gyn9D5CNXeoPc2wqOexm5K/sDy+SFSO4CHPGtXWfCQs6pKTWBzOeMF1Rd+0MKCOu8QXuWDr9H2bCIx5hRUSuW4Okn7HEf+3SlHAwmvo+sFZUdCsA1jQWSjI9X0Ya/0s0JsXabsgAAJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(91956017)(66476007)(66446008)(64756008)(4326008)(66556008)(66946007)(478600001)(110136005)(316002)(54906003)(8676002)(8936002)(5660300002)(41300700001)(122000001)(76116006)(38100700002)(186003)(2616005)(83380400001)(6486002)(71200400001)(6512007)(6506007)(31696002)(86362001)(4744005)(38070700005)(36756003)(2906002)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0FNekszaWk3bXMrdm9xQWNTTVBDcURLVGorZEJKRldJRVovd2JUZHFRc0g2?=
 =?utf-8?B?MVJhL292MlFaZmpybFBCNHNZS0k3MDFrRHdDbjFITEV2L3ZYQkViODV2NXZR?=
 =?utf-8?B?UlNzTFdTeFFXVEZ4ODRlVEdpNGFwdVlucklXZzZGdUhBTUR5cmdlOXFjUC9m?=
 =?utf-8?B?WnpCSi9GeDI5aUk4UmV5cVNLT083eGQyVUhJeVZTUjJ2WWFmRGJ3UHlKdEVQ?=
 =?utf-8?B?enpscUtzWkNaMEY0clNRNWU5Z2JGZktPSGMzcVlYZVozTVBRMWtQTXU2ZUhO?=
 =?utf-8?B?QVRIY1B5L05MVjVNaktDZFhJNXlaUGZacjF6a2RrMWpqd3I3WTRuY1cwR29G?=
 =?utf-8?B?aFB2U1phQmRJVnM3bWxuN1pRUzBQcWZlQ2lXTkduTU1HejU3T1Q0WGtSTnZ4?=
 =?utf-8?B?TklHV25VNzNCZFgvc3FYTWV6Yzg1OGwyeFgvRFBTM2t3WmpCdnk0NjR4dFM3?=
 =?utf-8?B?RDVCSnZDdytqcGg5Wi8zOTJ5Q1M3S3hJN2pBL2k5anNDd3ZnZmVrTU15bVp2?=
 =?utf-8?B?ZVpKSG9CVUQ4bjdOcHlJeDJYaUZyL3hpa0k1ZjBMRndIRU9uNFRqZHpPdUlK?=
 =?utf-8?B?czRqM1V0REVaUjBXSkJqK3dxZDI4RTFCUHh2bk9PYnhTT1VuYXpqVU1XTzZt?=
 =?utf-8?B?WTByUWJSakxBbzNnMWN0TGIxTGZsM3g5U2psY0RSYndXL3p3cHMzNDA0aXcz?=
 =?utf-8?B?S0lkYnI1Uy9vWFFFVVMwa3VpZXp3MjdrRUV6YlQzY1VwbTFuenZSQUxMWnV5?=
 =?utf-8?B?YlFLNk12UTBGeVptOWlLaTRJNGo3bnhGejZwOVdacnNkWk5RaHpXbG1BQzZ3?=
 =?utf-8?B?eXFzNG9pTjBETm5RMHBqVmR1VTlYbGV6SEpaTFB4bEtaQXpEMEViVFRpTVpM?=
 =?utf-8?B?ekdSTjAyRUJpOTMxY2R0Um9pSXVpTDA4Q08yWVAyVzloODl5UFNHb3YzWVEr?=
 =?utf-8?B?VmtlY3FlRzR1QUJyTDZOdCtoVFo1WGJ1emNqNTdyS0lZRkRzN0k4cnRKR0I2?=
 =?utf-8?B?TTl2R1dhUjRxUGExUlFGc29HUDE2eE5WM2JzZ0dXWFRtb2tUTWE1NkdmSyt5?=
 =?utf-8?B?OTF0cG9vSVd1UklaYmM2SUlCb3MxakFkeGhVSXRkNjVCMTBNajRqQ1diMzVy?=
 =?utf-8?B?UE1xYldEMmwvOVkwc3hpbjltMjg3elBtWTlVQ1h1R1BCYVF0anpiMTlTTkl3?=
 =?utf-8?B?ZjIweGo4bjlFa0ZaY3dWZkV6djVLZ2MyV3VZTEtGVSthMkM3TDlGWGZ3NmlR?=
 =?utf-8?B?SGd3R0s4QmJWU0Rob0VzaWJObWJtVmRIVDRxeURjS2hnTENEdlBUTVQxeUE0?=
 =?utf-8?B?VnRiNWwxV0haZ25WZHkweER2OEFER0JGT1VOSFFQb1oxV0VKcjZuNXdxa2wz?=
 =?utf-8?B?SkVLR01qNkg1Y3paeDkzTGZ4clBMd0RiV0ViVHU1WnUxZDlXRU11dWY3QTYz?=
 =?utf-8?B?NS80eDk1NHNrYW1sdUZFTUJiTitVTCtKWSsrNzFKWmw4VjdQQjg3NHgrTUQr?=
 =?utf-8?B?T1h4WjZrQVE5b0kxWFAyZ05YbzhEUVhtazFDbmdiR3JwMWNjL29PZW5wbCtM?=
 =?utf-8?B?eXVVRStHOUN3ei92MU0yT2g3a3paM2NOR3VVZkg4SU1sbWw3TVU3VVlKNTJw?=
 =?utf-8?B?Q2pXS1ozc21jRGVPZUx6cDdTczBsTVJvT2g4aGRYV0xtczlPN3hUdFhXQWQ4?=
 =?utf-8?B?aVZZTGNuWWV5WkUxSmoxZVFWdi96emltVm5SQ1JXcHZHbURubWNXdEJEZnB6?=
 =?utf-8?B?N2lQMUJGeCtaSXdYQURmc3I3aFM0d1FITWx1UVZQK0tqWUVBbW8vL3o5OW9G?=
 =?utf-8?B?V2ZQN3ZhTEl3WDFYNm1GbFJpMXppN3BvT2JTOThPanBhdGZ3NHoyTkV1Zkdj?=
 =?utf-8?B?Sk5EblhsTW80RUNOSTB4ZC9VbTlXS05GQ09lQ0pDcXJQOC84eGdDUld1ZjVi?=
 =?utf-8?B?UE85aXVhUmJ4alBTWTVCeFdLdzI3NmdiL0t4RzZNZlg2V2hHeE9YWXdFWkJO?=
 =?utf-8?B?dnMyWlFSWVByd1V6Wk5jUzU2T3hEOXFzL2hGM1JnQzExQmhkcjR2N2xyWDhW?=
 =?utf-8?B?NjZ2bzc3WjdlTmY3dDk4MC95RWNnais4SWNsRmh0aDZZY1JTdGJKdXRZYlZV?=
 =?utf-8?B?NlNkcjVvb29UOTBFUDRUeHI4VzhkRUtMWUMrRHAwZjRZL1NRbEMyeWovODN3?=
 =?utf-8?Q?og1nHyzZLozNd1wtA4FSXUhxIw4v6JLUyZsM04N91Cwr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74F4F52EA5B5E64CB9759883766E3F8C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a96d18-e1a6-40f7-d02d-08db411d7784
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 21:31:41.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KhuzftQoplGVKEn4bzzFJdlfQuqmi67ptMc5DnjVs7W0VPbKd+/dYi/H7FVBSYGJ0hQdByIXXWEoF1sHt11Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4956
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d2UgY2Fubm90IGNoYW5nZSB0aGUgZGF0YXNldCBzaXplIGZvciBzbG93IFZNcywgaW5zdGVhZCBh
ZGQNCj4+IGEgY29tbWFuZCBsaW5lIGFyZ3VtZW50IGFuZCBwYXNzIGl0IHRvIHRlc3RzIGUuZy4N
Cj4+IG52bWVfdmVyaWZpY2F0aW9uX3NpemU9WFhYIHNpbWlsYXIgdG8gbnZtZV90cnR5cGUgYnV0
IGRvbid0IGNoYW5nZQ0KPj4gdGhlIGRlZmF1bHQgdmFsdWVzIHdoaWNoIHdlIGhhdmUgYmVlbiB0
ZXN0aW5nIGZvciB5ZWFycyBub3cNCj4+DQo+PiBUZXN0aW5nIGlzIHN1cHBvc2VkIHRvIGJlIHRp
bWUgY29uc3VtaW5nIGVzcGVjaWFsbHkgdmVyaWZpY2F0aW9uIGpvYnMuLg0KPg0KPiBJIGxpa2Ug
dGhlIGlkZWEsIGJ1dCBJIHRoaW5rIGl0IG1heSBuZWVkIHRvIGJlIHRoZSBvdGhlciB3YXkgYXJv
dW5kLg0KPiBIYXZlIHNob3J0ZXN0IHBvc3NpYmxlIHJ1bnMgYnkgZGVmYXVsdC4NCg0Kbm90IGV2
ZXJ5b25lIGlzIHJ1bm5pbmcgYmxrdGVzdHMgb24gdGhlIHNsb3cgdm1zLCBzbyBJIHRoaW5rIGl0
IHNob3VsZA0KYmUgdGhlIG90aGVyIHdheSBhcm91bmQsIHRoZSBkZWZhdWx0IGludGVncmF0aW9u
IG9mIHRoZXNlIHRlc3RjYXNlcw0KdXNpbmcgMUcgc2l6ZSBpbiB2YXJpb3VzIGRpc3Ryb3MsIGFu
ZCBpdCBpcyBub3QgYSBnb29kIGlkZWEgdG8gY2hhbmdlDQp0aGF0IHNvIGV2ZXJ5b25lIGVsc2Ug
d2hvIGFyZSBub3QgcnVubmluZyBzbG93IHZtcyB3aG8gc2hvdWxkIHVwZGF0ZQ0KdGhlaXIgdGVz
dHNjcmlwdHMgLi4uDQoNCi1jaw0KDQoNCg==
