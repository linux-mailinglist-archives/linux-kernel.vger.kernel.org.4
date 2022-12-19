Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1894D651487
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiLSU6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiLSU6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:58:02 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1980C6B;
        Mon, 19 Dec 2022 12:58:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euR392kyQHdapDjEXGH0L/Pav8I2pDN4Whb1sQa/fsB6WtlSjQW4IGULqKhcEtNf7U9v12OhF76d/UKfe5V5ncU1ubtNGTAmoPfH0sNW4trqudltEF4hkVdoQlhkbYhfjJyaJvwh/MbTFwezYK56IFzgGBFsQ9R/u9YATOTVsXDz/HlORSzCAmYRm152KCzqg3iJbd6aRYoKIYBbus3RXAw3BtHtbWxJ000OwAVo3NBKiJOFhCwmOhWc4ZcyHvc4GKdGJs2YYUNQ4a36NeLxWkFLfiVtq9KhnRMkO5QdA80akqIZ6GpwQSeomYdjTI9t7/3tPLZaB7V1PiEw4Fkc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unIPnTtJzP1UBHNLKTjxOSSFMWsFzr/Vs27RQG3Izs8=;
 b=hzCSpHiEOulJXYaZzncNOVPAgCAshuO9bFgXTiUUA4ElL4hHqIKMr0on7aBQ+bix61okEwoZook8X5DbSZZ/PT0wIZWIjK7M42Kv+wtY8uL5oFz8bcqk8Q2R1brSw2FwVkIFF9VrlUcRHx+/oaQhZNArt74EKgYndnt+aBICaxS40qAGfeG15ZQbzpwry/JJuvQ77iZzs+cG9JkkoGydcY8BV9r2PyswkefIIp7fEMC5DPQwl9EmjEo4dk3IrIlZ3x3I3NmpLwdNvuMUoitlpD4cieOyoQaMYLOjkyTQ9BzXUSmagpP7bC5aRIy4QNBQJUI3itAz68y0Y8rJtkWw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unIPnTtJzP1UBHNLKTjxOSSFMWsFzr/Vs27RQG3Izs8=;
 b=Tjzvg5TS9BkKeAWR0zFmMAqvpbkOqzgn9mfFTe6IVAyckhOpicHg1skf7gsAKzN67sr2/mf0OWUGk5jAbzCdJhi6f/CK+NmG+YthhLOxDWruoSUSk/RhpuRu/YLLLE12R03n56bB9K+nMxvhqmFoE2KXFwwAWlOus3QmmfBtfLY=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 20:57:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 20:57:58 +0000
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
Subject: RE: [PATCH v9 00/13] Support for AMD QoS new features
Thread-Topic: [PATCH v9 00/13] Support for AMD QoS new features
Thread-Index: AQHZBZqdPWUZgGQn2kuXVfR31D91jq5vXbKAgAZwKYA=
Date:   Mon, 19 Dec 2022 20:57:58 +0000
Message-ID: <MW3PR12MB4553148FD006F51BC54B732E95E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <2174535b-1f95-d286-2884-cfa7d0a8491f@intel.com>
In-Reply-To: <2174535b-1f95-d286-2884-cfa7d0a8491f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T20:57:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8f712ad2-1023-4c8e-bae1-3899da1cfcf7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T20:57:57Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 0898cc7c-84a4-4ae4-b509-eb5213727d40
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|CH2PR12MB4117:EE_
x-ms-office365-filtering-correlation-id: 4293df69-4ee6-4d66-33b1-08dae203b58d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkjg6ZTVKPMcM4IySJ2+eK+b4NOsqN0AmoTN/wc9ozH6bkQJ1/d8F1jo8olcTmnW69DCvfAzSPz9sn/QgkKTPPkm3GEWqLx7Mdjd21boo+frn5selRD68AlC6CPPpL+i7uUJLmaABmUYTnAzcSJ9z+VC7OGmpj/oRlCiHhKiwlZNwLz6Y/BGdflGFG/rH3wLSDD0vVDYkiwtxielPFX5pNqdwDXyGBaMbLpqTbjOE9wGhbwi6idcVkd+meRGA1+fCuEe4wT8eB5fhiSfQ5wL6vtlPjFuzG7gF9U5yd56wSwnzPhu28ssr9dpyMs8ChuqPzE7Slb3hqUPLeezFvj/yOqWTdXefdbVTQFt0zzwXk96tJ7YtiTxtalwC3ZqbMSAXqO933+M+u0JoFf34e5UolBYUPDzk8pF+fzBorqIHfoWwFzvcrK+KgBA5RWnQ/lVSYAE7ONOgke+R6l9HL5u8hpzT92HVZ2Kzxix0v0CwIChBILb+0VPkdxR+UtfAt8oTLeMRdjt7/zWwCv6E1ZiJoX45YOhKTo8WFt+PgIdXdgYktXSgi0iSnIL5uCI5pyN7S0q/gXaw7uM/yCL+ZHe5pLZ0df8F2WaiwnFcgtqbWhxquTCDbFiD4RCHfPScxMh/R9PWBm53khQKbMlP5/8lVRpOyKHGVZbtDjDXYyYBnRulQb4n60FVh7lZdvSXGJNGoH/3DBaHqGKcNLrRi631A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(41300700001)(8676002)(4326008)(38100700002)(122000001)(38070700005)(5660300002)(8936002)(7406005)(7416002)(52536014)(2906002)(83380400001)(53546011)(7696005)(71200400001)(6506007)(478600001)(33656002)(316002)(26005)(66556008)(55016003)(54906003)(110136005)(76116006)(66946007)(66476007)(64756008)(66446008)(86362001)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djU0dU1XVVRRK215eGNVa0s3OHRBWlRtWkwyWjNrZE9xVFVnaTVJWDhDb1V1?=
 =?utf-8?B?SHJ0d21tN3dyMzhJM2grTnlRUkJrRTJxMmV6M2ovVHlMYk9zMUJzUXBuOTVp?=
 =?utf-8?B?UkNoaVlFSXQ5M1p6WG5HbjdTT0hDNUpDNUdQT3ZXVnFRWmF2eXREa2k0NTYv?=
 =?utf-8?B?Vi9tbkd5cTBJd2JxNXNOMmJhaW94S0xXVWZpTVFJZXlacUh0TFhmUVAxQVBk?=
 =?utf-8?B?ZkJSSlRRRC9hVm1BV0l4NDIvZHBWOUtzcmhwcnRMMDFyYmxzOW4yQktmYW1O?=
 =?utf-8?B?dnN4R2ZuRUZ2K2R0am9iR2JkUlgrYWQ5VVllYnQ5U1JzQmZUOWZEd3hvSWt5?=
 =?utf-8?B?dFZZOHpYUS9XK254THlITCtBUDB4THEvcmtGc2pEaU5iVnB5ekpBRDRIbk04?=
 =?utf-8?B?VnY3U0lhcndzWGtVaGRtVSt3aEdlZ0FKcGpzbEZ6UkVSeHl6ZEpGb2xYTHVj?=
 =?utf-8?B?QkJVTFZFVitnWFFFKzVPa2hZV1ArQlRnYXNReUxkK0lHLzN5OUh4RHV5YjNn?=
 =?utf-8?B?K1hKUFpOODVrU0ZwVGZMbXprYVp2aWdGL3VzVXFCeHdXdkF4aWpHZzNZUlJw?=
 =?utf-8?B?TnJMNXNNZDY4MUhyREd1cVFBRm5lVG9JZ0xkTjVtajB4L3k2SXVoVW9IUy9B?=
 =?utf-8?B?TmRySS9hTkZZVUEyeTY1RHNlYWVBZk9RbHMrM2IwSHMrWDNJT3pNaHFncTd2?=
 =?utf-8?B?U0ZVSWIzVExVU2hxYlQvdHF0RlIydkRZd1FYQ2lDNklLRzF3cTJBNUd5ZjRF?=
 =?utf-8?B?cHBxZ2lHMEtiVmk0cXlHK29jWGZMOVU1NTMxaDlnaTFPNmt1MWNVS0tWR25C?=
 =?utf-8?B?bFoyVkNXdldORU5taUhuSDZNK2V1REJWalUvL0Y4WEhUb1FHbTVib3pDZllG?=
 =?utf-8?B?bElYUlBJbk9GTjRGWldxaWZwZTcvMkFjUEFydlVjM1VMV0hQdkpLMkptY2N0?=
 =?utf-8?B?RDF1M2hSbVFrbFltTGczSXkxZTcyOEIyRjdBWkdKQTVGUlljZEZoY0VKUC82?=
 =?utf-8?B?dEFDS3Z5eUQ0QVNGTVNJR1k3VU1aMFBBeE9GcXJMLzB2ZzVoV21meWh6ZFAz?=
 =?utf-8?B?VkEySFU0MVdTRENpaVpYMStIRE9YSUpBMzUrbkNldHBFSTJNQzdiRldXbXpJ?=
 =?utf-8?B?Y0JhbVVjMW45SEY1bjVlL2hhM0UrSlFmNmRaYWlmSWh0d1YvdE52U2NzdEpv?=
 =?utf-8?B?RTBtQkFyNElkeDZzSG9PQmhFcDJnVE1LQ0h6ZnVQQTZVVXpvQnZaMVVMc3lZ?=
 =?utf-8?B?TEZmS0ZGUVozdGQwRVVIbzNFN2sxYmF2S2ZTOWNTMElzVHVNTS90TkZFQjJN?=
 =?utf-8?B?RHdNNTd3R2dwRWZyRG0zRDVkWVlnaVdmdU9QRUpXRFduKyszK2ZwaURCRnA0?=
 =?utf-8?B?d3hHcnpxQVNRbkdiWm5ldWRPc3JjR0tTeWc4cnlCL2k5ZlJoL2FwejBUanpQ?=
 =?utf-8?B?dENSOGR3R0RSK1dWN2tvMW5UMFU2SU5MOUJ1T2dFZEgxYnNyWGtZOENQVnFU?=
 =?utf-8?B?QkNDbytIZmxtSWRIWVl1ekdndUZKeS9WcUFwSWR1cWRvT1cyQmJ5RnFQSStF?=
 =?utf-8?B?ckgzQ3BBVnpHNmhZT0dMc05yeFpYcTNyeUR5aFJiUGJzMDBaZDErOHYxeWpQ?=
 =?utf-8?B?RjZlbUpUZHE2YmNCeGlxdEtkdXFsZ2dZMml4c3dwNGFEc3ZVMDZFalJjMytl?=
 =?utf-8?B?U1hxbDVNRTZyd241R1NHSFFRZElWZW9scnh2ZlBLczBnMnFoQllGSUJSTzRP?=
 =?utf-8?B?T2hBV2txSkYzWldDdWZBbElzdmtHUEt2TVVKekJnZ1NJcGwzdFR1dERwREZE?=
 =?utf-8?B?YXNBalVpU2pYR3VxNmJnWFlqOE94TkRSL1hvZER1YUErdjlIWTRsMFlmMVZa?=
 =?utf-8?B?R2ZCNjRDcDJRZXJXZ3JkNk9RU3lVTUJWTmx4TW1TM3JhTDBKZTdDN0d6Y3JL?=
 =?utf-8?B?QjNRTy9KZGVGa1U2STE3ZUlqZ29WUzhxbUVLWjdXWWMzY2pzMnpobU1LY1Jy?=
 =?utf-8?B?Z3dkQTUvR2w2a256dlFmclMyNnJOVURmQ29TUTV2SWEvL3lsK3l6Z2diTVFF?=
 =?utf-8?B?Qk9UeEUzbTdTSlgwNnp2ZHN1TlZKZ1JzWVpObFA4WTRRekFMaElDNlFQQXhB?=
 =?utf-8?Q?EfJU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4293df69-4ee6-4d66-33b1-08dae203b58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 20:57:58.4587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0IAMcQbXfSQThGFH0AVai3LZJonzTkwApeYMRYzkg1s2l5iD7yM7tFhD2UGFlwzA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0dGUuY2hhdHJlQGlu
dGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE1LCAyMDIyIDEyOjM5IFBNDQo+
IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0QGx3bi5uZXQ7DQo+
IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRlDQo+IENj
OiBmZW5naHVhLnl1QGludGVsLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyB4ODZA
a2VybmVsLm9yZzsNCj4gaHBhQHp5dG9yLmNvbTsgcGF1bG1ja0BrZXJuZWwub3JnOyBha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnOw0KPiBxdWljX25lZXJhanVAcXVpY2luYy5jb207IHJkdW5sYXBA
aW5mcmFkZWFkLm9yZzsNCj4gZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb207IHNvbmdt
dWNodW5AYnl0ZWRhbmNlLmNvbTsNCj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IGpwb2ltYm9lQGtl
cm5lbC5vcmc7IHBib256aW5pQHJlZGhhdC5jb207DQo+IGNoYW5nLnNlb2suYmFlQGludGVsLmNv
bTsgcGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tOw0KPiBqbWF0dHNvbkBnb29nbGUu
Y29tOyBkYW5pZWwuc25lZGRvbkBsaW51eC5pbnRlbC5jb207IERhczEsIFNhbmRpcGFuDQo+IDxT
YW5kaXBhbi5EYXNAYW1kLmNvbT47IHRvbnkubHVja0BpbnRlbC5jb207IGphbWVzLm1vcnNlQGFy
bS5jb207DQo+IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGJhZ2FzZG90bWVAZ21haWwuY29tOyBlcmFuaWFuQGdvb2dsZS5jb207IGNo
cmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsNCj4gamFya2tvQGtlcm5lbC5vcmc7IGFkcmlhbi5o
dW50ZXJAaW50ZWwuY29tOyBxdWljX2ppbGVzQHF1aWNpbmMuY29tOw0KPiBwZXRlcm5ld21hbkBn
b29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDAvMTNdIFN1cHBvcnQgZm9yIEFN
RCBRb1MgbmV3IGZlYXR1cmVzDQo+IA0KPiBIaSBCYWJ1LA0KPiANCj4gUGxlYXNlIGFsc28gdXNl
IHRoZSB4ODYvcmVzY3RybCBwcmVmaXggaW4gdGhlIGNvdmVyIGxldHRlcidzIHN1YmplY3QuDQoN
ClN1cmUuDQpUaGFua3MNCkJhYnUNCj4gDQo+IFJlaW5ldHRlDQo=
