Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD165E558
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjAEGCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAEGCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:02:49 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6737A5132D;
        Wed,  4 Jan 2023 22:02:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/2cHuPZLkZI2ltFUXPvSN4Vcr+1aDLa5j8KRR/qe04NnHUt+FPB/yLjzgzLuPlpLS5fsc8FxB8i1uUhGj8dwOrVkV3w4YLD//RaSBZ0aY7CVlyooIntpQ0/0XL1ihMyT797MhcmgP+uDDL61GVCXN1xPmrqxzNIxhB8EpQ2H/E2YBLQz1uM5Le+LjBGNukTWJBDgbSw0GUo8nDEAbmDVcQF4f2G7TOjD1kE8SWwqrd/vDYsA2bbYtE2Nm5ygnpPQFkvNGAmD8ehApvuxtp0hJRfnJel0oXJo63LKKzwWNNtaG04uRzLIOuUJN09rNOEqKVNmMjtEyqXoJi/FmbaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBt9iVH8Y4ICc0aCEa6axmsPCAPD39ZxV8ZmZOCj8P0=;
 b=iyx/wwsREdmerkvG7Qc1D1CgchTEme2tk0dxNL+GQeEEEoNULvpJW1d9mRWed0OTXTKVIuk9ql9tdK5moN9q+lNEsDYR3oX5AUodw12I20KmI1sDlMdX2pQhIYVdxcyn8I78IAyru6B0y+1pHg8kUSNlxd3/9xtiYqqt2ZFsCWCzZIrpT4PwviSH7RMo6MFQX9crHGMGudM4sh/yw0MmE33aGEmTEvYQ9xdUy46hp/r47wEGm3cB4qznn9yUQoBRZHx/JqLGUZwHEEol9/sw31B5GYdGRn2+U813ZHyRkdDgE48sr7dishGrngt2rL8w4TG//wjiDverj0XPGFkDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBt9iVH8Y4ICc0aCEa6axmsPCAPD39ZxV8ZmZOCj8P0=;
 b=Su2VSjpKuLortJDQgclJzPE4lRzVDYN+mk5vHFjuVa3QTGE+fDikyvj2oELCevtkRjgjPJV8cvXirLpyubh9m+OaYKW0UNuZE3GQr95JNiMiNKPC5c7P+G6yU4ivH9HuSFt0n30WzHYeemP7O9tF6EoG9ZR5PFpqzylNH/XJKao=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:02:46 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:02:46 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Thread-Topic: [PATCH v9 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Thread-Index: AQHZGH7jvyKg2shHDUibO2UlusywdK6PXN2AgAAFSdA=
Date:   Thu, 5 Jan 2023 06:02:46 +0000
Message-ID: <DM4PR12MB5278359194E710FA04F0D2149CFA9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-2-perry.yuan@amd.com>
 <f274aef5-88f4-2f46-e2f7-b8581e38cac2@amd.com>
In-Reply-To: <f274aef5-88f4-2f46-e2f7-b8581e38cac2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-05T06:02:41Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=84d6c4be-c9be-49a9-953f-d46c50e97ae8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-05T06:02:41Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9132a7d5-7855-41d7-b7ee-23ef5ea448f4
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|DM4PR12MB5118:EE_
x-ms-office365-filtering-correlation-id: c617b12b-4721-419e-0d55-08daeee277af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBCT8XRkITjQPU2eLAUoccZRf2SRoEfR4+Hoi36GbYtNIhPhKnzBM+yv3FTr86FBasrllU3lekn3wVBZi+AQQz8am7cIuc3zc5qUhrxviBi17Tc/PMTKRdSWTCNlWdKaItdgQJUqMODoxmk5qrY42vscfNcZAOgiQ/44NDdQf4wbEK1X63T421vWlPMTCSv8p0W54pZUprjg+jy/Aqbx0tpCouWCIxhQkRxWvlSjnSaCjiwhpEAZ+Sh3l28cklrTrgnHxnwdfSvdRCkGZXwMg6iUPn3qTNotre3vbuwQ1rKXLp0dZX9YABb2KubnCXdqifeT8E2FNM9nI59qAFNsgNba2nr/SecBxcTEsXtrRaw7wG4zBRXjN2ghRfVG8V0VmoiBAQ18/BnrqhFCW8W8Y0cs5xsexBKLOQ1sLt8CsEKPn2V085SmiqKq5ntpndNaO7gl/tnzJIh4FS3CMmC0BKc4IXKCSyuZR28lYPsSh/kF2gG3bGtRC9+x9e40bt2XDo6MO7cUOukPLluZ1M74FSba8DwpiL3joXGSS6+H9um+bkBfyGPzFEc5ayJ3JGMTkzGk35YagAzBlRiu0Y9MeTcNO0Qz5kjsBOGvMO5F+GN1D5mD/aye+jL0aCi3jwkpSHy+caKEw+QaOawWQZilzjqs+w0xtn79+sra4SZQrFTZXHNzf1Kdbf6JMsvgt31tWttHzhLYpM3o6bx77NWjdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199015)(83380400001)(55016003)(86362001)(33656002)(38070700005)(38100700002)(122000001)(4326008)(2906002)(52536014)(316002)(110136005)(54906003)(41300700001)(66556008)(66946007)(8936002)(5660300002)(76116006)(66446008)(64756008)(66476007)(8676002)(186003)(9686003)(53546011)(478600001)(26005)(6506007)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFBrblRqclQ1RHF2c29DT0tHSnZDTHZ3Wmw0TnUxUGU4NUNxUWt3c01NdXl2?=
 =?utf-8?B?UC9RYmRDUng5RDRyd0J6cnZjaGp2d1ZrR1JqYjIvWGNQSzI2Smp2N09lMmo3?=
 =?utf-8?B?b1dNTjFROVFBNW1uVEExbFMxNHhFQ2h4aVM0dHY4d3BISUxqQUFnRDJuSVg4?=
 =?utf-8?B?dkRzRkJhaEsva3l1ZklFOTFxaGxSb3FzdmU0MjZlYit2cGVUb3hBckdsMDZ0?=
 =?utf-8?B?Nk44THNyeXZwQS9qRUw0QTZkUEhzUjdxK1BtTGNYekJSQWw3djg0SklzczB5?=
 =?utf-8?B?Yk0wZnhHN0ZLdkdOMVZxU3NQbjZDMEM4NzJaOFhyU3o4WFlvZE9hWkFTbmM1?=
 =?utf-8?B?MVpYYkdsY3huc3U0QmtGK21wdG1vdTRmcXcrTDNnY1BWM2UxM0N0V0l4NGdr?=
 =?utf-8?B?Mk0yWDFjSnpYOW1xWlJQbnZIdVdvQW00VU9FcTBCc3dGZ0xQOURTVUJjMmM4?=
 =?utf-8?B?SW1BSVdnZ2FGZVBsZExoU0pyWVhGNWdXMGROQ2pJeVo1MkVRdm1yci9xK3Q0?=
 =?utf-8?B?ZXp1cENMT3dGVlZHc25XclFsRmxYVnZXQnlXMTl2OG52cCsvY1RERmZDb0xh?=
 =?utf-8?B?eVZkTFEyTndVamJMWlJGMVdncVdRRHg4bWxTdXh3c1UrbUZsNEJGbTdkT2c2?=
 =?utf-8?B?ZWtGQk1Qa09LVGFIUmpYRkttUmtUc1NCR0VHcGhCbFBvdXpqcy9ib3JnUXkr?=
 =?utf-8?B?ZVBIMDVIdnhrZ0NIeTJlMFgzOWU1ZGUwWjBtNjBNVVJYZ3BhWHRTalJORzds?=
 =?utf-8?B?UWlNRFdza2tFYis0UGkzbk5BL0creitWbk1SOTdGU3h6YXdqb3dVbGpQUEVR?=
 =?utf-8?B?VHFnVVdpQVQrd3VkbjdFT2dvcEpxV0ZoZ1VRdlJXRllXR3gvNGpGdTZ5QUVj?=
 =?utf-8?B?TWM2RE43WFpsdm9UVldRQlpXYVg5alJmcFM2ZFpRaS9uVWQ1bVhLTWJESVF2?=
 =?utf-8?B?em82b2t1YVBkL3ZtTC9reTY5M2NyQ1FBTloyUzhoc3dIeDBaMlYyLzB6dVZs?=
 =?utf-8?B?bTUyYU14U2RFNkI3QWlZbEdiYktncTBDRVAzaW5mbXFidnVFNEVtRjVHejlP?=
 =?utf-8?B?NUJ2WkJWOFV1NE50TmNTNHE2WEhMYUNweENLL0lpK3NKYUVqTmVSOURyUkc0?=
 =?utf-8?B?cFpoTXZscjhnYzNpa1RDRlF2WDZTcVM3ZXA3REJyWVdMZStQRnYxNVVNNk9J?=
 =?utf-8?B?Q1hYazNpNUJHNjZneWovSzZaOUVMZmxjTG9YMTJzZUFhSnZVcVR3VUo2dUM2?=
 =?utf-8?B?clZCRUNtWkU0MTd1OFZ1TmFCbXRpVHdrYUgzY0pjblo2UENNZlNZZDJ4WDMz?=
 =?utf-8?B?N0F5cVpiMnA5aktKUm9pTXNMRHdsVmVqcFlSbWlUby84L2dPUVlJM0JrUnpG?=
 =?utf-8?B?NzE5WlQwRGZMeENiVmVqbGNyTnBMUXpqRkhsWmxxcmwrUnhQbENwb2MxWCtI?=
 =?utf-8?B?VGRRSGtXQ0VPSExlUFVUZWZhV0VWWlNTelJDWEtsQWZhcHZqNSs5N0NTQnpq?=
 =?utf-8?B?ckZHS1NiS0NpR053YVBoY1QySlozR2VrTXFGbGI5bS9iTGZGLzR2U09HdDlh?=
 =?utf-8?B?bkNEN3ZKWUo2NlZYaFBqUWhnVG5sbzNjc3Q5WENscFJhWVU0Z2piNTE0U3Ar?=
 =?utf-8?B?NEgwL3FaSzQ3N3h1VFgvWkcvb0EwcFV6Y2VaK3U0VDQxWE51R2xHQ0tCczRo?=
 =?utf-8?B?TWlXVkNjT3JvVTlpYmJEWjl4c2h5TmsvNDZrdEk0SkloTlRRNTF5dzJ4eEZu?=
 =?utf-8?B?dHo0Z1VqanVpVXNibGVEL2pKa3ZGd1cwUFpLWlFiUC9xWUpOL1M1TktuOEIy?=
 =?utf-8?B?ZitnaDY0UlYxdU1CVlhzcjhPOGRYYVg1emhrZVNPRWkzWmI3Z2dqNmhqSUJE?=
 =?utf-8?B?ZEI3OEpLU29iRzNQWkExa3Y5NEhrNkNCK1RGMDIxN0VId3BYVzhEYS8yekRV?=
 =?utf-8?B?ZlZYUzRnSXJoRDdkR3FwS1ZmQXQ4N0ViMDZoTm9VSUQwUjRsRERZNWZFOUY0?=
 =?utf-8?B?dVhOcEtpVmlBeUdNaXppbWlJNUs3WTJ1ZUdnL3NmWDFqL1JqSUhzWlgxd2pI?=
 =?utf-8?B?YUg5Mm12c3VObU1HMGJ3QThCbWZsSVFoVzI1cmdxclVENnN3djlRcFg2aExR?=
 =?utf-8?Q?vl6t5w7KuyivODQNIaeYa9nIO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c617b12b-4721-419e-0d55-08daeee277af
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 06:02:46.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTHmkJOcDic4FmR9m2Yp6HdXF/Puguel2SZaTCvS62s8rjw9fcBtlQztn3cj1RXYiAmt98hiCEUb2xfUAxz/gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFd5ZXMuIA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthcm55LCBXeWVzIDxXeWVzLkthcm55QGFt
ZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDUsIDIwMjMgMTozMSBQTQ0KPiBUbzog
WXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5qLnd5c29ja2lAaW50ZWwu
Y29tOw0KPiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBI
dWFuZywgUmF5DQo+IDxSYXkuSHVhbmdAYW1kLmNvbT47IHZpcmVzaC5rdW1hckBsaW5hcm8ub3Jn
DQo+IENjOiBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPjsgRm9udGVub3Qs
IE5hdGhhbg0KPiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIN
Cj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1l
ci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVu
ZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY5IDAxLzEzXSBBQ1BJOiBDUFBDOiBBZGQgQU1EIHBzdGF0ZSBlbmVyZ3kNCj4gcGVy
Zm9ybWFuY2UgcHJlZmVyZW5jZSBjcHBjIGNvbnRyb2wNCj4gDQo+IA0KPiANCj4gT24gMTIvMjUv
MjAyMiAxMDowNCBQTSwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBGcm9tOiBQZXJyeSBZdWFuIDxQ
ZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4NCj4gPiBBZGQgc3VwcG9ydCBmb3Igc2V0dGluZyBhbmQg
cXVlcnlpbmcgRVBQIHByZWZlcmVuY2VzIHRvIHRoZSBnZW5lcmljDQo+ID4gQ1BQQyBkcml2ZXIu
ICBUaGlzIGVuYWJsZXMgZG93bnN0cmVhbSBkcml2ZXJzIHN1Y2ggYXMgYW1kLXBzdGF0ZSB0bw0K
PiA+IGRpc2NvdmVyIGFuZCB1c2UgdGhlc2UgdmFsdWVzLg0KPiA+DQo+ID4gRG93bnN0cmVhbSBk
cml2ZXJzIHRoYXQgd2FudCB0byB1c2UgdGhlIG5ldyBzeW1ib2xzDQo+IGNwcGNfZ2V0X2VwcF9j
YXBzDQo+ID4gYW5kIGNwcGNfc2V0X2VwcF9wZXJmIGZvciBxdWVyeWluZyBhbmQgc2V0dGluZyBF
UFAgcHJlZmVyZW5jZXMgd2lsbA0KPiA+IG5lZWQgdG8gY2FsbCBjcHBjX3NldF9lcHBfcGVyZiB0
byBlbmFibGUgdGhlIEVQUCBmdW5jdGlvbiBmaXJzdGx5Lg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6
IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gDQo+IFJldmlld2Vk
LWJ5OiBXeWVzIEthcm55IDx3eWVzLmthcm55QGFtZC5jb20+DQoNClRoYW5rcyBmb3IgeW91ciBy
ZXZpZXcsIHdpbGwgcGljayB1cCB0aGUgdGFnIGluIHYxMC4NCg0KPiANCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jIHwgNjcNCj4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvYWNwaS9jcHBjX2FjcGkuaCB8IDEyICsr
KysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3OSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jIGIvZHJpdmVycy9hY3BpL2NwcGNf
YWNwaS5jIGluZGV4DQo+ID4gMDkzNjc1YjFhMWZmLi4wY2U2YzU1YTc2Y2EgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3BpL2Nw
cGNfYWNwaS5jDQo+ID4gQEAgLTExNTMsNiArMTE1MywxOSBAQCBpbnQgY3BwY19nZXRfbm9taW5h
bF9wZXJmKGludCBjcHVudW0sIHU2NA0KPiAqbm9taW5hbF9wZXJmKQ0KPiA+ICAJcmV0dXJuIGNw
cGNfZ2V0X3BlcmYoY3B1bnVtLCBOT01JTkFMX1BFUkYsIG5vbWluYWxfcGVyZik7ICB9DQo+ID4N
Cj4gPiArLyoqDQo+ID4gKyAqIGNwcGNfZ2V0X2VwcF9wZXJmIC0gR2V0IHRoZSBlcHAgcmVnaXN0
ZXIgdmFsdWUuDQo+ID4gKyAqIEBjcHVudW06IENQVSBmcm9tIHdoaWNoIHRvIGdldCBlcHAgcHJl
ZmVyZW5jZSB2YWx1ZS4NCj4gPiArICogQGVwcF9wZXJmOiBSZXR1cm4gYWRkcmVzcy4NCj4gPiAr
ICoNCj4gPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzLCAtRUlPIG90aGVyd2lzZS4NCj4gPiAr
ICovDQo+ID4gK2ludCBjcHBjX2dldF9lcHBfcGVyZihpbnQgY3B1bnVtLCB1NjQgKmVwcF9wZXJm
KSB7DQo+ID4gKwlyZXR1cm4gY3BwY19nZXRfcGVyZihjcHVudW0sIEVORVJHWV9QRVJGLCBlcHBf
cGVyZik7IH0NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoY3BwY19nZXRfZXBwX3BlcmYpOw0KPiA+
ICsNCj4gPiAgLyoqDQo+ID4gICAqIGNwcGNfZ2V0X3BlcmZfY2FwcyAtIEdldCBhIENQVSdzIHBl
cmZvcm1hbmNlIGNhcGFiaWxpdGllcy4NCj4gPiAgICogQGNwdW51bTogQ1BVIGZyb20gd2hpY2gg
dG8gZ2V0IGNhcGFiaWxpdGllcyBpbmZvLg0KPiA+IEBAIC0xMzY1LDYgKzEzNzgsNjAgQEAgaW50
IGNwcGNfZ2V0X3BlcmZfY3RycyhpbnQgY3B1bnVtLCBzdHJ1Y3QNCj4gPiBjcHBjX3BlcmZfZmJf
Y3RycyAqcGVyZl9mYl9jdHJzKSAgfQ0KPiA+IEVYUE9SVF9TWU1CT0xfR1BMKGNwcGNfZ2V0X3Bl
cmZfY3Rycyk7DQo+ID4NCj4gPiArLyoNCj4gPiArICogU2V0IEVuZXJneSBQZXJmb3JtYW5jZSBQ
cmVmZXJlbmNlIFJlZ2lzdGVyIHZhbHVlIHRocm91Z2gNCj4gPiArICogUGVyZm9ybWFuY2UgQ29u
dHJvbHMgSW50ZXJmYWNlDQo+ID4gKyAqLw0KPiA+ICtpbnQgY3BwY19zZXRfZXBwX3BlcmYoaW50
IGNwdSwgc3RydWN0IGNwcGNfcGVyZl9jdHJscyAqcGVyZl9jdHJscywNCj4gPiArYm9vbCBlbmFi
bGUpIHsNCj4gPiArCWludCBwY2Nfc3NfaWQgPSBwZXJfY3B1KGNwdV9wY2Nfc3Vic3BhY2VfaWR4
LCBjcHUpOw0KPiA+ICsJc3RydWN0IGNwY19yZWdpc3Rlcl9yZXNvdXJjZSAqZXBwX3NldF9yZWc7
DQo+ID4gKwlzdHJ1Y3QgY3BjX3JlZ2lzdGVyX3Jlc291cmNlICphdXRvX3NlbF9yZWc7DQo+ID4g
KwlzdHJ1Y3QgY3BjX2Rlc2MgKmNwY19kZXNjID0gcGVyX2NwdShjcGNfZGVzY19wdHIsIGNwdSk7
DQo+ID4gKwlzdHJ1Y3QgY3BwY19wY2NfZGF0YSAqcGNjX3NzX2RhdGEgPSBOVUxMOw0KPiA+ICsJ
aW50IHJldDsNCj4gPiArDQo+ID4gKwlpZiAoIWNwY19kZXNjKSB7DQo+ID4gKwkJcHJfZGVidWco
Ik5vIENQQyBkZXNjcmlwdG9yIGZvciBDUFU6JWRcbiIsIGNwdSk7DQo+ID4gKwkJcmV0dXJuIC1F
Tk9ERVY7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJYXV0b19zZWxfcmVnID0gJmNwY19kZXNjLT5j
cGNfcmVnc1tBVVRPX1NFTF9FTkFCTEVdOw0KPiA+ICsJZXBwX3NldF9yZWcgPSAmY3BjX2Rlc2Mt
PmNwY19yZWdzW0VORVJHWV9QRVJGXTsNCj4gPiArDQo+ID4gKwlpZiAoQ1BDX0lOX1BDQyhlcHBf
c2V0X3JlZykgfHwgQ1BDX0lOX1BDQyhhdXRvX3NlbF9yZWcpKSB7DQo+ID4gKwkJaWYgKHBjY19z
c19pZCA8IDApIHsNCj4gPiArCQkJcHJfZGVidWcoIkludmFsaWQgcGNjX3NzX2lkIGZvciBDUFU6
JWRcbiIsIGNwdSk7DQo+ID4gKwkJCXJldHVybiAtRU5PREVWOw0KPiA+ICsJCX0NCj4gPiArDQo+
ID4gKwkJaWYgKENQQ19TVVBQT1JURUQoYXV0b19zZWxfcmVnKSkgew0KPiA+ICsJCQlyZXQgPSBj
cGNfd3JpdGUoY3B1LCBhdXRvX3NlbF9yZWcsIGVuYWJsZSk7DQo+ID4gKwkJCWlmIChyZXQpDQo+
ID4gKwkJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJaWYgKENQQ19TVVBQ
T1JURUQoZXBwX3NldF9yZWcpKSB7DQo+ID4gKwkJCXJldCA9IGNwY193cml0ZShjcHUsIGVwcF9z
ZXRfcmVnLCBwZXJmX2N0cmxzLQ0KPiA+ZW5lcmd5X3BlcmYpOw0KPiA+ICsJCQlpZiAocmV0KQ0K
PiA+ICsJCQkJcmV0dXJuIHJldDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXBjY19zc19kYXRh
ID0gcGNjX2RhdGFbcGNjX3NzX2lkXTsNCj4gPiArDQo+ID4gKwkJZG93bl93cml0ZSgmcGNjX3Nz
X2RhdGEtPnBjY19sb2NrKTsNCj4gPiArCQkvKiBhZnRlciB3cml0aW5nIENQQywgdHJhbnNmZXIg
dGhlIG93bmVyc2hpcCBvZiBQQ0MgdG8NCj4gcGxhdGZvcm0gKi8NCj4gPiArCQlyZXQgPSBzZW5k
X3BjY19jbWQocGNjX3NzX2lkLCBDTURfV1JJVEUpOw0KPiA+ICsJCXVwX3dyaXRlKCZwY2Nfc3Nf
ZGF0YS0+cGNjX2xvY2spOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlyZXQgPSAtRU5PVFNVUFA7
DQo+ID4gKwkJcHJfZGVidWcoIl9DUEMgaW4gUENDIGlzIG5vdCBzdXBwb3J0ZWRcbiIpOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJP
TF9HUEwoY3BwY19zZXRfZXBwX3BlcmYpOw0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIGNwcGNf
c2V0X2VuYWJsZSAtIFNldCB0byBlbmFibGUgQ1BQQyBvbiB0aGUgcHJvY2Vzc29yIGJ5IHdyaXRp
bmcgdGhlDQo+ID4gICAqIENvbnRpbnVvdXMgUGVyZm9ybWFuY2UgQ29udHJvbCBwYWNrYWdlIEVu
YWJsZVJlZ2lzdGVyIGZpZWxkLg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FjcGkvY3BwY19h
Y3BpLmggYi9pbmNsdWRlL2FjcGkvY3BwY19hY3BpLmggaW5kZXgNCj4gPiBjNTYxNDQ0NDAzMWYu
LjZiNDg3YTViZDYzOCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2FjcGkvY3BwY19hY3BpLmgN
Cj4gPiArKysgYi9pbmNsdWRlL2FjcGkvY3BwY19hY3BpLmgNCj4gPiBAQCAtMTA4LDEyICsxMDgs
MTQgQEAgc3RydWN0IGNwcGNfcGVyZl9jYXBzIHsNCj4gPiAgCXUzMiBsb3dlc3Rfbm9ubGluZWFy
X3BlcmY7DQo+ID4gIAl1MzIgbG93ZXN0X2ZyZXE7DQo+ID4gIAl1MzIgbm9taW5hbF9mcmVxOw0K
PiA+ICsJdTMyIGVuZXJneV9wZXJmOw0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0cnVjdCBjcHBjX3Bl
cmZfY3RybHMgew0KPiA+ICAJdTMyIG1heF9wZXJmOw0KPiA+ICAJdTMyIG1pbl9wZXJmOw0KPiA+
ICAJdTMyIGRlc2lyZWRfcGVyZjsNCj4gPiArCXUzMiBlbmVyZ3lfcGVyZjsNCj4gPiAgfTsNCj4g
Pg0KPiA+ICBzdHJ1Y3QgY3BwY19wZXJmX2ZiX2N0cnMgew0KPiA+IEBAIC0xNDksNiArMTUxLDgg
QEAgZXh0ZXJuIGJvb2wgY3BjX2ZmaF9zdXBwb3J0ZWQodm9pZCk7ICBleHRlcm4gYm9vbA0KPiA+
IGNwY19zdXBwb3J0ZWRfYnlfY3B1KHZvaWQpOyAgZXh0ZXJuIGludCBjcGNfcmVhZF9mZmgoaW50
IGNwdW51bSwNCj4gPiBzdHJ1Y3QgY3BjX3JlZyAqcmVnLCB1NjQgKnZhbCk7ICBleHRlcm4gaW50
IGNwY193cml0ZV9mZmgoaW50IGNwdW51bSwNCj4gPiBzdHJ1Y3QgY3BjX3JlZyAqcmVnLCB1NjQg
dmFsKTsNCj4gPiArZXh0ZXJuIGludCBjcHBjX2dldF9lcHBfcGVyZihpbnQgY3B1bnVtLCB1NjQg
KmVwcF9wZXJmKTsgZXh0ZXJuIGludA0KPiA+ICtjcHBjX3NldF9lcHBfcGVyZihpbnQgY3B1LCBz
dHJ1Y3QgY3BwY19wZXJmX2N0cmxzICpwZXJmX2N0cmxzLCBib29sDQo+ID4gK2VuYWJsZSk7DQo+
ID4gICNlbHNlIC8qICFDT05GSUdfQUNQSV9DUFBDX0xJQiAqLw0KPiA+ICBzdGF0aWMgaW5saW5l
IGludCBjcHBjX2dldF9kZXNpcmVkX3BlcmYoaW50IGNwdW51bSwgdTY0DQo+ID4gKmRlc2lyZWRf
cGVyZikgIHsgQEAgLTIwMiw2ICsyMDYsMTQgQEAgc3RhdGljIGlubGluZSBpbnQNCj4gPiBjcGNf
d3JpdGVfZmZoKGludCBjcHVudW0sIHN0cnVjdCBjcGNfcmVnICpyZWcsIHU2NCB2YWwpICB7DQo+
ID4gIAlyZXR1cm4gLUVOT1RTVVBQOw0KPiA+ICB9DQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IGNw
cGNfc2V0X2VwcF9wZXJmKGludCBjcHUsIHN0cnVjdCBjcHBjX3BlcmZfY3RybHMNCj4gPiArKnBl
cmZfY3RybHMsIGJvb2wgZW5hYmxlKSB7DQo+ID4gKwlyZXR1cm4gLUVOT1RTVVBQOw0KPiA+ICt9
DQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IGNwcGNfZ2V0X2VwcF9wZXJmKGludCBjcHVudW0sIHU2
NCAqZXBwX3BlcmYpIHsNCj4gPiArCXJldHVybiAtRU5PVFNVUFA7DQo+ID4gK30NCj4gPiAgI2Vu
ZGlmIC8qICFDT05GSUdfQUNQSV9DUFBDX0xJQiAqLw0KPiA+DQo+ID4gICNlbmRpZiAvKiBfQ1BQ
Q19BQ1BJX0gqLw0KPiANCj4gLS0NCj4gVGhhbmtzICYgUmVnYXJkcywNCj4gV3llcw0K
