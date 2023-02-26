Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1449B6A2E9A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 07:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBZGh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 01:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZGhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 01:37:25 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC7F12F15;
        Sat, 25 Feb 2023 22:37:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WokX4r/E2NMzluB0FdRPK9xNrr0uEtHeJ1QOJH2fGLJJNJ5k0pzWwG/R+k+eoDcMep1cYhbRvpcEaezIcOT3WCz0zMzeswTJbGZwUeXzeFciglBAckRGHI1MlzMRrJOVqAxcVLa6iw3XpRIJ94j4FekMBT3UinGEv1n0kV/D8J6zqbZztesMDNOTfN3GPxw7toSyYIatLiMCPZbqqFQVYJSv0rmlrVKEaOOaVl6/k2mtOx2/UutYmXoDr2KxGZJlpxPyeWQeXLxVvmEjv0Lx1kURzisOAvztzN6zwtgda7h2OaApPD4TN2hI/d/RXNtmJjAaMwIh0V42Wq0UhaoyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YNokLxDEo1lWK+D58DVqeX3W3YKAvwy8UuSNjl9IDo=;
 b=ni0WFltiYtlaUnA9aJqySxbAjrfWfxV98GDCRrXhDZU1cgLhzZXlIDdN6eJrHcRsEuBoaTdMJeaA85WM+EoY1Lt5lsO6r8VwCDl5wc3BnOc8nRj/xtiVnbnAgzGVkrDt29UyBGqvUh46hZYVRKDMGNYD7xIAkfI8ALF0K0+4CgnhNdQTqGgqs9LwJGz3lf+WE70JSiYw3NejKlxAcIGMAXgkAM3VKD5nwxKL06fncfBHfBheD562/qTpRsLhUg0JvUYQEktLUBgX/fsaZtxVnCQLoxr24Gpg0KO80M/m8v0SXsdDt/k7KEjHztFuK20yn0JbGARjvm8d7coXb30XHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YNokLxDEo1lWK+D58DVqeX3W3YKAvwy8UuSNjl9IDo=;
 b=ICqvIUhJ93Dbpxwa/bHd40JQMqnNri0O9vDFANxdD3t1QD6wd05rv+1ScsqQ+NfNvkWz4Py09etgxT6AwxDOPVk3diWV5o48eNLExRyac3f7n9jGOuX96ojHstgJlUhO5EasDT5e5bf3sRr7WMy9kTn9O/k6/96/pfPfLRgEog5ufyTSKMivbHwQ+ETbF0y4h5JOdoh+lMG8Zsqgj2LOzY+QYStmAh9H0Y6W691rB0YKOtCAmttEPd1XlwGNLgTPmJ1DZb0p/YRfLpAYIuyxlhrAcWQHFW9phhGF/1WBgZNJodNm1d710NR+gwSiLvjDNB4NFDb7BPKTUs1ooVNtuA==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Sun, 26 Feb
 2023 06:37:20 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::9e20:f69a:50a9:cd73]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::9e20:f69a:50a9:cd73%9]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 06:37:20 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Shych <michaelsh@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH 5/8] platform: mellanox: select REGMAP instead of
 depending on it
Thread-Topic: [PATCH 5/8] platform: mellanox: select REGMAP instead of
 depending on it
Thread-Index: AQHZSaTFpAzcaXErK0ehcccvFQfCxK7gxhHw
Date:   Sun, 26 Feb 2023 06:37:20 +0000
Message-ID: <BN9PR12MB53811CD76F1395B9597278A3AFAE9@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20230226053953.4681-1-rdunlap@infradead.org>
 <20230226053953.4681-6-rdunlap@infradead.org>
In-Reply-To: <20230226053953.4681-6-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|CH3PR12MB7667:EE_
x-ms-office365-filtering-correlation-id: 3ec859da-1f26-4660-6f2f-08db17c3e97b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZXul1zkdk9TZhRDQJq2OuPAHIv2x0dvDpANOKzPABDt48HIJwAbhM5KBPirld2J/U2Sg+BQb72oIQShzK0bzs3pSnpMKzR2Y5cLD2SrD41UEO5rQDlBPPLuQWcufmpaAYIrfGqLvje5xKKRJb6CDVY2RQXLzaMbEPWbKx5Y8f+B9TGvM/cizg05QokNr0THEE9/4JUAsbjVMeZjK+Ll4Y0E8vHfWP5fQBIs4FEQ7aVgERwHHn3+jbmU7JuERQdTsONq6Qw1z7sYea6eD5sOAoMih2xKhTxoPSF3JG4ue15oCE5uAhiz6C27Ysyx0+N+Mfqo7nlj0AufaCVNKxJkF0pU4NCtTUTNOJDSW9P1RlyiwwG5KX7ubMi++OMChpXIzLt6g89+XD0ufY3nH5wHgdqED2FV73633Zh6trJvB2KJQjnwPLHsFIW+qZ+LXLv+o26fHoaL7mbCzu4J0z9/3vGmDL+cegBIZs4tyqvg3fmoA7LQSeTzcAYm4Fk3IxcrL4DvssLMIrfWEryLjX/0uzMK5YTenHrDCPru2XzYC6DzpYujpdjCccTRrRNtwa/vMf6yAWKFF7CbpAf0sGQArZNR1mJK7BdNOcdwaV5LfhjVE1jQLf1DDnxtGXlY8RrAOJ3c8oH2b0m/MhVutGuKIOQQmVUVCzis2Y6yQoor1Z2tvha+im8JODJpQ+kRjIoHFnQbIY2GW92ElOUBc1Qhu+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199018)(83380400001)(33656002)(316002)(86362001)(110136005)(54906003)(64756008)(9686003)(2906002)(5660300002)(66476007)(4326008)(66946007)(76116006)(66556008)(8936002)(8676002)(41300700001)(6506007)(66446008)(478600001)(53546011)(26005)(186003)(71200400001)(55016003)(7696005)(38100700002)(38070700005)(52536014)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzRkL0RaQWtDVjVTOC8rUDlBdGJyRXVRWkc2TmNhTTYxdmE1NlpaV1FaVHZR?=
 =?utf-8?B?V1hxZU1TMGcwc0FFakJkcWV2VlVZZ1UxaUNtTlpLTENRTWw2UHdobWV6a3pR?=
 =?utf-8?B?RTB4czVrcDN2VTd0OGU2TDdKVU83RGxaMlV0ZmxoUUlkeTlmZER0eVRnT3Vp?=
 =?utf-8?B?aDNqaWdzZ29KRi9xTlJJVVNnNjd5b1ZBUWR4YzlqbDBoWW90TnBhSytZTEhs?=
 =?utf-8?B?bHNvUWVKQ0w1c1JhbVh1TVU3cVlvWlNEc0pFQ05GQkxiZ3Jna3BScnBlVHdq?=
 =?utf-8?B?TWZ1cDQrazBwUmNsYlEvZ0xKYkhVd0tpKzNRSmQvN3dLazRwTjkvMVBCZzhv?=
 =?utf-8?B?WEFWVCtjdDdocnhuV1htVlkya2cvM1ZpMHJ6aDdmR3Y0MVE5TzA0UVR0OVVG?=
 =?utf-8?B?c29VTkluRitKcU5nNWhsUU02cGJRVXVwYi9TdVBZczZzQzdFbTNEblB5ZUFv?=
 =?utf-8?B?TkN1eTVuWGtlRUpHN1l6RWUvMTU2UVVUOG9zSUZhT2F0MTFVcEV5M2t6ZWJW?=
 =?utf-8?B?NTZuZll5ekJFY0dxRmZJak92ZTQvQWlYSWNsSlV0UHBZZDZJVW9pNGJlOFRN?=
 =?utf-8?B?M0tlZnFsQmNGNTFVUjB3VUFST2ZpcC80akZWR3NzVDBkQjl4RUh3TCtKd0VC?=
 =?utf-8?B?VWhRQjNRMVZ1OGQ4Qyt2WHRHc0NTb09XaXlqc3ZIVmJFSGJLSGdrVkRxWHBr?=
 =?utf-8?B?SkV0MFZMdWxOZmhWMkJQZ0JBcWx4SEN5Q2N4TDd0aXRyQ1RRdGJLYmpzNzVP?=
 =?utf-8?B?eEtXbTJRcDUybElZVTU5bTBldW5vVlZlVHNxMjlybStjRFE0RXJDVFlRbG1P?=
 =?utf-8?B?Z0FGSGFQTHRtZ3lDcUZIYWl3cjV5aElQSkFvczZZeFlKemhyQkt4aFFvdzR0?=
 =?utf-8?B?cXltMnpNVjdFaENSejR0N3A1THJoVXR0K21ZaHRWZ0RGS2Fjd09uaitZOG5p?=
 =?utf-8?B?dktYN3VHT0FRWmlOaHBaaDZRYldxUTJiajdWTnlzWWRkRUY2ZG1UaEVRcmI3?=
 =?utf-8?B?TVg5dDNYRktkNVpIYzgrTW45Wm1md1UwSGNNaHpQd2RrZmVaeVJCQ05CR1hm?=
 =?utf-8?B?ajJIVkNIbFEvSDIvNTJycUhLbm5XT2VrNlh2aUhWNUNib1dMZHNKZUt4KzlJ?=
 =?utf-8?B?YnNYb2FpcEZtZVMwaW1wclBXVW5Rd0VPQ0tRN2huN0FaTWdBaU1PTFBhcG1p?=
 =?utf-8?B?MU1SQ1FYRWNTSDMrZkJzQlZuYlI5ek5JaGRWL0UzL2ltcTFxandBMjB4MnMz?=
 =?utf-8?B?N2kzb3VTSEdDQmV0U3lFcjhDdklJRDZHbk9HL0h6NWFQQUtGYnRCNThEam9V?=
 =?utf-8?B?WXpNTFUxdlJFQU1ONk5NWStGSVBMUy9LZ3dQdXBqdGFkTlJNQWR1dlcvcnY5?=
 =?utf-8?B?SUpnVVEyQ3g5ektjb0ZjYmhnVTJEZFZCMm82clFmaS9OWUo2NjA0LzJMM3Zq?=
 =?utf-8?B?UVhmN21zb3Y1KzFpM0FMN0k5bzl2TG9FS2NnZXlRR3lHSk8ycy95UmIrZEM2?=
 =?utf-8?B?cDREU1daSWN1ODJiTE0ySXhsbHNFYmVvOWJRNjBVYzc3U0lPTFVwck5LL1l0?=
 =?utf-8?B?MGxIQU13Z2Z2L1RJWHdrZ0VOcTA5eUdOaWZNS2NVY05MQVJhMWZjM0hlL0ZS?=
 =?utf-8?B?SktORDlwSEwzanl5MFlsOFBCdWVnNFJiR2pNdDgwSmZUazdxZktSdlFacnAv?=
 =?utf-8?B?N01VcmFUd29ZdkttUXJlZThKN0IwSm12NkJrbUgwSWttQ054ZTg0UENBN1Jt?=
 =?utf-8?B?aTEycm9DSG4zN0YyUmxoKy9uamU5ZjVPQ1RzUEQ0MzBtaFVFUGVSZlRiZ2FN?=
 =?utf-8?B?L0VXNExXVVBzQVM2S3pRSkxaaDJ2Ri8vem93WU1UNVV2bDE4WGtuVXRsMERQ?=
 =?utf-8?B?ZlA2azBxeCtQd3g4OXRvenM4MFovd0tPV1MraVZxbitrMFU2TkFucENlNTVH?=
 =?utf-8?B?Z215cWdWSTZ6V25NQW5YQVpEbkJHd1FWaituNjVIWTFBeWwyV1FPakN5R3Rs?=
 =?utf-8?B?SklWUmZVUHg3bUlrUk1LN3BHbS9GNHFRdllkNUdYQktUUmdWWngzaTdkc0U4?=
 =?utf-8?B?Ly9HY1MrcjRFaFRxRWlTL0g2blFUVG5tZlFlWW1FRVI3OHVCa3dUMzVaSkNM?=
 =?utf-8?Q?GWjjqhigajjPicQTVVQTR8awg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec859da-1f26-4660-6f2f-08db17c3e97b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2023 06:37:20.5831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aEtUTU6yM992q6SkGa0Z7VpLBOCZzdEnykv2LglbkqN5DaDqYzmDocExq286ZUzB1qoXpqtsLOeoUNpiyegSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgMjYgRmVicnVhcnkgMjAyMyA3
OjQwDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBSYW5keSBEdW5s
YXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz47IERhcnJlbiBIYXJ0DQo+IDxkdmhhcnRAaW5mcmFk
ZWFkLm9yZz47IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBNaWNoYWVsDQo+
IFNoeWNoIDxtaWNoYWVsc2hAbnZpZGlhLmNvbT47IE1hcmsgR3Jvc3MgPG1hcmtncm9zc0BrZXJu
ZWwub3JnPjsNCj4gVmFkaW0gUGFzdGVybmFrIDx2YWRpbXBAbnZpZGlhLmNvbT47IHBsYXRmb3Jt
LWRyaXZlci0NCj4geDg2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggNS84XSBw
bGF0Zm9ybTogbWVsbGFub3g6IHNlbGVjdCBSRUdNQVAgaW5zdGVhZCBvZg0KPiBkZXBlbmRpbmcg
b24gaXQNCj4gDQo+IFJFR01BUCBpcyBhIGhpZGRlbiAobm90IHVzZXIgdmlzaWJsZSkgc3ltYm9s
LiBVc2VycyBjYW5ub3Qgc2V0IGl0IGRpcmVjdGx5IHRocnUNCj4gIm1ha2UgKmNvbmZpZyIsIHNv
IGRyaXZlcnMgc2hvdWxkIHNlbGVjdCBpdCBpbnN0ZWFkIG9mIGRlcGVuZGluZyBvbiBpdCBpZiB0
aGV5DQo+IG5lZWQgaXQuDQo+IA0KPiBDb25zaXN0ZW50bHkgdXNpbmcgInNlbGVjdCIgb3IgImRl
cGVuZHMgb24iIGNhbiBhbHNvIGhlbHAgcmVkdWNlIEtjb25maWcNCj4gY2lyY3VsYXIgZGVwZW5k
ZW5jeSBpc3N1ZXMuDQo+IA0KPiBUaGVyZWZvcmUsIGNoYW5nZSB0aGUgdXNlIG9mICJkZXBlbmRz
IG9uIFJFR01BUCIgdG8gInNlbGVjdCBSRUdNQVAiLg0KPiANCj4gRm9yIE5WU1dfU04yMjAxLCBz
ZWxlY3QgUkVHTUFQX0kyQyBpbnN0ZWFkIG9mIGRlcGVuZGluZyBvbiBpdC4NCj4gDQo+IEZpeGVz
OiBjNmFjYWQ2OGViMmQgKCJwbGF0Zm9ybS9tZWxsYW5veDogbWx4cmVnLWhvdHBsdWc6IE1vZGlm
eSB0byB1c2UgYQ0KPiByZWdtYXAgaW50ZXJmYWNlIikNCj4gRml4ZXM6IDVlYzRhOGFjZTA2YyAo
InBsYXRmb3JtL21lbGxhbm94OiBJbnRyb2R1Y2Ugc3VwcG9ydCBmb3IgTWVsbGFub3gNCj4gcmVn
aXN0ZXIgYWNjZXNzIGRyaXZlciIpDQo+IEZpeGVzOiA2MmY5NTI5YjhkNWMgKCJwbGF0Zm9ybS9t
ZWxsYW5veDogbWx4cmVnLWxjOiBBZGQgaW5pdGlhbCBzdXBwb3J0IGZvcg0KPiBOdmlkaWEgbGlu
ZSBjYXJkIGRldmljZXMiKQ0KPiBGaXhlczogNjYyZjI0ODI2Zjk1ICgicGxhdGZvcm0vbWVsbGFu
b3g6IEFkZCBzdXBwb3J0IGZvciBuZXcgU04yMjAxDQo+IHN5c3RlbSIpDQo+IFNpZ25lZC1vZmYt
Ynk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KDQpBY2tlZC1ieTogVmFk
aW0gUGFzdGVybmFrIDx2YWRpbXBAbnZpZGlhLmNvbT4NCg0KPiBDYzogRGFycmVuIEhhcnQgPGR2
aGFydEBpbmZyYWRlYWQub3JnPg0KPiBDYzogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0
LmNvbT4NCj4gQ2M6IE1pY2hhZWwgU2h5Y2ggPG1pY2hhZWxzaEBudmlkaWEuY29tPg0KPiBDYzog
TWFyayBHcm9zcyA8bWFya2dyb3NzQGtlcm5lbC5vcmc+DQo+IENjOiBWYWRpbSBQYXN0ZXJuYWsg
PHZhZGltcEBudmlkaWEuY29tPg0KPiBDYzogcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5l
bC5vcmcNCj4gLS0tDQo+ICBkcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L0tjb25maWcgfCAgICA5
ICsrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS0gYS9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L0tjb25maWcN
Cj4gYi9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L0tjb25maWcNCj4gLS0tIGEvZHJpdmVycy9w
bGF0Zm9ybS9tZWxsYW5veC9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFu
b3gvS2NvbmZpZw0KPiBAQCAtMTYsMTcgKzE2LDE3IEBAIGlmIE1FTExBTk9YX1BMQVRGT1JNDQo+
IA0KPiAgY29uZmlnIE1MWFJFR19IT1RQTFVHDQo+ICAJdHJpc3RhdGUgIk1lbGxhbm94IHBsYXRm
b3JtIGhvdHBsdWcgZHJpdmVyIHN1cHBvcnQiDQo+IC0JZGVwZW5kcyBvbiBSRUdNQVANCj4gIAlk
ZXBlbmRzIG9uIEhXTU9ODQo+ICAJZGVwZW5kcyBvbiBJMkMNCj4gKwlzZWxlY3QgUkVHTUFQDQo+
ICAJaGVscA0KPiAgCSAgVGhpcyBkcml2ZXIgaGFuZGxlcyBob3QtcGx1ZyBldmVudHMgZm9yIHRo
ZSBwb3dlciBzdXBwbGllcnMsIHBvd2VyDQo+ICAJICBjYWJsZXMgYW5kIGZhbnMgb24gdGhlIHdp
ZGUgcmFuZ2UgTWVsbGFub3ggSUIgYW5kIEV0aGVybmV0DQo+IHN5c3RlbXMuDQo+IA0KPiAgY29u
ZmlnIE1MWFJFR19JTw0KPiAgCXRyaXN0YXRlICJNZWxsYW5veCBwbGF0Zm9ybSByZWdpc3RlciBh
Y2Nlc3MgZHJpdmVyIHN1cHBvcnQiDQo+IC0JZGVwZW5kcyBvbiBSRUdNQVANCj4gIAlkZXBlbmRz
IG9uIEhXTU9ODQo+ICsJc2VsZWN0IFJFR01BUA0KPiAgCWhlbHANCj4gIAkgIFRoaXMgZHJpdmVy
IGFsbG93cyBhY2Nlc3MgdG8gTWVsbGFub3ggcHJvZ3JhbW1hYmxlIGRldmljZSByZWdpc3Rlcg0K
PiAgCSAgc3BhY2UgdGhyb3VnaCBzeXNmcyBpbnRlcmZhY2UuIFRoZSBzZXRzIG9mIHJlZ2lzdGVy
cyBmb3Igc3lzZnMgYWNjZXNzDQo+IEBAIC0zNiw5ICszNiw5IEBAIGNvbmZpZyBNTFhSRUdfSU8N
Cj4gDQo+ICBjb25maWcgTUxYUkVHX0xDDQo+ICAJdHJpc3RhdGUgIk1lbGxhbm94IGxpbmUgY2Fy
ZCBwbGF0Zm9ybSBkcml2ZXIgc3VwcG9ydCINCj4gLQlkZXBlbmRzIG9uIFJFR01BUA0KPiAgCWRl
cGVuZHMgb24gSFdNT04NCj4gIAlkZXBlbmRzIG9uIEkyQw0KPiArCXNlbGVjdCBSRUdNQVANCj4g
IAloZWxwDQo+ICAJICBUaGlzIGRyaXZlciBwcm92aWRlcyBzdXBwb3J0IGZvciB0aGUgTWVsbGFu
b3ggTVNONDgwMC1YWCBsaW5lDQo+IGNhcmRzLA0KPiAgCSAgd2hpY2ggYXJlIHRoZSBwYXJ0IG9m
IE1TTjQ4MDAgRXRoZXJuZXQgbW9kdWxhciBzd2l0Y2ggc3lzdGVtcw0KPiBAQCAtODAsMTAgKzgw
LDkgQEAgY29uZmlnIE1MWEJGX1BNQw0KPiANCj4gIGNvbmZpZyBOVlNXX1NOMjIwMQ0KPiAgCXRy
aXN0YXRlICJOdmlkaWEgU04yMjAxIHBsYXRmb3JtIGRyaXZlciBzdXBwb3J0Ig0KPiAtCWRlcGVu
ZHMgb24gUkVHTUFQDQo+ICAJZGVwZW5kcyBvbiBIV01PTg0KPiAgCWRlcGVuZHMgb24gSTJDDQo+
IC0JZGVwZW5kcyBvbiBSRUdNQVBfSTJDDQo+ICsJc2VsZWN0IFJFR01BUF9JMkMNCj4gIAloZWxw
DQo+ICAJICBUaGlzIGRyaXZlciBwcm92aWRlcyBzdXBwb3J0IGZvciB0aGUgTnZpZGlhIFNOMjIw
MSBwbGF0Zm9ybS4NCj4gIAkgIFRoZSBTTjIyMDEgaXMgYSBoaWdobHkgaW50ZWdyYXRlZCBmb3Ig
b25lIHJhY2sgdW5pdCBzeXN0ZW0gd2l0aA0K
