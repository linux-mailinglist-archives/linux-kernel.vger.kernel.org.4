Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36329651375
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiLSTvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiLSTv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:51:27 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1382BE5;
        Mon, 19 Dec 2022 11:51:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOpZgEz0tJc7djG/b8MCr0y63clfq2qFzzFeMUe/LTw2Gr8Dgu8nztt2Lpvopu/VW4gdJNR3FBOFhPEry5/CONkTtMTFs/O52fn8/+nVwaEn032l9Iss3gRHVIivxNvQIbwS4h7qH2e7GaGEmQP01HGqapsciF4Y+YSOg0vtvdZ6x9lTj6WqT7x2/CjIT1Av6Nu4eLG0sVq1JkO2zHYC5/YK90T0fzKyPuiwOpPEB2i6LEunF8UDBdRK0XN0xBcub+o15YJwvcr2YztZ6ZLlg2EexmRoDVI9w1YQ86u6gYjOYYrh7bTqIaKIEM5D1j/T6Pe7gw0ba0/InluxMdJSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkop/abPRNTjxGTjHz/FqYNkpDj18WDwwM9Pv1ADPGw=;
 b=B8JTPN7ozoxNyEQj67bJDsSE1u4QvR2Nl315mTzFczs/9YDyV5Uax9Bp7MlVPyAbEbYwCz0Stb1FBVZXUoSFMoynjiR7mCqWHn3j6pMPXOmmeB5qMNymI7FZWSaUqs7a5wmHl/p3zjXXn67Alqq53XMADVfNJzPIPByHgxOLaCaMVsVxP3buZSybTCZ5qLDS5H5+nvlpMVRw46xdgVOaQsyR44cUZCO1JkGYWSGUs1So7QQ2v4wLpKhwbNOBnqi7SNhHONzG4Q3mxmpq1aiOpnzjt/f0HlNx6Cfee3A99CDL/frNFBGEuVZTIg8jBx4SPvJNAnW2udTx+IMuG4QfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkop/abPRNTjxGTjHz/FqYNkpDj18WDwwM9Pv1ADPGw=;
 b=oIjlNK/FUauhnYDLdXL+2RhBwSSa9jEly6iL8af1stX1MGpi0b80IraZVnykfJBZl6u+Md91DceOS9VdHq74pOzki8XjvHupuaOY8OrOyRXI3YKysvqy0haIX9qlEnTm4cUX1PoL4onyrQrwDEPVtks3nJnIQlKfsXMMe3YBgrM=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 19:51:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 19:51:23 +0000
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
Subject: RE: [PATCH v9 11/13] x86/resctrl: Add sysfs interface to write
 mbm_local_bytes_config
Thread-Topic: [PATCH v9 11/13] x86/resctrl: Add sysfs interface to write
 mbm_local_bytes_config
Thread-Index: AQHZBZrU3dsS5MqoSkKA4lGKGJAHea5vWguAgAZhJGA=
Date:   Mon, 19 Dec 2022 19:51:23 +0000
Message-ID: <MW3PR12MB455360DC63B348EBEDDC9A7B95E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990904243.17806.8875872967137007418.stgit@bmoger-ubuntu>
 <819f31d8-5fe0-908e-9861-f4ec36105cd6@intel.com>
In-Reply-To: <819f31d8-5fe0-908e-9861-f4ec36105cd6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T19:50:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=91b86c81-8ec0-4db0-8fbd-ed387e22832e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T19:51:22Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3db9e1cf-7aea-4c87-9d24-1df65d0a708d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|LV2PR12MB5752:EE_
x-ms-office365-filtering-correlation-id: afac4797-b415-4d8c-e184-08dae1fa6878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 623h33IhlXMiOhDrB0HQ1u0Daz8Q7RggtW2g0Hr4Vv0dosVP9owbhWdf/s046aOl7tZnrcCp1MC33oXkfgxZEOjn+uv+KB2oBzRC5koyGADjAwN9XM0PxXAuwj9VGuqkvWWbSJ5/kP9SLS4mubnfvuP2i5fRwLtp5G+Q2qcFNV4s4hl0Hxvxgi98eFmupwEpB8mw4sk4HMorCBLtXOSGxz5ReAnR/SGwE6Ep2eShzk+itmIITOelXp7FnsczmL6FYEy5NkaBlKYhUkDC/l596xRhPB3O2Qp7G4g98tNRfJg/MkCxhnmkPVQfcIKzPQogDsGsYmtA/Oh4Y2spIpi+bnOuK0e37OandYrTIa7/hVEkzVx2IJlxImDSAD+Hpzvb0ZfeTCopSbxKDtj6L9khy0yHpRBSY5bA62n8c3D3a3rzbvuTpMhLSMG3WhYQ51SmSc7mP2uSDN3dkarCPLFfZdw5MrsWIm1e7BFneSOnjbDZ6fUL8lKUqPhCR5EzO3lweOBTmT6ii5DJzpMdsJstVu3Kg+cbuBvXToJTvCetEelkczrdMVG1gyL14ybvP010cwDJ5jpixYczOnn4REMGAnTnw/TQZhhutCG6v7iYhmJnRSFKo/xx6280DlLT/xUiRftaDVahfSqmMxYTWbVVpoQCDYixO/T0IVssx5rX6buPZN7x4dRF5pPpuT5jvvFPS8RGEEiEL602QlwKDLIT1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(478600001)(71200400001)(110136005)(54906003)(76116006)(7696005)(316002)(53546011)(6506007)(8676002)(66476007)(66556008)(64756008)(66946007)(66446008)(186003)(26005)(9686003)(4326008)(8936002)(52536014)(7416002)(41300700001)(5660300002)(7406005)(83380400001)(2906002)(38100700002)(38070700005)(122000001)(33656002)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjZ0OGtWQ0lwZll3a05ZSGlqR0V2Zkx0MndBUytXazVhNXdpdUwvUlA1U29p?=
 =?utf-8?B?RUx4VCtxb1NjQXVFQmc0RkhSeFNIRWZpMFpxZzlUdWgyemxDMVFzSDU3S255?=
 =?utf-8?B?eWpyKzljRFpEN0RzS1hCVUF6bzhyZWMwUEdsYnZlemdlWWZ4UCt1dXFKMlkw?=
 =?utf-8?B?OFF6Nm5aRVE4SEhTaTBCVnlTcnNOVkF5b2lacm9jMnBHQU9XOTYzWUZxdGcr?=
 =?utf-8?B?VlVINHFxSXdTZkkrTFhkcm1XR1dNTng1YXE5QUFZVHZabmUxSHpqSkg4SWJk?=
 =?utf-8?B?WkJtaEUyQ0JjNjd0ZjBqZEtCdXlUQlhvSDJqanZzb0U0M0ZOeXlUcTB6a3Rr?=
 =?utf-8?B?bFJpQTFIa3R1djdKMmNBZW1sU1M5RXp2MXgxNXJjL0E4RWJ2T0wzREw4azNl?=
 =?utf-8?B?RjlsM0lXUCtIRmlBeG1mUjZiSUFURGhqQS9LVkJyS2xiOXdMRVdLTmRDcmRT?=
 =?utf-8?B?MTdoM0g2UHN0RXM3NnMwbG5JeWE5N2JvMUF2N2tGNWdYY2x6QlRTS0JqTjB3?=
 =?utf-8?B?ZkU1aFVRM25STGNUak92UzNuTmtGbDhLb3dSV2JuSDBlVXVqRHRtM1FsQVJj?=
 =?utf-8?B?MFNtVldVNE5UVmVZS0RtbHJkZ1NZV0NXcVlEUFdDLzUxRHVFeERjM1o3eTFi?=
 =?utf-8?B?dU5iLyszemJPR2tOYkNUYXFNVzhIb05KbzdPbjZrdVplT2dJdzE3akVvbVRR?=
 =?utf-8?B?NVpMYWdIeENjVTVXT1JvZWU4VTBnVzZYb2xGN1RNQWJhQmY4ai9SdFBpNkRI?=
 =?utf-8?B?UFdaQVVLOUsyRlNKR1V4UVlYTVJFQ0Z6WVBsdjBaOUd3NVp1QzVmaUVDZEVD?=
 =?utf-8?B?ODZTekI5RHUreU85QWg2OWdlbUR5dUNzaElFZ2xWNHJkNW53aFYyTTJGYjJE?=
 =?utf-8?B?TndvbVBNMXFlZ3N4WU1wVTJueXFVYTdKaTdaT25aOGkrRk1lVWdBdEc5MnIz?=
 =?utf-8?B?b1ArSFQ2VktIMW1kSHZDWW5DRjRYYlNiVklXa3RNSGtneTBLZytrRXQyakpQ?=
 =?utf-8?B?dU1VRkNiS0xYM0l0eUU5Sy9Vdm16QkF1RUowYkNWNzczc1plKy9VL2l0UGpo?=
 =?utf-8?B?cGlnOCtyY2JpeExiQ3hvYjdRQ3pMMEM1S2t1b3pLeCtCeDBRWXh4OUc0NEEv?=
 =?utf-8?B?Qk5uTDdnRlM0bnNVMEE1VTVXYlZWNEh4ZGl4bFFRa25UQkdmSi9DcjQwUWlL?=
 =?utf-8?B?SDVOenVLM214dVVoS1QvalNsc1VQSitteTkwc1FwclBHTDhHaGhxamRBTlk2?=
 =?utf-8?B?azV5alN3citBdlo0TkZtR0dsbFNOT3VrZDU3VnN0NGdkYURVdE1DQXY4eGZ0?=
 =?utf-8?B?TDBlNDhJdXMrMS9VRGJXclFSb1FwUVZIUHBRMTJaQ2xjNmhkbkVzcjFJT3Zp?=
 =?utf-8?B?NzBwbHJZTEpLYThEV01oMjVTYXZ2OFN1emFuVmdlanVDdDJMNzI1dGZORlZw?=
 =?utf-8?B?VVdTWFJwTEg2RnBJUytZcklTWFJMSEo3TU1vSWlYNi8rMHFrRWdIQmtaWVVT?=
 =?utf-8?B?ZFlTYWNwTFAzVldmOXl2aDA1SHU4REJIK2RhSXozMFhsUHVNRE82MG9OeG9h?=
 =?utf-8?B?bXpnWStyV0hWWk9BcnVhNDJKZitCM0tVeEVkbVhZelB6MkJUemNxVGVlL2d3?=
 =?utf-8?B?Y2JOUTc3aGdBdW9GOW5NZXNHUHRPRkM5R1hKL2M1ck43TGdJTGorSTJqZEtJ?=
 =?utf-8?B?bzJ0WmRVc2ZnbHhHZVZCY3V0YkNKSmp6cGFwUk1jOHpNaWRLRGt3V2p2ajl5?=
 =?utf-8?B?RUR3bjVNZ05tODkyc2RSSWlKRU9lL2hwYUZzaHFoS3FLUXQ1MUhLSU5GbWhj?=
 =?utf-8?B?cWZLVWR0WnQxYU94cGlUVGhZNkdGbWVZaXNCYmMwTFlXZGh5STdUSlRpZk5q?=
 =?utf-8?B?SlRpVWlhNHo4Y3dCWXFGamgvZGtLZnNlQ0U2WUpjUGNnR003K3UybkFDNk9u?=
 =?utf-8?B?NHFiZ244MU9sVHgrNHdEMy9SbHNSTmppU2NQMHYyVmxKdEMzMERtR1JvcmVp?=
 =?utf-8?B?SXhwczA5alZNdm54QURUWTVtRHNzc3VNZjk4a2lVSU5ySGRVTEd4R2dsRG42?=
 =?utf-8?B?aXpVS2w1NzdURWRoSXQ5ZE1lUGpXczAreDJjYWlQNjQ5ekxYVktIWDBQeWMv?=
 =?utf-8?Q?nnmI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afac4797-b415-4d8c-e184-08dae1fa6878
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 19:51:23.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tw407/T2Cy0OFrInl1XKMJd8kKH+veXdMN/fL/lTAHE7KNH7FMwpDgj0ZWrbg6xm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
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
IDEyOjI2IFBNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0
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
ZXRlcm5ld21hbkBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMTEvMTNdIHg4
Ni9yZXNjdHJsOiBBZGQgc3lzZnMgaW50ZXJmYWNlIHRvIHdyaXRlDQo+IG1ibV9sb2NhbF9ieXRl
c19jb25maWcNCj4gDQo+IEhpIEJhYnUsDQo+IA0KPiBPbiAxMi8xLzIwMjIgNzozNyBBTSwgQmFi
dSBNb2dlciB3cm90ZToNCj4gPiBUaGUgY3VycmVudCBldmVudCBjb25maWd1cmF0aW9uIGZvciBt
Ym1fbG9jYWxfYnl0ZXMgY2FuIGJlIGNoYW5nZWQgYnkNCj4gPiB0aGUgdXNlciBieSB3cml0aW5n
IHRvIHRoZSBjb25maWd1cmF0aW9uIGZpbGUNCj4gPiAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MM19N
T04vbWJtX2xvY2FsX2J5dGVzX2NvbmZpZy4NCj4gPg0KPiANCj4gU2FtZSBjb21tZW50cyBhYm91
dCBzdWJqZWN0IGxpbmUgYW5kIHVzYWdlIG9mICJjdXJyZW50Ii4NCg0KU3VyZSwNCj4gDQo+ID4g
VGhlIGV2ZW50IGNvbmZpZ3VyYXRpb24gc2V0dGluZ3MgYXJlIGRvbWFpbiBzcGVjaWZpYyBhbmQg
d2lsbCBhZmZlY3QNCj4gPiBhbGwgdGhlIENQVXMgaW4gdGhlIGRvbWFpbi4NCj4gPg0KPiA+IEZv
bGxvd2luZyBhcmUgdGhlIHR5cGVzIG9mIGV2ZW50cyBzdXBwb3J0ZWQ6DQo+ID4gPT09PQ0KPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiA+IEJpdHMgICBEZXNjcmlwdGlvbg0KPiA+ID09PT0NCj4gPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiA2ICAgICAgRGly
dHkgVmljdGltcyBmcm9tIHRoZSBRT1MgZG9tYWluIHRvIGFsbCB0eXBlcyBvZiBtZW1vcnkNCj4g
PiA1ICAgICAgUmVhZHMgdG8gc2xvdyBtZW1vcnkgaW4gdGhlIG5vbi1sb2NhbCBOVU1BIGRvbWFp
bg0KPiA+IDQgICAgICBSZWFkcyB0byBzbG93IG1lbW9yeSBpbiB0aGUgbG9jYWwgTlVNQSBkb21h
aW4NCj4gPiAzICAgICAgTm9uLXRlbXBvcmFsIHdyaXRlcyB0byBub24tbG9jYWwgTlVNQSBkb21h
aW4NCj4gPiAyICAgICAgTm9uLXRlbXBvcmFsIHdyaXRlcyB0byBsb2NhbCBOVU1BIGRvbWFpbg0K
PiA+IDEgICAgICBSZWFkcyB0byBtZW1vcnkgaW4gdGhlIG5vbi1sb2NhbCBOVU1BIGRvbWFpbg0K
PiA+IDAgICAgICBSZWFkcyB0byBtZW1vcnkgaW4gdGhlIGxvY2FsIE5VTUEgZG9tYWluDQo+ID4g
PT09PQ0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KPiA+DQo+ID4gRm9yIGV4YW1wbGU6DQo+ID4gVG8gY2hhbmdlIHRoZSBtYm1f
bG9jYWxfYnl0ZXNfY29uZmlnIHRvIGNvdW50IGFsbCB0aGUgbm9uLXRlbXBvcmFsDQo+ID4gd3Jp
dGVzIG9uIGRvbWFpbiAwLCB0aGUgYml0cyAyIGFuZCAzIG5lZWRzIHRvIGJlIHNldCB3aGljaCBp
cyAxMTAwYiAoaW4gaGV4DQo+IDB4YykuDQo+ID4gUnVuIHRoZSBjb21tYW5kLg0KPiA+ICAgICAk
ZWNobyAgMD0weGMgPiAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MM19NT04vbWJtX2xvY2FsX2J5dGVz
X2NvbmZpZw0KPiA+DQo+ID4gVG8gY2hhbmdlIHRoZSBtYm1fbG9jYWxfYnl0ZXMgdG8gY291bnQg
b25seSByZWFkcyB0byBsb2NhbCBOVU1BIGRvbWFpbg0KPiA+IDEsIHRoZSBiaXQgMCBuZWVkcyB0
byBiZSBzZXQgd2hpY2ggMWIgKGluIGhleCAweDEpLiBSdW4gdGhlIGNvbW1hbmQuDQo+ID4gICAg
ICRlY2hvICAxPTB4MSA+IC9zeXMvZnMvcmVzY3RybC9pbmZvL0wzX01PTi9tYm1fbG9jYWxfYnl0
ZXNfY29uZmlnDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2Vy
QGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRn
cm91cC5jIHwgICAyOQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jDQo+ID4gYi9h
cmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+IGluZGV4IDhhMjJhNjUy
YTZlOC4uNjg5N2M0ODBhZTU1IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
cmVzY3RybC9yZHRncm91cC5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJs
L3JkdGdyb3VwLmMNCj4gPiBAQCAtMTY0MSw2ICsxNjQxLDMyIEBAIHN0YXRpYyBzc2l6ZV90DQo+
IG1ibV90b3RhbF9ieXRlc19jb25maWdfd3JpdGUoc3RydWN0IGtlcm5mc19vcGVuX2ZpbGUgKm9m
LA0KPiA+ICAJcmV0dXJuIHJldCA/OiBuYnl0ZXM7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMg
c3NpemVfdCBtYm1fbG9jYWxfYnl0ZXNfY29uZmlnX3dyaXRlKHN0cnVjdCBrZXJuZnNfb3Blbl9m
aWxlICpvZiwNCj4gPiArCQkJCQkgICAgY2hhciAqYnVmLCBzaXplX3QgbmJ5dGVzLA0KPiA+ICsJ
CQkJCSAgICBsb2ZmX3Qgb2ZmKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgcmR0X3Jlc291cmNlICpy
ID0gb2YtPmtuLT5wYXJlbnQtPnByaXY7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCS8q
IFZhbGlkIGlucHV0IHJlcXVpcmVzIGEgdHJhaWxpbmcgbmV3bGluZSAqLw0KPiA+ICsJaWYgKG5i
eXRlcyA9PSAwIHx8IGJ1ZltuYnl0ZXMgLSAxXSAhPSAnXG4nKQ0KPiA+ICsJCXJldHVybiAtRUlO
VkFMOw0KPiA+ICsNCj4gPiArCWNwdXNfcmVhZF9sb2NrKCk7DQo+ID4gKwltdXRleF9sb2NrKCZy
ZHRncm91cF9tdXRleCk7DQo+ID4gKw0KPiA+ICsJcmR0X2xhc3RfY21kX2NsZWFyKCk7DQo+ID4g
Kw0KPiA+ICsJYnVmW25ieXRlcyAtIDFdID0gJ1wwJzsNCj4gPiArDQo+ID4gKwlyZXQgPSBtb25f
Y29uZmlnX3dyaXRlKHIsIGJ1ZiwgUU9TX0wzX01CTV9MT0NBTF9FVkVOVF9JRCk7DQo+ID4gKw0K
PiA+ICsJbXV0ZXhfdW5sb2NrKCZyZHRncm91cF9tdXRleCk7DQo+ID4gKwljcHVzX3JlYWRfdW5s
b2NrKCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldCA/OiBuYnl0ZXM7DQo+ID4gK30NCj4gPiAr
DQo+ID4gIC8qIHJkdGdyb3VwIGluZm9ybWF0aW9uIGZpbGVzIGZvciBvbmUgY2FjaGUgcmVzb3Vy
Y2UuICovICBzdGF0aWMNCj4gPiBzdHJ1Y3QgcmZ0eXBlIHJlc19jb21tb25fZmlsZXNbXSA9IHsN
Cj4gPiAgCXsNCj4gPiBAQCAtMTc0OCw5ICsxNzc0LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgcmZ0eXBl
IHJlc19jb21tb25fZmlsZXNbXSA9IHsNCj4gPiAgCX0sDQo+ID4gIAl7DQo+ID4gIAkJLm5hbWUJ
CT0gIm1ibV9sb2NhbF9ieXRlc19jb25maWciLA0KPiA+IC0JCS5tb2RlCQk9IDA0NDQsDQo+ID4g
KwkJLm1vZGUJCT0gMDY0NCwNCj4gPiAgCQkua2Zfb3BzCQk9ICZyZHRncm91cF9rZl9zaW5nbGVf
b3BzLA0KPiA+ICAJCS5zZXFfc2hvdwk9IG1ibV9sb2NhbF9ieXRlc19jb25maWdfc2hvdywNCj4g
PiArCQkud3JpdGUJCT0gbWJtX2xvY2FsX2J5dGVzX2NvbmZpZ193cml0ZSwNCj4gPiAgCX0sDQo+
ID4gIAl7DQo+ID4gIAkJLm5hbWUJCT0gImNwdXMiLA0KPiA+DQo+ID4NCj4gDQo+IFdpdGggdGhl
IHN1YmplY3QgYW5kIGNoYW5nZWxvZyBjb21tZW50cyBhZGRyZXNzZWQ6DQo+IA0KPiBSZXZpZXdl
ZC1ieTogUmVpbmV0dGUgQ2hhdHJlIDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KDQpUaGFu
a3MNCkJhYnUNCj4gDQo+IFJlaW5ldHRlDQo=
