Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75360FC3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiJ0Prh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiJ0Pre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:47:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7450618982D;
        Thu, 27 Oct 2022 08:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4nuU4tdHkEeLf6VJksI5t++/3rogdMKW3iEHLmdWDRy+XmNAhviUTMGl/YMruh5zBj/UAm7HOCfIWvF3e72tnNC+7ULaFwM6fxvM+JuCDgFx2IwRMZYy7k5dHuKwxwUHftpOmf/TEK3Z9LNNh/elUWeH1SUNm3PAOh1ZXZneEkT4dRb+OL5PyjykM3D21HtmQZA0NKC2bpjX561/rHmMA7S5iEE/pXTg22JfIBYXhz/cY1AcxKz96lBy2JPeL2HbTjusra9w3d0It2RPwXpsp4cngDPozmzesXDgsLmb1HNIl4pZsX8GeTw7ZUW/3W6SnsZF+tqRIEh8K5Ogk6ysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhmqPqRaVwoCMuZNzsQ06+U/1LawbdOpNmCORoX2VcE=;
 b=kLBImx0VziqEBtCWpsvytBChbkzbgEWxZvEyJznj4Rf84ZRQluyW9PA2iQTR26c203vNmgIdyU9PM3PAEA8UK0rj5/BuVTpi0wcRhJwOCZKw/4T3pOsnI5gtSFxHqRiWiXoSQnoXTqyvztTgUw7CdRC/kpC4S9/cNhpSwTFWhbs/u+lPbPbyMzHRppZ7f1pzeDplz34ijrkToXuIcS6ITpZSZdfwPzILVeOVnQBdwAIxOZ6b+1wk5wsI4+25WPC6GGiBT+C2SbUQexXVk49u2UNPisyr0kH/Ee4T0DyN5bqtSLTUeENqBbyvizJ1JWZ5DRZCFcvZgCiya9dYv5NNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhmqPqRaVwoCMuZNzsQ06+U/1LawbdOpNmCORoX2VcE=;
 b=CPVqZUsYKhNetJscoAPMiydwSwysfgvDYvV78ZYpnp2XSgwepcuDV384nbpShYIkGbTZaRE6GrhodS5KyKlD9E2izcWEjTNtwV5YI1f+FRwBjgfM3APfg/NeVToHqjZa7gnC7bI/dmiRlUv1VWFXI3cOJn6rpZRQbk9GFCZo4qc=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 15:47:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.015; Thu, 27 Oct 2022
 15:47:31 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Subject: RE: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
Thread-Topic: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
Thread-Index: AQHY6hfBjWF6tgClnky1tqSxunvCJa4iYLoAgAAAdbA=
Date:   Thu, 27 Oct 2022 15:47:31 +0000
Message-ID: <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
 <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com>
In-Reply-To: <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-27T15:42:20Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=11f0dff9-011f-4755-b609-a7a9bd65e88d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-27T15:47:29Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 764976e4-0df3-4804-bd5a-065a7ae9f872
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH2PR12MB4293:EE_
x-ms-office365-filtering-correlation-id: 39783a5c-4ee2-4630-5779-08dab8328f33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SdLOK/4zmEfeY0ap2pvLYEkWSVFHLbYtjSecFdm4kf5fKduzVP7XptOHT8HM1kQeBGhqPsk0won5sopXHolZJdChhCGklBW2ziKQL+304+F354YxqvN/qdKAm4nZZ0BGx8+fOQwZQNDtuaiKDqWtcxUQyk3NBXTOBMJ/OEc5poGnMnJF0MBI+Kaq4Uyrcewo29PJJVQ+WP++4c+J96IFxsYUsyZSLDSQDnOiliUFYJXkz8Wh2ZvRlXop2d9cW95ilGwdM/Qkn66YrwfQXCUuE1FWzrXXyEhqj/cAXZiLckxZywUBPUiPNkJY2k+LA4HIXcBzSSkB+p2mbCJoZSLzy8Yby3PyBa4hKr8KJoEY33O0ZuLYCzxQk3KyBz9jM7CWwFSr1uZJanjMiHLWRx3B9qkzcz1fMtfOvuuhsEAoMArHPPemIoFUd/kR3se9eEU88KKDDfWmlA6Lei/RTH4TtsLz74gvjCc/42Hx90SsN1JnBSQnsddv5oGWclOLY5LVosKMbE/i5raM0jg1hNRjvWMEfIP8AhOBvgne4Tb/qeTYctzJ8zLnwOwY4P4s/6bs2QBzEw77h86l3JCfyDQeK9nBy7Gd4mYD2oPlGqZX5yg+5fHBdcw18lwBD4A4VvjGXHSDC37je8uhRTWpjcC6em9624Ifx2USV5bT+NRyW9WLwk9ty+Z4lpCazb4oVj5+OMcSBuZwXouC4ItTnxTkBY/KMOAOiQCZB5oXQUiq0EeOnT8Bp7x3Cdv6AGOQXfVjZ0ApXZKcZ7OL2rlhWEwKPDetZkauq4DoEdhJ00gOVFhmFLWgDSNps2PCWwAeJZ8d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(33656002)(2906002)(64756008)(66446008)(66476007)(66556008)(38070700005)(38100700002)(122000001)(7416002)(5660300002)(110136005)(52536014)(41300700001)(54906003)(8936002)(316002)(71200400001)(66946007)(55016003)(8676002)(76116006)(4326008)(83380400001)(26005)(9686003)(478600001)(966005)(53546011)(6506007)(7696005)(186003)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG5QQnRUVGFYOVVTUUtIYi9Pa0ErZjNrT2RJaWZpR1lXSnZveStEd0JsMS9n?=
 =?utf-8?B?WFM3Z3MxNnVnRHV1K3BFeTNtNnpmZ3ZEQncxcVNHRUxSd0MrTVg1cWZxTFdp?=
 =?utf-8?B?WUd4SXFjZmtGMFVsUVNTcFU4QXhqdVBwNnhNRU5JUVRkM3kydTRXOFA0VkYw?=
 =?utf-8?B?STg2dWY5VE9mSHd5TnZjNWlyRDU4Tmw1cnl2b05GbHgxakpncXdDNzErTlZK?=
 =?utf-8?B?Y1R1RS9vVlRlVUk2cnhGR2FvWTBHZ2ViK3JPMU14L1Y5TDQwN3FyRGNjTm9D?=
 =?utf-8?B?RThyYzA5c2RZZktIQzJydG5wNVdPTk9NaDlqdU9lRUp0VUhmYmJrR0NZV05J?=
 =?utf-8?B?QW1xY3o1aDRibEhjNlliVDhDZGpScGNlT1pqTTJ6bHNnTG03RnVMaGpPSFVV?=
 =?utf-8?B?VHFoYytpeVdnRHc3MTRXdzFESE1WbDY0ME55N1g0YTArYzJWZitOejNxTlA1?=
 =?utf-8?B?TyszZFk2OURkdDg0L1NvQTFqWCtYaExqd2NHZUMwcy9jTGhxMDdNRVJvYURq?=
 =?utf-8?B?a3RmU3J1WUxsL2xubU1ocGRHeTRNZ2w5WkJiRjlNbEM0dk5RaFJxM08wbXFI?=
 =?utf-8?B?ZEl1RDF0NUxCUllTNEpDcTRJUHJOQVZtd2hUaXZTTXhKQW9iNEQ4SVU1aGtM?=
 =?utf-8?B?b28wcG5WRUs5azhlTVpvenl4Rnk4VDkzN0d4eXZUSjJXTG9vSVV4MTNrSlpt?=
 =?utf-8?B?YkZmV2Q4T2pqT0JRVFJremZ3QmVVcUNxQitGSVRiZk50bk5aa09lc2U5U1B1?=
 =?utf-8?B?bWRYeFFrZU4zaDRhbFcwSVVqZ3A5QmRhRzlyTyt4T3YvWnpyb2lYb0c3UHFv?=
 =?utf-8?B?aUdLbHVsTUVLdG4xdXp1dFNMME9WdUFENWhzMmNDZ2NSSjBwUElBbzE0OVEv?=
 =?utf-8?B?VWpQOCtEUDlybUhSMVg1NUl0cTArWjJZVWhNYnJnd0d3YllWMk9QdVJsNzBI?=
 =?utf-8?B?T0hnY2dXOW45K2oxb0w4U1N5RkQ4VDc4TTVTUmJjdkgreURZZHI5VmVlQ0Qv?=
 =?utf-8?B?U2lFeEF1ejJydHlQaFp2UG9RL1FlK01EWUNKUnNMamRrMllTaTlCaGFPQnhr?=
 =?utf-8?B?UlpueGR3OFExSzc2bFRQYStnbUhtRUVXaFVTM3NqY1R2aUQ3T1MzTXYyZHFh?=
 =?utf-8?B?ekNRTGV2R0ZXQ0huV0xtRGNIeEdud0ZxbGxiMXBIbkZpdThUU21ub1VTQkQ1?=
 =?utf-8?B?elVmTWdUeDhoaUdTb01UNmIwSVdJcVB5Mmx5dEZ6V2ZPVng1WXlweEltbHZC?=
 =?utf-8?B?cDJlRGtkRzhvb1FtVG5HaXVadnZUa0cvSFRYTkRFeXU3T2xWdUgvZmI1NElZ?=
 =?utf-8?B?Vmp4cHpNSjhVRXhNeHF2RnNjY1Z5VW43SmJOS2tOenJ3NmpUYXd0RHMyazhJ?=
 =?utf-8?B?MXBzZUpweU5vbWJOc3k1cXMxNXppbXBJeG02OVZDWkhVOE0yakV5UjA2QzlV?=
 =?utf-8?B?blBTbDFZb0pkdmxjbkd1ZndoTEkyTEcxN2FHOUxOVlh4MGM2L1k2c1BCZVc0?=
 =?utf-8?B?VDZFK05ITlZjelBKaGZYV1FTSnBlSTFWeWFTV3dJbUJQYzdnUEJlWkZtMkFX?=
 =?utf-8?B?MGJQc2g1cGFyWnhyZjc5ckZWUC9aUFhJUndiYkxTQWlFQkVaOWlsY2FYdDBm?=
 =?utf-8?B?S09qaTI5Y21jRDRxU0RUUXJzZlJpU005UkV0Rm56bmdGdHl4ZldObk4vb0M2?=
 =?utf-8?B?OHo0T1FTSnZOS1grV3FCMHpYYmI4UnlYRklkMUtaU0JiRzNGK3FEL2lyYVov?=
 =?utf-8?B?REtIeWZvOHBzUmk4MUtxTlpESTFUTEYwSHJUZUZnR1VDUHJuMUY2RVZrTVIx?=
 =?utf-8?B?akNXeVBQdnN0L3Y3NGpFVkJ2MWJrSWRNYUhFUnhia1dhTlBCcUdEVXFtbHpB?=
 =?utf-8?B?NDYrZlpvMDBKT3R4cHpYZUNJVEF3ekZjdDZmNnpmLzcyemZrQWsxNm5KRDdZ?=
 =?utf-8?B?ck0wY2pvUzBaakd0M3ArTVpqWWU1NFNNc3Z1STc1TFhJZHVsbWVIaVJEMkRN?=
 =?utf-8?B?S1YwaW1lY0JzYVBqUmFtSGFCWGNTU093MG9ENzRHM0hlQlRVeFNTQUJMN2ZG?=
 =?utf-8?B?dVlNZ1FqOHQ2eU44Yi83T1FHSitBVEQ2ODl6bnI3YUV3d1NXZWloaDZnaDdW?=
 =?utf-8?Q?TKRk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39783a5c-4ee2-4630-5779-08dab8328f33
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 15:47:31.6260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0q5zAz50vDOzk0VQ3AD8zZa1I5j31goMnmays9J6yqG3ltyRxcI345/9lcwIlrFX1xkeOV4zlNsPCivMPCsnqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KK1NoeWFtICYgUmF1bA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBPY3RvYmVyIDI3LCAyMDIyIDEwOjQxDQo+IFRvOiBTdmVuIHZhbiBBc2hicm9vayA8
c3ZlbnZhQGNocm9taXVtLm9yZz47IExLTUwgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnPg0KPiBDYzogcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7IFJham5lZXNo
IEJoYXJkd2FqDQo+IDxyYWpuZWVzaC5iaGFyZHdhakBpbnRlbC5jb20+OyBSYWZhZWwgSiBXeXNv
Y2tpIDxyandAcmp3eXNvY2tpLm5ldD47DQo+IFJhamF0IEphaW4gPHJhamF0amFAZ29vZ2xlLmNv
bT47IERhdmlkIEUgQm94IDxkYXZpZC5lLmJveEBpbnRlbC5jb20+Ow0KPiBNYXJrIEdyb3NzIDxt
YXJrZ3Jvc3NAa2VybmVsLm9yZz47IFJham5lZXNoIEJoYXJkd2FqDQo+IDxpcmVuaWMucmFqbmVl
c2hAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBwbGF0Zm9ybS94ODY6IGlu
dGVsX3BtY19jb3JlOiBwcm9tb3RlIFMwaXggZmFpbHVyZQ0KPiB3YXJuKCkgdG8gV0FSTigpDQo+
IA0KPiBIaSwNCj4gDQo+IE9uIDEwLzI3LzIyIDE3OjE5LCBTdmVuIHZhbiBBc2hicm9vayB3cm90
ZToNCj4gPiBUaGUgImZhaWx1cmUgdG8gZW50ZXIgUzBpeCIgd2FybmluZyBpcyBjcml0aWNhbGx5
IGltcG9ydGFudCBmb3IgbW9uaXRvcmluZw0KPiA+IGFuZCBkZWJ1Z2dpbmcgcG93ZXIgcmVncmVz
c2lvbnMsIGJvdGggaW4gdGhlIGZpZWxkIGFuZCBpbiB0aGUgdGVzdCBsYWIuDQo+ID4NCj4gPiBQ
cm9tb3RlIGZyb20gbG93ZXItY2FzZSB3YXJuKCkgdG8gdXBwZXItY2FzZSBXQVJOKCkgc28gdGhh
dCBpdCBiZWNvbWVzDQo+ID4gbW9yZSBwcm9taW5lbnQsIGFuZCBnZXRzIHBpY2tlZCB1cCBhcyBw
YXJ0IG9mIGV4aXN0aW5nIG1vbml0b3JpbmcNCj4gPiBpbmZyYXN0cnVjdHVyZSwgd2hpY2ggdHlw
aWNhbGx5IGZvY3VzZXMgb24gV0FSTigpIGFuZCBpZ25vcmVzIHdhcm4oKQ0KPiA+IHR5cGUgbG9n
IG1lc3NhZ2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3ZlbiB2YW4gQXNoYnJvb2sgPHN2
ZW52YUBjaHJvbWl1bS5vcmc+DQo+IA0KPiBXQVJOKCkgaXMgcmVhbGx5IG9ubHkgaW50ZW5kZWQg
Zm9yIGludGVybmFsIGtlcm5lbCBidWdzIGFuZCBub3QgZm9yDQo+IGh3IG1pc2JlaGF2aW5nLCBz
byBJJ20gbm90IGEgZmFuIG9mIHRoZSBjaGFuZ2UgeW91IGFyZSBzdWdnZXN0aW5nIGhlcmUuDQo+
IA0KPiBJbnRlbCBmb2xrcywgZG8geW91IGhhdmUgYW4gb3BpbmlvbiBvbiB0aGlzID8NCg0KRm9y
IGEgcmVmZXJlbmNlIHBvaW50OyBvbiBBTUQncyBpbXBsZW1lbnRhdGlvbiBvZiBhIHNpbWlsYXIg
ZHJpdmVyIChwbGF0Zm9ybS94ODYvYW1kL3BtYy5jKQ0KdGhpcyAidHlwZSIgb2YgbWVzc2FnZSBp
cyBhbHNvICJkZXZfd2FybiI6DQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxv
Yi9tYXN0ZXIvZHJpdmVycy9wbGF0Zm9ybS94ODYvYW1kL3BtYy5jI0wzNjUNCg0KSWYgd2UgZG8g
bWFrZSBjaGFuZ2VzIHRvIHRoaXMgbWVzc2FnZSBsZXZlbCBzbyB0aGF0IG90aGVyIGluZnJhc3Ry
dWN0dXJlIHBpY2tzIHVwIEkgc3VnZ2VzdA0Kd2UgZG8gaXQgZm9yIGJvdGggZHJpdmVycy4NCg0K
QXJlIHdlIG1heWJlIGF0IHRoZSBwb2ludCBub3cgaXQgc2hvdWxkIGJlIGRldl9lcnIgaW5zdGVh
ZD8NCg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCj4gDQo+IA0KPiA+IC0tLQ0KPiA+IEFn
YWluc3QgdjYuMS1yYzINCj4gPg0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMv
Y29yZS5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRl
bC9wbWMvY29yZS5jDQo+IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuYw0K
PiA+IGluZGV4IGExZmUxZTBkY2Y0YTUuLjgzNGYwMzUyYzBlZGYgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
cGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMNCj4gPiBAQCAtMjEyNSw3ICsyMTI1LDcgQEAg
c3RhdGljIF9fbWF5YmVfdW51c2VkIGludA0KPiBwbWNfY29yZV9yZXN1bWUoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KPiA+ICAJfQ0KPiA+DQo+ID4gIAkvKiBUaGUgcmVhbCBpbnRlcmVzdGluZyBjYXNl
IC0gUzBpeCBmYWlsZWQgLSBsZXRzIGFzayBQTUMgd2h5LiAqLw0KPiA+IC0JZGV2X3dhcm4oZGV2
LCAiQ1BVIGRpZCBub3QgZW50ZXIgU0xQX1MwISEhIChTMGl4IGNudD0lbGx1KVxuIiwNCj4gPiAr
CWRldl9XQVJOKGRldiwgIkNQVSBkaWQgbm90IGVudGVyIFNMUF9TMCEhISAoUzBpeCBjbnQ9JWxs
dSlcbiIsDQo+ID4gIAkJIHBtY2Rldi0+czBpeF9jb3VudGVyKTsNCj4gPiAgCWlmIChwbWNkZXYt
Pm1hcC0+c2xwczBfZGJnX21hcHMpDQo+ID4gIAkJcG1jX2NvcmVfc2xwczBfZGlzcGxheShwbWNk
ZXYsIGRldiwgTlVMTCk7DQo=
