Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AAB5E9492
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiIYRB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiIYRBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:01:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDE82C64C;
        Sun, 25 Sep 2022 10:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXFb+vRFTdSuuEJC2Ky3k0juQL4Anoer9qq11eqsPN0SYq6N2+kshBnidYmIFJGrp7HNv74o8ViW3woH54iQ1exHfK9r7P6lLxMKnvn6JYHJNwwJyub7z2LKqSBCvpxi747olbTxbS4X0zAN83Xlu7bkYg2RydEOEHWeLlST6vl+5cLohDgHgT+rAOH7Xb9X6fdrQrqddYrAdEWXPgkVK3GT4+Ko7MX75ZvitCdIS5Bu807hl7j3XGMVcezp+4YC3B9E1WJejQCLZ4dGcvhdsez823E7HG39VCf8G39tF+WtvM+9yzFcmEZwMivSmsDrxKCvX4wjz6dFEfy9soC3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKllqMxlocnpKAvYkGA7lNcZINOxHG3Cu/LA6qDp1w8=;
 b=E6XBz8HkVULHhwq82Ho8vMTr1qBwX5UC9pFYjojncmJorMy8Z8dEBL/+wdN2LmPcVIqaYgcCt0c8yK4P29cvL0bDZNQgng8Z40mQD0hvE4/LcLraiv3vsyGp/bwGizkKFLFRjDrC6RfUOxJNUZFoWRkFqa+wEYkjmKR4DShQhnwQ2QUgZuGY2yjVpbiBcc/Yi9wfBjVgO5f45jhBlxovmqUw8TI5KzH7AWHWjaSH/dUN0SagkhinR9NvTBkWWzFgceo6WvAPQDYzuqsprKwf0We+IPLGQvDd+4cxNwrxfmZbS3kSXd+9WJbK7nety1IFNKmr1BRZSkaij1vGhMs5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKllqMxlocnpKAvYkGA7lNcZINOxHG3Cu/LA6qDp1w8=;
 b=AU8MfqlysaeY2gcmCykGxTmiqgVjnAYgoCoj1s9lV9oCBNj6psFN7xe7spPfL9L3HYldUQiEeE9TnWdYO915Yk62y17/MVLLdEbPnlkr9PZslEGetfCyV5nhuB3Pa6mAtXbK3+2fFwbzRiDMYV5AdDOa8CZQhVKegcCf1BqE7Bk=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 17:01:20 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128%6]) with mapi id 15.20.5654.024; Sun, 25 Sep 2022
 17:01:20 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/7] cpufreq: amd_pstate: add AMD pstate EPP support for
 shared memory type processor
Thread-Topic: [PATCH 4/7] cpufreq: amd_pstate: add AMD pstate EPP support for
 shared memory type processor
Thread-Index: AQHYxGvRM+wjOHeEFkmAjJvH2VLI6K3XcdyAgBkFtuA=
Date:   Sun, 25 Sep 2022 17:01:19 +0000
Message-ID: <DM4PR12MB5278AD9B67F0C30B55D249439C539@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-5-Perry.Yuan@amd.com>
 <82b3b47a-c6f6-5d06-d1d5-3a1c132d80da@amd.com>
In-Reply-To: <82b3b47a-c6f6-5d06-d1d5-3a1c132d80da@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-25T17:01:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=89d09477-4be3-4ed3-a7d0-d88bb8327d52;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-25T17:01:15Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1901a8c7-f67c-4ddb-ab3b-5b01ed2fa5dd
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY8PR12MB7100:EE_
x-ms-office365-filtering-correlation-id: 15c7eab7-d9cc-47c1-9892-08da9f179175
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ugLdLGUVjpM1WgBzgqG9Z/LyYBtQRrYQVjx7AB8Z/j9bthNPWGaNfZnuAoPnlsyI7EpduEQHGUhDui29ogUkEvJuh3RILhEMe7uXffTnw4O1CFU3tQKbqFgPUm501T4AFJLnH44Yw4P1AGOurk1EEnluRKkgJm0zPQTUK1P6y4OwFdazlquZtex9+v952T2t0gSdX51iP0xToPHXPhfwtrpI9dyU4ioSXXDU0FSFJ+1/YeJO2I0k3XHsuGiZUBzMp3wb9rgZH6/gKuosVhk10yOO2mEgcdsPn6dN4ADHvIH8iWgtt1NzmGTb0244c5z6o67EIz3PGMaSJsPWexP+7U8oAezGXlKgD2tB43Bzus3/D6grfgY1kwCSz2lSjxMaLp05WGYoeYTlohqyqdjux2JDNvs2hp+6u+/BEjPW4FFbAyce5SqbuJj3N9gcG/6YoxUzzs0yTPg3fko+JLwO13eUEtcKnmwOU2PVKwxJI8s8V0Ae4fu5TU4X0K7Swvln0Lu0zent+OoWdSa0vPc8QkYVik4ztpKMWdDH8ME+wobHT5kjtetxRhI4CGWKg/9HBKVqF8wEt8oh16amC3dyjLs3zFl2XD50zraBt2yvvHBnos8SBTkyIdQks/7pKdhhoKz5NBYcMMOqCyIUXrvHFJlkHfiqkX0avOHJhnYreu8fjiiHTDLnir2ntkAgOcxCe4U4forac73mi7d5gFgta08YjpCb3IFVpz6iq1eyLROeMe6bFdbY0BqV//kL6N1NzPIaKN7Wk/WVW0IuZnsqmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(110136005)(54906003)(316002)(38070700005)(5660300002)(55016003)(52536014)(8936002)(33656002)(66556008)(86362001)(66446008)(64756008)(8676002)(66946007)(66476007)(76116006)(41300700001)(2906002)(4326008)(9686003)(26005)(71200400001)(186003)(478600001)(6506007)(7696005)(53546011)(38100700002)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXIwWHkxUUcxSVFoNTEzRlhGT0tyTXJCWlloVmFKQndoOFVZNGlBVjVpbGJY?=
 =?utf-8?B?RUw0cXM5bTdpdEZIazZxZWh3UEordm9MZUoxZSs2T3Ntd3JiM1lQWGJIb0JR?=
 =?utf-8?B?T3RGYzIvVzNHTHczVFNlZkZscDAyckN6WmlVQi9UamdkaklJNmwwbVJUVjNp?=
 =?utf-8?B?YWFtcS9KTUZTNjBLNmw0VkI4SHFzalR0cHJzZGR2ejNJNDZQRFlGQ093Zko3?=
 =?utf-8?B?Zy9XVFRGRyszM2grTUdQRTRFUHd3WnFpOG5wWkUvOTBrVEZtUU1YbXdnNjJQ?=
 =?utf-8?B?U2NsaENvS3dMT3I4OEY0aFE5TGFrdjZJd210VTY0WHhDcHRuMm5hQSsvb3k4?=
 =?utf-8?B?STZmVjcrOTc3YlU2K1JlcG0xWDJXK2RzMStvcjVWTi8ydVhyb2tlcDBOcERs?=
 =?utf-8?B?NmNkbGFBRkpRaDlIbmtnSVhvTWtMeEIrM3hSYkRjRnFaditVM2JRUkYvaHhp?=
 =?utf-8?B?ZFFKdTV2T1NCOVd3NHY2QzM2dTRaTkhaM3g1UWk4Qzl3NWMzcElTVWRGMFVs?=
 =?utf-8?B?Um1ESmg3UHFrTjJGd0hmdXVoamI0MFpoTkkzaFpHVW1hTzZaZnBJUkJ0Z2ZN?=
 =?utf-8?B?aC84THFFelNLS1lhWlJJQll5SzBDRG53WXQyd0tUaFFiWDBneXNRN0p6TW90?=
 =?utf-8?B?SVhMTSttWEJCQ3BoQ0poc0xjWWN2RzhxYW9nTHdwWEd3VUFCRVU5RlBTVmdy?=
 =?utf-8?B?TnBubFIrMTRhSjh5MkZ2Vngyb21BSkFUUFB4U2J0aXcvZ0VjZWVYWVAxZUZJ?=
 =?utf-8?B?TmVlV3RXZ09aaW9EODdzVXVyYzJnQWg5cGxXYTg1YVdVeGtVNHVzTG0vN1JZ?=
 =?utf-8?B?cklzakFDemllNmlNQWhvSWlQUEY1QlhyNGF1ckt1bStyL3N1MU9XZmRyN1lu?=
 =?utf-8?B?V3JUOEwvVjZDQTYwemswNjlCUGo2eFBEZHk1RUEzQzQrRWdjN3RQQjdHTjZ5?=
 =?utf-8?B?QjIva0srZkhRSDJ0TjVMenkxbzhpakhIeUZZYzN1cWsrN3BOdGppVGNVbTJr?=
 =?utf-8?B?Yjd1eHUrV0ZzbVpVZmZMWVRQQ1p0WEdaRlR4M3hYRlBXYTFNejhCN05JbHBW?=
 =?utf-8?B?ZTFMQ1RaeXRMRlE2eWFsejE2ZzQveGNYeU5QZ21MNkxyT2tMMUVjQkhKNkNr?=
 =?utf-8?B?QStOd1BxdVBybWVDTVZ2UytkNGIrWi9iQVFiZjgrc3lZbGc3V2ltSEk1QkVC?=
 =?utf-8?B?WTJ6S2V2YlRmNzN2NzY5aHpWcWo2K3dtekpTRzBLakhDQ2lMUFpxbkFsOFFp?=
 =?utf-8?B?b1ZyR24xM25reGZYblg2NjAxM3ZRUEFvTms3Rmphb0llK3NJN21DTFQzeGZ2?=
 =?utf-8?B?ekV2Z3liNzVEdStUK01HZlBOUTJ0NWZsNzlyeXUvQlpnNU5IY0ZnMWxXQjdk?=
 =?utf-8?B?aVg4N3RSeHVFWkdtUE1FOFZyUXRnajM0SkRkZkpMaGswMnBnQ2JYcW5QTmRH?=
 =?utf-8?B?QnorckZzWm1LMHlzWGhYeUVkY083MDQxaFJhbUI3RGIycVdzaDBocWFteGEr?=
 =?utf-8?B?UElPejVUSG0zVk1SVGR5L0w5b1J5Zm5FeWhhOXRWSk1lVkdvYTZENExmbUd6?=
 =?utf-8?B?SXVKQnV1aTEwbit4dzVYR2wzSUtyUk84dHF1S0c1WnhscDRySlVtUW9EejVS?=
 =?utf-8?B?Z1FJZDRoZU1acDNEbTM3SnFvYW5UYjZDM1RIRnlZWnh3dmR6T1ZTTVFITXBS?=
 =?utf-8?B?bnliMkV0NHJGUitGUXJTVWY4dVFoUE0rOThtVmwyUTVhNjlSVENqVGZOd1VG?=
 =?utf-8?B?akxnQU5lYVZ6bVFla0NGQk9kUWxWMHY5VWoxM1NYVDZKb0NoYUVTd1IxREw0?=
 =?utf-8?B?Q0l0a2tXa3ZJempTbUNMR0VyMjNGYUM3WEJKZmpSeEc5WXZNRWJtbHZxQnlh?=
 =?utf-8?B?TGlRZG5kK1hpbVRJTTZGTmRyby8vdHF5cjZVdVA0dkt0bGsyUC9OUndwUUs1?=
 =?utf-8?B?TTZRMm01TXZUUDhwUlFoeGV1b2lxaW1tYUZGdklnNmxxRDRGU3pPb2NnKzMr?=
 =?utf-8?B?WTY3MTYrQzBTc2p6NFM3KzQ3V3NzZGltQU1Edm9YYlhKNjZpWmV1WVU3L3VI?=
 =?utf-8?B?eUdIeHNNYTVOUU5nVXNzVGZicEVBZ2tTN2VCcnVuZjFUck9wcjFLM1lrRGZt?=
 =?utf-8?Q?ZUo09hJqtsu1O9fXoO9mY+vhX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c7eab7-d9cc-47c1-9892-08da9f179175
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2022 17:01:19.9501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgQt9C7oDr49XYujxh6EvhUjLpqjS0hEFLvCrryyai95KMiFVHsmSJVwlHpksQhdfHeh54v78XM/OBKfCO6ofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhJIE1hcmlvLg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIFNlcHRlbWJlciAxMCwgMjAy
MiAyOjUzIEFNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVs
Lmoud3lzb2NraUBpbnRlbC5jb207IEh1YW5nLA0KPiBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsg
dmlyZXNoLmt1bWFyQGxpbmFyby5vcmcNCj4gQ2M6IFNoYXJtYSwgRGVlcGFrIDxEZWVwYWsuU2hh
cm1hQGFtZC5jb20+OyBGb250ZW5vdCwgTmF0aGFuDQo+IDxOYXRoYW4uRm9udGVub3RAYW1kLmNv
bT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFN1
LCBKaW56aG91IChKb2UpIDxKaW56aG91LlN1QGFtZC5jb20+Ow0KPiBIdWFuZywgU2hpbW1lciA8
U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuDQo+IDxYaWFvamlhbi5EdUBhbWQu
Y29tPjsgTWVuZywgTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtDQo+IHBt
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDQvN10gY3B1ZnJlcTogYW1kX3BzdGF0ZTogYWRkIEFNRCBwc3RhdGUgRVBQ
IHN1cHBvcnQNCj4gZm9yIHNoYXJlZCBtZW1vcnkgdHlwZSBwcm9jZXNzb3INCj4gDQo+IE9uIDkv
OS8yMDIyIDExOjQ1LCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+IEFkZCBFbmVyZ3kgUGVyZm9ybWFu
Y2UgUHJlZmVyZW5jZSBzdXBwb3J0IGZvciBBTUQgU09DcyB3aGljaCBvbmx5DQo+ID4gc3VwcG9y
dCB0aGUgc2hhcmVkIG1lbW9yeSBpbnRlcmZhY2UgdGhhdCBpbXBsZW1lbnRlZCBvbiBaZW4yIGFu
ZCBaZW4zDQo+ID4gcHJvY2Vzc29ycywgYmVjYXVzZSB0aGlzIHR5cGUgQ1BVIGhhcyBubyBNU1Ig
c3VwcG9ydGVkLCBpdCB3aWxsIHVzZQ0KPiA+IEFDUEkgUENDIGNoYW5uZWwgdG8gZW5hYmxlIEVQ
UCBhbmQgcmVzZXQgZGVzaXJlZCBwZXJmIHRvIGJlIHplcm8uDQo+IA0KPiBUaGlzIHJlYWRzIGxp
a2UgYWxsIFplbjIgYW5kIFplbjMgcHJvY2Vzc29ycyBkb24ndCBoYXZlIHRoZSBNU1IsIGJ1dCB0
aGF0J3MNCj4gbm90IHRydWUuIEhvdyBhYm91dDoNCj4gDQo+ICJBZGQgRW5lcmd5IFBlcmZvcm1h
bmNlIFByZWZlcmVuY2Ugc3VwcG9ydCBmb3IgQU1EIFNPQ3Mgd2hpY2ggZG8gbm90DQo+IGNvbnRh
aW4gYSBkZXNpZ25hdGVkIE1TUiBmb3IgQ1BQQyBzdXBwb3J0LiBBIHNoYXJlZCBtZW1vcnkgaW50
ZXJmYWNlIGlzDQo+IHVzZWQgZm9yIENQUEMgb24gdGhlc2UgU09DcyBhbmQgdGhlIEFDUEkgUEND
IGNoYW5uZWwgaXMgdXNlZCB0byBlbmFibGUgRVBQDQo+IGFuZCByZXNldCB0aGUgZGVzaXJlZCBw
ZXJmb3JtYW5jZS4iDQo+IA0KDQpUaGlzIGlzIG1vcmUgY29ycmVjdGx5IHRvIGRlc2NyaWJlIHRo
ZSBkZXRhaWwsIHRha2UgdGhpcyBpbnRvIFYyLg0KVGhhbmsgeW91ICENCg0KUGVycnkuICANCg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyB8IDEyICsrKysrKysr
KysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJzL2Nw
dWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IDQ1MTI5NTI4NGEyNi4uZmZmMjk4NzQ0YThlIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiArKysgYi9kcml2
ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gQEAgLTEzMywxMiArMTMzLDI0IEBAIHN0YXRp
YyBpbmxpbmUgaW50IHBzdGF0ZV9lbmFibGUoYm9vbCBlbmFibGUpDQo+ID4NCj4gPiAgIHN0YXRp
YyBpbnQgY3BwY19lbmFibGUoYm9vbCBlbmFibGUpDQo+ID4gICB7DQo+ID4gKwlzdHJ1Y3QgY3Bw
Y19wZXJmX2N0cmxzIHBlcmZfY3RybHM7DQo+ID4gICAJaW50IGNwdSwgcmV0ID0gMDsNCj4gPg0K
PiA+ICAgCWZvcl9lYWNoX3ByZXNlbnRfY3B1KGNwdSkgew0KPiA+ICAgCQlyZXQgPSBjcHBjX3Nl
dF9lbmFibGUoY3B1LCBlbmFibGUpOw0KPiA+ICAgCQlpZiAocmV0KQ0KPiA+ICAgCQkJcmV0dXJu
IHJldDsNCj4gPiArDQo+ID4gKwkvKiBFbmFibGUgYWN0aXZlIG1vZGUgZm9yIEVQUCAqLw0KPiA+
ICsJcmV0ID0gY3BwY19zZXRfYXV0b19lcHAoY3B1LCBlbmFibGUpOw0KPiA+ICsJaWYgKHJldCkN
Cj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCS8qIFNldCB6ZXJvIHRvIGRlc2lyZWQg
cGVyZiB0byBlbmFibGUgRVBQIGNvbnRyb2wqLw0KPiA+ICsJcGVyZl9jdHJscy5kZXNpcmVkX3Bl
cmYgPSAwOw0KPiA+ICsJcmV0ID0gY3BwY19zZXRfcGVyZihjcHUsICZwZXJmX2N0cmxzKTsNCj4g
PiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiAgIAl9DQo+ID4NCj4gPiAgIAly
ZXR1cm4gcmV0Ow0K
