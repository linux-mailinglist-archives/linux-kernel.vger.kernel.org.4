Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7955F8324
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 07:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJHFci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 01:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJHFcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 01:32:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F74AA366
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 22:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665207155; x=1696743155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SEJOVASVxo19ZMLVISxudZWobCMxvTgKx6hZQcd9VIU=;
  b=DQb1JVBCXOjho0SPX/++S0ENf9LUu8zGLZ5U2+AGH81H6iTUDmiDtolO
   df8dRfi7g8kF2Zp/Q786yDkLJN0kEk1SHhdubqNtqrpiZBqgCG9w9pnxU
   GABXLjYSgxTw6lt7y/wTElX+/b/VTD+iIWr0duGnKPK4Nzd36FF3N2MCM
   VhHEudJj8OQvCxojisQVsZs9hKo/TSMmx+eCvKZeE0juJp5bvLUesB3z+
   y+QZ3OvWVhFcNH1ZMGYiDfiXRm7+jR7LWDPu/oMxrcbxhLO3zguMoGFSE
   fvFsuUL2hWfUkT19r0aSVeheADxSV811vpyHNt4igA8n2mAhF0LxpbNpK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="287126083"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="287126083"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 22:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="576477373"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="576477373"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2022 22:32:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 22:32:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 22:32:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 22:32:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 22:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDjphrbid96ed/FvWqV89futd7/ewpzSFIStLQOEgDRf1nmYxK77PqsY1yk5Oyu/lDbKTHFAnoiRgWxn/aLLOm9FdmWRq/bGxti7tpTGDEvnBO39DuC1U4T0f/bCHQarf1hLLVJOLtgC8/iIn8lEZ5trlkOwcPIY3lfgLx7WALMdh2yO5Ud0RywddY8CMhBfgBKCYgWmCacj5bLD78RCUQwi9vOP5YxgH+xv70+9bAr0jux59Va3yF1Yj1Ex1fq+4QOkw7Nh3HOvkc5lMb8QpURZ1wP/saDFcD1TkjdIlaDnODUHsCbILQ0wR7JGFils+Pw0RbSBLT/w1oc2CYYVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEJOVASVxo19ZMLVISxudZWobCMxvTgKx6hZQcd9VIU=;
 b=DCPX0vyYucon/efRdDLgA2QZCDyexYPnXvTO2g4DtQk2fco5ZdHOl5gxJFcxLwycEbALKanxGuVoOWS79i+rowc4qNVRlz2oMm2dH+7NljbwOE8nK8rQj1ZM127wff51LLiDY0EceqaX2g0n+d+94SujdBRshtm/R2L8eYgkl3cfoZHhQGbn6vIqB/kdSCL47S+Vl+CgbjvUfuJ4pA2uHNuoGS/GeI4LsmwuVockPiig3PTdRZ+A+Y/TTnCyqRKlGse+GOml9ArPUUzyOljqOWyU819h4BK+1cQZTxHFBFgMfiUhXhXkuh8Dlx4A5fPOnno3B1h1dSDm0QfPg69bzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by DS0PR11MB7262.namprd11.prod.outlook.com
 (2603:10b6:8:13c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Sat, 8 Oct
 2022 05:32:32 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 05:32:32 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: RE: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Topic: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Index: AQHY2Z1YsyE3enznIkOfLcepaehVE64DBB+AgAA15gCAABeEgIAACuQAgAAFu4CAAAKlgIAAlneA
Date:   Sat, 8 Oct 2022 05:32:31 +0000
Message-ID: <BN6PR1101MB21617D356343204482EFD1F6A85E9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
 <BN6PR1101MB21611798953AADA4DFD71719A85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y0B83cSSwJnRtGAn@hirez.programming.kicks-ass.net>
 <80AC2E90-D842-4EA2-A413-3CC5CFF088BC@zytor.com>
 <Y0CKz/wjvYYYgH3P@hirez.programming.kicks-ass.net>
 <b2943f49-41ba-59c9-2592-d1a91a151138@zytor.com>
In-Reply-To: <b2943f49-41ba-59c9-2592-d1a91a151138@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|DS0PR11MB7262:EE_
x-ms-office365-filtering-correlation-id: 00bdb8b8-3762-483c-4254-08daa8ee7f6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xj7vbINy3gYEZ9ZQmTM8wjHUthV2ENlx4/gVXfkWoFWBknQHLHI44FhAXvALOtsRJqgi+u05Gk4LNvaoO6ksFypL/cCCwTnC9vkRD07q9yNI9VAqSM1i9mh2gPZIjLexfMaMkSPuj/lBBNDRjPYckIJreFNaBxmghL/5dnfhyAjkMjxWyCo/Qy6qQaV0vTkkPNOL6jbmNRWVqzcCbWO791xKLmEMAoDwTbwss+pdgb0jS3lnrW+gkmKp/w6gG7IqlhvIGrdkhVSE8EPe3jNNflsxzKhOXeB3BR++N5RLD2y6B+x2O85vhLIWgNDGCacam3eOXlplYTrScjPeKr1KhvO2Oa5wMyLZRdy8mghJby/3jHbOh5ImSh5Zh8IT0Fb9ozAsEsSp2o9+XomVlFY7xmv9bnYwT6qkDvzg3id2O/lqDtoktvjb5aFdMIH+2RpL9vIPEhuvuGDIuFsz2g2Kxu/TVAmktNrkX4QF4lfpx2LkbqFLaCjimGu1XXql/RIyCFBzOO1V4A8SF9RnRRQ0PzJXqORcADdsqy1B6HnxL/3cP9X5YbUyTwpZDhESHZLCfIPeLMS38u+8sKsOLKeeqs95NchN/JxYutdi3Sg918VAGE7EjJiDHCe7qHX/zvj4K0SOHPP/BPbot/P6tVaOoCv4sJvr+F7xtrdGLMeu9l7xw65bGjnHkR1A8AnWqXeDfASm/7eB5AZlvd8Q3rGQtqrk/jl3w/1vkYx81VOe+1w+YWYsSrFXpJwrjI+qhH4TSh5HlfOnGH+0H91luDYtUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199015)(38100700002)(122000001)(86362001)(33656002)(38070700005)(82960400001)(6506007)(52536014)(478600001)(8936002)(5660300002)(2906002)(7696005)(316002)(66946007)(76116006)(64756008)(8676002)(54906003)(4326008)(4744005)(41300700001)(110136005)(71200400001)(66476007)(66556008)(66446008)(83380400001)(26005)(55016003)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0RpMTVaVGtmaXpvcHJ1VEhNOStSWkFwaEJteHNKbFJlTi9WYldDTU9xQWtq?=
 =?utf-8?B?dFlrczN6QjMwVlJlOUZ4RHF4RzhWNFIzSjA0alJZNm9aZWx6TzB6OHJIWHVt?=
 =?utf-8?B?ZHpWb0xhNWFDVlVlNkRYdFNJUmFkb3Q1aldLcktDejREMG9FQzJKREdMODVY?=
 =?utf-8?B?eEk3RDlDZFB4YlVKTDNhR0xWODVmMVFvLzNzRndYU2lVYnNzTGJzSUtqKzMw?=
 =?utf-8?B?eGNDbVB2VHV5YzZXRmtqdkpjclEzMWhhTDRBRmVlRWlGUXFCOFBZZnhpSEFB?=
 =?utf-8?B?Z1R6TW9SZGlvbVRjTXVMOUd6Nm9PNWdWVEg4YVR3UHU4VWhGMDQ3TnphajRj?=
 =?utf-8?B?SUE3aE9JN0k4d3M1dXRzM2N3REE3VzhObmhvQzU0VXQ0RE1sYUdQRnBFbXh0?=
 =?utf-8?B?QzB5YlgybC9IMTU0UjRwNGN6V2tiVTRFR1IyTmVFYXVWM0ZFajlPN0ZpWmdx?=
 =?utf-8?B?NnZodjEwdXVKOWlwaWhldGFOU3N2dzRGSDRvSGoyTnl1R004bXZIcS9sNVYy?=
 =?utf-8?B?ZEEvSGVFeEFoV3BhcnNxbWRWbjNER1gydDVsRDE5ZjdwdmI3ZlAyY3ZXUUhQ?=
 =?utf-8?B?MnVNQVFEUjdTM2w2cW5DY1Z5KzFYZFgyQzM4cGhpZVdPUjZaRjhsUDBST1du?=
 =?utf-8?B?RGRrTWhvaWtrbEJQTHVUQnFpc0lMSGtEdnlOdW9KaFQ2NjNYRmdrWWJEUzkv?=
 =?utf-8?B?VExOK1dZR0Y1c2VPYVhoR29JTitZM1hnL1YvRVQrQWFuc3V1YzBQSUNJM3E4?=
 =?utf-8?B?YlBTV0ZmRjYyRnU1RSs2blNPL2xzN2VpRUhwR0RBSFZyblVqVzZweElrV0tN?=
 =?utf-8?B?WmEweU4vcXdxWWJzT2pWTVRFRFNuV1NrbFlPanhmUUVabGdyUDRUOFYvZmZ4?=
 =?utf-8?B?d25mblFwRkoveHZtWHFHOG5mQWJCNzMySUdqV041VVhBNHpucmxGY29za3RS?=
 =?utf-8?B?ZmU2aXlEa3dVRFE5d1RVdUFyclpQbEovQkttSHZOQmNDVWtqTVZyd3pOQUtG?=
 =?utf-8?B?bDFwMnpUQWlHUnN3eXBzQXBLNTRwRGVzcUtpM1l3QU5xcmJudDNEZG5vdDY0?=
 =?utf-8?B?SldFU3BwWlJXcDdoajd4TnhiNW8zMkVCdFcvT25mQURwaXBmVFA1U0JxK0J4?=
 =?utf-8?B?MktzUnlhajdyRkRXRHhmZHBYb1JoSFVaV05XQVI2TVptNG1WakdoYmdiMm9Y?=
 =?utf-8?B?NUdYYVhsbDFVZlpWVkpvVXBqZ3VrNDdLV2RKbm1GUGI2azhNeVdRY1JGdjRP?=
 =?utf-8?B?WmFqSHRZZ2lSaENTTDA4ZXJhOFUzV2ErZUU5YklUMVhWeG1YL0VtWHpQcGhp?=
 =?utf-8?B?SXo0dEdqd0FDRTZyUlJjK3BUdzlNNVRUVGxBbVZ5QzRwN1V3Ymo1ejZ6bUl6?=
 =?utf-8?B?cVhKTlEzd2VyRzlDV0xOU2J4eVllSnBucTdyMTNGNTBzbzZnUmNWWkpuUE94?=
 =?utf-8?B?eGR1dWlhbWNVelMzemh0REZkUVVRWkhsWXUwbHA2cytBMDg4Yjl1dlR2TzRN?=
 =?utf-8?B?a1I2c0MzVFRQUUc3OWRCTjd1WGY1L2J1NkxnMytTZVhXWjF3VUQ3MVdzOUtj?=
 =?utf-8?B?RGZicXZvWStkbTVtSW00UVZtTXpXOWtNOHBBSnBjWmNaZFh3L2oxSGNkYmxv?=
 =?utf-8?B?OFJrSVVSREdpUkNIMjVRMlBhUVJHTEJTeGlmS2ExSnhtdnd1TElLYUNLR3A4?=
 =?utf-8?B?K3p6Wmp6N2dkYzh5SUNQcWJZSW1pODZQYUt3NXl2d3pMc0JoMzBPRVU4WWlm?=
 =?utf-8?B?cGFBTjBjWjRYQ0xnNWsyaHljcldQc3EvQ1k1UFNuSlVuTHI1L2pxNGtRVVRF?=
 =?utf-8?B?c000V2xaN2Y5TmRacFUrZWlqc1VBckR2M2swNU5nQ2ZyZ09LZ2FlT0swdHI5?=
 =?utf-8?B?UEpoY3l1U09WMW9iTWpqcUFUR3BVTDUyRU9DdHRIMUY5WFcyYkF5ODFMSXFZ?=
 =?utf-8?B?RGJRbWhxUkFFaE43UEJnTGFCNG1mWnNickQ3eVp1aHk4cTRBQjRwdnFNaFNo?=
 =?utf-8?B?NDBEeFdSV3I2d2I5TlMrRTUxNkZxNFJuSjJQSzB4aXlyTGgydzdVcVlDOXNW?=
 =?utf-8?B?a1hYUVVVa0orcDVJc1ZDSHozcU0yd1Nsb3RKdGJST2t2UnZnRXc3TkpXR2E4?=
 =?utf-8?Q?g2j4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bdb8b8-3762-483c-4254-08daa8ee7f6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 05:32:31.9361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOSC9FgiMI9R3arHBjvZNlvM+nzNGAwbbw211fAxaRxU0e86WUNb/pLB3qDd0n47OrOBWhv+AaKa0gGZp5X8IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7262
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEFuZHJldyBDb29wZXIgc3VnZ2VzdGVkIHVwZ3JhZGluZyB0aGUgb3JwaGFuIHNlY3Rpb24g
d2FybmluZyB0byBhIGhhcmQNCj4gPiBsaW5rIGVycm9yLCBvcnBoYW4gc2VjdGlvbnMgYXJlIGJh
ZCByZWdhcmRsZXNzLg0KPiA+DQo+IA0KPiBBZ3JlZWQgMTAwMCUuIFRoaXMgaXMgYSBuby1icmFp
bmVyLiBGcm9tIElSQzoNCj4gDQo+IA0KPiA8YW5keWhocD4gLUxERkxBR1Nfdm1saW51eCArPSAt
LW9ycGhhbi1oYW5kbGluZz13YXJuIDxhbmR5aGhwPg0KPiArTERGTEFHU192bWxpbnV4ICs9IC0t
b3JwaGFuLWhhbmRsaW5nPWVycm9yDQoNCldobyBpcyBnb2luZyB0byBtYWtlIHRoZSBjaGFuZ2U/
DQo=
