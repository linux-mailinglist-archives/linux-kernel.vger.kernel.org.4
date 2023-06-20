Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBACC73633F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjFTFlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjFTFlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:41:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF2410E0;
        Mon, 19 Jun 2023 22:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bReVbJ1AyiuVSoD4QMLqrq8swOVAftusoYcht3kxHKi4Fy/AxDKIfGh8FxxOiT87vluKmFWafP7sDiiBtWreaEcLN/agigR/Mk2W4nPWXNGH7ndwu47S2iiKj89cTwZ0PMN2aeFrw2zRp1S6Bq8MkOyL7h5EHy61hBB5iPMo4EkYsaVkOsF2wvCn/YBn50qyieAQAZ+3zRMfo0wndIcIL9IkqVBgadINzExPjN2VkAhivsaer+yOfslq5IuSB/ZA7NQBuOZXhICjFyeE+RgPBRTk5TuRzH+6zO+iQaS5FxI4WeVm7StPvnY5vxmEJY2v6G9XqlXCI3yeqSqqfK5HvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VXV7QHbbKwsoQl5oFpsi16BvcwHbZFwIC6MxSt/334=;
 b=OWKSL1d8XHedbthYY7zMNKjkcd4g8T242WxEyI4nOWW/GdrbnQmzrHgsY7YAH7ZtkS3ypVNLxpWABHK+DjIAVl5tv5DwlFQ7Dh4vB1bK7RtyH+89KigQBwUM/aP0BRmVv5pLeYmJUwOT+km96IWfzfdxpySlZN866aO8y2+sG3+kjZeZEu4AdTMRGaUJCA9eaO6J/+nL7j4Z4eJmRv187pVJuurU+XC0j1olddtlYbam9WyO9RWPQv+SmTxX/97vnIKr/Oamr1J6Vb7F10iRPNo/hAwS1hJ8df9rA5rhe8afgHoRjO670hA2qUCdXokhna3F4jmfnp2aY8OFENRSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VXV7QHbbKwsoQl5oFpsi16BvcwHbZFwIC6MxSt/334=;
 b=GMnORJJufAHe0xy7P0bVcC8js6KcCHd7e0gBRufmNTn1SmMli+g/sVBDwzlqyxifq85SiFx67MtaZsjo72uYn2NfHTfmMiq8QSEDdCgr/KjCd+V+5V9/2Jt1YKhhhwFGbcixLusSQEugmeGCzD7EVUw3IdCisOOyiNquLQeWTxleWp/r1uzkjFzBb798DR9kFj3iwQEGB2ME97hTD1V4rBeYvm2BjbIa+9Ow6IMFPC3xP4wlN8waoR+6mJp4Ix7T0LFM23dSEVDWCZbqobhftKghfeGnDVMVUkiu9RGC2Xff5MLdgoO9aeyp3QcHYk8vMqcwAWi8hXO+G4UQsZupog==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 05:41:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 05:41:11 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the block tree
Thread-Topic: linux-next: Fixes tag needs some work in the block tree
Thread-Index: AQHZojNup7drQWNH4USrTHq5s1jdUq+TLzsA
Date:   Tue, 20 Jun 2023 05:41:11 +0000
Message-ID: <a6f86f61-a054-2d31-92ee-0241c44a8ae6@nvidia.com>
References: <20230619082249.0e577baa@canb.auug.org.au>
In-Reply-To: <20230619082249.0e577baa@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4156:EE_
x-ms-office365-filtering-correlation-id: 4f1ee374-1be4-4c55-a8f7-08db7150f435
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xU11qx3Vc62xloAHcj6DyEkO+0v1oVWaNDjO3jPn6tCqkI7/Sjg1ZOp7f/LQsSM0uDzugEYilepbIovG/bn9D4rbpzGFfROLYqDn1rQH41k/yo74sgOQeUEoHfetRT0sriKCMXG/2fvnSwbDR0rKWoes3OJVW9NZUkmn3f+7kyAzK0TGEtv/+9/eQAlb8DH2dqPAqA7CRAccmKPh8FzeZTZO5tIIcWJZb0D5VGw86++4UHVXViWWtJ65SJi9FG5jl8aSmBB7KxAulY5SMF4z5J8QjQrVdjnBQhZSCBQsFJGBvYwpOaLTxHBo4UTgXmh5NhdAJK/Nzyy65bK1TaPDTxro+p3Zu2yrvnTCcMf2zDR+Jh/U1jKKMW/jPsjWXUTsaITfJMxSOBLT+2PMLSXM0vXtDYFpP4O7NLuK/M9zTxIJ1gtZFWOPOalZ9QtM005kuFZpTuQoGN9u12zgppLNILxJkr20ZIdUThII8D0fOn2XHnbrc7HjgK7S7ar9J9hjmRSa6RCww30sXaZ0CY1Lzs5XvfRUvw7hs9VTX63LIVFDaqDVjg4LxEIrCvkI02hdHwIQOdHWKiM4hhqhp9YC02TyfKIi+G6v7ajTj1LXNK++oLoQC2F9zXNooMPC7x+4G6ZW6RvLT19ZDDSgRU8by3opkJP83PK8v+Bn2FjWkrrxviKhRQaL0lu4F5bHCLo0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(54906003)(110136005)(6512007)(6506007)(186003)(6486002)(41300700001)(31686004)(478600001)(76116006)(91956017)(66946007)(66476007)(66446008)(66556008)(64756008)(4326008)(316002)(53546011)(38100700002)(71200400001)(36756003)(5660300002)(8676002)(8936002)(2616005)(31696002)(86362001)(2906002)(83380400001)(38070700005)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THNhYVhqOTJySzg0cFFBRUJYaDhIVEhXZFpqdGgwN2gzMWxndnRtTHlKUWVo?=
 =?utf-8?B?NE1zVHZWSVJlZkJBaHRZUitvRFdoaFdjNGQ4ZUZJbHVXc3NUMkpXbkdscHJh?=
 =?utf-8?B?UFNLVWFaUU5DZ25vMW9jclJVUEhIaThZc1U2S1B0Z1Z0NXE5T2EwVGN2K0R0?=
 =?utf-8?B?YVBFeXhlM3NFakszcjRRcDNHeENFUDhZTVIyTFdma0FIaGI4VmEzRVoyZ211?=
 =?utf-8?B?Qm1VSjhlbWMrclQ3eW1VZDdrQ01FSzBuRU1MQWxVaFJhckdscUV0b2Z0b2ZB?=
 =?utf-8?B?eGFYS0M0Y05IVDFlaW11S0JUVUxxcG9nR3F0ZCtxcElGZ3ZrSEFnYUMzUHVl?=
 =?utf-8?B?aWtIektuUURpdlcwSUFJZVRhZGFDUDNETUpnYldyWVJkeXBQWHBkZjdsNkRM?=
 =?utf-8?B?Mmx0OCtKemRwZThuRGFoMENsUm5Vc0lUK2NLWURTRk5zb2g5TGcrTTc4UVg1?=
 =?utf-8?B?TzN1a0FDSjhrYVlRMm9mQS9LNks3T29kUGkzaE5sOHFNK2VlbWpTd0UzRzQ1?=
 =?utf-8?B?Rko1T1NtVzcrOStYVnpFaXJKSUhjQm42cVhmNVA1RnUwaHgzTjBRT2dVNDl4?=
 =?utf-8?B?UnFUNHRIdW0raGFtcDBFWHptd0pXV3NqcUFkc1NqdVU2ZDcvUWsxN0lxZjMz?=
 =?utf-8?B?RjBPRmdDV3VkRHo3Wi9PbnRKNEVPVWNianJPZ0h2THdnK3RKbTFLb2hZbEJw?=
 =?utf-8?B?cjJwSmtuWW5YYVY4eWhyQ2dMa3p4SUlxYjJaS1REVEN1TXV4bHRMSTVMWG1N?=
 =?utf-8?B?anlBR3JCR0dXdTlmY3Z3S1JBSkhBQUFFUzlNOC9mUlhBbllQTS9sZGpLa3Z6?=
 =?utf-8?B?dWVMc1doM1R5cGFHYnlEc2NsMUdvK2w1T2dOQlc5VGNZQzRRbFI2S0JHcmxU?=
 =?utf-8?B?SWw3RGxYeDh4MnNEcWJ1d0FzK21pa1lCZlZVdUhHOFF5OEhYbTB4TWJmRk85?=
 =?utf-8?B?aHpQVk1ETGpaUGMzWldqYlc0ZUUxeVNwSkhWK3drRXM5VzVYWjAxZUNzZzZS?=
 =?utf-8?B?d0pjQ3Irc0xFQjg0WmpPSlRIYUw5VHZ0ZUVnQ0ZzcisvV2YwK2U4UzJLWk5G?=
 =?utf-8?B?cVh2WWVnRW9FUVVYZGtKZHZxbE9yNTZnOWJFVTBuU2RHRUV4YTJlcisraEMy?=
 =?utf-8?B?YW1FckZFN1FENXJJaUV0RmJsazUrZ3psazNsZ3BVTHRsZ3krMzlQamhXNzB3?=
 =?utf-8?B?cG5iaEdnMkJvRVR4TndPaWRTZXhaR2Vzc1JlSjI0cDRRQ0tzOUlSemJxZWJD?=
 =?utf-8?B?V3czQy9hSkFVcERXNjEwTytDZkhwVkZ0em4yUnlKWWMwc2JLV0tQcDVKaSsz?=
 =?utf-8?B?RlJnbVZOS3dnTzEycTVGM0crRW41U1ZFdVNCSkZmWmRDZi8wbWFUaFh0NE1t?=
 =?utf-8?B?NVlZV2pLS2VRSnpQMGRVUDdRaU1YUHJMbFBvZUlmNkFhcjlqWS9ZZFBpTUdG?=
 =?utf-8?B?V0pJYUorNFdxNThBY1RwSzlBSVZpNm1Zay9RbU1acWlpb2tqQjRBbjhVRk5w?=
 =?utf-8?B?TkFGTHJxQmhVdHZHN1Z3dkM4cUkxTEJLcnUram02UDR2QUVTb2l5Mi9OYW1D?=
 =?utf-8?B?ZGY3VnJ2UDNhRkZCbGtJbnNCWXlHS0M3d3JrbEhDOUQ3UVd6M1JEK09mT2RK?=
 =?utf-8?B?cytiNG1XSHZ1eTVKV3BtTkV5NEJ2bnB5cGJBMHNmOWxRYk5aMm9GZ3dIbkpW?=
 =?utf-8?B?aHFXcXA1Y2VZQTVrVDRuSVNzd2lTSThtb3ZsdVE3OGt2Z3lVMFFIV3lBSzF2?=
 =?utf-8?B?WDdWMGcvMkFOKy9ZNmluMDByMDErSkgwd3NoU3llMTZJMFU1cTcxVUpBNTVJ?=
 =?utf-8?B?ZWhCb1RaWHRaUzBURDNIMWtlOTRYQk5zbm5vemNESmVLMjVuWVlZbHNKUlJF?=
 =?utf-8?B?alN3dFRxVGdqeC9qWko2TEVoWnhzNWxEelpwZmQ4Wi8vMGJRbm1kTk03WThY?=
 =?utf-8?B?Q1Q3RzUyZk9OS3Rwc01Xb1lWZzNPM0tiN3pxOWZWLzhmVmNUQkI1clhYUDV4?=
 =?utf-8?B?RHpnRWhkdUUzejZGZ3grZUNsMzJ6K1BHampPODg3SU1XTVIzYWh6czBFOXdV?=
 =?utf-8?B?bXQrYThKMUdXYksxQWR2akY0Wk9UWVlzMU9lT0dBd2lLUTFOK29COEZQT0Rx?=
 =?utf-8?B?c0pxc3k1amR4OE9NdktFZTRZcHBROG5vNVV1Um9pNk82enlMbFd4MytQNGtQ?=
 =?utf-8?Q?03anmNHPsGJHvc5sV1QnpmSJnX5Rtw6YNN6H7MN/saGJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA51A9B25B31A44486055D4E063A6929@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1ee374-1be4-4c55-a8f7-08db7150f435
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 05:41:11.1195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQwh//svAz6ewkaZt83q9mb5LnFRUg0LipB4a4pVsbhbaexm1i8wrjelB/kz0ThOiTVS9c9QUIwqbh0pbtIENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xOC8yMyAxNToyMiwgU3RlcGhlbiBSb3Rod2VsbCB3cm90ZToNCj4gSGkgYWxsLA0KPg0K
PiBbQWxzbyBpbiB0aGUgZGV2aWNlLW1hcHBlciB0cmVlXQ0KPg0KPiBJbiBjb21taXQNCj4NCj4g
ICAgOTAwMDk1YmZiYmY2ICgibnZtZS1mYWJyaWNzOiBlcnJvciBvdXQgdG8gdW5sb2NrIHRoZSBt
dXRleCIpDQo+DQo+IEZpeGVzIHRhZw0KPg0KPiAgICBGaXhlczogZjBjZWJmODIwMDRkICgibnZt
ZS1mYWJyaWNzOiBwcmV2ZW50IG92ZXJyaWRpbmcgb2YgZXhpc3RpbmcgaG9zdCIpDQpzb3JyeSBJ
IGRpZG4ndCB1bmRlcnN0YW5kIHRoaXMgd2l0aCBhYm92ZSB0YWcgSSBjb3VsZCBmb3JtYXQgYSBw
YXRjaA0KdGhhdCBsZWFkcyB0byBhYm92ZSBzdWJqZWN0IGxpbmUgOi0NCg0KbnZtZSAobnZtZS02
LjUpICMgZ2l0IGZvcm1hdC1wYXRjaCBmMGNlYmY4MjAwNGQgLTENCjAwMDEtbnZtZS1mYWJyaWNz
LXByZXZlbnQtb3ZlcnJpZGluZy1vZi1leGlzdGluZy1ob3N0LnBhdGNoDQogwqBkaXJlY3RvcnkN
Cm52bWUgKG52bWUtNi41KSAjIGNhdCANCjAwMDEtbnZtZS1mYWJyaWNzLXByZXZlbnQtb3ZlcnJp
ZGluZy1vZi1leGlzdGluZy1ob3N0LnBhdGNoDQogRnJvbSBmMGNlYmY4MjAwNGQ2MTBiZTNlZjQ3
YWJmMzE1ZGRmOTVhYTJkY2QxIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogTWF4IEd1
cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4NCkRhdGU6IEZyaSwgMTIgTWF5IDIwMjMgMTg6
NDE6NTUgKzAzMDANClN1YmplY3Q6IFtQQVRDSF0gbnZtZS1mYWJyaWNzOiBwcmV2ZW50IG92ZXJy
aWRpbmcgb2YgZXhpc3RpbmcgaG9zdA0KDQpXaGVuIGZpcnN0IGNvbm5lY3RpbmcgYSB0YXJnZXQg
dXNpbmcgdGhlICJkZWZhdWx0IiBob3N0IHBhcmFtZXRlcnMsDQpzZXR0aW5nIHRoZSBob3N0aWQg
ZnJvbSB0aGUgY29tbWFuZCBsaW5lIGR1cmluZyBhIHN1YnNlcXVlbnQgY29ubmVjdGlvbg0KZXN0
YWJsaXNobWVudCB3b3VsZCBvdmVycmlkZSB0aGUgImRlZmF1bHQiIGhvc3RpZCBwYXJhbWV0ZXIu
IFRoaXMgd291bGQNCmNhdXNlIGFuIGV4aXN0aW5nIGNvbm5lY3Rpb24gdGhhdCBpcyBhbHJlYWR5
IHVzaW5nIHRoZSBob3N0IGRlZmluaXRpb25zDQp0byBsb3NlIGl0cyBob3N0aWQuDQoNClRvIGFk
ZHJlc3MgdGhpcyBpc3N1ZSwgdGhlIGNvZGUgaGFzIGJlZW4gbW9kaWZpZWQgdG8gYWxsb3cgb25s
eSAxOjENCm1hcHBpbmcgYmV0d2VlbiBob3N0bnFuIGFuZCBob3N0aWQuIFRoaXMgd2lsbCBtYWlu
dGFpbiB1bmFtYmlndW91cyBob3N0DQppZGVudGlmaWNhdGlvbi4gQW55IG5vbiAxOjEgbWFwcGlu
ZyB3aWxsIGJlIHJlamVjdGVkIGR1cmluZyBjb25uZWN0aW9uDQplc3RhYmxpc2htZW50Lg0KDQpU
ZXN0ZWQtYnk6IE5vYW0gR290dGxpZWIgPG5nb3R0bGllYkBudmlkaWEuY29tPg0KUmV2aWV3ZWQt
Ynk6IElzcmFlbCBSdWtzaGluIDxpc3JhZWxyQG52aWRpYS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBN
YXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPg0KUmV2aWV3ZWQtYnk6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNj
aEBrZXJuZWwub3JnPg0KLS0tDQoNCj4gaGFzIHRoZXNlIHByb2JsZW0ocyk6DQo+DQo+ICAgIC0g
VGFyZ2V0IFNIQTEgZG9lcyBub3QgZXhpc3QNCj4NCj4gTWF5YmUgeW91IG1lYW50DQo+DQo+IEZp
eGVzOiBhZThiZDYwNmUwOWIgKCJudm1lLWZhYnJpY3M6IHByZXZlbnQgb3ZlcnJpZGluZyBvZiBl
eGlzdGluZyBob3N0IikNCj4NCg0K
