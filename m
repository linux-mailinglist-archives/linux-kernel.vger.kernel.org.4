Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EFA651169
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 18:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiLSR4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 12:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSR4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:56:12 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C163B3;
        Mon, 19 Dec 2022 09:56:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAuhi+1l9fb5jxffp4CUaEuNnX9o69aGqyZM6o6NhOeBLYOHd2qMnsG3kO8rZv5UYeNecPp1DnEw2DcVkg8goDT9fcS/CnQ01C4+r5MJH/9PM3wtkO/ts+GXQBDxjv2Ii+uE87R90Av33pEalZLvx4fS7g9SBmxOw3laS8X3G7a5uHXT8AcjY2QhAZ0sGUuJR6WcZQQjLZVH6SIm5wOGJxNEy4sqiybYSEB9Mji+hMshdSgAt9uXpz3H2wLAsGgP2+jHQskz+LAalv9gT5EGhgu1V6CLY1xy3bITWmwC82DX/9viKN9dQz6uzt+MMK6oH0EnPcnyD7dKTd2516tUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4L8kaIO+yC0hfqQoMiGDWV3k93Bv8PoOxURXQNMhU4=;
 b=eNve8twE8OLdkF/RBdiD6eVoS1Bi1lr0ZQYf2dg1xuH8DrxcvyXruPPJXAMwuNxSFTKruHBd6avAKZlDNIKDdmzDZUfyEljw8Wfs4FuIh2oLbahmstaUGvEuEqHrAI4myBaH9ac+o10YFltW+62QxvhYQU2NETTnJNny7ZZJ/1czHe1UhLpEW8ypVJVGpxAjNhykoFZ9rDBo/hxrOr4mBseZinyzznN7o5hb5WjfuuY+ooqEtNFbOpbn2fMRGb0y4AzENFmUk8V/l/XSX6cCM5Z+7xxrG7/eLbfCoWpo+Fqq9HVRgrQwxXFBbr+KJQQ0KRgS4IrflPR0sXUWeaEdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4L8kaIO+yC0hfqQoMiGDWV3k93Bv8PoOxURXQNMhU4=;
 b=rdrBx6wIN6UitytgSSwot/Keq9PHz8fUl5JLqewL2RebVVTiYDlcVKQO2TVCfg4G+MoklkGhmmn85Ch/yWlB6MTM8RiDBMyshKQ7O1RRHTHHmoxAU2MdlWPFOpxP1u8ewhARozjClRhUCQiCZAVgWp/Y4jb80GKqQYGHLwuta9M=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 17:56:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 17:56:06 +0000
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
Subject: RE: [PATCH v9 07/13] x86/resctrl: Introduce data structure to support
 monitor configuration
Thread-Topic: [PATCH v9 07/13] x86/resctrl: Introduce data structure to
 support monitor configuration
Thread-Index: AQHZBZrFhiWrQ6VvbUmgiTao5c6Asq5vR3mAgAZTc8A=
Date:   Mon, 19 Dec 2022 17:56:06 +0000
Message-ID: <MW3PR12MB45532A37EE100F1EAA64422F95E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990900849.17806.5346239458898437535.stgit@bmoger-ubuntu>
 <20ea6828-8ca9-3106-7eac-00fd9cec5fed@intel.com>
In-Reply-To: <20ea6828-8ca9-3106-7eac-00fd9cec5fed@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T17:55:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=33cba4f1-ed9b-4375-a6cb-0109f65b5725;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T17:56:05Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 277c10bd-2007-4117-ba8e-5ea1fce3bb56
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|PH7PR12MB5808:EE_
x-ms-office365-filtering-correlation-id: 5d2f9a97-6a65-4db7-2bc0-08dae1ea4db0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23XphdI4Qcx9wHt2UdauBxNiA5rfuH0YPyJK99VVDODLkDbl/WrSutzi9y4gPqHl7O2sia80k3OHOQBct/C3szO0BGQEcuIJX1H9EkdTOhGGK1ns0OJhqUMAVfuk/cKRL60qitZ2YymtOm26OgpEgBTnqvKet6hKkNCzNsBJIbVzyh/wjK7olDJcnDKXbiLJ3liRjQTwlfGwMXhe4CKNB4TVNULM8FgAEMnwcDeGm6JzdK2GjloPWczAbrBsFcqR8fMfEg6TAmykKBiPmC3fz9VnNbwlNHmgWxfY69hS48MQcgpwIqkKpbHwoiRpHxmhPRLdyOfW9T105g2YJVhPdy4RoHdPwEIkgmjzsYmK8C8TjLVz8a+qiEFx3PqGEVqqlENJpyxdlC1L4e0g0hTr9l0vhKDYM6GY8/jQ01VN2hqygkASRP0kmqAIaJ+87TQIHUEOSIKmMHThyDa2nk3jwjGVorn84iqYcEElcPycjGxhXBJbVOYJ2K5+m8pQwXev103FhyqjxzlM/QvldYzp8A+I1wzyW1e4BmW9PGKjGJCPV6BLUguFaL1B0plWKhLF5BbULWqfGPSeTiLlqL+veM8gTly6pgVh2eF8rLOH4LBqBfU2b5GMYDtvSSzdGbu6JEghWa1SkOJ6KdGX+9lCjv7EMEHu2GPkW0sGcNVaczt6DQzjP0wGCxbURg04E1DyWqDHzd92beyW9lrZ/VL9dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(66946007)(86362001)(66476007)(76116006)(66446008)(64756008)(4326008)(8676002)(316002)(52536014)(66556008)(5660300002)(8936002)(33656002)(41300700001)(9686003)(7696005)(6506007)(53546011)(186003)(26005)(71200400001)(38070700005)(83380400001)(122000001)(54906003)(55016003)(38100700002)(110136005)(478600001)(2906002)(7406005)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG5mWXVVWkhSbDRyVUhHc3RnbTYrdXVEZEF6dStzU2hPbXRldWdmeVJPLzBj?=
 =?utf-8?B?V1R3SXptdHhneGJVdjVLa3IwV05DTTIxMndWck50ZDlaRlNmcGRPemR2RTZE?=
 =?utf-8?B?djEzamdpbTliOTc0OGFmVHZicDIxNmNaZkhPRjFjVTd5SEFRZzk3dlA1QTY3?=
 =?utf-8?B?RkNraXFVblhvSjYxNVlUZFV0eDZlWW83NmFvUUtucTVDdEMvV1NvWEwrNUdo?=
 =?utf-8?B?TzBXelZ3Y2pwM2ZodWd3bDVTdnFaSG1kblBuV0wwQldzS0duWWlNR3RXaCsy?=
 =?utf-8?B?U2FHWXpHejMyRWpoVkN5VStlN2pTbEFDTGF5VVRCb3pIQ0M2ZXBpNlFkWC85?=
 =?utf-8?B?aGZMQStIQ3c2d0NNYVNqYURxOWZ1ZTRxUHZMOEg2MTFEaUFBTE1XbXN2cHBj?=
 =?utf-8?B?Q05CK05ORFJldGJsQ3crd28xdmdGeVBkVHBHMXFWMTFPZXYzU1lHaVhNOHlu?=
 =?utf-8?B?UzZKTnFvUktyNHBEV1JKeWxMTWlxK1NubEhHczBrZWpkeGNRTlM2YTJNTi9z?=
 =?utf-8?B?RkFPaHJORWlwcEdlWnRBYnFUYzExUFdTbXNhRS9URVN0Zit5RU1YRW9ObnVE?=
 =?utf-8?B?QlNCT3JBYmRiUE1wQ2drNTNoK3lqZjhvMEk3NTVNRk5EalIrd2hsTHpDcllo?=
 =?utf-8?B?eElpVUl5dTNOZVg1YnV3YytOTnlKU3VzMENkcGF6YWZwVkdEZ0puWmk5eDc4?=
 =?utf-8?B?bTBVR0JCVVRKR0FPdU9XTVVnMkhDcGRaTkJMeDR2Rm1yTzUvb2VrSVhkY3ho?=
 =?utf-8?B?d1k5YmRzMVNHUFlHVXhkeTRGRVdpM1JRYzBISmV1U0RBUHRDQXd6aUlxelNs?=
 =?utf-8?B?OXMvVlE4elJjSmp4TlByWEVMeE5jcitoNjh4TWNkNFFObW5YQlJSZHZTRkRa?=
 =?utf-8?B?bDV3UFc3QzZ3UUJKUmFJK0VkZnpjd29jaXVhZUxqalY2dmc5MFQ3M0VKVkx6?=
 =?utf-8?B?VGFwMXdmamZrMDllMUNCMkJtcHd6VThvOGJRU3A2WUdKWnd5aytlRi9RSjFn?=
 =?utf-8?B?Q2hmeUkrVldFOWhRM3hucVRpWldCbUhCVDVxbmZrOTVJRHEwQVdwQ1hZaTgw?=
 =?utf-8?B?ejlERDJGL2Q4OEY3bDRkUUJaL1ovL0U3bjRyNnFpVUQ1VDRRTVRQZnBxeXRU?=
 =?utf-8?B?cUZ3WTRiRnVMOXEwVXBPOHJSTEo1Q3AvamdCTXp6UUxQNTkxUWc4b1loWWJm?=
 =?utf-8?B?RythT0swVnBaR1VMaWNBOXIxZkhDSnIwMjRFNm9Qd2pxL0Uwc254YWhOTE54?=
 =?utf-8?B?UTJnWnpDbVVvRFVDMytJNkZ6RDNORG1mbDZ3WWhRQnFaQ0JKNW5penVYcDhk?=
 =?utf-8?B?SEFCbHZlOUZMMG1rZjRFZCtsZ0ZYQzIvNEpyME1WSHJ6M3h4SnhzaGhWY3FB?=
 =?utf-8?B?Nm9oNmZHeUlvdThXYVlhenV3Z2p3OE9UZGRJUFJhWHVjQ0lQRTlCL3JKUXRQ?=
 =?utf-8?B?NC91ZFlpazJybkw2cDB2dXV6K3dJbUJZRFFWM2JlR1M3VzIvSUlHRldIOXpU?=
 =?utf-8?B?UHVqSWJSWEJVSmZQbCs2ZXBCd0hhdkcwNEdVNEdXRVdhZnBTWFJlZ2YxeCtF?=
 =?utf-8?B?VWxrdW9hcFd5K3AyZnY2VlhGbG5CRm5PeXBQd3drZEFTdmNON2Fjd0ZQWW9O?=
 =?utf-8?B?bndobGVxak5sK1VtT3VZOXVZV3RzTkhpYWMvaTNBSitOMmxDbGxUTGs0TEdE?=
 =?utf-8?B?cTBKNmVPcGI1dnZWYVJ1QVAyMEE3cU16WkEySllCYXViaFVxQmhVUXVHaXBN?=
 =?utf-8?B?ck5wSExwc3FHWDNsZk9KV3JVVUxBZTFkbnVYNDdGUG9hSGlIalppRU9kbHVZ?=
 =?utf-8?B?MjFDblBxZ0Y2bWlNY3NtSnZHQmxybloweEpLSWFMU2pkWUVxUjBKSGs1S1FY?=
 =?utf-8?B?ZURlMi9zQVlhZXBoRCtucHN1WGlKQnoxWGloYkRnSU05RFZaZmZYUkNRMkNl?=
 =?utf-8?B?VFFvRzBaS0xxSFJxSXdmU01TOTR0KzQ2RGJDM3crUk9oL1U1VS9YaE1nSmJX?=
 =?utf-8?B?elZiNEZWekJoLzZrL1pSbGJ1ZGJyeXQyV2N6WUppaHkwc3U4NUVQRE1uTXR2?=
 =?utf-8?B?SFJtTmNxNmVmQlg4NW1tRERyUFhwbTRPbFExU01Kcmp4OG5kRUxBb0MvT2My?=
 =?utf-8?Q?4Qmk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2f9a97-6a65-4db7-2bc0-08dae1ea4db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 17:56:06.7708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAHz32EVpDv9/9QUjE3zQ4kB8ltoDVZCbRP9TqTvhqij8vFCYf8Y0Bq+ybjiCns/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJlaW5ldHRlLA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE1LCAyMDIy
IDExOjE5IEFNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0
QGx3bi5uZXQ7DQo+IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxp
ZW44LmRlDQo+IENjOiBmZW5naHVhLnl1QGludGVsLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50
ZWwuY29tOyB4ODZAa2VybmVsLm9yZzsNCj4gaHBhQHp5dG9yLmNvbTsgcGF1bG1ja0BrZXJuZWwu
b3JnOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBxdWljX25lZXJhanVAcXVpY2luYy5j
b207IHJkdW5sYXBAaW5mcmFkZWFkLm9yZzsNCj4gZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndk
Yy5jb207IHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbTsNCj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7
IGpwb2ltYm9lQGtlcm5lbC5vcmc7IHBib256aW5pQHJlZGhhdC5jb207DQo+IGNoYW5nLnNlb2su
YmFlQGludGVsLmNvbTsgcGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tOw0KPiBqbWF0
dHNvbkBnb29nbGUuY29tOyBkYW5pZWwuc25lZGRvbkBsaW51eC5pbnRlbC5jb207IERhczEsIFNh
bmRpcGFuDQo+IDxTYW5kaXBhbi5EYXNAYW1kLmNvbT47IHRvbnkubHVja0BpbnRlbC5jb207IGph
bWVzLm1vcnNlQGFybS5jb207DQo+IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJhZ2FzZG90bWVAZ21haWwuY29tOyBlcmFuaWFuQGdv
b2dsZS5jb207IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsNCj4gamFya2tvQGtlcm5lbC5v
cmc7IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyBxdWljX2ppbGVzQHF1aWNpbmMuY29tOw0KPiBw
ZXRlcm5ld21hbkBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDcvMTNdIHg4
Ni9yZXNjdHJsOiBJbnRyb2R1Y2UgZGF0YSBzdHJ1Y3R1cmUgdG8gc3VwcG9ydA0KPiBtb25pdG9y
IGNvbmZpZ3VyYXRpb24NCj4gDQo+IEhpIEJhYnUsDQo+IA0KPiBJIGRvIG5vdCBzZWUgYSBuZXcg
ZGF0YSBzdHJ1Y3R1cmUgaW50cm9kdWNlZC4gUGVyaGFwcyBzdWJqZWN0IGNvdWxkIGp1c3QgYmU6
DQo+IHg4Ni9yZXNjdHJsOiBTdXBwb3J0IG1vbml0b3IgY29uZmlndXJhdGlvbg0KDQpTdXJlDQo+
IA0KPiBPbiAxMi8xLzIwMjIgNzozNiBBTSwgQmFidSBNb2dlciB3cm90ZToNCj4gPiBBZGQgYSBu
ZXcgZmllbGQgaW4gbW9uX2V2dCB0byBzdXBwb3J0IEJhbmR3aWR0aCBNb25pdG9yaW5nIEV2ZW50
DQo+IA0KPiAibW9uX2V2dCIgLT4gInN0cnVjdCBtb25fZXZ0Ig0KT2sNCj4gDQo+ID4gQ29uZmln
dXJhdGlvbihCTUVDKSBhbmQgYWxzbyB1cGRhdGUgdGhlICJtb25fZmVhdHVyZXMiIGRpc3BsYXku
DQo+ID4NCj4gPiBUaGUgcmVzY3RybCBmaWxlICJtb25fZmVhdHVyZXMiIHdpbGwgZGlzcGxheSB0
aGUgc3VwcG9ydGVkIGV2ZW50cyBhbmQNCj4gPiBmaWxlcyB0aGF0IGNhbiBiZSB1c2VkIHRvIGNv
bmZpZ3VyZSB0aG9zZSBldmVudHMgaWYgbW9uaXRvcg0KPiA+IGNvbmZpZ3VyYXRpb24gaXMgc3Vw
cG9ydGVkLg0KPiA+DQo+ID4gQmVmb3JlIHRoZSBjaGFuZ2UuDQo+ID4gCSRjYXQgL3N5cy9mcy9y
ZXNjdHJsL2luZm8vTDNfTU9OL21vbl9mZWF0dXJlcw0KPiA+IAlsbGNfb2NjdXBhbmN5DQo+ID4g
CW1ibV90b3RhbF9ieXRlcw0KPiA+IAltYm1fbG9jYWxfYnl0ZXMNCj4gPg0KPiA+IEFmdGVyIHRo
ZSBjaGFuZ2Ugd2hlbiBCTUVDIGlzIHN1cHBvcnRlZC4NCj4gPiAJJGNhdCAvc3lzL2ZzL3Jlc2N0
cmwvaW5mby9MM19NT04vbW9uX2ZlYXR1cmVzDQo+ID4gCWxsY19vY2N1cGFuY3kNCj4gPiAJbWJt
X3RvdGFsX2J5dGVzDQo+ID4gCW1ibV90b3RhbF9ieXRlc19jb25maWcNCj4gPiAJbWJtX2xvY2Fs
X2J5dGVzDQo+ID4gCW1ibV9sb2NhbF9ieXRlc19jb25maWcNCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94
ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmggfCAgICAyICsrDQo+ID4gIGFyY2gveDg2
L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMgIHwgICAgNyArKysrKysrDQo+ID4gIGFyY2gv
eDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jIHwgICAgNSArKysrLQ0KPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvaW50ZXJuYWwuaA0KPiA+IGIv
YXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmgNCj4gPiBpbmRleCA3YmJmYzEw
MDk0YjYuLmIzNjc1MDMzNGRlYiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1
L3Jlc2N0cmwvaW50ZXJuYWwuaA0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3Ry
bC9pbnRlcm5hbC5oDQo+ID4gQEAgLTUyLDExICs1MiwxMyBAQCBERUNMQVJFX1NUQVRJQ19LRVlf
RkFMU0UocmR0X21vbl9lbmFibGVfa2V5KTsNCj4gPiAgICogc3RydWN0IG1vbl9ldnQgLSBFbnRy
eSBpbiB0aGUgZXZlbnQgbGlzdCBvZiBhIHJlc291cmNlDQo+ID4gICAqIEBldnRpZDoJCWV2ZW50
IGlkDQo+ID4gICAqIEBuYW1lOgkJbmFtZSBvZiB0aGUgZXZlbnQNCj4gPiArICogQGNvbmZpZ3Vy
YWJsZToJdHJ1ZSBpZiB0aGUgZXZlbnQgaXMgY29uZmlndXJhYmxlDQo+ID4gICAqIEBsaXN0OgkJ
ZW50cnkgaW4gJnJkdF9yZXNvdXJjZS0+ZXZ0X2xpc3QNCj4gPiAgICovDQo+ID4gIHN0cnVjdCBt
b25fZXZ0IHsNCj4gPiAgCWVudW0gcmVzY3RybF9ldmVudF9pZAlldnRpZDsNCj4gPiAgCWNoYXIJ
CQkqbmFtZTsNCj4gPiArCWJvb2wJCQljb25maWd1cmFibGU7DQo+ID4gIAlzdHJ1Y3QgbGlzdF9o
ZWFkCWxpc3Q7DQo+ID4gIH07DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVs
L2NwdS9yZXNjdHJsL21vbml0b3IuYw0KPiA+IGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJs
L21vbml0b3IuYw0KPiA+IGluZGV4IGUzM2U4ZDhiZDc5Ni4uYjM5ZTBlY2ExODc5IDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMNCj4gPiArKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvbW9uaXRvci5jDQo+ID4gQEAgLTc4Myw2ICs3
ODMsMTMgQEAgaW50IF9faW5pdCByZHRfZ2V0X21vbl9sM19jb25maWcoc3RydWN0DQo+IHJkdF9y
ZXNvdXJjZSAqcikNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPg0KPiA+
ICsJaWYgKHJkdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0JNRUMpKSB7DQo+ID4gKwkJaWYgKHJkdF9j
cHVfaGFzKFg4Nl9GRUFUVVJFX0NRTV9NQk1fVE9UQUwpKQ0KPiA+ICsJCQltYm1fdG90YWxfZXZl
bnQuY29uZmlndXJhYmxlID0gdHJ1ZTsNCj4gPiArCQlpZiAocmR0X2NwdV9oYXMoWDg2X0ZFQVRV
UkVfQ1FNX01CTV9MT0NBTCkpDQo+ID4gKwkJCW1ibV9sb2NhbF9ldmVudC5jb25maWd1cmFibGUg
PSB0cnVlOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCWwzX21vbl9ldnRfaW5pdChyKTsNCj4gPg0K
PiA+ICAJci0+bW9uX2NhcGFibGUgPSB0cnVlOw0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+IGIvYXJjaC94ODYva2VybmVsL2NwdS9y
ZXNjdHJsL3JkdGdyb3VwLmMNCj4gPiBpbmRleCA4YTNkYWZjMGRiZjcuLjgzNDJmZWI1NGE3ZiAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0K
PiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jDQo+ID4gQEAg
LTEwMDEsOCArMTAwMSwxMSBAQCBzdGF0aWMgaW50IHJkdF9tb25fZmVhdHVyZXNfc2hvdyhzdHJ1
Y3QNCj4ga2VybmZzX29wZW5fZmlsZSAqb2YsDQo+ID4gIAlzdHJ1Y3QgcmR0X3Jlc291cmNlICpy
ID0gb2YtPmtuLT5wYXJlbnQtPnByaXY7DQo+ID4gIAlzdHJ1Y3QgbW9uX2V2dCAqbWV2dDsNCj4g
Pg0KPiA+IC0JbGlzdF9mb3JfZWFjaF9lbnRyeShtZXZ0LCAmci0+ZXZ0X2xpc3QsIGxpc3QpDQo+
ID4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KG1ldnQsICZyLT5ldnRfbGlzdCwgbGlzdCkgew0KPiA+
ICAJCXNlcV9wcmludGYoc2VxLCAiJXNcbiIsIG1ldnQtPm5hbWUpOw0KPiA+ICsJCWlmIChtZXZ0
LT5jb25maWd1cmFibGUpDQo+ID4gKwkJCXNlcV9wcmludGYoc2VxLCAiJXNfY29uZmlnXG4iLCBt
ZXZ0LT5uYW1lKTsNCj4gPiArCX0NCj4gPg0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0K
PiA+DQo+IA0KPiBXaXRoIHN1YmplY3QgYW5kIGNoYW5nZWxvZyBjaGFuZ2VzOg0KPiANCj4gUmV2
aWV3ZWQtYnk6IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0dGUuY2hhdHJlQGludGVsLmNvbT4NCg0K
VGhhbmtzDQpCYWJ1DQo+IA0KPiBSZWluZXR0ZQ0K
