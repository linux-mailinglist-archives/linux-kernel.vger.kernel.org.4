Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B07696783
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjBNPBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjBNPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:00:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236EC25945;
        Tue, 14 Feb 2023 07:00:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IB0BuFEcvJcpnKsM0MWAwsGyjpOExbsMk4V83idHVUV7AAs78x154u5NprVMJ9+shiAjz3nDP4VTZF6XXmFMrupMWU/ckcqigsqsMyQjZpQaLwxi4M/pF31xKw7BUjGfC16lBKqFtq81GlYv4HzmCU5kngpCFQz7+bVTeIVPEVGLKcDME1LhHKLF44lLGbvKj0nw/egPT8jRbEvPlmONFfgUJYz1wdJKavMmsH0YUKYvJzMJcDZvi7DtRW6BMRpqAPS6ZvCf5pleHQqWvc7dIl1VaRe/GIA+AQj6nqrDFXXf7smdyc/NJKRPqSVNfCd9lPyXpB/ekElmVcrh0LCOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaOhuLbshxSTaphG+NovIwrTSKRg6Hkc1lB4GTevrT4=;
 b=arbzdgZonZQqtDFxJ2G2i8WOmc00qnwNVJKnU7xWSXe63R4lX5qmScSi1bylDc3apKqrDRfeqPCvmTU2pQptVjK8f2n7Om8LVnpBsUkU+B+YU6lluB9zoiEDKkm4q2782CFsgm+Dex8n5uLvDSd6jrrHMjMPOtAW4SvUMtxErmMs6P8qbElPLl2nplKwuz+fEUWAQsN63ZAuNrl2FYEpcOXnW+kBLXIMUqStiK+oksWerSJjzXofxO+KqsmZR2P4R1zK/mjOxSN1Q325MbsXMbMMlOcAp9SafIDPb8FBGwNw+zaayd48UJXMWTmuhoJCWkWPt/v5YjthdUds7GbaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaOhuLbshxSTaphG+NovIwrTSKRg6Hkc1lB4GTevrT4=;
 b=n8P4yrTIdYPJ52b8Sy4NPDWS8YKc8MWLU/NtLvtjNgfV1ujQJVfCohdMyhEcdJbouRuYXpyo27dfw6jgdUAcCsuz3CFUzA6C0XH7UYLgCMHkGqTT7DZePIFGhMnj4ElYeIH/yul4cJiOkThqGfd/IseBj2v6oVDKt1plip9BgeA=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 15:00:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 15:00:52 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dbilios@stdio.gr" <dbilios@stdio.gr>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 2/2] ACPI: x86: Add more systems to quirk list for forcing
 StorageD3Enable
Thread-Topic: [PATCH 2/2] ACPI: x86: Add more systems to quirk list for
 forcing StorageD3Enable
Thread-Index: AQHZP/Mm6AFdqfdHpUiBXMFpR3XHoq7OhvgAgAAAQpCAAAKPgIAAADtw
Date:   Tue, 14 Feb 2023 15:00:52 +0000
Message-ID: <MN0PR12MB61012E7DCCF3397D6DF5679AE2A29@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230213213537.6121-1-mario.limonciello@amd.com>
 <20230213213537.6121-2-mario.limonciello@amd.com>
 <CAJZ5v0j0GYyrF33=7ginfhYMrNyD=EDUK0RuHHYkKJ2VZAQnsQ@mail.gmail.com>
 <MN0PR12MB61018CBDE5DBBAB7C65F9F4AE2A29@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAJZ5v0hD2evYkZFmxv+pwF34UUr4VV1HGBvcjbtW_RMD6a6vpg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hD2evYkZFmxv+pwF34UUr4VV1HGBvcjbtW_RMD6a6vpg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-14T15:00:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=39585526-a871-44ae-9a8b-a2dce8ea3a72;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-14T15:00:51Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 650ff50a-c4ca-4670-9866-2f9194eaf436
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH7PR12MB6538:EE_
x-ms-office365-filtering-correlation-id: a7d0136e-1d86-4f91-5554-08db0e9c4474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2QxW0KOnMsmNVpjknYRBiJxPvjBRsgZ3W0WWtqZWMhInRxD/PzMtreIXX+Ba0sLAv/V3I4F07PWfso7VPBm+9EluyQoSR01Py72F8n8Fwt1VjSZ6XQe5NLBpSbPciPX9DoFMnAiEkhrLB7rFwN+iVg5DCs7HgtNk+R4jDAlfmBPsk+XYM93BOgAKrq3Trn+vro7APS7v4wFd1XZ5ML9RvGUs7z5i90ImfcSEPW+BHGsJFGZdWtMMk5ZQqHFJU3Azjn+OABz6AvXXEwiP1H8mWLX7V6keaQdAPzOfbF1E+PmP4D7MDhhfybteCL0l6O/c7hbiRo9cvxZNNvOtCGPDrbEwe1osibWArAAhE8tMYdA2tECI97GqGSHx9q5HactulM7Ew1gq1f5sXM7wC+UK7vw8yd7DK1InpwJBlwvLfZOgp7P2oruakmFdtNUwp1gl0cVuKJZ49Ekk4W/1xv3/zfMC6NAsOl0ZUJ66sOmCZ/szaTrOYt/s0muRPWVmluJxe7kLGF//TAWbJr58D/pa6+3ybQFv69TqmG4awlFoHp7JWdHLA5btu8Ur7NIVbIP7onp8BCS6c2+bVmEyZZ64VBEY8kQqK+TZa0WodrnvQvuX1krdDjo+v6kxwyTbzBQs8+dvcAYmSWlWKSC6EiOZ4D3drEgMRBLbaSfzBB2DL4BAk8jJa8fbbInVC3EE4HSk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199018)(66446008)(54906003)(316002)(66476007)(4326008)(66556008)(6916009)(8676002)(66946007)(64756008)(76116006)(52536014)(8936002)(41300700001)(66899018)(5660300002)(6506007)(7696005)(71200400001)(966005)(478600001)(122000001)(9686003)(26005)(2906002)(53546011)(186003)(55016003)(33656002)(83380400001)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkZPNjBVN0R4VmdjMjJhYjNCOG9mSDVZNnQrSlZibThmUTVyam1KVnNzU2tu?=
 =?utf-8?B?NEhrVmROcTVQNlFlZEJ1ZGc5MC9YV0pzNGRLb05ZUk5TOHRpbVlVNUt5UjQ2?=
 =?utf-8?B?R3VjcjBxTTdtcFZtdVdKb3dNTmV2Rnc4eGx2ckxwejJsQmRzZWVVb3U4SURW?=
 =?utf-8?B?cTNoQkNPd1g2cWJxdWRLcStDSnRjWTFjbzRqOGJJbkkwNDRnWjZSN2xJR1Rk?=
 =?utf-8?B?eWZ1WHc0OVEvV1VUazVYZHdNWE1BYlBNa3RuQUNwZGcwNVFYcTJ0MGlGRDlU?=
 =?utf-8?B?SE4xNzF0aXlJUll0c21BU0xDcEVPV1hDOEc4SU01dUdRdWh2ZWdsenB4M3lB?=
 =?utf-8?B?ZFNyYktEOFBpWEplUnNtMmZqMFVqdCtRR1dTZ2xjNDl6bzZZaTdBNkVRYStC?=
 =?utf-8?B?bWN5bGw1eGdYMGFHTjhubWVuRUNaa010Z1IzM2NhWlNtd0VTTzNKQSswSVlH?=
 =?utf-8?B?ajZOSFAvc0NobGlGR09oeWpvRTc1RzkvTWFJVURQQ0R6eUVyUnRXblRFSkQr?=
 =?utf-8?B?L2hPbnRLamhkZ29qV1VvVXV4Skc4NzU4UjErSEJWUnNocnNqSXZPMWFvbE5r?=
 =?utf-8?B?SXFXditBNjlSSnB3S3ppbit1aldsa2RxNGJBRFRnbGh0WGdSS1dpSFcwTmJj?=
 =?utf-8?B?b1FKMGM0ajEzb3VaQUlrSS9qWmNYeWloeUg2TmJHdDEvWDM4WnMwVUJHZmV0?=
 =?utf-8?B?QXI1dkt2UzlpOWE5V2lVQ24xcCtVWHh3VncrcmNLNDRqYmdjWTJYZHBzZ3R2?=
 =?utf-8?B?Sy9MRWRUbHZ1RE9CYi9OLzBiVGVYbFZlV1NSRkpOV1lxSFhiajVjUUVsUmVC?=
 =?utf-8?B?ckpDVW90MDlqUmUxalNXcGs5ZlBNbGNxYUZwQ3d3QXc5SEZIbzR0eTBHdXZo?=
 =?utf-8?B?Q0Y2SXpsTWtEckRnL3d1WUozbDZ4djhlVVdKMkpPRVI5SlBYckVuWjJpZWJ2?=
 =?utf-8?B?V1FDZkQ5MnBCNFAxRStySnZ0RFpiNm9ramR3QkFxVDJ4TEdUQ3FDZHNyVFM1?=
 =?utf-8?B?Ukd6RGVoUVJJK0ttV2t3S1duZ1A3YTFJTFU3aWk2eW9Gbml6RFRJRk1yL1Fa?=
 =?utf-8?B?MTRlR2hreHJtVzV2QTVsaXkraEJVMXYvSDZOdHUxalhKSHM2UC9sU3ArUk02?=
 =?utf-8?B?VWZsVXJnVG9rem9YT25qUGc3TmJuN0lVSVdHRlhSYXlNTWI2RnBlN0lMV241?=
 =?utf-8?B?Ylp5Y2V6VGNoSTV5OXk1UGduT1FnZVpFb0tXM2hYbkhSMFY1dWhTWTNZSTZh?=
 =?utf-8?B?Y2VOR1IzOS80YVV3NzVQeXlWQlU5SnhCam1HV3pkUC9nM0ZWOUVFekh0OW56?=
 =?utf-8?B?U0xzcDIwVHZ0Ti9jUUNYdlFSSlE2MEpEcURnRnFCbVhxYTB6OFJZYUp0MGNE?=
 =?utf-8?B?RGtKQU5adzNLMEV3UnlrZ1UzT1JTUjJSc2JrSlJjMVBZWGtYWlZXWGRxc2E4?=
 =?utf-8?B?UUhhRk00WUxRUXcwZXdkbHhldUpha1NiYnk4dXJDZElmZ2hQNHZoYXh6WElS?=
 =?utf-8?B?dkg1OWlsQzVuVU9oNkpQYnRBNUlhSWNUVUNRSFI2b1pmNC8zRTM4dlJyZm03?=
 =?utf-8?B?MnNERE1seGNWdS9BR3FlT2gvamxLcUVZYk1BT0NIV0tlZmkzOVBFQTlKYi90?=
 =?utf-8?B?WHJWckhLMDYxL0ZjMU0yUi9BZy81cURweDROVVVuRVIzUTNRMlZyVjFNcGl1?=
 =?utf-8?B?L2xSN2tmOWFoMkRRZlp1dmVQTWhyZ1VEbXJ3TlV6c29uRStrMUtwTEtrbGs3?=
 =?utf-8?B?ejNmZ2N3eTNzTHF3Y3E1UGJTSmpxZHJhNE5IN0FSM01vZDZoTGUrUTZsbDB4?=
 =?utf-8?B?eGl4Y2QrdEFDcGxCdUllY2VDMkZhMXVYRE0xMFVia044aFk1S2d1THZQeHJK?=
 =?utf-8?B?YTEzV0I0UEp5NGFjajdic2ZFcW1rNEhITHRVVmZXZVN3WFcrTDlrTXpORUVl?=
 =?utf-8?B?OGRTdFNhZjdWNldBM3VuWnV1dXlCVHVRYnU0WDdBeEtuaWtEYmU1MU1jM3Qv?=
 =?utf-8?B?OGtuUnpjSDBLMnJ4aEhhSmpWSXBjOUZoRWlMU0FCVVJ4N1dqQVJyNEdDd1hL?=
 =?utf-8?B?cXRmckJWZkdnNzZCN0JER3Z6WWl6bk9keUx6aFIyOUZLLzVqWTcxcSt0bUgz?=
 =?utf-8?Q?+1Qg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d0136e-1d86-4f91-5554-08db0e9c4474
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 15:00:52.9062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8t8QXNL+ev86FIyKuC/8uAfxduxscrHbcYpIDDECd/CVs/IqOtcBtB/wZ0in7pW/y0scQfb2QsMralQisqP09A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
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
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9y
Zz4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTQsIDIwMjMgMDg6NTkNCj4gVG86IExpbW9u
Y2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IFJhZmFlbCBK
LiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGRiaWxpb3NAc3RkaW8uZ3I7IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsgbGlu
dXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIEFDUEk6
IHg4NjogQWRkIG1vcmUgc3lzdGVtcyB0byBxdWlyayBsaXN0IGZvciBmb3JjaW5nDQo+IFN0b3Jh
Z2VEM0VuYWJsZQ0KPiANCj4gT24gVHVlLCBGZWIgMTQsIDIwMjMgYXQgMzo1MiBQTSBMaW1vbmNp
ZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+ID4NCj4gPg0KPiA+DQo+ID4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTQs
IDIwMjMgMDg6NDkNCj4gPiA+IFRvOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2ll
bGxvQGFtZC5jb20+DQo+ID4gPiBDYzogcmFmYWVsQGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGRiaWxpb3NAc3RkaW8uZ3I7DQo+IExlbg0KPiA+ID4gQnJvd24gPGxl
bmJAa2VybmVsLm9yZz47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIDIvMl0gQUNQSTogeDg2OiBBZGQgbW9yZSBzeXN0ZW1zIHRvIHF1aXJrIGxp
c3QgZm9yDQo+IGZvcmNpbmcNCj4gPiA+IFN0b3JhZ2VEM0VuYWJsZQ0KPiA+ID4NCj4gPiA+IE9u
IE1vbiwgRmViIDEzLCAyMDIzIGF0IDEwOjM1IFBNIE1hcmlvIExpbW9uY2llbGxvDQo+ID4gPiA8
bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IGNvbW1p
dCAwMThkNjcxMWMyNmU0ICgiQUNQSTogeDg2OiBBZGQgYSBxdWlyayBmb3IgRGVsbCBJbnNwaXJv
biAxNCAyLWluLQ0KPiAxDQo+ID4gPiA+IGZvciBTdG9yYWdlRDNFbmFibGUiKSBpbnRyb2R1Y2Vk
IGEgcXVpcmsgdG8gYWxsb3cgYSBzeXN0ZW0gd2l0aA0KPiBhbWJpZ3VvdXMNCj4gPiA+ID4gdXNl
IG9mIF9BRFIgMCB0byBmb3JjZSBTdG9yYWdlRDNFbmFibGUuDQo+ID4gPiA+DQo+ID4gPiA+IEl0
IGlzIHJlcG9ydGVkIHRoYXQgVm9zdHJvIDU2MjYgc3VmZmVycyBzYW1lIHN5bXB0b21zLiBBZGQg
dGhpcyBvdGhlcg0KPiA+ID4gPiBzeXN0ZW0gdG8gdGhlIGxpc3QgYXMgd2VsbC4NCj4gPiA+ID4N
Cj4gPiA+ID4gU3VnZ2VzdGVkLWJ5OiBkYmlsaW9zQHN0ZGlvLmdyDQo+ID4gPiA+IExpbms6IGh0
dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE3MDAzDQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQu
Y29tPg0KPiA+ID4NCj4gPiA+IENhbiB5b3UgcGxlYXNlIGNvbWJpbmUgdGhlc2UgdHdvIHBhdGNo
ZXMgaW50byBvbmU/DQo+ID4gPg0KPiA+ID4gT3IgYXQgbGVhc3QgbWFrZSB0aGUgc3ViamVjdHMg
ZGlmZmVyPw0KPiA+DQo+ID4gSSBsZWZ0IHRoZW0gc3BsaXQgc28gdGhhdCB3ZSBjb3VsZCByZXZl
cnQgb25lIGlmIHRoZSBCSU9TIGlzIGZpeGVkIG9uIG9uZQ0KPiA+IGluIHRoZSBmdXR1cmUuICBI
YXBweSB0byByZXNwaW4gd2l0aCBzZXBhcmF0ZSBzdWJqZWN0cy4NCj4gPg0KPiA+IEJ1dCBiZWZv
cmUgSSByZXNwaW47IHNvbWV0aGluZyBlbHNlIEkgd2FudCB0byBvZmZlciBhcyBhbiBpZGVhIHRv
IGF2b2lkIHRoaXMNCj4gbGlzdA0KPiA+IGdyb3dpbmcuDQo+ID4NCj4gPiBUaGV5IGFsbCB1c2Ug
dGhlIHNhbWUgQ1BVLiAgU28gd2UgY291bGQganVzdCBhZGQgdGhlIENQVSBtb2RlbCB0aGF0IGFs
bCBvZg0KPiB0aGVzZQ0KPiA+IHVzZSB0byB0aGUgZm9yY2UgU3RvcmFnZUQzRW5hYmxlIGxpc3Qg
YW5kIHRha2Ugb3V0IHRoZSB3aG9sZSAoZ3Jvd2luZykgbGlzdC4NCj4gDQo+IFdlbGwsIEknZCBy
YXRoZXIgZG8gdGhpcywgYnV0IGluIHRoZSBuZXh0IGN5Y2xlLg0KPiANCj4gPiBXaGljaCB3YXkg
d291bGQgeW91IHByZWZlcj8NCj4gDQo+IEZvciB0aGlzIG1lcmdlIHdpbmRvdywgcGxlYXNlIHJl
c3BpbiB0aGUgY3VycmVudCBwYXRjaCBzZXJpZXMgYW5kIG1ha2UNCj4gdGhlIGNoYW5nZXMgYXMg
cGVyIHRoZSBhYm92ZSBlYXJseSBhZnRlciA2LjMtcmMxLg0KPiANCj4gSXQgbWF5IGJlIHN0aWxs
IG5lY2Vzc2FyeSB0byBwdWxsIHRoZW0gaW50byA2LjMtcmMgbGF0ZXIsIGlmIG1vcmUNCj4gaW5z
dGFuY2VzIGFyZSByZXBvcnRlZCBvciBkaXNjb3ZlcmVkLCBidXQgd2UnbGwgc2VlLg0KDQpTdXJl
LCB0aGFua3MuICBJJ2xsIHJld29yayBpdCBmb3IgdGhpcyBhbmQgd2FpdCB1bnRpbCA2LjMtcmMx
IHRvIHNlbmQgaXQuDQo=
