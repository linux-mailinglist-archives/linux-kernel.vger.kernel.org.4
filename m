Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86666E832D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjDSVOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjDSVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA04468C;
        Wed, 19 Apr 2023 14:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1LzMQJlAZj+vrYf5yICuPMXe8pq4bYlD+niKryMKb5i7V2WnevOuv8xpT8kX2GGGjW+4VuV3S8+KWImdOIFJOpMgL4ed99v2g16LntZkU+6jq6QX5odufHjpBTTT+iV1Hxaw1kc+ApZoPPWr8lye7RBOd7isijHa8VMPscOjzxBqzwqT3G8RI+8Uyp1RiK0gDw3eHcj11S5iP+tVCDxuSApkHC+NQF+2+C+1g6QptQjb2IsGFVUFQEHuv4iERnzsCWaSMK9eGwQxjdMVhqiuE+YBybS8ZZdShaX38/R0XglIAG9Wfu7F57ex5sSsxk8laJmLOGWz+Pikm5/Ei4kSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp+hq5L0AE84TKnmhneNcyHASwT/MoAjwgOMdHInk+s=;
 b=lixbF2fxKQEkM+GUsC8hDOGmyZMlQRqvdU0Kn8S6oq6stoL/Mz/DNaPUm3NmWZ6FYrxUveey48G+1Vjp6+A4oGuxYxenaqhONwycrrmavzufL6Z+uBL6kepbwLakzt2tLYZhDwbSlrpzC/pl0h9HUdYR8esQwuJqQ+2hBem8dDD+DTP+JJSAojMJwHKvfx4e3OWbCtZb2nZ2dem8JOiesINWy6w3XmZx4PF25v3pCKDWia+9T7l7rOxBJNWkDB+20n97xO+CDcVPzL3Kzn65SNM0y9uI18h1OTpeK3aSBDgqyNI7EThB7WwXkbbPdPgFwKU7NrvOHxhMV+3DirZzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp+hq5L0AE84TKnmhneNcyHASwT/MoAjwgOMdHInk+s=;
 b=bWkrh0+WccTjui/fBBQ6IhlvbssgVHrkep+QQ29IOFTHWs+92lZU/VN6UkOrA//0ZzaeBJqDnbj6r0HxFjB9R7b2XV4iESfO6ZmCeR06HuQ8xM/24UkrNlTyhk37ACx/c3420/9O1SORnuYSOI22YHJvsoS3DnILysBe7CBC4AGTvYoajsniz86wSYmYoPug68QQ0YH6iQOexTfe9tRw5nJ0yvEMilyzWMlHakHfx5zy21RylBS0vFfDJ6IHrV+0PJlSdF+5jnTdx/LSraOkzmExIYqyTQ0+RzAUUIVmwA/t0Wvyk9BlnuTSqHz4RE5MP9b2nhQMDT6vDxqNPt6rOw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 21:13:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%5]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 21:13:58 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Thread-Topic: [RFC v1 0/1] nvme testsuite runtime optimization
Thread-Index: AQHZcpzgQRAsytyJiEWmAIUqEW+1V68yXyyAgAAEQwCAABaMAIAAIuaAgACFmoA=
Date:   Wed, 19 Apr 2023 21:13:58 +0000
Message-ID: <f8da3b2b-407a-c777-87f4-6a1dec32efb3@nvidia.com>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
 <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
 <zlavgcdalmmtabiabu76m4s3oo5hyaehckmwcxvqrnu3j6q6xo@5ke6gv5h3j7i>
 <6a5feb66-632f-b843-c04d-e0aaa2d51415@grimberg.me>
In-Reply-To: <6a5feb66-632f-b843-c04d-e0aaa2d51415@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB7685:EE_
x-ms-office365-filtering-correlation-id: bd06a806-2f97-406d-dade-08db411afd87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ryBv/ZO2OesHBrME5T/IV9CVi/+xoGkWR5I88KKufOFsGhBaS7sw8eZhKU1hFH9GyUkPaizpONwYCWAjpHbrKzGuX75z4KOoTjpedx88K/mnmAIlKzLJ42s2I+K2jdW9zPYaLTfuo8CaOG3u/Fl76gNaazchiWyPq6iXtlyPnefSKCX3NnbDWNHHMGk4i/JqigZ9mhcrJRfgexMZHgWPKA4JtB1URmBbZ3JeDYJwXVkuR27W95B1Ga4UEHP9QdsK2CkBqrMioIvR3/gwiA8GgDQIag7srBRtWurlvlGe61t31ywsWgiJJ4WiaPMPqdZ/LBLaO+gAJB49W0/pvtUV9aZslhLcS7msvINAeS50TY0la5aHwC2TBlbgrnXhvKl3eTJYP8Tcl8JzH7DsETNuQ223M7jTqHKd7iejQ59x04Okk2kCqwM8ppkyrD0zgbGL0k+gpxGvNxJgAmTqt61wIYpTopADjBnlZVc4H7RjODz/tNC7vqroAYXgVN3KJ1VUHyojxEBdQkskoSA4YlxP+j0lWKg96xCRaqFB48wQGND4YN95z19ywzXp6TjKdKNAlinUIXWQGiKYCLBm5F6yujrwsTQGf0Xf0bMqkN+ZUIFuP9SWnBFn/Rr8yPz8zIHJsc0NyFoe/AHX/bT85SCagDCdvi7oCeFnMabZz+NPzab2t5a1juNspPbPloZ0xCdU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(8676002)(41300700001)(8936002)(2906002)(38070700005)(5660300002)(83380400001)(54906003)(86362001)(122000001)(36756003)(110136005)(478600001)(6512007)(6506007)(2616005)(53546011)(6486002)(38100700002)(186003)(71200400001)(31686004)(31696002)(316002)(4326008)(66556008)(66476007)(64756008)(66446008)(91956017)(66946007)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkd5WmxMdk4rUEdkT0owYm84K2NqanRUL3ZMWVg5R0JUNU9QSGoxN2I3bnB1?=
 =?utf-8?B?TDB3bzA1elRldStacWpRZC9DMDVCZi9RTkNxYTllNVBxbStYdFliN0NHZ1JO?=
 =?utf-8?B?VmVzQ1crK3FPRklMczBqcHpjQVVBS2M3RGF3QUR5N01ienVlVG5jRjFhUmsz?=
 =?utf-8?B?b3JkSzZwK1hseWV1THRzM3dnWHRGOXJtcmw1UVZSQ2VzZm5qSnFaS3hFSUFl?=
 =?utf-8?B?MnRyVklyY3Y2SVJWUlhDMUp3UUZnam0zalFRcXVFeVhQN25BVzZuUmYyYURi?=
 =?utf-8?B?eHQremxlMDlhZjlxajRCK0svWGs1bXFmWjk3QUdGL0ZNcGtLZlkxL2RudkVz?=
 =?utf-8?B?MTRMVnJNNmR0OFJwM1FHRnhlYnhRY25DbFBZcCtRaUJ2aTJFcU9oOEhkc3ll?=
 =?utf-8?B?d2ZJcHpYT2Q5d2JwMWJPVE1KUk5BRzYrNDlLajF2WXlleXErSW1xaHZoYXhW?=
 =?utf-8?B?emg3aFo5cTQ4TEtlUFUvZmRqQTNZeXA5c3hNQ3JXOVpyQklFWGl6OU9yUzZW?=
 =?utf-8?B?SUl6VEFRcXRDZGlBc2RNODdJN1FqL2NBcHZ1a1RzRUNVSEZmUTAwSzVLR1FB?=
 =?utf-8?B?R1VaVy90SXY4SWMxYTB1UVVqMzVQUzdyWVJZZjE5cGZwdjlhOWttaUtweUdK?=
 =?utf-8?B?MFFhZ3RuRDNZVGZuc3NZbnRrNVF6NkgraklRSHErSHVxd0l3eHkrTzJLL0N5?=
 =?utf-8?B?RlhDaHJJMmtVM0o4czJ6MTVjYTN3STcvUFZCVjBDejRZUFNCR2wyenIvaitO?=
 =?utf-8?B?UmhXYkd1a0ZvaFp3SDNpQzBsOUJzSmI1cGVibVVpdWlIa2s3bG1yR254bWd2?=
 =?utf-8?B?ci9VZEVheTVPRlFJNmh6a2FvS0NGQjdmb2Z0Rk9nYXF5UFVwTXFDY1hHOUIy?=
 =?utf-8?B?cHJFQkl2ZXludW9wUnR0SUUvUWtXUDlWcGJaRlVROVZTKzZFREtuUVBxbUVk?=
 =?utf-8?B?cGhPY1pKbFpPSUNxYVI3L3M1Nng4dnFRdTRjTFo2Snl2d1BxMWhSQklET1I5?=
 =?utf-8?B?am9SS0tFejhpRjhhcjRzTDAxaTV2RXZDRGlrYStZZ0lqQWd0VHB0OUpCVEt3?=
 =?utf-8?B?UW55dTlsTXpWanRBZlpZRkw4OXp0N3Vvdk9Jb09uQlFDTnc4YnlLbkwvb2Y4?=
 =?utf-8?B?aWRNTHJZQ25xMytVdktXekg3NkRKOVArTFYzamdEZFF1Vjc3Nm1iRDd1NEZV?=
 =?utf-8?B?ckVrdGVBUnZ0M3N2aVNPMDRlR3I5NVFJVEVHbGUrL0pMTDk3RkY2dU1sZjJz?=
 =?utf-8?B?RGRmbGNmYmc2TW1nY2ZpcmQ3RDl0eVBXOUpGdzAvK05hQlVyWlR2azBwTjU3?=
 =?utf-8?B?aitISWxseTh6STVnakRIeHpraUJiczFzdGd2WEUwcWVDdWZLdmxZRDhlLzFQ?=
 =?utf-8?B?RGdjSlJuWU1CY0J2eTl1RUY3elFvcFJuY0ZteXpjT0lxSzFLN2hxQzJ4YjdU?=
 =?utf-8?B?YmxScnpxT00zcnJBSFZqYnVPeHdkUy9SdnRoNGwyK21qeXFoREpuZGxYUjAz?=
 =?utf-8?B?ZE00YnNucHc4K1EwS0Fvc2N2cmlURjB2OG1EK3NnRDVCZ1NpcmVkeXZUUkl6?=
 =?utf-8?B?YmY4cVBSTTVYSUVpNFRJamlrVkxjWUFDZFB1MXp2RkZnYkFHNFJsMlZwV0xD?=
 =?utf-8?B?SWNUMG5TWXhjL1F5RXRXS3NVMkZhd1ljeE9JVEVQcG9VL2NmQk0vM0tFWDcv?=
 =?utf-8?B?emhjNHVYbHR6YlJOM3NsSHNMdS9JVFpjYU1SbDVjWnJXV3NOR1NOLzJLWVJ2?=
 =?utf-8?B?S0d5WFpicWZwZ0cwc1R6bXhmb1liRkdRL1pHRUlpd2dlbDJJYnNmYlRDcTYv?=
 =?utf-8?B?VXl6aWhmUjRWRnRIK29DR2ZCMTZWRzFwVWQ0eDR3WVZ4blBjSlBKekh6U09Y?=
 =?utf-8?B?a2ZDRFlQREM5SU9ScTRzd1ZDdURtQXRNWXNyaWgxeFpHT0x1Z3Z2cDV4ZWhW?=
 =?utf-8?B?aVhUOU9lbzh6eUZVZzhYVSsxM3JSYTlsMTlIc005VEVzSGZiT0JwaUpuVUxU?=
 =?utf-8?B?SSttNktuRjlZT0J5QXl4RU91YWlkTDRCdXcxM2kzZlUzSDdkUDFWd3hSaUJG?=
 =?utf-8?B?dCt3eHE2amRvUHNiNDJ6UjBkYVhrUm5HZUlxOEJZTzdKL0NFbEJLRVJrUDdz?=
 =?utf-8?B?N2JQZXhFY05Sc0tpSFRSekF5TVRSSHY2RmdJRFQ0S1R3SXlnb2Ziem5ma2No?=
 =?utf-8?Q?p76l0nI+ecGdlR9lRz5KpGEclBorJNrQX97vd7R2NNQW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43275634600F2444BB9E2D28C86FCA63@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd06a806-2f97-406d-dade-08db411afd87
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 21:13:58.1038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wieVuNMjyOTMqBddqUZsXcsYSsfawQ36CbOBj4Z49tiu3CUqYjRar7x1R5IiwKcIfwD+TpEYebEtSujCRwfnlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
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

T24gNC8xOS8yMyAwNjoxNSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4NCj4+Pj4+IFdoaWxlIHRl
c3RpbmcgdGhlIGZjIHRyYW5zcG9ydCBJIGdvdCBhIGJpdCB0aXJlZCBvZiB3YWl0IGZvciB0aGUg
DQo+Pj4+PiBJL08gam9icyB0bw0KPj4+Pj4gZmluaXNoLiBUaHVzIGhlcmUgc29tZSBydW50aW1l
IG9wdGltaXphdGlvbi4NCj4+Pj4+DQo+Pj4+PiBXaXRoIGEgc21hbGwvc2xvdyBWTSBJIGdvdCBm
b2xsb3dpbmcgdmFsdWVzOg0KPj4+Pj4NCj4+Pj4+IHdpdGggJ29wdGltaXphdGlvbnMnDQo+Pj4+
PiDCoMKgwqDCoCBsb29wOg0KPj4+Pj4gwqDCoMKgwqDCoMKgIHJlYWzCoMKgwqAgNG00My45ODFz
DQo+Pj4+PiDCoMKgwqDCoMKgwqAgdXNlcsKgwqDCoCAwbTE3Ljc1NHMNCj4+Pj4+IMKgwqDCoMKg
wqDCoCBzeXPCoMKgwqDCoCAybTYuMjQ5cw0KPj4+DQo+Pj4gSG93IGNvbWUgbG9vcCBpcyBkb3Vi
bGluZyB0aGUgdGltZSB3aXRoIHRoaXMgcGF0Y2g/DQo+Pj4gcmF0aW8gaXMgbm90IHRoZSBzYW1l
IGJlZm9yZSBhbmQgYWZ0ZXIuDQo+Pg0KPj4gZmlyc3QgcnVuIHdhcyB3aXRoIGxvb3AsIHNlY29u
ZCBvbmUgd2l0aCByZG1hOg0KPj4NCj4+IG52bWUvMDAyIChjcmVhdGUgbWFueSBzdWJzeXN0ZW1z
IGFuZCB0ZXN0IGRpc2NvdmVyeSkgW25vdCBydW5dDQo+PiDCoMKgwqDCoCBydW50aW1lwqAgODIu
MDg5c8KgIC4uLg0KPj4gwqDCoMKgwqAgbnZtZV90cnR5cGU9cmRtYSBpcyBub3Qgc3VwcG9ydGVk
IGluIHRoaXMgdGVzdA0KPj4NCj4+IG52bWUvMDE2IChjcmVhdGUvZGVsZXRlIG1hbnkgTlZNZU9G
IGJsb2NrIGRldmljZS1iYWNrZWQgbnMgYW5kIHRlc3QgDQo+PiBkaXNjb3ZlcnkpIFtub3QgcnVu
XQ0KPj4gwqDCoMKgwqAgcnVudGltZcKgIDM5Ljk0OHPCoCAuLi4NCj4+IMKgwqDCoMKgIG52bWVf
dHJ0eXBlPXJkbWEgaXMgbm90IHN1cHBvcnRlZCBpbiB0aGlzIHRlc3QNCj4+IG52bWUvMDE3IChj
cmVhdGUvZGVsZXRlIG1hbnkgZmlsZS1ucyBhbmQgdGVzdCBkaXNjb3ZlcnkpIFtub3QgcnVuXQ0K
Pj4gwqDCoMKgwqAgcnVudGltZcKgIDQwLjIzN3PCoCAuLi4NCj4+DQo+PiBudm1lLzA0NyAodGVz
dCBkaWZmZXJlbnQgcXVldWUgdHlwZXMgZm9yIGZhYnJpYyB0cmFuc3BvcnRzKSBbcGFzc2VkXQ0K
Pj4gwqDCoMKgwqAgcnVudGltZcKgwqDCoCAuLi7CoCAxMy41ODBzDQo+PiBudm1lLzA0OCAoVGVz
dCBxdWV1ZSBjb3VudCBjaGFuZ2VzIG9uIHJlY29ubmVjdCkgW3Bhc3NlZF0NCj4+IMKgwqDCoMKg
IHJ1bnRpbWXCoMKgwqAgLi4uwqAgNi4yODdzDQo+Pg0KPj4gODIgKyA0MCArIDQwIC0gMTQgLSA2
ID0gMTQyLiBTbyBsb29wIHJ1bnMgYWRkaXRpb25hbCB0ZXN0cy4gSG1tLCANCj4+IHRob3VnaCBt
eQ0KPj4gb3B0aW1pemF0aW9uIGRpZG4ndCB3b3JrIHRoZXJlLi4uDQo+DQo+IEhvdyBjb21lIGxv
b3AgaXMgNG0rIHdoaWxlIHRoZSBvdGhlcnMgYXJlIDJtKyB3aGVuIGJlZm9yZSBhbGwNCj4gd2Vy
ZSB0aGUgc2FtZSB0aW1lZnJhbWUgbW9yZSBvciBsZXNzPw0KPg0KPj4NCj4+Pj4gVGhvc2Ugam9i
cyBhcmUgbWVhbnQgdG8gYmUgcnVuIGZvciBhdCBsZWFzdCAxRyB0byBlc3RhYmxpc2gNCj4+Pj4g
Y29uZmlkZW5jZSBvbiB0aGUgZGF0YSBzZXQgYW5kIHRoZSBzeXN0ZW0gdW5kZXIgdGVzdCBzaW5j
ZSBTU0RzDQo+Pj4+IGFyZSBpbiBUQnMgbm93YWRheXMgYW5kIHdlIGRvbid0IGV2ZW4gZ2V0IGFu
eXdoZXJlIGNsb3NlIHRvIHRoYXQsDQo+Pj4+IHdpdGggeW91ciBzdWdnZXN0aW9uIHdlIGFyZSBn
b2luZyBldmVuIGxvd2VyIC4uLg0KPj4+DQo+Pj4gV2hlcmUgZG9lcyB0aGUgMUcgYm91bmRhcnkg
Y29taW5nIGZyb20/DQo+Pg0KPj4gTm8gaWRlYSwgaXQganVzdCB0aGUgZXhpc3RpbmcgaGFyZCBj
b2RlZCB2YWx1ZXMuIEkgZ3Vlc3MgaXQgbWlnaHQgYmUgDQo+PiBmcm9tDQo+PiBlZmEwNmZjZjNj
ODMgKCJsb29wOiB0ZXN0IHBhcnRpdGlvbiBzY2FubmluZyIpIHdoaWNoIHdhcyB0aGUgZmlyc3Qg
DQo+PiByZWFsIHRlc3QNCj4+IGNhc2UgKGFjY29yZGluZyB0aGUgbG9ncykuDQo+DQo+IFdhcyBh
c2tpbmcgQ2hhaXRhbnlhIHdoeSBpcyAxRyBjb25zaWRlcmVkIHN1ZmZpY2llbnQgdnMuIG90aGVy
IHNpemVzPw0KPiBXaHkgbm90IDEwRz8gV2h5IG5vdCAxMDBNPw0KDQpTZWUgdGhlIGVhcmxpZXIg
cmVzcG9uc2UgLi4uDQoNCi1jaw0KDQoNCg==
