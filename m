Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C466BD589
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCPQ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjCPQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:27:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B88DDF20;
        Thu, 16 Mar 2023 09:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsj4UA1XOhGLQfqvWM/jhh1/kFUfBsj+A51QUK8B86nTDRm9gXEHztvDoTXSXcK0mzpTb41zOq2NOAyKSm9BOz2DH7y0GlaoaST440rZixc19TwiYXLCq+izHITYUh2eP1cRh+eDqELrtYhjtvI+Ff8WDAVj86Oa1OjA48AxENun0DbKZC18BceJ7VfaIFeEbdIX65m87/IWQjtTDxQwmaj8nfgHCfgmVh2foW12RIXB7bhHW8yXK2vqX8KbaXshmHJfrsKizb96mYBCUS5mPF9/+ysBA/PRGiHbhVe3nPVqevfvmBu4VQ3g6GmcnhPJ0WsyJaFFoNLfILM6lqs9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcLG6F0xPB2Z9A3qa58gM0u3vmo+YOJN1DdgxAYdTaQ=;
 b=TuuZWlIbyPDkbY5kXLuc4PyG9LgWWmiG2QRP3XoaLE1bjT/OBcC7iellsnBo8vhSYY2U6TPWTKn0o0PX6ccr6gDvSvHxyaYaBKP7jzEfVo4C2/v41oF+L4OFnzgYm8rWrqZCjks056lEFAo9Q2C8st8QtITiQNvYfQIS8X5Jk3YHvBq9ysskszGfv3tJ0y3IkSa1uqJbL/In6F1zvul4anhcGiUKC6fjerpAA0UUrausOPTiti6d4+8E9ARH4XXgwIU/v9zfWWPi7iaARbE4iOgbal5lSd7j7OHqNf/xN9K6Mrl5hu4eZILXV92yvBGjaYtNs7XwlTy/b8LLSNzm/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcLG6F0xPB2Z9A3qa58gM0u3vmo+YOJN1DdgxAYdTaQ=;
 b=CKW9SGyDTIZGJBv4VzYDCkOMsSd4Abx1j+OJlAp/UPWTKkTYRjzdqzKsrowdMlHXwgDgDxy+chIcvCJTG7eBGQozpWjZAUpm9vlFm3f8FJxkg5Wy1jOQCYrkV03pybffmHJAoHNPIwbAMXYg0gRHV3BlSWuibPt/ivK4EwH3O4U=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 16:27:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%9]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 16:27:21 +0000
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
Subject: RE: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Thread-Topic: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Thread-Index: AQHZTUT+FEhR64iFTUGWFRhalBQVz678PoeAgAFT85A=
Date:   Thu, 16 Mar 2023 16:27:21 +0000
Message-ID: <MW3PR12MB45537DC45130BB5F02F0F3F095BC9@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu>
 <9af9eb7a-476c-d4b0-e114-3f5c2b45dd95@intel.com>
In-Reply-To: <9af9eb7a-476c-d4b0-e114-3f5c2b45dd95@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-16T16:27:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=47685370-18df-40c1-ba3e-e40a8b54358c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-16T16:27:19Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6eb32c54-2c60-4baa-9be6-7df788d14d4d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|CY8PR12MB7513:EE_
x-ms-office365-filtering-correlation-id: ccb8bd19-0e89-411c-91fb-08db263b51af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ArC54IaMVbUsXjLf8qyi9boatz4879kyYcPCL5KJSXt0BG8jagTdtgWoWvCERzgxlHmqTvgdkggd5qa128qr79BcXYRgGiSvJ9/DCLca/ymbZYtsyNyFbbjV6vWhHK4U/BOUtalx4jVM7ezYGJWPTT2EGZzH4PHc0K2IJKML6vGLpDgfDznjWq9868970VSUm4DFEhR2dUFN8DIBahJNqb6m89QhCO4IBrbgB54RZmdxSgpzV1Zid+PE8EQ1hx8mwBMpMt49TWcS07Cn6amjmWz71DbU4MxxRq2HVaIQ8BkwTGx8DkpA+PorRN44rq3waBA9kr5QL9QabQduR1cAXJjqZSXhRXiKni/ewaSuYUFKtfzFG67f0RV9WmwHbZtEDeVb2EFXxdN9PzhiGrpvTolJPHGa8XNEfDjjXNXcJBnTwqcdjZc9Qo7mTP6AulDWx/nR/3SW8FtJkegT9ToJy+Wt9FRqNpbU4RSBKGRy70QP5o/Gk6i6QoP1V/82w/XcKW8tJC1TW3bdsfHf1Nw95xbrfJEYflrJD4im9MP0qIdnecDQA34io+DUvrmSHnsIbUZdte3lNwj/AT7sYsHC4pq9BfjLTEGtxXemXhS0MXqFnul6vUwJLjmkIQZPNXcFqXBOk9Z3o09bvCsjF4XRtkyWkq5SVCEkOg79iJxr50b+AnCAYnmwfWq1cdq/YSqK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199018)(7406005)(26005)(7416002)(186003)(9686003)(6506007)(53546011)(5660300002)(83380400001)(66899018)(52536014)(8936002)(38100700002)(7696005)(38070700005)(33656002)(66476007)(66556008)(2906002)(66446008)(76116006)(64756008)(41300700001)(71200400001)(86362001)(55016003)(478600001)(110136005)(316002)(66946007)(8676002)(54906003)(4326008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnJuRDRlL0hFNjhwcmd2cVRxbXJEYWNmZWJRUFJqM3BvajNVWmdHeHg4RTV2?=
 =?utf-8?B?dGpibm42N1VrdFZHOGZpdHF1Ymorcm5KRmZ6dmJYK2ZXZTNZdzVrOVZnc01a?=
 =?utf-8?B?Mzg3UnR3NlczMU5nekdaaDRpSW5yWjhCZmhzK2hzYVFVREJpSnRrOGg1ZWFu?=
 =?utf-8?B?TzJvWGFwOE84TER0Z1RHK0x6d1ZDSllzUEt1YzlmMTFrZ2ZITVRWMGY5SW04?=
 =?utf-8?B?RzlaMXcza0d6U0N4d3p2enB1a0czU3J3eTE4ckhENUFBendNTjNoRVV3ek5I?=
 =?utf-8?B?QlRsSHNpRW9aVENLUWJIMWFCeGNlR3QwRWIrOVgvQk5jYU94dm9IYXhYUjBH?=
 =?utf-8?B?Z3FZUDczR2R1dGluRzd4QjB0Z2RKS0FDa2hTZ3NDcm5SY2hNOWl4UFdPN1Bn?=
 =?utf-8?B?OHNQMWI4Yk1vYmppWW5tRGt6dW9sRXNNZkZBdGJEZXlWcUM1K1VYUDVtTm1I?=
 =?utf-8?B?Q3RPN0g4em1BTWNRUzgvVzVSK0pGeHp2TktVV2RjekdUcllqQkhvVjdiN2Fo?=
 =?utf-8?B?cXFqbWxZNllkRDdLS21KWHNwRXRTS1d3Qk1mandrd1pNUXo4aXl2UUVueWZO?=
 =?utf-8?B?a0s5ZkJNZXFvVzE2RmlSOVlqNVlpSWswaWFWb21Jb0hkR0lqVkhFOFMzK1Jw?=
 =?utf-8?B?d0ViWi9jbSt0akhVWWJVRU9nUkE1UHZmWTdDb1AyRE9LNUNBZVowWnpwU1Aw?=
 =?utf-8?B?WFhiS0JSVEdNSDdSR3ZkMzI0OXBZYXRjdDloRFUzZGRmbm9xQllxRnNlQnRz?=
 =?utf-8?B?VU9pblozbXErSU4rSjR2cXNoZzZXdjZRQ1NyYVZBQlU4ei9XQTJhaHpqN05P?=
 =?utf-8?B?ZW84T2QzN3B0M1hoMG1JaFc2YkFieXEyYjJjQk5IWHA4ZmdCTmJUc2htSEhk?=
 =?utf-8?B?Rm8yZ3pIWXBockFQSnlBb1N4WWVKTkNSTFV1T0REd3lEWldiaU1WMWMzdjhW?=
 =?utf-8?B?dE1PREJQVHphbVIvcUNYR1VqbkJrRmxRWmdHMFE3SElNNkpJdHVIclVsYURR?=
 =?utf-8?B?NlFCQnFMN0NIeEJTdVZDTVZOWXIxTzNoeVViQVR5WGN1NVlkaDYybTJqVmRj?=
 =?utf-8?B?NGxuRlVQQzV5ckJNd2RVanpKS2hjQkMvb3FqUUx3SXVyaFlmYUJwQ0s1cUdm?=
 =?utf-8?B?dDBiVlZ0NEd4clg2RXJ0aHVRbXUxMVFnU3VZaWxNT21abStlQUhPNlRIb3pD?=
 =?utf-8?B?dkNLRlJUcFJFVFJrWTcrbmJDYXpKTUlCTWpNaU9QdVk0NUpVN2M3amowTlFK?=
 =?utf-8?B?VTZDbC9ZSTN2UU5qRm1jZ1ZlMXpJU1hIYjE0REdEYTJmZlgxeXNoRldSbWYr?=
 =?utf-8?B?Zm9mcVFYWjhoMjYrRmNRMkhFT2RmaDdTR1lleDJYUEJTNDJFZTEzT1ZWMm0z?=
 =?utf-8?B?M0o3c3E5QVdaZlNmY2dBNFBhQXdITDUrYkZvVlJyckJqMVc1N1pBUmVvbzlC?=
 =?utf-8?B?TWlKSEVZSFZiV21OQXJUcFBnVmYwV1hxV1I5TlNycG1UbzVGWlJpOG05c1RD?=
 =?utf-8?B?ZEJYek1tZUN1eUI4M0c2eHFDN2tvNGJKN0R5Q0lQUm5QSkJEeXNjSlQ0UFN1?=
 =?utf-8?B?SjRyODE3SWVpbWg2WUNOMGk2bGtJMUZDcFBGb2FvNG1CcXZma0xTNWwwbmNh?=
 =?utf-8?B?WlNuUEVkTmNVS3M2VHRpRXJUdVZLZFIvUEFSOTZQRzQzL2pvc3JEQzB2OUFv?=
 =?utf-8?B?QzliSjdaWGlsbldkMXo5Y2t1bGZ0Wkl5VWcrVUg5aklHekhDZnk5TklYV1A5?=
 =?utf-8?B?dS8yd0dvM0hwSmZtYklNTEp0R1VsL1pCeTZTRDErWEpqaVZ3Yk1rRXUxVU9i?=
 =?utf-8?B?Yk4yZ1l0dkgzcjh4T04rdnBzUVBVUmpKTHFaT3U4NlB4THVwQXdYSC9IUFVV?=
 =?utf-8?B?NlhYVUxBaVBQMW9SUGVSRXlBRUY4OS83dno2OVh2Ny9kdUVTZnRPZjQ5UU1r?=
 =?utf-8?B?TVU0MGx1WmVQa2JoS0xmV1lZak90WFo4RTB4Nk1CNUdNMjVtV0U2Nm4xZTVp?=
 =?utf-8?B?eG16THhwaHNpOWZCTDJQQkpaaDA2b09iYXhoVVJCT0F1RFBpYncwOFNTWGl6?=
 =?utf-8?B?QTRqQnE1RUpiZU9aL3l4NSsvNTdZVjFYZm1iNmRUWElJRFNFT2tYcmY0ZjJW?=
 =?utf-8?Q?88bo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb8bd19-0e89-411c-91fb-08db263b51af
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 16:27:21.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNNFGDq2DSEnfd5OJ5t7N3xpTbsZt3VPWPxDvuIBi46nQHEaVs3+9Zos4BxEo4QA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJlaW5ldHRlLA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxNSwgMjAyMyAx
OjMzIFBNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0QGx3
bi5uZXQ7DQo+IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44
LmRlDQo+IENjOiBmZW5naHVhLnl1QGludGVsLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwu
Y29tOyB4ODZAa2VybmVsLm9yZzsNCj4gaHBhQHp5dG9yLmNvbTsgcGF1bG1ja0BrZXJuZWwub3Jn
OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBxdWljX25lZXJhanVAcXVpY2luYy5jb207
IHJkdW5sYXBAaW5mcmFkZWFkLm9yZzsNCj4gZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5j
b207IHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbTsNCj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IGpw
b2ltYm9lQGtlcm5lbC5vcmc7IHBib256aW5pQHJlZGhhdC5jb207DQo+IGNoYW5nLnNlb2suYmFl
QGludGVsLmNvbTsgcGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tOw0KPiBqbWF0dHNv
bkBnb29nbGUuY29tOyBkYW5pZWwuc25lZGRvbkBsaW51eC5pbnRlbC5jb207IERhczEsIFNhbmRp
cGFuDQo+IDxTYW5kaXBhbi5EYXNAYW1kLmNvbT47IHRvbnkubHVja0BpbnRlbC5jb207IGphbWVz
Lm1vcnNlQGFybS5jb207DQo+IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJhZ2FzZG90bWVAZ21haWwuY29tOyBlcmFuaWFuQGdvb2ds
ZS5jb207IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsNCj4gamFya2tvQGtlcm5lbC5vcmc7
IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyBxdWljX2ppbGVzQHF1aWNpbmMuY29tOw0KPiBwZXRl
cm5ld21hbkBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS83XSB4ODYvcmVz
Y3RybDogQWRkIG11bHRpcGxlIHRhc2tzIHRvIHRoZSByZXNjdHJsIGdyb3VwDQo+IGF0IG9uY2UN
Cj4gDQo+IEhpIEJhYnUsDQo+IA0KPiBPbiAzLzIvMjAyMyAxMjoyNCBQTSwgQmFidSBNb2dlciB3
cm90ZToNCj4gPiBUaGUgcmVzY3RybCB0YXNrIGFzc2lnbm1lbnQgZm9yIE1PTklUT1Igb3IgQ09O
VFJPTCBncm91cCBuZWVkcyB0byBiZQ0KPiA+IGRvbmUgb25lIGF0IGEgdGltZS4gRm9yIGV4YW1w
bGU6DQo+ID4NCj4gPiAgICRtb3VudCAtdCByZXNjdHJsIHJlc2N0cmwgL3N5cy9mcy9yZXNjdHJs
Lw0KPiA+ICAgJG1rZGlyIC9zeXMvZnMvcmVzY3RybC9jbG9zMQ0KPiA+ICAgJGVjaG8gMTIzID4g
L3N5cy9mcy9yZXNjdHJsL2Nsb3MxL3Rhc2tzDQo+ID4gICAkZWNobyA0NTYgPiAvc3lzL2ZzL3Jl
c2N0cmwvY2xvczEvdGFza3MNCj4gPiAgICRlY2hvIDc4OSA+IC9zeXMvZnMvcmVzY3RybC9jbG9z
MS90YXNrcw0KPiA+DQo+ID4gVGhpcyBpcyBub3QgdXNlci1mcmllbmRseSB3aGVuIGRlYWxpbmcg
d2l0aCBodW5kcmVkcyBvZiB0YXNrcy4gQWxzbywNCj4gPiB0aGVyZSBpcyBhIHN5c2NhbGwgb3Zl
cmhlYWQgZm9yIGVhY2ggY29tbWFuZCBleGVjdXRlZCBmcm9tIHVzZXIgc3BhY2UuDQo+IA0KPiBU
byBzdXBwb3J0IHRoaXMgY2hhbmdlIGl0IG1heSBhbHNvIGJlIGhlbHBmdWwgdG8gYWRkIHRoYXQg
bW92aW5nIHRhc2tzIHRha2UgdGhlDQo+IG11dGV4IHNvIGF0dGVtcHRpbmcgdG8gbW92ZSB0YXNr
cyBpbiBwYXJhbGxlbCB3aWxsIG5vdCBhY2hpZXZlIGEgc2lnbmlmaWNhbnQNCj4gcGVyZm9ybWFu
Y2UgZ2Fpbi4NCg0KQWdyZWUuIEl0IG1heSBub3QgYmUgc2lnbmlmaWNhbnQgcGVyZm9ybWFuY2Ug
Z2Fpbi4gIFdpbGwgcmVtb3ZlIHRoaXMgbGluZS4gDQo+IA0KPiA+DQo+ID4gSXQgY2FuIGJlIGlt
cHJvdmVkIGJ5IHN1cHBvcnRpbmcgdGhlIG11bHRpcGxlIHRhc2sgYXNzaWdubWVudCBpbiBvbmUN
Cj4gPiBjb21tYW5kIHdpdGggdGhlIHRhc2tzIHNlcGFyYXRlZCBieSBjb21tYXMuIEZvciBleGFt
cGxlOg0KPiA+DQo+ID4gICAkZWNobyAxMjMsNDU2LDc4OSA+IC9zeXMvZnMvcmVzY3RybC9jbG9z
MS90YXNrcw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBh
bWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL3g4Ni9yZXNjdHJsLnJzdCAgICAg
ICAgICB8ICAgMTEgKysrKysrKysrLS0NCj4gPiAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJs
L3JkdGdyb3VwLmMgfCAgIDI0ICsrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi94ODYvcmVzY3RybC5yc3QNCj4gPiBiL0RvY3VtZW50YXRp
b24veDg2L3Jlc2N0cmwucnN0IGluZGV4IDA1ODI1N2RjNTZjOC4uMjUyMDNmMjAwMDJkDQo+ID4g
MTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi94ODYvcmVzY3RybC5yc3QNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL3g4Ni9yZXNjdHJsLnJzdA0KPiA+IEBAIC0yOTIsMTMgKzI5MiwyMCBA
QCBBbGwgZ3JvdXBzIGNvbnRhaW4gdGhlIGZvbGxvd2luZyBmaWxlczoNCj4gPiAgInRhc2tzIjoN
Cj4gPiAgCVJlYWRpbmcgdGhpcyBmaWxlIHNob3dzIHRoZSBsaXN0IG9mIGFsbCB0YXNrcyB0aGF0
IGJlbG9uZyB0bw0KPiA+ICAJdGhpcyBncm91cC4gV3JpdGluZyBhIHRhc2sgaWQgdG8gdGhlIGZp
bGUgd2lsbCBhZGQgYSB0YXNrIHRvIHRoZQ0KPiA+IC0JZ3JvdXAuIElmIHRoZSBncm91cCBpcyBh
IENUUkxfTU9OIGdyb3VwIHRoZSB0YXNrIGlzIHJlbW92ZWQgZnJvbQ0KPiA+ICsJZ3JvdXAuIE11
bHRpcGxlIHRhc2tzIGNhbiBiZSBhc3NpZ25lZCB0b2dldGhlciBpbiBvbmUgY29tbWFuZCBieQ0K
PiA+ICsJaW5wdXR0aW5nIHRoZSB0YXNrcyBzZXBhcmF0ZWQgYnkgY29tbWFzLiBUYXNrcyB3aWxs
IGJlIGFzc2lnbmVkDQo+IA0KPiBIb3cgYWJvdXQgInRhc2tzIHNlcGFyYXRlZCIgLT4gInRhc2sg
aWRzIHNlcGFyYXRlZCIgb3IgImJ5IGlucHV0dGluZyB0aGUgdGFza3MNCj4gc2VwYXJhdGVkIGJ5
IGNvbW1hcyIgLT4gImJ5IHNlcGFyYXRpbmcgdGhlIHRhc2sgaWRzIHdpdGggY29tbWFzIg0KDQoN
CldpbGwgY2hhbmdlIGl0IHRvICIgTXVsdGlwbGUgdGFza3MgY2FuIGJlIGFzc2lnbmVkIHRvZ2V0
aGVyIGluIG9uZSBjb21tYW5kIGJ5IHNlcGFyYXRpbmcgdGhlIHRhc2sgaWRzIHdpdGggY29tbWFz
LiINCiANCj4gPiArCXNlcXVlbnRpYWxseSBpbiB0aGUgb3JkZXIgaXQgaXMgcHJvdmlkZWQuIEZh
aWx1cmUgd2hpbGUgYXNzaWduaW5nDQo+ID4gKwl0aGUgdGFza3Mgd2lsbCBiZSBhYm9ydGVkIGlt
bWVkaWF0ZWx5LiBUaGUgdGFza3MgYmVmb3JlIHRoZSBmYWlsdXJlDQo+ID4gKwl3aWxsIGJlIGFz
c2lnbmVkIGFuZCB0aGUgdGFza3MgbmV4dCBpbiB0aGUgc2VxdWVuY2Ugd2lsbCBub3QgYmUNCj4g
PiArCWFzc2lnbmVkLiBVc2VycyBtYXkgbmVlZCB0byByZXRyeSB0aGVtIGFnYWluLiBUaGUgZmFp
bHVyZSBkZXRhaWxzDQo+ID4gKwl3aWxsIGJlIGxvZ2dlZCBpbiByZXNjdHJsL2luZm8vbGFzdF9j
bWRfc3RhdHVzIGZpbGUuDQo+IA0KPiBQbGVhc2UgdXNlIGZ1bGwgcGF0aCBhcyBpcyBkb25lIGlu
IHJlc3Qgb2YgZG9jLg0KDQpPay4gU3VyZQ0KDQo+IA0KPiA+ICsNCj4gPiArCUlmIHRoZSBncm91
cCBpcyBhIENUUkxfTU9OIGdyb3VwIHRoZSB0YXNrIGlzIHJlbW92ZWQgZnJvbQ0KPiA+ICAJd2hp
Y2hldmVyIHByZXZpb3VzIENUUkxfTU9OIGdyb3VwIG93bmVkIHRoZSB0YXNrIGFuZCBhbHNvIGZy
b20NCj4gPiAgCWFueSBNT04gZ3JvdXAgdGhhdCBvd25lZCB0aGUgdGFzay4gSWYgdGhlIGdyb3Vw
IGlzIGEgTU9OIGdyb3VwLA0KPiA+ICAJdGhlbiB0aGUgdGFzayBtdXN0IGFscmVhZHkgYmVsb25n
IHRvIHRoZSBDVFJMX01PTiBwYXJlbnQgb2YgdGhpcw0KPiA+ICAJZ3JvdXAuIFRoZSB0YXNrIGlz
IHJlbW92ZWQgZnJvbSBhbnkgcHJldmlvdXMgTU9OIGdyb3VwLg0KPiA+DQo+ID4gLQ0KPiANCj4g
V2h5IGlzIHRoaXMgbGluZSByZW1vdmFsIG5lZWRlZD8NCg0KTm90IG5lZWRlZC4gDQo+IA0KPiA+
ICAiY3B1cyI6DQo+ID4gIAlSZWFkaW5nIHRoaXMgZmlsZSBzaG93cyBhIGJpdG1hc2sgb2YgdGhl
IGxvZ2ljYWwgQ1BVcyBvd25lZCBieQ0KPiA+ICAJdGhpcyBncm91cC4gV3JpdGluZyBhIG1hc2sg
dG8gdGhpcyBmaWxlIHdpbGwgYWRkIGFuZCByZW1vdmUgZGlmZg0KPiA+IC0tZ2l0IGEvYXJjaC94
ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gPiBiL2FyY2gveDg2L2tlcm5lbC9j
cHUvcmVzY3RybC9yZHRncm91cC5jDQo+ID4gaW5kZXggZTJjMTU5OWQxYjM3Li4xNWVhNWI1NTBm
ZTkgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3Vw
LmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+
IEBAIC02ODMsMTYgKzY4MywzNCBAQCBzdGF0aWMgc3NpemVfdCByZHRncm91cF90YXNrc193cml0
ZShzdHJ1Y3QNCj4ga2VybmZzX29wZW5fZmlsZSAqb2YsDQo+ID4gIAkJCQkgICAgY2hhciAqYnVm
LCBzaXplX3QgbmJ5dGVzLCBsb2ZmX3Qgb2ZmKSAgew0KPiA+ICAJc3RydWN0IHJkdGdyb3VwICpy
ZHRncnA7DQo+ID4gKwljaGFyICpwaWRfc3RyOw0KPiA+ICAJaW50IHJldCA9IDA7DQo+ID4gIAlw
aWRfdCBwaWQ7DQo+ID4NCj4gPiAtCWlmIChrc3RydG9pbnQoc3Ryc3RyaXAoYnVmKSwgMCwgJnBp
ZCkgfHwgcGlkIDwgMCkNCj4gPiArCS8qIFZhbGlkIGlucHV0IHJlcXVpcmVzIGEgdHJhaWxpbmcg
bmV3bGluZSAqLw0KPiA+ICsJaWYgKG5ieXRlcyA9PSAwIHx8IGJ1ZltuYnl0ZXMgLSAxXSAhPSAn
XG4nKQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gVGhlIHJlc2N0cmwgZmlsZXMgc2hv
dWxkIGJlIHNlZW4gYXMgdXNlciBzcGFjZSBBUEkuIFdpdGggdGhlIGFib3ZlIGNoYW5nZSB5b3UN
Cj4gdGFrZSBhbiBpbnRlcmZhY2UgdGhhdCBkaWQgbm90IHJlcXVpcmUgYSBuZXdsaW5lIGFuZCBk
aWN0YXRlIHRoYXQgaXQgc2hvdWxkIGhhdmUNCj4gYSB0cmFpbGluZyBuZXdsaW5lLiBIb3cgY29u
dmluY2VkIGFyZSB5b3UgdGhhdCB0aGlzIGRvZXMgbm90IGJyZWFrIGFueSBjdXJyZW50DQo+IHVz
ZXIgc3BhY2Ugc2NyaXB0cyBvciBhcHBsaWNhdGlvbnM/IFdoeSBkb2VzIHRoaXMgZmVhdHVyZSBy
ZXF1aXJlIGEgdHJhaWxpbmcNCj4gbmV3bGluZT8NCg0KSSBoYXZlIHRlc3RlZCB0aGVzZSBjaGFu
Z2VzIHdpdGggaW50ZWxfY210X2NhdCB0b29sLiBJdCBkaWRu4oCZdCBoYXZlIGFueSBwcm9ibGVt
cy4gDQpXZSBhcmUgYWxyZWFkeSBkb2luZyBuZXdsaW5lIGNoZWNrIGZvciBmZXcgb3RoZXIgaW5w
dXRzLg0KDQo+IA0KPiA+ICsNCj4gPiArCWJ1ZltuYnl0ZXMgLSAxXSA9ICdcMCc7DQo+ID4gKw0K
PiA+ICAJcmR0Z3JwID0gcmR0Z3JvdXBfa25fbG9ja19saXZlKG9mLT5rbik7DQo+ID4gIAlpZiAo
IXJkdGdycCkgew0KPiA+ICAJCXJkdGdyb3VwX2tuX3VubG9jayhvZi0+a24pOw0KPiA+ICAJCXJl
dHVybiAtRU5PRU5UOw0KPiA+ICAJfQ0KPiA+ICsNCj4gPiArbmV4dDoNCj4gPiArCWlmICghYnVm
IHx8IGJ1ZlswXSA9PSAnXDAnKQ0KPiA+ICsJCWdvdG8gdW5sb2NrOw0KPiA+ICsNCj4gPiArCXBp
ZF9zdHIgPSBzdHJpbShzdHJzZXAoJmJ1ZiwgIiwiKSk7DQo+ID4gKw0KPiANCj4gQ291bGQgbGli
L2NtZGxpbmUuYzpnZXRfb3B0aW9uKCkgYmUgdXNlZnVsPw0KDQpZZXMuIFdlIGNvdWxkIHRoYXQg
YWxzby4gTWF5IG5vdCBiZSByZXF1aXJlZCBmb3IgdGhlIHNpbXBsZSBjYXNlIGxpa2UgdGhpcy4N
Cg0KPiANCj4gPiArCWlmIChrc3RydG9pbnQocGlkX3N0ciwgMCwgJnBpZCkgfHwgcGlkIDwgMCkg
ew0KPiA+ICsJCXJkdF9sYXN0X2NtZF9wcmludGYoIkludmFsaWQgcGlkICVkIHZhbHVlXG4iLCBw
aWQpOw0KPiANCj4gVGhpcyBpcyByaXNreS4gV2hhdCB3aWxsIHBpZCBiZSBpZiBrc3RydG9pbnQo
KSBmYWlsZWQ/DQoNClllYS4gSSBuZWVkIHRvIHNlcGFyYXRlIHRoZXNlIGZhaWx1cmUgY2FzZXMu
IE9uZSBpcyBwYXJzaW5nIGVycm9yLCBhbmQgYW5vdGhlciBpcyBpbnZhbGlkIHBpZC4NCg0KPiAN
Cj4gPiArCQlyZXQgPSAtRUlOVkFMOw0KPiA+ICsJCWdvdG8gdW5sb2NrOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiAgCXJkdF9sYXN0X2NtZF9jbGVhcigpOw0KPiA+DQo+ID4gIAlpZiAocmR0Z3JwLT5t
b2RlID09IFJEVF9NT0RFX1BTRVVET19MT0NLRUQgfHwgQEAgLTcwMyw2DQo+ICs3MjEsMTAgQEAN
Cj4gPiBzdGF0aWMgc3NpemVfdCByZHRncm91cF90YXNrc193cml0ZShzdHJ1Y3Qga2VybmZzX29w
ZW5fZmlsZSAqb2YsDQo+ID4gIAl9DQo+ID4NCj4gPiAgCXJldCA9IHJkdGdyb3VwX21vdmVfdGFz
ayhwaWQsIHJkdGdycCwgb2YpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlnb3RvIHVubG9jazsN
Cj4gPiArCWVsc2UNCj4gPiArCQlnb3RvIG5leHQ7DQo+ID4NCj4gDQo+IFRoZSBkb2N1bWVudGF0
aW9uIHN0YXRlcyAiVGhlIGZhaWx1cmUgZGV0YWlscyB3aWxsIGJlIGxvZ2dlZCBpbg0KPiByZXNj
dHJsL2luZm8vbGFzdF9jbWRfc3RhdHVzIGZpbGUuIiBidXQgSSBkbyBub3Qgc2VlIGhvdyB0aGlz
IGlzIGhhcHBlbmluZyBoZXJlLg0KPiBGcm9tIHdoYXQgSSBjYW4gdGVsbCB0aGlzIGltcGxlbWVu
dGF0aW9uIGRvZXMgbm90IGRvIGFueXRoaW5nIGJleW9uZCB3aGF0DQo+IGxhc3RfY21kX3N0YXR1
cyBhbHJlYWR5IGRvZXMgc28gYW55IHNwZWNpYWwgbWVudGlvbiBpbiB0aGUgZG9jcyBpcyBub3Qg
Y2xlYXIgdG8NCj4gbWUuIFRoZSBjb3ZlciBsZXR0ZXIgc3RhdGVkICJBZGRlZCBwaWQgaW4gbGFz
dF9jbWRfc3RhdHVzIHdoZW4gYXBwbGljYWJsZS4iIC0gaXQNCj4gc291bmRlZCBhcyB0aG91Z2gg
bGFzdF9jbWRfc3RhdHVzIHdvdWxkIGNvbnRhaW4gdGhlIGVycm9yIHdpdGggdGhlIHBpZCB0aGF0
DQo+IGVuY291bnRlcmVkIHRoZSBlcnJvciBidXQgSSBkbyBub3Qgc2VlIHRoaXMgaGFwcGVuaW5n
IGhlcmUuDQoNCllvdSBhcmUgcmlnaHQgd2UgYXJlIG5vdCBkb2luZyBhbnl0aGluZyBzcGVjaWFs
IGhlcmUuIHBpZCBmYWlsdXJlcyBlcnJvciB3YXMgYWxyZWFkeSB0aGVyZS4NCkkgd2lsbCBoYXZl
IHRvIGNoYW5nZSB0aGUgdGV4dCBoZXJlLg0KVGhhbmtzDQpCYWJ1DQoNCj4gDQo+ID4gIHVubG9j
azoNCj4gPiAgCXJkdGdyb3VwX2tuX3VubG9jayhvZi0+a24pOw0KPiA+DQo+ID4NCj4gDQo+IFJl
aW5ldHRlDQo=
