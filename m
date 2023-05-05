Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92376F8741
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjEERJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjEERJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:09:42 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5329A1990C;
        Fri,  5 May 2023 10:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSHxc5s4sRd1Iz2EkdtY0i1po1EGg9xL9ViypKFfy3eC658TNAOlFPA6+ah6TlcoGUI5BSlTVhesicYWyg0NjXH84GQPgJ6w96Ssk0IcybZAKESD/seccDmfTx0CroMuV7+oyuI9yMUQZrdUaFVKwjGMvwYWr9ueBrq/hnWlQkDqBWqlQ5NwH4Y2h/6OxUrHizL2NImKOYYSrEs//naHehoXH0Jrrg42UlV6MM0GFirimwTF/VfbscTW29f4trsl+6bEDqSf8HMzsoH4OLEJYWt9v3+UdctnfMh8ke/plghdzSNVoqb8hl8nZrTHKorGhGPOYBkwQ7996gbgY9dqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/IjbY5f/6vf5O47YcCxn5HQluIeFJSslAVQ63beW84=;
 b=X43g/t0d4x3ScsEoxMkkROKEsayNizJmPFr1ArSPgNn5Nw/khPp5998bzrnZvviRRcLLOlZi2lbMvkwfe3rFpJo4mZRhjPcHmmVn91gcLkt7iKyTCmQhYUCK1dNUadd1CesF5nOfY40UA0cRcyTuZS8Ng2V6A7nWOJAR5K0IpWe9KackR7I13qN+DgkkDDCm4JMBmguy87K6FFU7LDQUGxqlVGtIlRnvdErXRiYQkcNhZeuYctas1Ps2jYjLm3/5jdvkLid2dLx17uXYgRkufETs79PgjqVRpQG1IU72fBnq+CYaMuttuPr7tXbriJwScjZj2truI3LD99GEDI0ldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/IjbY5f/6vf5O47YcCxn5HQluIeFJSslAVQ63beW84=;
 b=YltVn7ubeTiAzjwX8sbrV+3ltfUxUl++alb+uUuBxdwVjOsJsr7xq+YLbT/6mDPlkT5vTRkMBbWd+3E5L3UReXmOc6Ujkoffaw2BlqAOLdFE8Xn1Exj9Po78Ix8VTGGUm+k0g2CsPcQYGwC6gnlpCKYyzBqH0pQGg6v6wFVNopU=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8534.namprd12.prod.outlook.com (2603:10b6:610:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:09:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 17:09:37 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v4 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Thread-Topic: [PATCH v4 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Thread-Index: AQHZcYUkcs1a0ushqUSSQIeK80u5hq9KkZYAgAFn4/A=
Date:   Fri, 5 May 2023 17:09:37 +0000
Message-ID: <MW3PR12MB4553BAD1A9390D518D9919A895729@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177444676.1758847.11474266921067437724.stgit@bmoger-ubuntu>
 <51a1b46e-9162-83bc-29df-8a154059f847@intel.com>
In-Reply-To: <51a1b46e-9162-83bc-29df-8a154059f847@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-05T17:09:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=adb7db3a-a77b-43c8-a86a-2628c8355ed8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-05T17:09:35Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 26bdb682-7b3b-481e-984c-be091dc36e65
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|CH3PR12MB8534:EE_
x-ms-office365-filtering-correlation-id: 7fef1fe8-0400-4271-3989-08db4d8b81a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SaIPZKPanJTFVdwIClLuP7niL2r03BX87BxS+6QfOz32+FRzQAkn5ukY3HOmVjBT5k74SfPUpFr+cQZXq97GU4MFmbPeFnViEwk78hxLqf/s9QMCDjOklBMqLtLF9UBeLEvGjAG5mu+fWh8+UVx16fxsf9Y71QzrkItVI4L0yg1AyYPKay8dJfB6PmMmR0tu+VXp74nrxauGCgaOp9U37FJA5OYAdWT6eIIhc/KOjg5RzIu4h5sFUK6h/3xFDzDDcWVatjWzBhwQc3yTrXfuD29lRoLZKhmeug2VT0K8ZGLDrIufLurJ+ZnlIMaCJmgOztpHTSDGL4Gdvl0UhjUbhMMXu7TjoU3lgfWtwE0q8r1jo/QrxLmEh+osm+1UftZBLC3d950Ve8c6segYiEePENXIktH8Qzs0cCHVL0diljq4qn7vOkTsz56pkj4feaHOL+yfE2bzAiTc5qn0Ue6PwP/nuDPXONpU7+Z2R3HDCygb/bDtufd057chpPPsVxp1PxkYYMStWJvW37Fhcj5GtapB8jcKKPZhueZWyTLsAyJvf4gkdLOUo8lhIjsTS+AA06K/FxZG1R5l7Lt+AwlEn+L0nDyvW19RuoyqMe+QAAA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(66899021)(55016003)(8936002)(26005)(9686003)(6506007)(8676002)(7416002)(7406005)(53546011)(2906002)(83380400001)(41300700001)(4326008)(76116006)(7696005)(71200400001)(478600001)(316002)(52536014)(5660300002)(186003)(66446008)(110136005)(66476007)(66556008)(66946007)(54906003)(64756008)(86362001)(38070700005)(38100700002)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVZsS0Z1YUpmQ2VqUTRLc05yVHdnZldpWDZhdFd0QWVsYkplRGMzdDBsL29P?=
 =?utf-8?B?YnhydUFYakFZd3o3di95OFI2dUxqd1Brd01HQjd2WUQ4TmprUUNSdHFKaEJY?=
 =?utf-8?B?OGFIeTVEVSswVk9YTGhraEhYRVhlcHNZWE9vakZKcHJqV2FJUjVNdFlXRjIy?=
 =?utf-8?B?R1lrVWV6MmJ2UE9nK0NnVFlvZnNVeDdzdXViamR1aWx4enh5Tm1ubmNvRXkw?=
 =?utf-8?B?YktSc1hDSlNNM1l5WVRMZGV3Z2FnTGFQdXVJWkt2eGF5dElyWUVRZm5Eaktw?=
 =?utf-8?B?VTFmcDVtMU1SRGh0MTczcHZtYm9IeFhVemVmdisvZFFHQ1h2enF4ZEhVc3lk?=
 =?utf-8?B?ZHhkSE9kbWtXcWFiV1VaMEI4STRHM0p2a3lDT2o1Y0xJWDlmcFMyTSttdmZD?=
 =?utf-8?B?T1E1VWdzdGtjUlRVRHJvVDZHV2xlZURMU3g1cHBRWENCcHlUc0tqQnNZUkZ3?=
 =?utf-8?B?Wkw2Zit1T0F1OXFoZTRBZjdCUFlVK3lFcEx0UVFVaHZwWkhnOHZQcGtuZk1t?=
 =?utf-8?B?amxrWnBVVGIxdStydFFCSCtWMHgzaHRiL2RPdVI2L1dvTkNEMVVBQ3Yzellk?=
 =?utf-8?B?T1RwbDhUcEhLZTF2M2RVVkJkUlpoeTFoSU50WWNML3VtK09qcjM4MzAzeTEr?=
 =?utf-8?B?cC8xTlNpdFcrZVd4YjZIZEZCdUg4U0NuYXQrRndwcUo3QzJLT0NCUnZTYXky?=
 =?utf-8?B?Z2xZdTIvdGRsZm9PVFJnUmNNSVpkZHlQaVA0MG9rVlV6MWJZazcyT2VLREVR?=
 =?utf-8?B?QWxRZW4xSkNDTThWQVVWL2JXa1VjYUsveWl2VXFwYy9tSkc0M05POWR3Nlho?=
 =?utf-8?B?eUNJeFJIbXo5VXZEMlh4TWh0aGFsNDZIaUh6U2VwZjViV3JPaDRIVlJybW55?=
 =?utf-8?B?Z2VPMG5zV0luN24rTE80aVdNa1A5RlZLYnJJMzR5RVBEeHZwL1U2ajl6RHFl?=
 =?utf-8?B?akQrT2xibkFaR1Q5dFphZ003WmQxOS9UdFJRZFg0VFdrOWVsRk1NV0ZrYUdo?=
 =?utf-8?B?UEk2ZitvSWFpQkZkTk9OWkpwQjhXbHY3dC9McCtVUlJKb1l1U2JGVG9ZQks0?=
 =?utf-8?B?QWNxcndaRm1SVHdHQ3U3RVArVit4bTdqZmh1eEZNZWlnNG9zbnJHeE9MTEth?=
 =?utf-8?B?a0pKL3hJWU5ZemZVMVkrOWFad1ZxcUVqaXdYZC9wamw4NFFrUUFmb2t2ZTB5?=
 =?utf-8?B?NFl2Y3JoQ3lJT2JrSjdhd0VKNWRvNkNUSGs0eXdvVDVVeEtXRlRyK2FrY2U1?=
 =?utf-8?B?dGhOdEdTSEVFNGFPcGc3bnZ5UGg3RkFGSGdwU3NTbmFCb0dlcndyVTNXRVdp?=
 =?utf-8?B?TE1uaVViVUlYU3BmQzB3SVdGK0xxSWJKMW1qUmZicEpmYXBuMUtHSEh5R0p5?=
 =?utf-8?B?ZUZXWXlkNXRwdDVuTjArRi9DTG5kaXNYWEJZa2hVTDFRclhUMFRNTzVIdWJr?=
 =?utf-8?B?Sk1hb0NGUXRRTC96dnUvTFhoeGJQV0h4Y3RNU0pGOXRkVHBZRm16aEJNNlQ4?=
 =?utf-8?B?dWZENHYvcURnMWJkRm5nNlJiZzJGMjF1Z1lEellhY1VOSVpVYzVhU1hCVlVN?=
 =?utf-8?B?UzNKcXpObUZKdzdIeWpPSFNaV25PSmQ2VVlyWVJXYVkySHpuWWtxUldRc2Fu?=
 =?utf-8?B?UzVRTTJ3T0VBTnlYNnFpbGVVOGQ0eU9TNmRDQmk3MG5XL1hEbEZDSUtQNVBD?=
 =?utf-8?B?MWJ5U2kxdkM2Z0ZUbmtJWHFFUEFsb2NuUUtBYUlwMllZS1pYSy9IS1BrRysy?=
 =?utf-8?B?dW1LQmlaamd3WGlFSU1LTTFkMGw3Y0FLYkxXdktrUXhoZGQvK3Q0QVMzUzFH?=
 =?utf-8?B?b1MzaHE2MjF2OVhPNVRJM0ZLZHdDbUduK251aC94Sy9NVlI1OHN5cDVGQ0Ji?=
 =?utf-8?B?YzRSTTNLVjZVYmZ0cytVb0N4VU9hUFJtMWtNQldWOGNQcldmS2tkZ1JVeTR6?=
 =?utf-8?B?c2toWkk0MDVveWZyK2NTTHM2TERSdnhtS1Z4RmlMbGl0bUFnZEZZQ1ZKeWE0?=
 =?utf-8?B?ZVlkYWx3eWo4dDdlV0ZRWmRGUnBXTTZQNllieTZzLzZtVzNNRVVSamQxV3Nz?=
 =?utf-8?B?OWd1V20rYzI3bVhGRFRGT2tPOTdwVDJMNjBhK3FMdXRxOWFRSmQ4Y1d1eWIv?=
 =?utf-8?Q?1qcw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fef1fe8-0400-4271-3989-08db4d8b81a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 17:09:37.3686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGpFL+EIYcIAO7+11cl2EolGCVXrRPSmxy1u4rFN6efFZcsJB529I2mv33cOGszY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8534
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJlaW5ldHRlLA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSA0LCAyMDIzIDE6NTgg
UE0NCj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+OyBjb3JiZXRAbHduLm5l
dDsNCj4gdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGUN
Cj4gQ2M6IGZlbmdodWEueXVAaW50ZWwuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207
IHg4NkBrZXJuZWwub3JnOw0KPiBocGFAenl0b3IuY29tOyBwYXVsbWNrQGtlcm5lbC5vcmc7IGFr
cG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IHF1aWNfbmVlcmFqdUBxdWljaW5jLmNvbTsgcmR1
bmxhcEBpbmZyYWRlYWQub3JnOw0KPiBkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbTsg
c29uZ211Y2h1bkBieXRlZGFuY2UuY29tOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsganBvaW1i
b2VAa2VybmVsLm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gY2hhbmcuc2Vvay5iYWVAaW50
ZWwuY29tOyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb207DQo+IGptYXR0c29uQGdv
b2dsZS5jb207IGRhbmllbC5zbmVkZG9uQGxpbnV4LmludGVsLmNvbTsgRGFzMSwgU2FuZGlwYW4N
Cj4gPFNhbmRpcGFuLkRhc0BhbWQuY29tPjsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9y
c2VAYXJtLmNvbTsNCj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gYmFnYXNkb3RtZUBnbWFpbC5jb207IGVyYW5pYW5AZ29vZ2xlLmNv
bTsgY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Ow0KPiBqYXJra29Aa2VybmVsLm9yZzsgYWRy
aWFuLmh1bnRlckBpbnRlbC5jb207IHF1aWNfamlsZXNAcXVpY2luYy5jb207DQo+IHBldGVybmV3
bWFuQGdvb2dsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzddIHg4Ni9yZXNjdHJs
OiBBZGQgbXVsdGlwbGUgdGFza3MgdG8gdGhlIHJlc2N0cmwgZ3JvdXANCj4gYXQgb25jZQ0KPiAN
Cj4gSGkgQmFidSwNCj4gDQo+IE9uIDQvMTcvMjAyMyA0OjM0IFBNLCBCYWJ1IE1vZ2VyIHdyb3Rl
Og0KPiA+IFRoZSByZXNjdHJsIHRhc2sgYXNzaWdubWVudCBmb3IgTU9OSVRPUiBvciBDT05UUk9M
IGdyb3VwIG5lZWRzIHRvIGJlDQo+ID4gZG9uZSBvbmUgYXQgYSB0aW1lLiBGb3IgZXhhbXBsZToN
Cj4gDQo+IFdoeSBhbGwgY2FwcyBmb3IgbW9uaXRvciBhbmQgY29udHJvbD8gSWYgdGhlIGludGVu
dGlvbiBpcyB0byB1c2UgdGhlIHRlcm1zIGZvcg0KPiB0aGVzZSBncm91cHMgdGhlbiBpdCBtYXkg
YmUgZWFzaWVyIHRvIHVzZSB0aGUgc2FtZSB0ZXJtcyBhcyBpbiB0aGUNCj4gZG9jdW1lbnRhdGlv
biwgb3IgeW91IGNvdWxkIGp1c3Qgbm90IHVzZSBhbGwgY2FwcyBsaWtlIHlvdSBkbyBpbiBsYXRl
ciBwYXRjaGVzLg0KDQpTdXJlLg0KPiANCj4gPg0KPiA+ICAgJG1vdW50IC10IHJlc2N0cmwgcmVz
Y3RybCAvc3lzL2ZzL3Jlc2N0cmwvDQo+ID4gICAkbWtkaXIgL3N5cy9mcy9yZXNjdHJsL2Nsb3Mx
DQo+ID4gICAkZWNobyAxMjMgPiAvc3lzL2ZzL3Jlc2N0cmwvY2xvczEvdGFza3MNCj4gPiAgICRl
Y2hvIDQ1NiA+IC9zeXMvZnMvcmVzY3RybC9jbG9zMS90YXNrcw0KPiA+ICAgJGVjaG8gNzg5ID4g
L3N5cy9mcy9yZXNjdHJsL2Nsb3MxL3Rhc2tzDQo+ID4NCj4gPiBUaGlzIGlzIG5vdCB1c2VyLWZy
aWVuZGx5IHdoZW4gZGVhbGluZyB3aXRoIGh1bmRyZWRzIG9mIHRhc2tzLg0KPiA+DQo+ID4gSXQg
Y2FuIGJlIGltcHJvdmVkIGJ5IHN1cHBvcnRpbmcgdGhlIG11bHRpcGxlIHRhc2sgaWQgYXNzaWdu
bWVudCBpbg0KPiA+IG9uZSBjb21tYW5kIHdpdGggdGhlIHRhc2tzIHNlcGFyYXRlZCBieSBjb21t
YXMuIEZvciBleGFtcGxlOg0KPiANCj4gUGxlYXNlIHVzZSBpbXBlcmF0aXZlIG1vb2QgKHNlZSBE
b2N1bWVudGF0aW9uL3Byb2Nlc3MvbWFpbnRhaW5lci10aXAucnN0KS4NCj4gDQo+IFNvbWV0aGlu
ZyBsaWtlOg0KPiAiSW1wcm92ZSBtdWx0aXBsZSB0YXNrIGlkIGFzc2lnbm1lbnQgLi4uLiINCg0K
SG93IGFib3V0Og0KIkltcHJvdmUgdGhlIGFzc2lnbm1lbnQgYnkgc3VwcG9ydGluZyBtdWx0aXBs
ZSB0YXNrIGlkIGFzc2lnbm1lbnQgaW4NCm9uZSBjb21tYW5kIHdpdGggdGhlIHRhc2tzIHNlcGFy
YXRlZCBieSBjb21tYXMuIg0KDQo+IA0KPiA+DQo+ID4gICAkZWNobyAxMjMsNDU2LDc4OSA+IC9z
eXMvZnMvcmVzY3RybC9jbG9zMS90YXNrcw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFidSBN
b2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL3g4
Ni9yZXNjdHJsLnJzdCAgICAgICAgICB8ICAgIDkgKysrKysrKystDQo+ID4gIGFyY2gveDg2L2tl
cm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jIHwgICAzMQ0KPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3g4Ni9yZXNj
dHJsLnJzdA0KPiA+IGIvRG9jdW1lbnRhdGlvbi94ODYvcmVzY3RybC5yc3QgaW5kZXggMzg3Y2Ni
Y2I1NThmLi5mMjhlZDE0NDNhNmENCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L3g4Ni9yZXNjdHJsLnJzdA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24veDg2L3Jlc2N0cmwucnN0
DQo+ID4gQEAgLTI5Miw3ICsyOTIsMTQgQEAgQWxsIGdyb3VwcyBjb250YWluIHRoZSBmb2xsb3dp
bmcgZmlsZXM6DQo+ID4gICJ0YXNrcyI6DQo+ID4gIAlSZWFkaW5nIHRoaXMgZmlsZSBzaG93cyB0
aGUgbGlzdCBvZiBhbGwgdGFza3MgdGhhdCBiZWxvbmcgdG8NCj4gPiAgCXRoaXMgZ3JvdXAuIFdy
aXRpbmcgYSB0YXNrIGlkIHRvIHRoZSBmaWxlIHdpbGwgYWRkIGEgdGFzayB0byB0aGUNCj4gPiAt
CWdyb3VwLiBJZiB0aGUgZ3JvdXAgaXMgYSBDVFJMX01PTiBncm91cCB0aGUgdGFzayBpcyByZW1v
dmVkIGZyb20NCj4gPiArCWdyb3VwLiBNdWx0aXBsZSB0YXNrcyBjYW4gYmUgYWRkZWQgYnkgc2Vw
YXJhdGluZyB0aGUgdGFzayBpZHMNCj4gPiArCXdpdGggY29tbWFzLiBUYXNrcyB3aWxsIGJlIGFz
c2lnbmVkIHNlcXVlbnRpYWxseSBpbiB0aGUgb3JkZXIgaXQNCj4gDQo+IEkgdGhpbmsgdGhlICJp
biB0aGUgb3JkZXIgaXQgaXMgZW50ZXJlZC4iIGNhbiBiZSBkcm9wcGVkIHNvIHRoYXQgaXQganVz
dCByZWFkcyAobm90ZQ0KPiB0ZW5zZSBjaGFuZ2UpOiAiVGFza3MgYXJlIGFzc2lnbmVkIHNlcXVl
bnRpYWxseS4iDQoNCk9rLiBTdXJlDQoNCj4gDQo+ID4gKwlpcyBlbnRlcmVkLiBGYWlsdXJlcyB3
aGlsZSBhc3NpZ25pbmcgdGhlIHRhc2tzIHdpbGwgYmUgYWJvcnRlZA0KPiA+ICsJaW1tZWRpYXRl
bHkgYW5kIHRhc2tzIG5leHQgaW4gdGhlIHNlcXVlbmNlIHdpbGwgbm90IGJlIGFzc2lnbmVkLg0K
PiANCj4gTXVsdGlwbGUgZmFpbHVyZXMgYXJlIG5vdCBzdXBwb3J0ZWQuIEEgc2luZ2xlIGZhaWx1
cmUgZW5jb3VudGVyZWQgd2hpbGUNCj4gYXR0ZW1wdGluZyB0byBhc3NpZ24gYSBzaW5nbGUgdGFz
ayB3aWxsIGNhdXNlIHRoZSBvcGVyYXRpb24gdG8gYWJvcnQuDQoNCk9rLiBTdXJlDQoNCj4gDQo+
ID4gKwlVc2VycyBtYXkgbmVlZCB0byByZXRyeSB0aGVtIGFnYWluLiBGYWlsdXJlIGRldGFpbHMg
cG9zc2libHkgd2l0aA0KPiANCj4gSSBhbSBub3Qgc3VyZSBhYm91dCB0aGlzIGd1aWRhbmNlLiBG
cm9tIHdoYXQgSSBjYW4gdGVsbCBhIGZhaWx1cmUgY291bGQgYmUgZWl0aGVyDQo+IHRoYXQgdGhl
IHBpZCBkb2VzIG5vdCBleGlzdCBvciB0aGF0IHRoZSBtb3ZlIGlzIGlsbGVnYWwuIEEgcmV0cnkg
d291bGQgbm90IGFjaGlldmUNCj4gYSBkaWZmZXJlbnQgb3V0Y29tZS4gSSB0aGluayB5b3UgbWF5
IHRodXMgbWVhbiB0aGF0IHRoZSB0YXNrcyB0aGF0IGZvbGxvd2VkIGENCj4gdGFzayB0aGF0IGNv
dWxkIG5vdCBiZSBtb3ZlZCwgYnV0IGluIHRoYXQgY2FzZSB0aGUgInJldHJ5IiBpcyBub3QgY2xl
YXIgdG8gbWUuDQoNCk9rLiBXaWxsIGRyb3AgInJldHJ5IiBzZW50ZW5jZS4NCg0KPiANCj4gPiAr
CXBpZCB3aWxsIGJlIGxvZ2dlZCBpbiAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9sYXN0X2NtZF9zdGF0
dXMgZmlsZS4NCj4gDQo+IFdvdWxkIGl0IG5vdCBhbHdheXMgcHJpbnQgdGhlIGZhaWxpbmcgcGlk
IChpZiBlcnJvciB3YXMgZW5jb3VudGVyZWQgd2hpbGUNCg0KTm90IGFsd2F5cy4gSW4gdGhpcyBj
YXNlIGl0IGRvZXMgbm90IHByaW50IHRoZSBwaWQsDQpyZHRfbGFzdF9jbWRfcHV0cygiQ2FuJ3Qg
bW92ZSB0YXNrIHRvIGRpZmZlcmVudCBjb250cm9sIGdyb3VwXG4iKTsNCiAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KDQo+IGF0dGVtcHRpbmcgdG8gbW92ZSBhIHRhc2sp
ID8gTWF5YmUganVzdCBkcm9wIHRoYXQgc28gdGhhdCBpdCByZWFkcyAiRmFpbHVyZQ0KPiBkZXRh
aWxzIHdpbGwgYmUgbG9nZ2VkIHRvIC4uLiIgKGFkZGluZyBmaWxlIHNlZW1zIHVubmVjZXNzYXJ5
KS4NCg0KT2sNCg0KPiANCj4gDQo+ID4gKw0KPiA+ICsJSWYgdGhlIGdyb3VwIGlzIGEgQ1RSTF9N
T04gZ3JvdXAgdGhlIHRhc2sgaXMgcmVtb3ZlZCBmcm9tDQo+ID4gIAl3aGljaGV2ZXIgcHJldmlv
dXMgQ1RSTF9NT04gZ3JvdXAgb3duZWQgdGhlIHRhc2sgYW5kIGFsc28gZnJvbQ0KPiA+ICAJYW55
IE1PTiBncm91cCB0aGF0IG93bmVkIHRoZSB0YXNrLiBJZiB0aGUgZ3JvdXAgaXMgYSBNT04gZ3Jv
dXAsDQo+ID4gIAl0aGVuIHRoZSB0YXNrIG11c3QgYWxyZWFkeSBiZWxvbmcgdG8gdGhlIENUUkxf
TU9OIHBhcmVudCBvZiB0aGlzDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
cmVzY3RybC9yZHRncm91cC5jDQo+ID4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0
Z3JvdXAuYw0KPiA+IGluZGV4IDZhZDMzZjM1NTg2MS4uZGY1YmQxMzQ0MGIwIDEwMDY0NA0KPiA+
IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jDQo+ID4gKysrIGIv
YXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gPiBAQCAtNjk2LDE4ICs2
OTYsNDEgQEAgc3RhdGljIHNzaXplX3QgcmR0Z3JvdXBfdGFza3Nfd3JpdGUoc3RydWN0DQo+IGtl
cm5mc19vcGVuX2ZpbGUgKm9mLA0KPiA+ICAJCQkJICAgIGNoYXIgKmJ1Ziwgc2l6ZV90IG5ieXRl
cywgbG9mZl90IG9mZikgIHsNCj4gPiAgCXN0cnVjdCByZHRncm91cCAqcmR0Z3JwOw0KPiA+ICsJ
Y2hhciAqcGlkX3N0cjsNCj4gPiAgCWludCByZXQgPSAwOw0KPiA+ICAJcGlkX3QgcGlkOw0KPiA+
DQo+ID4gLQlpZiAoa3N0cnRvaW50KHN0cnN0cmlwKGJ1ZiksIDAsICZwaWQpIHx8IHBpZCA8IDAp
DQo+ID4gKwlpZiAobmJ5dGVzID09IDApDQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0K
PiA+ICsJYnVmW25ieXRlcyAtIDFdID0gJ1wwJzsNCj4gPiArDQo+IA0KPiBUaGlzIHNlZW1zIGxp
a2UgYW5vdGhlciByZW1uYW50IG9mIHRoZSBzY2hlbWF0YSB3cml0ZSBjb2RlIHRoYXQgZXhwZWN0
cyB0aGF0DQo+IHRoZSBidWZmZXIgZW5kcyB3aXRoIGEgJ1xuJy4gU2luY2UgdGhpcyBjb2RlIGRv
ZXMgbm90IGhhdmUgdGhpcyByZXF1aXJlbWVudCB0aGUNCj4gYWJvdmUgbWF5IGhhdmUgdW5pbnRl
bmRlZCBjb25zZXF1ZW5jZXMgaWYgYSB0b29sIHByb3ZpZGVzIGEgYnVmZmVyIHRoYXQgZG9lcw0K
PiBub3QgZW5kIHdpdGggJ1xuJy4NCj4gSSB0aGluayB5b3UganVzdCB3YW50IHRvIGVuc3VyZSB0
aGF0IHRoZSBidWZmZXIgaXMgcHJvcGVybHkgdGVybWluYXRlZCBhbmQgZnJvbQ0KPiB3aGF0IEkg
dW5kZXJzdGFuZCB3aGVuIGxvb2tpbmcgYXQga2VybmZzX2ZvcF93cml0ZV9pdGVyKCkgdGhpcyBp
cyBhbHJlYWR5IHRha2VuDQo+IGNhcmUgb2YuDQoNClN1cmUuIFdpbGwgY2hlY2suIFRoZW4gSSB3
aWxsIGhhdmUgdG8gY2hhbmdlIHRoZSBjaGVjayBiZWxvdyB0byBpZiAoIWJ1ZikuDQo+IA0KPiA+
ICAJcmR0Z3JwID0gcmR0Z3JvdXBfa25fbG9ja19saXZlKG9mLT5rbik7DQo+ID4gIAlpZiAoIXJk
dGdycCkgew0KPiA+ICAJCXJkdGdyb3VwX2tuX3VubG9jayhvZi0+a24pOw0KPiA+ICAJCXJldHVy
biAtRU5PRU5UOw0KPiA+ICAJfQ0KPiA+ICsNCj4gPiArbmV4dDoNCj4gPiArCWlmICghYnVmIHx8
IGJ1ZlswXSA9PSAnXDAnKQ0KPiA+ICsJCWdvdG8gdW5sb2NrOw0KPiA+ICsNCj4gPiAgCXJkdF9s
YXN0X2NtZF9jbGVhcigpOw0KPiANCj4gV2h5IGlzIHRoaXMgYnVmZmVyIGNsZWFyZWQgb24gcHJv
Y2Vzc2luZyBvZiBlYWNoIHBpZD8NCg0KV2lsbCBjaGVjay4NCg0KPiANCj4gPg0KPiA+ICsJcGlk
X3N0ciA9IHN0cmltKHN0cnNlcCgmYnVmLCAiLCIpKTsNCj4gPiArDQo+ID4gKwlpZiAoa3N0cnRv
aW50KHBpZF9zdHIsIDAsICZwaWQpKSB7DQo+ID4gKwkJcmR0X2xhc3RfY21kX3ByaW50ZigiVGFz
ayBsaXN0IHBhcnNpbmcgZXJyb3JcbiIpOw0KPiANCj4gcmR0X2xhc3RfY21kX3B1dHMoKT8NCg0K
U3VyZS4NCg0KPiANCj4gPiArCQlyZXQgPSAtRUlOVkFMOw0KPiA+ICsJCWdvdG8gdW5sb2NrOw0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChwaWQgPCAwKSB7DQo+ID4gKwkJcmR0X2xhc3RfY21k
X3ByaW50ZigiSW52YWxpZCBwaWQgJWQgdmFsdWVcbiIsIHBpZCk7DQo+ID4gKwkJcmV0ID0gLUVJ
TlZBTDsNCj4gPiArCQlnb3RvIHVubG9jazsNCj4gPiArCX0NCj4gPiArDQo+ID4gIAlpZiAocmR0
Z3JwLT5tb2RlID09IFJEVF9NT0RFX1BTRVVET19MT0NLRUQgfHwNCj4gPiAgCSAgICByZHRncnAt
Pm1vZGUgPT0gUkRUX01PREVfUFNFVURPX0xPQ0tTRVRVUCkgew0KPiA+ICAJCXJldCA9IC1FSU5W
QUw7DQo+IA0KPiBUaGUgYWJvdmUgY29kZSBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRoZSBwaWQg
c28gcmVwZWF0aW5nIGl0cyBleGVjdXRpb24gZG9lcw0KPiBub3Qgc2VlbSBuZWNlc3NhcnkuDQoN
CldpbGwgcmVtb3ZlLi4NClRoYW5rcw0KQmFidQ0KPiANCj4gPiBAQCAtNzE2LDYgKzczOSwxMiBA
QCBzdGF0aWMgc3NpemVfdCByZHRncm91cF90YXNrc193cml0ZShzdHJ1Y3QNCj4ga2VybmZzX29w
ZW5fZmlsZSAqb2YsDQo+ID4gIAl9DQo+ID4NCj4gPiAgCXJldCA9IHJkdGdyb3VwX21vdmVfdGFz
ayhwaWQsIHJkdGdycCwgb2YpOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCXJkdF9sYXN0X2Nt
ZF9wcmludGYoIkVycm9yIHdoaWxlIHByb2Nlc3NpbmcgdGFzayAlZFxuIiwgcGlkKTsNCj4gPiAr
CQlnb3RvIHVubG9jazsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJZ290byBuZXh0Ow0KPiA+ICsJ
fQ0KPiA+DQo+ID4gIHVubG9jazoNCj4gPiAgCXJkdGdyb3VwX2tuX3VubG9jayhvZi0+a24pOw0K
PiA+DQo+ID4NCj4gDQo+IFJlaW5ldHRlDQo=
