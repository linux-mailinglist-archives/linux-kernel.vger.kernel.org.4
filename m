Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481906A10AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBWTlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBWTlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:41:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6CE59E41;
        Thu, 23 Feb 2023 11:41:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4vvYErD9/VYB6fiz/cg/Gkb8N3mb9p/kCFYLEGtnfVi47YxpISHq3Ad16IpogMqLrB+luMiT6hmc9WKvwoaAQq+pT0yw+W5D7wUk2X2deBpPO5E3O2k+XQL1pl/g+BCci0PrbgTx6EUsDezoqlEgtlQHePt3NVqvG7sEt544DD+31Kd1U5wp9IYkjXdJM1KBWKpiX4u5aOL16l/dYmG5i1MHJPaaWA/LP/lmyE/NjVL93LWcCC9sWXckp7PKOsMb5p9xFGxybcqdGrwzaIkYK2IdALNkHDZFjLi8KVVv5UtfvWOVFRwz3ir5G4okpUaQlqRAfidi+bN53W9Hrmexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua4uB6otsiCUcuSXMxVlVKiXi7hqvJjTApglsR+sPac=;
 b=d/4BaFWxItJJq24ThkDW0CICNlkC22sUOQHFOaR0K5U8B0HNXSFWix+QKJ6zSmGcsrM2276zZ0/1iOatmdAZVo/K0PT4ozwClOlEAZFn/uT7wHkXwpCtlqsFQ7cS2TkKE5zDzL4SH5pDx4vzVzvKopigbUWpT++TVX7XfSWX5YM6OAUWzf5/PVe03Ihde/DszS9tFzQ3gQNnq+TmcwjMPzGZ/Lvy2MzW/EfVsqNGFR7aMSantqthykysDc92KPs0aQWfuW54jigtZFQwSQminTfjznzHzE1qRgNVJfINGX1Z6Quw64nyUiAIz12btw8parzL18tg/OM630wfpElJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua4uB6otsiCUcuSXMxVlVKiXi7hqvJjTApglsR+sPac=;
 b=XTA+yyBA8Ggmw5jWBkWEQ0TUv45l7AEkQG4syuyTZOS4F+TfAzbDCdAlR3bBjCs9A1cwRNH9QiWz4SEfKh/lM0H1f5adflYF1QMWfQ/dg7Nk0uej8HW56byQjrZoZ8eBrnthUHnLOgv6IiZ2ZuqUG3uLxoEV7q6VqXPUY5JEJDI=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 19:41:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 19:41:33 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Wu <michael@allwinnertech.com>
CC:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gong, Richard" <Richard.Gong@amd.com>
Subject: RE: [PATCH] HID: usbhid: enable remote wakeup for mice
Thread-Topic: [PATCH] HID: usbhid: enable remote wakeup for mice
Thread-Index: AQHZR3iDazov67zqf0SmSMvJFyQb2a7cY4mAgAAKwwCAAHzogA==
Date:   Thu, 23 Feb 2023 19:41:33 +0000
Message-ID: <MN0PR12MB6101B1BF9748F0602684FED5E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <Y/WwXBF37hoZBbQa@kroah.com>
 <9bf4463c-6541-a6cb-9bbc-6d070118509a@allwinnertech.com>
 <Y/dMq2KKYfdMdrjh@kroah.com> <801338c3-7c0d-6b3e-eac8-872ee5add466@suse.com>
In-Reply-To: <801338c3-7c0d-6b3e-eac8-872ee5add466@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-23T19:41:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=04801bc9-2583-4925-916a-3942c69649ca;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-23T19:41:31Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: dea54f92-7dc9-4346-b7a7-639b12879cdc
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SA3PR12MB7806:EE_
x-ms-office365-filtering-correlation-id: e215b517-2d3f-4822-824e-08db15d5f7dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BiwdjXfWhBwGQWhYyxH+aGoVPrM1QzmnTV8+r/soHNYvydxY0lRdvHPNIZ8wbM+G8vgyOYnjU0C1OEy2xk2WyxsOTbZNRhk8L6513Rmg/ivJRN7MulDjE7aXsLKRZ32mHb3IXGweKXtkHyVnmjp6t0CVz364NKhXuxadFfPLcLvTNtvoGHcb7A6M3ZVnjGJEJki0e1poDitKoyDqusp/tqSSy8R6MOmhSybA7W0owlZjgc7ZVGXB9eMKzT/lo3IzoJbP/uEQY6k9xWFC9QlO66topH095Phyo/eIaMa/1WnFE3Nz0sTkGMOgTz43UQ65KZ3saAWmoEAF1HE1u/EefWNwiR31abpp2nnoongxeplB6lKLbJMZJqci2yctNv9WX8h6tT/qT9Xg5QXUS6EdKasH+ugk7Zi7bVwbBIGNPBLCO1SKPFLqypZFewhGDz6fD2Oxc7dhvtDrO/OfhrGPbcKuzivM8ehTC5Zx+gXoH9yAZLfovmBCMxSWQlOQPmvn73QQIYyckbyuLbZkzmA0cGuFzcaMrheXWqc6GD8ip6nBnSyPY8HzppP/eNDjvFFCT37v1OyBHJ67v1DT91cZbv3fxiuxHU/35M96ueoYlOg7eq3lHpvN2d9T/eoyUCcNv9XxEFG+pQMbKXQUUjp8NJ7BuElPbwsIcQJ7UOi2Pcv74jL12qJM2AOu0KL830osVgk8sgH9yLf2VBZDQa8bXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199018)(86362001)(38070700005)(55016003)(33656002)(76116006)(54906003)(66556008)(41300700001)(66946007)(66476007)(66446008)(4326008)(8676002)(64756008)(53546011)(6506007)(110136005)(478600001)(186003)(9686003)(26005)(7696005)(71200400001)(122000001)(38100700002)(316002)(5660300002)(52536014)(83380400001)(8936002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkhjUjhMV3dhckxwc1lEQm83NWtiZ3JxVkMwUVh3bllZVzlLZGxmcHE3RnM5?=
 =?utf-8?B?R085aU9IV0d0Q0tlL25FT3drUzNkRitHVzdUbWpMUU45a0Y2c1gxRXF3TjJ2?=
 =?utf-8?B?di91dks1YWJNNUxBNGF1b24xb1VLa1VoUmI5SnlBOGtPQitnTE1Zd0MrN2Zj?=
 =?utf-8?B?NlYvM0xZTzdCQVNlUjdTbStPTFJqWjAvOTZVUDBVVDBKMDNHSCtybVBJMldj?=
 =?utf-8?B?azR3RW81OWwyRVBVQks4cUZldVNpNDhlN0FSeUF0VHdDVU5WZGxBL05XTDQ4?=
 =?utf-8?B?WEdHSUNrODBlL01UMVBmYTZzbEtEeXhVMndnUHhBNzhPSXhXRmhUbG44NVdo?=
 =?utf-8?B?ZEt1blpscUNkck1QRVVkcVY1cVZtTWQxcWJCSlBVZlZTMitZRDh4OHh5aUpj?=
 =?utf-8?B?Z2VycG1rL1R0cVk3WEx2cmxNN2FlT1RjYk50RjRBc2RXVEEvaUpzZENSa29V?=
 =?utf-8?B?cFFOSTh0QXYrRnIwTDUzcEloQVk5b1dZbkVHTVhyTlFaSUhJL0c4M05QcnlC?=
 =?utf-8?B?SXo2U2RMcDJleHFkMkRuWVdpLzBkMktmZnRQL0NtZGI1Ujl4d2Fqd0ZQZW1L?=
 =?utf-8?B?WHNYaU1xWTlDSTFjS2dnRmJ0VDRDMHh2MUpsbEkzSVVXQ0JEUlVvSlhjd0Nn?=
 =?utf-8?B?Mjk2eFo0bjV2S25ydDk4cXpGVHBROGtUb1QwUGJoSkx2UHJDQmw2WTA3eGZj?=
 =?utf-8?B?ZS9jbE1aYnZ1MGQ3NHAyQUttc1JrY3N6cDNvc0NhcnNEVTZvT2N3MVZkNG1E?=
 =?utf-8?B?K3NmMEpPTTVUT3MwVUszUzl6c2U4aXpuaENKUGxtUGVPb2ZhM0tWc0xhUDds?=
 =?utf-8?B?RkdVT2p6ZmkzcjVDNE9WanduYytHRkV3UEllczFRQUlaSzBhY0lIcXFkZ0pi?=
 =?utf-8?B?d0VmcEZmMmw0NXJjVXQwUkZxU0Y2eGx1MGQxRHFoSmJIWWVkUFBaM3N3ZWtQ?=
 =?utf-8?B?d3VWYU1BNXd4QTd5VVVXM2dVcXJKa1RrVEg5Z0E2VitPTEdycGwrRTdqWGJX?=
 =?utf-8?B?M1duemJuMFJEQk5OTnZLZVpqcUVPY3k4NGM2VW84WUF4MUhuZ0tvMlBqZCtU?=
 =?utf-8?B?RXhkTkdlcG1mK29qV0piWms4MXFQamNzUnZyNURJQkxrM3prRGM0STU1WjZa?=
 =?utf-8?B?Mm9nbGNtZ1lKclF4MElYZDJwWkxGQXBaRit6L2RvZitYRVpycERkQ2hZcHkv?=
 =?utf-8?B?Mm56djVRdWNnSXBIdTQ2RUQ1SldheE1mdVVRditSTnJNVWVtNzlLZnJUVEZB?=
 =?utf-8?B?N0FTTWc0eWhGT0IwbnFzeE1ZejRwVk9IaGdCMWZ5N2w3b0xNWnFocGdFSVo5?=
 =?utf-8?B?V2s4V3FyNWZWZnNSenA0czU2a0s5elQwd2w3ZHBPdVZ3TkVZSnF6dGIzR3Az?=
 =?utf-8?B?YWVpRUlUcnVwYWl1RkxXWUwwcXlMcjd5UGFTSTNvc3ZGblF5MGY0SVNZNnZB?=
 =?utf-8?B?azBWblNEaENrV0hMclE2ZHMyYnBNb24yVDFIcGoyUDBYYXJvU2N5cW4zbXFR?=
 =?utf-8?B?VHpSaGthaVE0Sy85ZFVmRndxUC9BbERUYkk4dGVZNzNKald5MDF5SnVubzNG?=
 =?utf-8?B?cmsyNE9QUWsvZWR3RERvUlY1Ymx1Z2YvcnBVV05vNGJYcWp1RnpvWnBBdC8v?=
 =?utf-8?B?bHJxTVhjeVJ5RVBwZ3lDeTVjbXE5b0wxQ2VHNm0zM0RpMUtSQ2U4WGZHSVlo?=
 =?utf-8?B?ZCs4VWhzNVU3Z2Q1MWU0YTVsd0ZvSnlyeitENEVhMGtPYWdCbnBXdGdYVkpQ?=
 =?utf-8?B?dTRDMUNVNFAxL0R3M2FFNVBGNlhFRWR3VXU2dS9WWkU2bE04bWcwSWMwczYr?=
 =?utf-8?B?L1dHRVVHNG1Lb2pqcmFTcGhtM21HT2NMREFXTU9CbFlXQU9mbjZrYTZuNlFX?=
 =?utf-8?B?clhJZUlOdGovbVFmOVZ5ejd5U2xDbWYzZVlwdzhMU0gxZ2M5amFLamFqc29H?=
 =?utf-8?B?ZnBHc2JQbklBK2t1Wm9HQnpKN28vOHhCelhaVkpUT1d3Z2xZRnh4dzBVR2Yw?=
 =?utf-8?B?UWFkWDE5Q2ltNDFyZEVhb29sNk15SjRhdTRSNWdGUzZveDhsNTFlTFoyOFVH?=
 =?utf-8?B?YWVYcnd6T1NaWW5ZWm1rN2lwZlpJbjJaQ2xQREppcWd1aUtKSVhKczZJUmRa?=
 =?utf-8?Q?LN8w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e215b517-2d3f-4822-824e-08db15d5f7dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 19:41:33.3072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJYcx224DoNp1hwM+ytuZ7Z5DIs2YdwwM/aEi4c/r8SSU4vcI/7XPXJGR2V7KDF6aOcRTE+T0hajn8shw7TUJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IE9saXZlciBOZXVrdW0gPG9uZXVrdW1Ac3VzZS5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyMywgMjAyMyAwNjowMg0KPiBUbzogR3JlZyBLSCA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBNaWNoYWVsIFd1DQo+IDxtaWNoYWVsQGFsbHdp
bm5lcnRlY2guY29tPg0KPiBDYzogamlrb3NAa2VybmVsLm9yZzsgYmVuamFtaW4udGlzc29pcmVz
QHJlZGhhdC5jb207IGxpbnV4LQ0KPiB1c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1pbnB1dEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMaW1vbmNp
ZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+Ow0KPiBHb25nLCBSaWNoYXJk
IDxSaWNoYXJkLkdvbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gSElEOiB1c2Jo
aWQ6IGVuYWJsZSByZW1vdGUgd2FrZXVwIGZvciBtaWNlDQo+IA0KPiBPbiAyMy4wMi4yMyAxMjoy
MywgR3JlZyBLSCB3cm90ZToNCj4gDQo+ID4+IEkganVzdCB3YW50IHRvIGV4cGxhaW4gdGhlIGJh
Y2tncm91bmQgb2YgbXkgcGF0Y2gsIHRvIHByb3ZlIHdlIGNvdWxkIHVzZQ0KPiBhDQo+ID4+IHNp
bWlsYXIgd2F5IHRvIGF2b2lkIHN1Y2ggYSAiZGlzdHVyYmluZyIgc2l0dWF0aW9uLg0KPiA+PiBU
byByZWR1Y2UgdGhlIGluZmx1ZW5jZSwgbXkgcGF0Y2ggZW5hYmxlcyByZW1vdGUgd2FrZXVwIGZv
ciBVU0INCj4gbW91c2UNCj4gPj4gZGV2aWNlcyByZWZlciB0byB3aGF0IGtleWJvYXJkIGRvLg0K
PiA+DQo+ID4gS2V5Ym9hcmRzIGFyZSBub3QgbWljZSA6KQ0KPiA+DQo+IA0KPiBPSywgbGV0IG1l
IGV4cGxhaW4sIHdoeSBJIG5ldmVyIHByb3Bvc2VkIHN3aXRjaGluZyBvbiBhdXRvc3VzcGVuZA0K
PiBmb3IgbWljZSBvciB1c2luZyB0aGVtIGFzIGEgc3lzdGVtIHdha2V1cCBzb3VyY2UuIFRoZSBy
ZWFzb25zIGFyZSB2ZXJ5DQo+IHNpbWlsYXIuDQo+IA0KPiBCYXNpY2FsbHkgdGhlIHN0YW5kYXJk
IGdpdmVzIHVzIG5vIHdheSB0byBhc2sgYSBkZXZpY2Ugd2hhdCBjb25zdGl0dXRlcw0KPiBhIHdh
a2V1cCBldmVudCBmb3IgaXQuIFdlIGp1c3QgZ2V0IHRoZSBibGFua2V0IHN0YXRlbWVudCBvZiBz
dXBwb3J0DQo+IG9yIG5vIHN1cHBvcnQuDQo+IA0KPiBGb3IgcnVudGltZSBQTSBJIHdvdWxkIHdh
bnQgbXkgbW91c2UgdG8gZ2VuZXJhdGUgYSByZW1vdGUgd2FrZXVwDQo+IHdoZW5ldmVyIGEgYnV0
dG9uIGlzIHByZXNzZWQgb3IgdGhlIG1vdXNlIGlzIG1vdmVkLiBVbmRlciB0aGlzDQo+IHByZW1p
c2UgcnVudGltZSBQTSB3aXRoIGEgbW91c2Ugd29ya3Mgd29uZGVyZnVsbHkuIFRlc3RpbmcgdGhh
dCwNCj4gaG93ZXZlciwgaXMgYSBjaGFsbGVuZ2UuDQo+IEl0IHR1cm5zIG91dCB0aGF0IG1pY2Ug
dGhhdCBjbGFpbSB0aGF0IHRoZXkgc3VwcG9ydCByZW1vdGUgd2FrZXVwDQo+IGJ5IGFuZCBsYXJn
ZSBkZWFjdGl2YXRlIHRoZWlyIExFRC9sYXNlciB3aGVuIHlvdSBzZW5kIHRoZW0gaW50bw0KPiBz
dXNwZW5zaW9uLiBIZW5jZSB0aGV5IHJlYWN0IG9ubHkgdG8gYnV0dG9ucyBiZWluZyBwcmVzc2Vk
IG9yIG1vdXNlDQo+IHdoZWVscyBtb3ZlZC4NCj4gDQo+IEFzIGEgc3lzdGVtIHdha2V1cCBzb3Vy
Y2UgYSBtb3VzZSB0aGF0IGdlbmVyYXRlcyBldmVudHMgd2hlbg0KPiBpdCBpcyBtb3ZlZCwgaG93
ZXZlciwgd291bGQgbWFrZSB0aGUgc3lzdGVtIHVuc3VzcGVuZGFibGUsIHdoZW5ldmVyDQo+IGV2
ZW4NCj4gYSBiaXQgb2YgdmlicmF0aW9uIGlzIGFjdGluZyBvbiB0aGUgc3lzdGVtLg0KPiBBbmQg
YXMgUzQgaXMgdXNlZCBpbiBtYW55IHNldHVwcyB0byBwcmV2ZW50IGFuIHVuY29udHJvbGxlZCBz
aHV0ZG93bg0KPiBhdCBsb3cgcG93ZXIsIHRoaXMgbXVzdCB3b3JrLg0KDQpBdCBsZWFzdCBpbiBt
eSB2ZXJzaW9uIG9mIHRoZSBzZXJpZXMsIHRoaXMgaXMgcGFydCBvZiB0aGUgcmVhc29uIHRoYXQg
aXQgd2FzDQpvbmx5IGludGVuZGVkIHRvIGJlIHVzZWQgd2l0aCBzMmlkbGUuDQoNClRoZSBrZXJu
ZWwgZHJpdmVyIGlzIHdlbGwgYXdhcmUgb2Ygd2hhdCBwb3dlciBzdGF0ZSB5b3UncmUgaW4gdGhl
IHN1c3BlbmQNCmNhbGxiYWNrIChwbV9zdXNwZW5kX3RhcmdldF9zdGF0ZSkuDQoNCldoYXQgYWJv
dXQgaWYgd2UgYWdyZWVkIHRvIHRyZWF0IHRoaXMgb25lIHNwZWNpYWwgYnkgZXhhbWluaW5nIHRo
YXQ/DQoNCklmIHRoZSBzeXNmcyBpcyBzZXQgdG8gImVuYWJsZWQiDQoqIER1cmluZyBzdXNwZW5k
IGlmIHlvdXIgdGFyZ2V0IGlzIHMyaWRsZSAtPiBwcm9ncmFtIGl0DQoqIER1cmluZyBzdXNwZW5k
IGlmIHlvdXIgdGFyZ2V0IGlzIG1lbSAtPiBkaXNhYmxlIGl0DQoqIER1cmluZyBzdXNwZW5kIGlm
IHlvdXIgdGFyZ2V0IGlzIGhpYmVybmF0ZSAtPiBkaXNhYmxlIGl0DQoNCldpdGggdGhhdCB0eXBl
IG9mIHBvbGljeSBvbiBob3cgdG8gaGFuZGxlIHRoZSBzdXNwZW5kIGNhbGwgaW4gcGxhY2UNCnBl
cmhhcHMgd2UgY291bGQgc2V0IGl0IHRvIGVuYWJsZWQgYnkgZGVmYXVsdD8NCg0KPiANCj4gSSBz
dXNwZWN0IHRoYXQgbW9zdCwgYnV0IF9ub3RfIF9hbGxfIG1pY2UsIGFyZSBkZXNpZ25lZCBmb3Ig
dXNlDQo+IHdpdGggYSBzeXN0ZW0gdGhhdCB0aWVzIHBvd2VyIG1hbmFnZW1lbnQgdG8gdGhlIHNj
cmVlbiBzYXZlci4NCj4gVGhhdCBpcyBhIG1vZGUgb2Ygb3BlcmF0aW9uIHRoYXQgZHVlIHRvIHRo
ZSBsYWNrIG9mIGNvdXBsaW5nDQo+IGJldHdlZW4gR1VJIGFuZCBrZXJuZWwgaXMgaGFyZCB0byBj
b3B5Lg0KPiANCj4gRnJhbmtseSBnaXZlbiB0aGVzZSBjb25zdHJhaW50cyB0aGUgb25seSBkZWZh
dWx0IHNhZmUgaW4gZXZlcnkNCj4gY2FzZSBzZWVtcyB0byBtZSB0byBsZWF2ZSB0aGUga2VybmVs
J3MgZGVmYXVsdCBhdCBvZmYgYW5kDQo+IHB1dCB0aGUgd29yayBpbnRvIHVkZXYncyBod2RiLiBO
b3QgdGhhdCB0aGF0IGlzIGEgZ29vZCBzb2x1dGlvbiwNCj4gbWVyZWx5IHRoZSBiZXN0IEkgY2Fu
IGNvbWUgdXAgd2l0aC4NCj4gDQo+IAlSZWdhcmRzDQo+IAkJT2xpdmVyDQoNClR1cm5pbmcgb24g
ImF1dG9zdXNwZW5kIiBmb3IgVVNCIG1pY2UgbWFrZXMgdGhlbSBiZWhhdmUgcHJldHR5DQpzaW1p
bGFybHkgdG8gaG93IHRoZXkgd29yayB3aGVuIHRoZXkncmUgbWFya2VkIGZvciByZW1vdGUgd2Fr
ZXVwLg0KDQpPbiBzb21lIG1pY2UgdGhlIGxhc2VycyB0dXJuIG9mZiwgYW5kIHRoZXkgb25seSB3
YWtldXAgd2hlbiB5b3UNCnByZXNzIGEgYnV0dG9uIG9yIHJvbGwgYSB3aGVlbC4NCg==
