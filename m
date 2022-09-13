Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3B5B7657
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiIMQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiIMQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:20:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE7DA5C59;
        Tue, 13 Sep 2022 08:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzbHxA8kpLcyvb3kYttbHiwhnbPDMVwn65avKQQ/bGgM25lDLC9+/LR/DoAFPatG86LTg1WxEWiO6BfaoYc5lkUaBHK0Ae4puW+e7QUV+/pO1610F86uY3ySCBCswEPJInDTlQ32qdT0mHXfUCAndNbKd5S9auiNWFbIBTSeBpCKfFwC1UtEsaY7D9MAC6jiLaApg2JYOoohjXsw+z2reivRESeW69kChRjTdRvcpUgASoYOk6cwu8lk49ykTJTzoDLPPOSCRvP556ExgKjeBDOCttpc+Nni7XuC7CO2mQi3WIV6xq3EeteHHRpFCcABLCtAkOJPx02ZoX39f31r6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fu3QcFPzLqbDHiY08f3eFnTehqtyQ7HH3FkjWq3OPA=;
 b=PNTyOv+c5SjkVoRko+9IE7El+3c50T9/CY93wSu/X1PL4SYsGRwMK0Flh+hdNK0CXobHbt/U0UP9OZ9mhtNhipHBl8Z1ZVCpW2ssMn6ndy41R4O/C+/XEPlc1qwB/BcBgQVOgbtrr0zeIyXyHb4wwSXjEzLPWyMf6GXD6uIf14QlcAaRIRNv2S48PLER0kBXQmuuhsfhrJ2y1fLAZi7uLAFIkM77rY0bI8VUIZ8loQR1CDOHUBMKJZX1c3OkC9l7ZV0hkttr06hRFPQLVNAKgPTyCeeTc18vAw4ZoGGnBZS0rFZh89AChfp5NpjTRIYvcVsaurkzFlxghrYmGN5PlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fu3QcFPzLqbDHiY08f3eFnTehqtyQ7HH3FkjWq3OPA=;
 b=eBpDikUYpUNGwDp1SAQUyTIF6ZAuz/VJXeHmjVKCr6Ik5KjMUzoI7RChlGF4u3WAp0wtRlzq1lby0W+vBovfa+GtqL9X83xXK6HpZdbG6iPGre/9wV6Cvz0F1ixE96ekglcKTLlf0hvIw50BElV4+c7bWJRMu09XJj68j0IF3Gc=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 15:14:14 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 15:14:14 +0000
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
Subject: RE: [PATCH 2/7] cpufreq: amd_pstate: add module parameter to load amd
 pstate EPP driver
Thread-Topic: [PATCH 2/7] cpufreq: amd_pstate: add module parameter to load
 amd pstate EPP driver
Thread-Index: AQHYxGvMfyM5wc0bSEifIZSI5R0+Ja3XcP6AgAYD7wA=
Date:   Tue, 13 Sep 2022 15:14:13 +0000
Message-ID: <DM4PR12MB52785281752518053A305D519C479@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-3-Perry.Yuan@amd.com>
 <abb1ec0e-2a1f-09bc-f11c-8e5be4526927@amd.com>
In-Reply-To: <abb1ec0e-2a1f-09bc-f11c-8e5be4526927@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-13T15:14:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c3c32774-09f1-466e-85a3-92a2563de631;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-13T15:14:10Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9f39354d-5338-4e74-a229-80b78da7660b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CH2PR12MB4280:EE_
x-ms-office365-filtering-correlation-id: 427f2397-2ea8-4847-c31b-08da959a9e4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BfI0wx2pqm6/NT8GB9eWAt2gxRSAOt2LXTFUjBvpfyskue8aT1cm7mnicuXYLWVvU1MHgmErBxABH1cNaDHjbPSONHp8di4QVTMH7z090ytSVuyYNu3Tw9zaWI+/oEgWdMNKrSwkR7b8Bq6XTDBwzB3N01H8/bXv6uicTd1F862U7FAbf2PcAySDPJOJeBwjG+jcUPkktsyggWZsXr/BviFS42gIAZEvEnyLHXgsg637TMbhhKMccHAEsahrvy7QKFkiFhQbj/GVCPfoaVdoO1KzO0v2UC+WI7dBowfZH+PKivVmsTYvD3Z5zaBK+8qpA2gdkegGztmX0rk4J7uk9ILX4v3cVr5V+7EUweQqn0X6kswyWBPj0lOiABLU3G5w2Ug9N6VQmcDtdcGoPEmXEn1Wgp8epsDyD7rrZ0DAAMSIkNzciKb7DJzSRY0quVFeHZqaYLxXWFMr+2PAQ1unCJCLLhNwl2l2Y4xpV0qDczSRjZJP2CscslfYZWOQLkmV5hM+fnw8lVCKWIVY+V/95OJWkuYi2Y/N09/zHVDiH+KjGGBJo8JtReOHk8p+qedB59sJZjCCphYS/lzwVtUwJ+4SAGYEnohFRZnhx5eGcFAJEWqDPYPh47/i+UxBAoteiZiXXf6+PBuGIYliu8BcIKNcyBrhNC5rKukGQoAweHXwH8DzQ8oTWiY2BKl8ZXdHCikCqd0b5wqNyaR3qQHwpDPrzZa4djI1rQvqo4a2zCO5p/lIBEZ5vc32TkXhaNcwajUQkc3A86AzSSP7fUEeog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(8676002)(76116006)(4326008)(66446008)(66476007)(52536014)(6506007)(186003)(38070700005)(316002)(7696005)(71200400001)(110136005)(54906003)(2906002)(66556008)(66946007)(478600001)(53546011)(41300700001)(26005)(9686003)(64756008)(5660300002)(86362001)(122000001)(8936002)(55016003)(38100700002)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG5ibTl5ak5IRFpqdmExWk9kNy9SMUt5THRXSkVtKys1VXNsV1hnM0QraGwz?=
 =?utf-8?B?MExKRXluSllGZVYzNjVSY3RqSEVrQ05CeVhibXhlMWV4NTZmTzhyaTM4NS9Q?=
 =?utf-8?B?K2JzTm9IQk51Z2YxaGkzYm5VVHBqVlFMZlUxNUlIblRMZDd4YWc0VkZUT3BL?=
 =?utf-8?B?SlZTWUVKeDk0ZGhzWW1NL3doMDRRZmU4Vmc0MEc5NGZaZFdtRWNkRUlVaGpm?=
 =?utf-8?B?VGczMkxwakVvTVVZOG9saFlIWFBMSTJ4MTVqenhJNVU5dEV3OGwwQ0tNb3JM?=
 =?utf-8?B?YnQ1NTQyWjJBN0hNMGRvY3Q3dHFXVDFGU2hUeU1qdUtsWlpWZHdib3g1dXdl?=
 =?utf-8?B?ckY0WjdVeDdNR0QvWWFQRGpXeWgvTXRJNEczQlBlM29XdTNGc3Q5MXd4MXF4?=
 =?utf-8?B?NHc0cGVLSjVSVStGdGtnMDBlTjI5TFhkVndQcHg3c0hWNHVVUU9uUXg0VFky?=
 =?utf-8?B?UG5ramVHV3VTYS8rQWx6V2RGQ01KdzJFeS9oRWc5U2o3L05OR2w5R1diRUt4?=
 =?utf-8?B?Rk1PSkNxYVEwb3Y3d2tyMU9CdXA4ajdWTDYzaDYwc013eUlHSDh5b2J4SlZ1?=
 =?utf-8?B?ckZiSlFtMFZNNU5uaTk1OW43bmRzUDhLRkdBcnRmR1BmUlB5bUcrSlR2MlZI?=
 =?utf-8?B?Nk5XbWFqY2k1b2R6Sm1mWWdScStKdXZmcVNQbkVtNkFBT1dyb0lWZjJnWTk4?=
 =?utf-8?B?TnZUeWhzWXZVWTZMM1hUVjJoQmdHdmZFM09EcDhHQVFKcU5La1FuZllBeU4y?=
 =?utf-8?B?WnNad1pVWFNpeW0xWFRPRm5EaGpURHoyOHJzYm5jMEYxMkdwSGJFMEd6T0Zz?=
 =?utf-8?B?blJXd3huSkxVS1FydXJ3OS9oVXNSYUZCQnhtYTBkMVBiTTVvL25NTWdKZlB6?=
 =?utf-8?B?NHp1QUJvWDhwNDlMMFZOKytRanhQem5VbTBPMXkvMXFkeHZrQTM4akZkSU04?=
 =?utf-8?B?bkkvcGZVRndsQitIOTMwM0ZYYmt2b3Y3V3RxWDFxZk00MTJIdE5RZkEvSTkw?=
 =?utf-8?B?c2FjOGdHVVJWL1daeTBaVUR0V3E5cUZKSEJBUmd0aWpsZUFJZTJRUXk5ZjNa?=
 =?utf-8?B?WkNsaWYvTXo3Tk82Rlh1ZW9zUWVwT0QyaUQ1KzRQL1o5VThUT2pET3JHSldp?=
 =?utf-8?B?eW1MRGY3eFJPRHNrU2UrYmpybG9jWnZaOGZZQUhUMENueFhJTEJwbHNwYm9I?=
 =?utf-8?B?NitGWHY2VXpYOVBVbEp5Y3U0RGFGc3VMYTBsVWZUWXlTeUl1UzhkbUxoOFUr?=
 =?utf-8?B?Z0tzLzBsbGN1WWgzMGNLMUNVZWd1ZzhFVDdnc29VenJWZlRHakdsVzBzZ1hv?=
 =?utf-8?B?RWZTRFJaMjlTZHF2TzB5V25Dc0FWMXJjRHlvREJiN0Jxb3BKOWU4ekk3MExw?=
 =?utf-8?B?OVlLenEwRTVtbzY5TGZYV2lIeXhpelNtM1I1UjI4UW1zWksvdTlFb2oxZDhj?=
 =?utf-8?B?NTBFSHJDRXhVMnlUOWllRXBJcitKUzV4ekRuQXRGUERuQUZHYWdBUG1QVXJ4?=
 =?utf-8?B?T3ZUTUFuSG9TNGNORDdtUWlVbUJ6VnI2TGlKdFk4UCtLQnR4aVhIT3lqemVz?=
 =?utf-8?B?cTFmU1BDMEw5enBOcXRxRXpDZkEwV0s5cllkb05IQ2NlVkRsd1pWZzEzNWxO?=
 =?utf-8?B?MzQ4TDZNMTBrNkZiMjdiV3YrVWtBdVdwcGltTGZSRTdLMWV3eFVRc3BIR1cx?=
 =?utf-8?B?WTkxVXdraTFvSW8wOEkvTkVhazR3Vm0wY0NQcGxmdTRYTWluWlZrN0dCZ2Zm?=
 =?utf-8?B?aHlYNWV1T25UaVJhNXgrK3JSU3R2N09OTWYweVJob1Q5K3dHN2FzMVlZYVMx?=
 =?utf-8?B?WWZweDl1RkNZdXY3RG4zWnl4bE4yQ3Q3SEpYV05jd0tqYTdCU1hWR0pjY3l4?=
 =?utf-8?B?QUp3cktwcjhtaUpTTzVOd3Q0MW9haU5Db3Z4Ty9IK1VwK2R4ZnN6OHpDOTZD?=
 =?utf-8?B?UnNnWVp1Z295ZmN1UXJjMmNRbHcxSHZoVkttZ2NWYUpVamZKU3crQzRoanRk?=
 =?utf-8?B?TEdoTkd5YTlnb3ljZkhUVG1sK2dZcW8yMnR4eXhuMVZxTHh5ZVZEcU1FaGZB?=
 =?utf-8?B?L3VsdmtwNExkUkc0bjFTRGo5UGRHekM2dTNndTIyVm9xMEd6ZllhQ040UmRj?=
 =?utf-8?Q?ACAVnn2wQhqJjtVbR2+EgeKkF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427f2397-2ea8-4847-c31b-08da959a9e4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 15:14:13.9133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDPtXUoAqboWTnXn7aiybuZDGEUgV1Y/YyHk/178ADr5F4nh0vnlZRp2Q0R+EQ3ClYr1KdvCFSPvW8J66+rPGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhJIE1hcmlvDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5M
aW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgU2VwdGVtYmVyIDEwLCAyMDIy
IDI6NTAgQU0NCj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwu
ai53eXNvY2tpQGludGVsLmNvbTsgSHVhbmcsDQo+IFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+OyB2
aXJlc2gua3VtYXJAbGluYXJvLm9yZw0KPiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFy
bWFAYW1kLmNvbT47IEZvbnRlbm90LCBOYXRoYW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29t
PjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU3Us
IEppbnpob3UgKEpvZSkgPEppbnpob3UuU3VAYW1kLmNvbT47DQo+IEh1YW5nLCBTaGltbWVyIDxT
aGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4NCj4gPFhpYW9qaWFuLkR1QGFtZC5j
b20+OyBNZW5nLCBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC0NCj4gcG1A
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi83XSBjcHVmcmVxOiBhbWRfcHN0YXRlOiBhZGQgbW9kdWxlIHBhcmFtZXRl
ciB0bw0KPiBsb2FkIGFtZCBwc3RhdGUgRVBQIGRyaXZlcg0KPiANCj4gT24gOS85LzIwMjIgMTE6
NDUsIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4gVGhlIGFtZF9wc3RhdGUgbW9kZSBwYXJhbWV0ZXIg
d2lsbCBhbGxvdyB1c2VyIHRvIHNlbGVjdCB3aGljaCBhbWQNCj4gPiBwc3RhdGUgd29ya2luZyBt
b2RlIGFzIGJvb3RpbmcgbW9kZSwgYW1kX3BzdGF0ZSBpbnN0YW5jZSBvcg0KPiBhbWRfcHN0YXRl
X2VwcCBpbnN0YW5jZS4NCj4gPg0KPiA+IDEpIGFtZF9wc3RhdGUgaW5zdGFuY2UgaXMgZGVwZW5k
aW5nIG9uIHRoZSB0YXJnZXQgb3BlcmF0aW9uIG1vZGUuDQo+ID4gMikgYW1kX3BzdGF0ZV9lcHAg
aW5zdGFuY2UgaXMgZGVwZW5kaW5nIG9uIHRoZSBzZXRfcG9saWN5IG9wZXJhdGlvbg0KPiBtb2Rl
Lkl0DQo+ID4gICAgIGlzIGFsc28gY2FsbGVkIGFjdGl2ZSBtb2RlIHRoYXQgQU1EIFNNVSBoYXMg
RVBQIGFsZ29yaXRobSB0byBjb250cm9sIHRoZQ0KPiA+ICAgICBDUFUgcnVudGltZSBmcmVxdWVu
Y3kgYWNjb3JkaW5nIHRvIHRoZSBFUFAgc2V0IHZhbHVlIGFuZCB3b3JrbG9hZC4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCA2ICsrKysrKw0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRl
LmMgaW5kZXggYTI0NjNmNzg1MzIyLi40NTEyOTUyODRhMjYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQt
cHN0YXRlLmMNCj4gPiBAQCAtNTgsNiArNTgsMTIgQEAgbW9kdWxlX3BhcmFtKHNoYXJlZF9tZW0s
IGJvb2wsIDA0NDQpOw0KPiA+ICAgTU9EVUxFX1BBUk1fREVTQyhzaGFyZWRfbWVtLA0KPiA+ICAg
CQkgImVuYWJsZSBhbWQtcHN0YXRlIG9uIHByb2Nlc3NvcnMgd2l0aCBzaGFyZWQgbWVtb3J5DQo+
IHNvbHV0aW9uDQo+ID4gKGZhbHNlID0gZGlzYWJsZWQgKGRlZmF1bHQpLCB0cnVlID0gZW5hYmxl
ZCkiKTsNCj4gPg0KPiA+ICtzdGF0aWMgYm9vbCBlcHBfZW5hYmxlZCA9IHRydWU7DQo+ID4gK21v
ZHVsZV9wYXJhbShlcHBfZW5hYmxlZCwgYm9vbCwgMDQ0NCk7DQo+IE1PRFVMRV9QQVJNX0RFU0Mo
ZXBwX2VuYWJsZWQsDQo+ID4gKyAgICAgICAgICAgICAgICAibG9hZCBhbWRfcHN0YXRlIG9yIGFt
ZF9wc3RhdGVfZXBwICh0cnVlID0NCj4gPiArYW1kX3BzdGF0ZV9lcHAgZHJpdmVyIGluc3RhbmNl
IChkZWZhdWx0KSwgZmFsc2UgPSBhbWRfcHN0YXRlIGRyaXZlcg0KPiA+ICtpbnN0YW5jZSkiKTsN
Cj4gPiArDQo+IA0KPiBJZiB5b3UncmUgb3BlcmF0aW5nIGluIEVQUCBtb2RlIG9yIG5vdCB0aGUg
a2VybmVsIG1vZHVsZSBpcyBzdGlsbCAnYW1kLXBzdGF0ZScuDQo+IFNvIHRvIGEgdXNlciBJIHRo
aW5rIHRoaXMgaXMgYSBwcmV0dHkgY29uZnVzaW5nIGRlc2lnbmF0aW9uLg0KPiANCj4gSSB3b3Vs
ZCBwcm9wb3NlIHRoZSBmb2xsb3dpbmcgaW5zdGVhZDoNCj4gDQo+ICA+ICtzdGF0aWMgYm9vbCBl
cHAgPSB0cnVlOw0KPiAgPiArbW9kdWxlX3BhcmFtKGVwcCwgYm9vbCwgMDQ0NCk7DQo+ICA+ICtN
T0RVTEVfUEFSTV9ERVNDKGVwcCwNCj4gID4gKyAgICAgICAgICAgICAgICAiRW5hYmxlIGVuZXJn
eSBwZXJmb3JtYW5jZSBwcmVmZXJlbmNlIChFUFApIGNvbnRyb2wiKTsNCj4gDQo+ID4gKw0KPiA+
ICAgc3RhdGljIHN0cnVjdCBjcHVmcmVxX2RyaXZlciBhbWRfcHN0YXRlX2RyaXZlcjsNCj4gPg0K
PiA+ICAgLyoqDQoNCk1ha2Ugc2Vuc2UsIHdpbGwgbWFrZSB0aGlzIGNoYW5nZSBpbiB0aGUgVjIu
IA0KVGhhbmtzLg0KDQpQZXJyeS4gDQo=
