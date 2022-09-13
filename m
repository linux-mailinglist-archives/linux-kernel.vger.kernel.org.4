Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159705B77B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiIMRVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiIMRVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:21:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414691EED0;
        Tue, 13 Sep 2022 09:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxELtorG4dkoIFTnusjqY49rDXruWFpniUYytdcrq8Wmut9JYc/HoPWV25SD7OtR1yIvrWXfLH1Z8jSOWz6kV/n8dkQGkpuQqR5pLV9fWv0WuUeRrpC0eRE6kL/USQeMjsenzBFltmu2iEfpwMiskrsgQRlEGBHHlSuUwXKlSGilm9A8jpGnyyaXy3hL429llvTEiWk8ccjVdXHLoozhMoSb1tNUiJAQxtuCvvRgONNl7Vdj78JQdBeT92Sio+9Ch8ebi5BnbKQg7YM03o2AN6Eir6fjiYlkUAdvOZQ+NiIYB413dDFIGxQm7T0uWWtu8emIXEa+bfPQhNeIe/Gtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdkEUMhW/OjBP/5cMTRDtJhLaWQTtebgqS71ZbHbmdo=;
 b=gL1jHvsAfuD6oloszJmkasW16ig0YOCuFUadfru5j78aM9LA+xsqbNNcP6KbDamobSVpy5FbMAonVe2DI8zp2tQf8pJb7QJrpq5IPLYdCJ1lVvZl4yvEqu7ByI4Eb4WRhoKiAC1qZx63jRNW38BffuxHb/odfNdkPTqHM1MSyhTD4MYVXdBRUxSE4Ny+EJB5T6GuR+IkuxUKnCuVk2UX7Xo6WppuO+gES6Ppd1k1vy/SZLB4639hPhA4J4Hrg1iM/rtN9UTi1R8LXzaS1ggMV9s/lJ3a5q7Rn99CNfrE4KxFc00MIEGii9StHPdTsIs7tH0n4VJPe2Ykq2IYgvCrPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdkEUMhW/OjBP/5cMTRDtJhLaWQTtebgqS71ZbHbmdo=;
 b=eWaktxAr/SNlH/3bHjLM3asJWxE4a4gkOFy3Ix6kY45G7wIYK07LNvkVrDNG61WClroMuWxGUNCkjVoYvCZPb4TW2RiWIbdsPuxhzYNFuu2ST+w+eT+X9fWXwBPWvyt5vGTX/nbYXfhwwE5qNxPV+I8yNS1b4/05dKAKdwO/Fqk=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 16:08:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3565:585c:3431:216c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3565:585c:3431:216c%7]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 16:08:17 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Armin Wolf <W_Armin@gmx.de>, Randy Dunlap <rdunlap@infradead.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "hmh@hmh.eng.br" <hmh@hmh.eng.br>,
        "matan@svgalib.org" <matan@svgalib.org>,
        "corentin.chary@gmail.com" <corentin.chary@gmail.com>,
        "jeremy@system76.com" <jeremy@system76.com>,
        "productdev@system76.com" <productdev@system76.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
Thread-Topic: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
Thread-Index: AQHYxqbQEciGJA2EpEiljTYwRrdm2q3cV6EAgAEYrACAABg3sA==
Date:   Tue, 13 Sep 2022 16:08:17 +0000
Message-ID: <MN0PR12MB6101CE9055DC152A6E96B2EDE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-6-W_Armin@gmx.de>
 <b1b794b4-f6c3-7697-5d5a-b811809a9313@infradead.org>
 <2aae0ae9-9608-675a-ec0c-6e7526e57363@gmx.de>
In-Reply-To: <2aae0ae9-9608-675a-ec0c-6e7526e57363@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-13T16:08:10Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f6f1a56c-2014-403d-80c2-9997185916b3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-13T16:08:16Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ce623bd0-a900-4f3e-89ed-fcf3389b6876
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SN7PR12MB7106:EE_
x-ms-office365-filtering-correlation-id: 3f32eb1c-fcd3-4f4f-1e83-08da95a22baa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: asEXd7uocUTO5QHKttMeOb9V3M9OWgK0qBerZx4m4GDDQu5g0J7++RBco3QpSe4UXJd03WQVz4EAzlYlwfPqAnUi6KHRrZJheFmhVjtXRtLXPK7fgH3SKx9sYalzLNrfGPvcIyQYJ0FiIGM57brAPu0biZZI8AfaOl49/Eul4sDC9+pWl5HOZdU8HS0ckeG9UtnlAs61Zs9o44CW/rtFlrHmYrAx7aadGPSbEgf4dFiKQlKXiwrtAZEDPpsYASlt+iZIGfRyitV4klBaNskjYIvjBkU9zTR5p2qbpqUlQzAmsM75byblpdlvw67d7lxjrmSFZXADxSmb3+2/0vbjUdOJ1D5OO4/S5pYxKglnB4Wpz/+MSMBFeEPiU+FBK17pbk7+q4fobf7bE7Dew5AxFPlXBsxDkdcDJ5+mU6BiUB/RovZoVioEecVa0KV6yLDMB1pru03a6Gn4h009dG5QEJcRmScrO2w7GDvqoJYOO6newp8l1eKFwWiEOKmZjvxAo6L2EE6zKBkJi9bEFo6axfeJUyQ4fFILkkexXdEQ5a31/rsDvpNedOY6vkbIGp7zZW+BEZqiMYCpciNQINAOMRgTaUvTJr1d2gVVjpePz7olnKdY/bQg3KDD/CpFvleR4YJT9S+1v8tos2EAKOpPxMyrZ/TLvviJHGjhyCx1b6HDrJIpIYpjYnfxWQQ+GKwb3xx3wj3Wqs8tMhoK0rbCEMuVlxepBdWMiy0CFGxdtaj90RTAf15HEmiRSL5iP0O5nFd75AyCn0eNnwMO/vALeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(38070700005)(53546011)(7696005)(6506007)(71200400001)(33656002)(64756008)(186003)(52536014)(66476007)(2906002)(4326008)(76116006)(41300700001)(9686003)(5660300002)(26005)(478600001)(7416002)(38100700002)(316002)(54906003)(8676002)(66446008)(66946007)(66556008)(55016003)(86362001)(110136005)(83380400001)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um1reEJSUVoyRzJ6cTJBNmc2MWE3SHp3clJ6Z2VDYkUvR2hSN2JrMy9vcC9i?=
 =?utf-8?B?REhNWTMxYW9kSXZpTW1PTVJXaXlKSExGcXhXVVFuWUcrbU1UaUVOak1NYm5j?=
 =?utf-8?B?d2hlcy9rZlNrc2V6Wm5mTWxJMUxuT3ZkR0hOTUhOdEdQNnh0NERVWEx6QXlR?=
 =?utf-8?B?TFA2TFA1bmdGMTBHREY0VU9OK0tYckkxaWRmaDR1QUNobmxXRHFMeGY2d05P?=
 =?utf-8?B?cFFuSTcySE0vcUlKU0xzcWRpL1ZwNnpNcURsYzZRdDRBTjBhYWpkSWs2Mmlx?=
 =?utf-8?B?R1pUTklsVzk1Q1V5N0NIVUR4VUtxTjE3ckZZaWN1RUNiVGg1b2hKWWpHU0Zh?=
 =?utf-8?B?UnlGM2daSmZLbmdEeE9xOEVsSnVrT05ISVF3NWF0Q0ZrZUpZRTQzNEE2TEcx?=
 =?utf-8?B?SUc5VEZmdkZueElMTGpzWVJhSnRCWWtLLzd0VmVIZ3U0cnhtTjlzbkc1eE5L?=
 =?utf-8?B?d0NsdkFQMldRSWFGb0tUcUVGOFl1SmV5cHduY3pXdHRvNFVBTzAzdHIyZWNI?=
 =?utf-8?B?ZWJQNHVBekdIWlU4ditHQkVUbDBCaXp3TWl0RE5DTk9tazU4RFVzN2hiaWRt?=
 =?utf-8?B?eVVvTDNqZndBUHVKc3V3OXgxckp5L3I0dWd4alNiMG8zenBZRDg3QjhSK0FY?=
 =?utf-8?B?V0ZJbmkwNjZFM2dGZTRuRzJ0OVN1ZDFxdHJJZzRiRjkwYytrOW1zYy9xcFZj?=
 =?utf-8?B?MGpZYVJxQjl0cDU3bUxwOVhYMzR0SEJoU1g0eUFlcWNlOW9YUHhmYmphMmxv?=
 =?utf-8?B?dTNjbVJTNUJYanc4SDMrQXoyU1Bhc2hGQ1FFNUF2Qlh2blhPbkQwRG1lbzU2?=
 =?utf-8?B?NENrMThoRHg4eWIxeUdWd1ExaGNBWnVMNHlUczl1UGJoRmpFRXpaUUVQMVNR?=
 =?utf-8?B?NWlMd2JwTmhNM2lnVWZTVnVGT3VwOFV0NlBmZUpZUUNENnNnQU5NRmNmUGJQ?=
 =?utf-8?B?Y2Rva1prN2o1WTlqc2xyVTlLVHRKZEh5cmhsUDBSY05BUXl0Y3k4RGxRT0NF?=
 =?utf-8?B?YnMrazRQay80WkxUYWxPSXFKNHVYUitBckRYeThIMWVqZDZ6OVVXcEtxeDlu?=
 =?utf-8?B?cTlOYlB0bGVXZXRLMUVpcUdta1ErckFqMTB2K1RCOGYvZlRVdGJMeGNMU09s?=
 =?utf-8?B?VUlLUTN3S3JNL3dYVThJVzJUd200K2ZiK3BMWUZTc1ZmdEtrcW0xYW0yakFy?=
 =?utf-8?B?S2c4S0VjK3g1UURJYkU2clpJNzJESjk5c2JET0Q3eXZ3ZzdmN1pNZ3FKcEhw?=
 =?utf-8?B?LzE5UHUyTllZOVo5WGsxTDNyNDNuL25iVUFUazlYZ1Jxa2hNM1FjamRORFZF?=
 =?utf-8?B?VjZJeURUL1JUZjF6QzE3MG5xbkRTRlQvUnRXcjdBQnR5aUhVN2krRHhNK0pn?=
 =?utf-8?B?QXJ4OEI3S2tEbEtvRnNQOTJQTDJIdll1T0xpdHg3U21xVTZLM0ZkSXMvOXhD?=
 =?utf-8?B?bERLY2JSUnYrdmJIUllFWnFFZUU0MkY1WGRjVXhTOG1DQXBoOGh4U2taUjRO?=
 =?utf-8?B?MmNNTFdiTm5BbSswSWVpN0xRRFZMREN5TTVEN016WS8wRFhTN0haOVJvb0p3?=
 =?utf-8?B?Z21lbElXdkZtZkhxOFUxUzk3TU9MNnR0N0FMS0xsbFJkaUNkQ1hVWTg4TXM4?=
 =?utf-8?B?TU44cmhrOGxPS3FUeVFwcVVmeXZHOURmekJqOHFBdDAyV29JTzVvblZ0V2J2?=
 =?utf-8?B?MlE3dG95U3c1U05RNU43SEpzNEZHNURBZEpTS2R1cUZjMEFiaGpBOU9iSzQ5?=
 =?utf-8?B?VFpjeXhTb3lScXd3ZUNNcyt3RDM3ZlF5RHNzTmdOcGRUZ2RYVU9raUZXaWJa?=
 =?utf-8?B?QXhzOWZFcS85ZFpMa3MzNXJBdkphanI5VnF4SlpYRUE2Rnd5RDFQd21UUDNh?=
 =?utf-8?B?OGF1K21mNHVKY0U5K2JxdTNGWTlxWXBySUdqQ01DMDhrTUM3b215T2xUMDE5?=
 =?utf-8?B?OHRZWWtrRUJWZ1FhRlBsai81ejlPT1VwK0hkR094UkJ6OHpiV1Mwb1FXQ2tW?=
 =?utf-8?B?QnRwK2NRMXR0a3NHUU0vK3p5WVBFRWpIaWZZOTM2VTZuYVV3ZmZ4TWFoL3Fx?=
 =?utf-8?B?Y0VpWFRYSFVCZ1AyWG1QbjhiQzYrOGZ3OUNnSnYvM2RROHhzRElZV2pTbVpE?=
 =?utf-8?Q?GoAg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f32eb1c-fcd3-4f4f-1e83-08da95a22baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 16:08:17.6000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fr3sRpEZp4GGknoT6keOv9c4nw4L+Po3TLrm9/917mFHjdzGWfBbgrUrdm77c2b2sDc0qNB4aP6eUSXuTir9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJt
aW4gV29sZiA8V19Bcm1pbkBnbXguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxMywg
MjAyMiAwOTo0MQ0KPiBUbzogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+OyBo
ZGVnb2VkZUByZWRoYXQuY29tOw0KPiBtYXJrZ3Jvc3NAa2VybmVsLm9yZw0KPiBDYzogcmFmYWVs
QGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsgaG1oQGhtaC5lbmcuYnI7DQo+IG1hdGFuQHN2
Z2FsaWIub3JnOyBjb3JlbnRpbi5jaGFyeUBnbWFpbC5jb207IGplcmVteUBzeXN0ZW03Ni5jb207
DQo+IHByb2R1Y3RkZXZAc3lzdGVtNzYuY29tOyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IGFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS81XSBwbGF0Zm9ybS94ODY6IGRl
bGw6IEFkZCBuZXcgZGVsbC13bWktZGR2IGRyaXZlcg0KPiANCj4gQW0gMTIuMDkuMjIgdW0gMjM6
NTYgc2NocmllYiBSYW5keSBEdW5sYXA6DQo+IA0KPiA+IEhpLS0NCj4gPg0KPiA+IE9uIDkvMTIv
MjIgMDU6NTMsIEFybWluIFdvbGYgd3JvdGU6DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bs
YXRmb3JtL3g4Ni9kZWxsL0tjb25maWcNCj4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsL0tj
b25maWcNCj4gPj4gaW5kZXggMjU0MjFlMDYxYzQ3Li4yMDllNjNlMzQ3ZTIgMTAwNjQ0DQo+ID4+
IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwvS2NvbmZpZw0KPiA+PiArKysgYi9kcml2
ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsL0tjb25maWcNCj4gPj4gQEAgLTE4OSw2ICsxODksMTkgQEAg
Y29uZmlnIERFTExfV01JX0RFU0NSSVBUT1INCj4gPj4gICAJZGVmYXVsdCBuDQo+ID4+ICAgCWRl
cGVuZHMgb24gQUNQSV9XTUkNCj4gPj4NCj4gPj4gK2NvbmZpZyBERUxMX1dNSV9ERFYNCj4gPj4g
Kwl0cmlzdGF0ZSAiRGVsbCBXTUkgc2Vuc29ycyBTdXBwb3J0Ig0KPiA+PiArCWRlZmF1bHQgbQ0K
PiA+IFlvdSBzaG91bGQgKHRyeSB0bykganVzdGlmeSBkZWZhdWx0IG0sIG90aGVyd2lzZSBqdXN0
DQo+ID4gZG9uJ3QgaGF2ZSBhIGRlZmF1bHQgZm9yIGl0Lg0KPiANCj4gSSBoYXZlIGNob3NlbiBk
ZWZhdWx0IG0gc2luY2UgbWFueSBvdGhlciBEZWxsIHBsYXRmb3JtIGRyaXZlcnMgYXJlIGJlaW5n
DQo+IGRlZmF1bHQgbS4gU2luY2UgdGhpcyBkcml2ZXIgaXMgbm90IGVzc2VudGlhbCBmb3Igbm9y
bWFsIG9wZXJhdGlvbiwNCj4gaSB3aWxsIGRyb3AgZGVmYXVsdCBtIHRoZW4uDQoNCkFjdHVhbGx5
IERlbGwgZHJpdmVycyBkaXJlY3RvcnkgYXJlIGEgYml0IHVuaXF1ZSBpbiB0aGlzIHJlZ2FyZC4g
IFRoZXJlIGlzIGEgc3BlY2lhbA0KdG9wIGxldmVsIGJvb2xlYW4uICBJIHdvdWxkIHN1Z2dlc3Qg
dG8ga2VlcCBpdCBhcyBpcy4NCg0KVGFrZSBhIGxvb2sgYXQ6DQptZW51Y29uZmlnIFg4Nl9QTEFU
Rk9STV9EUklWRVJTX0RFTEwNCg0KPiANCj4gQXJtaW4gV29sZg0KPiANCj4gPj4gKwlkZXBlbmRz
IG9uIEFDUElfQkFUVEVSWQ0KPiA+PiArCWRlcGVuZHMgb24gQUNQSV9XTUkNCj4gPj4gKwloZWxw
DQo+ID4+ICsJICBUaGlzIG9wdGlvbiBhZGRzIHN1cHBvcnQgZm9yIFdNSS1iYXNlZCBzZW5zb3Jz
IGxpa2UNCj4gPj4gKwkgIGJhdHRlcnkgdGVtcGVyYXR1cmUgc2Vuc29ycyBmb3VuZCBvbiBzb21l
IERlbGwgbm90ZWJvb2tzLg0KPiA+PiArCSAgSXQgYWxzbyBzdXBwb3J0cyByZWFkaW5nIG9mIHRo
ZSBiYXR0ZXJpZXMgZVBQSUQuDQo+ID4+ICsNCj4gPj4gKwkgIFRvIGNvbXBpbGUgdGhpcyBkcml2
ZXJzIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUgbW9kdWxlIHdpbGwNCj4gPj4gKwkg
IGJlIGNhbGxlZCBkZWxsLXdtaS1kZHYuDQo=
