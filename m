Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6569CFCD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjBTPA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjBTPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:00:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6854BFF1E;
        Mon, 20 Feb 2023 07:00:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dstXdpBL6kZ17sT9Cx2YkQQhDOsozJdvsJp9Qxn8ij3qX/aW1IyNbNJrUcSxq/jqaOiTNU5fTuW7WAgeYYOhGr7t2Gx7t2DAd9ss1jtNqWRZoCnrFq4ekAsFlK07dGWeO9E2GjS8iENDH122Hm0uqGAwo9hM0w4vHVRDpyWhktNHzNnSfKjcv9vYSCUM+2nTj18ppmkQRRfGyIRPNWQwF9YAmRdXnWLD5AlrJe8sraljSgBc9gypHbN/cV3vFEwkMcw+y7c9KRmtvjOXGPt6NwvwZvcydKm8QFjeMSFDokT5F2PgQTlhmbVsx7UksHURhMJ8WzcEqV/0wfyqyw2NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di9DFGM4oWOrrD/bbPnJONBcsiU6ytbLXNaxOqdk5sY=;
 b=Q8QMx9JyARiy1Fpmqyr8JL63aLulyMg/1x3gEce8BY+RYzMnmG1ze9gzu7e1mGggpeK0bANzhBQD2pjoEevMDx+wOAnL5vBNUeu9tVbbu72reNQmKA+3d1LhBZAGutc4wXlrET5+gj43pFTJTQ3gbKP/p79ClbTBGfElCdp9l3R5NYq/zwNSrrYteNYRCtzX1AZSdX/zMsl1EbZ/YkT+1DtMdysuw5R/pOjZ0StAnznTjDvjpSlPXrW2tTanN6r4HTTGgvK8EOd16purGMK6WPWx2GHtjQ9nTg8qUN3gRG96gFiO0T5mR4m5NniNT8C236TpxnoouC9IkkxNurcg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di9DFGM4oWOrrD/bbPnJONBcsiU6ytbLXNaxOqdk5sY=;
 b=vmydJFExOMKpCsHDdZMXyrGRsysSTtrkFG34HpT7+W4RviychBe+HSUiWn9v1rAQBxrquyF+dkr3wM6uzd7L5BpuTucOhlfobROoweDUejONflvJIDG5vLqjcYFw0Qr3XUViAW8uGKfd+oKu9WIrkoGarjUbQsHRSQ+JfBsmPW4=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 15:00:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 15:00:46 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     AceLan Kao <acelan.kao@canonical.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Tsao, Anson" <anson.tsao@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "Oakes, Gregory" <Gregory.Oakes@amd.com>
Subject: RE: [PATCH] usb: xhci: Workaround for runpm issue on AMD xHC
Thread-Topic: [PATCH] usb: xhci: Workaround for runpm issue on AMD xHC
Thread-Index: AQHZRNl8K5G70EumBU6YOoRYxDIZf67XZpKAgACHWKA=
Date:   Mon, 20 Feb 2023 15:00:45 +0000
Message-ID: <MN0PR12MB6101526DCB8A51FB62FDC490E2A49@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230215075855.46204-1-acelan.kao@canonical.com>
 <141b6b13-00ca-c941-e315-6b2fe62e6515@amd.com>
 <CAFv23Qk2yG+KPGd1s1JsY8rBfU_z-tFe6KSo6r=q7DsQ6ETL_w@mail.gmail.com>
In-Reply-To: <CAFv23Qk2yG+KPGd1s1JsY8rBfU_z-tFe6KSo6r=q7DsQ6ETL_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-20T15:00:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2f564e8a-85f6-430b-8188-4bffbf042b19;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-20T15:00:56Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: cd9736b6-bbaf-471f-a3eb-f76788f05f82
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SN7PR12MB7909:EE_
x-ms-office365-filtering-correlation-id: e4929d68-e9d6-402a-55e8-08db13533ecd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4qAEKUfkoggVWSoKavCvtgiX1YplRt0bDBkMr7tz87MSsgGDDWHFzH/5uOzefZeMyNIty6b1UMByM4eXBMWRTBRzfrP6h+gHICqLiLDVdV3BPPhzorK5NaLrcY2SkPfGFoqMd8axEer9tieuLOpvxn4ZK/c/djW5V8eXfnCVRUNezY3FaITysqY7IZ6zwyVrzH8xy8jfmRV7KdeOFHUFZiCQNb1tO0YbiH4TVKJd5C1nmd0zpH+LWmLbxHpSo5P8Hqx1+zbrcbnORXfwlxErBZaRz41PRLVJ4CapulZ80kofxUSc3oEGPdEa7/PEkl7ZmTuIZ/4aq/LawwpQ+WTK2gFmPruOYFQTHtc6dDQYvIaV5wIi1Fs4HjF8/PZGzcVT1jLPA0NO/XKJPyo15zbW3Opl4EYYtgBkJlsBhOB2w2MH6PMn4fe1UMdTq7zMApDKXnTmjlaSc2mvMzc7GebcoqM1uK0IOCfZEXl3VCXn6fDf/RAwPXFHCmOQcOpTPPxkF4pT57qZ0SS51QOvkxbCtadFWKmbmlBRd+6379fMspAv1K8DoJJu2DFO3V7ELxUrU10/fSI2h/Ldi6E7SwXjOKnKFZYfb8LzWsHoTSgQ9yUuNNk1zhANeq0jBuaxIOJIuz8H+QsGIjgO5YdBzbIojCgOjC5uPJdBELE6/2GjsFnJ2V9wG/UGFBftSRmKgCfGHjIVMvq1x+tcNWx7sYVBww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199018)(55016003)(86362001)(33656002)(38070700005)(316002)(6916009)(4326008)(66446008)(64756008)(66556008)(66476007)(76116006)(8676002)(66946007)(8936002)(52536014)(41300700001)(5660300002)(7696005)(54906003)(2906002)(83380400001)(122000001)(38100700002)(6506007)(26005)(9686003)(53546011)(186003)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTJXY3N0L3JqQ2g4UkpaeW5EUXAvMzhBcXUzdlp4ZFZwNnhpc3hCdFB2NEpx?=
 =?utf-8?B?VmxiTFhvMVBOWHFEVUFZVno0eEZSWnNNajVsQ1ZVT2h1WDlmWmpXT0wvV0FS?=
 =?utf-8?B?MGlHYjNqd0duRUs4YUdWQ3prdDhQVk84YWVJY2RkSFlTdURhbVRZQVFsSFkz?=
 =?utf-8?B?OUZZeTNSbVhTZ2ZVVnh4c2g0U24yTnJhVm00M0tsZzRVNDZYTWREMzUrQVJm?=
 =?utf-8?B?eUY1M2ZVdmtnNk5LYnNKTklYUlBzRVdobDh1Q0o5UjY5aVBwU0IzVUt2bmFC?=
 =?utf-8?B?VzlCNnBvMkhxZWNQWDRBakZBUzlOK2dKRDl0SlVudXZFVGNBRnk2REJWSTc3?=
 =?utf-8?B?dVZJQisxQVkyWmJFMGh5Tkw4ZnFxMUxidE1kakxoQk05QXRXQ21aY0JYNTVx?=
 =?utf-8?B?M0NLRjdVb3IvalBRSHV5V0FtNDJsc2pxTWU3RDdSWWFOOXF1L3ZycDJwTDB3?=
 =?utf-8?B?aVVNdzhGQ08zV0pxVGNjL2lSQUVXUFlMVkRLOHhFRy9icko3Q2JheFgxS3p5?=
 =?utf-8?B?QWYwdDg2dUl0eEhLZU1lV3ZBeHpPY1haaGQ5c3BzSlg4WXJjc0dHdlZienFG?=
 =?utf-8?B?ZXlIVHJCbUU4NW9iQUZpN1hPR1Z2dUlnQmkwa3I4dnhqWWZRbE1iZ0dueGdy?=
 =?utf-8?B?bmFLbjNXaVJyMmQrd21VdHlPT0lLSmd6M1dvM1haWkg4czdRZ0ZRa2U1NU5S?=
 =?utf-8?B?NXpMSHRzazVBZTN4SC81TzNuL3BobTB4TXdCSTM4d1FLVEQ5ZzVNcHBrY25D?=
 =?utf-8?B?bFVsTjBkRzY4SGpqR2g5a282eFJjZ1gxZ0NKZk5ucnpsUGFSZW9NclpJSm84?=
 =?utf-8?B?U0xvNWptOGRYcFBCdkpTQWpqdE1ieFVEeFQ1R3Q0WUZaUXRZcHA1WDRmYTdm?=
 =?utf-8?B?dm80R2JpUjRObGdrR2MrWkxPeFRoT0Y2NVBpSXpDUkRVOGYxbjdRVnFCRmFn?=
 =?utf-8?B?NHVzSzNXT0cycVVJYzhYNkpJbGkzKzFxZ0NiTW5rUEhTN21OamMzcnZMdFpB?=
 =?utf-8?B?MVZQS1ZJVExBYXFYMzZva3RESC93eUVqUHIvdnVCakw4NUlWZTJRYmNuNkhG?=
 =?utf-8?B?RmtZdnQ4NjJYMUl1N0FuT1g3dGNsblJ4VEFuTUdwREZmalFIcllua0xzc0Zl?=
 =?utf-8?B?QlVNdWVtUFZieU1nZ2JRazFvQWNyQU1HZG5pem11WDdVWlZZdmdiZ3dCZUVT?=
 =?utf-8?B?N09kSDVicndLdExZM2VJcTZJL2ZhRURIQ3Y1aVhZbFNwNkpFeEJnSUx0N3pz?=
 =?utf-8?B?VE1OcWpTMzV6cy90UWswZ3BKaldhU21KY3dkSE9iMnkwSU9DbTdDUGF3bVBn?=
 =?utf-8?B?YzdxMkZpaFBYbCs1TVA5dXJQZmVYZkF0bnFuR2R2N2hFQVJjbEh0QWpDdWxN?=
 =?utf-8?B?OVdvREwrUjZFcXBxUGlaUzJOV2FUdE83YUkxMUYyWE9XYTRRSGFiT3BkSEdE?=
 =?utf-8?B?SHhtczRFL2V2N2dGcGl4eVQ5VTdnZHlIMlFqenRocmFjTnZnOWFlb3hkalFn?=
 =?utf-8?B?Zmd5SE9BcWY1SWVocVljVm1WK0FPRjNkNjBsQ0JrYW1Ib0YrcUllNGdXMnhv?=
 =?utf-8?B?cXRPbWJsNXZldHF2TWJSWm93d1FPRzdqN3Y1NXM2RDF5QUcvWE5LTnFTd1JL?=
 =?utf-8?B?SXdNZVR2NWtERTNRSFhneWpmalc5V0UwOUU4NlZRQk5LcmZ2dXBXWllEZ3hy?=
 =?utf-8?B?NExXNVBzRnpDRUpabU15alFQUU9LellleFMwYzR0QTF1MEZEdy9DSHloRVZ3?=
 =?utf-8?B?YkZRRTA4dkpLUHdHcDAwWE9UbktjNGxCYVFlNFUydGlKRk9KbDZFMlg3T3Z4?=
 =?utf-8?B?V1FDMjFITGw4dWk2UjlXZkEzVXdxQUxhZzZzamVRSjB6SGphZmw1NHJ5Y0tN?=
 =?utf-8?B?T1pzRTA3dzZyY0hiQXhiNUFQNk9OUXdOOTEvOW5xU2V4VG5FekJMcEEwNURi?=
 =?utf-8?B?T2FMQlBkaGk4STJaY3hjY0t0S0ZTM3owZXFsUDlDSGh0MFp0KytFN05rY254?=
 =?utf-8?B?bHpmVzUwanVNd215YVdXVm1NMzZYSW1kNnRkNElLVFJDdkd4bUozSExqYVRx?=
 =?utf-8?B?ekpmQlZHSTBWblo5N2R3a2J4RjJkTjFSTFhnT05QZStMczhrS0dwUEp5R3Qr?=
 =?utf-8?Q?UqyE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4929d68-e9d6-402a-55e8-08db13533ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 15:00:45.9289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iq2GDe/XfkPzIzX+jsDczx61fDjJdK35Q+cTzyyVQz5YXIZUZeLxYScVVJorPVrCO/edRQ9qpDqPZfOSDPFh2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
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
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFjZUxhbiBLYW8gPGFjZWxhbi5rYW9AY2Fub25pY2FsLmNv
bT4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAyMCwgMjAyMyAwMDo1NA0KPiBUbzogTGltb25j
aWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBDYzogTWF0aGlhcyBO
eW1hbiA8bWF0aGlhcy5ueW1hbkBpbnRlbC5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFMtaywgU2h5YW0tc3VuZGFyIDxTaHlhbS1z
dW5kYXIuUy0NCj4ga0BhbWQuY29tPjsgVHNhbywgQW5zb24gPGFuc29uLnRzYW9AYW1kLmNvbT47
IEdvbmcsIFJpY2hhcmQNCj4gPFJpY2hhcmQuR29uZ0BhbWQuY29tPjsgTmF0aWthciwgQmFzYXZh
cmFqDQo+IDxCYXNhdmFyYWouTmF0aWthckBhbWQuY29tPjsgT2FrZXMsIEdyZWdvcnkNCj4gPEdy
ZWdvcnkuT2FrZXNAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiB4aGNpOiBX
b3JrYXJvdW5kIGZvciBydW5wbSBpc3N1ZSBvbiBBTUQgeEhDDQo+IA0KPiBIaSBNYXJpbywNCj4g
DQo+IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiDmlrwgMjAy
M+W5tDLmnIgyMOaXpSDpgLHkuIANCj4g5LiK5Y2IMTE6MTTlr6vpgZPvvJoNCj4gPg0KPiA+ICsg
YSBidW5jaCBvZiBBTUQgZ3V5cw0KPiA+DQo+ID4gUGxlYXNlIGRvbid0IHN1Ym1pdCBxdWlya3Mg
Zm9yIEFNRCBzeXN0ZW1zIHdpdGhvdXQgdGFsa2luZyB0byBBTUQgYWJvdXQNCj4gPiBpZiB0aGV5
IG1ha2Ugc2Vuc2UuDQo+IEdvdCBpdC4NCj4gDQo+ID4NCj4gPiBPbiAyLzE1LzIzIDAxOjU4LCBB
Y2VMYW4gS2FvIHdyb3RlOg0KPiA+ID4gRnJvbTogIkNoaWEtTGluIEthbyAoQWNlTGFuKSIgPGFj
ZWxhbi5rYW9AY2Fub25pY2FsLmNvbT4NCj4gPiA+DQo+ID4gPiBXaGVuIHRoZSB4SEMgaG9zdCBp
cyBydW50aW1lIHN1c3BlbmRlZCwgdGhlIGRldmljZSBjb25uZWN0cyB0byBpdCB3aWxsDQo+IGJl
DQo+ID4gPiBkaXNjb25uZWN0ZWQgd2hpbGUgdHJ5aW5nIHRvIHVzZSBpdC4NCj4gPiA+IFRoZSBx
dWlyayBpbiBjb21taXQgMmE2MzI4MTU2ODNkICgidXNiOiB4aGNpOiBXb3JrYXJvdW5kIGZvciBT
MyBpc3N1ZQ0KPiBvbg0KPiA+ID4gQU1EIFNOUFMgMy4wIHhIQyIpIGFsc28gd29ya3MgZm9yIHRo
aXMgaXNzdWUsIHNvIGFkZGVkIGl0cyBJRCB0byB0aGUNCj4gPiA+IHF1aXJrLCB0b28uDQo+ID4g
Pg0KPiA+ID4gMDU6MDAuMCBVU0IgY29udHJvbGxlciBbMGMwM106IEFkdmFuY2VkIE1pY3JvIERl
dmljZXMsIEluYy4gW0FNRF0gRGV2aWNlDQo+IFsxMDIyOjE1MDVdIChwcm9nLWlmIDMwIFtYSENJ
XSkNCj4gPiA+ICAgICAgICAgIFN1YnN5c3RlbTogRGVsbCBEZXZpY2UgWzEwMjg6MGMzZl0NCj4g
PiA+ICAgICAgICAgIENvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVt
V0lOVi0NCj4gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lO
VHgrDQo+ID4gPiAgICAgICAgICBTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFy
RXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LQ0KPiA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBF
UlItIElOVHgtDQo+ID4gPiAgICAgICAgICBMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDY0
IGJ5dGVzDQo+ID4gPiAgICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgNjAN
Cj4gPiA+ICAgICAgICAgIElPTU1VIGdyb3VwOiAyMQ0KPiA+ID4gICAgICAgICAgUmVnaW9uIDA6
IE1lbW9yeSBhdCBjMDAwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xTV0N
Cj4gPiA+ICAgICAgICAgIENhcGFiaWxpdGllczogPGFjY2VzcyBkZW5pZWQ+DQo+ID4gPiAgICAg
ICAgICBLZXJuZWwgZHJpdmVyIGluIHVzZTogeGhjaV9oY2QNCj4gPiA+ICAgICAgICAgIEtlcm5l
bCBtb2R1bGVzOiB4aGNpX3BjaQ0KPiA+ID4NCj4gPiA+IFsgICAyMC43NjkyNzVdIHhoY2lfaGNk
IDAwMDA6MDU6MDAuMDogeEhDSSBob3N0IG5vdCByZXNwb25kaW5nIHRvIHN0b3ANCj4gZW5kcG9p
bnQgY29tbWFuZA0KPiA+ID4gWyAgIDIwLjc3MTQyOV0geGhjaV9oY2QgMDAwMDowNTowMC4wOiB4
SENJIGhvc3QgY29udHJvbGxlciBub3QgcmVzcG9uZGluZywNCj4gYXNzdW1lIGRlYWQNCj4gPiA+
IFsgICAyMC43NzE0NDRdIHhoY2lfaGNkIDAwMDA6MDU6MDAuMDogSEMgZGllZDsgY2xlYW5pbmcg
dXANCj4gPiA+IFsgICAyMC43NzE3MzNdIHVzYiA1LTE6IFVTQiBkaXNjb25uZWN0LCBkZXZpY2Ug
bnVtYmVyIDINCj4gPiA+DQo+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjdjQuMTkr
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaGlhLUxpbiBLYW8gKEFjZUxhbikgPGFjZWxhbi5rYW9A
Y2Fub25pY2FsLmNvbT4NCj4gPg0KPiA+IElzIHRoaXMgc3lzdGVtIHRoYXQgeW91J3JlIGZpbmRp
bmcgdGhpcyBidWcgYWxyZWFkeSBsYXVuY2hlZD8gIFRoaXMNCj4gPiBsb29rcyBsaWtlIGEgQklP
UyBidWcuDQo+ID4NCj4gPiBJZiBpdCdzIG5vdCBsYXVuY2hlZCB3ZSBzaG91bGQgZml4IGl0IGZy
b20gQklPUywgcmVhY2ggb3V0IHRvIEFNRCBvZmYNCj4gPiBsaXN0IHRvIHRhbGsgYWJvdXQgaXQu
DQo+IFRoaXMgc3lzdGVtIGlzIG5vdCBsYXVuY2hlZCB5ZXQsIGFueSBoaW50cyBhYm91dCB0aGUg
QklPUyBpc3N1ZT8NCj4gSSB0cmllZCB0byBkaXNhYmxlIEQzQ29sZCwgYnV0IHRoZSBzeW1wdG9t
IGlzIHRoZSBzYW1lLg0KPiBUaGUgeEhDIGVudGVycyBEM0hvdCBhbmQgdGhlbiBpdCBjYW4ndCBi
ZSB3YWtlbiB1cC4NCg0KT0sgdGhhbmtzIGZvciBjb25maXJtaW5nLg0KSXQncyBub3Qgc29tZXRo
aW5nIHRoYXQgaGFzIGEgY29uZmlndXJhdGlvbiBrbm9iIGluIEJJT1MuDQpSYWlzZSBhIHRpY2tl
dCB3aXRoIEFNRCBhbmQgaXQgY2FuIGJlIGRpc2N1c3NlZCB0aGVyZS4NCg0KPiANCj4gPg0KPiA+
ID4gLS0tDQo+ID4gPiAgIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1wY2kuYyB8IDQgKysrLQ0KPiA+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wY2kuYyBiL2RyaXZl
cnMvdXNiL2hvc3QveGhjaS1wY2kuYw0KPiA+ID4gaW5kZXggZmI5ODhlNGVhOTI0Li5iOGY2ODQz
YThjZDEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMNCj4g
PiA+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wY2kuYw0KPiA+ID4gQEAgLTE3Nyw3ICsx
NzcsOSBAQCBzdGF0aWMgdm9pZCB4aGNpX3BjaV9xdWlya3Moc3RydWN0IGRldmljZSAqZGV2LA0K
PiBzdHJ1Y3QgeGhjaV9oY2QgKnhoY2kpDQo+ID4gPiAgICAgICAgICAgKHBkZXYtPmRldmljZSA9
PSAweDE1ZTAgfHwgcGRldi0+ZGV2aWNlID09IDB4MTVlMSkpDQo+ID4gPiAgICAgICAgICAgICAg
IHhoY2ktPnF1aXJrcyB8PSBYSENJX1NOUFNfQlJPS0VOX1NVU1BFTkQ7DQo+ID4gPg0KPiA+ID4g
LSAgICAgaWYgKHBkZXYtPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0FNRCAmJiBwZGV2LT5kZXZp
Y2UgPT0NCj4gMHgxNWU1KSB7DQo+ID4gPiArICAgICBpZiAocGRldi0+dmVuZG9yID09IFBDSV9W
RU5ET1JfSURfQU1EICYmDQo+ID4gPiArICAgICAgICAgICAgIChwZGV2LT5kZXZpY2UgPT0gMHgx
NWU1IHx8DQo+ID4gPiArICAgICAgICAgICAgICBwZGV2LT5kZXZpY2UgPT0gMHgxNTA1KSkgew0K
PiA+ID4gICAgICAgICAgICAgICB4aGNpLT5xdWlya3MgfD0gWEhDSV9ESVNBQkxFX1NQQVJTRTsN
Cj4gPiA+ICAgICAgICAgICAgICAgeGhjaS0+cXVpcmtzIHw9IFhIQ0lfUkVTRVRfT05fUkVTVU1F
Ow0KPiA+ID4gICAgICAgfQ0KPiA+DQo=
