Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ACF5E9487
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiIYQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIYQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:58:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914DE2B276;
        Sun, 25 Sep 2022 09:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uvr5e5X7cWLMIyNFwdSAMHGaKOuETYK63PzK8Y/q6Nnux1MMzL6cc1LYv9RyB7B141k98zKGIZZDBCPQnpK1m1J6vV3jLDv/GYdlYDloj4Q6PRzK2Pkk4TAgPVIPTDkQjMtZbKQNnGFvE0W76BzSH/z1+FhOoTlIdtLV21cZrF20iZTMAYMtGZax9y622gks6t4RH/aikW67y8DfME5bttH/nzt5P4ROivjMxbSzMFI87mV4nH8iCiIiAp44MYNNmio+QcDTnWX0Jcb2AgEQAq5IZmQIMwA9H3RJUUQRkdJphF6EZjtiAIesprtgXcKUaF/YOVOOh44LbWrNKlZxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3StT6JPLj5IgGwyP7QY3cQNmS6pHRKdJ45NipMwnqXk=;
 b=LuF57NiCKii4XnJ/cTvW25NdXDspo4wid6Bxq8rR/Dke2mOgpK1caB/XaxMuTMtBT066oNiKo0G9SlEx7kk6OP5N68Ya9opa1FamJ2MFAE50WVhW6ESKdwj/lu3ozqw9pV8HWlW5m49qXwCHSpHkJcsfVXCSFB46KhcNF+K8UDXZxjixdvzFk/suxUy8y+KP/CMPTS/X4yi1Kw+CjJsDETZvG+cgMe5R86aHkajQ6/YIesZwK2GooPa2OyDS8id9iYHc5AQqNjnTqIqGjd+xHXMeGyMGQccMBt2/oMODXlFZmgxGBlxT0NBQmLErLTVVjLRNBW69czXEPPsOdr6tVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3StT6JPLj5IgGwyP7QY3cQNmS6pHRKdJ45NipMwnqXk=;
 b=u8ThinUoXrzuyKD6sWXp0/lXvi8S2Za1jVPu2qWHMm7j6ZY6gcnEM0oEPGni3Y0dsFajMM7w8qSyaBe5TBXXAw5OGTnOhMaY8udbalwnZwkSNL6O3Ewoq0eafrjuAL/LIfFg8sRp4U7VVQbAwOxkhifbC6tISzcjWBtdoQg6DUY=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 16:58:52 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128%6]) with mapi id 15.20.5654.024; Sun, 25 Sep 2022
 16:58:52 +0000
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
Thread-Index: AQHYxGvMfyM5wc0bSEifIZSI5R0+Ja3XcP6AgBkGIkA=
Date:   Sun, 25 Sep 2022 16:58:52 +0000
Message-ID: <DM4PR12MB52788F8644FE308871E1883C9C539@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-3-Perry.Yuan@amd.com>
 <abb1ec0e-2a1f-09bc-f11c-8e5be4526927@amd.com>
In-Reply-To: <abb1ec0e-2a1f-09bc-f11c-8e5be4526927@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-25T16:58:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=42dc7f49-9be8-404c-8e7a-a0dfc842b8e4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-25T16:58:48Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: abd89521-e5c2-4c7e-8bee-645e27a9a596
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY8PR12MB7100:EE_
x-ms-office365-filtering-correlation-id: e937a83d-d6d1-4c0f-65fe-08da9f173995
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WQqsklsOjUVYeK6tKEM2J8oChRj/uC/+cHxMgip1poBu0uUkLa1d3prxuP/x6SvP2N2xP3ITpMO/9L04+0JiLipCT4MRrzyYgQFL53mYcKzUyOyQmmz1D5f3Ci83f9opvKAicKY6lKeYckKpr9YtC7nlKpML3Qy7Q9EZyDmdDLhLT8UQIHeE0N+EBDhG2w0OGrRmbAkno+5NG37niE/VbffBqZ1mIoOwf6A9CDfSU5y/pAv0c37jHn/748OG5ysaaL8944ZjktFT9+dNDIB8TFaoWQLZuBFIGqstaK5NGpv1j9VfyrXEj2jdP6T0I67chWZVIWtIxTrE9aVIRrvf1cRESHocpsFlbTVte4S64G4WI33uMVj+J9QGK2MLn+yiC9YBEwhufs9QNkRwWSp0peRi6l9j55pUe9w8mcFjE8nmXaq+oIUkkgBzExJ8fH4osAoveS7WKa/r73+RJ+HEICgi+UBKsuV3LFx7XuSX2s38u98VXgoB5+qyLiL/V6axrS/Jnpn+Huzqn5KwqwamRIMcGgqm70FW+pIcf8xpV/CWsEqhE/bkVSpHnW104cbwUk2k6YvinmeRa4NcruDnvH3tDnJvWtgeeeuRVVoRTBmMvHiK85b5zDBXc41zyvI9QCdMjCtZtYpEaLiJzlZXAKKe4yJTiEZqW02UcFbWp6rtAccRG97UQ8awD8B5jmtJ8uwBETLFZVjDO2ggWrL13i+uxnBQZ0X++bwvU+gNcxZt39Q40qjSRFh34kc70RRFsA6/8LOkOk/7H7DBCmq0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(110136005)(54906003)(316002)(38070700005)(5660300002)(55016003)(52536014)(8936002)(33656002)(66556008)(86362001)(66446008)(64756008)(8676002)(66946007)(66476007)(76116006)(41300700001)(2906002)(4326008)(9686003)(26005)(71200400001)(186003)(478600001)(6506007)(7696005)(53546011)(38100700002)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2RFekRnODVFNTlvaFQ4RG10RGtaYnJRMU1FWHFEOFdndU9CM1RZL2x1SlM2?=
 =?utf-8?B?RitFMGVpUlQ4WnpHSDJpY2JsUlZxamkxL282UGFqUUk4aGhUZU1mZzF6UlVE?=
 =?utf-8?B?UHhnV3QxS3pjV01CYytLTzdrU1NQenc5ejBtMWwyc1h2MnlUV2FuZ1lEblhI?=
 =?utf-8?B?SEY4bzJFRWRnOW0zeUNGb0tnRzFkTHBhWkk0eWFBUjIwTVQvei9rRmhTS3lO?=
 =?utf-8?B?U09rMHJjankyYTVGaHI5d2lsc2pPRGo2T3l0dzJlVkZ1dFNMR0sxUVhoRHJy?=
 =?utf-8?B?eUxzc2U0U2pKYkxhdUtlMUFnWSs0SHJtZEEzS0VzZlhDNUt1dmFsSW1EZ0oy?=
 =?utf-8?B?cXNBcDVpOWloN0w5L2Y5MTJ2RlhCcXZCcWxoeExOc21EQTR6NFBPOWxpTW9E?=
 =?utf-8?B?bkNhVndhTzBRc3dtdnJSWVFlMVhUbERyNEdLRWlTc0lUSEpWT1g2Qk9VSmJx?=
 =?utf-8?B?ZmlPWjFlTVMxOUt6WE5rK2FMa1l4M2cyaWVNazNjTk5qYW82eXFLcHRnNzJ5?=
 =?utf-8?B?VHFxd1RTUFp3T1lKeEtRdnBZRVdTTUw4NU4wNXJ3emc1RVYzT0UyZWsxQVRa?=
 =?utf-8?B?V0k4ZWtJZU5vSnNxNUx1SjRwV1ZMOHloV1ZIWFFTK3FlcGQxcUhDdmVnUC85?=
 =?utf-8?B?emUzcW9yNlFlTEZmRk9tdWFIR01UNDg3dHltLzg5Ni9jQ000ME13YVR2WTM1?=
 =?utf-8?B?OU04S1RjMHVZU0FZT1ozOEthWmJWWnZ1WHJXdWpySllaT0hDcEN1cmFDb2p1?=
 =?utf-8?B?Ti9zUlJOT3VHMnNLK1Nydm9UbkRZSTFKNzNTWkdiTkpUWEJKd3RkQjV0UStM?=
 =?utf-8?B?WE5NM3U1NERGeHdIYkhOL0VjamRGSUR0bGc1cy91UW53MWhYSitBUTZ1ekVx?=
 =?utf-8?B?emFVSHhxRjlDeUFNK093eXlJL05FRlRHdHVzb21nRHNaYVFtZjJiV3hENDVi?=
 =?utf-8?B?Y2VxeDZoZllBeGFYTURXVUt0bUFuRGMrRkFHZWtDUWQzbUt4MkxUUTJZYVVJ?=
 =?utf-8?B?U2k2eG8vVDFraStPR1B3czBFa1FsVU13T2hXV040VlN0aXY1T2NRdjVXRVhG?=
 =?utf-8?B?eEhBaWlyRmY2ck1mTmxqbnk2QjhOb2pGcS93bStINklMK256WktLV21OcGhr?=
 =?utf-8?B?QmVlL2xtc3lJYUZnZ2RLd1VWMkZHTDVob0l6TWFJZ05iSnBKMmh0eWFoY0RO?=
 =?utf-8?B?alZJRllYcEdQVm1XZkVXQkFPb05QVHpHRndtcWVKZGNBRGpJM0taWHNoeUlz?=
 =?utf-8?B?LzlpeEY2YVVaSVo2ald5SElsM0dKTG5KM0NsNnZxaWFLN2hGVUdrc2RRRExy?=
 =?utf-8?B?TzV5RWtDQ0xSSUJDU0p3VE1KempBcnA2Q1k3MnhuMzhxTjMwN1hXNjZUcTYw?=
 =?utf-8?B?ODlPNGtiZm94ZzkrRFI4NU9FaU9GdHZVb293U3pnMGV0QUZsVmlHMXVIMzR1?=
 =?utf-8?B?Z2NyVUt4Yyt0TFVST25uOHdaTDV6UGZtMXJhd0dpNFozRExBWTV0MmcvM1c0?=
 =?utf-8?B?dVpJNFp5OWtXbDQ1czQrZlFBMlk3L1BobWluRkcwUlNrUUt6QTk1Y2FtTDdF?=
 =?utf-8?B?SXo4Q2VSZXEveThITHBPay9lS0d0ajVKT2dYSDIvZmF2SkZCYkRkVHRMaU1i?=
 =?utf-8?B?NjA4d3owVTNnUmprSEpaRWtYYVU2VVgxdi9CQTNINmhOS0JTdS9UWXZDMWZZ?=
 =?utf-8?B?eG4rbVhMaUFEck5ORUdRa0lUaE5sRStMR2ZaNkJWUjg2Q0J1cnB4c01qSmpl?=
 =?utf-8?B?RER5SDNBODRCMGNlVkFBeURudXFXcVNNZ2kzSWQweC9US1ROQ0NONjNwY1Nm?=
 =?utf-8?B?Yk1LRmdlZlBBZXN1elBsNTVCWG9zZDNTN3dkaEwwcXVXQW9oQTd2b2N2azJU?=
 =?utf-8?B?dFYzZXlzRzQ3ejZFQ0RGMnBnelgvVzlvbTJBSWJTVk1rdHd5d3ZhcUtQamZo?=
 =?utf-8?B?aVpOYzZhcWRTRFFhK05uRGYxS2xISFdIMEdpakEzZkZNR1l6QlRaOUpQaWQ2?=
 =?utf-8?B?NnJ5bWYwcUo2SFRSSEdLNkcvajN0OEoySjg3Z01xakgyK2NDM0IvNlJvUlhk?=
 =?utf-8?B?SGJVMW9Xc3pFaTlDKzJEUDlrTjU5MjZOVmxuOVFLeW02am1MUEFYQTh2NjNw?=
 =?utf-8?Q?6jGP631ls54PHXAdTxe0BZw//?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e937a83d-d6d1-4c0f-65fe-08da9f173995
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2022 16:58:52.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzlzC/8z58TlXI9Z9CccP65SVpfcEZ0XbCm6zcSBI+7vNVytP3leP5g+heorVgw+8yqr6+x3afy5ylqae9Gk0w==
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLiANCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMTAsIDIw
MjIgMjo1MCBBTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFl
bC5qLnd5c29ja2lAaW50ZWwuY29tOyBIdWFuZywNCj4gUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47
IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnDQo+IENjOiBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNo
YXJtYUBhbWQuY29tPjsgRm9udGVub3QsIE5hdGhhbg0KPiA8TmF0aGFuLkZvbnRlbm90QGFtZC5j
b20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBT
dSwgSmluemhvdSAoSm9lKSA8SmluemhvdS5TdUBhbWQuY29tPjsNCj4gSHVhbmcsIFNoaW1tZXIg
PFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbg0KPiA8WGlhb2ppYW4uRHVAYW1k
LmNvbT47IE1lbmcsIExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IGxpbnV4LQ0KPiBw
bUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAyLzddIGNwdWZyZXE6IGFtZF9wc3RhdGU6IGFkZCBtb2R1bGUgcGFyYW1l
dGVyIHRvDQo+IGxvYWQgYW1kIHBzdGF0ZSBFUFAgZHJpdmVyDQo+IA0KPiBPbiA5LzkvMjAyMiAx
MTo0NSwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBUaGUgYW1kX3BzdGF0ZSBtb2RlIHBhcmFtZXRl
ciB3aWxsIGFsbG93IHVzZXIgdG8gc2VsZWN0IHdoaWNoIGFtZA0KPiA+IHBzdGF0ZSB3b3JraW5n
IG1vZGUgYXMgYm9vdGluZyBtb2RlLCBhbWRfcHN0YXRlIGluc3RhbmNlIG9yDQo+IGFtZF9wc3Rh
dGVfZXBwIGluc3RhbmNlLg0KPiA+DQo+ID4gMSkgYW1kX3BzdGF0ZSBpbnN0YW5jZSBpcyBkZXBl
bmRpbmcgb24gdGhlIHRhcmdldCBvcGVyYXRpb24gbW9kZS4NCj4gPiAyKSBhbWRfcHN0YXRlX2Vw
cCBpbnN0YW5jZSBpcyBkZXBlbmRpbmcgb24gdGhlIHNldF9wb2xpY3kgb3BlcmF0aW9uDQo+IG1v
ZGUuSXQNCj4gPiAgICAgaXMgYWxzbyBjYWxsZWQgYWN0aXZlIG1vZGUgdGhhdCBBTUQgU01VIGhh
cyBFUFAgYWxnb3JpdGhtIHRvIGNvbnRyb2wgdGhlDQo+ID4gICAgIENQVSBydW50aW1lIGZyZXF1
ZW5jeSBhY2NvcmRpbmcgdG8gdGhlIEVQUCBzZXQgdmFsdWUgYW5kIHdvcmtsb2FkLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyB8IDYgKysrKysrDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3Rh
dGUuYyBpbmRleCBhMjQ2M2Y3ODUzMjIuLjQ1MTI5NTI4NGEyNiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2Ft
ZC1wc3RhdGUuYw0KPiA+IEBAIC01OCw2ICs1OCwxMiBAQCBtb2R1bGVfcGFyYW0oc2hhcmVkX21l
bSwgYm9vbCwgMDQ0NCk7DQo+ID4gICBNT0RVTEVfUEFSTV9ERVNDKHNoYXJlZF9tZW0sDQo+ID4g
ICAJCSAiZW5hYmxlIGFtZC1wc3RhdGUgb24gcHJvY2Vzc29ycyB3aXRoIHNoYXJlZCBtZW1vcnkN
Cj4gc29sdXRpb24NCj4gPiAoZmFsc2UgPSBkaXNhYmxlZCAoZGVmYXVsdCksIHRydWUgPSBlbmFi
bGVkKSIpOw0KPiA+DQo+ID4gK3N0YXRpYyBib29sIGVwcF9lbmFibGVkID0gdHJ1ZTsNCj4gPiAr
bW9kdWxlX3BhcmFtKGVwcF9lbmFibGVkLCBib29sLCAwNDQ0KTsNCj4gTU9EVUxFX1BBUk1fREVT
QyhlcHBfZW5hYmxlZCwNCj4gPiArICAgICAgICAgICAgICAgICJsb2FkIGFtZF9wc3RhdGUgb3Ig
YW1kX3BzdGF0ZV9lcHAgKHRydWUgPQ0KPiA+ICthbWRfcHN0YXRlX2VwcCBkcml2ZXIgaW5zdGFu
Y2UgKGRlZmF1bHQpLCBmYWxzZSA9IGFtZF9wc3RhdGUgZHJpdmVyDQo+ID4gK2luc3RhbmNlKSIp
Ow0KPiA+ICsNCj4gDQo+IElmIHlvdSdyZSBvcGVyYXRpbmcgaW4gRVBQIG1vZGUgb3Igbm90IHRo
ZSBrZXJuZWwgbW9kdWxlIGlzIHN0aWxsICdhbWQtcHN0YXRlJy4NCj4gU28gdG8gYSB1c2VyIEkg
dGhpbmsgdGhpcyBpcyBhIHByZXR0eSBjb25mdXNpbmcgZGVzaWduYXRpb24uDQo+IA0KPiBJIHdv
dWxkIHByb3Bvc2UgdGhlIGZvbGxvd2luZyBpbnN0ZWFkOg0KPiANCj4gID4gK3N0YXRpYyBib29s
IGVwcCA9IHRydWU7DQo+ICA+ICttb2R1bGVfcGFyYW0oZXBwLCBib29sLCAwNDQ0KTsNCj4gID4g
K01PRFVMRV9QQVJNX0RFU0MoZXBwLA0KPiAgPiArICAgICAgICAgICAgICAgICJFbmFibGUgZW5l
cmd5IHBlcmZvcm1hbmNlIHByZWZlcmVuY2UgKEVQUCkgY29udHJvbCIpOw0KPiANCg0KTWFrZSBz
ZW5zZSB0byBtZSwgZ2V0IHRoaXMgY2hhbmdlZCBpbiBWMiBsaWtlIHlvdSBzdWdnZXN0ZWQuDQpU
aGFua3MuDQoNCj4gPiArDQo+ID4gICBzdGF0aWMgc3RydWN0IGNwdWZyZXFfZHJpdmVyIGFtZF9w
c3RhdGVfZHJpdmVyOw0KPiA+DQo+ID4gICAvKioNCg==
