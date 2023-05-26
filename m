Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CFD7127C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243768AbjEZNtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjEZNtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:49:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923F1F3;
        Fri, 26 May 2023 06:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXymL83188bPk0zDsAJJSCnz/quRPzdhmXYXF64EYqHLHbig9zuiTMicBB7gqJ3KyOx9oFwtWU4iSrI533irTdtC0HEXKRXhCqW7coWhwosLezkL2tZXRpyQcGwUWZ9B12LiT8qXSPYOHw0bVPKKM9dL42iEHPvdvNa6N6anPbHWFpzzG5Pk985qUW/aM2Ggh66X//MLn5tpv37sZDjuNvV7CkeyE9bdU6m/XE1ksNwbZ+Zq01Hez5i6MMZ3siv7GyQUDmfz5rF8fiXEKgsMq/yfirr7rHE1oL2HVy09EUmfrZnXFv7Gx2Eh5cKuzk7kCrxwx3lF9RerSKt4rskDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtChwFcpoGwvVdvgchBaPhj7vHO2fFmgevs5wGpwD98=;
 b=M/4pE3etSfv/ESdgRMgUt6z/MQsAu7F+ikINP1vDUxp4Yp7MWhkXljUx7o4B8v1W2RWi+rHOd/iBDp/WYKTUYgyN1DB983DDSZDAH3uE14iUt6sFb2KuF4CqmF5IvTT8/O0Z9vp/eBumzGCAXYC5R/yrk+CwY9Sfjx+13rY5JqtF1MVSF75He9a7XfpU8+nZ/Oz0LT3aeHVRiS9/o1OIzRGar0yjHDkWPA0MmnyXlvulgXygfGhjxVKXl0FW7uJkMvQd7TCiGVazA/8V+oelX2Huu6hVZzUOcMrnUOmaOhlTEPTDO3U1L12EPxxxedfUTBOy3DvhGkhxr6AOQRWT2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtChwFcpoGwvVdvgchBaPhj7vHO2fFmgevs5wGpwD98=;
 b=baMTGY7RIWlgVJ3WC8IvPkOZAkA7zalbCc/cpg/FyLqNuqjNX0CBa0fOr28nxO5AJ7USZ1XoyEDe2ip8RIaBPOeF39Qk8e0gZOdotogKumUNP/W2ajNfVMg2eueGwQKCBuMecQEo+UTFUAPi7FhNayCa676HAr2uEz2TeUpa53s6HlXmC4z9W+RibuQxWcDZa7AwyYMF0bi0Pk1sG2HWnJBklE3v2XMiLHCS5dtnV6c7O2nc044Ee8yzq5dk9h5W6XBM2gpEIKfGQmyGIFaQxJ04V/pWeTURJwscimZxbt1oFpvTxpH685U8o5kdPw7w59Iz9G+DBIiTV+kP/P6VVQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Fri, 26 May 2023 13:48:58 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::cd75:4dca:813a:cf72]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::cd75:4dca:813a:cf72%2]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 13:48:58 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] gpio: mlxbf3: Add gpio driver support
Thread-Topic: [PATCH v6 1/2] gpio: mlxbf3: Add gpio driver support
Thread-Index: AQHZV4g0mf0KnjGDfkCNFmKuBrQRha7+8BeAgG4Ro3A=
Date:   Fri, 26 May 2023 13:48:57 +0000
Message-ID: <CH2PR12MB3895BDF9D79D61420A2F2BA8D7479@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230315215027.30685-1-asmaa@nvidia.com>
 <20230315215027.30685-2-asmaa@nvidia.com>
 <CAHp75VfnNOsfcyLM-UP61CMAF9sLOwMbRkAe5Ljhs2p8F=4Pgw@mail.gmail.com>
In-Reply-To: <CAHp75VfnNOsfcyLM-UP61CMAF9sLOwMbRkAe5Ljhs2p8F=4Pgw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|DM4PR12MB5745:EE_
x-ms-office365-filtering-correlation-id: b92bca7d-3ed5-43fd-b099-08db5deff44c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XJp8woqMWeGBOp7gQQ57Bb7eer9vW7WuqWF+qAe/RT4pr7Z/fA7lg4LJd/nln49QL3M04k88XPg3mk2aT0iPiqxgTk9nCLOhQcPhuMwxuThF0qiRV+rFSpAp3cj4nGWlaOZpG6XRgX1S4ZfzAK/IWJwOrrGno24IgHHcAr36AbZdbdQKSTFZ1wqqbGMSzrWMZZSI/MBVFtUXwwdEFoMEtjcCxKd4s6J/+bscTMs/ygKLBqcTW4jM9BdHKHfEELklvL6O768j4nVESg19ZOL0S7F2wu0l5LDZSEvONK0ytpZmAJXY/PxYic2pHkYHT6l0ZAHXGFiFbasKzOYYI5C9X2mL88A5kSyTuTlMN/uJl6lQ18mT5GP+UNzbU76XSn7huFExEfkgwbvDJg0s+Rj1S7kIXI5X18iqGE1kf0PL7uOFmmAzJZtZ+C/Q9GpZfam3JEpqBgWe5C5ZMz3wF//emRb+ennrMsFMrLwRXVWVHFq2q6C2YfZPhzIBInrUelhpaLZc/iCgoKt/pWuH99/+TbgQB2QTY2b3n/d2Os0he0Fw6WGd8KohpXBfpidf7LvlYW41u7uLyAXF8oJRPI8Z9fVyMeQTvK5LoMIEhzzFG50=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(2906002)(66476007)(66556008)(76116006)(4326008)(64756008)(66446008)(52536014)(4744005)(5660300002)(41300700001)(66946007)(316002)(54906003)(110136005)(8936002)(8676002)(71200400001)(478600001)(7696005)(55016003)(9686003)(26005)(6506007)(186003)(53546011)(83380400001)(33656002)(86362001)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2pOZDFJYVZBVEpNSDZMQnFrMkVGUm02eGZaTlFGN1ZROW5iOHJUb2hkbUhG?=
 =?utf-8?B?aHVWSUx2K1RCVnhXdVo3dFpRTjl5cFNqQklia0EvZkR2UHgwdUF2SHhSNU1N?=
 =?utf-8?B?RUpGdWhIWkhHbVJheFFjUE4vY1U2TzRRQlVYazkyV1Q3eXh2ckNhMzNOdWdM?=
 =?utf-8?B?NGNCdy9hdHM2ZUFnaFJXOVhpTU1iRnlJS0VBTmxhYzdCUHJzek1OaTZKcWQy?=
 =?utf-8?B?RnE2d2dicEFwbHJ3WFBRZnZFSUhZSEliWWpub2sxVHpOQXJma2wyM0Q2Wkds?=
 =?utf-8?B?bjNlSHYvcUZTODhsTjNxWmhhUEZyMm9EdVFzR3d1eGlFdytyYlJaVy9ML1V3?=
 =?utf-8?B?K1ZEYlpoVlQraU52M2ZEUHNyWFNLb0dDYVh3V0JFT25ScEpPOXEvcmx0YllI?=
 =?utf-8?B?M0hua2tTNkNqK2lyTTdzcG1iVkIxNG9iSzdwazAxMXQ1Kzk1cnhKN0dNeWda?=
 =?utf-8?B?am8zOXRJazA0bjZ4b3RwK21UeXIyT2VFcDlXSnU0dTF0czZvWkRBSGNVZGlK?=
 =?utf-8?B?ZTJpcUhwcWVDd2NNVkdXT1RXTTlEVDVjcnIvOU1LVmRXSXlvY0x3TVBDQTRM?=
 =?utf-8?B?VkNTQXByQS9ZSXRCNHR3VVN3KzZTZHdUemlHM0NqdDdQZ3loTUtVV1B4MHV0?=
 =?utf-8?B?UWhCTzhpU2lPdS8vVlNRcEw4WW5lVGg3OTZGbGtqVnlkQTlOa08yQUFJVzI3?=
 =?utf-8?B?aW04Y3RLQXdqNWlSbTR6SzhrQWljNmJRcG82RlpFVkJFUXlrZEZCaWF0eE4v?=
 =?utf-8?B?R2tIVlJCU1ErMWRVa1RVRGJhV3pRMjlzUTlxeVI2VEVTSEhnMXlqR0lLeDd5?=
 =?utf-8?B?cC94em1SYkhuZUFJRWZGb2NaZndVL1ljb2FURE9Valhtc2JOVEtVWVhyTkRh?=
 =?utf-8?B?ZGpqczdyNkUvQ09iR2Qyd3hiaVVpcHp0U1cwbjNtY0ROYWhyaFc0SkFsZW9S?=
 =?utf-8?B?b2J1QWpBM0NBOStoNkJQajh2aXQ3a3M4aVBhRDhoeHB2bTYrQmo0dTVCdjVw?=
 =?utf-8?B?VmI4T3lybGp6MW8zNmFJNjBwaVpWQ3hLZU93cWVLVW9PVkFFNHNyblJHNjFv?=
 =?utf-8?B?WnJUTkp3SlFvbE1uSkpQVkpiaHJKcVdqTEFzUG1LU1M5N0FtbEtYTzcwcXRo?=
 =?utf-8?B?cXM4S005Q1BsTE9HWk4xT3d3SUl1U2c0UEczeE94TmlwWVlvTkp0Mzl5SFdH?=
 =?utf-8?B?bDJnbFF0RDVhZ1NLenJCeVdrZm5FdHlPS0hBc1RxMVgzZS9ONm9sQkhHTmJz?=
 =?utf-8?B?ZFg2WGlFeHZ3eitvSk5qNkQvVkdBZ01VRnJsaVdGYkFIRFl1UUpVUXNLMnZh?=
 =?utf-8?B?ekw1WWxCTW80SjhsbXdwbXZqV25vK3hQT2dlLzQxeXduL2JFRFV2QnNOWlRy?=
 =?utf-8?B?SE9CQU5ISGkxVEMzUkNlT0VFOHdNckZhalg2N01TNjlMc2l4WHdFVFVoSER5?=
 =?utf-8?B?WnBURlY0dTkvclorSXBrK0FBS1hUb1plOEMvcDJEWUhZUzgxTHd5SVE3Uld2?=
 =?utf-8?B?anJ2cmJGOGhrMVA2NTExOUFYblJ5WUpNL3FZZzZBazZpcXR6TzloQkhocS9W?=
 =?utf-8?B?U0VFQ2ZnUnFVQjNYUGhPckhmMzNKTG9JMzFpTVBzQ2I4UGgwelNBVDdsZU91?=
 =?utf-8?B?bytwbEZ1MEIyK3l3aDVYRW1TbHN1TlpkcUFPamEyTVFJUndjc3JYNG5QM1Iy?=
 =?utf-8?B?bTcrTTdseUd4cS9EV2RHb1UxNzJhNUJTdGxCOTdnOEJVdXp1d2J4R1RiS3U0?=
 =?utf-8?B?eEczSkVqNTNlL1huR0tneDA2QmdIVTZ1Z3czZmNoZ0tJZ1UvUUFsWXRETTZD?=
 =?utf-8?B?YVZlYUlvYUJZNkFFSjYzUEZjcTRXWlZMSk5qbTd4MUo2OGZJSjZzYzVlSndM?=
 =?utf-8?B?MlE3UUdUVEZ3NjlyNnphS2JsU0dGc2Ntb2lOejFJUERUQkFoYllCa0FsajFs?=
 =?utf-8?B?Nlg1cTdEZTJWZGJTVnpsNkdMTEpYcGVrUEhYeHZPQy9jTlpiNk1ocDFoTEgv?=
 =?utf-8?B?RzFWeWNRZGFZejZITDBSODdiOEtIQzRyQWdoS1ZyR1VTTUZ1Y1ErcjU2U0Ru?=
 =?utf-8?B?OVI0RzJUZHF0ZjBmVFhvMkYyWXJYcTBjVUtsaGpPS3I2Zkkwam9BbnJhZGNl?=
 =?utf-8?Q?kogs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92bca7d-3ed5-43fd-b099-08db5deff44c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 13:48:57.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PklnLHMeRE1nZM+ADzi6kJSEo/yxk2uy3aBMI0tfp498RU4l5AWbtoxR6tb3HppyoR+dvb9ErQEeBYSJa6JYiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwgSGkgTGludXMsDQoNCkkgc2VlIHRoYXQgdGhlIHBpbmN0bC1tbHhiZjMuYyBpcyBp
biB2Ni40IGtlcm5lbCBidXQgSSBhbSBub3Qgc2VlaW5nIGdwaW8tbWx4YmYzLmMsIG5vdCBldmVu
IGluIExpbnV4IG5leHQuIERvIHlvdSBrbm93IHdoZW4gdGhpcyBkcml2ZXIgd2lsbCBiZSBpbnRl
Z3JhdGVkPw0KDQpUaGFua3MuDQpBc21hYQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4g
U2VudDogRnJpZGF5LCBNYXJjaCAxNywgMjAyMyA4OjU0IEFNDQo+IFRvOiBBc21hYSBNbmViaGkg
PGFzbWFhQG52aWRpYS5jb20+DQo+IENjOiBsaW51cy53YWxsZWlqQGxpbmFyby5vcmc7IGJnb2xh
c3pld3NraUBiYXlsaWJyZS5jb207IGxpbnV4LQ0KPiBncGlvQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGFjcGlAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMS8yXSBncGlvOiBtbHhiZjM6IEFkZCBncGlvIGRy
aXZlciBzdXBwb3J0DQo+IEltcG9ydGFuY2U6IEhpZ2gNCj4gDQo+IE9uIFdlZCwgTWFyIDE1LCAy
MDIzIGF0IDExOjUw4oCvUE0gQXNtYWEgTW5lYmhpIDxhc21hYUBudmlkaWEuY29tPg0KPiB3cm90
ZToNCj4gPg0KPiA+IEFkZCBzdXBwb3J0IGZvciB0aGUgQmx1ZUZpZWxkLTMgU29DIEdQSU8gZHJp
dmVyLg0KPiA+IFRoaXMgZHJpdmVyIGNvbmZpZ3VyZXMgYW5kIGhhbmRsZXMgR1BJTyBpbnRlcnJ1
cHRzLiBJdCBhbHNvIGVuYWJsZXMgYQ0KPiA+IHVzZXIgdG8gbWFuaXB1bGF0ZSBjZXJ0YWluIEdQ
SU8gcGlucyB2aWEgbGliZ3Bpb2QgdG9vbHMgb3Igb3RoZXIga2VybmVsDQo+IGRyaXZlcnMuDQo+
ID4gVGhlIHVzYWJsZXMgcGlucyBhcmUgZGVmaW5lZCB2aWEgdGhlICJncGlvLXJlc2VydmVkLXJh
bmdlcyIgcHJvcGVydHkuDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5
LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiANCg0K
