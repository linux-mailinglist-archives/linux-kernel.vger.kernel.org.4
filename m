Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736856DD2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjDKGh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjDKGh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:37:26 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2087.outbound.protection.outlook.com [40.107.215.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921F619B9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1PW/oIp9nCoApXjThOnfUl2ut1ZHREZxLrAfQC4uNft94jYh/19MjObDNEmPVzFjmU8Ddd17PwDt7LloyELEKn7fJf4cYcBdk2GUuA4NZ/BZnmD1+tVku9g0/8czUgXoZirMRJHnYRRsomFgbw87cqBpE9C0R8P/wZAog0VxkNVr8kTX/fDDL+gjOk6DVPAvsX4dIArADYH5L9hJ2W8TcKxI5gsrQZpOpflZdiAi8O9A2qArjfF/WNvVd0Pgq+ARYLT1IpsvMCTtmmFPLn6QwnYe8P26T+w+Hghd5DQrTVas5nlPUG5L70acyiVtsF58SsAmL4qxi1z5Ggu60Ws1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1gzvK/8zO1yexd3Ja/0mu/BcQzlQscxvGhvRp8TrUk=;
 b=dFHN/aaCFy/tDltaDzkwpCavL1pZMaPhyRX3jSneW0sqHsJIFrRpto4E9WDjFeYM1+pdJvhv5t7a8dGaFqfmiq3/VMrmsuE5d3EMm2Pf5UG79KTvclybY698LyGNkVctl9bQPmsv6KDKcGzjnY5a5yYObFf/Y5uf2ZLQR83LtIL3PeLYKp4nMyKDISQzHMxzs1SQUDbaefGQoW8acQlZsQi4R9+5aDJG6b8OiS4YwlM7CG0no0x8CHzpVl5XkSgmm8vNdjDs9X4kKvu0xuzTjXt3nGMFo6FTshhZ6qH/Spc+jzM0R4GJ/7og6q80rnA4vb5qx4Whof6uxylAE/IUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1gzvK/8zO1yexd3Ja/0mu/BcQzlQscxvGhvRp8TrUk=;
 b=kiK82uIk30KLrYDV+c7yKBqj44jtiwjr9dVLSZygP4pWiC5L7h1q1YZ3fMzNHp11tvxtgtZeMPIWbQzLZ4uJHCOoU8qOEr4eyzH6VMarM9sO9ERMS+pQ8yKhFDM6pF0GR56ip8H04KFZVt811BBKt5N/drPHp2Ece4He570Fyec7vTXmuuCWgUh+5aX6KrKsqUw0oW3Kc5YU6v4ce5RhyZZLnBlXjoS4XvDIYR0s5K/YRbu2RtBe4zc/0dc32IhbaIS9YvPf5RsuzbEqadUqDZfASDARiNc35vXpBQ2/rcdDb/OTkr/aHLic4ijCWfPml/+HLmC6elk1jqr5ZtIdSA==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by PSAPR06MB4341.apcprd06.prod.outlook.com (2603:1096:301:8a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 06:37:21 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 06:37:21 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Topic: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Index: AQHZbBZh3jvrK38aOUOklBMw4wCkQq8lZioAgABBpIA=
Date:   Tue, 11 Apr 2023 06:37:21 +0000
Message-ID: <TY2PR06MB3424EB45AB598371D41CC669859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <1681180912.9817035-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1681180912.9817035-2-xuanzhuo@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|PSAPR06MB4341:EE_
x-ms-office365-filtering-correlation-id: f9c2be98-1bcd-43ab-801c-08db3a573433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FeQxg0NjNGaHsZmnyrE86ieE+tFC3+jrUq1dp8K/okFC+KMXaI3T20OtfrywMcCe2b/LpIHMwEXsDYcRY9mPZ9c5IMZWWOpspgm9aLkamIcRCAyGgtjanBFUKcglzm2YspT7Ma0RWI4f1R9S8JZo0Vy2haDD07g2vwf17aA0CR1jVeNFPqR9Bwkdwg223DdLHVaYjXYovyB1zTzkTh3/emrsUxK81QS5A3nDixDKmaiGNZa2MIOjWItdIacxOKKAJ+QL18UwKAhKWUM0kA806EX8FolMSTo7JC+tYHsOtd972LgTJTsl8CxRqBLvRhf3Lk6fhIVqfxT+n4i0xIrwkI8g9KA5+OXM054nn8p9G7V6XGTqrmozbtcHW1MeqyAG+hCCZFRKF611BnNuND2Ce0zt+NBDO76MS6RV7fz/aXRJ5CWbjliBPf4BOVLBOFDfZ91Ata8dfxMzEIK4Q0qnWp/XFDF5564dTP6/8gZTkwXgdDQMO8+NH6GtOkrgcuxVCN6U2meqbiOfQr8mkuncE+Rn5GgIwULXYcmpkwxeRBqI67llZCPY9YR9FCztO88tcI0cY1CriFgMEhBbnsb1ce6K4KiEOQeNzGEUAwPHGhoTWXfxYBfPjY9D6gWuou8q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39830400003)(396003)(451199021)(478600001)(7696005)(71200400001)(6506007)(316002)(54906003)(53546011)(26005)(9686003)(186003)(2906002)(44832011)(66556008)(76116006)(66946007)(4326008)(52536014)(64756008)(41300700001)(5660300002)(66446008)(66476007)(8676002)(8936002)(6916009)(38070700005)(38100700002)(122000001)(55016003)(33656002)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmNuYVMzWXpacFp3eUR1QXRtQkFuZ0VLbzVCMC9RbnJSOEIzUXlFNUYwRklG?=
 =?utf-8?B?SmZpTGZpVnJxZ0UzSTBHdllsZXBGdUZsRVdnOW9CRVd4eWJjOWFZcmRmOEM3?=
 =?utf-8?B?Mzh5OHo4a3RBUHFOcExGbXh2TmwwVk9vUnlud0FIMTBQZWw4WCttRHMxNzBT?=
 =?utf-8?B?WURsTy9wc1F5MUhDSkhRVDZGRlVFYnVZTUtWTURlZkd3aG96Y05aVXFxNDB0?=
 =?utf-8?B?S1pYbjBwSzltYUVOQ2JoRGpSNXVxMHpOZ2wrelUrT3hoTEppTWx2WURkT0Jp?=
 =?utf-8?B?aDZmWmxla0hhb3psVTA4MHorY3VBRklORlU2cmtIWVQ0ZjNkZmVwRDQ4eEZ3?=
 =?utf-8?B?RDNHc1lBcE03RkhDd09vbkZMQjIyZjVGYWVWQmQ3THdiNmlGR0hTV3hVaUl2?=
 =?utf-8?B?cmFQYVh4blpKVFpWVU5WYmlWa0xVbkNVb05rV1NRMzl3dW5TR0xLVVNqVjFp?=
 =?utf-8?B?cU1pZG5KQ3RlRGIweE9kR25OTGhrbFF2bnppaG5aMnYxUVNXbnBSbThRb05H?=
 =?utf-8?B?bU9SZEJRRHNTTmpRQVVDNlB5NU13YWdaNit1dWU2ZWdVME05NTk3OFBtajdq?=
 =?utf-8?B?cnFqZGN3V0UxYUxHdkdEZTYyVUw4NUFFRlBOeTlUTjRnaUozNlNFVFdvUlBT?=
 =?utf-8?B?R2ZMNzVrWEdIeWFNdk5xand4K3hKek05eEsvSHowYnFPakc1UXpSTG13RDN6?=
 =?utf-8?B?MXZqTzNPaC9ZUUhLRFpRU2ljUHpycFZVZFJ3TTQwR2JQd0dRWXdQWEVRcnFL?=
 =?utf-8?B?ZkhCZE9lZEZUZFphMnRlMmYwVDM2MWNDVUp5WlZzdTNjSW42K2xYVkNnL09u?=
 =?utf-8?B?UUFXTlB2UEwxTGljcDRJSGhWSVVPdTRKVGRlUFVnKzBscjRkdHowZG5BNFJG?=
 =?utf-8?B?clpuQXBEWFlmQm5XdnhCV2piVFNpVXB3YmJLY3YxdHk4RkZZMWx5TTN2dWwx?=
 =?utf-8?B?YzF6V3l6UWJVTjRmektDTmpBVCtEWGlWNExmcVJld0NHZlY5L0VQbUVxN3FQ?=
 =?utf-8?B?aTQ4eDVZRnBVN2FLNXk0amFUdEtyQmNzSzNxME1TNTVocGI3bTI5MEJZbzZn?=
 =?utf-8?B?ZVBMSkxZYzhBbW52eWNZYk44MnhQSytmWE1BSWRDZW1rZXJ5NkNhWExWM05x?=
 =?utf-8?B?aEo3SFRvd1EwUXpBOURJQVFnam1SaFlHb0NZQWwwTGMrYmFkK0FXWHlSK3JO?=
 =?utf-8?B?WGh5RytIYXdZR0UyU25iRTRMeFI2MUxYSVd3SXBNZXkxVTVLYkhuRGNIOEYz?=
 =?utf-8?B?MXdTaUIzeTJZeUtPQXFZRmZmYmNrZkxscHZWb3o3YmNmczdNUnVsRFNabk14?=
 =?utf-8?B?dVlQVGRzNjU5NGVmeE5OSzBMbDhxMTRTanRyK0o1ako5dThBamFlVzAxejl4?=
 =?utf-8?B?ZzlST2gzWG1HQ051S0U0eWdpMVRkT3RhSWF5SjRTSXM0cVdreG43UWlmUmg1?=
 =?utf-8?B?WHJxeFZ2MWdyZkpCN0IrODlUSVZTem9MekhtZTY5NzA1clYrbTQxT0xLMG40?=
 =?utf-8?B?NTdXWHFuWjJWSFFUdE1BamNOa1lsZzVYVFBRVVZEb2lwQlRTTGc2UStQZTFS?=
 =?utf-8?B?dzVzNG1qSlg0eEg0cTNlRVB3d0hvUGQ4RmswK3VBTzFLK215T2FVd1JCTjBZ?=
 =?utf-8?B?MlJ1cHFhU00xRmVZYnF5UzdRSTNOTnMvdXBtdjVUd0VFVTRSVHFTdnR4cDBh?=
 =?utf-8?B?M0c1WDhRWVVBTnFFS3VONGh2Vm5sLzhKdmNEblVhbU5xcnRITi9ReDRCOEhF?=
 =?utf-8?B?OU1ENUcycnFqZy9zZU9CWThqTTE3YWxlN3RheENxOWhKM3RwV0pHamZ1MkJn?=
 =?utf-8?B?S3dCSUVuTkJSQ1picS9ja0FTeitkaGQyeHk5aTZCL0haV01ZNFBzS1Y2dkhn?=
 =?utf-8?B?bHBJQlBpZXAxS0I0cTdTRjFyLzh2dFEyc3hWaDhQMEM1OU9kY1RTNEpwWlZn?=
 =?utf-8?B?S0pBdGlPUS81VDE4a3E1VnRxYUZHSUZQd0QyN21KOGo0UmNEOUFWMEU1cTM1?=
 =?utf-8?B?aVZ1RHBTU0ozRG90V0wxQ1lHZG5FRWgwcXZmS0lnTitURTFXNkRQY25DcEpG?=
 =?utf-8?B?VVJKQzdGcWZBbkszeWJremlQNVoxTHQrQmRxSjdJWHVvd0E4TGNPalRwc3d4?=
 =?utf-8?Q?9zYKgtvYmMwr2Ghw6RKOXrb2L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c2be98-1bcd-43ab-801c-08db3a573433
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 06:37:21.5062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9QnBNvY3z42f3hgtLJ1oATQOLs5u/iO1J1rubuMfjXA0sEXEZNy6Z1Qrb8Sf9tjRi6VM0PZk3OrTIOaZOQzLziCSa/mbW9wPtJEfUO187Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4341
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWHVhbiBaaHVvIDx4dWFu
emh1b0BsaW51eC5hbGliYWJhLmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTEsIDIwMjMg
MTA6NDIgQU0NCj4gVG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPg0K
PiBDYzogdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWlj
cm8uY29tPjsgbXN0QHJlZGhhdC5jb207DQo+IGphc293YW5nQHJlZGhhdC5jb20NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gdmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRldmljZSB0byBiZSBy
ZXNldA0KPiANCj4gT24gVHVlLCAxMSBBcHIgMjAyMyAwOTozODozMiArMDgwMCwgQW5ndXMgQ2hl
bg0KPiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+IHdyb3RlOg0KPiA+IFdlIHJlYWQgdGhl
IHN0YXR1cyBvZiBkZXZpY2UgYWZ0ZXIgcmVzZXQsDQo+ID4gSXQgaXMgbm90IGd1YXJhbnRlZWQg
dGhhdCB0aGUgZGV2aWNlIGJlIHJlc2V0ZWQgc3VjY2Vzc2Z1bGx5Lg0KPiA+IFdlIGNhbiB1c2Ug
YSB3aGlsZSBsb29wIHRvIG1ha2Ugc3VyZSB0aGF0LGxpa2UgdGhlIG1vZGVybiBkZXZpY2UgZGlk
Lg0KPiA+IFRoZSBzcGVjIGlzIG5vdCByZXF1ZXN0IGl0ICxidXQgaXQgd29yay4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPg0K
PiANCj4gTEdUTQ0KDQpUaGFuayB5b3UgZm9yIHlvdSByZXBseS4NCj4gDQo+IFJldmlld2VkLWJ5
OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPg0KPiANCj4gDQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgfCA0ICsrKy0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jDQo+ID4gaW5kZXggMjI1N2YxYjNkOGFlLi5mMmQy
NDE1NjNlNGYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdh
Y3kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMNCj4gPiBA
QCAtMTQsNiArMTQsNyBAQA0KPiA+ICAgKiAgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT4NCj4gPiAgICovDQo+ID4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4g
ICNpbmNsdWRlICJsaW51eC92aXJ0aW9fcGNpX2xlZ2FjeS5oIg0KPiA+ICAjaW5jbHVkZSAidmly
dGlvX3BjaV9jb21tb24uaCINCj4gPg0KPiA+IEBAIC05Nyw3ICs5OCw4IEBAIHN0YXRpYyB2b2lk
IHZwX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQ0KPiA+ICAJdnBfbGVnYWN5X3Nl
dF9zdGF0dXMoJnZwX2Rldi0+bGRldiwgMCk7DQo+ID4gIAkvKiBGbHVzaCBvdXQgdGhlIHN0YXR1
cyB3cml0ZSwgYW5kIGZsdXNoIGluIGRldmljZSB3cml0ZXMsDQo+ID4gIAkgKiBpbmNsdWRpbmcg
TVNpLVggaW50ZXJydXB0cywgaWYgYW55LiAqLw0KPiA+IC0JdnBfbGVnYWN5X2dldF9zdGF0dXMo
JnZwX2Rldi0+bGRldik7DQo+ID4gKwl3aGlsZSAodnBfbGVnYWN5X2dldF9zdGF0dXMoJnZwX2Rl
di0+bGRldikpDQo+ID4gKwkJbXNsZWVwKDEpOw0KPiA+ICAJLyogRmx1c2ggcGVuZGluZyBWUS9j
b25maWd1cmF0aW9uIGNhbGxiYWNrcy4gKi8NCj4gPiAgCXZwX3N5bmNocm9uaXplX3ZlY3RvcnMo
dmRldik7DQo+ID4gIH0NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
