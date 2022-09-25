Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF45E930B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 14:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiIYMXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 08:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIYMXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 08:23:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B919C31DDC;
        Sun, 25 Sep 2022 05:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmxBTxg2NTynKbt7bw1I/w6yFU5Spgem0RL1I5Y1kFMIqVbGuc4TdFi2n9WZG7iPsXj/IpZK1e6RYSHnUB+Vf4q3RB0hlVFzgKWKApfjqIFohbPilRqa/17rtGBS5ftUYfndg1gEqGX3ECZbyYymd+SVUw1Qkjz1cechvOpVNL8M8UNrbRGWRCZn68zkpWUewaamRQYvGTZTbgmRnCUi0z9nVXBnLBx4wFBlspNFAXtGB1+n9gr1xo/1GtXIRQrZle5qu9lLdXTWQl+9oyUULx5gocg8UXk6sVsv6tf6RJNMuFXupqakUKWcn2MbMxrvltS1j92PxYSwxtASea0V3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBp9SGVINoIi9RXnKdawWE87thKZ0STJUPfulcNtm0I=;
 b=jdCwPydkQZQ6m6xqnuhDJ1w21A74Z/1t18qTnOoKG/IR4ZMfZmgZZEzdvTjp5OdvN3XNjayblXZXesqkMRXh1XogbMqQlSOo1liwSBiC4iITugI5xE6WrrkV947NQTg2BKe5blR/9Cd6AhaRBdwHUa7HfJ4Rco+M7umMPCLqjUuZNcuYTLhHa8YMp9gPjmrUXGW8DPjI9YWvOYmCGFycsNRTJMXFIvMW27UdsWfat69Lc9ZGgPkVP3FvgiUq7zrBCOw4YGNH8JSecF2+kf0UGRIErETvsYw0XMuMV/wkeJVY0KM3TrHeQUTn6frrATe36kPZk+0Z+IbLvwCQLZ3akg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBp9SGVINoIi9RXnKdawWE87thKZ0STJUPfulcNtm0I=;
 b=jMtkg9YJSupoFKkuv45Et6ZbUD8Aw4zoG8r2IiQ/533WS/GAcdN6TKEjnxf5DS6Oc5Nqb2wybu3auEcfbCymZkaCF8hPnKOM0NLxLb1wQjSZkFdWERxLL5rjof+6MbAxcgS1LMTtZPv8Icqne/eNUFF0vLz1uqfNwoE7hP4cEhw=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Sun, 25 Sep
 2022 12:23:05 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128%6]) with mapi id 15.20.5654.024; Sun, 25 Sep 2022
 12:23:04 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
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
Thread-Index: AQHYxGvRM+wjOHeEFkmAjJvH2VLI6K3gtk4AgA9wDMA=
Date:   Sun, 25 Sep 2022 12:23:04 +0000
Message-ID: <DM4PR12MB5278639EB4E0FD416653743A9C539@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-5-Perry.Yuan@amd.com>
 <a21bdd7d-3ade-4a54-1a7f-42831ce8e83a@amd.com>
In-Reply-To: <a21bdd7d-3ade-4a54-1a7f-42831ce8e83a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-25T12:22:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=05287267-aed0-4a3b-b1b0-56597a77a654;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-25T12:22:59Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: e170366d-0ebe-49c4-8b5c-8a65e479feb8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|DS7PR12MB5981:EE_
x-ms-office365-filtering-correlation-id: 0fcd2a0a-1e33-48d5-6ed2-08da9ef0b260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BkwkHtsKwMAJBZ/KJMf5Xur3tBDWXzXVzn2nwmwi63+IhU1h+VmkCMbprfqsbZaSDskYngb61Kqf04v7/XCDEUjaWqsBDiVHvJVw6rNU5zUnoIt1UiL9DPXQqENPQLU3KVYODxhJbPhhq+hktK4UTzDf5gO1sj9sY6p29lksQO7RC/8H2+vYaCkuxPFVxv+mlqTN1V3vFxm9PNzUuc2SZi7niJRuCgbHme0H65LOIPuZ4e7FpVOAwTGFjgcAqg96gxd25A/r7o4qxy56h6rZaUo9wQhuF7x/7cXRsCpj8i6jEc2Be/LTJnW3Lfuq1V47HyrZxu6XMNuMD7iZXK7zCjBwvQdO6z7OCT8OIRdDkDTEkZwlJq+o0H2IuEmJijP+O1psh1VfO0Ss9FruRFxmKSr7Lt5y8fYZe7tUGnSwR/jgKhDYY/ekSwlQgGz/RMwf7ZbKDCc0EWy3ryiM2u/cR3e+diW/Ykd3henx6gux7CzI/ZDyC3pat/yD+QcIizX8PU/xGiNmYLjgn1C87q87Fw3V5n0zc7yqPYq4m8oI59oxg1AQIY32UikQXAyO8GJ20DU1qy7ZxUqAHSCCjWXBn5U6DBK2mGteiqZt3ZWzD31cCsWBlk79J4EDThG/LS+MHMg3UBl2hA5KyRuDo/21ONb0h5MQIjJ+52Vf2Nq85etZ3UuvFze0i/iYlp4EhQO0PhsjVeUe9DNX06JBTv0xj8KurUynwjxR5DLn91CzdCNtvlWL6H6WcLdAkNIq3ALRHV2wZ9TAJoqZYmlcHjjjSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(53546011)(6506007)(38070700005)(33656002)(2906002)(7696005)(5660300002)(9686003)(26005)(8936002)(4326008)(66556008)(76116006)(66476007)(122000001)(64756008)(66446008)(66946007)(41300700001)(52536014)(8676002)(86362001)(55016003)(38100700002)(186003)(54906003)(71200400001)(83380400001)(110136005)(316002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXF2U2xwQkYwQkJ5ZXlyRnF0QTAxNDZrQ0p3TnJCZjJVUUdzeXhTSjhjUzFj?=
 =?utf-8?B?TjdqcDRPV3pTblVsbHJ3K3RtcjlSN3IwbE1EZk44T3ZrKzJ3d283SHcvNGx3?=
 =?utf-8?B?SnpUQVBkUHpsZnJwN3dpb2hndkpCN2xRWHoxWWwrUmpyakJzSHBPaGYzL2U3?=
 =?utf-8?B?bjZxemhkVUl1eVVON1ZyQmJwTVVOdU9hbXp0WC9RY2RQTENtZmowME5YNjlx?=
 =?utf-8?B?ckVWenpOWTMrUlRVaUhWNkRSM0lkRjRCTVFJQjQrQk5Bd0I1NjFpZXVISlJq?=
 =?utf-8?B?Z21HbjkyTDhSNjJpdngzdkdqK0pHTWljVTl0dXIzdzMrb1NEKzlEV1BlSm95?=
 =?utf-8?B?SWRjNHJ0Y2FScDcvNWVBUm52eXh1S2xEbmErc2hlbXN1NDRycWMzc0EvWUJL?=
 =?utf-8?B?S1VCMmNldU91STRqek9zU2FWb2RKTzcwRjF6cy9nNDg3QmkzUTVnU3FkZ1I1?=
 =?utf-8?B?RTBzZ1Q4RC9uUWg3c0crVi9vMEtUc3dUSERHMEg1NWZyc1ZiVUlva21DUTFM?=
 =?utf-8?B?ZDVIU0ZmS3Q1SVRpK1RmZjJsYUo2ZG5oc1FHcjFHTnZtejRvTzRlTjBjNlc5?=
 =?utf-8?B?U3pGNncvSFpmRjM1eldDa1F0Tll1dFBvVUtZc1c0VVIrQSs1ZTUxdHVJREtT?=
 =?utf-8?B?SWhvTGEyR1N2T1pkMld2cEptVC9BYlBpdFNOajFlUlJBTFc0YlFvMlFlYlR1?=
 =?utf-8?B?VnlIRWpyVmJmbHI0VVJhZWpVbTYxbzBFcHZ4KzNwVUlmS2l3SmVKOWoySHR6?=
 =?utf-8?B?bFpmWUw3TnkzSElpWFNvam5MT0pMZHlFenNRVHhPMTNGUS94Vm93eDBlYUhB?=
 =?utf-8?B?UXlWUDJrMzR2SjY4aEEyU3YrL3BmK1UvNktkKzFJbk9XTHFKREtyOS84czBM?=
 =?utf-8?B?NCtSZVd0UmNISUxTb2NieEZiU2t4TC80N0J4b0ZxclVyY3FpMjVZb3N0WDIy?=
 =?utf-8?B?alNMaktpdC9aMGovdDQ0OXZQSGFKOWYrb0Q0aS9lNmtpa3hHQ2cwNjlSZFpB?=
 =?utf-8?B?a3Vpc0dwMFJaUmJrcy9jNm93bWhTb01MV1lEK0p3Y2hNVmc4dFIwSGZ1Qkgx?=
 =?utf-8?B?bUdBSVhOcXpKeWFQbDc1RVY2clpVK1c2cnVsY1p2OXU2bTlQYXdpS05tRDRB?=
 =?utf-8?B?b3pCNDB5L0liM1QvL24vZGtvdHZ1TmJ6aTQrZFhJdHdWQUxReVlqQ2JnR05E?=
 =?utf-8?B?UWpoekVVeHRLaXBYSWs4SDFoVkZDT1BMUkJOMFBDRDJPekxINEF5ZEU2TnYy?=
 =?utf-8?B?Y1J6Y1l1Mm8yQzF4bUJyb0VnUzJFMS84bjBTWHg2VEpIaDR3UDA2U3puQVRy?=
 =?utf-8?B?VmdJeXo1TllKblh4L0ptWHhQbmFnU1EwMEdnS05YeUFrYnQyTW1UYy9hQVM2?=
 =?utf-8?B?S3c0dnVPMHQ1MHNONHFPcXhuczBNMU5SemdXN3lXNlM4SHRKTHZUd0xMamE2?=
 =?utf-8?B?Nlk4TFU1aFdWYnAwMkpwbGMrVzNBaHVqRkV5d0k3Q3VML0FWRm8rYi9hUVBZ?=
 =?utf-8?B?eEJXWk9YNUxkZytMTGJZNExDbUhMZkxxcEZqbUg4b1NHSkFZdXdURmdsbGZT?=
 =?utf-8?B?TkFkTngvT1V6ay9HMDE3a0trZ21DNjJBT2pZMWdJOERDdlVXRklPZVBSdmlS?=
 =?utf-8?B?RDh3blFEUnEvSXdYOWlML0ozRVZtS2dFa2R1bVk4L3I1ZVpKTEhYeThjMWJ0?=
 =?utf-8?B?cWdHNTU2ZG1nM3RwUTFWQXpaenpndmVaZGN5eVVUU1I1aHhyYW40QU5LVStW?=
 =?utf-8?B?NlIvSHhqcDZUK0VySFRvallJeHVING05S1JKYWV0Sk1qdExMV1BOb2N6VDFq?=
 =?utf-8?B?T0FoWHE1cEdualVqMXM2WVhHWTlWK3U2VE1VcTVUV0pFUXczOVBGUWF1OG8x?=
 =?utf-8?B?dktzM3N1dmdEUzh1NHFXRFhNMEY3eFE5ZllDc1krWjIwcWFzMUNGdU9DV1d3?=
 =?utf-8?B?SlBJamQ2MVBIWWpQalZRT2krbS9VZ2h0WXhmSENDbEl3YjJwNEpuSlc1ZVl4?=
 =?utf-8?B?UC9Sd1dnZ3dENkF6dlppSEQ1OUF4eG5idUVWWlhuZ3UvUmdEZmt0THRpc2hR?=
 =?utf-8?B?ajA2Y0VpTTJ5QkJBN0RZaHpQQkJDelN6dkVpRHJ3aUhBQ3RjVzhQcGROOUZw?=
 =?utf-8?Q?ogbt7tadpHuvY88kO2HfMw4db?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcd2a0a-1e33-48d5-6ed2-08da9ef0b260
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2022 12:23:04.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66Io1w88+UI63AH/t/irJb4jjg5qvltg7Ib74F8/sJKaizR474MRHvgqWrQ7MgwwvU0o3l4/OcpzspBucpulwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE5hdGhhbi4NCg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZvbnRlbm90LCBOYXRoYW4gPE5hdGhh
bi5Gb250ZW5vdEBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxNiwgMjAyMiAx
MjoyNCBBTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tOyBIdWFuZywNCj4gUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IHZp
cmVzaC5rdW1hckBsaW5hcm8ub3JnDQo+IENjOiBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJt
YUBhbWQuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
U3UsIEppbnpob3UgKEpvZSkgPEppbnpob3UuU3VAYW1kLmNvbT47DQo+IEh1YW5nLCBTaGltbWVy
IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4NCj4gPFhpYW9qaWFuLkR1QGFt
ZC5jb20+OyBNZW5nLCBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC0NCj4g
cG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggNC83XSBjcHVmcmVxOiBhbWRfcHN0YXRlOiBhZGQgQU1EIHBzdGF0ZSBF
UFAgc3VwcG9ydA0KPiBmb3Igc2hhcmVkIG1lbW9yeSB0eXBlIHByb2Nlc3Nvcg0KPiANCj4gT24g
OS85LzIyIDExOjQ1LCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+IEFkZCBFbmVyZ3kgUGVyZm9ybWFu
Y2UgUHJlZmVyZW5jZSBzdXBwb3J0IGZvciBBTUQgU09DcyB3aGljaCBvbmx5DQo+ID4gc3VwcG9y
dCB0aGUgc2hhcmVkIG1lbW9yeSBpbnRlcmZhY2UgdGhhdCBpbXBsZW1lbnRlZCBvbiBaZW4yIGFu
ZCBaZW4zDQo+ID4gcHJvY2Vzc29ycywgYmVjYXVzZSB0aGlzIHR5cGUgQ1BVIGhhcyBubyBNU1Ig
c3VwcG9ydGVkLCBpdCB3aWxsIHVzZQ0KPiA+IEFDUEkgUENDIGNoYW5uZWwgdG8gZW5hYmxlIEVQ
UCBhbmQgcmVzZXQgZGVzaXJlZCBwZXJmIHRvIGJlIHplcm8uDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCAxMiArKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nw
dWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGlu
ZGV4IDQ1MTI5NTI4NGEyNi4uZmZmMjk4NzQ0YThlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Y3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0
ZS5jDQo+ID4gQEAgLTEzMywxMiArMTMzLDI0IEBAIHN0YXRpYyBpbmxpbmUgaW50IHBzdGF0ZV9l
bmFibGUoYm9vbCBlbmFibGUpDQo+ID4NCj4gPiAgc3RhdGljIGludCBjcHBjX2VuYWJsZShib29s
IGVuYWJsZSkNCj4gPiAgew0KPiA+ICsJc3RydWN0IGNwcGNfcGVyZl9jdHJscyBwZXJmX2N0cmxz
Ow0KPiA+ICAJaW50IGNwdSwgcmV0ID0gMDsNCj4gPg0KPiA+ICAJZm9yX2VhY2hfcHJlc2VudF9j
cHUoY3B1KSB7DQo+ID4gIAkJcmV0ID0gY3BwY19zZXRfZW5hYmxlKGNwdSwgZW5hYmxlKTsNCj4g
PiAgCQlpZiAocmV0KQ0KPiA+ICAJCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCS8qIEVuYWJs
ZSBhY3RpdmUgbW9kZSBmb3IgRVBQICovDQo+ID4gKwlyZXQgPSBjcHBjX3NldF9hdXRvX2VwcChj
cHUsIGVuYWJsZSk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0K
PiA+ICsJLyogU2V0IHplcm8gdG8gZGVzaXJlZCBwZXJmIHRvIGVuYWJsZSBFUFAgY29udHJvbCov
DQo+ID4gKwlwZXJmX2N0cmxzLmRlc2lyZWRfcGVyZiA9IDA7DQo+ID4gKwlyZXQgPSBjcHBjX3Nl
dF9wZXJmKGNwdSwgJnBlcmZfY3RybHMpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4g
cmV0Ow0KPiANCj4gU2hvdWxkbid0IHRoaXMgZW50aXJlIGJsb2NrIGJlIGluZGVudGVkIG9uZSBh
ZGRpdGlvbmFsIHRhYiBvdmVyIHNpbmNlIGl0cyBwYXJ0DQo+IG9mIHRoZSBmb3JfZWFjaF9wcmVz
ZW50X2NwdSgpIGxvb3A/DQo+IA0KPiAtTmF0aGFuDQoNClllcywgSSBjYW4gc2VlIHRoZSBpbmRl
bnQgaW4gbXkgbG9jYWwgdnNjb2RlIGVkaXRvciwgSSBkbyBub3Qga25vdyB3aHkgdGhlIHBhdGNo
IGRpZG5gdCBzaG93IHRoYXQuDQpJcyBpdCBjb3JyZWN0IGFzIGJlbG93ID8NCg0KCWZvcl9lYWNo
X3ByZXNlbnRfY3B1KGNwdSkgew0KCQlyZXQgPSBjcHBjX3NldF9lbmFibGUoY3B1LCBlbmFibGUp
Ow0KCQlpZiAocmV0KQ0KCQkJcmV0dXJuIHJldDsNCg0KCQlpZiAoZXBwX2VuYWJsZWQpIHsNCgkJ
CS8qIEVuYWJsZSBhdXRvbm9tb3VzIG1vZGUgZm9yIEVQUCAqLw0KCQkJcmV0ID0gY3BwY19zZXRf
YXV0b19lcHAoY3B1LCBlbmFibGUpOw0KCQkJaWYgKHJldCkNCgkJCQlyZXR1cm4gcmV0Ow0KDQoJ
CQkvKiBTZXQgemVybyB0byBkZXNpcmVkIHBlcmYgdG8gYWxsb3cgRVBQIGZpcm13YXJlIGNvbnRy
b2wqLw0KCQkJcGVyZl9jdHJscy5kZXNpcmVkX3BlcmYgPSAwOw0KCQkJcmV0ID0gY3BwY19zZXRf
cGVyZihjcHUsICZwZXJmX2N0cmxzKTsNCgkJCWlmIChyZXQpDQoJCQkJcmV0dXJuIHJldDsNCgkJ
fQ0KCX0NCg0KUGVycnkuIA0KDQo+IA0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlyZXR1cm4gcmV0Ow0K
