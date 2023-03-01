Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4BA6A6F9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCAPb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCAPb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:31:26 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ADC42BD3;
        Wed,  1 Mar 2023 07:31:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IortEY3UGlD6IWnv1VVwDFtrCaGGfIr7MhGKehh1SwNK34ReRYMwY2Svn+ZScTOqB2JfoBn0ndKM0LpLnXLSNCcmoMtqfCzwQGUutn9F+u+NHF1wEBEweXTrw4snFrXgCa6+da6Emsrqc8b5kiHGhXyRCSUPPChu9UVIYINNU7llyvYYBU1lqZ2ZvywgNmL+LW8+NHy/Li6LWzxNZzY1KwsLIuVZ2cmyHsybSIeQOX+vTc7J5JRFQJLsYQNubKVTmhItKI3FCyAl1QMFyeC2/jdidfyskSFRHPNMKR4B2F0VGZzgNm09jQ4b7Mbst8dawSJxFFrrz+WR9g3YVT8qBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCgITldxH85lTmFRR0DXpctZfqmv0jvh34t5wy2kd/Q=;
 b=OLrCxIaUsDiRBIqfziXzw0Jl6pXW+ItE1eSlbF/DiYw7Llk2//7bLH2nGuuCiM0ej+u3tVBpoBzrtGp7fK8MWSwbYUcJqZXq3Fl8GLn3bSg0ghKiFvJqXUVw12wT3tEXOAY9bXrJeJIO56tpJhzM2g5mlZjkotaF4PwO7/Z4PFJZ2jmb/fRoQAkNAq9cWsOHNx1tR9vIVoGvs/ZD7X3TwDgK8l2CliAn5uuX+xahyBHnBW4SkWDx2Dw8E8z82usyvOxP6LRFQo958qlCHFGClvMvro/86QESlx+2FV/bFDHrW+T3+7r6hZanSgwAL3Dv4jThB8b+jkTpI4lVvme8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCgITldxH85lTmFRR0DXpctZfqmv0jvh34t5wy2kd/Q=;
 b=zfi1JKxpsuxH+n3MdcwNxlLc/Na7ko/aTa1OFM0dksDuBDr4tGtqL349u1uUPiby+OI0zGLtWbW81kzjiqkxXFF0uplxYdS7gWrZCqKqt0laUwSoyeOl4C6n+jamLIEE4nIrrlTYf03D0a88BZw1pzOZtcwrPTbOAQlu0fWFdb8=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 15:31:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%7]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 15:31:21 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
CC:     Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking
 minimum SMU version
Thread-Topic: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking
 minimum SMU version
Thread-Index: AQHZTE+38ckCb6quDUqXBktiSELovq7mDEYAgAAAKIA=
Date:   Wed, 1 Mar 2023 15:31:21 +0000
Message-ID: <MN0PR12MB6101781FC5089EA217CA48A9E2AD9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230301150821.9791-1-mario.limonciello@amd.com>
 <846d6f46-07ab-4d4a-5623-417a469c3d0b@redhat.com>
In-Reply-To: <846d6f46-07ab-4d4a-5623-417a469c3d0b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Shyam-sundar.S-k@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-01T15:31:19Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=270e0803-737a-464e-97bb-e52ec36807ec;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-01T15:31:19Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 05fdc8ce-48a4-406c-93c6-6f0b09cc418f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MN2PR12MB4048:EE_
x-ms-office365-filtering-correlation-id: 8cb41336-3893-41f8-b845-08db1a6a0250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1wc1wqqFrBpKqkvMqBessCQhzR8aRNgjcEeAB8hCB99uhsNx0+6jIJ6pd3yrzw3/5/pd2JudV3rNNhc/gF7EvplfrZhFFRCSBrnZ9MRWTkvxgOOKLRqcFiuRZO7KzJ/W1JESjqgA2SHMaq/xTpbAWwwCyyyjRyguV3RcSEMRONLsiLWEuGgmLmcZaJYcSwkivBov/7LuQgdo5CupP+VUVsfSUp/jGP/2GfUZgmOCzcbLF87+z7+QksL//gS31Ml+8gB1H7Q7W3OL99RF0p8NXn2VQVECFHEfIrdmHYTuBwLzp1pwlvTVNxQcjwvXjDoQOh47h+cS5GGTJwQu61gXyCryCjgoccWb9mgnvoLeEGondd1tz4HK8yJnfAt3FBH2jPZ2xnLlWZjydEo+ehTZ7Y0agCIGcMhlwUhjLrhKlYj/8iiElTCVZczSnMOonPduaOi28HLyS5XIBNpZD8ZvyMvpD3H5IcNEDz7TyPws/S7ZwtQBYkQavAi7PzpDPnfxrd0Vzb1YkGSAlLJKRUGg0PEg0I7ww2pMMOMNp9TrIbIkyxvjvj4BusX5UpFYQHCt97N5/ye5Roa1YEpvJBQBiIazDb4rZM8z97OZRjzFxSgidJCV6cNxRWpweOpxLnB7624tAuZhxlgPa/yeZCjz89fMxGG3WUxuN6LqRHWR6bD5ZYJF9ez76hFzKGiB3ttrzLx9AQ/dMoeyP0kb9j0Tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199018)(5660300002)(33656002)(8936002)(86362001)(52536014)(55016003)(83380400001)(478600001)(7696005)(186003)(71200400001)(9686003)(53546011)(6506007)(26005)(66476007)(66556008)(66946007)(66446008)(76116006)(4326008)(38100700002)(54906003)(64756008)(41300700001)(38070700005)(8676002)(110136005)(6636002)(122000001)(316002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STkzdHloWHllNlh6SUtmR1BNNnZUYWF1Z1B1U2tOT0RyMmQrMHp4a0RSZk9G?=
 =?utf-8?B?cVdMODJsaWIxT3J5b2V3OEFWb1I1Q1lTUzgwajRpYlQ0cFRacldWUTB1VVpq?=
 =?utf-8?B?TVpxK3F0RGlBSW9GUUdCMThsWFVaQ2RwVXdVRFNDYVJYT2cxaEsrQjlITHdW?=
 =?utf-8?B?OHlDZmlNQWV3RktqNHhxazZwM0dyN1Y0ZFVFejQvZHJ1TTV4Q0RQbmp6bWxZ?=
 =?utf-8?B?Y3U0OFArdTBudHVqNEtheG9vbTNmLzRWdll4VFk2d0J1dnJwZHk4UUNEMlBv?=
 =?utf-8?B?ZHdHblo2QVc0R1hEUXlPUGsxTjRYcnJydTErM3QvM2tVakNtRVVOU09RNmxy?=
 =?utf-8?B?SnhvQXlwMjBRcnpJQWwveS9sbmR6R3BMenhrWk9pZmJJOGdqd1hoOW1PNlUr?=
 =?utf-8?B?d283aE1WSkZGMmhBRFFJSnB6eTkzZjBuQVd2THRDVFNFaDFMdnMzczc4dkRm?=
 =?utf-8?B?QjlEd2F4N2EvN2lXT3RlOTgxMUkrcitRUHBiSGYzMThJOWFOQ0FzZnNRQ3B3?=
 =?utf-8?B?NGI5SmErY1RVVWFFMzladkFRRlNtQ0VVV1NWcHR2dkhIcmFuWjBvVWxRUDhG?=
 =?utf-8?B?MVlFSGdDcHZ4Tyt1eEhwamxGWVZRanlZbWFBRnIzTjZWR1ZMeWd4elEzN0VM?=
 =?utf-8?B?K1hlL0FiWG10Z2JNbW9IRGFicER5cFVSUndUUXNLcFBZcXZlcFVqTlVDa2Ny?=
 =?utf-8?B?Mm9UeThZeXF2Smo1MWpFNEI1T0xoRUFrVms2TDlpdU14bDhKdXdFVkdrb1RE?=
 =?utf-8?B?TTNWS2FQRHl1V1oxVUlhcXNkZ0QvY01ObEl6UmlPNk50c2tuOWhzUUhwMmJr?=
 =?utf-8?B?N3VGVTNReEY5NmVJa3ZNb1pnZ1lUU2Q1VUFRemFkditvOVlTOUZYSVc3M2gv?=
 =?utf-8?B?Ymo0N2ZxMXhQVE4zZzZjYmVQQXBKa012Um5hY0I5bzFQUFhJWkpzMzhZRVBh?=
 =?utf-8?B?Mi9yQ00wcU9uOVZPZS9YeklpVnNRdTJZYVladmwzOWxPdFgvMUpLQytWTzhL?=
 =?utf-8?B?SjRDUXVOY0RrVktNTDNsSENlNWg1NlhFVnZzRHU1RVUzbFZYV0VWd3Y5RGZY?=
 =?utf-8?B?SDVtT09GMjd2OEN6RU42bTNuRUs1S1ByWHJDTThqY01OZlNpeXJRbytpSTFC?=
 =?utf-8?B?bXBWa3h5SXBETEZjRk5GeWFWM1pYYzFmTGROSjJJU2doV1p4dXpzQ1JWelU5?=
 =?utf-8?B?R3hOTzhqREZGTllQcjRnS1FPVW1uU3IzL3VnRG5CL1NrWFhReU83REhmSE5w?=
 =?utf-8?B?VXF3UXdybS9uNW5TODU1d0dQRC9sdUNQTXVEaStTZ0JIMnY2V0UzcVpQQ0Vw?=
 =?utf-8?B?bTJ0eWl3K1Zjd3k3OHdqNS9uVXRQajloL25udWVybXVtMWowVTNhTWJJcjEw?=
 =?utf-8?B?a1NsNnRiZE4xODVmZ0FVUUJ0dkt0VURSM3h2RTJtTmtBWFRUWkFBWDBGREpM?=
 =?utf-8?B?dHB3MHNoVGJlcnhrSzc1bWdoakVHeXV4aGY4L2RFUzI0L0pQOVBkbWZFZ2RN?=
 =?utf-8?B?Y29JdTRVR2NrRXRRVTJodG9VWlZ6REl4UGZFVVlUc0VscUlVbG0vTGg5YVA3?=
 =?utf-8?B?ZmNhaS8xODFWbnFZWlcvdkUxMEQydkNIYVh3b2h1bVV4bktjV200Y2ZxQmhO?=
 =?utf-8?B?ekRSVDE1cTFWRGE5ZE9jNTBqTUl2LzVQeWx5STFSdjNQb3UzOWUxWCthSVZM?=
 =?utf-8?B?ZXVENjJTeVMvbUtmdGV6MHZKcFdIaWI2M3ZBUThQbjhITzdQajg5RDZEdUww?=
 =?utf-8?B?bkJ4czIrazNXajNPdXROcW8rT3FGZXZRREQrQ3Flb1dPRDFBOUlJbG5mRlZB?=
 =?utf-8?B?L3huam1ucTdHdks2Zzg1d0JnbWdPVGlGU1ZSS2JBOU5BYnZNUUJ0VHpCWklr?=
 =?utf-8?B?QmF0ZE9SSTVQOU5hQUphOVljOVcyMzJub01RY0JzMU5tdnZjWkszTnFBWDFi?=
 =?utf-8?B?SmdsNzNxRnI4UzJDUWYxOVVPOU1OT2NGMHlrek5MbnNpV0QvNzBZRlhaMCtk?=
 =?utf-8?B?VEF4U2N2TE1rYXRXMmx6NHFBVk9jR2M0aWI5Qmx1V3hSWlF3WnhHQitpZEdC?=
 =?utf-8?B?QUY0aXpNR2c4bzBuV1dZVjF0YS92RXJFbFozM2ptZUJUditLd1hjMCs2bWFr?=
 =?utf-8?Q?iR44=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb41336-3893-41f8-b845-08db1a6a0250
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 15:31:21.0600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23guxBT8Y7VBOBaNuZprv1b+Ls0VRfGAP/hW5SX06MpwSlqP7XObJeFzCe9mNAA1cjCiCaBeHQNVrPBtHV2n5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFu
cyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAxLCAyMDIzIDA5OjI4DQo+IFRvOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2ll
bGxvQGFtZC5jb20+OyBTLWssIFNoeWFtLXN1bmRhcg0KPiA8U2h5YW0tc3VuZGFyLlMta0BhbWQu
Y29tPg0KPiBDYzogTWFyayBHcm9zcyA8bWFya2dyb3NzQGtlcm5lbC5vcmc+OyBwbGF0Zm9ybS1k
cml2ZXItDQo+IHg4NkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHBsYXRmb3JtL3g4Ni9hbWQ6IHBtYzogQWRk
IGEgaGVscGVyIGZvciBjaGVja2luZw0KPiBtaW5pbXVtIFNNVSB2ZXJzaW9uDQo+IA0KPiBIaSwN
Cj4gDQo+IE9uIDMvMS8yMyAxNjowOCwgTWFyaW8gTGltb25jaWVsbG8gd3JvdGU6DQo+ID4gSW4g
YSBmZXcgbG9jYXRpb25zIHRoZXJlIGlzIHNvbWUgYm9pbGVycGxhdGUgY29kZSBmb3IgY2hlY2tp
bmcNCj4gPiBtaW5pbXVtIFNNVSB2ZXJzaW9uLiAgU3dpdGNoIHRoaXMgdG8gYSBoZWxwZXIgZm9y
IHRoaXMgY2hlY2suDQo+ID4NCj4gPiBObyBpbnRlbmRlZCBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVs
bG9AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvYW1kL3BtYy5j
IHwgNDkgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvYW1kL3BtYy5jDQo+IGIvZHJpdmVycy9wbGF0Zm9y
bS94ODYvYW1kL3BtYy5jDQo+ID4gaW5kZXggMmVkYWFlMDRhNjkxLi5jNDJmYTQ3MzgxYzMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvYW1kL3BtYy5jDQo+ID4gKysrIGIv
ZHJpdmVycy9wbGF0Zm9ybS94ODYvYW1kL3BtYy5jDQo+ID4gQEAgLTQxOCw2ICs0MTgsMjIgQEAg
c3RhdGljIGludCBhbWRfcG1jX2dldF9zbXVfdmVyc2lvbihzdHJ1Y3QNCj4gYW1kX3BtY19kZXYg
KmRldikNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGJvb2wgYW1k
X3BtY192ZXJpZnlfbWluX3ZlcnNpb24oc3RydWN0IGFtZF9wbWNfZGV2ICpwZGV2LA0KPiBpbnQg
bWFqb3IsIGludCBtaW5vcikNCj4gPiArew0KPiA+ICsJaWYgKCFwZGV2LT5tYWpvcikgew0KPiA+
ICsJCWludCByYyA9IGFtZF9wbWNfZ2V0X3NtdV92ZXJzaW9uKHBkZXYpOw0KPiA+ICsNCj4gPiAr
CQlpZiAocmMpIHsNCj4gPiArCQkJZGV2X3dhcm4ocGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlYWQg
U01VIHZlcnNpb246DQo+ICVkXG4iLCByYyk7DQo+ID4gKwkJCXJldHVybiBmYWxzZTsNCj4gPiAr
CQl9DQo+ID4gKwl9DQo+ID4gKwlpZiAocGRldi0+bWFqb3IgPiBtYWpvcikNCj4gPiArCQlyZXR1
cm4gdHJ1ZTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcGRldi0+bWFqb3IgPT0gbWFqb3IgJiYgcGRl
di0+bWlub3IgPj0gbWlub3I7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBzc2l6ZV90IHNt
dV9md192ZXJzaW9uX3Nob3coc3RydWN0IGRldmljZSAqZCwgc3RydWN0DQo+IGRldmljZV9hdHRy
aWJ1dGUgKmF0dHIsDQo+ID4gIAkJCQkgICBjaGFyICpidWYpDQo+ID4gIHsNCj4gPiBAQCAtNTI2
LDE0ICs1NDIsNyBAQCBzdGF0aWMgaW50IGFtZF9wbWNfaWRsZW1hc2tfc2hvdyhzdHJ1Y3Qgc2Vx
X2ZpbGUNCj4gKnMsIHZvaWQgKnVudXNlZCkNCj4gPiAgCXN0cnVjdCBhbWRfcG1jX2RldiAqZGV2
ID0gcy0+cHJpdmF0ZTsNCj4gPiAgCWludCByYzsNCj4gPg0KPiA+IC0JLyogd2UgaGF2ZW4ndCB5
ZXQgcmVhZCBTTVUgdmVyc2lvbiAqLw0KPiA+IC0JaWYgKCFkZXYtPm1ham9yKSB7DQo+ID4gLQkJ
cmMgPSBhbWRfcG1jX2dldF9zbXVfdmVyc2lvbihkZXYpOw0KPiA+IC0JCWlmIChyYykNCj4gPiAt
CQkJcmV0dXJuIHJjOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAtCWlmIChkZXYtPm1ham9yID4gNTYg
fHwgKGRldi0+bWFqb3IgPj0gNTUgJiYgZGV2LT5taW5vciA+PSAzNykpIHsNCj4gDQo+IFRoZSAy
IG1ham9yIGNoZWNrcyBoZXJlIG9yaWdpbmFsbHkgd2VyZSBub3QgaW4gc3luYywgc28gZm9yIG1h
am9yID09IDU1DQo+ICphbmQqIG1ham9yID09IDU2IGl0IHdvdWxkIG9ubHkgc3VjY2VlZCBpZiBt
aW5vciA+PSAzNy4NCj4gDQo+IFdoZXJlIGFzIGFmdGVyIHRoaXMgcGF0Y2ggZm9yIG1ham9yID09
IDU2IGl0IHdpbGwgbm93IGFsd2F5cyBzdWNjZWVkLg0KPiANCj4gVGhpcyBmZWVscyBsaWtlIGEg
YnVnIGluIHRoZSBvcmlnaW5hbCBjb2RlLCBidXQgbWlnaHQgaGF2ZSBiZWVuDQo+IGludGVudGlv
bmFsID8gUGxlYXNlIHZlcmlmeSB0aGlzLg0KDQpAUy1rLCBTaHlhbS1zdW5kYXIgYXMgdGhlIG9y
aWdpbmFsIGF1dGhvciBvZiB0aGF0LCBjYW4geW91IHBsZWFzZSBjb25maXJtPw0KDQo+IA0KPiBB
ZnRlciB2ZXJpZnlpbmcgcGxlYXNlIHBvc3QgYSB2MiB1cGRhdGluZyB0aGUgY29tbWl0IG1lc3Nh
Z2UgdG8NCj4gcG9pbnQgb3V0IHRoaXMgZnVuY3Rpb25hbCBjaGFuZ2UuDQo+IA0KDQpTdXJlLCB0
aGFua3MuDQoNCj4gPiArCWlmIChhbWRfcG1jX3ZlcmlmeV9taW5fdmVyc2lvbihkZXYsIDU1LCAz
NykpIHsNCj4gPiAgCQlyYyA9IGFtZF9wbWNfaWRsZW1hc2tfcmVhZChkZXYsIE5VTEwsIHMpOw0K
PiA+ICAJCWlmIChyYykNCj4gPiAgCQkJcmV0dXJuIHJjOw0KPiA+IEBAIC02ODYsMTUgKzY5NSw4
IEBAIHN0YXRpYyBpbnQgYW1kX3BtY19nZXRfb3NfaGludChzdHJ1Y3QNCj4gYW1kX3BtY19kZXYg
KmRldikNCj4gPiAgc3RhdGljIGludCBhbWRfcG1jX2N6bl93YV9pcnExKHN0cnVjdCBhbWRfcG1j
X2RldiAqcGRldikNCj4gPiAgew0KPiA+ICAJc3RydWN0IGRldmljZSAqZDsNCj4gPiAtCWludCBy
YzsNCj4gPg0KPiA+IC0JaWYgKCFwZGV2LT5tYWpvcikgew0KPiA+IC0JCXJjID0gYW1kX3BtY19n
ZXRfc211X3ZlcnNpb24ocGRldik7DQo+ID4gLQkJaWYgKHJjKQ0KPiA+IC0JCQlyZXR1cm4gcmM7
DQo+ID4gLQl9DQo+ID4gLQ0KPiA+IC0JaWYgKHBkZXYtPm1ham9yID4gNjQgfHwgKHBkZXYtPm1h
am9yID09IDY0ICYmIHBkZXYtPm1pbm9yID4gNjUpKQ0KPiA+ICsJaWYgKGFtZF9wbWNfdmVyaWZ5
X21pbl92ZXJzaW9uKHBkZXYsIDY0LCA2NikpDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4NCj4gPiAg
CWQgPSBidXNfZmluZF9kZXZpY2VfYnlfbmFtZSgmc2VyaW9fYnVzLCBOVUxMLCAic2VyaW8wIik7
DQo+ID4gQEAgLTcxOCwxNCArNzIwLDEwIEBAIHN0YXRpYyBpbnQgYW1kX3BtY192ZXJpZnlfY3pu
X3J0YyhzdHJ1Y3QNCj4gYW1kX3BtY19kZXYgKnBkZXYsIHUzMiAqYXJnKQ0KPiA+ICAJc3RydWN0
IHJ0Y190aW1lIHRtOw0KPiA+ICAJaW50IHJjOw0KPiA+DQo+ID4gLQkvKiB3ZSBoYXZlbid0IHll
dCByZWFkIFNNVSB2ZXJzaW9uICovDQo+ID4gLQlpZiAoIXBkZXYtPm1ham9yKSB7DQo+ID4gLQkJ
cmMgPSBhbWRfcG1jX2dldF9zbXVfdmVyc2lvbihwZGV2KTsNCj4gPiAtCQlpZiAocmMpDQo+ID4g
LQkJCXJldHVybiByYzsNCj4gPiAtCX0NCj4gPiArCWlmIChkaXNhYmxlX3dvcmthcm91bmRzKQ0K
PiA+ICsJCXJldHVybiAwOw0KPiA+DQo+ID4gLQlpZiAocGRldi0+bWFqb3IgPCA2NCB8fCAocGRl
di0+bWFqb3IgPT0gNjQgJiYgcGRldi0+bWlub3IgPCA1MykpDQo+ID4gKwlpZiAoIWFtZF9wbWNf
dmVyaWZ5X21pbl92ZXJzaW9uKHBkZXYsIDY0LCA1MykpDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4N
Cj4gPiAgCXJ0Y19kZXZpY2UgPSBydGNfY2xhc3Nfb3BlbigicnRjMCIpOw0KPiA+IEBAIC03NzIs
MTMgKzc3MCwxNCBAQCBzdGF0aWMgdm9pZCBhbWRfcG1jX3MyaWRsZV9wcmVwYXJlKHZvaWQpDQo+
ID4gIAkvKiBSZXNldCBhbmQgU3RhcnQgU01VIGxvZ2dpbmcgLSB0byBtb25pdG9yIHRoZSBzMGkz
IHN0YXRzICovDQo+ID4gIAlhbWRfcG1jX3NldHVwX3NtdV9sb2dnaW5nKHBkZXYpOw0KPiA+DQo+
ID4gLQkvKiBBY3RpdmF0ZSBDWk4gc3BlY2lmaWMgcGxhdGZvcm0gYnVnIHdvcmthcm91bmRzICov
DQo+ID4gLQlpZiAocGRldi0+Y3B1X2lkID09IEFNRF9DUFVfSURfQ1pOICYmICFkaXNhYmxlX3dv
cmthcm91bmRzKSB7DQo+ID4gKwlzd2l0Y2ggKHBkZXYtPmNwdV9pZCkgew0KPiA+ICsJY2FzZSBB
TURfQ1BVX0lEX0NaTjoNCj4gPiAgCQlyYyA9IGFtZF9wbWNfdmVyaWZ5X2N6bl9ydGMocGRldiwg
JmFyZyk7DQo+ID4gIAkJaWYgKHJjKSB7DQo+ID4gIAkJCWRldl9lcnIocGRldi0+ZGV2LCAiZmFp
bGVkIHRvIHNldCBSVEM6ICVkXG4iLCByYyk7DQo+ID4gIAkJCXJldHVybjsNCj4gPiAgCQl9DQo+
ID4gKwkJYnJlYWs7DQo+ID4gIAl9DQo+ID4NCj4gPiAgCW1zZyA9IGFtZF9wbWNfZ2V0X29zX2hp
bnQocGRldik7DQo+IA0KPiANCj4gUGF0Y2ggMi8yIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBT
aG91bGQgSSBxdWV1ZSB2MiAob25jZSBwb3N0ZWQpIHVwIGFzIGEgZml4IGZvciA2LjMtcmMjICA/
DQoNClllcyBwbGVhc2UuICBJZiBpdCBtYWtlcyBpdCBlYXNpZXIgSSBjYW4gcmUtb3JkZXIgdGhl
IHNlcmllcyBzbyB0aGF0DQp3ZSBhZGQgYSBjaGVjayBpbiAxLzIgYW5kIHN3aXRjaCB0byB0aGUg
aGVscGVyIGFzIDIvMi4NCg0KVGhpcyBtaWdodCBtYWtlIGl0IGVhc2llciB0byB0YWtlIHRoZSBM
VFMga2VybmVsIHRvbyBmb3Igc3RhYmxlLA0KYnV0IEkgZG9uJ3QgZmVlbCBzdHJvbmdseS4NCg0K
PiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCg==
