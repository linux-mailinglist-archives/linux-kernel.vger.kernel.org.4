Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454425BB396
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiIPUin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIPUil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:38:41 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5329B99CD;
        Fri, 16 Sep 2022 13:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbcYO5GVWOvod8s/c8i2ynQy4H8ucPNWJRPWZK19li+YFSHCSZruS/TIyZpADSkOgJkMvwyez3dTr3EP08uyXa+cw1yvC0MXYLD6Vp2RQZX8eHhPeRmttn/a56ws1fnh0SK0bgKjHc+Lm/7586Du99zkWbjLC2VOYPqABkJT7cOZg9CKpsGsKWbR7MZ59CzlRW5rX7C4xZX94VMjkalODJHiAWEqrwzokA/QgVetMIdUZ05/cD8pbPhb0/7WvZ1S6egQfPEblWLS62ECEtSpoM5iAypyVt2goaLTRgDwNqi7N3XgFugVPQUKCbWhDNGsn/XzlE7N0Ivsb2IaZlXU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTR3u7TZEvNAlcKrBpHO/4qca47EyXydbdssItxLoxY=;
 b=ZIa7dwqAw9F6f0q7QPMN8IL2a5pB2ec9AM1zDil55rpcpIE7DjQ+r40bF9BSx8dlF8NaN03ql6X9MoyOQ/X4T+kRINpo+lzdqD7ggtpz0jJ51EgTS2mACENB9hsLEYDwCMh6hCm26rQC9Cx5OkJ0h3UOeJXGBzVfa9RAnPu2o7hOK8vSyyvdMx8fRdpNQR2j2Q2dApC0RF32GUShmKqRh9mcv19iTOkayX2srAnJ8vQ85MagQIYScrp0461fmEYM5FDpISyLD3v1syL0tFpzRkmWGGU3B05dNaa7ZkgnpjajXMHbNtzKdv08GCJR5U1oNWJic1b95W3kFvLQuNM3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTR3u7TZEvNAlcKrBpHO/4qca47EyXydbdssItxLoxY=;
 b=4I5MJ0qeZPt0LtooliWnCA4qUzjH+TxARuqLwj2y0rFWSVfPvo63sKNKjF/yQvm73C/6A05hjK8z9aM6+e6KoyroSdOu7s9LOjZ3q3BvkrHVJJNAx9m1cqvBIg32Fr3CkZkMIgD54/3fwBMkQdryI7yxcX40n5KV58+0kYls9RQ=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 20:38:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 20:38:38 +0000
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
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH v4 12/13] x86/resctrl: Replace smp_call_function_many with
 on_each_cpu_mask
Thread-Topic: [PATCH v4 12/13] x86/resctrl: Replace smp_call_function_many
 with on_each_cpu_mask
Thread-Index: AQHYwuP/HrseUoSCiEqKOiRBSiAC1a3iSfcAgABIqrA=
Date:   Fri, 16 Sep 2022 20:38:38 +0000
Message-ID: <MW3PR12MB4553AAC7520F0B495ECAF14895489@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257368306.1043018.15116501631578530094.stgit@bmoger-ubuntu>
 <aa3cbecb-636f-cece-0c6f-97f67f060cdb@intel.com>
In-Reply-To: <aa3cbecb-636f-cece-0c6f-97f67f060cdb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-16T20:37:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=51f89491-005f-4461-b83a-18863711a483;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-16T20:38:37Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a646db38-be10-4225-b8da-919ccd3e8b22
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|SJ0PR12MB6733:EE_
x-ms-office365-filtering-correlation-id: a061c42f-3303-4446-82ca-08da98236f5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: th96A9pPo0sBUJ1U5jFhVoiT1SdyVmMpSuwNj7eBH+OgPbgs6ww+HogCRMxy3G8KPlOCRQQUf3vfY7+4gJRqsCxUG4alRQ/Gl4sew8j4d8TaVnnmJpLiJjQelnSzIYUigwYJgB4p0ZScYxKWWawfTDQzHAmxpSD1PrR4qjr+POlJ1o+WhBsvL4B6NSaM2wR0DbTLR5HmpbWr5rRFEVlaV56STDnynf3wtR+OzvEWfVjDCEKGkkIztVa0mc3T1AIbn1Tb2aL/VuDaTEf74fz7WHEETm0DspmYyKH1yElEOCMJBJ4hWQLzNstXlkCNhiY8PUV1SlT4g+kOR6Pel4iX82TNwuDhiA7H3eRRl59ZRRCUWV4hIjwuTBBgXqCLfWNEVHlLUAgKznxkrZNIma7luZuQa4NVnMKY1rm4vdy/KG6nDlOTjHoyirw0r/cq8Q3nhwmjkhouUr8JLvfJoacCghKdz+ccaRaHXerxXri6CjfwLkzPb/B3pYKEICEnvycmHjV37JfhImiYxXvV1hkejW05YuHpG6zocRj/fmKYjPGB3kwNZw/dENZeQXhWIcCUrQvlS48uIh8XUtEzvyRCI5O5A7cflyzPuEBeB2sbyF8KGK1lkbdz5lFb/EK2YQVM5o9F+nubJ7ovGiR3EzKwnaLFHYXjh3wxP0f83cqTffFatWOY0yCDutZlZoghM8PVoSYhMsHZM35stlWP0LAJrrsuz+6j3xz9Fa7tsyZaxmWEa0Sq7dfoBGdVM5HoQGkiYSx0sM9xYdYBsZHgpT3eJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(9686003)(38100700002)(110136005)(71200400001)(8936002)(83380400001)(122000001)(26005)(86362001)(55016003)(7696005)(66946007)(6506007)(478600001)(66476007)(186003)(7416002)(66446008)(76116006)(54906003)(4326008)(38070700005)(64756008)(52536014)(53546011)(5660300002)(66556008)(2906002)(8676002)(316002)(41300700001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmVTb1ZuM2NUWUYzTHljUUhJZTFNTEFiZ01VaGFsYUNWOG9lWTU3WUxUY3Ey?=
 =?utf-8?B?cmh3Y1hPc2JpRWcrYUVtSGN0WW95QzZ3SFNSc1lKVHFkMkF5TnZtTVlBeFZn?=
 =?utf-8?B?bHhrbW1BVUtKTWVBSTJrcDlabThLRVpVRlNybURoZGRrVEZmOHcyU3E3MTNa?=
 =?utf-8?B?eXFVZ0tNYkdPTmRJUnBhandoclRGQTVxQmVmOHJZMU9NbngvQ0hVU3gxZVdH?=
 =?utf-8?B?T0JXbXI5VStwVElmNkwrUjQwUGRrVGhiSTh3ZmpXNEJSL0FvOSsva2hzUTlz?=
 =?utf-8?B?aXpkaStNd1VwdnFQa1g1c1ZWSWxGdzBSSk5pdVdxTXlIWW1UTUg2TEVyVXNv?=
 =?utf-8?B?RmhhMWRsQ2VObTdvVTZlQVdTMTMwWlhmeTJqMVdBMDh4MlR5eW0zZmdJNENi?=
 =?utf-8?B?RmMzRmtlSEtIUEdEVnBjckd3b280eisvdnVFSW41N2UzRlEvV2g3MTlveXZT?=
 =?utf-8?B?elg4cWtEUGFrNFViK0JOQWpoOVMrWWs2ZnhxYWE3bkR1TXBrUEw1eDZaZmMv?=
 =?utf-8?B?a1F6SkYreFBYajUrRnpDYUpQOU1ZRzJBQTM0TFZJQktodjB6L3hmSWNucDRr?=
 =?utf-8?B?ZlJ1MDUzT1k5WlR0cG5JRFljMmhNQ2cxc1VRRHQ1dlh0bG1oR3hyWndUdzBH?=
 =?utf-8?B?WmhCVVo4enNFSkpYSmhoZ1pCbUtNVGZHMVVzUHVXUUdYTXd6UFhKSjRRR2Fa?=
 =?utf-8?B?YlQrVEhBa2xDaEZkOFZRQ1kwSk5yenl1WkZkZVpzekQ5cWtDZlpjTDVJR20z?=
 =?utf-8?B?Y01pekhaRllXTDBkV0VwZ0pLSDBMdC9Xc3VTSUJIL1NHREZHY3RyM1RKRllM?=
 =?utf-8?B?MEpQd0h3UE1qOFVNOWR2TXRwYUc2WkpiaHlUNWlySHV4NUV4bCtJU0k4OEhJ?=
 =?utf-8?B?dk1ZaWdBT3ZpcEJXaktRT2dnejlvQ2E2ZkdoNXp3QmNYaVRuK1FEMHFpY2tC?=
 =?utf-8?B?MU5Sbkc1WVZIM0VNRjBTRHJOZ0dqa1NTQlltelRuUmtzZzFrVnYrb3RmdzhW?=
 =?utf-8?B?K1FSMUlnamIyMXE3YkFYNUozc09Tay9yTUZRU1B5T1FxZU81Rks3UUNRSVg2?=
 =?utf-8?B?TFBwTU51bFhoTHVXcFQyb1JMWFdIMVRjRzNIMW42bHhFSW5wYjZBYktaeHQ3?=
 =?utf-8?B?a0N2Qk1OUnV2bXFHMkVFTXlqdjFNcnNiL1krbEdWQjV1VzVJcHdvS1N1SWlH?=
 =?utf-8?B?eVRYSnhIMUhOdkFNdC8vVEx2MytDSEdrOEszNmhkZzNLT3Z4L3AyczVSMHEw?=
 =?utf-8?B?VFBuVUYwUmppcE1jN09YZFpxK1BvSmthb3FXN211ZndVLzBlU1FkWTZ0QWpG?=
 =?utf-8?B?V3JPZVFLNm1sc0g5aHNzdlVvSlNRUHgyWXlSNExxalpBam0rbk9IWk43YTg1?=
 =?utf-8?B?RlRVbVlXeXA1eGdRSUJTekJtV21UTktrbWtZaTJmY2s2V0w2aStGakNUcmFM?=
 =?utf-8?B?NmJCRE1XUXlUNDNPdkZWWWY5WnJxcFhVd0R5c2NKRTl6TUNIZmRYeGhjakRK?=
 =?utf-8?B?aWU4bkMwZ201L0NUSVFmZkhxbFNmbENUT2FqbHlhWHBaMWQ5eUdPTnVDTFlL?=
 =?utf-8?B?WFk0Q1hXVmU0N2VPemgzNkdHMFdjcWFLSzNVZ3pyUTkwL1lNQmNoWlJuMm1B?=
 =?utf-8?B?bmNCTU1NelhETlFKb3hFNGFPcllKTXVtMThTZTBWZnBvRWs3RnByVmJ0dmFO?=
 =?utf-8?B?MDY3R2ExVE80SE1FT2pZSDc3eW1PSlV5SlNkYnNBZjdpVFJYQldKNTJ6dVVn?=
 =?utf-8?B?VEFYVFJtbElvN2ppUlZzcWQ4R29STEUvNzFqM2cxK0JYYnZJbk85MnNwK1Bu?=
 =?utf-8?B?ZWRwOUpIbnN4NDhnTElxSERxY005ZGNPT1Zwd3BWS3hBV1dFNFQwZ3pIS2k3?=
 =?utf-8?B?VVZuQ0pTTUQyMDYvQWtidzNuZzhzSWZoNGtMUlRFMXlvcUQ1NE1uZWNVeFdv?=
 =?utf-8?B?YVlqQW54TzRld2ZBTVNlR2ZoYzJDbTV6ZWgvTjhBNWJjQ005SWhmRS84eW1S?=
 =?utf-8?B?UXJJYjl2VFZjM3V4TGMvZUJ0UnJpWEFkbG4zcllNNUpwbHV2TklodTVxZlJl?=
 =?utf-8?B?dmthcWxNTlEzVmxNM3k2REhVcXI3cUZXaENtK05BbG1UWm9Oekd5UlFVNnVE?=
 =?utf-8?Q?Q/9M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a061c42f-3303-4446-82ca-08da98236f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 20:38:38.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: co9C8yOgvbVMhrQjl6X+cpNpvKx4qPDfEhwsvnkV3bnucAkC7k6+VfpxhcjxqdJi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733
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
dGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMjIgMTE6MTggQU0NCj4g
VG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+OyBjb3JiZXRAbHduLm5ldDsNCj4g
dGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGUNCj4gQ2M6
IGZlbmdodWEueXVAaW50ZWwuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IHg4NkBr
ZXJuZWwub3JnOw0KPiBocGFAenl0b3IuY29tOyBwYXVsbWNrQGtlcm5lbC5vcmc7IGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmc7DQo+IHF1aWNfbmVlcmFqdUBxdWljaW5jLmNvbTsgcmR1bmxhcEBp
bmZyYWRlYWQub3JnOw0KPiBkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbTsgc29uZ211
Y2h1bkBieXRlZGFuY2UuY29tOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsganBvaW1ib2VAa2Vy
bmVsLm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gY2hhbmcuc2Vvay5iYWVAaW50ZWwuY29t
OyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb207DQo+IGptYXR0c29uQGdvb2dsZS5j
b207IGRhbmllbC5zbmVkZG9uQGxpbnV4LmludGVsLmNvbTsgRGFzMSwgU2FuZGlwYW4NCj4gPFNh
bmRpcGFuLkRhc0BhbWQuY29tPjsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJt
LmNvbTsNCj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gYmFnYXNkb3RtZUBnbWFpbC5jb207IGVyYW5pYW5AZ29vZ2xlLmNvbQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY0IDEyLzEzXSB4ODYvcmVzY3RybDogUmVwbGFjZSBzbXBfY2Fs
bF9mdW5jdGlvbl9tYW55DQo+IHdpdGggb25fZWFjaF9jcHVfbWFzaw0KPiANCj4gSGkgQmFidSwN
Cj4gDQo+IE9uIDkvNy8yMDIyIDExOjAxIEFNLCBCYWJ1IE1vZ2VyIHdyb3RlOg0KPiA+IFRoZSBj
YWxsIG9uX2VhY2hfY3B1X21hc2sgY2FuIHJ1biB0aGUgZnVuY3Rpb24gb24gZWFjaCBDUFUgc3Bl
Y2lmaWVkDQo+ID4gYnkNCj4gDQo+IHBhcmVudGhlc2lzIGFyZSB1c2VkIHRvIGluZGljYXRlIGZ1
bmN0aW9ucywgaW4gdGhpcyBjYXNlLCBwbGVhc2Ugd3JpdGUNCj4gIm9uX2VhY2hfY3B1X21hc2so
KSIgYW5kICJzbXBfY2FsbF9mdW5jdGlvbl9tYW55KCkiIGluc3RlYWQuDQo+IA0KU3VyZS4gVGhh
bmtzIA0KQmFidQ0K
