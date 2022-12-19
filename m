Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA89A651390
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiLSUAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiLST77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:59:59 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA43F11C22;
        Mon, 19 Dec 2022 11:59:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g80V5fKRhi2MNDafHyMW92YLZzpxN6y1OFwajMmhf7s4j6z3pyo8u+VBzfxiFwU0979ZXb8XFJBmdp8wZcvhdqmHe5GBmU3AUXL9vgObBGN0XYgyFv1BQYj7YEf/OmlrilV80BBY9njKN+RVtersAuL/A0IN0KC6peKbXbcuhqBItHoARXa02VWU2y7giZKZzPYMF1jBxqGdJ+4RhPgnvpreWqaaGZfjycgk6kkxMD+Z1dSG+TzsVUd5dqy3HRs4ZHuA7m8AerQX+0Ip31ZhljvefoNFhrhlFVltIGjusbpqjmaTPINVOEBu/brpQOPz7s3HFytJFWnB1nX0kTqdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9sj7/6thCWB7Te/EL1Y6MN5ZvK2hNYAOdWtd8rZGjo=;
 b=X00s2n57/Mxqz8UU+TyWBPRtPoDDT48dcJOE8sJaBn/EU7IJwlMz4+vLd4vzVzIi8M7RbpiV73vJOHPxz7c31np97adr9ZCtmJ6sOTITq67Y1XIbqXkARmMtD87YlICvey+LfMFaqFkMzrqrU0Q+5d1niHOTd8nC+AK2rvQ+qlH6MP4/YNDvU7vnulOuQyLgwmfAafWPB3VDBaaOJyMtt6t2GYBb+FuIHDgRbGDJc1Yc7RqRqsp5e5cT7b4b2zsLrrDh5kGsmJHBybzAUtYo1xN/luBeH/NH+dCZL0XmH691QvgZEjhlNOcHT8hVuLkxkCgp8mZTp9Q9bNakdzQwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9sj7/6thCWB7Te/EL1Y6MN5ZvK2hNYAOdWtd8rZGjo=;
 b=bb7Vv2apY6/SWHsUgFYdoNlwbhSCEvRq0+6xwMMLb/deodeT6qhE05UN98jE8HuHLwbYohbYpeJgjmJxZclE4R/3XcqfEYypoQvFqVeoPJcIiSub/thgB8obq0iwd5aI9dBigynJp4alnQpwnZWtJ0dLjo4nLAR/oYuDYnkUpW4=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 19:59:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 19:59:51 +0000
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
Subject: RE: [PATCH v9 12/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Thread-Topic: [PATCH v9 12/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Thread-Index: AQHZBZrX8wUn+2aoCUy5y0njSK2IGK5vWlQAgAZjCTA=
Date:   Mon, 19 Dec 2022 19:59:51 +0000
Message-ID: <MW3PR12MB455332539171D4A7465C090E95E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990904972.17806.4220672882391241296.stgit@bmoger-ubuntu>
 <27680a78-d9c1-b86b-8aa4-38245d0547d7@intel.com>
In-Reply-To: <27680a78-d9c1-b86b-8aa4-38245d0547d7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T19:58:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6f4c319d-8748-4769-abbc-e88a135707b0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T19:59:50Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d64bfa31-c315-40a3-a9eb-a5af96af1c0d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|LV2PR12MB5989:EE_
x-ms-office365-filtering-correlation-id: 38a4e415-43a4-49b3-0653-08dae1fb9759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5F2NBWWkZ7kRPpYMR3QEU4kb6YvUBjFJsXFHwLlDUPy/j8Vo5SC78k5HJH3dgP8P+lgIGtfnJavrOdpSiXRMSBbghedIxyi+JgG/CcWm58jl4e0d5tsjRGVsCWgDk5/SmFvPLKf++4IhtBQ+4IP+q6iW81sPUHuzmGEBCg7vTCKH+bRCCgwB0kf5NFPnfVA3b+ycaF+c1tFBdfHnFhXMUCN/aV+1+7bnexo7mGRVq28rmxFbQSV3amU4FtwuA2PE14lq+GyfDof9Sub4Tse4h8P8czRNbOebvapHDw5FJ0zuwvRnz3AzHDryvWgKS9mSyvtrXZXXAHh701bw0bkNO5Iuipt4YV9VnxqELTGh3sF07oB7gjVTzhmEMb7INPDZZjo7G211wmCsIStjVcrg1lZaUBC2XiztBVOJoBxHCxpcQwVhp73uD01pDrbLdYRhxsAa5nyXjKWaitxqeJwa45+x5mcY0hb312Do/ecVaFLhxL3EI9dqczZHXBtOF7C/zHAQUxDx09tWfQCK++X2gmaSP4vNnYQ8uAMO+9n6qlfIg+K0HTY2RL0iGoqZu82s1R5kwI/zoXU1tGQ3J6YBq0YodwOfRXrpqw2ysQt3cRr6SWK+VZpJw7cABfTd3wa6gY++CVrVQHWGgoICZ1ETieLbry/MoGexa4HzFVh/b3x+Y628+Rx+qkPe/d/jCECTSUaFbjfQmQBPxcKiCNjcSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(478600001)(71200400001)(6506007)(66476007)(7696005)(9686003)(76116006)(26005)(186003)(55016003)(110136005)(86362001)(54906003)(66446008)(66946007)(66556008)(64756008)(316002)(8676002)(38070700005)(38100700002)(41300700001)(4326008)(122000001)(2906002)(83380400001)(52536014)(33656002)(53546011)(8936002)(5660300002)(7416002)(7406005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N052S2ZLV1hKRHc5OU5WeGJBWEJsWUNGcDd4a2VMeFZNNSswdGZTSEJaRlRJ?=
 =?utf-8?B?YnVhTW1lNm5GVlpGVmNWSnFmN0QwalhkWEVIaTYxZEJFQjNmQmhTRzVkbzN4?=
 =?utf-8?B?cWVtem45T0xQZTdsTEJWTll1OXVIb2g0bHVSbU16Y0FvTTZRZE0rUFdZUUlu?=
 =?utf-8?B?UDRVME9qb3AxT1RBWXFxRVhPakt2SmgrWjFvTXEveisrN0FxRHFOOVlvenFE?=
 =?utf-8?B?WWpFOUwwUWNGNkh0TlpGd003aWMrM1JxcUlxcmxWRENla1VCTGJNQjM2RmJG?=
 =?utf-8?B?TXZYNFFuU016UzZvUmw4MVNSQm5rcE4rQ1A3cUZhVGVzSVBPSzRqa0xYZVhT?=
 =?utf-8?B?OFEzMW9NMVNwc254WE1yQU45MWg0b0VZMkpiaTJUaEhGQjY4VXJVdTJIUyt6?=
 =?utf-8?B?dHcxU0FiWm1DZDFTWWJwN0t0Sy9CbEVNTnM1bEJPc0V0ODhMY1M4QkpFR1BV?=
 =?utf-8?B?YS8zamhqbENzU0hRczVtTk5RTlFyb1kreEREWlBPcml2bG9WZTkxSUdvZnpt?=
 =?utf-8?B?enJRQnZ5NVZkN3FLY0Y5SlpRZ3d1UTdCUXp0MTdyemliK2dybHFRQnUxL1Ir?=
 =?utf-8?B?azAwaVQzMmJLSXBpQVF0TTZaaklIeWFKTlh1bCtZbDdmMExBRng5UUt0Nktn?=
 =?utf-8?B?cWVhdnkzZGVPOG9sQWd3L0tEWWp3cmRoQmdhRUdyd0lFcVRkeE80bGRLUHEv?=
 =?utf-8?B?N092aFhsOGVReHdOcldMalVPNkhXV2xIdnA2c24rU3hVWTNEK2cxREYrS1Zr?=
 =?utf-8?B?bjkwM2EwSDV5MW5lMktvdTJMaTRFNElFVDRBOFJybno1dm9aeEZERzZSK294?=
 =?utf-8?B?OEQ2UlhHRFZrM1p0cHJVY2lLenNROUNXcHVoaFd6RVhzZmI5VUZmZEw0NVRx?=
 =?utf-8?B?bmtIOWxIY3pPcWRYejJib3pBRnhoSXlneXJXNDFZOXpscHYvWU9zdTZoV245?=
 =?utf-8?B?YlMrUW9KQk9kdWdITzNCWTVPaG5lQ2lCOTY1NnlNb0E2M2xNaVpXb0hhM0Er?=
 =?utf-8?B?QkNXczN0QXljTkMyWERMbGNrL1VLQXh2b09MQXBXZDJJT0p5TGcwSlE3SFVI?=
 =?utf-8?B?V3ZCS0dxWkZmZFhxaXlRZVQzME1RSHA5dDlMcFdNZUJ0NnpLMno0QWo2Y1FF?=
 =?utf-8?B?cXRJRWd5bk9kRmx4a0dhMXVqaThKbjRwTkpDU2JVWlhzYldSakd0L3BSekFu?=
 =?utf-8?B?RW5wY0pIdFZnV0R0UUV2YnNUUElUbFZjbjc0MUNGREhJTUFTQ2p5QzJGODZR?=
 =?utf-8?B?c25DZVpHWWh4T2FNRGZZRWNYck53azcwT25CRGpoSExqS2MyQ0lCdVM4Rlhp?=
 =?utf-8?B?SmdqdXlkYmFlT2krMVhCQVZIUXd1eDhJVTNhb0hLd3ozbjZPbk9EelZrWXlP?=
 =?utf-8?B?bDNXQkJ0Wk9oU2RlTUNHanBMRGM1S3V5Zm1EbmhVNkVLOHVwczVZKzlFZUZP?=
 =?utf-8?B?cXRRMzQxc010Qzdya1lBY3VvcGtxcmR4eFJ3bUcvbjY3eTNRNks0SzVLVXQ3?=
 =?utf-8?B?RkU4Tzk4R1FhMjYweVQ1aVJZZWNoN09Rc0VoQzdDYmV0K04wbGJPcEcrYXZj?=
 =?utf-8?B?ZitlRG90Vk4wZFFTc2xOVDEwN2Q3eEt4T3RrOWh2amF1SWNZM21VNmhCR2g1?=
 =?utf-8?B?THlmNUVjVW0rbW5CTlA2T01rSmY0Rk5SSWZOc0VhQjBGcTlMRTFKYTk4Umxw?=
 =?utf-8?B?SWlvdUI3c2JSaGRJVmtKY0RQU0h3d01kR1B0TkRnV253bG9HaktkZFA5ckVl?=
 =?utf-8?B?eU1FUDB2cE0vZHdPbyt5TmYyYUJ6VGhqNWZ6aVNpeXNISW1WUCswRENrd216?=
 =?utf-8?B?cm5OSU54TkpyamVjUE1PVkVma0FHVUZ0RUk2WlJudlQvWUtUbGpmeE9uNkpN?=
 =?utf-8?B?Y2RQYktySnRqM2RoV1ZwVnVEc0QzVGtCN2RuMUxTS1l4dDVCMDdVbU9KQkh1?=
 =?utf-8?B?bG8ybi9rZXd5NDE0M1JTTjRZbFFaYjJ4VDdLWmEwZXdONnV4dkFUYkpuU3Ir?=
 =?utf-8?B?VmVMcFpsTUs4ZHpYdk9JeTQrVWo0MHd1RUJBZTZVYlZTZ1V4ZTV1SWJlTHg0?=
 =?utf-8?B?bE5tZk9MTG1PblZKTEo2T3ltc29wYUVIYkZDYnhxWjM2TGxUeGlpZ0t4WmNJ?=
 =?utf-8?Q?nhR4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a4e415-43a4-49b3-0653-08dae1fb9759
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 19:59:51.8425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0znG9TKaWzkNMr/7hJcUAlyu4mEIfyygaiTRnOZiV4qQ2/I6vY3Hx8MM25V9srfJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
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
IDEyOjI3IFBNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0
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
ZXRlcm5ld21hbkBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMTIvMTNdIHg4
Ni9yZXNjdHJsOiBSZXBsYWNlIHNtcF9jYWxsX2Z1bmN0aW9uX21hbnkoKQ0KPiB3aXRoIG9uX2Vh
Y2hfY3B1X21hc2soKQ0KPiANCj4gSGkgQmFidSwNCj4gDQo+IE9uIDEyLzEvMjAyMiA3OjM3IEFN
LCBCYWJ1IE1vZ2VyIHdyb3RlOg0KPiA+IFRoZSBjYWxsIG9uX2VhY2hfY3B1X21hc2soKSBydW5z
IHRoZSBmdW5jdGlvbiBvbiBlYWNoIENQVSBzcGVjaWZpZWQgYnkNCj4gPiBjcHVtYXNrLCB3aGlj
aCBtYXkgaW5jbHVkZSB0aGUgbG9jYWwgcHJvY2Vzc29yLiBTbywgcmVwbGFjZSB0aGUgY2FsbA0K
PiA+IHNtcF9jYWxsX2Z1bmN0aW9uX21hbnkoKSB3aXRoIG9uX2VhY2hfY3B1X21hc2soKSB0byBz
aW1wbGlmeSB0aGUgY29kZS4NCj4gDQo+IFBsZWFzZSBtb3ZlIHRoZSBzb2x1dGlvbiB0byBhIG5l
dyBwYXJhZ3JhcGggYW5kIGRyb3AgdGhlICJTbywiLiBUaGUgdHdvDQo+IGluc3RhbmNlcyBvZiAi
dGhlIGNhbGwiIGNhbiBiZSBkcm9wcGVkIGFsc28uDQoNClN1cmUuDQo+IA0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KPiA+IC0tLQ0KPiAN
Cj4gQ291bGQgeW91IHBsZWFzZSBtb3ZlIHRoaXMgcGF0Y2ggdG8gdGhlIGJlZ2lubmluZyBvZiB0
aGlzIHNlcmllcz8NCj4gRml4ZXMgYW5kIGNsZWFudXBzIHNob3VsZCBnbyBiZWZvcmUgbmV3IGZl
YXR1cmVzLg0KDQpTdXJlLg0KDQo+IA0KPiA+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwv
cmR0Z3JvdXAuYyB8ICAgMjkgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gPiBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jDQo+ID4gaW5kZXggNjg5N2M0
ODBhZTU1Li42OGUxNDgzMWE2MzggMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2Nw
dS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0
cmwvcmR0Z3JvdXAuYw0KPiA+IEBAIC0zMjUsMTIgKzMyNSw3IEBAIHN0YXRpYyB2b2lkIHVwZGF0
ZV9jcHVfY2xvc2lkX3JtaWQodm9pZCAqaW5mbykNCj4gPiBzdGF0aWMgdm9pZCAgdXBkYXRlX2Ns
b3NpZF9ybWlkKGNvbnN0IHN0cnVjdCBjcHVtYXNrICpjcHVfbWFzaywgc3RydWN0DQo+ID4gcmR0
Z3JvdXAgKnIpICB7DQo+ID4gLQlpbnQgY3B1ID0gZ2V0X2NwdSgpOw0KPiA+IC0NCj4gPiAtCWlm
IChjcHVtYXNrX3Rlc3RfY3B1KGNwdSwgY3B1X21hc2spKQ0KPiA+IC0JCXVwZGF0ZV9jcHVfY2xv
c2lkX3JtaWQocik7DQo+ID4gLQlzbXBfY2FsbF9mdW5jdGlvbl9tYW55KGNwdV9tYXNrLCB1cGRh
dGVfY3B1X2Nsb3NpZF9ybWlkLCByLCAxKTsNCj4gPiAtCXB1dF9jcHUoKTsNCj4gPiArCW9uX2Vh
Y2hfY3B1X21hc2soY3B1X21hc2ssIHVwZGF0ZV9jcHVfY2xvc2lkX3JtaWQsIHIsIDEpOw0KPiA+
ICB9DQo+ID4NCj4gPiAgc3RhdGljIGludCBjcHVzX21vbl93cml0ZShzdHJ1Y3QgcmR0Z3JvdXAg
KnJkdGdycCwgY3B1bWFza192YXJfdA0KPiA+IG5ld21hc2ssIEBAIC0yMTM1LDEzICsyMTMwLDkg
QEAgc3RhdGljIGludCBzZXRfY2FjaGVfcW9zX2NmZyhpbnQgbGV2ZWwsDQo+IGJvb2wgZW5hYmxl
KQ0KPiA+ICAJCQkvKiBQaWNrIG9uZSBDUFUgZnJvbSBlYWNoIGRvbWFpbiBpbnN0YW5jZSB0byB1
cGRhdGUNCj4gTVNSICovDQo+ID4gIAkJCWNwdW1hc2tfc2V0X2NwdShjcHVtYXNrX2FueSgmZC0+
Y3B1X21hc2spLA0KPiBjcHVfbWFzayk7DQo+ID4gIAl9DQo+ID4gLQljcHUgPSBnZXRfY3B1KCk7
DQo+ID4gLQkvKiBVcGRhdGUgUU9TX0NGRyBNU1Igb24gdGhpcyBjcHUgaWYgaXQncyBpbiBjcHVf
bWFzay4gKi8NCj4gPiAtCWlmIChjcHVtYXNrX3Rlc3RfY3B1KGNwdSwgY3B1X21hc2spKQ0KPiA+
IC0JCXVwZGF0ZSgmZW5hYmxlKTsNCj4gPiAtCS8qIFVwZGF0ZSBRT1NfQ0ZHIE1TUiBvbiBhbGwg
b3RoZXIgY3B1cyBpbiBjcHVfbWFzay4gKi8NCj4gPiAtCXNtcF9jYWxsX2Z1bmN0aW9uX21hbnko
Y3B1X21hc2ssIHVwZGF0ZSwgJmVuYWJsZSwgMSk7DQo+ID4gLQlwdXRfY3B1KCk7DQo+ID4gKw0K
PiA+ICsJLyogVXBkYXRlIFFPU19DRkcgTVNSIG9uIGFsbCB0aGUgQ1BVcyBpbiBjcHVfbWFzayAq
Lw0KPiA+ICsJb25fZWFjaF9jcHVfbWFzayhjcHVfbWFzaywgdXBkYXRlLCAmZW5hYmxlLCAxKTsN
Cj4gPg0KPiA+ICAJZnJlZV9jcHVtYXNrX3ZhcihjcHVfbWFzayk7DQo+ID4NCj4gPiBAQCAtMjYx
OCw3ICsyNjA5LDcgQEAgc3RhdGljIGludCByZXNldF9hbGxfY3RybHMoc3RydWN0IHJkdF9yZXNv
dXJjZSAqcikNCj4gPiAgCXN0cnVjdCBtc3JfcGFyYW0gbXNyX3BhcmFtOw0KPiA+ICAJY3B1bWFz
a192YXJfdCBjcHVfbWFzazsNCj4gPiAgCXN0cnVjdCByZHRfZG9tYWluICpkOw0KPiA+IC0JaW50
IGksIGNwdTsNCj4gPiArCWludCBpOw0KPiA+DQo+ID4gIAlpZiAoIXphbGxvY19jcHVtYXNrX3Zh
cigmY3B1X21hc2ssIEdGUF9LRVJORUwpKQ0KPiA+ICAJCXJldHVybiAtRU5PTUVNOw0KPiA+IEBA
IC0yNjM5LDEzICsyNjMwLDkgQEAgc3RhdGljIGludCByZXNldF9hbGxfY3RybHMoc3RydWN0IHJk
dF9yZXNvdXJjZSAqcikNCj4gPiAgCQlmb3IgKGkgPSAwOyBpIDwgaHdfcmVzLT5udW1fY2xvc2lk
OyBpKyspDQo+ID4gIAkJCWh3X2RvbS0+Y3RybF92YWxbaV0gPSByLT5kZWZhdWx0X2N0cmw7DQo+
ID4gIAl9DQo+ID4gLQljcHUgPSBnZXRfY3B1KCk7DQo+ID4gLQkvKiBVcGRhdGUgQ0JNIG9uIHRo
aXMgY3B1IGlmIGl0J3MgaW4gY3B1X21hc2suICovDQo+ID4gLQlpZiAoY3B1bWFza190ZXN0X2Nw
dShjcHUsIGNwdV9tYXNrKSkNCj4gPiAtCQlyZHRfY3RybF91cGRhdGUoJm1zcl9wYXJhbSk7DQo+
ID4gLQkvKiBVcGRhdGUgQ0JNIG9uIGFsbCBvdGhlciBjcHVzIGluIGNwdV9tYXNrLiAqLw0KPiA+
IC0Jc21wX2NhbGxfZnVuY3Rpb25fbWFueShjcHVfbWFzaywgcmR0X2N0cmxfdXBkYXRlLCAmbXNy
X3BhcmFtLCAxKTsNCj4gPiAtCXB1dF9jcHUoKTsNCj4gPiArDQo+ID4gKwkvKiBVcGRhdGUgQ0JN
IG9uIGFsbCB0aGUgQ1BVcyBpbiBjcHVfbWFzayAqLw0KPiA+ICsJb25fZWFjaF9jcHVfbWFzayhj
cHVfbWFzaywgcmR0X2N0cmxfdXBkYXRlLCAmbXNyX3BhcmFtLCAxKTsNCj4gPg0KPiA+ICAJZnJl
ZV9jcHVtYXNrX3ZhcihjcHVfbWFzayk7DQo+ID4NCj4gPg0KPiA+DQo+IA0KPiBTaG91bGQgdGhl
IHNuaXBwZXQgaW4gcmVzY3RybF9hcmNoX3VwZGF0ZV9kb21haW5zKCkgYWxzbyBiZSB1cGRhdGVk
Pw0KDQpZZXMuIEl0IHNob3VsZCBiZSBjaGFuZ2VkIGFsc28uICBXaWxsIGZpeCBpdC4NClRoYW5r
cw0KQmFidQ0KPiANCj4gUmVpbmV0dGUNCg==
