Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA25EDD52
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiI1M7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiI1M6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:58:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8CCA031D;
        Wed, 28 Sep 2022 05:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPawbEvbXtuIb2T82J2Q/9srWz3hAYlwDbSqyCkH/KGj87fso+4M89zO2hYmTrW58hXhB3TgxJfNhWd13T5/f6gXNRL9W3E8b/uOT4yv5gpNUgkzurBJFRFZpsM8TnbYQ6spv6WLCQebkcUOc++MbFgARuMko1huUB3MrQk2HAiaYr9TtC1LkUdLhD6OkeJr8WqtWXHmpHDnQZpVfk52RG1uzbb7BeS2wrIucygaymFKl1dmUe/JNJmNcBzjahfnpnK7qv/PD7U2teBXJg2QCTrh7IKKB65Zjz5hnLs3bOSqCXk4p7xFvdx5YseUrPS7mSl7o8FRM7vC7cDgOmSJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6neo4+VzpogSfluHnDiS6kxCGhRadsiZJaYAhLCTKM=;
 b=WQ5iUT8PT3BS+fp65k4o/44xnym9QhluFRgu2xA7bLX3ZMGc3JLIZapzvlQI02lJ8IcatgnOVAz/hpbJ4zrQKPTZm6/6yb6kYLx3MWVWn5OIaLMMxoM+EZeqLbpAqUVPDQyj3eXshI1LMgjuOLJLtO9vnxNHnfck608k0OMDGGN8z7kDCf9ih1ARigz/mC0I+LCGw545jiRsYTTqFTfO+sQppyqNjEtwywxNmZTT6UwaXk4N4zx1VbuGtx1ZcxNM0IOyGFx1IHUtxXZ9HjHfJdKhO2aPtyA+dNeLCUMKUeG8JIIjnhTe0aCc16a3/rFaTwlYyZZLp598cMjqut5XAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6neo4+VzpogSfluHnDiS6kxCGhRadsiZJaYAhLCTKM=;
 b=pHDfRGeK8MLbbHFIBNS2L0Bp8/L7xvFyLjVSMk58ylSGr+kzCUgsKl94jUUjBCGxao2m/wI2u6sVVoSJHZCZbDkgcFumEQVO4U+hVgwRtNTh+mVJdZFU7VFmQbMgo35d7gvNh+gLPZzX9ts9wYjnX1pDDsL4he2lKDWVRXRcPas=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Wed, 28 Sep 2022 12:58:03 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e%3]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 12:58:03 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: RE: [PATCH v5 09/12] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes event configuration
Thread-Topic: [PATCH v5 09/12] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes event configuration
Thread-Index: AQHY0q97FdZqX7F2c06guPlTSvWGAq3z3KEAgADxrmA=
Date:   Wed, 28 Sep 2022 12:58:02 +0000
Message-ID: <MW3PR12MB4553E3A356B634C6329BC5F695549@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431039972.373387.17483031820875867626.stgit@bmoger-ubuntu>
 <IA1PR11MB6097F93E6975B4FAAE3BA1599B559@IA1PR11MB6097.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6097F93E6975B4FAAE3BA1599B559@IA1PR11MB6097.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-28T12:57:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ed63214f-7ff4-4835-b8f3-e05376bfbbfb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-28T12:58:01Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 590c9d43-a1f7-4896-ad0f-c5df170a118e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|DS7PR12MB6023:EE_
x-ms-office365-filtering-correlation-id: 1c8e5987-dc6e-4b60-c16f-08daa1511438
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IxgXzp/ZiU3VemSjno8W5CfPSHZwTbYo9r1TKY2fDX6/yXlOkYycJRkRji+bzj5CtqfCgWCk2urJpvbDLdQZ00d8YsAclwjqf2n+gqw1cR3Bfy6ZOoVzNjIQjJDUxtPASNsppuylQFvuIt4rMbqsDQ02HLr9Ck94oIX05MYC+CSRpxHcd+l5TCdcEbm6z3dTGvetUqB9+nZH70Sm20oY1bAx2ayaY5y0HWsW+x0ZrSn9kuOztcMb8oJTrUh7hvEoLj11OhNkk6+eKOpqEOMG1+bpGixyyrRl/klz8/d//GKySluKdtmgcLH8Sb3Rbb2ucOMPfN9s7h4dJNfDJ0UH3GNxkSaRGqrH3t/Yuq+GkF4UHEr2Uu5b4sMpoxHa26q9M4Uo01rDnf/7Yvb6CVEjYi1686ZJ6SVWlGWB4fqc+tzIESAzIdmr4aduh4tcRWMVCpVIfls1Vp+tWXEQXluRoEc4cT+Owy3cvPe1pKop/jLYsCMYTTCP4GJ/XSmIl5hizPcsaH4yyMQq8jLpv8konNm5+wMdY9M1SoOQVivsIUPC5oezEprWG55mZeydjgQAhDLmVfixOVaUNSerkSkXSlBI9Qj1LeeV3T2Wz1pTbiIz+8GtZrkLRIRny4jId/rGmymIA1CLSPTcUnCrai1VSvoxruPZtaVtLnCYr/vPXVUaInxqFZx3NqwfrdPTOYk3rQpSnH+/1BJWj7Zcr5imjLToRTfLWh1GwGhr52l0DSc5jSY84gXafLtytGtJ9p58CO8XulO5m2ZAfhDTrrVg8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199015)(7416002)(41300700001)(5660300002)(53546011)(9686003)(26005)(8936002)(38070700005)(2906002)(33656002)(66446008)(66556008)(66946007)(64756008)(4326008)(6506007)(52536014)(76116006)(7696005)(8676002)(66476007)(38100700002)(122000001)(86362001)(71200400001)(55016003)(186003)(316002)(54906003)(110136005)(83380400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHVFQ1NxMXdyd0VTZERjb1A4OXZrcDQ4OGhkdFVWemRxMHdyeUd6NThLMU96?=
 =?utf-8?B?TC96dWJ2bllGSk9yc1dkdU9yR0tLTzNGTDB2Q1RCUDJ3RURUTC9KNnl0alZD?=
 =?utf-8?B?eFoyS05IbEh1THhCZ0FMT1hjNUd2eno5R1R3YVhHUGVTK0g1bGQ4cVk5S2sv?=
 =?utf-8?B?dmRIS1FhUk5URDEwUnVOSjZSdElLeTI2ZjdoVG44U3FlaEIzcHcrZjhKMTR6?=
 =?utf-8?B?OThhb0dWbHY1U2pMQitPdno5a1dtbFF6dEE4VytjZUU4NzFTYlprV3NBV2U0?=
 =?utf-8?B?OUtRYTJySGRveWtmMXFGM1RNSTF5dHFZZnZDRWNJSEVQTncycVNWWW1TV1J5?=
 =?utf-8?B?aXljL1ZnT3kyU1grUERKQ24vMjlYT2tLTzdjcS9UZWNPV2hQSzN2WHBHMklH?=
 =?utf-8?B?eHFITHF2Z0NBa1NEc3R6a3ZzMGdjcDM5ZXZreHZ0ZkVDcVlWeGgvb1NZTzBH?=
 =?utf-8?B?bHpjemFldzB1dm9IMDV1amdCTUtrVHF2WEtaSE1DMnp4UVZidFJTWUJhRkt6?=
 =?utf-8?B?U3p5eUhScHpac1F0QkZTK2FqWlF1czZ3Z1U1aEZXbU5keUErOVZMQmtzNTB3?=
 =?utf-8?B?dnJrYmNQZGU2Zk01bmlNTVZGR09YSldraUxzMFpBbzdzL1BHMlpjbE9pZys3?=
 =?utf-8?B?dHF2U1R6OGI0eUVaVG80N2ZjNWFuZnJIWlBjdFpuNzNybGdSVkxqc3FRNDlH?=
 =?utf-8?B?cXNkVFB0ajE1LzZNMVhsd1YrWUZrZHFOb2kySWN2TTdpZnZjRnBPNkFaekNR?=
 =?utf-8?B?R280aUVCVnFlaWxRV2w3dGJzVExIMVpHZnJJWDVDSCtJMG5yYVZCUzkxVkVD?=
 =?utf-8?B?UmZPK29QMWZOTllEMVQ5azkrbnV2cllRQkVWWHhwTGhTcnFwTDk0TDVkc3RS?=
 =?utf-8?B?bU8xd3FTeGNCVkVyejY2ZGlIaXhSZ1BlTFp4cnM5SW5ZaC9BamxCdElZVkxR?=
 =?utf-8?B?ZnlqcG0vdHFHMDduRks4NVFQVE4xS1pmVmFVcGtGTTVRa3hrY2hqVDE0bXY5?=
 =?utf-8?B?OUJaMWFzWUxOTGlqdkwwblFaZDVoSEhjeExVVEwrVXZxRmhGNFlraDV0OEgr?=
 =?utf-8?B?Z0xqMytsSUlHTGR6ZVhIVXoyUEZlNU5GSjZ6ZWRWdFdXY2FzbDlSWVE3elc2?=
 =?utf-8?B?WmIwcGNBRlJGZDNqYXk1bU56N09nVmhHdHIxUk9MNElycG11RVloa0J5ZW9Y?=
 =?utf-8?B?dS96bHJwRWxCSWNOd0k2K0x1cmQrMkdSdTBqUldRQ3V3TnNZV29UYU1OL1Iy?=
 =?utf-8?B?bW1NM0gzeFI5SzRWTWtGbmk3V3NOdUkzYmR2aXZCSFRLdlFVekNWVDBsZFh5?=
 =?utf-8?B?VFdxejZwOTU3THZlc0sxQUZoTDZYbHUvdy9PK0ZtWStocVlPZWtBaExKZEtl?=
 =?utf-8?B?NUdtUHkzN1NyNXc5cStVUlZiWndQc3l0N1p0OXJhOGFLaVhPYmoxYlhhWldF?=
 =?utf-8?B?UksxT2JHOVJVejcybGwxaWl2THpXdnhKTFdTSU96MlFoaW16dTVsa1BvckZI?=
 =?utf-8?B?b2Z4cE9FZ1VxRVNlUlp0M2tMaFlYd01XVzVkZWxsZUdDMk0va2gxeFNUSmV6?=
 =?utf-8?B?Z2tTUnFvYTFDVGNvRFJuOXRhWWllS2RSOEFnY0JOaS90ZG1NREhMdjVRSXlS?=
 =?utf-8?B?Rnd0RHBjR2pQa09MUldLaUo4L3J2TVp2YW55VU5QL2dKSkgybkdDalhTZWpQ?=
 =?utf-8?B?QXlmN2lPek96aXpHRm1xVFNkenVqaGR4dHlaRzNBUFRGVzFBTGU0Nm8wRE1S?=
 =?utf-8?B?RG9xMzRFYW1RTzViOTZoaFRBVEZlSUtSK0FEcnZNbnROaTJKUmMwOVgxNWhU?=
 =?utf-8?B?bHFydXlGMUpDcGVabkc3ZmJvNlFmMi84bkNOaTg0bVJqcnRPV3ZJbVhQUUpG?=
 =?utf-8?B?SlBpYitRMFUxVmwwZ2xtR3lqL09zTjVqc3p3akF5ZnZBTkVtVSsvOGtPYnEz?=
 =?utf-8?B?R085dXUyejU5MlNLUEJLem9vUlFlMEg1ZW5xRStFSlhHMjkwbG1Ra3UzMDBY?=
 =?utf-8?B?eUlMZlE5YnhwTnJRYmx4NmRSZmNKc2FsUmhicWVUcmh5Wm9DVndYd0hsY2hm?=
 =?utf-8?B?OEVGUnhHbUdBcjUwc3VlWnV1aG9hMXZHaWxVRnhSQjJCb2J3enUvYjUyVWZu?=
 =?utf-8?Q?OgMA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8e5987-dc6e-4b60-c16f-08daa1511438
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 12:58:02.9408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/Agisy5G391MWRbRvyCwuVF7XhkrYNSue6VOY1ax2prfMwsGoe1kvqKXaIfqVEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEZlbmdodWEsDQoNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZdSwgRmVuZ2h1YSA8ZmVuZ2h1YS55
dUBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMiA1OjMyIFBN
DQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0QGx3bi5uZXQ7
IENoYXRyZSwgUmVpbmV0dGUNCj4gPHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+OyB0Z2x4QGxp
bnV0cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207DQo+IGJwQGFsaWVuOC5kZQ0KPiBDYzogZGF2
ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyB4ODZAa2VybmVsLm9yZzsgaHBhQHp5dG9yLmNvbTsN
Cj4gcGF1bG1ja0BrZXJuZWwub3JnOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBxdWljX25l
ZXJhanVAcXVpY2luYy5jb207DQo+IHJkdW5sYXBAaW5mcmFkZWFkLm9yZzsgZGFtaWVuLmxlbW9h
bEBvcGVuc291cmNlLndkYy5jb207DQo+IHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbTsgcGV0ZXJ6
QGluZnJhZGVhZC5vcmc7IGpwb2ltYm9lQGtlcm5lbC5vcmc7DQo+IHBib256aW5pQHJlZGhhdC5j
b207IEJhZSwgQ2hhbmcgU2VvayA8Y2hhbmcuc2Vvay5iYWVAaW50ZWwuY29tPjsNCj4gcGF3YW4u
a3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tOyBqbWF0dHNvbkBnb29nbGUuY29tOw0KPiBkYW5p
ZWwuc25lZGRvbkBsaW51eC5pbnRlbC5jb207IERhczEsIFNhbmRpcGFuIDxTYW5kaXBhbi5EYXNA
YW1kLmNvbT47DQo+IEx1Y2ssIFRvbnkgPHRvbnkubHVja0BpbnRlbC5jb20+OyBqYW1lcy5tb3Jz
ZUBhcm0uY29tOyBsaW51eC0NCj4gZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgYmFnYXNkb3RtZUBnbWFpbC5jb207DQo+IEVyYW5pYW4sIFN0ZXBoYW5l
IDxlcmFuaWFuQGdvb2dsZS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjUgMDkvMTJdIHg4
Ni9yZXNjdHJsOiBBZGQgc3lzZnMgaW50ZXJmYWNlIHRvIHdyaXRlDQo+IG1ibV90b3RhbF9ieXRl
cyBldmVudCBjb25maWd1cmF0aW9uDQo+IA0KPiBIaSwgQmFidSwNCj4gDQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jDQo+ID4gYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+IGluZGV4IDI3YmY2YWRlMGRiZi4u
YzFkNDNkMDM4NDZhIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3Ry
bC9yZHRncm91cC5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdy
b3VwLmMNCj4gPiBAQCAtMTQ5MSw2ICsxNDkxLDE0NCBAQCBzdGF0aWMgaW50IG1ibV9sb2NhbF9j
b25maWdfc2hvdyhzdHJ1Y3QNCj4gPiBrZXJuZnNfb3Blbl9maWxlICpvZiwNCj4gPiAgCXJldHVy
biAwOw0KPiA+ICB9DQo+ID4NCj4gPiArdm9pZCBtb25fZXZlbnRfY29uZmlnX3dyaXRlKHZvaWQg
KmluZm8pIHsNCj4gDQo+IFNob3VsZCB0aGlzIGZ1bmN0aW9uIGJlIHN0YXRpYz8NCg0KU3VyZS4N
Cj4gDQo+ID4gKwlzdHJ1Y3QgbW9uX2NvbmZpZ19pbmZvICptb25faW5mbyA9IGluZm87DQo+ID4g
Kwl1MzIgbXNyX2luZGV4Ow0KPiA+ICsNCj4gPiArCXN3aXRjaCAobW9uX2luZm8tPmV2dGlkKSB7
DQo+ID4gKwljYXNlIFFPU19MM19NQk1fVE9UQUxfRVZFTlRfSUQ6DQo+ID4gKwkJbXNyX2luZGV4
ID0gMDsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgUU9TX0wzX01CTV9MT0NBTF9FVkVOVF9J
RDoNCj4gPiArCQltc3JfaW5kZXggPSAxOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJZGVmYXVsdDoN
Cj4gPiArCQkvKiBOb3QgZXhwZWN0ZWQgdG8gY29tZSBoZXJlICovDQo+ID4gKwkJcmV0dXJuOw0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCXdybXNyKE1TUl9JQTMyX0VWVF9DRkdfQkFTRSArIG1zcl9p
bmRleCwgbW9uX2luZm8tDQo+ID5tb25fY29uZmlnLA0KPiA+IDApOyB9DQo+ID4gKw0KPiA+ICtp
bnQgbWJtX2NvbmZpZ193cml0ZShzdHJ1Y3QgcmR0X3Jlc291cmNlICpyLCBzdHJ1Y3QgcmR0X2Rv
bWFpbiAqZCwNCj4gPiArCQkgICAgIHUzMiBldnRpZCwgdTMyIHZhbCkNCj4gPiArew0KPiA+ICsJ
c3RydWN0IG1vbl9jb25maWdfaW5mbyBtb25faW5mbyA9IHswfTsNCj4gPiArCWNwdW1hc2tfdmFy
X3QgY3B1X21hc2s7DQo+ID4gKwlpbnQgcmV0ID0gMCwgY3B1Ow0KPiA+ICsNCj4gPiArCXJkdF9s
YXN0X2NtZF9jbGVhcigpOw0KPiA+ICsNCj4gPiArCS8qIG1vbl9jb25maWcgY2Fubm90IGJlIG1v
cmUgdGhhbiB0aGUgc3VwcG9ydGVkIHNldCBvZiBldmVudHMgKi8NCj4gPiArCWlmICh2YWwgPiBN
QVhfRVZUX0NPTkZJR19CSVRTKSB7DQo+ID4gKwkJcmR0X2xhc3RfY21kX3B1dHMoIkludmFsaWQg
ZXZlbnQgY29uZmlndXJhdGlvblxuIik7DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICsJY3B1c19yZWFkX2xvY2soKTsNCj4gPiArDQo+ID4gKwlpZiAoIXphbGxv
Y19jcHVtYXNrX3ZhcigmY3B1X21hc2ssIEdGUF9LRVJORUwpKSB7DQo+ID4gKwkJcmR0X2xhc3Rf
Y21kX3B1dHMoImNwdV9tYXNrIGFsbG9jYXRpb24gZmFpbGVkXG4iKTsNCj4gPiArCQlyZXQgPSAt
RU5PTUVNOw0KPiA+ICsJCWdvdG8gZV91bmxvY2s7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyoN
Cj4gPiArCSAqIFJlYWQgdGhlIGN1cnJlbnQgY29uZmlnIHZhbHVlIGZpcnN0LiBJZiBib3RoIGFy
ZSBzYW1lIHRoZW4NCj4gPiArCSAqIHdlIGRvbnQgbmVlZCB0byB3cml0ZSBpdCBhZ2Fpbi4NCj4g
PiArCSAqLw0KPiA+ICsJbW9uX2luZm8uZXZ0aWQgPSBldnRpZDsNCj4gPiArCW1vbmRhdGFfY29u
ZmlnX3JlYWQoZCwgJm1vbl9pbmZvKTsNCj4gPiArCWlmIChtb25faW5mby5tb25fY29uZmlnID09
IHZhbCkNCj4gPiArCQlnb3RvIGVfY3B1bWFzazsNCj4gPiArDQo+ID4gKwltb25faW5mby5tb25f
Y29uZmlnID0gdmFsOw0KPiA+ICsNCj4gPiArCS8qIFBpY2sgYWxsIHRoZSBDUFVzIGluIHRoZSBk
b21haW4gaW5zdGFuY2UgKi8NCj4gPiArCWZvcl9lYWNoX2NwdShjcHUsICZkLT5jcHVfbWFzaykN
Cj4gPiArCQljcHVtYXNrX3NldF9jcHUoY3B1LCBjcHVfbWFzayk7DQo+ID4gKw0KPiA+ICsJLyog
VXBkYXRlIE1TUl9JQTMyX0VWVF9DRkdfQkFTRSBNU1Igb24gYWxsIHRoZSBDUFVzIGluIGNwdV9t
YXNrDQo+ID4gKi8NCj4gPiArCW9uX2VhY2hfY3B1X21hc2soY3B1X21hc2ssIG1vbl9ldmVudF9j
b25maWdfd3JpdGUsICZtb25faW5mbywNCj4gPiAxKTsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJ
ICogV2hlbiBhbiBFdmVudCBDb25maWd1cmF0aW9uIGlzIGNoYW5nZWQsIHRoZSBiYW5kd2lkdGgg
Y291bnRlcnMNCj4gPiArCSAqIGZvciBhbGwgUk1JRHMgYW5kIEV2ZW50cyB3aWxsIGJlIGNsZWFy
ZWQgYnkgdGhlIGhhcmR3YXJlLiBUaGUNCj4gPiArCSAqIGhhcmR3YXJlIGFsc28gc2V0cyBNU1Jf
SUEzMl9RTV9DVFIuVW5hdmFpbGFibGUgKGJpdCA2MikgZm9yDQo+ID4gKwkgKiBldmVyeSBSTUlE
IG9uIHRoZSBuZXh0IHJlYWQgdG8gYW55IGV2ZW50IGZvciBldmVyeSBSTUlELg0KPiA+ICsJICog
U3Vic2VxdWVudCByZWFkcyB3aWxsIGhhdmUgTVNSX0lBMzJfUU1fQ1RSLlVuYXZhaWxhYmxlIChi
aXQgNjIpDQo+ID4gKwkgKiBjbGVhcmVkIHdoaWxlIGl0IGlzIHRyYWNrZWQgYnkgdGhlIGhhcmR3
YXJlLiBDbGVhciB0aGUNCj4gPiArCSAqIG1ibV9sb2NhbCBhbmQgbWJtX3RvdGFsIGNvdW50cyBm
b3IgYWxsIHRoZSBSTUlEcy4NCj4gPiArCSAqLw0KPiA+ICsJbWVtc2V0KGQtPm1ibV9sb2NhbCwg
MCwgc2l6ZW9mKHN0cnVjdCBtYm1fc3RhdGUpICogci0+bnVtX3JtaWQpOw0KPiA+ICsJbWVtc2V0
KGQtPm1ibV90b3RhbCwgMCwgc2l6ZW9mKHN0cnVjdCBtYm1fc3RhdGUpICogci0+bnVtX3JtaWQp
Ow0KPiA+ICsNCj4gPiArZV9jcHVtYXNrOg0KPiA+ICsJZnJlZV9jcHVtYXNrX3ZhcihjcHVfbWFz
ayk7DQo+ID4gKw0KPiA+ICtlX3VubG9jazoNCj4gPiArCWNwdXNfcmVhZF91bmxvY2soKTsNCj4g
PiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICt1bnNpZ25lZCBpbnQg
bW9uX2NvbmZpZ19wYXJzZShzdHJ1Y3QgcmR0X3Jlc291cmNlICpyLCBjaGFyICp0b2ssIHUzMg0K
PiA+ICtldnRpZCkgew0KPiANCj4gU2hvdWxkIHRoaXMgZnVuY3Rpb24gYmUgc3RhdGljPw0KDQpT
dXJlLiBUaGFua3MNCkJhYnUNCj4gDQo+ID4gKwljaGFyICpkb21fc3RyID0gTlVMTCwgKmlkX3N0
cjsNCj4gPiArCXN0cnVjdCByZHRfZG9tYWluICpkOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBkb21f
aWQsIHZhbDsNCj4gPiArCWludCByZXQgPSAwOw0KPiA+ICsNCj4gPiArbmV4dDoNCj4gPiArCWlm
ICghdG9rIHx8IHRva1swXSA9PSAnXDAnKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiAr
CS8qIFN0YXJ0IHByb2Nlc3NpbmcgdGhlIHN0cmluZ3MgZm9yIGVhY2ggZG9tYWluICovDQo+ID4g
Kwlkb21fc3RyID0gc3RyaW0oc3Ryc2VwKCZ0b2ssICI7IikpOw0KPiA+ICsJaWRfc3RyID0gc3Ry
c2VwKCZkb21fc3RyLCAiPSIpOw0KPiA+ICsNCj4gPiArCWlmICghZG9tX3N0ciB8fCBrc3RydG91
bChpZF9zdHIsIDEwLCAmZG9tX2lkKSkgew0KPiA+ICsJCXJkdF9sYXN0X2NtZF9wdXRzKCJNaXNz
aW5nICc9JyBvciBub24tbnVtZXJpYyBkb21haW4gaWRcbiIpOw0KPiA+ICsJCXJldHVybiAtRUlO
VkFMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmICghZG9tX3N0ciB8fCBrc3RydG91bChkb21f
c3RyLCAxNiwgJnZhbCkpIHsNCj4gPiArCQlyZHRfbGFzdF9jbWRfcHV0cygiTWlzc2luZyAnPScg
b3Igbm9uLW51bWVyaWMgZXZlbnQNCj4gPiBjb25maWd1cmF0aW9uIHZhbHVlXG4iKTsNCj4gPiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KGQsICZyLT5kb21haW5zLCBsaXN0KSB7DQo+ID4gKwkJaWYgKGQtPmlkID09IGRvbV9pZCkg
ew0KPiA+ICsJCQlyZXQgPSBtYm1fY29uZmlnX3dyaXRlKHIsIGQsIGV2dGlkLCB2YWwpOw0KPiA+
ICsJCQlpZiAocmV0KQ0KPiA+ICsJCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwkJCWdvdG8gbmV4
dDsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIC1FSU5WQUw7DQo+ID4g
K30NCj4gPiArDQo+ID4gK3N0YXRpYyBzc2l6ZV90IG1ibV90b3RhbF9jb25maWdfd3JpdGUoc3Ry
dWN0IGtlcm5mc19vcGVuX2ZpbGUgKm9mLA0KPiA+ICsJCQkJICAgICAgY2hhciAqYnVmLCBzaXpl
X3QgbmJ5dGVzLCBsb2ZmX3Qgb2ZmKSB7DQo+ID4gKwlzdHJ1Y3QgcmR0X3Jlc291cmNlICpyID0g
b2YtPmtuLT5wYXJlbnQtPnByaXY7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCS8qIFZh
bGlkIGlucHV0IHJlcXVpcmVzIGEgdHJhaWxpbmcgbmV3bGluZSAqLw0KPiA+ICsJaWYgKG5ieXRl
cyA9PSAwIHx8IGJ1ZltuYnl0ZXMgLSAxXSAhPSAnXG4nKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFM
Ow0KPiA+ICsNCj4gPiArCXJkdF9sYXN0X2NtZF9jbGVhcigpOw0KPiA+ICsNCj4gPiArCWJ1Zltu
Ynl0ZXMgLSAxXSA9ICdcMCc7DQo+ID4gKw0KPiA+ICsJcmV0ID0gbW9uX2NvbmZpZ19wYXJzZShy
LCBidWYsIFFPU19MM19NQk1fVE9UQUxfRVZFTlRfSUQpOw0KPiA+ICsNCj4gPiArCXJldHVybiBy
ZXQgPzogbmJ5dGVzOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAvKiByZHRncm91cCBpbmZvcm1hdGlv
biBmaWxlcyBmb3Igb25lIGNhY2hlIHJlc291cmNlLiAqLyAgc3RhdGljDQo+ID4gc3RydWN0IHJm
dHlwZSByZXNfY29tbW9uX2ZpbGVzW10gPSB7DQo+ID4gIAl7DQo+ID4gQEAgLTE1OTQsNiArMTcz
Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgcmZ0eXBlIHJlc19jb21tb25fZmlsZXNbXSA9IHsNCj4gPiAg
CQkubW9kZQkJPSAwNjQ0LA0KPiA+ICAJCS5rZl9vcHMJCT0gJnJkdGdyb3VwX2tmX3NpbmdsZV9v
cHMsDQo+ID4gIAkJLnNlcV9zaG93CT0gbWJtX3RvdGFsX2NvbmZpZ19zaG93LA0KPiA+ICsJCS53
cml0ZQkJPSBtYm1fdG90YWxfY29uZmlnX3dyaXRlLA0KPiA+ICAJfSwNCj4gPiAgCXsNCj4gPiAg
CQkubmFtZQkJPSAibWJtX2xvY2FsX2NvbmZpZyIsDQo+ID4NCj4gDQo+IFRoYW5rcy4NCj4gDQo+
IC1GZW5naHVhDQo=
