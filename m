Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03B2685D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjBACci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBACcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:32:35 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4860934316;
        Tue, 31 Jan 2023 18:32:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbmIPAGAE+krvGEXj2AHvH0QxEPVoMj7F+V+fhiYlJt1S08Yd5kSJ26G7Tyxja6yoUYa5f5WUfjyKQN4npaKQEmd7spTQ+r7xRgG+GhP58pGQKvMrbdQma2mNXfD+GUD7iExLxV+gGtG2lBgqf0iNfptw+1nwAVDK7uBgB5szz8Szinu9KzC87Z+ZMQ90hf3EdTdxRoWyhG8awG48c98VbMv0kty1DBJJwkBgt2vzfAJVZIQhD+snzQBphVWir13BDzx1v3lNnhr0EHtrEs9n0sPtNVjOJd/x5joGFGWyho/5doOkXhR6/n6jqTGQvq94J07QMhXjlJW4JVdTuFoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF7GSBCIY1+AC+uUHXphp1MHHiyszdIKxl+c3AiMCEs=;
 b=QQ9BznseTxdOLsKkdWORW16r9FWBTiI7crKWxyUoZW80TmYtEKBt8ROG9jWXP1KwWZmJ/OSlTaLvhClanC2tLcBJO6EQSRifDQZOF5BxOhnz4jjQKpgSJrWyepG1aMb7b20a5mtG/kSIcJGV/ThUc0zlydWGvBFtQcUd2UVJ2Mzot2CXg6PDIoYZYQFgUdOjI5TK0cBqX+sd033/9Vc9DsZuaPo5QGiuVbjWm753VxVZw9nMuMgolA9nEvQRFQP7Tdcyfs/INcBfFmWLeUizeuOgJ6QprepGWwmAeyDXo+paMYznftDyaDXLp0pgtR0iy7BhWUyPUj4y/5cNX7rmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cometbackup.com; dmarc=pass action=none
 header.from=cometbackup.com; dkim=pass header.d=cometbackup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cometbackup.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF7GSBCIY1+AC+uUHXphp1MHHiyszdIKxl+c3AiMCEs=;
 b=PXfALfpPeErjg0kLqxGM0gCqbeN7B04bdMHD7VPt77+R4Dtajk6DittqrPRGlHB3/uw9U4hUg+/H4TGiDeQpmSNHrSVM1OeZqqCuQ7FmaxfBDC6faXZggZLx+hd5Gkli8CRJGcVG5uo8i9pNeU1w2+tP+nh5BgV6xkEJzJNJoQJ9e6lJhY0Q1gdHYSzRMRZ0QPXlv1q46vzAzRjc8Tzko4shnq0/XMSgNpx8xoEFnN6YFPkCOcVU/hHgxEQPJ5T2+f0NmCa6GxOYV1xKjiDWh5WzUNnJj5ReUwd9cGqUZpuzceXAltwJgra7jgqLys3ZMHogd8VNQTSiz0YAuGWZBw==
Received: from SYYP282MB1901.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:d9::10) by
 SYYP282MB0845.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:74::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Wed, 1 Feb 2023 02:32:29 +0000
Received: from SYYP282MB1901.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4935:6a21:2ed0:716a]) by SYYP282MB1901.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4935:6a21:2ed0:716a%4]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 02:32:29 +0000
From:   Mason Giles <mason@cometbackup.com>
To:     Mike Snitzer <snitzer@kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "drwilliams@datto.com" <drwilliams@datto.com>
Subject: RE: [PATCH v2 00/21] blksnap - block devices snapshots module
Thread-Topic: [PATCH v2 00/21] blksnap - block devices snapshots module
Thread-Index: AQG4JUIXsWG37qEUjV9h3UlvtAsaCgHoG6k8Ads7F64B27Knd67OgVsA
Date:   Wed, 1 Feb 2023 02:32:29 +0000
Message-ID: <SYYP282MB1901AE0C3A06480BF8FA8A38B5D19@SYYP282MB1901.AUSP282.PROD.OUTLOOK.COM>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <Y8cNVv4O+vjL+aAy@redhat.com>
 <15ffd4bb-cb87-4bc9-53fc-4e0b941db0b7@veeam.com>
 <Y9l+WIDSrVhRhPME@redhat.com>
In-Reply-To: <Y9l+WIDSrVhRhPME@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cometbackup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYYP282MB1901:EE_|SYYP282MB0845:EE_
x-ms-office365-filtering-correlation-id: 35af37f5-ca8d-48d9-a67f-08db03fc905f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K8Ekbv/F839LGT7Lbns7/QQGB/6yTUP0yatoh/TYJ0MNrovOnnobNFTSUZtrVAEE1k5A8J2HlxTOyu5kUhpLn5pFIyAgn1Pd0TMAfrufS35AzJ6dK+iSK7izUMPOW5SVeJ7BU2jHCuiKzJND+LB+qsxhi18Q0FmCDAYtqCvEOTHpdOgeRHyS8IsnoGjrHiJ3U02EHpPq8zZjwyHmqEMqz2+Md7SiUwsZidi38WtBU9Y8tHSHT516bNOonndLhLysW/BOMcKEmjkK050J7JhNWB5U1HynG6eoZOhNnwkUpO7mKv6zNc6l4LWK8LJXs1WLNS+d1Im/j93RAFZgGjJSEJ8shvdaubWSakMCWUH6aSc07btXKTuOMkkO/clCrDkw+VPNN5Okz18QOmQVqvpE2ywLTf9HUpde0OVMeuW9QJhFx6Pu3yCth02E0dOi19SwF6+AcY4m+/sP4fyydtgLmWxsBbZzVUBwyW9ODXNUEA1PSn9zmtS4j+anzAPaA3aHsnKQATdtxRyUQgco+ysZk/WO8iUHyaDVzrmuusyHdVJ/M44+7wulWdlcW772iGVmyuv1dM6PioPM50I19f6jS9k4MRyNk6P0e3koefeNCYKWodLYyHw0d3fRr1qZqxqoHjwC+ufjz/G0LnLj+5J0qGZTmDYjrzuEF+1DQkiaY68hldEOWVjjsEKiPNcEmMeAwWi2wMAYjWYHYaxkvdayHuQmwyUhyZM+JYMKj32iYHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB1901.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(396003)(39830400003)(136003)(346002)(42606007)(366004)(376002)(451199018)(52536014)(5660300002)(8936002)(38100700002)(122000001)(38070700005)(55016003)(33656002)(86362001)(2906002)(41300700001)(110136005)(54906003)(966005)(7696005)(186003)(478600001)(26005)(9686003)(71200400001)(316002)(66446008)(64756008)(8676002)(66556008)(66946007)(66476007)(4326008)(76116006)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHp4OFp0VThHajQrRUUrMGVuamtybG45VkQ5V0VmNGkvWUVzUk9pdTJLeUN1?=
 =?utf-8?B?dTc0NzZZdFV0R04wc1ZGVEdCaEtpYXZDVHpCbmhVanpRYmNwSzFwMy9aam81?=
 =?utf-8?B?dk9EWnRyeFpvZXRjQzhrR3FhQzhqZjFNR3BnZVk1a3Zrd2tpMmo5S1hmZkxS?=
 =?utf-8?B?MjRzYnRPZ1VVbXFnYUhtcHhQM1ZzbDZXQWxPM2M2cWRpMStCY08zRWdNbCtz?=
 =?utf-8?B?bHJ3Y0tnYjFWU0N2eFk5Q2Ivb2NpL2hBRVFySEY1eS9iRXVzczhIUEtKMlZY?=
 =?utf-8?B?NHl3SzMwcC9YakFlemRLY2JVeEVrV1dCWWdETlpjMEJmTkdORFVjblR1S3o3?=
 =?utf-8?B?RnF5TExrcm1WV2h1U05jalU4YnB2dGtpckNUTDdoU2RQcWNIbXRpSXJrYzFP?=
 =?utf-8?B?STZDcTJudFF2c3orWTliREI3S3VUQm9ueGFIQktEUkU4YUt5UmIvT1gvaER2?=
 =?utf-8?B?REI0NnV1NXNraEFQUHVvOHBkU2tJR1RBZVFKVEEyOUJIdDNBM1lIdVl4NElR?=
 =?utf-8?B?U0duQWhDODhvV3EyTDB2bm13WDBTYjRwaDJ0UjQrZDBXRFE0SHkwenBhMUYx?=
 =?utf-8?B?V3FCdkoraERFS05vRE9BczNabU9xVVY0Zi9peG9YSmZuY0FYcFROSS9wRVdO?=
 =?utf-8?B?TmtHT1RhcjlXN3g3eDRDOENnRk9ETWRiZTA1SWYvRU54WmhQVDFwZmphVEcz?=
 =?utf-8?B?MnMzZzVTTkw5ZzN3blJTRExxa0U5L3FuU0h4UENsUmhkMlFPU0FxSVBsd1Za?=
 =?utf-8?B?c0pCTHlFTWRPWkVHRXpyalFyYzVoUjVGY01tdllHeGtmVU9QMEpYczUvWkZU?=
 =?utf-8?B?UitYUmtHOEdHdG9qL2NwT3UzMWNXenhKT0lCMXdJU0JTR0JVOHN2a0xWazVZ?=
 =?utf-8?B?cjdOdzVkdnlOYWJoT2NySEtBMXhEM3YxR1YxVVFpcm9FaUFvU3RHb2o2SFYr?=
 =?utf-8?B?UnFnajR2K0hza3M5SUJtYmlYbjFmcVRQL1FrU2QxTFYvREVyWXJoUjcvamlq?=
 =?utf-8?B?cXh5YUhRcE9nWHQ1Mmlnd1poaHJNUEpHOW9PTHBPMkVJU2pxNXF1WXhUVjkw?=
 =?utf-8?B?SFlXL0krMVZCeVkvbWV6OUMwWU9wRW1LT0s2UEdrd0wwYXRvOFlTWXBHcDdu?=
 =?utf-8?B?bG9sTUx6Um5yNEtwZGVrQ1l5dEMvbFF1YldPVE5udHVYV2hDRXc1Q3NrSlYy?=
 =?utf-8?B?Zzc1V0J4djlOL2xTSzZVSG9Nc2RmR2tWc3pXcmh1dzEwYVVWWnM5TmJFWVpX?=
 =?utf-8?B?ZXhYVzkzSFpQemREdUhLM1ZJZUxTZzhXSlFKT00vend6dnN4YmFEYmM0Z1pt?=
 =?utf-8?B?aGNJUzVWMmdoMjJjSUZHNzdBdTlrS3cycnorTFVmUlVFcGx1RFFYQzdncTV5?=
 =?utf-8?B?Rm9HUDdNRm5KbUFJMTRnZXo4eG94azJ1MGdrRlNYYlZqVzhIZGgyeEVRWkZ4?=
 =?utf-8?B?bXVUNlNBZ0h6K1VSSmxnY1FSb3RzaEtNUzBmeHQyUElsUHlWWjlrSStGL01Q?=
 =?utf-8?B?Q1NIN000MFY0V1VWck9KN1h1ekt1aFNKTXJpTlY1dGlhV0UxcmtHV2NsR0Fs?=
 =?utf-8?B?L3AvQ3oyVG42WUdSck9aM0VpZDkrWmVBN0xBdWtieldESmtQTkhiTGJQRHp5?=
 =?utf-8?B?a2dBekVtUlpWNjlhdkFiTjVlOFVjTVliYnRmcVpqR1hkc0hsOWdTVVM4ZEVp?=
 =?utf-8?B?Z0pGRHhEM0YzVE0vYmx0Q3NmZnNhY2ViUjdNUTRzeXF0K0pORVBUbTlxRzR1?=
 =?utf-8?B?aXl1ZzA5ZUttZFRvSnV3TU1vK3NORmtsK0xSZkZQVkRoVnpCcFNKUmgxZnFZ?=
 =?utf-8?B?bko2MHpFRDRidEZMdjJZY2k1Y1dUaWNUdUZrdllPYmY5aG1iLzYzbTRzOUQv?=
 =?utf-8?B?eXlLK25iV1R5YUFQOFBKelhJR0d4ZzdQZHY3Y3pBRnlBZUo4emtOUEYrb1JO?=
 =?utf-8?B?TU55eno5bjJYNzdhL1M3cW9lSTFENVBacFFxYWZNTEZIbVBreGZ2T1NsUlhi?=
 =?utf-8?B?UHRSOGxLenFXWFFqaXhycDlhRkVNazFqa2JvbkFWd1VPQUpxUnNIM3ZTTDdy?=
 =?utf-8?B?KzlNWXZYd3lqN1RKb0ZsdDNjM3d4SHFrQ3dzeDNXcnZ2QkIyV1ZYeGFzTFRW?=
 =?utf-8?Q?NuaTxvVBAuy06qse3BuWWD+hV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cometbackup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB1901.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 35af37f5-ca8d-48d9-a67f-08db03fc905f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 02:32:29.1418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9096f9ac-9e1d-4258-b91f-cf57c563c0b1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LU2TFdmSPNkO4jJtXn2pBQ410Cw0lSblgSkfCnHRPXkESOC290lQTSBqUqfcl80LSazyjr99e8r6mx/Uy0HYUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB0845
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlrZSBhbmQgU2VyZ2VpLA0KDQo+ID4gSXTigJlzIG5vdCBhYm91dCBWZWVhbSBhdCBhbGwu
IEkgYW0gc3VyZSB0aGF0IG15IHdvcmsgd2lsbCBoZWxwIG1hbnkgDQo+ID4gYmFja3VwIHZlbmRv
cnMgYW5kIGF2ZXJhZ2UgdXNlcnMgdG8gYnVpbGQgbW9yZSByb2J1c3QgYW5kIGVmZmljaWVudCBi
YWNrdXAgdG9vbHMuDQo+ID4gU28sIHRoZSBhcmd1bWVudCB0aGF0IEkgZG8gaXQganVzdCBiZWNh
dXNlIFZlZWFtIG5lZWRzIGl0IGRvZXMgbm90IA0KPiA+IGhvbGQgYW55IHdhdGVyIOKAkyBJIGtu
b3cgdGhhdCBtYW55IHBlb3BsZSBuZWVkIHRoZSBmZWF0dXJlLCBub3QganVzdCBWZWVhbS4NCj4g
DQo+IE5vIG90aGVyIHNuYXBzaG90IGNvbnN1bWVycyBoYXZlIHNob3duIHRoZW1zZWx2ZXMuIFVz
aW5nIHRoZW0gYXMgc29tZSBzb3J0IG9mIGltcGxpZWQgY29uc2Vuc3VzIG9uIHdoYXQgaXMgbmVl
ZGVkIGZvciBnZW5lcmljIExpbnV4IHNuYXBzaG90IGlzIGEgYml0IG9mIGEgbGVhcC4gQWxsIHlv
dSByZWFsbHkgaGF2ZSBhcmUgeW91ciByZXF1aXJlbWVudHMuIERvZXNuJ3QgcmVhbGx5IGhlbHAg
dG8gc2F5IHlvdSByZXByZXNlbnQgdGhlIGludGVyZXN0cyBvZiBhbGwgaW50ZXJlc3RlZCBwYXJ0
aWVzIGlmIHRoZXkgcmVtYWluIG5hbWVsZXNzIGFuZCBpbiB0aGUgYmFja2dyb3VuZC4NCg0KSSdt
IHNwZWFraW5nIG9uIGJlaGFsZiBvZiBDb21ldCBCYWNrdXAsIGFub3RoZXIgY29tbWVyY2lhbCB2
ZW5kb3IgaW4gdGhpcyBzcGFjZS4gSSBqdXN0IHdhbnQgdG8gY2hpbWUgaW4gYW5kIHNheSB3ZSdy
ZSB2ZXJ5IGNsb3NlbHkgZm9sbG93aW5nIHRoZSBkZXZlbG9wbWVudCBvZiB0aGlzIHBhdGNoIHNl
dC4gDQoNCk91ciBlbmQtdXNlciBjdXN0b21lcnMgaGF2ZSBhbiAiYXJiaXRyYXJ5IiBMaW51eCBz
eXN0ZW0gd2hlcmUgd2UgZG9uJ3QgY29udHJvbCB0aGUgZmlsZXN5c3RlbSBvciBibG9jayBkZXZp
Y2UgbGF5ZXIuIEhhdmluZyBhIHBvaW50LWluLXRpbWUgY29uc2lzdGVudCBzbmFwc2hvdCBpcyBl
c3NlbnRpYWwgZm9yIGEgaGlnaCBxdWFsaXR5IGJhY2t1cCwgYW5kIGl0J3MgdGFibGUtc3Rha2Vz
IG9uIFdpbmRvd3Mgd2l0aCB0aGUgVlNTIHN1YnN5c3RlbS4gQnV0IGEgdmVyeSBsYXJnZSBudW1i
ZXIgb2YgaW5zdGFsbHMgaW4tdGhlLXdpbGQgYXJlIHVzaW5nIHBsYWluIGV4dDQgd2l0aG91dCBs
dm0sIGFuZCB3ZSBoYXZlIG5vIHJlbWFpbmluZyB2aWFibGUgbWVjaGFuaXNtcyBmb3IgZWl0aGVy
IGZpbGVzeXN0ZW0tbGV2ZWwgb3IgYmxvY2sgZGV2aWNlLWxldmVsIGJhY2t1cC4NCg0KRm9yIHRo
aXMgdXNlIGNhc2UsIHRoZSBzbmFwc2hvdHMgYXJlIGdlbmVyYWxseSBzaG9ydC1saXZlZC4gVGhl
IHVuZGVybHlpbmcgbWVjaGFuaXNtIGRvZXNuJ3QgYWZmZWN0IHVzIG11Y2ggLSB3aGV0aGVyIGl0
J3MgbGl2ZS1zd2FwcGluZyBETSBkZXZpY2VzLCBvciBleHBsaWNpdGx5IHRyYWNraW5nIGJpbydz
IChvciBpZiBzb21laG93IGV4dDQgYW5kIHhmcyBtYWdpY2FsbHkgZ290IGZzLWxldmVsIHNuYXBz
aG90dGluZyBzdXBwb3J0KS4gQnV0IG1vc3Qgb2YgYWxsLCB3ZSdkIGxvdmUgdG8gc2VlIHNvbWV0
aGluZyB1cHN0cmVhbS4NCg0KSSdkIGFsc28gcG9pbnQgeW91IHRvd2FyZHMgRGF0dG8ncyBvdXQt
b2YtdHJlZSAnZGF0dG9iZCcgYmxvY2sgZGV2aWNlIGRyaXZlciB3aXRoIHRoZSBzYW1lIG9iamVj
dGl2ZTogaHR0cHM6Ly9naXRodWIuY29tL2RhdHRvL2RhdHRvYmQgKExHUEx2MispLiBJdCB3YXMg
d29ya2luZyBpbiBhIHNsaWdodGx5IGRpZmZlcmVudCB3YXkgYnkgdXNpbmcgZnRyYWNlIHRvIGhv
b2sgc3VibWl0X2Jpb19ub2FjY3QuIA0KDQpSZWdhcmRzLA0KTWFzb24gR2lsZXMNCg0K
