Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0076C666651
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjAKWjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjAKWjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:39:09 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC41A395EB;
        Wed, 11 Jan 2023 14:39:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBJNVA0kwMY7//uBQONqnS8TQWgyQhl2WBNuEH84v0myRGS8U6dGihp0IDNeg18z79ka7d0VsXyJdAiFHZo93M26kcS+oQxRdBoFyNAAqi5hmOHu9i2cyVpoA/4wx0ViiaT6sn4DsuEmbCl9n8z5SVOQytcldWYdaqKBcPHGFTHIpEIwW5nne+kuPVDDsXBFmAj10wx+i5htyGrWn4Vlq2E9yJHHpnX4Tx+07boF2aKph0zk8Ma1/JHJIPME5ae2XVMLUhTabNgVW4ZCB301fodgID3TXCIymUcd5Sr1oIV+SgbM76aECmQQWKpewmSS74WwhfSpHQFir/8aPB70xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vgR2ZvEMwNJk37NhernDkpdg846KrsfHO9BDzB9VLU=;
 b=n2fHsWJbYPOSNvKorYABLFt5dTs0E/sYs/fZWtYX1qqlezw01tdtRsTkM7tt81lLCXDUFLRfLVWh3I8fnn+PUc6DKEnbiSLf24R5UobNPMvkyP69oGR5Xbf7xnlp4dgvPT16WIcXd+xkUX2eDwcv9cp2RACUzYJaTCJsMjZPbMB1knOwfU+gNgRlNbJUFbcre/IHuINf+kt4Ef2qAe+RuxDEFebX8BV/rkblpFsWSGAuGBYJCbNE4EGUx33TxkEemDqXSw8/0fpTNsUTtKNpI06GMBb17zvINjfQkcwY4wVEKYnqwN/jmAhQWpH/8ITT2OugUcp7RLQgnn4gc2hTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vgR2ZvEMwNJk37NhernDkpdg846KrsfHO9BDzB9VLU=;
 b=LXtbes1J4uI4M6hYNL+NnnlJNAybmVspiroCi8CX/1YceMKo1UKUjEcXbJPzt+HbplHKQQr7chbfpPK83lnPD8e+tIVuFx7hzpPR0C3+vOt6qc3x6BSryrdSFChQ6hK/AK3YTzGpbDM6xRmySO4MCpZlDSRzlfqOaMnJqntLwA4=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 22:39:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%7]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 22:39:04 +0000
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
Subject: RE: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for new
 features
Thread-Topic: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for new
 features
Thread-Index: AQHZJEmrk2z3hSULUk6NOZBmDO6S+K6ZyWMAgAAHQRA=
Date:   Wed, 11 Jan 2023 22:39:04 +0000
Message-ID: <MW3PR12MB45538E045D655C1D6B3BD02C95FC9@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-14-babu.moger@amd.com>
 <c7d563ce-13d9-ca6b-a5c9-7e08a3cdc3a9@intel.com>
In-Reply-To: <c7d563ce-13d9-ca6b-a5c9-7e08a3cdc3a9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-11T22:32:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=58148cbe-5d0a-492c-a804-864e80ddd188;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-11T22:39:02Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 636cf7df-c90a-4fc6-a3ce-90e8424c85bc
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|CY8PR12MB7146:EE_
x-ms-office365-filtering-correlation-id: fb269eae-a866-4e1b-8aaa-08daf424a491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2iBQyjDyX/TKvnYAFN4EdU/f2VJWzkowzM8ZglxQyliEVxvQsuI9IORTVv4ZdQ+Y7bp7yp2uXrHmWHZNYT+HiuhHxXZmLd0mhFDb90O3bBniMz3O8TulRKpfeHknPTY2CFrRMAKAUtqN9+4Ix/BcojYR86fQ9yqQBGKNkHQvxOAZJ/sH4jXU3Wu1ryFYsuKUOIOmjFA6ekfqltYeIU9CQf2BXx1MBOG8BHYXvUjtdY+yfmoj9pcyNjSyjnsp4PvW8sJa9uTpBIOSSkrGuey0ps7GUtOd7HIb/8djsYWtbWJ8cuHSCO61+d32sbp2iv4gkhvxV+4mpKW1JZ3XYlS9tysQ6Bl8V/fT6hNPeIoSW0X41aMMUFQhrm/VWdaR2nGLfI4GiOoXAPeqoBIzzOSr/h+ppQ5Q2h5PlBsHezRcYzHScJ9OfrPGMLsSPZBrthN0zqJjEtEhpxvOCVrE0sWYj5BapgB/oS8EJVYCpuIaTcxuxKo3kkNbxAjqKhO7jyRUgYC4Jel/dT+4+0HMZ/FB0gBv3Fo0ND423Py7s7ZJg2oN1TLp1y4nb5q2mBfTD+fsUm0Hr1L4aalReNXOe5PrUjZayhvWi6WzURea9VnRktAlAjk9bEXmQFnNk82xTtGz75cJPhiaTqEE2Kltq91v3m/5/lECNOp98JAZxmK8Uj5LcrlCOTPMAPeRNJl3EZp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(122000001)(38100700002)(83380400001)(33656002)(38070700005)(110136005)(86362001)(55016003)(76116006)(8676002)(66446008)(66476007)(64756008)(66946007)(66556008)(54906003)(4326008)(2906002)(316002)(15650500001)(52536014)(5660300002)(7416002)(7406005)(41300700001)(8936002)(9686003)(478600001)(71200400001)(7696005)(6506007)(186003)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0FRckNEc3ZaNXVpSWRySVh0YkZRcEdzTjc0KzdUcUE0cUxYUno3eERLOFAr?=
 =?utf-8?B?cTd1c1c4bmpxOFZMZUpPZXlGM3lRNEdyTHpvVFBBTHFWNmtKTGw1M1lpMXpI?=
 =?utf-8?B?QW9LcUpBNmVSQ3R5UXB6V0k4R0EzWDIzRnR6Z2V2aXh1bWVUcTQ2czdJSG1L?=
 =?utf-8?B?VlUxT25hSlB0Q1ZObHd0TkxRZHNwbHdvR1gyaVRvakFzQ0srUXdOSHUxSWZ6?=
 =?utf-8?B?M0w3THJJV3djaG5Wd1lVU1RQOFh5U3RhY0xCVGxyRzllK243V1dXZUJ3TWhv?=
 =?utf-8?B?RkluM29VZHZvUGs4dTBaOEpqdUdwV2VMUTdKYUNHaVF0OFViSUkvNFR6UXMr?=
 =?utf-8?B?R0Ewc3FrUGxtaFBiQ2VPcTY4ZmxCc0psMWxIcCt0Y3VVR1lJVm1ic1drSGdX?=
 =?utf-8?B?YUxtekJOWnd4RklOQnEvYk9ZUFhBVCtiNVh5cnk0Vm1mcjlReE9oY1lOaHhT?=
 =?utf-8?B?czJTTUUwTnFoNDhHQ0VzcW9hOEdsKzUwMk5wR3p6M1NHVG9wUEQyam1FOTMv?=
 =?utf-8?B?VmVLQXFXSU1OQXdzRWNSSFo5Mm1xYjdadTRKbEp0T0VwTk5HeTNmQ3ZIdHBK?=
 =?utf-8?B?SzBGdXBxeEVZZFF6cENIWHNjM0laZ1AzRFBrbWY3VWpnZmpIVm1GMm8wZmtp?=
 =?utf-8?B?cm93eTNHZ0EwN01reGxoMDlpMXhvbkE1TWExdW9JSTNvcGoxeVR2QXVrbVNy?=
 =?utf-8?B?WDcrMUlEMXQ1bjljWURNUGxDZlNBdHA4OUdqZkV5VmR6QmRMc3BaVUs2bWNT?=
 =?utf-8?B?bGNWdzlVazZjZzM2RkYvazVGK20rWHBSNExiOElaa2o0NDZwN1ZqcU8rZ2pV?=
 =?utf-8?B?UVI1dHQ1QkVMYXF1LzJJQnlKM21zSTZ2cG9qODVYT3pqMkl2akQyTm9kc0Vy?=
 =?utf-8?B?NVA4bmEyMkR4UGo5R3NmeEJEL2Yza25SQXhDbzVpQkF6NVZrUWE1UURJbTho?=
 =?utf-8?B?SEdVTndab1d1YzBoYXR4VyttMHNyRVBDazJ5SEZFOGY1M2Vsbkx5cFZaY1hK?=
 =?utf-8?B?RTBIcVpBMEllNHNuV1JTZW5GTndJeGI5MGc5V2lGUlFTYUZmazdmYlkyVGtX?=
 =?utf-8?B?ZTZIMkVoeGY3Um5GNG5mOVlHSnc5c1plMmVDdEZHbU5KNG8yeHZMTEE0K09R?=
 =?utf-8?B?RW50Qnk3N29zSU1UaE1BNnFmaTFyM1EvOUN1TGFpL1Jtc3cxY2Z0dmgxdjA4?=
 =?utf-8?B?UTNzalQ0MVJrWTBUTWpKM3BLYUlBQjdIMkdVRWJDYUFPRVRTT1ZhUC85UUNj?=
 =?utf-8?B?QzVVL2YyR0MxSTdaWUlkeWFnZzFjaDhvcjZWUG1CVDIySkJZWjlOZS9HVm5n?=
 =?utf-8?B?MjdiR3FOWFBKRTNDWGU4em4xSHlWd1B0VTBuMUJWMm9nd29UL3VQNVlQcjFw?=
 =?utf-8?B?NElDYTVJTU5zdnprZlVKSW8zbE8wUllkUEdsc29QNDZ3MU91L1FNNmd0aDl1?=
 =?utf-8?B?cXFRZUxobkVFcnpRa2l6YTNtcUMzbGtieklwUjlxV0hxcTJpcXM1NVN3ZWxz?=
 =?utf-8?B?VWZPVjBNbmI1M3ZEZ0lZMy8zWG1mYmFvMit1cFVxbllSNjJia0RpakdpZ0d4?=
 =?utf-8?B?d0RaWXlNcHBHb3pNOGpqTzFvVDE0MGVmMStPUUZ5QStpdjBsSG9KVks2TUlr?=
 =?utf-8?B?VHJYZ21QUzhzbmNJUFF5Tm5GMUMrallEb29iWlJ5UlFpOS9FcytCK3ZTYzRM?=
 =?utf-8?B?VnNBaHpoNStYaTN2QVllNXNCUmNyUERnWE4xOTdiWVNadnZCMWV5RnJwaUc3?=
 =?utf-8?B?TjhBVFFrZi9Dbm56VkNPVHhxZXB6Y3dkemFJbVJaRWxkSndscUVFdU9RR2FB?=
 =?utf-8?B?SE1nS1BGbmd3RE4rajArSWZxZjVDM2dJemNCRTd4L0d0L0lRdSsrMjJ5aGc2?=
 =?utf-8?B?d3pXOHFsSFV6MnhjWXYzL1pDM3p4ZUNGVHROVnJFaG1RcCtzcDVXNnpxdEJS?=
 =?utf-8?B?cEtOcFNyWDI3UE5VRHIwam5PZTdqOFRESXdFaitZWEJtVFFRb096SnJ1Nk5Z?=
 =?utf-8?B?WndxWElCTm5scllRaXpCL3IzZEVMa1Urb2ZRZXFFdkJJaWNTK0ptYUJRUjBW?=
 =?utf-8?B?S3pDUmp5L0d3czZlMnZ2VFI0dmVXT1hOd21tYWVKUnpQWCtwK1ZDbVV6SHds?=
 =?utf-8?Q?As2A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb269eae-a866-4e1b-8aaa-08daf424a491
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 22:39:04.2723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8MkYmyGNJKuiGBAPWW46MJsjuKnzPBYYTFqJ7ISnQtdJTbMLEyWQEWe+wHlPrmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
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
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDExLCAyMDIz
IDQ6MDcgUE0NCj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+OyBjb3JiZXRA
bHduLm5ldDsNCj4gdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGll
bjguZGUNCj4gQ2M6IGZlbmdodWEueXVAaW50ZWwuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRl
bC5jb207IHg4NkBrZXJuZWwub3JnOw0KPiBocGFAenl0b3IuY29tOyBwYXVsbWNrQGtlcm5lbC5v
cmc7IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IHF1aWNfbmVlcmFqdUBxdWljaW5jLmNv
bTsgcmR1bmxhcEBpbmZyYWRlYWQub3JnOw0KPiBkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2Rj
LmNvbTsgc29uZ211Y2h1bkBieXRlZGFuY2UuY29tOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsg
anBvaW1ib2VAa2VybmVsLm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gY2hhbmcuc2Vvay5i
YWVAaW50ZWwuY29tOyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb207DQo+IGptYXR0
c29uQGdvb2dsZS5jb207IGRhbmllbC5zbmVkZG9uQGxpbnV4LmludGVsLmNvbTsgRGFzMSwgU2Fu
ZGlwYW4NCj4gPFNhbmRpcGFuLkRhc0BhbWQuY29tPjsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFt
ZXMubW9yc2VAYXJtLmNvbTsNCj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gYmFnYXNkb3RtZUBnbWFpbC5jb207IGVyYW5pYW5AZ29v
Z2xlLmNvbTsgY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Ow0KPiBqYXJra29Aa2VybmVsLm9y
ZzsgYWRyaWFuLmh1bnRlckBpbnRlbC5jb207IHF1aWNfamlsZXNAcXVpY2luYy5jb207DQo+IHBl
dGVybmV3bWFuQGdvb2dsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMTMvMTNdIERv
Y3VtZW50YXRpb24veDg2OiBVcGRhdGUgcmVzY3RybC5yc3QgZm9yIG5ldw0KPiBmZWF0dXJlcw0K
PiANCj4gSGkgQmFidSwNCj4gDQo+IE9uIDEvOS8yMDIzIDg6NDQgQU0sIEJhYnUgTW9nZXIgd3Jv
dGU6DQo+ID4gVXBkYXRlIHRoZSBkb2N1bWVudGF0aW9uIGZvciB0aGUgbmV3IGZlYXR1cmVzOg0K
PiA+IDEuIFNsb3cgTWVtb3J5IEJhbmR3aWR0aCBhbGxvY2F0aW9uIChTTUJBKS4NCj4gPiAgICBX
aXRoIHRoaXMgZmVhdHVyZSwgdGhlIFFPUyAgZW5mb3JjZW1lbnQgcG9saWNpZXMgY2FuIGJlIGFw
cGxpZWQNCj4gPiAgICB0byB0aGUgZXh0ZXJuYWwgc2xvdyBtZW1vcnkgY29ubmVjdGVkIHRvIHRo
ZSBob3N0LiBRT1MgZW5mb3JjZW1lbnQNCj4gPiAgICBpcyBhY2NvbXBsaXNoZWQgYnkgYXNzaWdu
aW5nIGEgQ2xhc3MgT2YgU2VydmljZSAoQ09TKSB0byBhIHByb2Nlc3Nvcg0KPiA+ICAgIGFuZCBz
cGVjaWZ5aW5nIGFsbG9jYXRpb25zIG9yIGxpbWl0cyBmb3IgdGhhdCBDT1MgZm9yIGVhY2ggcmVz
b3VyY2UNCj4gPiAgICB0byBiZSBhbGxvY2F0ZWQuDQo+ID4NCj4gPiAyLiBCYW5kd2lkdGggTW9u
aXRvcmluZyBFdmVudCBDb25maWd1cmF0aW9uIChCTUVDKS4NCj4gPiAgICBUaGUgYmFuZHdpZHRo
IG1vbml0b3JpbmcgZXZlbnRzIG1ibV90b3RhbF9ieXRlcyBhbmQgbWJtX2xvY2FsX2J5dGVzDQo+
ID4gICAgYXJlIHNldCB0byBjb3VudCBhbGwgdGhlIHRvdGFsIGFuZCBsb2NhbCByZWFkcy93cml0
ZXMgcmVzcGVjdGl2ZWx5Lg0KPiA+ICAgIFdpdGggdGhlIGludHJvZHVjdGlvbiBvZiBzbG93IG1l
bW9yeSwgdGhlIHR3byBjb3VudGVycyBhcmUgbm90DQo+ID4gICAgZW5vdWdoIHRvIGNvdW50IGFs
bCB0aGUgZGlmZmVyZW50IHR5cGVzIG9mIG1lbW9yeSBldmVudHMuIFdpdGggdGhlDQo+ID4gICAg
ZmVhdHVyZSBCTUVDLCB0aGUgdXNlcnMgaGF2ZSB0aGUgb3B0aW9uIHRvIGNvbmZpZ3VyZSBtYm1f
dG90YWxfYnl0ZXMNCj4gPiAgICBhbmQgbWJtX2xvY2FsX2J5dGVzIHRvIGNvdW50IHRoZSBzcGVj
aWZpYyB0eXBlIG9mIGV2ZW50cy4NCj4gPg0KPiA+IEFsc28gYWRkIGNvbmZpZ3VyYXRpb24gaW5z
dHJ1Y3Rpb25zIHdpdGggZXhhbXBsZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1v
Z2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24veDg2
L3Jlc2N0cmwucnN0IHwgMTQyDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi94ODYvcmVzY3RybC5yc3QNCj4g
PiBiL0RvY3VtZW50YXRpb24veDg2L3Jlc2N0cmwucnN0IGluZGV4IDcxYTUzMTA2MWU0ZS4uMjg2
MDg1NmY0NDYzDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi94ODYvcmVzY3Ry
bC5yc3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL3g4Ni9yZXNjdHJsLnJzdA0KPiA+IEBAIC0x
NywxNCArMTcsMTYgQEAgQU1EIHJlZmVycyB0byB0aGlzIGZlYXR1cmUgYXMgQU1EIFBsYXRmb3Jt
IFF1YWxpdHkNCj4gb2YgU2VydmljZShBTUQgUW9TKS4NCj4gPiAgVGhpcyBmZWF0dXJlIGlzIGVu
YWJsZWQgYnkgdGhlIENPTkZJR19YODZfQ1BVX1JFU0NUUkwgYW5kIHRoZSB4ODYNCj4gPiAvcHJv
Yy9jcHVpbmZvICBmbGFnIGJpdHM6DQo+ID4NCj4gPiAtPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+IAk9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiA+ICs9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
PiAJPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiAgUkRUIChSZXNvdXJjZSBE
aXJlY3RvciBUZWNobm9sb2d5KSBBbGxvY2F0aW9uCSJyZHRfYSINCj4gPiAgQ0FUIChDYWNoZSBB
bGxvY2F0aW9uIFRlY2hub2xvZ3kpCQkiY2F0X2wzIiwgImNhdF9sMiINCj4gPiAgQ0RQIChDb2Rl
IGFuZCBEYXRhIFByaW9yaXRpemF0aW9uKQkJImNkcF9sMyIsICJjZHBfbDIiDQo+ID4gIENRTSAo
Q2FjaGUgUW9TIE1vbml0b3JpbmcpCQkJImNxbV9sbGMiLA0KPiAiY3FtX29jY3VwX2xsYyINCj4g
PiAgTUJNIChNZW1vcnkgQmFuZHdpZHRoIE1vbml0b3JpbmcpCQkiY3FtX21ibV90b3RhbCIsDQo+
ICJjcW1fbWJtX2xvY2FsIg0KPiA+ICBNQkEgKE1lbW9yeSBCYW5kd2lkdGggQWxsb2NhdGlvbikJ
CSJtYmEiDQo+ID4gLT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiAJPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiArU01CQSAoU2xvdyBN
ZW1vcnkgQmFuZHdpZHRoIEFsbG9jYXRpb24pICAgICAgICAgInNtYmEiDQo+ID4gK0JNRUMgKEJh
bmR3aWR0aCBNb25pdG9yaW5nIEV2ZW50IENvbmZpZ3VyYXRpb24pICJibWVjIg0KPiA+ICs9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAJPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPg0KPiANCj4gSSBleHBlY3QgdGhhdCB5b3Ugd2ls
bCBmb2xsb3cgQm9yaXMncyBndWlkYW5jZSBoZXJlIGFuZCBub3QgbWFrZSB0aGVzZSBmbGFncw0K
PiB2aXNpYmxlIGluIC9wcm9jL2NwdWluZm8uIFRoYXQgd291bGQgaW1wbHkgdGhhdCB0aGlzIGFk
ZGl0aW9uIHdpbGwgaGF2ZSBubyBlbnRyaWVzDQo+IGluIHRoZSBzZWNvbmQgY29sdW1uLiBQZXJo
YXBzIHRoaXMgY291bGQgYmUgbWFkZSBlYXNpZXIgdG8gcGFyc2UgYnkgdXNpbmcNCj4gZW1wdHkg
cXVvdGVzICgiIikgaW4gdGhlIHNlY29uZCBjb2x1bW4gdG8gbWF0Y2ggc3ludGF4IHVzZWQgaW4g
dGhlIGV4aXN0aW5nDQo+IGZsYWdzIGFzIHdlbGwgYXMgdGhlIGNwdWZlYXR1cmVzLmggY2hhbmdl
Pw0KDQpIbW0uLiBJIHRob3VnaHQgd2UgZHJvcHBlZCB0aGF0IGlkZWEgZm9yIG5vdy4gRGlkIEkg
bWlzcyB1bmRlcnN0YW5kIHRoYXQ/DQpUaGFua3MNCkJhYnUgDQoNCj4gDQo+IElmL3doZW4gbWFr
aW5nIHRoaXMgY2hhbmdlLCBjb3VsZCB5b3UgcGxlYXNlIGFsc28gYWRkIGEgbm90ZSB0aGF0IGRv
Y3VtZW50cw0KPiB0aGlzIG5ldyBndWlkYW5jZSBmb3Igb3RoZXIgcmVzY3RybCBkZXZlbG9wZXJz
PyBTb21ldGhpbmcgbGlrZSBiZWxvdyBidXQgSSBhbQ0KPiBsb29raW5nIGZvcndhcmQgdG8NCj4g
aW1wcm92ZW1lbnRzOg0KPiAiSGlzdG9yaWNhbGx5IG5ldyBmZWF0dXJlcyB3ZXJlIG1hZGUgdmlz
aWJsZSBieSBkZWZhdWx0IGluIC9wcm9jL2NwdWluZm8uIFRoaXMNCj4gcmVzdWx0ZWQgaW4gdGhl
IGZsYWdzIGZpZWxkIGJlY29taW5nIGhhcmQgdG8gcGFyc2UgYnkgaHVtYW5zLiBBZGRpbmcgYSBu
ZXcNCj4gZmxhZyB0byAvcHJvYy9jcHVpbmZvIHNob3VsZCBiZSBhdm9pZGVkIGlmIHVzZXIgc3Bh
Y2UgY2FuIG9idGFpbiBpbmZvcm1hdGlvbg0KPiBhYm91dCB0aGUgZmVhdHVyZSBmcm9tIHJlc2N0
cmwncyBpbmZvIGRpcmVjdG9yeS4iDQo+IA0KPiBUaGUgcmVzdCBvZiB0aGUgZG9jdW1lbnQgbG9v
a3MgZ29vZCB0byBtZS4NCj4gDQo+IFRoYW5rIHlvdQ0KPiANCj4gUmVpbmV0dGUNCg==
