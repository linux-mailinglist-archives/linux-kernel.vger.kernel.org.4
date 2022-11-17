Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3272E62D71D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbiKQJeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKQJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:34:17 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5ACDFA0;
        Thu, 17 Nov 2022 01:34:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJGuJdt3nHw/EZs0h7vp1rrshlWRgmL2YWaqgkj6tfvyCJh3P15hmpGIHNBrPHBANVzYAsDz4+myeoybrqSAGIqY8zOYutZt3aPRdJfdQIWpJUGylew6oFtLk3qf1oO0yuqV0pyim8vJLYG7Gr1jgiTj0laC7/6zHAn24P2MN9TCIolsh5X9HZAwAZJ50gS0bSPd0uzurZ8g5BEAqj0wueBptwhKH1M5PQFl7OuU9YuH646muGFyjbQ1xAgK9WSTMMtuXKjPwDv/2McpXW6jxoFRLirYh+bTYxqImH4taiseTumFwXe41J12eEVOYjx1TJko1FyQZQ3ge1Z0rLeaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S90MOn7Ui1ZzEmri8WRpVOVOiptx6LOGQQOb3F97iTo=;
 b=Ca6EEiAVkjw1QWI5fD7pVNfyW97lMM4wTq3TR9oaumoCYMCZVbBfLpv+GYUkVukWxco7i1FQtiPJaXcnvUCK68Ti2UGuzHhM+0SuwnfYolqcdYJSbb8rpEIjL3uaJgLljl6weBpSrL252jc9u9JL1h67EkVz5hAmsTcLByLwmkNvp4/Cm7yMyH50eHWUyVSOeKIwHjl6SmOexGte2V/1mrURRFKQrJz+ZBoHlJT25vGARqeW9tUoZY7aAceyJYU86K4sYedo7tmNrS89Fszpf1kZQPQ4FirxaHIyDTvvCy80osPyb7DSezhUsd+gZRbmjJdmjMeNwINNkQap5GGjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S90MOn7Ui1ZzEmri8WRpVOVOiptx6LOGQQOb3F97iTo=;
 b=JyJca/hc7wxMOOnv/N3sUXh1A7ci1F/hNI3pWSIx1r7HQ0tIplMC1PYXgoYVYZ3Ks1AdfVQDK5uh7exdXeapcLFBhD1CM78CGDiFBliGOjNH6Lb7iYxkQ1g1LhGluyvzB0ioEvEPtb/cKByUoRaJ1hW88CHeNyI0U6Uu4Qln4eY=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 09:34:13 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%7]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 09:34:13 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/5] Documentation: amd-pstate: add driver working mode
 introduction
Thread-Topic: [PATCH v3 4/5] Documentation: amd-pstate: add driver working
 mode introduction
Thread-Index: AQHY+ldNIl8cy1+SLUWKj/vt6sZ9PK5C0MIAgAAKDQA=
Date:   Thu, 17 Nov 2022 09:34:13 +0000
Message-ID: <DM4PR12MB5278CF8846AC4661B09F7B189C069@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221117073541.3350600-1-Perry.Yuan@amd.com>
 <20221117073541.3350600-5-Perry.Yuan@amd.com> <Y3X3pPtOGX5UWsUK@debian.me>
In-Reply-To: <Y3X3pPtOGX5UWsUK@debian.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-17T09:28:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=df29e455-3200-467e-9222-e47f02814392;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-17T09:34:09Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b0ea0582-bed5-4292-a7de-2c948363fd9a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|MN2PR12MB4301:EE_
x-ms-office365-filtering-correlation-id: 58cc7573-0a39-4e65-72cb-08dac87ee34f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHw8QD73xh0yhSkPhXCpg2HmZscPo0gAkw1pdRjJXCkDmTb5GD8kwGsPS94AYpwMytSB2WT9ZU432Lbc2qnpsjwlX2TdfQZ1lXhECyzLaFNuB1oO+3U3aE90gF93m+cdflaWdXQvyvPwDPLD36qAuiUnsZx92eFcQiZtFTwInKjKJdNe0/ORVQxvxetWBpaB3cIqqtEFlP5F+0/ApSd/OSKJFMeTqN4TkMh6Po1QGzbYvishefP947+DUBI2QRxU7gJ3vjMCn10wpUXHP5YvWN9kBhzWYQ183HQJY1MaXiIyR9OstG09XdIoS7zOKlqk1cS9qs/WrIpdQ41hymCQs764r3fAKiom0FmNpaTfUxSUW3ZC8t9V69K90hQTZEF2vA2xZocMSvTrjdPyphLZDLfBkdxhrs49JtDbnqz6q8vGLDgbUVWHnEBwf/ygJV2RhY7wkQb0wFCDx9bk2Wbmfr0ggm4TcHKMcH4VHRzoI4rpwlN7/orfSqgI52tBaVEXWQePpCIfBxlYvb44ufgpxq49GErvtm9uLvxgJVJkWyw2rL5nnwc/M1yooAd6DyO9Xu9/9Svk/9YwYs/hvewMJo9MjqI7evCF+ssP+B3M3awSPL2+9ThlAW8wkikAA20MpvTDUHEa9d9npOyj0QbFRPPLBEVftpXabqjcQwUhSJpgWVyEwJJF7XmZ6jD1kowwaFdS61cLwdUSd22/+4pnefrLvsh6gcOy60u9MKu0b+w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(71200400001)(86362001)(26005)(53546011)(7696005)(6506007)(9686003)(316002)(6916009)(54906003)(33656002)(38070700005)(38100700002)(83380400001)(66946007)(55016003)(66556008)(64756008)(8676002)(66476007)(66446008)(76116006)(122000001)(8936002)(478600001)(52536014)(41300700001)(5660300002)(2906002)(4326008)(186003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1JEVy9PbVhDeWh4WjdueGI3cGJEaEFsS1FMMEVNQXQrR0FQVFlUdmx0WHV1?=
 =?utf-8?B?dGRKblIxYnhtNjNaSlBzZUZ5VEZhNWJwMkR2NGdZT1FoVjlmOUJtb0VPbWth?=
 =?utf-8?B?Nmd5ZEhQQlVDeW1Nb3c1MjBHMGZ5YnNKL1RmYVkzNU8zNzFmMGRZWmV4M0w3?=
 =?utf-8?B?T3pZd2pXT1ExeVZKeDFRcnhoWGw0cHhyUWczV2lqbUsrSlFlc2hlUFhMTjh6?=
 =?utf-8?B?clZpMHlFc3Q2QXVhaVZDYlVBLzhDSU5VeEIvWGhQRTRZSHRNVFBLK2xhYWQ5?=
 =?utf-8?B?TTlVYzRQeXJDaGQyU3JWU1JWSkZHK0NLQmx0T2ZhakY4VFpkYS9KeGtlV2pE?=
 =?utf-8?B?cDJ3aGluUkl3dEJDckYrSzE5NWE4S3ZudDhRTVY1a3hob3lMalE3RitndnZs?=
 =?utf-8?B?azBxNUlxODZzbGNUM1hyNW81U0JqVVhnYzRIYW5qdXQ4dmFOc1d6SC9ZOTNn?=
 =?utf-8?B?bzRHS29jMmVkaXpWdWEzVEJoRUxjZTVUY0NCZ3Q0emlvUEo1UnB0OHJIOXhM?=
 =?utf-8?B?NnB6UHhKL2NCaktFclgybXIzdW9NbmtkZkZsbHZRTlpab2JJZmkvbkhFcGNv?=
 =?utf-8?B?UTkrM0FXWDZvZzA2eGh6Y2ZseExURnhROVBkeVJzdHUxMG9EaXI4Tk11WjRa?=
 =?utf-8?B?ZXVhdVdjMWNVQzZzSGwvZ2JWUmNUQ0hTZ0hNdVQvNG1BUkxEaEdSQlFPa0Nm?=
 =?utf-8?B?UCtUdmxQZmVTdDNXeWt5aEJHc251bzhCb2lNemlXcGREK3FmbTFzSmtsdHJG?=
 =?utf-8?B?cG53dDBwbTdQUkx6ejhYL1Jnb042eUpuazltOGhNOVNLQVRMdnRzRXNXZ1FK?=
 =?utf-8?B?T2RwQlhoRUlrNURuNUh6MGRBanRhQk1nQVdVeWo0Z2p6dmNXeWlsMUtlSXVt?=
 =?utf-8?B?VHc1cHN4dmM1VHAwd3FRZ3JuS0NUejZWcU83OE5hY2lCY1ZlWnM2bXdxSUdC?=
 =?utf-8?B?em8vUW1qUWtxMDhyelVBbWNiOFhLN01WdlNMY1NlZmlaY3lXYTVyeUoxZlVw?=
 =?utf-8?B?bEVZTmE4cE52L0RpNml5RVBvdFlVMEhWb1k5S28zWGFMaS8yMklzcGlNRmNK?=
 =?utf-8?B?cWVRK29VVTBYNnozalFGSzZTOHpCamViSXVvNEw3YVBaRUh6QUI1d1hTVStn?=
 =?utf-8?B?bVNlU1JSdmlFRUl2RFRUZjhXMlJTR01CS253U1RlZFRBQkZObjRocmVZRHBt?=
 =?utf-8?B?SVNqWnlYZENkRnp0bG95Skdsc3M0Q3FpczIralUzM2dvZExVUTljb0diOHI2?=
 =?utf-8?B?TVd6RDVDYU5qaTI5VU1OLzM1UHQyT3ZFbEdFVERaSW02UVFxTVAzTVBtTEFp?=
 =?utf-8?B?VnQ5eUkwbWg2UC9oNTJ6UWhNVHRDV0NDRUtrZ1gzM0ExVlprcDlFeGJzalVz?=
 =?utf-8?B?VDl3OVRZRC8yRnY3cFlCQlBsSC9tcTZjOURscGJJMEJHZTNJU3pWdFF3VHBW?=
 =?utf-8?B?UGx3VjFYd0VyUmE0N1kzcVFFYVBsWFpvUUxjekhYTXBQV3BJckJGSzd1MjM2?=
 =?utf-8?B?ZkxBeFByaUNnWVFqNS9wSE9HdGtIektKMzNFTlBJbTNVTjA0RVhyVWxMWlkv?=
 =?utf-8?B?TUF5akpEWVBDbFBaRlIzRVMzc0VZazQySmptL1d5REZkUXJvWWpXYjBnQlFX?=
 =?utf-8?B?TURFMzM5Rm1sYmU5bFdSbWFMSkJRZlVrekEvbzlVS3VCcW9zV3h1LzhVb09E?=
 =?utf-8?B?REhxNlFLT1MvdlZ1Z1FKZFZxbEtNVUthVzBHTktXd2ZjcGNrQkhzQlJpQ2ZF?=
 =?utf-8?B?dG43RSs3dERuMjJMV1BlN3V1N096RXhzRFcyakQyWTYrSW5GM29YSXpzaDlG?=
 =?utf-8?B?UjNjRXFGRXJKVzBFTFJaK0NMaHkzTUZUVVdWTGtYaGV4MVYvcGFkWnBqRWVj?=
 =?utf-8?B?eXlSTmhrU0VVcXVOMVVTdWVzU3lYWUpmVnlIYmQzK0t4c2JidXdyNGR0SlVw?=
 =?utf-8?B?WEdKa0Y5clZQRU1vd3JCWE1qRGxDNzNzQjB2c0R2ZmtCQmJQemFncnB2MmFw?=
 =?utf-8?B?K1BMWWpZVnhzS3hKRlllb3dMQjlSa2s0TXRJZmFZMkJ5dkpOYXhDQ0xOL0Ju?=
 =?utf-8?B?ZU00NUZNd2FFVEdaYjFybXJ6eWFuMDgxOWFCQkprRTRjc1lTSHFPYW5zMkov?=
 =?utf-8?Q?NnurYDCtCpVSbeQJZgdNp+xiL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cc7573-0a39-4e65-72cb-08dac87ee34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 09:34:13.1102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qD5XXbnVaN9ltRDWRN+yf83iU8zDFQitErUItr2/J2XPeHuMh3pSTtONh2iOc1osshCoXQGbG4JiCg8W978t7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEJhZ2FzIFNhbmpheWEgPGJhZ2FzZG90bWVAZ21haWwuY29t
Pg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTcsIDIwMjIgNDo1OCBQTQ0KPiBUbzogWXVh
biwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gQ2M6IHJhZmFlbC5qLnd5c29ja2lAaW50
ZWwuY29tOyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IA0KPiB2aXJlc2gua3VtYXJA
bGluYXJvLm9yZzsgTGltb25jaWVsbG8sIE1hcmlvIA0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1k
LmNvbT47IEZvbnRlbm90LCBOYXRoYW4gDQo+IDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47IERl
dWNoZXIsIEFsZXhhbmRlciANCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBTaGFybWEs
IERlZXBhayA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPjsgDQo+IEh1YW5nLCBTaGltbWVyIDxTaGlt
bWVyLkh1YW5nQGFtZC5jb20+OyBNZW5nLCBMaSAoSmFzc21pbmUpIA0KPiA8TGkuTWVuZ0BhbWQu
Y29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgS2FybnksIFd5ZXMgDQo+
IDxXeWVzLkthcm55QGFtZC5jb20+OyBTaGVub3ksIEdhdXRoYW0gUmFuamFsIDxnYXV0aGFtLnNo
ZW5veUBhbWQuY29tPjsgDQo+IE5hcmF5YW4sIEFuYW50aCA8QW5hbnRoLk5hcmF5YW5AYW1kLmNv
bT47IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgDQo+IGxpbnV4LSBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNC81XSBEb2N1bWVudGF0aW9uOiBhbWQt
cHN0YXRlOiBhZGQgZHJpdmVyIA0KPiB3b3JraW5nIG1vZGUgaW50cm9kdWN0aW9uDQo+IA0KPiBP
biBUaHUsIE5vdiAxNywgMjAyMiBhdCAwMzozNTo0MFBNICswODAwLCBQZXJyeSBZdWFuIHdyb3Rl
Og0KPiA+IEludHJvZHVjZSB0aGUgYGFtZF9wc3RhdGVgIGRyaXZlciBuZXcgd29ya2luZyBtb2Rl
IHdpdGggDQo+ID4gYGFtZF9wc3RhdGU9cGFzc2l2ZWAgYWRkZWQgdG8ga2VybmVsIGNvbW1hbmQg
bGluZS4NCj4gPiBJZiB0aGVyZSBpcyBubyBwYXNzaXZlIG1vZGUgZW5hYmxlZCBieSB1c2VyLCBh
bWRfcHN0YXRlIGRyaXZlciB3aWxsIA0KPiA+IGJlIGRpc2FibGVkIGJ5IGRlZmF1bHQgZm9yIG5v
dy4NCj4gPg0KPiA+PHNuaXBwZWQ+Li4uDQo+ID4gLS4uIF9zaGFyZWRfbWVtOg0KPiA+IC0NCj4g
PiAtYGBzaGFyZWRfbWVtYGANCj4gPiAtVXNlIGEgbW9kdWxlIHBhcmFtIChzaGFyZWRfbWVtKSB0
byBlbmFibGUgcmVsYXRlZCBwcm9jZXNzb3JzDQo+IG1hbnVhbGx5DQo+ID53aXRoICAtKiphbWRf
cHN0YXRlLnNoYXJlZF9tZW09MSoqLg0KPiA+IC1EdWUgdG8gdGhlIHBlcmZvcm1hbmNlIGlzc3Vl
IG9uIHRoZSBwcm9jZXNzb3JzIHdpdGggYFNoYXJlZCBNZW1vcnkgDQo+ID5TdXBwb3J0ICAtPHBl
cmZfY2FwXz5gXywgd2UgZGlzYWJsZSBpdCBwcmVzZW50bHkgYW5kIHdpbGwgcmUtZW5hYmxlIA0K
PiA+dGhpcyBieSBkZWZhdWx0ICAtb25jZSB3ZSBhZGRyZXNzIHBlcmZvcm1hbmNlIGlzc3VlIHdp
dGggdGhpcyBzb2x1dGlvbi4NCj4gPiAtDQo+ID4gLVRvIGNoZWNrIHdoZXRoZXIgdGhlIGN1cnJl
bnQgcHJvY2Vzc29yIGlzIHVzaW5nIGBGdWxsIE1TUiBTdXBwb3J0IA0KPiA+PHBlcmZfY2FwXz5g
XyAgLW9yIGBTaGFyZWQgTWVtb3J5IFN1cHBvcnQgPHBlcmZfY2FwXz5gXyA6IDo6DQo+ID4gLQ0K
PiA+IC0gIHJheUBoci10ZXN0MTp+JCBsc2NwdSB8IGdyZXAgY3BwYw0KPiA+IC0gIEZsYWdzOiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGZwdSB2bWUgZGUgcHNlIHRzYyBtc3IgcGFlIG1jZSBj
eDggYXBpYyBzZXAgbXRyciBwZ2UNCj4gbWNhIGNtb3YgcGF0IHBzZTM2IGNsZmx1c2ggbW14IGZ4
c3Igc3NlIHNzZTIgaHQgc3lzY2FsbCBueCBtbXhleHQgDQo+IGZ4c3Jfb3B0IHBkcGUxZ2IgcmR0
c2NwIGxtIGNvbnN0YW50X3RzYyByZXBfZ29vZCBub3BsIG5vbnN0b3BfdHNjIA0KPiBjcHVpZCBl
eHRkX2FwaWNpZCBhcGVyZm1wZXJmIHJhcGwgcG5pIHBjbG11bHFkcSBtb25pdG9yIHNzc2UzIGZt
YSBjeDE2IA0KPiBzc2U0XzENCj4gc3NlNF8yIHgyYXBpYyBtb3ZiZSBwb3BjbnQgYWVzIHhzYXZl
IGF2eCBmMTZjIHJkcmFuZCBsYWhmX2xtIA0KPiBjbXBfbGVnYWN5IHN2bSBleHRhcGljIGNyOF9s
ZWdhY3kgYWJtIHNzZTRhIG1pc2FsaWduc3NlIDNkbm93cHJlZmV0Y2ggDQo+IG9zdncgaWJzIHNr
aW5pdCB3ZHQgdGNlIHRvcG9leHQgcGVyZmN0cl9jb3JlIHBlcmZjdHJfbmIgYnBleHQgDQo+IHBl
cmZjdHJfbGxjIG13YWl0eCBjcGIgY2F0X2wzDQo+IGNkcF9sMyBod19wc3RhdGUgc3NiZCBtYmEg
aWJycyBpYnBiIHN0aWJwIHZtbWNhbGwgZnNnc2Jhc2UgYm1pMSBhdngyIA0KPiBzbWVwDQo+IGJt
aTIgZXJtcyBpbnZwY2lkIGNxbSByZHRfYSByZHNlZWQgYWR4IHNtYXAgY2xmbHVzaG9wdCBjbHdi
IHNoYV9uaSANCj4geHNhdmVvcHQgeHNhdmVjIHhnZXRidjEgeHNhdmVzIGNxbV9sbGMgY3FtX29j
Y3VwX2xsYyBjcW1fbWJtX3RvdGFsIA0KPiBjcW1fbWJtX2xvY2FsIGNsemVybyBpcnBlcmYgeHNh
dmVlcnB0ciByZHBydSB3Ym5vaW52ZCBjcHBjIGFyYXQgbnB0IA0KPiBsYnJ2IHN2bV9sb2NrIG5y
aXBfc2F2ZSB0c2Nfc2NhbGUgdm1jYl9jbGVhbiBmbHVzaGJ5YXNpZCBkZWNvZGVhc3Npc3RzIA0K
PiBwYXVzZWZpbHRlciBwZnRocmVzaG9sZCBhdmljIHZfdm1zYXZlX3ZtbG9hZCB2Z2lmIHZfc3Bl
Y19jdHJsIHVtaXAgcGt1IA0KPiBvc3BrZSB2YWVzIHZwY2xtdWxxZHEgcmRwaWQgb3ZlcmZsb3df
cmVjb3Ygc3VjY29yIHNtY2EgZnNybQ0KPiA+IC0NCj4gPiAtSWYgdGhlIENQVSBmbGFncyBoYXZl
IGBgY3BwY2BgLCB0aGVuIHRoaXMgcHJvY2Vzc29yIHN1cHBvcnRzIGBGdWxsIA0KPiA+TVNSIFN1
cHBvcnQgIC08cGVyZl9jYXBfPmBfLiBPdGhlcndpc2UsIGl0IHN1cHBvcnRzIGBTaGFyZWQgTWVt
b3J5DQo+IFN1cHBvcnQgPHBlcmZfY2FwXz5gXy4NCj4gPiArUGFzc2l2ZSBNb2RlDQo+ID4gKy0t
LS0tLS0tLS0tLQ0KPiA+ICsNCj4gPiArYGBhbWRfcHN0YXRlPXBhc3NpdmVgYA0KPiA+ICsNCj4g
PiArSXQgd2lsbCBiZSBlbmFibGVkIGlmIHRoZSBgYGFtZF9wc3RhdGU9cGFzc2l2ZWBgIGlzIHBh
c3NlZCB0byB0aGUgDQo+ID4gK2tlcm5lbCBpbg0KPiB0aGUgY29tbWFuZCBsaW5lLg0KPiA+ICtJ
biB0aGlzIG1vZGUsIGBgYW1kX3BzdGF0ZWBgIGRyaXZlciBzb2Z0d2FyZSBzcGVjaWZpZXMgYSBk
ZXNpcmVkIA0KPiA+ICtRb1MgdGFyZ2V0IGluIHRoZSBDUFBDIHBlcmZvcm1hbmNlIHNjYWxlIGFz
IGEgcmVsYXRpdmUgbnVtYmVyLiBUaGlzIA0KPiA+ICtjYW4gYmUgZXhwcmVzc2VkIGFzIHBlcmNl
bnRhZ2Ugb2Ygbm9taW5hbCBwZXJmb3JtYW5jZSANCj4gPiArKGluZnJhc3RydWN0dXJlIG1heCku
IEJlbG93IHRoZSBub21pbmFsIHN1c3RhaW5lZCBwZXJmb3JtYW5jZSANCj4gPiArbGV2ZWwsIGRl
c2lyZWQgcGVyZm9ybWFuY2UgZXhwcmVzc2VzIHRoZSBhdmVyYWdlIHBlcmZvcm1hbmNlIGxldmVs
IA0KPiA+ICtvZiB0aGUgcHJvY2Vzc29yIHN1YmplY3QgdG8gdGhlIFBlcmZvcm1hbmNlIFJlZHVj
dGlvbiBUb2xlcmFuY2UgDQo+ID4gK3JlZ2lzdGVyLiBBYm92ZSB0aGUgbm9taW5hbCBwZXJmb3Jt
YW5jZSBsZXZlbCwgcHJvY2Vzc29yIG11c3QgDQo+ID4gK3Byb3ZpZGUgYXQgbGVhc3Qgbm9taW5h
bA0KPiBwZXJmb3JtYW5jZSByZXF1ZXN0ZWQgYW5kIGdvIGhpZ2hlciBpZiBjdXJyZW50IG9wZXJh
dGluZyBjb25kaXRpb25zIGFsbG93Lg0KPiA+DQo+ID4NCj4gPiAgYGBjcHVwb3dlcmBgIHRvb2wg
c3VwcG9ydCBmb3IgYGBhbWQtcHN0YXRlYGANCj4gPg0KPiANCj4gV2h5IGRvIHlvdSByZXBsYWNl
IHNoYXJlZF9tZW0gc3Vic2VjdGlvbiB3aXRoIHBhc3NpdmUgbW9kZSBzZWN0aW9uPyBJdCANCj4g
aXNuJ3QgYmUgbWVudGlvbmVkIGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbi4NCnNoYXJlZF9tZW0g
aXMgbm90IG5lZWRlZCBhbnkgbW9yZSwgIGlmIG5vIGNwcGMgZmxhZyBkZXRlY3RlZCBmb3IgTVNS
IHN1cHBvcnQsIHBzdGF0ZSBkcml2ZXIgd2lsbCB1c2Ugc2hhcmVkIG1lbW9yeSBpbnRlcmZhY2Uo
Y3BwYyBhY3BpKSB0byBzZXQvZ2V0IHBlcmYgdmFsdWVzIHRvIHRoZSBsb3ctbGV2ZWwgZmlybXdh
cmUuDQpUaGVyZSBhcmUgdHdvIHR5cGUgQ1BQQyAgb25seSBpbiB0aGUgYW1kIGNwcGMgaW1wbGVt
ZW50YXRpb24uIA0KUmVtb3Zpbmcgc2hhcmVkX21lbSAgcGFyYW1ldGVyIHdpbGwgbWFrZSBpdCBz
aW1wbGUgdG8gbG9hZCBhbWQgcHN0YXRlIGRyaXZlciBub3cuDQoNClBlcnJ5LiANCg0KPiANCj4g
LS0NCj4gQW4gb2xkIG1hbiBkb2xsLi4uIGp1c3Qgd2hhdCBJIGFsd2F5cyB3YW50ZWQhIC0gQ2xh
cmENCg==
