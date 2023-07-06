Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D03C7495EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjGFGvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGFGvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:51:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ED81B6;
        Wed,  5 Jul 2023 23:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSlD1ljfz9JR2kdPhPu9DHwuJAs/7VWeGAyg3mf+zH5Y7IE9zSRLxeoWpD/NrUGtBjUJmk2b9OLutn6m9CMl5Do/2b66mPJQ5apSMOu/TKSKoP26vwYRm7LyfjKFcjEn+ZsYzZb6fX9KuhT6e3m40B8+vcy0nYEbUKafPoogSdcvA7AvKEN/rhx7Cbkt9uyLkMlkaQMyru9En6aZpmCg4ls529DyhtdX/sPg1K44YDZzK5dFqjWRKJA06Jsl0Dm1FC4zgI/Odq11RBAOflfsYVrIjvpIo4NSRcrQKuAJv3vs54neyUtkacoVBOojD1HbHQPmPpU3GOTjGHKBlcT61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc3OJfaouTKtCD78UMX8pfvyi+aRicbu/LvaiaGGohU=;
 b=kM+tqYB2/mLpDRUIDrBdn4Ntn+CN2YT4u6FBydD6WOYY/t6QkbCjEpMUOnhTZwbZLktXiPQjdGViLuE6ShhKj/ZON96s48nvIU0x6cLGqcTl82fezy8FIz3ItO2mllYhP2QLPbiDc0XfyaraUdgqIwA5ZazG8hGvR9QELxpDqVqG3f+Ahdk+EkOMjHJ2w4ULxO1xFdzh0D2Boi6G0xZ8y8tt44sRcJJJAWGD+rXBYgjI7NPT4Zy3nzEZ6h5LA+8HbfvoExfumsXxFAwigsYqOn/e/7RsiRrLJ8EdERojy7RRZ0iY9V2f9eweUkk6NZbtreJvAXsNZcSXF3PdxM8OiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc3OJfaouTKtCD78UMX8pfvyi+aRicbu/LvaiaGGohU=;
 b=W+liPoyS3P47xteZayaPJ5tVXxJMeKueNKhmZ6wphhlJs3Kc/cWhsdXCbseWHcniElXmbCq81ryxhtYR9mbR0ZGVzoPL5hSYJYuLJw4jwuE1ggaGSfkva41JuivrF1gO51mzREqBML+Q6rDhsNuUlUMsVRxht1GF030gBGtjP/0CHS5L2PuXNHbuVBR72mhVxKIMZM87G3KhfHWBkoBOwIphkLcHFtwWKJWnWcuSQpLyg+ShbAJBl8QgpHLganywiYK917xJma0PJNfCskVFQ6k/3iXLNwwFS28QWOCQTa0MwWvOEmCBPcQBE1Cze0m5jwJuUdJQZKZaLAD/C4y+gQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 06:51:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 06:51:30 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        Yi Zhang <yi.zhang@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v3 0/3] More fixes for FC enabling
Thread-Topic: [PATCH blktests v3 0/3] More fixes for FC enabling
Thread-Index: AQHZrY8ddz8bHQc+EUKGskaeljJAYa+pMa6AgAMfyQA=
Date:   Thu, 6 Jul 2023 06:51:30 +0000
Message-ID: <9125301c-61e0-96e4-35be-94d9c9565e90@nvidia.com>
References: <20230703091647.800-1-dwagner@suse.de>
 <op7hkwiauywfosn4q4h3cihdzcoy4m4vqthanv4urwxo4trazy@2qtljklkt4ry>
In-Reply-To: <op7hkwiauywfosn4q4h3cihdzcoy4m4vqthanv4urwxo4trazy@2qtljklkt4ry>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN0PR12MB5857:EE_
x-ms-office365-filtering-correlation-id: 7f8e8ce1-9c62-4a2b-828b-08db7ded6d81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: psRvEkCy3KRp7vlCK+FsiFN9T7gHKyP9Q+WoKpVujMbV+KCvySidGeF/lc8Tayn4feUKC1sA0TZjlUCHjPAoias8e/vI5t3tElIh1JafDGT0ekCE9qP0szoOdKIh/3YxOedbXHk3xNopzD8GHYajgxqA5SiTuN0TfihoNiOFC5rgZgpLM++XcOMjXOMga6lbdXyPC3N+vtWV6CTgJhr36KR+9M+xr/Yb5qHcrDVRpbNKMJ8DtnNZ3KgMooq5291lmt2tJwlaJVr1bceZvo6/Kjg46PWPGiJQ+ZyVs0f3QGbNaDJrm6qJ6lFhy5gRo1aOZ9jn314b/5yyWo1bon5mBdDraedntytqvbgMcHbpzGoqtN8EHogqpZSGkekm6rP1gaXfAK0Y4+rLv4GR7utZ6ojrUv6U/JM0iiVv74H5P+4vVHtBiYZGBVbi7xjb76PUt/6DT98TodX6ZdDdDgHvkgUmcE/Ebz65aOX1tTtgLoqqZjuP8ku78FclqUwn9Pps5SyH5Vg30U/1E2YC+w3U97LsHjMFNbwspNmPLd/e82z9pkP9ISNK3Qs54Nla/SBOeF8IX4rp1M4ZbUOBDKWzO15jlasMpoKRy6MRCs7g4k4gXM33kA7joFeL6IZ1d1RVHf4Iu7HmPiTIqt06wmLrV0VAxD/P/3XUW38pzrwF+tDeAMd/NYa00u9UczXKALkYCdpcI+VRy+A6nEBQNZ2dbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(122000001)(38100700002)(38070700005)(36756003)(31696002)(86362001)(6512007)(966005)(478600001)(71200400001)(6486002)(186003)(53546011)(6506007)(8936002)(8676002)(5660300002)(91956017)(76116006)(110136005)(31686004)(6636002)(54906003)(41300700001)(66946007)(66556008)(66476007)(4326008)(64756008)(66446008)(2906002)(316002)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWkzS2Fmd2NjaTNGN0hmc3NPSXowUEN2M3I1amVIa1M1LzFCVHJqYW5zN09S?=
 =?utf-8?B?ZVVUY3NEZUlDb293T3g4RWliTHNUdVQ2VzZpTVZzWU1YMzBvT1FyY2hmWU9i?=
 =?utf-8?B?RFduK1ZSR1JtdDk5TUs2YWRPMTUrYWs0U1RNMWpsTFVTZzBMOStGRjNScy81?=
 =?utf-8?B?U2puNElQUzQ4bTkvVUNSdW5rQzFGRGxTUE1RcE9BNnFMOUtKUTFROHA0S3k0?=
 =?utf-8?B?LzdkL2hNN1hSdWxxdXFqV3greit4OHlNMWsyWHN6MFY5UWVSR2ZPaGZMcXc1?=
 =?utf-8?B?ZlFCa2pPNFBuWXpiMmpsd0E2MkRGSnpJQitPZW5CeDRtd1RwbHZ4MWk0a2tX?=
 =?utf-8?B?Zm1OSndPNGJzRWwvZjVlbGhCZ0Z5MGFpbUNaUEVGNmJHR2ZnUEJWTVdteTNh?=
 =?utf-8?B?TDdkOGlYTG9BWFV6NDZNVlAwRHYrYWxRY0JWZlFBM0lwdzhZUDdrVTBFYmlI?=
 =?utf-8?B?NTRWcXBjb1N2VHBkMVZOL2ZwRnFGdnZLVmtMNzEzWEcvV1B5UTVpalIvK2Nx?=
 =?utf-8?B?TWFSeDR2YU1EZDJFUnFMYm4zV0d4ZlNNeFBEVzRKbzU4b29qekt4cUpkanlt?=
 =?utf-8?B?ZTlVSXdLeE4rcmJKRnZGeGcyMWdPdU40Y2FpUGFSZDdnSXpoYnVsdm1qN3cr?=
 =?utf-8?B?d1lha1NBQXhvbUVwQitaWDBUNDFENFYreXVUaGYyQ0V2ZEc2dit1anZQT21J?=
 =?utf-8?B?NlFiRFpCbVJWelQ1cXhvOHpTTTZENGtQNHV6enM0K25YcmVNWTQweVVZUGVz?=
 =?utf-8?B?NU1idmZWR2NJdzdFRldubmlYOU0zM0FtMFJIUnlPbWNudUVNVkFFMXppTjZP?=
 =?utf-8?B?NStaTWxVNXRhUkVDZk9nS0FOdS82K1UvbzZpaHMrTUtucFRId3dRbVY0Mzl0?=
 =?utf-8?B?aTArSHFWOGo0ZjRmM1R1YmFDRlBEOGt3WjZ1MkVXZjNzSXlacUxFRHZ4TWVl?=
 =?utf-8?B?T2VhUE9UUjYvb1hqeG92TklQa2hVRnFid3grTFhNcnlaSmtqek9OK09Nd2xq?=
 =?utf-8?B?aWt4VkRON2w2aHoxMXY5UVU4dW9lWWd2VFpDb1IvdWVYU3NyMFUwVEplUHZq?=
 =?utf-8?B?RmU3YjIxK1EyeHBxeExma1gzMmdUa2JRRHAwVExsNW1XTmtOcHMzSHorMTVw?=
 =?utf-8?B?RXB1V2xGQkV2YTMyWW96TGU1YURUTGlUNlZKNDZ4M3lOZVNkVHhTeThkYU45?=
 =?utf-8?B?VHBpZ0xyOE1UY1QrdFVDdW9LV2hCTlZlRG5yeFo2dW5nM3Y1TGxJb3NmRmwr?=
 =?utf-8?B?a3lZRmhJZXBXOThXMTN0NHdtdEhHK1kwWUFXckJaUFpFcVNBOUozS0JQU3Jr?=
 =?utf-8?B?YytLU0UrNHZyZVVnbTg1bnMwcUoyUmNlY09oNDhvL0V0YTA3ZVY3eTRpUmNy?=
 =?utf-8?B?OHF2NHd0UEFlV0tFWHRJQ2JWeElmU0hpNzNnVzBlZFFXWU05cmpjcmIrTDBX?=
 =?utf-8?B?MWo1ZmhUNUo0aVRybWY0ZVUxRFVEdlZVS2VJbWJ2OVVPU3hlZTRiRkxpVWVp?=
 =?utf-8?B?bnY5R0YwcUN5dFRCSmxUdExCS2pBYzR0V2h6aE5HZDFDUlJsOGdVMHdid01m?=
 =?utf-8?B?R1JiZkRheElrQUkyRzhLWUo1Y3dKUDg4bkJqd3NSb1RIdzhhdnI1a2c4N2NX?=
 =?utf-8?B?VWFBVnR0OE9IOXFlOEQvMUs3STl2Ykpzd055WC96Y3Q3UGZVQlprN1JENDgx?=
 =?utf-8?B?VFF5QlNjck13OU5SNldWQVlaNlFRczV4ZGFXY0NLdytoL2kwVXpPOFFwMGFv?=
 =?utf-8?B?RU81bjlBM3R0MlhKa1lKelFKaVo5TEkvbjVSOCtUV2NLMmVaZVZBRlRYaE5W?=
 =?utf-8?B?MVNqaU8zOWErelI3aEFRcXdhakxMbWltWU9DL1QyKzVOSkFWNkpSenEyQlFJ?=
 =?utf-8?B?aWFucDJGUEhHQU1FUStIYUROeDEvNlNkKzJlcW9RSkU5OEVjUUx4UjJGN2tC?=
 =?utf-8?B?dGt3WHJWenZ2VThNTFh2WWlsbTlqOTRhRmpJVDR0SzNmN1JnbXNmNFVweWVo?=
 =?utf-8?B?ZXBaREdCSXg5T25TSE9zL1ZYaWdHQ0crUmowYkZveGdtVlNxWmpzUzg0QmtZ?=
 =?utf-8?B?Y2dVMGorYjNaZmNqNENiOWNnN1ArK0dIckhhKzdPNkxNeWovckNpTlIyazZy?=
 =?utf-8?B?SGdWUzFyZG1oSmEvWmI5MnhhdUJiTE1HM05sbm5QMnhzMEIrRXlFSEVpbWVL?=
 =?utf-8?Q?97HMFPOOrayVed189dhxjAw5vzQvQ8P5wH2pNCo+teim?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A24892B45F10954C993B9E34AD67491F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8e8ce1-9c62-4a2b-828b-08db7ded6d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 06:51:30.0892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRdK9j3GRxNoBWKJvTgKAennjpcJt2OtTWfapTiP8mq9RvCAgyZgkEBv0R7dsWUhRw8glD42PYwPyjynKVFrTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA3LzQvMjAyMyAxMjowOCBBTSwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gT24g
SnVsIDAzLCAyMDIzIC8gMTE6MTYsIERhbmllbCBXYWduZXIgd3JvdGU6DQo+PiBJJ3ZlIHJlYmFz
ZWQgdGhlIHNlcmllcyBvbiB0aGUgY3VycmVudCBIRUFEIGFuZCBtb3ZlZCB0aGUgZGVmX2hvc3Ru
cW4gYml0cyBmcm9tDQo+PiB0aGUgc2Vjb25kIHBhdGNoIHRvIHRoZSB0aGlyZC4gVGhpcyBzaG91
bGQgbWFrZSBpdCBtb3JlIGNvbnNpc3RlbnQgaW4gY29tbWl0DQo+PiBoaXN0b3J5Lg0KPj4NCj4+
IEFsc28gcmV0ZXN0ZWQgYW5kIGZvdW5kIGEgYnVnIGluIHRoZSBjb250ZXh0IG1hdGNoaW5nIGNv
ZGUgaW4gbGlibnZtZSB3aGljaCBJDQo+PiBwb3N0IGEgZml4IHRvby4NCj4gDQo+IFRoYW5rcyBE
YW5pZWwuDQo+IA0KPiBPbmUgdGhpbmcgSSBub3RpY2VkIGlzIHRoYXQgbm93IHRoZSAzcmQgcGF0
Y2ggcmVtb3ZlcyB0aGUgcmVmZXJlbmNlcyBmcm9tDQo+IG52bWUvcmMgdG8gL2V0Yy9udm1lL2hv
c3RpZCBhbmQgL2V0Yy9udm1lL2hvc3RucW4uIEknbSBvayB3aXRoIHRoaXMgY2hhbmdlIHNpbmNl
DQo+IEkgc2VlIHRoZSBtb3RpdmF0aW9uIGRpc2N1c3NlZCBoZXJlIFsxXS4gSSB3aWxsIHdhaXQg
Zm9yIHNldmVyYWwgZGF5cyB0byBtYWtlDQo+IHN1cmUgaXQncyBvayBmb3Igb3RoZXJzLiBJbiBj
YXNlIGFueW9uZSByZWxpZXMgb24gdGhvc2UgZmlsZXMgdG8gc2V0IHVwIGJsa3Rlc3RzDQo+IGVu
dmlyb25tZW50LCBwbGVhc2Ugc3BlYWsgdXAuDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtbnZtZS9hamNtNnl1cGd1aWNrYXVjYW5zaXV6anFhdHl6NXFpam5ucDR0b3B4
djY0Y2lzYmJsY0A0c2d2M2JkM2psNHEvDQo+IA0KPiBPdGhlciB0aGF0LCBjaGFuZ2VzIGluIHYz
IGxvb2tzIGdvb2QgdG8gbWUuIElmIHRoZXJlIGlzIG5vIHZvaWNlLCBJJ2xsIGFwcGx5DQo+IHRo
ZSBwYXRjaGVzIGFzIHRoZXkgYXJlLg0KDQpBZGRpbmcgTWF4IGFuZCBZaSB3aG8gd2VyZSBwYXJ0
IG9mIG9yaWdpbmFsIGRpc2N1c3Npb24gWzFdLg0KDQotY2sNCg0KDQo=
