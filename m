Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664F71F08E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjFARVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjFARVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:21:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251B1F2;
        Thu,  1 Jun 2023 10:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqO2PNwfjrW9JodrV0IphrkSIXbAFU1jTkrp38LjILzSKhlNv8XqnhbwuJ9qezLtA6+Tl2N+k7gzneXgKjgY4TIeMxyDieuDLK9AGaFl6tDkSNmc8iZHUzfsWSGmfrGxoCzecMqy/6p4El0V+MpH8Pf35v2TtsbIMlpWmXCpV9uNkdc0xstwq5IE+KHraNM0zyvJ2uObgdZLlRWENrRumQrwyUfQN3P4oRr5eR2SXD907mzaVLW02ewOozXWZIERL6juRtz9yCUgvu4+Zv83VRo1QEpLxMxniA4Y9+my109mKwwm4CLypU2OKCiyjbdUw+/IqWfn2l1lUWOwerY2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6/QFVAvFp7kf86/kWx2pOTI0m4/+fkVVr6h4KLNaoc=;
 b=BIsgsBOlODjUoq3BPeaGDbur1AtYR9NbO2tr/jdpb9si2+DegNmdDXaDgxgPf1vdYelp/FZCdb0rZY9m4iApggoji0K+nXSJzHVK6S3KYL/5P1ASySVPGiQZ52K75RT2BlT+9Kb6KMF15dr37sWnHezunrPOO5j3m2MN3fySBIw8bmKCT5WIE/CcFf6aJKqmvnPdaxM1FEnfBnOOlBBBtMhlUdRFxFSZ6vX6aePcuCXVDXwCCx5zFLtiVZ3sdDYFS9eq1IleFjLSxnm/fLcCAN4ypnEA6kAuijFiNtbHFEy9x/4jX9Rzur3fv9J+UhtBEg+v9HuiFKJKQK5PArsyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6/QFVAvFp7kf86/kWx2pOTI0m4/+fkVVr6h4KLNaoc=;
 b=VGlEPSqLgIXq2OH4gXmkwPFdfJD92fsFgG8pEuUS7uUCsZKt/Jru+I3d6hl/HX0cKxQL2p2K3B0njjaRzwp2cZOi+PpDNCUAec5kvk7MEwu1mHpjdWgZ5jAnYTH9+ZAEojojJRGUyj7F1PmTqqXZcgzXirxq2ACL0V8jmkVnPLM=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 17:21:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 17:21:35 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Karol Herbst <kherbst@redhat.com>
CC:     Nick Hastings <nicholaschastings@gmail.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "1036530@bugs.debian.org" <1036530@bugs.debian.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI string"?
 (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Thread-Topic: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Thread-Index: AQHZkTCTXT9qiOm+i06x7G4cHp2/pq9vocuAgADMgQCAAAUmAIAAK9qAgAFBYoCAAFNkgIAAMowAgAKppoCAARahAIAABDeAgAAETGCAAAh3AIAAAELw
Date:   Thu, 1 Jun 2023 17:21:34 +0000
Message-ID: <MN0PR12MB6101DE067CF85E59AF187763E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHKrC4/G6ZyvRReI@xps> <ZHL5cCNUzVdleiag@eldamar.lan>
 <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com> <ZHP4IqxBUPuVRvRV@xps>
 <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com> <ZHQhPcKUF76Kplwm@xps>
 <ZHUt9xQKCwCflvVC@xps> <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
 <ZHWfMBeAONerAJmd@xps> <ZHfa/wQlaVCeUC22@xps>
 <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
 <CACO55tsuO1kQUFfPdPFUHm4WEQseCR2tQSDhFRzR+8wOECZCyA@mail.gmail.com>
 <MN0PR12MB61017541F5AC55485A490BCDE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tudULtvt_Hcdg+uqXeYkSAR_NZ1oD=R_KhuE_THSRe88g@mail.gmail.com>
In-Reply-To: <CACO55tudULtvt_Hcdg+uqXeYkSAR_NZ1oD=R_KhuE_THSRe88g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7f3d1c86-a990-4965-8366-57467ab74b30;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-01T17:19:42Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SA1PR12MB8857:EE_
x-ms-office365-filtering-correlation-id: 920ff5d7-4a82-48ca-4af2-08db62c4a68a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwRgK5Kfi001YdQ+hQcyKwwly4EHglrFkDPoxM3FokK1EPGgdfR09HbNxbIPou0Kb+KVkBRvbXgmF3UcPEm7WpZDKEICIqiRNfJxwIzTkOc7HtpiaShCBWBoh0Ky4JPJ0yjwWcYmwie2INNMJ//ia85ZZhp2frBG5fQsCJrTx/TKs/7nd3C0GX74R1S+BqWBBl5UUJfLLyU4fxFd+R1UvUsgOS1nOxgeGSKH0pnQy3HWhGzhzJqEnl+WxGZJqqMvx0St6SnxnaACYT0XNwhlY1pcJkIHQf5YX89+RtA1tpBR9gTMoi3BnEJcbSZHvNVrCFJdxfOKmcKXYbjrp9OXklhlTubDr9ckkdg/zMy3eU3kYy2A9/6HEHkMmiLdUz3STNoUT14df020HA8UyKbZKnDCt0YDRp4kcNgbz2LRIpbXYgzyUAPwG83ygDF/Pk8i8Xh6XzxQ0s4OPtiLqYttjktct49HVmooTmojr0zKtoe8bk1RBwI8/r5WKtxRuUUHUdqfl4Q/4j8HnrRxrz+jAupGzbHyemMQC9vgCznhzlgYi7GlbgNfZJT93VvfzvoYdqt9j2zUV3L3OpXj8bm/GgleP6qDR/I555ITL4Ac74fTk2l3rxWutJ2ujPJYwb4Me4gU0O/jQVvNSU6eVPS2BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(316002)(83380400001)(122000001)(2906002)(54906003)(76116006)(966005)(38100700002)(6506007)(9686003)(26005)(64756008)(6916009)(66446008)(66556008)(66476007)(4326008)(66946007)(38070700005)(86362001)(7416002)(478600001)(71200400001)(5660300002)(33656002)(186003)(7696005)(41300700001)(52536014)(55016003)(8676002)(8936002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0pjdDFjSkdudkpGTkFmZjNxcHdCRHNkZ2YvWlZXOHBKd0MrK3c0RXJHR29z?=
 =?utf-8?B?Z2xqTnpCZHM1dU5lOS92SktRZWFmTE9OTXFJRFVkRitudUNCUkdFZ3l0OStH?=
 =?utf-8?B?WjhXK0NWZS94V2tBQzhkbzhJQjQrVjlaQU5ibmJQMXpqZGpsRWNOZG5CNWdS?=
 =?utf-8?B?OGRnWDJPSEJCdEpKZFkxeW1GM2hxQTFKRjdyTDBQQTlxSUdNSmNCUlppOEtm?=
 =?utf-8?B?Q29hcXRhaUJNaTJCdmd3aXJXNUEwd0dHNFdjSzhJakRHVXdtNXVmZzB2amFm?=
 =?utf-8?B?OXZHMVFxK0FnQ1RHTk9uaEEwcDFQaFN4bU9LMVlwdXdPdTlPTkhGNndaa0sz?=
 =?utf-8?B?Z3k3YldPbmo2RzJidWNMa1lSeWFjbmlLSXFmZjE1MWpSK3djc1NwZEl4K0tp?=
 =?utf-8?B?U0tyNDVvaVRrOWJLcW53UVkvZlB0Rk5tQzh1dnJZN1R4ditCRFhyb0tlWVRM?=
 =?utf-8?B?WVRORVltdHZTVGNic2t6SnU1dHNqd2hVZkU1VWl6UWdRL0drbHVMVzBKdjZS?=
 =?utf-8?B?MzNpMThKZ3QvUjdrY0NxTlVYd3J5UjFTUlN4S216ZS9ScVpaTU1Sd1RJWVJu?=
 =?utf-8?B?S2dlSForZCtwQ2pZd3RyMEU4ZXA4MCtvUGh2YU0xZ09HaXo5Zk9rbU8rT2Fu?=
 =?utf-8?B?UWlLV2lMN3dnV09sbSt5UG1oVHJIREpTVW9oZC9OdUt6NHd0QjhDT1A5dGhu?=
 =?utf-8?B?MkNOZWFOa1FSamFad0s2NEE2U1dSUE93MVg2dElOYWhIWFFvR2hBQ2V0d2lW?=
 =?utf-8?B?RUFBbW03SmVzaklwbk5icjR0UjZOSEZCQW9admZCRVltV0lqWWs1ejNkRmQw?=
 =?utf-8?B?MFNBZG9zLy9ENXFoZEI5WUJnTTNpSzViR1RwK05SV2I0cVg0dzBOcGg2SDB4?=
 =?utf-8?B?WE8wOXNHa045aTZVZ2czWE1KZjY2QVg5ZDZWU0ZkcHZ5K3ViQ1E1TDdIanhl?=
 =?utf-8?B?ZitlNWhhUTBKdGEwQStaNTVXNGp0eDdHSlBrZEc3RGxmZnF0K0IrT0EwSVIr?=
 =?utf-8?B?M3cvcTFFRG9xVEJPUk1uWWlNdE1lNGI3VWpWcDdKZTU0dnRxMkFSZDg0am81?=
 =?utf-8?B?L2NpZGViUktiQjdyQWlybDU4bHBSOWNDUG1xSStLQmJ4UEJaWHpjVUNUK2Jh?=
 =?utf-8?B?MjA1ZzcrdWF5eVBaUm5pWm8zQWdhcm43Yk9pU3k5NnBkUkI3SnNpdG4ydzhz?=
 =?utf-8?B?MHB4SjFHbTkxNWd6K0RxSkp5VURacW43dmxuK3hCOGdMVVJNd3RPcXkyaGlD?=
 =?utf-8?B?YTd3ZFFLU1A1dmU3OE9rYWpaS2Z6U1JyTGtmNDE4VHhqaEo3MnFhSTdsOWhW?=
 =?utf-8?B?Vyt2cUJhazA3UUxyMW5HVHJ0bTI0eEJDeGhCK2NHcVZJUktWR3JCTFVQZ25m?=
 =?utf-8?B?eWdVTm9pc0FiaU5xRnNkeEtPQmZYOVpCOG1kL1kxeDZRYld2Q3RtWjJCMVZI?=
 =?utf-8?B?YmF5V0R3eWo5MCtOMGxWY1ZQanNJQnp3UHE4TkZXSlV6T1JBc2ZlTE5NRDN4?=
 =?utf-8?B?bzI4WXhnM0ZpY2phWDZFN3RkZ3hneUhIRFVsczVYb2ppQ1Z0bzMvOGx1Q3dt?=
 =?utf-8?B?T2piRGtpRVlQMlg2cVZ0S2dMb0lLMTJjY2ZwNXlpR2FscTYvNDVWL1FRcHdl?=
 =?utf-8?B?dTJWRGRhNHNpZC9lWUNlN0NyQXRDR1VaK1B3Y0FNSUU4cXZwVHJWRm1MZjFv?=
 =?utf-8?B?WUhHK3hDdGtXSjVUSCttOWlDRnBqU3ZndzRjV0FLTUdqQXRtd0tOeElJM2F0?=
 =?utf-8?B?bG41eWVySnMvbUFzSmdmYytIQ2NQWmVQTGhWYWZxaUZHMFZ4RHJhd3Y1WEJ1?=
 =?utf-8?B?RU5FZTMydUppYTloNzlMejRncFR6UEVIb0FEeUhvMXBnbFFjbkY0dGhUYWM5?=
 =?utf-8?B?dTBRMFhiOWEwY1V4OHgxandtS0dsTmNhcytYZVhCbWpPZGdqNHQzdDJJdlAr?=
 =?utf-8?B?bWdseXc1L2FOakFvNHFQNXRKZS9FTG42dXovbXAzZExqQmRkWFB5eFNjSTI2?=
 =?utf-8?B?V3B0djNpdDBxblpDOEFEKzdNZ1BCMFF4ZUZzN0pMQ2ZUY094M0ZZZXU5aVdp?=
 =?utf-8?B?QngreDJSeGdCL0tadkQvS0dJT2RTdHJFUTBXK2VhVG5GSHdaZUxwMEUwbGJp?=
 =?utf-8?Q?rx2Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920ff5d7-4a82-48ca-4af2-08db62c4a68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 17:21:34.9827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64T8ArLtBx8yoXZCff+6bOZqyBGX7+0OxHfLAG/oi9HF6F1ecSS3ZzyXUrCCQpTtBkzGuqDWGM1xwPdNQv4Aww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS2Fyb2wgSGVyYnN0IDxraGVyYnN0QHJlZGhhdC5jb20+DQo+IFNl
bnQ6IFRodXJzZGF5LCBKdW5lIDEsIDIwMjMgMTI6MTkgUE0NCj4gVG86IExpbW9uY2llbGxvLCBN
YXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IE5pY2sgSGFzdGluZ3MgPG5p
Y2hvbGFzY2hhc3RpbmdzQGdtYWlsLmNvbT47IEx5dWRlIFBhdWwNCj4gPGx5dWRlQHJlZGhhdC5j
b20+OyBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT47IFNhbHZhdG9yZQ0KPiBCb25hY2Nv
cnNvIDxjYXJuaWxAZGViaWFuLm9yZz47IDEwMzY1MzBAYnVncy5kZWJpYW4ub3JnOyBSYWZhZWwg
Si4NCj4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVs
Lm9yZz47IGxpbnV4LQ0KPiBhY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gcmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJl
OiBSZWdyZXNzaW9uIGZyb20gIkFDUEk6IE9TSTogUmVtb3ZlIExpbnV4LURlbGwtVmlkZW8gX09T
SQ0KPiBzdHJpbmciPyAod2FzOiBSZTogQnVnIzEwMzY1MzA6IGxpbnV4LXNpZ25lZC1hbWQ2NDog
SGFyZCBsb2NrIHVwIG9mIHN5c3RlbSkNCj4NCj4gT24gVGh1LCBKdW4gMSwgMjAyMyBhdCA2OjU0
4oCvUE0gTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPiB3
cm90ZToNCj4gPg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5lcmFsXQ0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogS2Fyb2wgSGVyYnN0
IDxraGVyYnN0QHJlZGhhdC5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxLCAyMDIz
IDExOjMzIEFNDQo+ID4gPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxs
b0BhbWQuY29tPg0KPiA+ID4gQ2M6IE5pY2sgSGFzdGluZ3MgPG5pY2hvbGFzY2hhc3RpbmdzQGdt
YWlsLmNvbT47IEx5dWRlIFBhdWwNCj4gPiA+IDxseXVkZUByZWRoYXQuY29tPjsgTHVrYXMgV3Vu
bmVyIDxsdWthc0B3dW5uZXIuZGU+OyBTYWx2YXRvcmUNCj4gPiA+IEJvbmFjY29yc28gPGNhcm5p
bEBkZWJpYW4ub3JnPjsgMTAzNjUzMEBidWdzLmRlYmlhbi5vcmc7IFJhZmFlbCBKLg0KPiA+ID4g
V3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47
IGxpbnV4LQ0KPiA+ID4gYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4gPiByZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXYNCj4gPiA+IFN1Ympl
Y3Q6IFJlOiBSZWdyZXNzaW9uIGZyb20gIkFDUEk6IE9TSTogUmVtb3ZlIExpbnV4LURlbGwtVmlk
ZW8gX09TSQ0KPiA+ID4gc3RyaW5nIj8gKHdhczogUmU6IEJ1ZyMxMDM2NTMwOiBsaW51eC1zaWdu
ZWQtYW1kNjQ6IEhhcmQgbG9jayB1cCBvZg0KPiBzeXN0ZW0pDQo+ID4gPg0KPiA+ID4gT24gVGh1
LCBKdW4gMSwgMjAyMyBhdCA2OjE44oCvUE0gTGltb25jaWVsbG8sIE1hcmlvDQo+ID4gPiA8bWFy
aW8ubGltb25jaWVsbG9AYW1kLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+ICtMeXVkZSwg
THVrYXMsIEthcm9sDQo+ID4gPiA+DQo+ID4gPiA+IE9uIDUvMzEvMjAyMyA2OjQwIFBNLCBOaWNr
IEhhc3RpbmdzIHdyb3RlOg0KPiA+ID4gPiA+IEhpLA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gKiBO
aWNrIEhhc3RpbmdzIDxuaWNob2xhc2NoYXN0aW5nc0BnbWFpbC5jb20+IFsyMzA1MzAgMTY6MDFd
Og0KPiA+ID4gPiA+PiAqIE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQu
Y29tPiBbMjMwNTMwIDEzOjAwXToNCj4gPiA+ID4gPiA8c25pcD4NCj4gPiA+ID4gPj4+IEFzIHlv
dSdyZSBhY3R1YWxseSBsb2FkaW5nIG5vdXZlYXUsIGNhbiB5b3UgcGxlYXNlIHRyeQ0KPiA+ID4g
bm91dmVhdS5ydW5wbT0wIG9uDQo+ID4gPiA+ID4+PiB0aGUga2VybmVsIGNvbW1hbmQgbGluZT8N
Cj4gPiA+ID4gPj4gSSdtIG5vdCBpbnRlbnRpb25hbGx5IGxvYWRpbmcgaXQuIFRoaXMgbWFjaGlu
ZSBhbHNvIGhhcyBpbnRlbCBncmFwaGljcw0KPiA+ID4gPiA+PiB3aGljaCBpcyB3aGF0IEkgcHJl
ZmVyLiBDaGVja2luZyBteQ0KPiA+ID4gPiA+PiAvZXRjL21vZHByb2JlLmQvYmxhY2tsaXN0LW52
aWRpYS1ub3V2ZWF1LmNvbmYNCj4gPiA+ID4gPj4gSSBzZWU6DQo+ID4gPiA+ID4+DQo+ID4gPiA+
ID4+IGJsYWNrbGlzdCBudmlkaWENCj4gPiA+ID4gPj4gYmxhY2tsaXN0IG52aWRpYS1kcm0NCj4g
PiA+ID4gPj4gYmxhY2tsaXN0IG52aWRpYS1tb2Rlc2V0DQo+ID4gPiA+ID4+IGJsYWNrbGlzdCBu
dmlkaWEtdXZtDQo+ID4gPiA+ID4+IGJsYWNrbGlzdCBpcG1pX21zZ2hhbmRsZXINCj4gPiA+ID4g
Pj4gYmxhY2tsaXN0IGlwbWlfZGV2aW50Zg0KPiA+ID4gPiA+Pg0KPiA+ID4gPiA+PiBTbyBJIHRo
b3VnaHQgSSBoYWQgYmxhY2tsaXN0ZWQgaXQgYnV0IGl0IHNlZW1zIEkgZGlkIG5vdC4gU2luY2Ug
SSBkbyBub3QNCj4gPiA+ID4gPj4gd2FudCB0byB1c2UgaXQgbWF5YmUgaXQgaXMgYmV0dGVyIHRv
IGNoZWNrIGlmIHRoZSBsb2NrIHVwIG9jY3VycyB3aXRoDQo+ID4gPiA+ID4+IG5vdXZlYXUgYmxh
Y2tsaXN0ZWQuIEkgd2lsbCB0cnkgdGhhdCBub3cuDQo+ID4gPiA+ID4gSSBibGFja2xpc3RlZCBu
b3V2ZWF1IGFuZCBib290ZWQgaW50byBhIDYuMSBrZXJuZWw6DQo+ID4gPiA+ID4gJSB1bmFtZSAt
YQ0KPiA+ID4gPiA+IExpbnV4IHhwcyA2LjEuMC05LWFtZDY0ICMxIFNNUCBQUkVFTVBUX0RZTkFN
SUMgRGViaWFuIDYuMS4yNy0xDQo+ID4gPiAoMjAyMy0wNS0wOCkgeDg2XzY0IEdOVS9MaW51eA0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gSXQgaGFzIGJlZW4gcnVubmluZyB3aXRob3V0IHByb2JsZW1z
IGZvciBuZWFybHkgdHdvIGRheXMgbm93Og0KPiA+ID4gPiA+ICUgdXB0aW1lDQo+ID4gPiA+ID4g
ICAwODozNDo0OCB1cCAxIGRheSwgMTY6MjIsICAyIHVzZXJzLCAgbG9hZCBhdmVyYWdlOiAxLjMz
LCAxLjI2LCAxLjI3DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBSZWdhcmRzLA0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gTmljay4NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzLCB0aGF0IG1ha2VzIGEgbG90
IG1vcmUgc2Vuc2Ugbm93Lg0KPiA+ID4gPg0KPiA+ID4gPiBOaWNrLCBDYW4geW91IHBsZWFzZSB0
ZXN0IGlmIG5vdXZlYXUgd29ya3Mgd2l0aCBydW50aW1lIFBNIGluIHRoZQ0KPiA+ID4gPiBsYXRl
c3QgNi40LXJjPw0KPiA+ID4gPg0KPiA+ID4gPiBJZiBpdCB3b3JrcyBpbiA2LjQtcmMsIHRoZXJl
IGFyZSBwcm9iYWJseSBub3V2ZWF1IGNvbW1pdHMgdGhhdCBuZWVkDQo+ID4gPiA+IHRvIGJlIGJh
Y2twb3J0ZWQgdG8gNi4xIExUUy4NCj4gPiA+ID4NCj4gPiA+ID4gSWYgaXQncyBzdGlsbCBicm9r
ZW4gaW4gNi40LXJjLCBJIGJlbGlldmUgeW91IHNob3VsZCBmaWxlIGEgYnVnOg0KPiA+ID4gPg0K
PiA+ID4gPiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL25vdXZlYXUvDQo+ID4g
PiA+DQo+ID4gPiA+DQo+ID4gPiA+IEx5dWRlLCBMdWthcywgS2Fyb2wNCj4gPiA+ID4NCj4gPiA+
ID4gVGhpcyB0aHJlYWQgaXMgaW4gcmVsYXRpb24gdG8gdGhpcyBjb21taXQ6DQo+ID4gPiA+DQo+
ID4gPiA+IDI0ODY3NTE2ZjA2ZCAoIkFDUEk6IE9TSTogUmVtb3ZlIExpbnV4LURlbGwtVmlkZW8g
X09TSSBzdHJpbmciKQ0KPiA+ID4gPg0KPiA+ID4gPiBOaWNrIGhhcyBmb3VuZCB0aGF0IHJ1bnRp
bWUgUE0gaXMgKm5vdCogd29ya2luZyBmb3Igbm91dmVhdS4NCj4gPiA+ID4NCj4gPiA+DQo+ID4g
PiBrZWVwIGluIG1pbmQgd2UgaGF2ZSBhIGxpc3Qgb2YgUENJZSBjb250cm9sbGVycyB3aGVyZSB3
ZSBhcHBseSBhDQo+ID4gPiB3b3JrYXJvdW5kOg0KPiA+ID4NCj4gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJp
dmVycw0KPiA+ID4gL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2RybS5jP2g9djYuNC1yYzQjbjY4
Mg0KPiA+ID4NCj4gPiA+IEFuZCBJIHN1c3BlY3QgdGhlcmUgbWlnaHQgYmUgb25lIG9yIHR3byBt
b3JlIElEcyB3ZSdsbCBoYXZlIHRvIGFkZA0KPiA+ID4gdGhlcmUuIERvIHdlIGhhdmUgYW55IGxv
Z3M/DQo+ID4NCj4gPiBUaGVyZSdzIHNvbWUgYXJjaGl2ZWQgb250byB0aGUgZGlzdHJvIGJ1Zy4g
IFNlYXJjaCB0aGlzIHBhZ2UgZm9yDQo+ICJqb3VybmFsY3RsLmxvZy5neiINCj4gPiBodHRwczov
L2J1Z3MuZGViaWFuLm9yZy9jZ2ktYmluL2J1Z3JlcG9ydC5jZ2k/YnVnPTEwMzY1MzANCj4gPg0K
Pg0KPiBpbnRlcmVzdGluZy4uIEl0IHNlZW1zIHRvIGJlIHRoZSBzYW1lIGNvbnRyb2xsZXIgdXNl
ZCBoZXJlLiBJIHdvbmRlcg0KPiBpZiB0aGUgcGNpIHRvcG9sb2d5IGlzIGRpZmZlcmVudCBvciBp
ZiB0aGUgd29ya2Fyb3VuZCBpcyBhcHBsaWVkIGF0DQo+IGFsbC4NCg0KSSBkaWRuJ3Qgc2VlIHRo
ZSBtZXNzYWdlIGluIHRoZSBsb2cgYWJvdXQgdGhlIHdvcmthcm91bmQgYmVpbmcgYXBwbGllZA0K
aW4gdGhhdCBsb2csIHNvIEkgZ3Vlc3MgUENJIHRvcG9sb2d5IGRpZmZlcmVuY2UgaXMgYSBsaWtl
bHkgc3VzcGVjdC4NCg0KPg0KPiBCdXQgeWVhaCwgSSdkIGtpbmRhIGxvdmUgZm9yIHNvbWVib2R5
IHdpdGggYmV0dGVyIGtub3dsZWRnZSBvbiBhbGwgb2YNCj4gdGhpcyB0byBmaWd1cmUgb3V0IHdo
YXQgZXhhY3RseSBpcyBnb2luZyB3cm9uZywgYnV0IGV2ZXJ5dGltZSB0aGlzDQo+IGdldHMgaW52
ZXN0aWdhdGVkIEludGVsIHNheXMgIm91ciBoYXJkd2FyZSBoYXMgbm8gYnVncyIsIHRoZSBBQ1BJ
DQo+IGZvbGtzIGRpZyBmb3IgbW9udGhzIGFuZCBmaW5kIG5vdGhpbmcgYW5kIEkgZW5kIHVwIGZp
Z3VyaW5nIG91dCBzb21lDQo+IHdlaXJkbyB3b3JrYXJvdW5kIEkgZG9uJ3QgdW5kZXJzdGFuZC4g
QW5kIGFwcGFyZW50bHkgYWxzbyBub2JvZHkgaXMNCj4gYWJsZSB0byBoYW5kIG91dCBkb2NzIGV4
cGxhaW5pbmcgaW4gZGV0YWlsIGhvdyB0aGF0IHJ1bnRpbWUNCj4gc3VzcGVuZC9yZXN1bWUgc3R1
ZmYgaXMgc3VwcG9zZWQgdG8gd29yay4NCj4NCj4gSSBoYXZlIGEgRGVsbCBYUFMgOTU2MCB3aGVy
ZSB0aGUgYWRkZWQgd29ya2Fyb3VuZCBpbiBub3V2ZWF1IGZpeGVkIHRoZQ0KPiBwcm9ibGVtIGFu
ZCBJIGtub3cgaXQncyBmaXhlZCBvbiBhIGJ1bmNoIG9mIG90aGVyIHN5c3RlbXMuIFNvIGlmDQo+
IGFueWJvZHkgaXMgd2lsbGluZyB0byBwdWJsaXNoIGRvY3MgYW5kL29yIGFjdHVhbGx5IGRlYnVn
IGl0IHdpdGgNCj4gZG9tYWluIGtub3dsZWRnZSwgcGxlYXNlIGdvIGFoZWFkLg0KPg0KPiA+ID4g
QW5kIGNvdWxkIGFueWJvZHkgdGVzdCBpZiBhZGRpbmcgdGhlDQo+ID4gPiBjb250cm9sbGVyIGlu
IHBsYXkgaGVyZSBkb2VzIHJlc29sdmUgdGhlIHByb2JsZW0/DQo+ID4gPg0KPiA+ID4gPiBJZiB5
b3UgcmVjYWxsIHdlIGRpZCAyNDg2NzUxNmYwNmQgYmVjYXVzZSA1Nzc1Yjg0M2E2MTkgd2FzDQo+
ID4gPiA+IHN1cHBvc2VkIHRvIGhhdmUgZml4ZWQgaXQuDQo+ID4gPiA+DQo+ID4NCg0K
