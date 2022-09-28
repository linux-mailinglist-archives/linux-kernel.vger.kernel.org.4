Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A5E5EDD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiI1M4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiI1M4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:56:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BCA4DB65;
        Wed, 28 Sep 2022 05:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffEdhvEC3kVaQyULdPvoI1RnmzEpK0+AgqZJuleWTTYmtVSKk8p/RKHXN/b+UadtHrNqlVi+o7LEFhV/TqB2A534Y6vgqBUPQ9Tp3Vb7iyDrgVi4vTsjTlKQNPTBI/GcmwJo3bBFQ4I8nD4DWpf4sWP8m9wOZCKbRPH4yOSaT/CGEMVgzn8HRVVaeSIqJ8C0IkGbYV241cSBQ/se9UCL6s3h8dDEDeTi+d0FkZHCXLPD3hw2Wgx5KJ9tsNJoIxDcZ+tsDuxs1MI0C8aXZmXip4kqGwyhhfEos8dXOobIHqDkWv+DritVcXi8bLbxuhdF/BnwTABeWjFBXKCKsXocJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF6s79gXdyDdExTWuYSUcTXmn8FZdnoM6O4gD3luQmg=;
 b=Tic1JC3VKOwgSf31dZLTZQJjS35WtxbD4w7Agh07GGhcqUcRIEvb5CFp3SFn7z8baik973M1ZZ4pLfh7NHgppn7eyZviuFB9Eln83+LtsEVQehRGZDS0vM28g4tzDaRkVZiX+U0eWl1DscUKca6hd6yO9fDlmesCGoLk791XQAEZh/gIcganS4O/cMZ6pxoa2dWYeHySmzlrDGRwdttlAbSVdVCRPpE2SjVZgBcZf3bsq6ZMnATAY2nhSpJO215AFlHYSVvpfSFAQKFJtZCaeDn9R58EEjyfDz/YroCPn6mx+DxgJCZp7R6GWxaMGVOxbVudpkoJ/815E06cRxIiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF6s79gXdyDdExTWuYSUcTXmn8FZdnoM6O4gD3luQmg=;
 b=WuKHrlQNuB7wsFbwRGMLf8GQb+R2uYB8kaXsr5/Xj6ANe2FfAthe+pS3WBwn+PVN5iELUoDNaHAjKgCo8/+DOJcFpN2/fyKW9/voTUFnxT+RgYF83/y/sg538Snr6TOo2GXKfxIldoUhtIaLgbvOvFnVrb+PKLvG2PF6l/kus8U=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Wed, 28 Sep
 2022 12:56:26 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e%3]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 12:56:25 +0000
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
Subject: RE: [PATCH v5 06/12] x86/resctrl: Introduce data structure to support
 monitor configuration
Thread-Topic: [PATCH v5 06/12] x86/resctrl: Introduce data structure to
 support monitor configuration
Thread-Index: AQHY0q9x9XMDQbRa+UWmRA8Bs1Iq4q3z2p+AgADzETA=
Date:   Wed, 28 Sep 2022 12:56:25 +0000
Message-ID: <MW3PR12MB4553C14CBF929B68413D4A3B95549@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431037370.373387.14792678048042598706.stgit@bmoger-ubuntu>
 <IA1PR11MB6097ACA784844B2815AD5A529B559@IA1PR11MB6097.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6097ACA784844B2815AD5A529B559@IA1PR11MB6097.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-28T12:55:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=eceb38f1-a440-4bd2-952a-0572deba2ec9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-28T12:56:24Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: e09af66e-3fb8-4f6d-a16b-72353c531881
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|DM4PR12MB6661:EE_
x-ms-office365-filtering-correlation-id: 4930f893-e403-4839-9ed2-08daa150da35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yvs2jeVXTCWyUcO7Ym40D08iDSdue8nq2arUyDUfFDCDuSdcveKB7mb1118p5bOi03SCX3Wj6cLPyKaZ2xNMEYWCEA6aq++Ch/bkP78ZzWM8Wd8Nn/PtHv3WMToYVaqmZcJJWp29JFk1EjW4a31JnE4XppO8hX3HZvin53u4J37d/zyYPfOJIl8p7ksGiX4oPe+JKnfH9Pau32sZWPRvaCRYZwh7R4J66q4Q5MhqdZZKIOeo2rEPG0ZB7CXzutqwoHTUJ1TPNFe//ijA2svJeofQgwp/10neUy53/dcagUB0iOWdiNWGFUNKRs6KF4UcvSMyp9d8AmsCW7L//KPdT7uGqVhj6kD0iY3DV15cf8EKOhJXrWFbOZgCgPeeR8R4tbfREmlH/ImsCLLnyzzD6ytKZKepKDuXzh1dknISQI+4VVtw2QivPPFk9+P2puWkfaHf1V0nUP1z5NHvSKc2bZx979qJUoUv76d9uHcBG2YIfcsFO4YILGUFRQPefVG67H/lrYVKQAr1tSJ8/ZAeUVBjmlYBClxeXyWu6wVa8yLj3epzfoo5srGS5n4CKCv/afZY4Uxg9QDtOJogkAxDeNHvqXu74h3gbkmEV4PcMSoFZ3yq5JwPyW1OqHTDEt26BdLk7TxL296WkK8fY2BctCycAtA6Y2T16Nfp+kV2wOK9epkiC+mFUm1bH5TZ89RvTExFPIGy9gP2NCjfZ/Smvw5BfkjsbidFiDH0S5eAdxbYbRVy4EohBAxs69hzKRMGPfK4bBETbXkIXiCeVgzmNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(38070700005)(52536014)(7416002)(5660300002)(8936002)(71200400001)(26005)(122000001)(66446008)(7696005)(9686003)(110136005)(54906003)(55016003)(478600001)(76116006)(66556008)(186003)(4326008)(6506007)(83380400001)(316002)(8676002)(53546011)(41300700001)(66476007)(33656002)(64756008)(86362001)(66946007)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGJjLzloMTM3Nm1sbzhYSk9Yd285Vmx4aDJLMVJvazJ5bnNXa3NwMUdVc3gr?=
 =?utf-8?B?RmorNElvL2w3UW1nd0ozSnQ3RnlYbGtCV1d6RThVMGxRa3VJNm94ZmFva0ta?=
 =?utf-8?B?VWw1a1F4SEpaTm9qNWhsbWpLVlQ0RzRSZFcyeEVUZmd5K3g3Q2ZaT1dJTGlP?=
 =?utf-8?B?NkZaMEc5OVZjbktkM2ROWTdHVGhIU2ZGOXBHU2UvdmxmbzdPc1A1cEhNQTlP?=
 =?utf-8?B?SllxenJkMXp2V3NtMUVTZ3lpWG9sMjdxd2NhdEgvb2puTlViTU05MDJCejRm?=
 =?utf-8?B?cW1oTkRwTGMxbGNvd05pSmh3ZlExQUlvM0M4R0hFdWd1bE9lbEVDcFlQWVY5?=
 =?utf-8?B?UXhmdVA0amt3bUlwVFNWZVZiSEJuZGg4ZTl2bmJHV0FxMXNjSlhoUHNPOGFk?=
 =?utf-8?B?blp5T1FYMGI5U0hFamZGT2RJWDFvUStQWmhjeVhwTVNKbCtBNzZ6YWhEaHhI?=
 =?utf-8?B?dldOOWNWelhoeUlhR3dJM2krUUpnc2JxUExsYVZCeEdmVm0vY0JWcUx5S1k0?=
 =?utf-8?B?bGhIRHNnQUNkMHJMRmYwMzBNQVpiY3IrTEtVUE9JQWptV1RrWlpEdGpRa05V?=
 =?utf-8?B?MW1TTDhjdHRpRi9hbjkyS1FJV1Ezay9jajl6WlJVSDdZS1VrUVFmNDlQaklR?=
 =?utf-8?B?Y2J3QkNaa3BaNS81ZFhXejNQaDlYbmJuSFFJaHBsMjFMdmxhRWlaczRxWngx?=
 =?utf-8?B?RThudmVLZGR4dSt2Z2RUdXcrUWlUN1NHRWlOZUo0akdlMnAzSUViQnQ1Vktt?=
 =?utf-8?B?TmJlUFRiNlhWSlB6dmlOdTlGT0s5RlM0UlJvR0JtUnRRWFNkb1N1R3Y3dlJ3?=
 =?utf-8?B?N1RXTXNUMmluVEF5Skljd2c0YlhIS3dpbStnYlM4YXp2TjdmZ0w2eUppcXVL?=
 =?utf-8?B?Vkg4aUE2RjRicGFvM2ppbmVHSVVkbDdGeXZZaENRMHVvVjNyNTZUNm1BaE9V?=
 =?utf-8?B?MVBEbFZTU3FCY3ErRjVQMkFwanJkelV4VVRON3QyNGRvczhHNlVTdmRjMmJG?=
 =?utf-8?B?NGdXbjNqazFBejJNcUhwcE1CTHZMRVdHUjZJMHdpYnIvRVp3UythNjB5QTdi?=
 =?utf-8?B?b1ZIQ1cwTnFkeUVqWWNzZmlRdys2RDlvTkN5M2dRNU5WTy8ybFpObDVuSUh2?=
 =?utf-8?B?WEx3WjN5ck5veUpZRURYM1lZSXU4bFB3emVwZjh0R3I0Z1dMWDU1WUdkUXJT?=
 =?utf-8?B?bEgxTjZzNU9EOGt0elltbzJZMTJudnhRREtHemQzdXVnU3BHTEVhMHJtbE1x?=
 =?utf-8?B?ZFBzYVA0NXhTK21tcUxSclN0aHFWeEg3dmVhMXV2QWhFb3dJUnJNUW9IN3Bw?=
 =?utf-8?B?Ykl2NXIwTHo4Y3UxWmZEektoZTB1aUNvTnFlUzhhU1ZvREh5bU4yd3BrVU02?=
 =?utf-8?B?K05lK2J2RWZZNnl2RW1IQ09SUXRlbVlCZnBBUGh4Sy8wTnZWZG5jSDlleUFM?=
 =?utf-8?B?NWpOZjdZcENnVFVJQkYwckZoTEVEVytNY0Ztc3dLb3p3R0dnRmtoZyszNlY0?=
 =?utf-8?B?V1BzM0EzWjNxZjVrdVBBMVhXSjI2ZmE4WjhCNlRjZVlKSXhCaE1CZGhIdmtU?=
 =?utf-8?B?WEExT3B5ZkRBOW5NaFhzQkNBL1ZtaWNqaXBIU2Nub0JxYm1GTmp1TXpLWklw?=
 =?utf-8?B?YjluMTlqQ1dmUWRXWE1ZMW5MeWxpOXg3OVFRTTB5Nmp1TXBIOGYvdmRpOHJV?=
 =?utf-8?B?WmNsdGFMSjVXdVl2ZHZ2UlNDYkxTLzRxdU5DbU5yZWpIcUVHZ0dXWGh3TGR3?=
 =?utf-8?B?YTdLL21WWnllYmZQblVhaWV0eXoySnF0QXowY1doVEx2TnEyQ3FLRXRqS1c4?=
 =?utf-8?B?R2J5SmxIMlRxam9Jd1h3NXVkUlFod3Q3Wm0rMFRrUTJHTUVxYjdSZWpsNStZ?=
 =?utf-8?B?R2tUU1FKMkhJdjRtK25Uam5JNUk1dnFJTzUwTmw0NnFWQkRUT1hEVUtFOGRO?=
 =?utf-8?B?aERzZTlOdERycy81THMyYkx6anoxcUIrV1k0a0Y4OE41Y3lpZERvREVrQkZU?=
 =?utf-8?B?SnB2anluTlk3U3lrbEJWUWphQ0t2V05rZDgzRnBRUHZKUGIyOC9UdXJ6ZmR0?=
 =?utf-8?B?WWwwV096Y2Fpb1lxMGFmMjNOLzlIdS9Cd040YUNGRVN6Y1B6b0wrenJhb21E?=
 =?utf-8?Q?5QXc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4930f893-e403-4839-9ed2-08daa150da35
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 12:56:25.6280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FNC0eGL569mBsVJzbJ4ce63zIvPfhMgOeFP1yft13rtHGcjcldNlpHy/Tu62gTV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEZlbmdodWEsDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWXUsIEZlbmdodWEgPGZlbmdodWEueXVA
aW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjIgNToyNSBQTQ0K
PiBUbzogTW9nZXIsIEJhYnUgPEJhYnUuTW9nZXJAYW1kLmNvbT47IGNvcmJldEBsd24ubmV0OyBD
aGF0cmUsIFJlaW5ldHRlDQo+IDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPjsgdGdseEBsaW51
dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOw0KPiBicEBhbGllbjguZGUNCj4gQ2M6IGRhdmUu
aGFuc2VuQGxpbnV4LmludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmc7IGhwYUB6eXRvci5jb207DQo+
IHBhdWxtY2tAa2VybmVsLm9yZzsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgcXVpY19uZWVy
YWp1QHF1aWNpbmMuY29tOw0KPiByZHVubGFwQGluZnJhZGVhZC5vcmc7IGRhbWllbi5sZW1vYWxA
b3BlbnNvdXJjZS53ZGMuY29tOw0KPiBzb25nbXVjaHVuQGJ5dGVkYW5jZS5jb207IHBldGVyekBp
bmZyYWRlYWQub3JnOyBqcG9pbWJvZUBrZXJuZWwub3JnOw0KPiBwYm9uemluaUByZWRoYXQuY29t
OyBCYWUsIENoYW5nIFNlb2sgPGNoYW5nLnNlb2suYmFlQGludGVsLmNvbT47DQo+IHBhd2FuLmt1
bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsgam1hdHRzb25AZ29vZ2xlLmNvbTsNCj4gZGFuaWVs
LnNuZWRkb25AbGludXguaW50ZWwuY29tOyBEYXMxLCBTYW5kaXBhbiA8U2FuZGlwYW4uRGFzQGFt
ZC5jb20+Ow0KPiBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgamFtZXMubW9yc2VA
YXJtLmNvbTsgbGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGJhZ2FzZG90bWVAZ21haWwuY29tOw0KPiBFcmFuaWFuLCBTdGVwaGFuZSA8
ZXJhbmlhbkBnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHY1IDA2LzEyXSB4ODYv
cmVzY3RybDogSW50cm9kdWNlIGRhdGEgc3RydWN0dXJlIHRvIHN1cHBvcnQNCj4gbW9uaXRvciBj
b25maWd1cmF0aW9uDQo+IA0KPiBIaSwgQmFidSwNCj4gDQo+ID4gQWRkIGNvdXBsZSBvZiBmaWVs
ZHMgaW4gbW9uX2V2dCB0byBzdXBwb3J0IEJhbmR3aWR0aCBNb25pdG9yaW5nIEV2ZW50DQo+ID4g
Q29uZmlndXJhdGlvIChCTUVDKSBhbmQgYWxzbyB1cGRhdGUgdGhlICJtb25fZmVhdHVyZXMiLg0K
PiANCj4gcy9Db25maWd1cmF0aW8vIENvbmZpZ3VyYXRpb24vDQoNClN1cmUuDQo+IA0KPiA+DQo+
ID4gVGhlIHN5c2ZzIGZpbGUgIm1vbl9mZWF0dXJlcyIgd2lsbCBkaXNwbGF5IHRoZSBtb25pdG9y
IGNvbmZpZ3VyYXRpb24gaWYNCj4gc3VwcG9ydGVkLg0KPiA+DQo+ID4gQmVmb3JlIHRoZSBjaGFu
Z2UuDQo+ID4gCSRjYXQgL3N5cy9mcy9yZXNjdHJsL2luZm8vTDNfTU9OL21vbl9mZWF0dXJlcw0K
PiA+IAlsbGNfb2NjdXBhbmN5DQo+ID4gCW1ibV90b3RhbF9ieXRlcw0KPiA+IAltYm1fbG9jYWxf
Ynl0ZXMNCj4gPg0KPiA+IEFmdGVyIHRoZSBjaGFuZ2UgaWYgQk1FQyBpcyBzdXBwb3J0ZWQuDQo+
ID4gCSRjYXQgL3N5cy9mcy9yZXNjdHJsL2luZm8vTDNfTU9OL21vbl9mZWF0dXJlcw0KPiA+IAls
bGNfb2NjdXBhbmN5DQo+ID4gCW1ibV90b3RhbF9ieXRlcw0KPiA+IAltYm1fdG90YWxfY29uZmln
DQo+ID4gCW1ibV9sb2NhbF9ieXRlcw0KPiA+IAltYm1fbG9jYWxfY29uZmlnDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlLmMgICAgIHwgICAgMyArKy0NCj4g
PiAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmggfCAgICA2ICsrKysrLQ0K
PiA+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvbW9uaXRvci5jICB8ICAgIDkgKysrKysr
KystDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jIHwgICAgNSAr
KysrLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2Nv
cmUuYw0KPiA+IGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYw0KPiA+IGluZGV4
IDU2Yzk2NjA3MjU5Yy4uNTEzZTZhMDBmNThlIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tl
cm5lbC9jcHUvcmVzY3RybC9jb3JlLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jl
c2N0cmwvY29yZS5jDQo+ID4gQEAgLTg0OSw2ICs4NDksNyBAQCBzdGF0aWMgX19pbml0IGJvb2wg
Z2V0X3JkdF9hbGxvY19yZXNvdXJjZXModm9pZCkNCj4gPiBzdGF0aWMgX19pbml0IGJvb2wgZ2V0
X3JkdF9tb25fcmVzb3VyY2VzKHZvaWQpICB7DQo+ID4gIAlzdHJ1Y3QgcmR0X3Jlc291cmNlICpy
ID0NCj4gPiAmcmR0X3Jlc291cmNlc19hbGxbUkRUX1JFU09VUkNFX0wzXS5yX3Jlc2N0cmw7DQo+
ID4gKwlib29sIG1vbl9jb25maWd1cmFibGUgPSByZHRfY3B1X2hhcyhYODZfRkVBVFVSRV9CTUVD
KTsNCj4gPg0KPiA+ICAJaWYgKHJkdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0NRTV9PQ0NVUF9MTEMp
KQ0KPiA+ICAJCXJkdF9tb25fZmVhdHVyZXMgfD0gKDEgPDwgUU9TX0wzX09DQ1VQX0VWRU5UX0lE
KTsgQEAgLQ0KPiA+IDg2MCw3ICs4NjEsNyBAQCBzdGF0aWMgX19pbml0IGJvb2wgZ2V0X3JkdF9t
b25fcmVzb3VyY2VzKHZvaWQpDQo+ID4gIAlpZiAoIXJkdF9tb25fZmVhdHVyZXMpDQo+ID4gIAkJ
cmV0dXJuIGZhbHNlOw0KPiA+DQo+ID4gLQlyZXR1cm4gIXJkdF9nZXRfbW9uX2wzX2NvbmZpZyhy
KTsNCj4gPiArCXJldHVybiAhcmR0X2dldF9tb25fbDNfY29uZmlnKHIsIG1vbl9jb25maWd1cmFi
bGUpOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIF9faW5pdCB2b2lkIF9fY2hlY2tfcXVpcmtz
X2ludGVsKHZvaWQpIGRpZmYgLS1naXQNCj4gPiBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3Ry
bC9pbnRlcm5hbC5oDQo+ID4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvaW50ZXJuYWwu
aA0KPiA+IGluZGV4IGMwNDlhMjc0MzgzYy4uNGQwM2Y0NDNiMzUzIDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9pbnRlcm5hbC5oDQo+ID4gKysrIGIvYXJjaC94
ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmgNCj4gPiBAQCAtNzIsMTEgKzcyLDE1IEBA
IERFQ0xBUkVfU1RBVElDX0tFWV9GQUxTRShyZHRfbW9uX2VuYWJsZV9rZXkpOw0KPiA+ICAgKiBz
dHJ1Y3QgbW9uX2V2dCAtIEVudHJ5IGluIHRoZSBldmVudCBsaXN0IG9mIGEgcmVzb3VyY2UNCj4g
PiAgICogQGV2dGlkOgkJZXZlbnQgaWQNCj4gPiAgICogQG5hbWU6CQluYW1lIG9mIHRoZSBldmVu
dA0KPiA+ICsgKiBAY29uZmlndXJhYmxlOgl0cnVlIGlmIHRoZSBldmVudCBpcyBjb25maWd1cmFi
bGUNCj4gPiArICogQGNvbmZpZ19uYW1lOglzeXNmcyBmaWxlIG5hbWUgb2YgdGhlIGV2ZW50IGlm
IGNvbmZpZ3VyYWJsZQ0KPiA+ICAgKiBAbGlzdDoJCWVudHJ5IGluICZyZHRfcmVzb3VyY2UtPmV2
dF9saXN0DQo+ID4gICAqLw0KPiA+ICBzdHJ1Y3QgbW9uX2V2dCB7DQo+ID4gIAl1MzIJCQlldnRp
ZDsNCj4gPiAgCWNoYXIJCQkqbmFtZTsNCj4gPiArCWJvb2wJCQljb25maWd1cmFibGU7DQo+ID4g
KwljaGFyCQkJKmNvbmZpZ19uYW1lOw0KPiANCj4gU2VlbXMgY29uZmlnX25hbWUgaXMgb25seSB1
c2VkIHRvIGJlIHNob3duIGluIG1vbl9mZWF0dXJlcy4gSXMgaXQgbmVjZXNzYXJ5IHRvDQo+IGhh
dmUgdGhlIGZpZWxkPw0KDQpTdXJlLiBJIGNhbiByZW1vdmUgaXQuDQoNCj4gDQo+ID4gIAlzdHJ1
Y3QgbGlzdF9oZWFkCWxpc3Q7DQo+ID4gIH07DQo+ID4NCj4gPiBAQCAtNTI5LDcgKzUzMyw3IEBA
IGludCBjbG9zaWRzX3N1cHBvcnRlZCh2b2lkKTsgIHZvaWQgY2xvc2lkX2ZyZWUoaW50DQo+ID4g
Y2xvc2lkKTsgaW50IGFsbG9jX3JtaWQodm9pZCk7ICB2b2lkIGZyZWVfcm1pZCh1MzIgcm1pZCk7
IC1pbnQNCj4gPiByZHRfZ2V0X21vbl9sM19jb25maWcoc3RydWN0IHJkdF9yZXNvdXJjZSAqcik7
DQo+ID4gK2ludCByZHRfZ2V0X21vbl9sM19jb25maWcoc3RydWN0IHJkdF9yZXNvdXJjZSAqciwg
Ym9vbCBjb25maWd1cmFibGUpOw0KPiA+ICB2b2lkIG1vbl9ldmVudF9jb3VudCh2b2lkICppbmZv
KTsNCj4gPiAgaW50IHJkdGdyb3VwX21vbmRhdGFfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZv
aWQgKmFyZyk7ICB2b2lkDQo+ID4gcm1kaXJfbW9uZGF0YV9zdWJkaXJfYWxscmR0Z3JwKHN0cnVj
dCByZHRfcmVzb3VyY2UgKnIsIGRpZmYgLS1naXQNCj4gPiBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
cmVzY3RybC9tb25pdG9yLmMNCj4gPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25p
dG9yLmMNCj4gPiBpbmRleCBlYWYyNWEyMzRmZjUuLmRjOTdhYTdhM2IzZCAxMDA2NDQNCj4gPiAt
LS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvbW9uaXRvci5jDQo+ID4gKysrIGIvYXJj
aC94ODYva2VybmVsL2NwdS9yZXNjdHJsL21vbml0b3IuYw0KPiA+IEBAIC02NTYsMTEgKzY1Niwx
MyBAQCBzdGF0aWMgc3RydWN0IG1vbl9ldnQgbGxjX29jY3VwYW5jeV9ldmVudCA9IHsNCj4gPiBz
dGF0aWMgc3RydWN0IG1vbl9ldnQgbWJtX3RvdGFsX2V2ZW50ID0gew0KPiA+ICAJLm5hbWUJCT0g
Im1ibV90b3RhbF9ieXRlcyIsDQo+ID4gIAkuZXZ0aWQJCT0gUU9TX0wzX01CTV9UT1RBTF9FVkVO
VF9JRCwNCj4gPiArCS5jb25maWdfbmFtZQk9ICJtYm1fdG90YWxfY29uZmlnIiwNCj4gPiAgfTsN
Cj4gDQo+IFN0cnVjdCBtb25fZXZ0IG1ibV90b3RhbF9jb25maWdfZXZlbnQgPSB7DQo+IAkubmFt
ZSA9ICJtYm1fdG90YWxfY29uZmlnIiwNCj4gDQo+ID4NCj4gPiAgc3RhdGljIHN0cnVjdCBtb25f
ZXZ0IG1ibV9sb2NhbF9ldmVudCA9IHsNCj4gPiAgCS5uYW1lCQk9ICJtYm1fbG9jYWxfYnl0ZXMi
LA0KPiA+ICAJLmV2dGlkCQk9IFFPU19MM19NQk1fTE9DQUxfRVZFTlRfSUQsDQo+ID4gKwkuY29u
ZmlnX25hbWUJPSAibWJtX2xvY2FsX2NvbmZpZyIsDQo+ID4gIH07DQo+ID4NCj4gPiAgLyoNCj4g
PiBAQCAtNjgyLDcgKzY4NCw3IEBAIHN0YXRpYyB2b2lkIGwzX21vbl9ldnRfaW5pdChzdHJ1Y3Qg
cmR0X3Jlc291cmNlICpyKQ0KPiA+ICAJCWxpc3RfYWRkX3RhaWwoJm1ibV9sb2NhbF9ldmVudC5s
aXN0LCAmci0+ZXZ0X2xpc3QpOyAgfQ0KPiA+DQo+ID4gLWludCByZHRfZ2V0X21vbl9sM19jb25m
aWcoc3RydWN0IHJkdF9yZXNvdXJjZSAqcikNCj4gPiAraW50IHJkdF9nZXRfbW9uX2wzX2NvbmZp
ZyhzdHJ1Y3QgcmR0X3Jlc291cmNlICpyLCBib29sIGNvbmZpZ3VyYWJsZSkNCj4gPiAgew0KPiA+
ICAJdW5zaWduZWQgaW50IG1ibV9vZmZzZXQgPQ0KPiA+IGJvb3RfY3B1X2RhdGEueDg2X2NhY2hl
X21ibV93aWR0aF9vZmZzZXQ7DQo+ID4gIAlzdHJ1Y3QgcmR0X2h3X3Jlc291cmNlICpod19yZXMg
PSByZXNjdHJsX3RvX2FyY2hfcmVzKHIpOyBAQCAtNzE0LDYNCj4gPiArNzE2LDExIEBAIGludCBy
ZHRfZ2V0X21vbl9sM19jb25maWcoc3RydWN0IHJkdF9yZXNvdXJjZSAqcikNCj4gPiAgCWlmIChy
ZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPg0KPiA+ICsJaWYgKGNvbmZpZ3VyYWJsZSkgew0K
PiA+ICsJCW1ibV90b3RhbF9ldmVudC5jb25maWd1cmFibGUgPSB0cnVlOw0KPiA+ICsJCW1ibV9s
b2NhbF9ldmVudC5jb25maWd1cmFibGUgPSB0cnVlOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCWwz
X21vbl9ldnRfaW5pdChyKTsNCj4gPg0KPiA+ICAJci0+bW9uX2NhcGFibGUgPSB0cnVlOw0KPiA+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+
IGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gPiBpbmRleCAwNGI1
MTliY2E1MGQuLjgzNGE1NWQ3OGUzZiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVz
Y3RybC9yZHRncm91cC5jDQo+ID4gQEAgLTEwMDEsOCArMTAwMSwxMSBAQCBzdGF0aWMgaW50IHJk
dF9tb25fZmVhdHVyZXNfc2hvdyhzdHJ1Y3QNCj4gPiBrZXJuZnNfb3Blbl9maWxlICpvZiwNCj4g
PiAgCXN0cnVjdCByZHRfcmVzb3VyY2UgKnIgPSBvZi0+a24tPnBhcmVudC0+cHJpdjsNCj4gPiAg
CXN0cnVjdCBtb25fZXZ0ICptZXZ0Ow0KPiA+DQo+ID4gLQlsaXN0X2Zvcl9lYWNoX2VudHJ5KG1l
dnQsICZyLT5ldnRfbGlzdCwgbGlzdCkNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnkobWV2dCwg
JnItPmV2dF9saXN0LCBsaXN0KSB7DQo+ID4gIAkJc2VxX3ByaW50ZihzZXEsICIlc1xuIiwgbWV2
dC0+bmFtZSk7DQo+ID4gKwkJaWYgKG1ldnQtPmNvbmZpZ3VyYWJsZSkNCj4gPiArCQkJc2VxX3By
aW50ZihzZXEsICIlc1xuIiwgbWV2dC0+Y29uZmlnX25hbWUpOw0KPiANCj4gSWYgImNvbmZpZ19u
YW1lIiBpcyBub3QgZGVmaW5lZCwgaXQgY291bGQgYmU6DQo+IAkJSWYgKG1ldnQtPmNvbmZpZ3Vy
YWJsZSkNCj4gCQkJU2VxX3ByaW50ZihzZXEsICIlc19jb25maWdcbiIsIG1ldnQtPm5hbWUpOw0K
PiANClN1cmUuIFRoYW5rcyANCkJhYnUNCg==
