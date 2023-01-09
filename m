Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5B26632D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbjAIV0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbjAIVZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:25:41 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A96334;
        Mon,  9 Jan 2023 13:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673299539; x=1704835539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kfQ8GLIy7Yanp6cDGvD0ZEX8Ouab9Yk52lbG8ry/TPU=;
  b=Qzs/x9pNggwIrTZai5uAEwtC4eeBsqa8+toycmp+OMZQNhk9xFoYZ2y1
   Q1tIAB11UYedVnQKvoQQleOGS9KHE26P4EBtjt/U7JbJRPKaIRwhxjiFC
   197Tldu/YGYH4yzTEawQZPaRX9RUF6dnCGGv1Lixz1SiFXr+0ImpkVexx
   kXn/Vc6X7HgFvpdCttvqLC12aWtXRz/exQ3U8Eikwlt+ZQK4YDnH6pEtv
   cCMYtrrNtKQPyvt/569Lal7bbhwJcd3o6bpXIJT9HcqyYj43S6jPU5n65
   8oNUaZ7/sKnDkayzF52RWMF52XBzJpJd3yQTkHxnRcSGf0GkZ2IAlgWA6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324226478"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324226478"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:25:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="634365527"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="634365527"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 09 Jan 2023 13:25:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 13:25:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 13:25:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 13:25:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 13:25:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGU/AfL3nzB77byA05gd12q0pYGRMPQFCdqtz95qne62JUZYQMQFklMdFwYGbghkninBWGTwN5qUUoL6gJ66kF8r59ZwkD2lCdwV+F5VSN/8NVnLNvvDg7gpukyzk+5Gc1K2/nL0AEvloUeAGDUeDWkH3ZfIfWG4ELWIzB2r5cNpsHD1O/roR9lld6itHju0rYMefsUH3S/vWMrOA0h3f3SkSrf0bQDQW8t7cshyQxS4EwopSBC538ONnALnqpztAYzM/ylaPKHPF+hCKzzRK8M+38MSYVAMQPIvHgB9dndaEREme8WnFhyhVu9KnLMw8NzzKzyHw2Q7FIjx6XTjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfQ8GLIy7Yanp6cDGvD0ZEX8Ouab9Yk52lbG8ry/TPU=;
 b=nBZOwmYgiUDhdSmOKIE3okzXlEoe6ZJj6LZecpSiVd14rU2/pB5AJLogCPrTfqnmcqkdD6r+2M3G4HUjk7P9C4lfgzlt8dp4htOC7MFiv58yWodQkgQ4wrt94GBHpARELoD0Z34CKlI+gfBtbWGwzHe5bUjvtxFIueFa5Ecs1jN+637q4/0Us02SoXWXyebkZ/1fV9zzhrd2N0RFMpRX/ufdIkPqKLjIzOwKah628CmRLJX77h39X2KVqyTJOcYs8OctY6Sgs2S97VBCXbPM/8+95PKIxGsyzw7p2YkwoMuK3AXmlsek/UYPDu4Wrexhx/Z/MHeYmqZc1RCyunYUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 21:25:32 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 21:25:32 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, "Moger, Babu" <babu.moger@amd.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
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
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Thread-Topic: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring
 Event Configuration feature flag
Thread-Index: AQHZJEmnmzyHArDZ4kO1HDjadoxLzq6WcBKAgAAOO4CAABXYAIAAAeGA
Date:   Mon, 9 Jan 2023 21:25:32 +0000
Message-ID: <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-5-babu.moger@amd.com> <Y7xjxUj+KnOEJssZ@zn.tnic>
 <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com> <Y7yCCNANVBnOOmxM@zn.tnic>
In-Reply-To: <Y7yCCNANVBnOOmxM@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB7449:EE_
x-ms-office365-filtering-correlation-id: e9e0fd35-317e-4725-a01f-08daf2880a16
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bv7T/kYnlbViLsEKnHGuepx/CXgc9jiV3IZrxk7bXPu+qENvkNKmDXNprhwl6t5efivAAKX4apE9gDDimSBm39Pt4CriE5EJr33NcY/o5OPUE10Cm3KW3QlD9XiCdUTWvDZSL1gF8qLQAw/c+EgylZajewHN8mvoKW2g97stWfvfnVEFJ1YFS7Huk+s13JEYHCETNouh+sXghUku8t8xZmbDch4FRnFoiVsBk4N3YkXQWxYIPZlAZn62xL362Y9vy6kbYtfCL9XlHMsUqjCshFKD72qS5lTfoFf7Ta7z2+U2dpvtZbG+DAf/iV2FI3qWBhWd9Z/N4Hcd6u8U3zz7Z2NoL5MWn15vg5kKK0S6fHOPGscAcRweL5wtfNQPd2NGVLTYq+mH/c0aXIc7C3R08nnNaV77V8GKWKLK20NEPMgHUwUcJGn/kkUP1xyJqxP37GGopltClk1SVDnyNOoQWGrcQTcmiEJs2I/T/zhMRQHA0ZdR+8q8VopN5AeolG0gwiFC0kaLJdBpw1D8vyirYaOFD3eJOuhjVZNOVa48k5i/eLlgqesCzmJ4kOW/hhVbMzfnSyKOhmyjM9rVw9kcl9aWffklckkS7BfZm2YpeGLLj4p9LrPUbdmyF11jgSd6IQlV0V1KTZVeMCoFPCOGivviIKuMKCdwNVsW9JkH5sH3wuheavjsKvMq+OcXa5v6kwMreVPpLj+0W+PFa+yZNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(8676002)(76116006)(64756008)(316002)(66946007)(66476007)(66556008)(38070700005)(66446008)(4326008)(7696005)(110136005)(54906003)(71200400001)(2906002)(7406005)(5660300002)(8936002)(41300700001)(7416002)(52536014)(83380400001)(82960400001)(33656002)(6506007)(478600001)(122000001)(38100700002)(9686003)(186003)(26005)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3Z2dFIyRFNwNlQ5Zld3b0wvd2huN05GKzRTaXNPL0VENEVrUkpjZzRvNTA2?=
 =?utf-8?B?K002L2NPZU91aEVhSlpBM2R2d29sWE5kcllnZjRmZmg0Vkp5M2psYUtsVXJT?=
 =?utf-8?B?Z2w4WFh6VHB3aDBmRUQ5NzdpbXRlNUtsbkt5TTVDU1VLV0VNbDBlSjVkaGRQ?=
 =?utf-8?B?NFgzNEs5V0YxbEwxaEhrN0U0LzJocStkdld0MG5xRnF0cExSNWI1S1lXaGFj?=
 =?utf-8?B?QTZ1dkpDQVdLeUU4OEh0VCtIY0xlYVVveUJ4TmJOaFdqT0ZCOUJ1SFYyNi9r?=
 =?utf-8?B?WEp5b0VTaHdyTkxpVnF6bW0zV2RLK0phRGJzbzNOYkluQkF3RmZJZjNFZTdy?=
 =?utf-8?B?dmNqRXFrY0RENldGOHVad1NQQjNkU21wM1dvbzQ1ZTVyV0kraERRTy9yOVBy?=
 =?utf-8?B?VE5VemN6WEI4aTF6bUtPZ3U2UnI2R2tiS094Z3N6T0ErY2E3T05VVmU5OUll?=
 =?utf-8?B?UzNPT1MyejB3cXBxMjZENTFaTzc0emZIVkRsQm5UamkwSUdrYVlZTERSdDF4?=
 =?utf-8?B?N2gwZ1ZaWnRBM1UwaVduWXMvQUtTbEVGejJpWUxBTSs3UHB2TEd1ZDlQYzQ4?=
 =?utf-8?B?Qk91T1FTR3VueGVHZ0hCeGZzUG1HOU92MVdQSUQxTzdFSGhzdDE2VTl1Tmk2?=
 =?utf-8?B?Tmpxd2RxcDNSSnkwQnhzalJlbE9OaFdnT2lqRkpsTW5xSHQ5bkFwQmdQYjJO?=
 =?utf-8?B?clhrVjNCTUdWb3I1NzZtQWtGb3R6NTlCODR6UGFST2tqZjNCKzR6YjNsNytv?=
 =?utf-8?B?Zzc5ZlhMdmFmSzNxc2xIZzFUd3VGYlRSRG9VODdBSGgzN0ZkN1FCOGpYcHZl?=
 =?utf-8?B?NGQrUk1SMFR0QWV1czhab0d2Rk5yZnRRMnZTdFErNFhsUGRoN1o3L2dFR0Iz?=
 =?utf-8?B?SkNnZHBtdWFnVWVhSHJkVmYwNVpCK1JnWm9XS3RoSHpuZDBhYXVlTzhxSGM0?=
 =?utf-8?B?d0lXeC9ZM2oxN282RGxZbkNJK0gzUWxMRVI4N1pyVXBob2dMNjhyM0hNcFBh?=
 =?utf-8?B?TllSQ1Exem9IMUJpWXhLSlRsVDBSWmZwdUVET3FWbysvbzR2R1p2bmhLSHZS?=
 =?utf-8?B?N1M4YlhGTTBZdytreGhqTk5KTGpYUXV3RTdRVlpqWmNlZVU0SVZkL2V4Rmdy?=
 =?utf-8?B?dmtySGFWSmVhdjZlbkM2MDlMeVpyZ2VkdXBYSEFzUWhJVitURGVxcjBYRTRY?=
 =?utf-8?B?NGlKZ2R0UFpIckd0ZktMemJGM1JVTExBczRnOXZlcjZyaXIvSkp4WHVyWW90?=
 =?utf-8?B?UFNCKzFrdk0vZHBHREZqcWl4ZytGbGtVOW5HU0lpRkpZNlZ0aXJiUFFtd01I?=
 =?utf-8?B?Q0xXck9oaklBa0czWUxIdlE1VFNhY21uVUNDc1lwdi9KM2NEU2ttNVVuRnU5?=
 =?utf-8?B?L0JLbEF2SnFqK0Yra0daWlFiKzVvMFRmNXhlRDd2bFFzVDZNZXQraTlaV2dM?=
 =?utf-8?B?dEd2ZkE3bWxOeGtmM0NHeUdVdW1QdXV1bHBiYTNCWkE1RG5HN3pFMEdVeWJ2?=
 =?utf-8?B?NU1LMmtJMDhUUzhPekRBUllRREQzQjBZbXhzTjc2dGVkMll3VmR0c3lieG5L?=
 =?utf-8?B?RUpXNFRWK0VHQzV4NTE3bGFkSlBNRnBJYXFHYnFqcE1PQ1JSTmJvdkplRTU5?=
 =?utf-8?B?U0tpRFJIWWRiZytWMzVVdnVwcVZmM2VRMTd1Yy9LY2JGUmJnalJ0QkRYM0Jm?=
 =?utf-8?B?bkp6Y2xiaUFodDE3ZEJKZEY1WkNSelpIMkFHSnhhQ2FUOHR6UFRiNE84cU4z?=
 =?utf-8?B?QVNPRERJWE04MkliU0JGNW5xbGNKdVlreit3aHhKdFdUR3lJS25yWWs5VGhl?=
 =?utf-8?B?THlMRXdzWVpPZzVhbUFHMit1RGtKR3BUek5pZ2xNclArVEwxQUprYWlud3Fk?=
 =?utf-8?B?andjVmJ4d3hlY1k4cUxVOTROUzQrenN5Mzh4MjlTM0JZeFdJYWVscU9Sc0dF?=
 =?utf-8?B?SjJIcnBGS0xhbG1YMFVpYVJUakRkamtRMnpWMUVIS0J6K01WN0dRK2FmeE5a?=
 =?utf-8?B?MnV4M3hEbHVLUERZTG1KbnZZbjBiL0VleXhhbjh0Q1RIakdoSUFlV1Q5ek9h?=
 =?utf-8?B?KzVRRm5vUUcyZ2dScXA1YXhxb29wcFdrNU9PVVRTWWcwWDRJTzVoMGZZRmY1?=
 =?utf-8?Q?6df8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e0fd35-317e-4725-a01f-08daf2880a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 21:25:32.4450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8I805YVblJHsn2rCoN8VSR+Zqev8WSxgqELvi7Ip7E2X6R1JcMcfhg4hUjofpvQsZdz2nSU7hF8HXNY7BPpHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gQWxsIHRoZSBRb1Mob3IgUkRUKSBmZWF0dXJlcyBhcmUgdmlzaWJsZSBzbyBmYXIuIElmIHdl
IG1ha2UgdGhlbSB2aXNpYmxlLA0KPj4gdXNlcnMgY2FuIGVhc2lseSBmaWd1cmUgb3V0IGlmIHRo
aXMgc3BlY2lmaWMgZmVhdHVyZSBpcyBzdXBwb3J0ZWQgb3Igbm90Lg0KPg0KPiBXaGF0IHdvdWxk
IGJlIHRoZSBhY3R1YWwsIHJlYWwtbGlmZSB1c2UgY2FzZSB3aGVyZSB0aGUgcHJlc2VuY2Ugb2Yg
dGhvc2UgZmxhZ3MNCj4gaW4gL3Byb2MvY3B1aW5mbyBpcyByZWFsbHkgbmVlZGVkPw0KDQpJdCBm
ZWVscyBsaWtlIHRoZSBvbGQgInJ1bGUiIHdhcyAibWFrZSBpdCB2aXNpYmxlIGluIC9wcm9jL2Nw
dWlkIiB1bmxlc3MgdGhlcmUgd2FzIHNvbWUNCmdvb2QgcmVhc29uIE5PVCB0byBkbyBpdC4gIEJ1
dCB0aGF0IGhhcyByZXN1bHRlZCBpbiB0aGUgImZsYWdzIiBsaW5lIGdldHRpbmcgcmlkaWN1bG91
c2x5DQpsb25nIGFuZCBoYXJkIGZvciBodW1hbnMgdG8gcmVhZCAoMTQxIGZpZWxkcyB3aXRoIDky
NiBieXRlcyBvbiBteSBTa3lsYWtlLCBtb3JlIG9uDQptb3JlIG1vZGVybiBDUFVzKS4NCg0KRm9y
IFJEVCBJIGRvbid0IHNlZSBhIGxvdCBvZiB2YWx1ZSBpbiBrbm93aW5nIHRoYXQgYSBmZWF0dXJl
IGlzIHByZXNlbnQgLi4uIGFsbCBvZiB0aGVtDQpoYXZlIHBhcmFtZXRlcnMgb24gaG93IG1hbnkg
dGhpbmdzIHRoZXkgY2FuIGNvbnRyb2wvbW9uaXRvciAuLi4gc28geW91IGhhdmUgdG8NCmVpdGhl
ciBnbyBwYXJzZSB0aGUgQ1BVSUQgbGVhdmVzLCBvciBqdXN0IG1vdW50IC9zeXMvZnMvcmVzY3Ry
bCBhbmQgbG9vayBpbiB0aGUgImluZm8iDQpkaXJlY3RvcnkgdG8gZ2V0IHRoZSBleHRyYSBpbmZv
cm1hdGlvbiB5b3UgbmVlZCB0byBkbyBhbnl0aGluZyB3aXRoIFJEVC4NCg0KSSBkb24ndCBrbm93
IGlmIHdlJ2QgYnJlYWsgYW55dGhpbmcgaWYgd2UgZHJvcHBlZDoNCg0KICBjYXRfbDMgY2RwX2wz
IG1iYSBjcW1fbGxjIGNxbV9vY2N1cF9sbGMgY3FtX21ibV90b3RhbCBjcW1fbWJtX2xvY2FsDQoN
CmZyb20gL3Byb2MvY3B1aW5mby4NCg0KUGVyaGFwcyB0aGUgInJ1bGUiIHNob3VsZCBiZSB3cml0
dGVuIGluIERvY3VtZW50YXRpb24ve3NvbWV3aGVyZX0/DQoNCi1Ub255DQo=
