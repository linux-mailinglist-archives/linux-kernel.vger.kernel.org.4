Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8555F7C99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJGR5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJGR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:57:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4CD9949
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Juid9oAln2zKYbJ5Zn374mI2CtNyJ2go0rbF4laPis50p1d3NvrjkUzzpO55WiVXFFDjajCIJooW70KeMTY5AAQHI6nH4ctkJpUl9BjqZ3ufWGod5Vq7EVgKyTBihjdl7LsqKoPakFpw8fCsDAHGR6lgTs9nKbFnMvKVYFZiRS9Okb6Dge/GkMTaLByFlfRio5E30MFadC7/lHueTff2qUgbhUdNhgF7UvVy6ZnCcG5n5X/Ky+R3AUfA7NnRW5MkJj0pVaP0ZH5jh/IiEGWeQlwAWmt8vxDv0rniDJlrQ4aDXA+eI6xWOjD57snm275SX5jNRSBvfOls4kpiLCpG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1iARpufB7piX7j6UOOABbZJ80oRgafyPXAie1MJsEw=;
 b=hOjcLsTah/X+Scz36rdbaQlggM4NytCOpcyoZgdfZwEUnR3B7YJYkvGdMFcOYVha7Iw2Az0pWQdG3JOhvEX3I1swvYVMxzwOGbWZZ6D/8pVZ34EkknGD9YSCsP6hTWfD7QpHuizUdhkFkjwAZvDLeqhNpJkbn7sxzRUBVPr0saRg9ddnwJlmfGKEVPFlEP9GfpYMGmGMmm70UBLZzdqGaY8JvvYIfEKTbiNwLLtpiA7C/ZNOh4bnfRV+qmfmoH/fGXdVDxz94lpeH/7yVspRRxRG27fVv5/hkCdFDNVLERjKDaNK93QcWYXbEjfqQayN3WCA2jQzdzQICwlkiapmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1iARpufB7piX7j6UOOABbZJ80oRgafyPXAie1MJsEw=;
 b=OvosxTFs3eFb9u5Z64MguXR5YWLJIK/Hcz5azHQX5cagMdtYZ/d1vCiZy1p4vbM0OxbU2SujO13Lt5L15ONFLT3S/i4w0fwKDnDMRI9AxIurIbKOOBs/T27dH/Jb0iAec59WS4MSJFteaeOiEDeLoVlLyuTB90fVZNdutyLxlYg=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB7316.namprd12.prod.outlook.com (2603:10b6:930:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 17:57:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e%3]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 17:57:23 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Peter Newman <peternewman@google.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Stephane Eranian <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>
Subject: RE: [RFD] resctrl: reassigning a running container's CTRL_MON group
Thread-Topic: [RFD] resctrl: reassigning a running container's CTRL_MON group
Thread-Index: AQHY2jkgj8cJdrpBrk6pqh1oLW7hm64DMlSA
Date:   Fri, 7 Oct 2022 17:57:22 +0000
Message-ID: <MW3PR12MB45531D396A2010666F3E238F955F9@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
In-Reply-To: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-07T17:36:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=735d2c2c-e9b0-477d-8f12-e13c3f37b50e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-07T17:57:21Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 95cbfcc3-cc4e-4a76-bc11-0e8f65903d7c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|CY8PR12MB7316:EE_
x-ms-office365-filtering-correlation-id: 49022ec7-991d-4ef6-d1b6-08daa88d6305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yUGY64p0NRNnXATWT0QZ3GUNHJcdWBR1nhEi/XYv0cMggv/O5oZ2k/4u43Utorx3XqgbFRLDYUij+wP6Rc8ZOuWAIm6INoFYJ1wI7WIG4WOlfg7fJ1NvyNPyGcoH5+BrrrKG7Kd6yvSMy4dPfRBWj3DjWPQJNKCefDKfTP7z1WCrPZJPbulUyLkou1Hf6Utx+jZ3hQTr4G9+5arq1eQwg0hAY0p7F5KiFyx9auEG4FxEEx4zRORFGuuKWYp7KTqgSGmNVJvpgaeIEVPWbYGTSP6GSJzacIvKgdkBu9MlrXe9RX8vHZxBLKu1aG8Gur1WtV+CchLbbOnVsqQScrxCFEXJ9Tw4fdEUTf6wE6TbpjE/+h2epo0bfyENwOZyRAIv1GIB5sNx6cayOZf54tR1eAbotjXRL4hycYWwl5zNGoIdMv8ahbcKczr0UutiO2Cid8fu/MPtk6gdbl1lteDyxcX/4jPicZyjgqKa164CzaW6bWlfAOaxsvSYxvKHSCdHkuR9VGfgzdR2xI8nG2oUjyqZ8vhzYlpPNXS0ln/Ni/CEudslkD4KoP088ZZbbYw8iU1ODpj1VOBVVq2gW2H3JRBvH9JbI5lSViYTNhnQU67Cr+J9Jd1f0nZxBHfqU0H2yup78KHsbK6EAiFUQ0z8eCHqF+w7Ts0DvfSjwOUBZzG2FjYHSt0Q3/SoQ0VSPlaApw3QF2L6i6PX/9jWNTu2WfRpBbyY6mOUi9BloVK/j8CkyibKvv9FXCUQ8eqMlwFEjk562k93spE1opGyYn9h7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(33656002)(2906002)(38070700005)(8676002)(122000001)(52536014)(41300700001)(5660300002)(8936002)(66476007)(64756008)(55016003)(66446008)(38100700002)(76116006)(66556008)(4326008)(66946007)(26005)(6506007)(7696005)(54906003)(110136005)(316002)(71200400001)(86362001)(9686003)(53546011)(478600001)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTNJS0xkdlIrODhCM3o1UGdpYi9VTEN4QjR5TWNSbmE2WjUvSlFYWGZzcHdT?=
 =?utf-8?B?QXc5TGFnM3BkUVBzenA3UDlZVkFHTm55RUN2T0VBZHUxUWprNmNjNnZLd2J4?=
 =?utf-8?B?ZGhLY21oUndwY3g2NjREcmJML2xXbjNiM1A4Yi9iSG55SVBKR1B3dncxYUp4?=
 =?utf-8?B?ZEMyZXlGRldsenp5NEg3QVNJVkhNQUNsSzI4ZU1OSFUvK3dCZ1dVdG9ZSE5h?=
 =?utf-8?B?WGdBSjNFK1Ayc1hNQUNpZFhsWnBzR3Fpc2t2Zy9sZGNuM0VsWkRBVTJzdVF0?=
 =?utf-8?B?MXNOWnRkT25FbkVTTnFLTXZTN2lxNndRWUJ6MEYrWHFnenIvQzFqYlJmVnVG?=
 =?utf-8?B?OWRpaVpNK3BYWGFKbjZMbGgwVnk4ZXVLNTVFUmlYSUhvdnBFTnVhWjVQYzNQ?=
 =?utf-8?B?TDBkdjRQdnk1bjlsNm9vL1dNRXdHVmRUZWVIa214KzhYbW15ZUtmZkZwOTZX?=
 =?utf-8?B?bDVQbHp4MEs2K1BxWEFHVkhPbU9TZk1sVjQ1ZTJpVkFqYU1NN0Z3bk8wQ2ZY?=
 =?utf-8?B?dzlieHBnZERscy8veG93dWlQdDhleEt1dXJzaEdtU3JlellmbUFJbFdreFpp?=
 =?utf-8?B?ZmQ2L3N4TStYR012NzcvTncvbkU3M0VneEN1N0hZRmhlMkMzb3BnREE2MzI0?=
 =?utf-8?B?eTdCNzA2OUl6Y2FTTkxYRGFLVjhCSWJac09lc0Ixc3AxVVkvK1FmQ2dIVUhl?=
 =?utf-8?B?SjZvK3hmUHd6VVNkcFpKNm96RnFlbjdLTW03eWlkSWU4ejJMRTZwZmkxL05q?=
 =?utf-8?B?NkxmQjJBbGV5ZTZjTzNhMGxock8yRVRidTdTMCtDalJqR0tEZXluTTRGQWdI?=
 =?utf-8?B?Q0x6TFlqSHV3T3h2OHZBSFRTMnpMc3pieWJVRmRjU0NwWm04elBpNnpwbTU4?=
 =?utf-8?B?K0JrL3RkK0JQclhsQVdHWHlDblRmbU5GMU1HN3hyRXBGUHp3Y3lTRk1jcFhK?=
 =?utf-8?B?SWtWb3FmN1hINVE0cXgwSkx0aUVaRWZjODhNZ3Vib08yZFZiOS9TUW4xaWVB?=
 =?utf-8?B?T29QSWJQT0M2cE1PTVBDZEZocm0vVjBtKzB3eGsvTHc5QkV3MStLSUNQbHZM?=
 =?utf-8?B?akRsd3ZIN2x0NUROSGREZDhlVTQ0LytMTG5DZ3AxWktZN1ZyQlAyYXIyZ1A1?=
 =?utf-8?B?c2RYQUNNQVB6bFp3YndUYVVINGQ5ZS9rcU9BZHBXSyt3cVJVS05VSXBMQkpo?=
 =?utf-8?B?U3VzV3AzaTZGQTZ6UllYbzdEbTVWamJJZGREbGoyWWw1ckk0Znd4KzJsajdx?=
 =?utf-8?B?eWUwWTZKbFJPdTRVMGpmcnZBbVAxMllPd1N1cktkOWdHNFVDemFqQVdwRy81?=
 =?utf-8?B?ekZsWXM2alpSNVcwbTRZdERXZS9LUFdIVGJNdzNydU5xT2dpTXJEUVdxN0J1?=
 =?utf-8?B?SGNYWHUzMTBiOFdJVzhxQVgxa3hTSi96MEkydFBrT2EwTWlENjZOTjl3b0U5?=
 =?utf-8?B?YVpicVozSFFHamtwRlNkU2pRckcvQUNPRWkvNlkrY3JGc2d1eFdRQ0lEa0gv?=
 =?utf-8?B?UW1mWHlsZFk5MC9Rbi9ESVNHaFRjcWxVaUZycU1xR25qOXIyMk5FckRjdlBV?=
 =?utf-8?B?am14S00zNkllZXVYa211WitXSjk0b1dvYTcwM0k3YWNzeWVIZzBlOFVEUVJJ?=
 =?utf-8?B?R1oyOURSbG4xaXBKTkFOUlpIeHRMUFFBWmpMS0I2aHlQK0labWFabzd6aFJN?=
 =?utf-8?B?cjlTZUhOOTREWjArdlNmMDFLMmh0NDkvUlJNNG5CcHFINUxVYnNsS044YUZa?=
 =?utf-8?B?VWt4ZlFBb1BJVUZYcVU3cStrU0YrSnFnUlErYlJ3UU1JTmVxUEw2b3VvRkNl?=
 =?utf-8?B?VUhFK0wwa1VoelpCTTl5VjY1Nk5ZNG95Wmd2OTl1QlpiQWxWcEVSRElHQ3hT?=
 =?utf-8?B?VUZyWlBqSHkwMkxGMWI1VFczUVNPSnBJOW9VajRQenRONkcyUkZTSDFXTXox?=
 =?utf-8?B?dGdTTXlJdTBpSzF2YkYvNmRkdzIwZWYwZ0ExRUxTaTBZNkM3NENGTm8vaFZT?=
 =?utf-8?B?VGllZ290aFFSYnZLMTZpRjlMeWRadThqRVp5NEQxeUJoNkRIN0F6TkNSNWVu?=
 =?utf-8?B?UCt0aENKMEUrMHFsVjJJQWMrZFlCTWRYK0xMenVYZHA2QjZPZHhhQUVaOHhT?=
 =?utf-8?Q?juVE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49022ec7-991d-4ef6-d1b6-08daa88d6305
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 17:57:23.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6tI38qnH8p9W05zyXCfDuegNEOivK/r0TVSR7lu1midxSEX7u7NCyaTJaquG4VX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFBldGVyLA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBldGVyIE5ld21hbiA8cGV0ZXJuZXdtYW5A
Z29vZ2xlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDcsIDIwMjIgNTo0MCBBTQ0KPiBU
bzogUmVpbmV0dGUgQ2hhdHJlIDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPjsgRmVuZ2h1YSBZ
dQ0KPiA8ZmVuZ2h1YS55dUBpbnRlbC5jb20+DQo+IENjOiBTdGVwaGFuZSBFcmFuaWFuIDxlcmFu
aWFuQGdvb2dsZS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IEphbWVzIE1vcnNlDQo+IDxqYW1lcy5tb3Jz
ZUBhcm0uY29tPjsgTW9nZXIsIEJhYnUgPEJhYnUuTW9nZXJAYW1kLmNvbT4NCj4gU3ViamVjdDog
W1JGRF0gcmVzY3RybDogcmVhc3NpZ25pbmcgYSBydW5uaW5nIGNvbnRhaW5lcidzIENUUkxfTU9O
IGdyb3VwDQo+IA0KPiBIaSBSZWluZXR0ZSwgRmVuZ2h1YSwNCj4gDQo+IEknZCBsaWtlIHRvIHRh
bGsgYWJvdXQgdGhlIHRhc2tzIGZpbGUgaW50ZXJmYWNlIGluIENUUkxfTU9OIGFuZCBNT04gZ3Jv
dXBzLg0KPiANCj4gRm9yIHNvbWUgYmFja2dyb3VuZCwgd2UgYXJlIHVzaW5nIHRoZSBtZW1vcnkt
YmFuZHdpZHRoIG1vbml0b3JpbmcgYW5kDQo+IGFsbG9jYXRpb24gZmVhdHVyZXMgb2YgcmVzY3Ry
bCB0byBtYWludGFpbiBRb1Mgb24gZXh0ZXJuYWwgbWVtb3J5IGJhbmR3aWR0aA0KPiBmb3IgbGF0
ZW5jeS1zZW5zaXRpdmUgY29udGFpbmVycyB0byBoZWxwIGVuYWJsZSBiYXRjaCBjb250YWluZXJz
IHRvIHVzZSB1cA0KPiBsZWZ0b3ZlciBDUFUvbWVtb3J5IHJlc291cmNlcyBvbiBhIG1hY2hpbmUu
ICBXZSBhbHNvIG1vbml0b3IgdGhlIGV4dGVybmFsDQo+IG1lbW9yeSBiYW5kd2lkdGggdXNhZ2Ug
b2YgYWxsIGhvc3RlZCBjb250YWluZXJzIHRvIGlkZW50aWZ5IG9uZXMgd2hpY2ggYXJlDQo+IG1p
c3VzaW5nIHRoZWlyIGxhdGVuY3ktc2Vuc2l0aXZlIENvUyBhc3NpZ25tZW50IGFuZCBkb3duZ3Jh
ZGUgdGhlbSB0byB0aGUNCj4gYmF0Y2ggQ29TLg0KPiANCj4gVGhlIHRyb3VibGUgaXMsIGNvbnRh
aW5lciBtYW5hZ2VyIGRldmVsb3BlcnMgd29ya2luZyB3aXRoIHRoZSB0YXNrcyBpbnRlcmZhY2UN
Cj4gaGF2ZSBjb21wbGFpbmVkIHRoYXQgaXQncyBub3QgdXNhYmxlIGZvciB0aGVtIGJlY2F1c2Ug
aXQgdGFrZXMgbWFueSAob3IgYW4NCj4gdW5ib3VuZGVkIG51bWJlciBvZikgcGFzc2VzIHRvIG1v
dmUgYWxsIHRhc2tzIGZyb20gYSBjb250YWluZXIgb3ZlciwgYXMgdGhlDQo+IGxpc3QgaXMgYWx3
YXlzIGNoYW5naW5nLg0KPiANCj4gT3VyIHNvbHV0aW9uIGZvciB0aGVtIGlzIHRvIHJlbW92ZSB0
aGUgbmVlZCBmb3IgbW92aW5nIHRhc2tzIGJldHdlZW4NCj4gQ1RSTF9NT04gZ3JvdXBzLiBCZWNh
dXNlIHdlIGFyZSBtYWlubHkgdXNpbmcgTUIgdGhyb3R0bGluZyB0byBpbXBsZW1lbnQNCj4gUW9T
LCB3ZSBvbmx5IG5lZWQgdHdvIGNsYXNzZXMgb2Ygc2VydmljZS4gVGhlcmVmb3JlIHdlJ3ZlIG1v
ZGlmaWVkIHJlc2N0cmwgdG8NCj4gcmV1c2UgZXhpc3RpbmcgQ0xPU0lEcyBmb3IgQ1RSTF9NT04g
Z3JvdXBzIHdpdGggaWRlbnRpY2FsIGNvbmZpZ3VyYXRpb25zLA0KPiBhbGxvd2luZyB1cyB0byBj
cmVhdGUgYSBDVFJMX01PTiBncm91cCBmb3IgZXZlcnkgY29udGFpbmVyLiBJbnN0ZWFkIG9mDQo+
IG1vdmluZyB0aGUgdGFza3Mgb3Zlciwgd2Ugb25seSBuZWVkIHRvIHVwZGF0ZSB0aGVpciBDVFJM
X01PTiBncm91cCdzDQo+IHNjaGVtYXRhLiBBbm90aGVyIGJlbmVmaXQgZm9yIHVzIGlzIHRoYXQg
d2UgZG8gbm90IG5lZWQgdG8gYWxzbyBtb3ZlIGFsbCBvZiB0aGUNCj4gdGFza3Mgb3ZlciB0byBh
IG5ldyBtb25pdG9yaW5nIGdyb3VwIGluIHRoZSBiYXRjaCBDVFJMX01PTiBncm91cCwgYW5kIHRo
ZQ0KPiB1c2FnZSBjb3VudHMgcmVtYWluIGludGFjdC4NCj4gDQo+IFRoZSBDTE9TSUQgbWFuYWdl
bWVudCBydWxlcyB3b3VsZCByb3VnaGx5IGJlOg0KPiANCj4gIDEuIElmIGFuIHVwZGF0ZSB3b3Vs
ZCBjYXVzZSBhIENUUkxfTU9OIGdyb3VwJ3MgY29uZmlnIHRvIG1hdGNoIHRoYXQgb2YNCj4gICAg
IGFuIGV4aXN0aW5nIGdyb3VwLCB0aGUgQ1RSTF9NT04gZ3JvdXAncyBDTE9TSUQgc2hvdWxkIGNo
YW5nZSB0byB0aGF0DQo+ICAgICBvZiB0aGUgZXhpc3RpbmcgZ3JvdXAsIHdoZXJlIHRoZSBkZWZp
bml0aW9uIG9mICJtYXRjaCIgaXM6IGFsbA0KPiAgICAgY29udHJvbCB2YWx1ZXMgbWF0Y2ggaW4g
YWxsIGRvbWFpbnMgZm9yIGFsbCByZXNvdXJjZXMsIGFzIHdlbGwgYXMNCj4gICAgIHRoZSBjcHUg
bWFza3MgbWF0Y2hpbmcuDQo+IA0KPiAgMi4gSWYgYW4gdXBkYXRlIHRvIGEgQ1RSTF9NT04gZ3Jv
dXAgc2hhcmluZyBhIENMT1NJRCB3aXRoIGFub3RoZXIgZ3JvdXANCj4gICAgIGNhdXNlcyB0aGF0
IGdyb3VwIHRvIG5vIGxvbmdlciBtYXRjaCBhbnkgb3RoZXJzLCBhIG5ldyBDTE9TSUQgbXVzdA0K
PiAgICAgYmUgYWxsb2NhdGVkLg0KPiANCj4gIDMuIEFuIHVwZGF0ZSB0byBhIENUUkxfTU9OIGdy
b3VwIHVzaW5nIGEgbm9uLXNoYXJlZCBDTE9TSUQgd2hpY2gNCj4gICAgIGNvbnRpbnVlcyB0byBu
b3QgbWF0Y2ggYW55IG90aGVycyBmb2xsb3dzIHRoZSBjdXJyZW50IHJlc2N0cmwNCj4gICAgIGJl
aGF2aW9yLg0KPiANCj4gQmVmb3JlIEkgcHJlcGFyZSBhbnkgcGF0Y2hlcyBmb3IgcmV2aWV3LCBJ
J20gaW50ZXJlc3RlZCBpbiBhbnkgY29tbWVudHMgb3INCj4gc3VnZ2VzdGlvbnMgb24gdGhlIHVz
ZSBjYXNlIGFuZCBzb2x1dGlvbi4NCj4gDQo+IEFyZSB0aGVyZSBzaW1wbGVyIHN0cmF0ZWdpZXMg
Zm9yIHJlYXNzaWduaW5nIGEgcnVubmluZyBjb250YWluZXIncyB0YXNrcyB0byBhDQo+IGRpZmZl
cmVudCBDVFJMX01PTiBncm91cCB0aGF0IHdlIHNob3VsZCBiZSBjb25zaWRlcmluZyBmaXJzdD8N
Cj4gDQo+IEFueSBjb25jZXJucyBhYm91dCB0aGUgQ0xPU0lELXJldXNpbmcgYmVoYXZpb3I/IFRo
ZSBob3BlIGlzIGV4aXN0aW5nIHVzZXJzDQo+IHdobyBhcmVuJ3QgY3JlYXRpbmcgaWRlbnRpY2Fs
bHktY29uZmlndXJlZCBDVFJMX01PTiBncm91cHMgd291bGQgYmUNCj4gbWluaW1hbGx5IGltcGFj
dGVkLiBXb3VsZCBpdCBoZWxwIGlmIHRoZSBwcm9wb3NlZCBiZWhhdmlvciB3ZXJlIG9wdC1pbiBh
dA0KPiBtb3VudC10aW1lPw0KDQpJIGFtIHN0aWxsIHRyeWluZyB0byB1bmRlcnN0YW5kLiBJIHdv
dWxkIHRoaW5rIHdoZW4gY3JlYXRpbmcgYSBuZXcgZ3JvdXAsIHRoZSBuZXcgQ0xPUyBpZCB3aWxs
IGJlIHVzZWQuIEJhc2ljYWxseSwgaXQgd2lsbCByZW1haW4gYXMgZGVmYXVsdCBiZWhhdmlvci4g
IFlvdSBwcm9iYWJseSBkb27igJl0IG5lZWQgdG8gY3JlYXRlIHR3byBpZGVudGljYWwgZ3JvdXAg
ZHVyaW5nIHRoZSBncm91cCBjcmVhdGlvbi4NCk5ldyBiZWhhdmlvciBvZiBjaGFuZ2luZyB0aGUg
Q0xPUyBpZCB3aWxsIGhhcHBlbiB3aGVuIHRoZSAibWF0Y2ggY2hlY2siIGlzIHRyaWdnZXJlZC4g
SG93IGlzIHRoZSBtYXRjaCBjaGVjayBpcyB0cmlnZ2VyZWQ/IElzIGl0IHRyaWdnZXJlZCBieSB1
c2VyPw0KVGhhbmtzDQpCYWJ1DQoNCiANCg==
