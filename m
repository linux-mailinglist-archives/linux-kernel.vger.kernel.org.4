Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5486465E359
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjAEDSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjAEDS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:18:28 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6781265F1;
        Wed,  4 Jan 2023 19:18:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTF9SSABOYFoK2/P+FuOYB7UOR5mo23W7f17XaroYQv8HFB/fr4DYnSpZADPfUvPhWOVRLEbpZgH89ILVyQT5ARyqGu641HpOMFzf0xbgas8iy5SLMGsiQ8Rof8qpCgWYhGCAzj+W621Qgk9JqIeuj5uirSmzaRelC23IUSZOtAl0/wqmT8XNb/mGLOZsgkswP3oAsgAjK+JO4cpp6qbsDAzmNzDCDHDeBt+6mLdcH6C7K7m0k6zwSJwmdU+dFgv9BfkVZR8rDRqhF2fSJtQLBHp/KsGrrZgVRTPPrHmI1yQ5NPBEV3DlDoeQaeePsijklGK2oOTNklJ8Rkf5oezgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJE7ybTy6i7ZwGGnG3Rfyvx9pgsuG4dmdSszjv6H1ac=;
 b=RmQrn9qSe5I2A0B+qWjgqrfzS2hFp2j6ub4hoclBXZKiuGoMIAVSDa9cyla4Aad2x5srFEhKOktCX4poYccqWBBvdQ3sBzYK+BaHBsh7K3vJOeQqnAvSHFJxfMgK2NGtfLyhtwAkt9NluSoYwg8fQdEXJRNgFIOQzSF6C7Zep6PMDXaQgmftDRShkR8ekP9LQ60ZcNSkffJEUJh2FqxT9aRZ3eKThi9lMK/em6HRW6S2cb1x7zov7Hom2Zr0or3D2OPkYFHWZeKD/NMrgB/vmQlajd6lOYfUXByuvH9FWKLUbTvoywY1eUuJu2jWb8SuPHsti61IqH7GUZzXalX/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJE7ybTy6i7ZwGGnG3Rfyvx9pgsuG4dmdSszjv6H1ac=;
 b=o2xnxKY8C2tKe4BcmHhComoyh4kEgJ6TJNcsILM6G1xQZkJfQyZumkFJRpOYzaACjkkPb/eaovh1r2lIlLvYgEzYQpEYRO19WmCdYedyRQfVzEfNhuutsIofDr9bHgVdReaUvOVrFFJXpFcgJzxQtyt2TpXZqqD/TC8IrqFX4cE=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:18:23 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 03:18:23 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 02/13] Documentation: amd-pstate: add EPP profiles
 introduction
Thread-Topic: [PATCH v9 02/13] Documentation: amd-pstate: add EPP profiles
 introduction
Thread-Index: AQHZGH7htbNBbClWFUiBrD63qWRhgK6NdicAgAGxfVA=
Date:   Thu, 5 Jan 2023 03:18:23 +0000
Message-ID: <DM4PR12MB5278A6318FE26889D2F291FC9CFA9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-3-perry.yuan@amd.com>
 <47cfe6c9-4300-1d76-4073-3a4ff50830d8@amd.com>
In-Reply-To: <47cfe6c9-4300-1d76-4073-3a4ff50830d8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-05T03:18:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=537ab0bd-e7ee-4e42-ae1e-e25f36ec04dd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-05T03:18:19Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: c452c10a-afd0-4734-90c4-afd693381182
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY5PR12MB6345:EE_
x-ms-office365-filtering-correlation-id: 52b799c5-2edb-4b8e-5205-08daeecb80fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IMiTOKdVXDaii4pQ9DgsvQzjA/Th/AvFFU5K5iyqQHSqTC3/Oh3lebyD73WImS1q/jZyEZ4uhLtn+Nl4j3L1nIYHjHm50bIjOIxj582Cwxc3G7/T+J1FNTGN72wrGE0xGz65GBmH3DgIbaVSYebF9476TKddJs62z/FUYRvRMzWVZ2sbguMas4Za+4JoefowPIb+DLKeWeUB6+0UIi1FHr24HL5yz+87QS6C+vYgVJHTmZZbySXWzGi8W8avW6lw310taXw+SBWuOXeOe+yvboUr7ltgHO4/9IHZ3JhStQ8cbxtQoNc/TFZQrf2Vy2uVx50QGBfOiwapLnLDN2CMuOA8LnghXASCrsk4+Jtg8eNR8iQ3ioaLu82+MND08yelpVnN4zirO9ig3JMqcRmfzNTEUsznq3JQvGZYuQ6LqloCrLOpycKnxFtBDmTSo6QopIInHyXnP89IYwcptPE2to4UR51CMtCoQLW0WPtWCnRVgBT5HkFmBDv+is3rGIVT4MQve4YR001QYCAN2UPR0QXv5G5MyH9yW74fw9Okfy825MCuGF9fxDYax6yImmR5TOscxFz0V6ai7n8nP40aFDi7AqV2N01LLLbBU369FkhMnFLzQ1p/5WOV6SJ2QmQjbJLOwnWCo8VuLl3XFYlPPLH6cumH4vLRUiJS2HIhq3EuKIIHEjhUyzrhyAStA0lHSjPF2bg1k4drcz8hbztWUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(64756008)(8936002)(52536014)(66446008)(66556008)(66476007)(41300700001)(5660300002)(2906002)(122000001)(83380400001)(38100700002)(55016003)(316002)(54906003)(110136005)(53546011)(8676002)(86362001)(76116006)(4326008)(186003)(26005)(9686003)(66946007)(6506007)(33656002)(71200400001)(7696005)(478600001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEVhUTVKaVdhdEJ1ekxIODNCWDBaTTRPNzRkMDdMbVhJN1BtamhKL2xCVENr?=
 =?utf-8?B?QUt2U01NRFZLZnY5M0c5Z0g0N2dwN1luSTVLT0xDVmIwMDU5TWhzN0ZKVk5Q?=
 =?utf-8?B?MFJmN1FzZzhXbVZ5ZldaYUl4dTBTU1N1MTl4b2R4cG5jTTdPd210L0p0VGhP?=
 =?utf-8?B?QnNOWDZPdDRVa0xoa21IVU5yY0pzcVpySmFNT2k3R2pIWVNGTnArQnJtUGZx?=
 =?utf-8?B?ZHpQZWNWS2RPZktjeitnVjNvOGIvTTBWVGZHbkNNNEN3YmJ0YUdyU1ArQzly?=
 =?utf-8?B?WHRRc0lzdjlESXF6cjZPMFZuaWVIWkt4K0FKV1duVW8xWGE5cHNNWE05V1dy?=
 =?utf-8?B?Zlo0NHhyaGthdmVlcmFVZ2lab0JvZXJRK2dNMjhmMGpFN2QybGQ0UnBiNUNq?=
 =?utf-8?B?OTVOVWdreWhRYzlxWUREZnAxRE5ROHJ4cFJMT01WR0lVb1QxN2xQSnlpS2dy?=
 =?utf-8?B?NVlMbWR2eFQ4NzNidWFsaDJEMXJ1aTREdithM3Exajh0NDd3VXdZOGpneWxn?=
 =?utf-8?B?elVBOU1DWlFBTWJLaThKMnN0VXdPTWlSYmRtWndNTUlwdmVhNDRFQmxiajgx?=
 =?utf-8?B?WE1URGlkWDFLckttWkpkTjcwVGdHT09La2pxditKNWFsRG90OHNsSFdJY1NN?=
 =?utf-8?B?NUxqSWdrVVpFcXRCdG50cG4zdDdZd1dzbnFoSGF2ZnhyOWh5bC9UTkswNFJZ?=
 =?utf-8?B?eEdHUmZ0N3NCR0s1Q0tiSWxoN3ZiRTZTUzZvRmorbUhUNTZySUF4cDZzSzZO?=
 =?utf-8?B?aDlFdldEUk5WeDE5cGNMUExsRE54ZEV5MkZyeVJTRkRyUjM4aURMT0Y5NVpS?=
 =?utf-8?B?ZHcxakJKRlJsNkJ6YTBidW5uM3JGenliRUpHQUhjb1RMd0lYOFdFaVJ5TGhn?=
 =?utf-8?B?Y3pvemJnTnRha1JqRmxHVkVvSVBwZ0NhN05JTDNza1p3SWtsaEpZeFJ4NG9n?=
 =?utf-8?B?Mm9NMkhIYWdGeVg1am9oaUFlSHBsUmh2QmRkYVFkNHd2RHlXS2E1K0JFakxi?=
 =?utf-8?B?V1N0VVl4bmcwK2poaGVZNnlqNmlUMVZUTFNPWnVqUS9KV3F5N2dyQ2RNUG1s?=
 =?utf-8?B?d28zMmg1ZS9MZ0pIelp5b2lPZlRva3pUZmV0YlB1VGdIMFR6a0p6bnRSMEYv?=
 =?utf-8?B?Q3FmU09WK3BuOHZYSE5OOXBoNStWN24yR2xzTm9ONnNjWHJsd0lSQ0RaMDBt?=
 =?utf-8?B?YVVVY29kRkc4aDAzY0k3aWJCcVV1dFF0a2FydUhmY0I1bDRMTENOWnpDeml3?=
 =?utf-8?B?Z1V4SkhXcmtXZDIwTzJNZDIyTVY0YzBkNlUyRitOK01zbEozdlU5dUtobTRB?=
 =?utf-8?B?Q3JJeGRweFRFTFE3MHNZV1RxY1JtekJIaUVzb29jVkwvQjRJWmxJWUo1LzVi?=
 =?utf-8?B?b1RvcHJibWtjTmw5SVBZcndyKzBEWDM4cFZxZUkvc1V0VVZ1SWpITTlCbXRU?=
 =?utf-8?B?OXIyc1FuWlZiclo0Y21oRUUwQjd2NmVBdXBCRCtpWDlzZ1BzcE9OYUZ2UWd5?=
 =?utf-8?B?ZGVQQW0vWTdBYUpIalFPZzRUOC85aUlPdjR1dHN4QlFHWjhDeEMzd2FQMS9P?=
 =?utf-8?B?YjlJYVd0Y2QwdXNWLytZTkZERlB6Rkt2Znc5bXZVMVh0dGp2YWF3K0xwb3g5?=
 =?utf-8?B?dlUwYVcwdWlybXpsbkh3Mll1RElaNlo5cnZVRjdDZDV5TmtXTkxtMytJYnhx?=
 =?utf-8?B?VTRuYUpob0VZWFdGNlArT1NVeWdIdDNCSCszcFI0eWNHQ0g0Z2trM0Fyb3lu?=
 =?utf-8?B?bFlibFdPdmJWUjd2UW1YUWRYc0JWZHdzbm1PL015MUZEdTVDYlU2djVwYXox?=
 =?utf-8?B?OE9vczJGUlV4OHNNaWxCMGhocm1scThQZGtiRGswK0tPZGljejVsNUJUdFEx?=
 =?utf-8?B?L3JKTFJoVVVoTm9KS2xqMVVpNFNISnpXQ0gwMEZlaXRtNHJNZWI4R2hpMzdu?=
 =?utf-8?B?ODkyRk85b3Y3bHdBa29RMkU3aXdQd0pBWHVFcEluc0Z6cUYxbktXbDVreDlt?=
 =?utf-8?B?bHZYMlowOG5YNzJuanR4UVUyYWVpTytNWGNRWkNESS81QTRjNjkxMGFRbzla?=
 =?utf-8?B?R0VqZjVEeEI2OHpVMldJaTlYdzAzdVFISnhSVS9GVHZieEhBT2Fzd1JVR1Uv?=
 =?utf-8?Q?2U5De215mn7LUxcQcmAHFaFKS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b799c5-2edb-4b8e-5205-08daeecb80fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 03:18:23.5644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z0swELoF7XrRgGzlDAxebyF7B1Ba2CczimG5h3kjgdsaFWgHdIfsvfq3P/qcNXkjLK12KxXGU4KnoY5DG8aKAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLiANCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSA0LCAyMDIz
IDg6MjkgQU0NCj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwu
ai53eXNvY2tpQGludGVsLmNvbTsgSHVhbmcsDQo+IFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+OyB2
aXJlc2gua3VtYXJAbGluYXJvLm9yZw0KPiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFy
bWFAYW1kLmNvbT47IEZvbnRlbm90LCBOYXRoYW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29t
PjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVh
bmcsIFNoaW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlh
b2ppYW4uRHVAYW1kLmNvbT47IE1lbmcsDQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNv
bT47IEthcm55LCBXeWVzIDxXeWVzLkthcm55QGFtZC5jb20+Ow0KPiBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2OSAwMi8xM10gRG9jdW1lbnRhdGlvbjogYW1kLXBzdGF0ZTogYWRkIEVQUCBwcm9maWxl
cw0KPiBpbnRyb2R1Y3Rpb24NCj4gDQo+IE9uIDEyLzI1LzIwMjIgMTA6MzQsIFBlcnJ5IFl1YW4g
d3JvdGU6DQo+ID4gRnJvbTogUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiA+DQo+
ID4gVGhlIGFtZC1wc3RhdGUgZHJpdmVyIHN1cHBvcnRzIGEgZmVhdHVyZSBjYWxsZWQgZW5lcmd5
IHBlcmZvcm1hbmNlDQo+ID4gcHJlZmVyZW5jZSAoRVBQKS4gQWRkIGluZm9ybWF0aW9uIHRvIHRo
ZSBkb2N1bWVudGF0aW9uIHRvIGV4cGxhaW4gaG93DQo+ID4gdXNlcnMgY2FuIGludGVyYWN0IHdp
dGggdGhlIHN5c2ZzIGZpbGVzIGZvciB0aGlzIGZlYXR1cmUuDQo+ID4NCj4gPiAxKSBTZWUgYWxs
IEVQUCBwcm9maWxlcw0KPiA+ICQgc3VkbyBjYXQNCj4gPg0KPiAvc3lzL2RldmljZXMvc3lzdGVt
L2NwdS9jcHUwL2NwdWZyZXEvZW5lcmd5X3BlcmZvcm1hbmNlX2F2YWlsYWJsZV9wcg0KPiBlZg0K
PiA+IGVyZW5jZXMgZGVmYXVsdCBwZXJmb3JtYW5jZSBiYWxhbmNlX3BlcmZvcm1hbmNlIGJhbGFu
Y2VfcG93ZXIgcG93ZXINCj4gPg0KPiA+IDIpIENoZWNrIGN1cnJlbnQgRVBQIHByb2ZpbGUNCj4g
PiAkIHN1ZG8gY2F0DQo+ID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jcHVmcmVxL2Vu
ZXJneV9wZXJmb3JtYW5jZV9wcmVmZXJlbmNlDQo+ID4gcGVyZm9ybWFuY2UNCj4gPg0KPiA+IDMp
IFNldCBuZXcgRVBQIHByb2ZpbGUNCj4gPiAkIHN1ZG8gYmFzaCAtYyAiZWNobyBwb3dlciA+DQo+
IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1ZnJlcS9lbmVyZ3lfcGVyZm9ybWFuY2Vf
cHJlZmVyZW5jZSINCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1
YW5AYW1kLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8u
bGltb25jaWVsbG9AYW1kLmNvbT4NCj4gDQoNCkkganVzdCBnb3QgYmFjayBmcm9tIHNpY2sgbGVh
dmUsIHdpbGwgcGljayBhbGwgeW91ciBSLUIgZmxhZ3MgYW5kIHNlbmQgdjEwIG91dC4gDQpUaGFu
ayB5b3UgaGVscCB0byByZXZpZXcgdGhpcyB2ZXJzaW9uLg0KDQpQZXJyeS4gDQoNCj4gPiAtLS0N
Cj4gPiAgIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0vYW1kLXBzdGF0ZS5yc3QgfCAxOQ0K
PiArKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0v
YW1kLXBzdGF0ZS5yc3QNCj4gPiBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0vYW1kLXBz
dGF0ZS5yc3QNCj4gPiBpbmRleCAwNmUyMzUzOGY3OWMuLjMzYWI4ZWM4ZmMyZiAxMDA2NDQNCj4g
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BtL2FtZC1wc3RhdGUucnN0DQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9hbWQtcHN0YXRlLnJzdA0KPiA+IEBA
IC0yNjIsNiArMjYyLDI1IEBAIGxvd2VzdCBub24tbGluZWFyIHBlcmZvcm1hbmNlIGluIGBBTUQg
Q1BQQw0KPiBQZXJmb3JtYW5jZSBDYXBhYmlsaXR5DQo+ID4gICA8cGVyZl9jYXBfPmBfLikNCj4g
PiAgIFRoaXMgYXR0cmlidXRlIGlzIHJlYWQtb25seS4NCj4gPg0KPiA+ICtgYGVuZXJneV9wZXJm
b3JtYW5jZV9hdmFpbGFibGVfcHJlZmVyZW5jZXNgYA0KPiA+ICsNCj4gPiArQSBsaXN0IG9mIGFs
bCB0aGUgc3VwcG9ydGVkIEVQUCBwcmVmZXJlbmNlcyB0aGF0IGNvdWxkIGJlIHVzZWQgZm9yDQo+
ID4gK2BgZW5lcmd5X3BlcmZvcm1hbmNlX3ByZWZlcmVuY2VgYCBvbiB0aGlzIHN5c3RlbS4NCj4g
PiArVGhlc2UgcHJvZmlsZXMgcmVwcmVzZW50IGRpZmZlcmVudCBoaW50cyB0aGF0IGFyZSBwcm92
aWRlZCB0byB0aGUNCj4gPiArbG93LWxldmVsIGZpcm13YXJlIGFib3V0IHRoZSB1c2VyJ3MgZGVz
aXJlZCBlbmVyZ3kgdnMgZWZmaWNpZW5jeQ0KPiA+ICt0cmFkZW9mZi4gIGBgZGVmYXVsdGBgIHJl
cHJlc2VudHMgdGhlIGVwcCB2YWx1ZSBpcyBzZXQgYnkgcGxhdGZvcm0NCj4gPiArZmlybXdhcmUu
IFRoaXMgYXR0cmlidXRlIGlzIHJlYWQtb25seS4NCj4gPiArDQo+ID4gK2BgZW5lcmd5X3BlcmZv
cm1hbmNlX3ByZWZlcmVuY2VgYA0KPiA+ICsNCj4gPiArVGhlIGN1cnJlbnQgZW5lcmd5IHBlcmZv
cm1hbmNlIHByZWZlcmVuY2UgY2FuIGJlIHJlYWQgZnJvbSB0aGlzDQo+IGF0dHJpYnV0ZS4NCj4g
PiArYW5kIHVzZXIgY2FuIGNoYW5nZSBjdXJyZW50IHByZWZlcmVuY2UgYWNjb3JkaW5nIHRvIGVu
ZXJneSBvcg0KPiA+ICtwZXJmb3JtYW5jZSBuZWVkcyBQbGVhc2UgZ2V0IGFsbCBzdXBwb3J0IHBy
b2ZpbGVzIGxpc3QgZnJvbQ0KPiA+ICtgYGVuZXJneV9wZXJmb3JtYW5jZV9hdmFpbGFibGVfcHJl
ZmVyZW5jZXNgYCBhdHRyaWJ1dGUsIGFsbCB0aGUNCj4gPiArcHJvZmlsZXMgYXJlIGludGVnZXIg
dmFsdWVzIGRlZmluZWQgYmV0d2VlbiAwIHRvIDI1NSB3aGVuIEVQUCBmZWF0dXJlDQo+ID4gK2lz
IGVuYWJsZWQgYnkgcGxhdGZvcm0gZmlybXdhcmUsIGlmIEVQUCBmZWF0dXJlIGlzIGRpc2FibGVk
LCBkcml2ZXINCj4gPiArd2lsbCBpZ25vcmUgdGhlIHdyaXR0ZW4gdmFsdWUgVGhpcyBhdHRyaWJ1
dGUgaXMgcmVhZC13cml0ZS4NCj4gPiArDQo+ID4gICBPdGhlciBwZXJmb3JtYW5jZSBhbmQgZnJl
cXVlbmN5IHZhbHVlcyBjYW4gYmUgcmVhZCBiYWNrIGZyb20NCj4gPiAgIGBgL3N5cy9kZXZpY2Vz
L3N5c3RlbS9jcHUvY3B1WC9hY3BpX2NwcGMvYGAsIHNlZSA6cmVmOmBjcHBjX3N5c2ZzYC4NCj4g
Pg0K
