Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C6B74A0A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjGFPP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGFPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:15:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ACB119
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688656523; x=1720192523;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=GHIIHVfpEglzMEDCGWhyqybVQKQrQcfk8G4K5qIlsII=;
  b=Qk5a3H7n3sgtFXpOXgNq+VEegVJYCqVjHQsA1eoHxmC/3EYx38JNUpcm
   wgnHVrS42peVn8AdHHvA8iXmkOUkbzjvidwTex/M31IaGV1vW3y35zrTe
   CN2Rirc54+mJyhepXtBp8aeLfTx0qJQeWp7p3fDh6tHNif/QN4aeEn2r8
   QY0NWQIgGKfmYsIYzb5ouae67wCON5LCug6LFgUsOO4yHUEqX11xQH6uA
   6hIsOtU5uIgSTUjotoWE/wqWySiD1jK+/qfrAFC703xRZzIL2ZKLietOL
   fixdJf5Zzmeu4DUj/o10x+uJpQGLvucb4dlqu0hJxV63VAP1qnHst251O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="367118927"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="367118927"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 08:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="784961114"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="784961114"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 08:15:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 08:15:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 08:15:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 08:15:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 08:15:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtEyNPGI2hugVXTysmaC1GFW9ULIAFWu2pPmtTen9Vlwyk/OPjZ7XtZocDspoBy3Ox0IrVAeWATrevU5LL/c3yDdZkTEdqBpekMbzw/QhBep8xZDwEzjqT3FyNFJel/Oti15HySEpsoAlGuUWBqhyDU5kVh6KNfJNz+lOMPj+v+1NqHiFKxXb5DWEfTMpS59TvNR6d4AGaTEnKnSTpH7x2cdvezjlupb8D/KMfdyv61FiOREUGBD4Tz6VVDX3U8fBXfDBPpN6zs0t6xjNVx1NFqrr8mn9xh9NJ+Kj70x/Vrk51tKYgRt8e5uHnANNL2VxlmwIf4PGw9Tn74EhXGtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHIIHVfpEglzMEDCGWhyqybVQKQrQcfk8G4K5qIlsII=;
 b=mlyNDWEbSC6hUSm4Yz7lyQ3+43kGT7Dv+rB4xsm+yOctDLQY3dpGBuQ5jdiVJ59zMQdKDFiUUfvLOogTBpX5+gT3GbMU/cFKFkvPt4lbX/0CcKeFOcbkO9xmuT0riNrYCJFjQb+Ac0v1n2+InQ+pawNv1rzVS2eU0SmzP+F/ytyrcoo6CSSTvd+zh8UoV7FFRzXiCcUuM1rgiMgH+9YCKGOG1y9a9GsxuL4zs3b8B7Vq9z+MVztkj0UTUrMWdRMzgnf4zTJWPbGanIfOHg3+Fried0gnoNCfnQ6RnQcKZ9RwwYV2axbn0De3nf62xByF+m/UoNe3/Utr/+ZUJliKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by DS0PR11MB7532.namprd11.prod.outlook.com (2603:10b6:8:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 15:15:17 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5dd7:db99:bf1a:4702]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5dd7:db99:bf1a:4702%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 15:15:17 +0000
From:   "Ma, Yu" <yu.ma@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "Deng, Pan" <pan.deng@intel.com>,
        "Li, Tianyou" <tianyou.li@intel.com>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH] mm/mmap: move vmKirill A. Shutemov
 <kirill@shutemov.name>a operations to mm_struct out of the critical section
 of file mapping lock
Thread-Topic: [PATCH] mm/mmap: move vmKirill A. Shutemov
 <kirill@shutemov.name>a operations to mm_struct out of the critical section
 of file mapping lock
Thread-Index: AQHZsBysRJkAlyNRbUKzXP586JZR/g==
Date:   Thu, 6 Jul 2023 15:15:17 +0000
Message-ID: <SN7PR11MB75902EEF55E7ABE8189C6CABE12CA@SN7PR11MB7590.namprd11.prod.outlook.com>
References: <20230606124939.93561-1-yu.ma@intel.com>
 <20230606192013.viiifjcgb6enyilx@revolver>
 <20230705165411.tfqqipcla7exkb7k@box.shutemov.name>
 <20230705173348.rxgzxge6ipb4hapy@revolver>
 <20230705190601.4atlxzh2wxc7zlu6@box.shutemov.name>
In-Reply-To: <20230705190601.4atlxzh2wxc7zlu6@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|DS0PR11MB7532:EE_
x-ms-office365-filtering-correlation-id: dfd6bc61-b352-4bce-1ea8-08db7e33cea8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rAsM/L1/cE++GXN2oVBTZAAK/Vk4EKnMEOlxjeqbdeXm+rLBv8WOekGd5J0oWNHHb1nO+K8gqeHTjRIZi2ralKFamZYqXAGia5J1YokMQR43Txs5um0jasqeEK0+hUd9YZoewTuTh9YisG/SYGScgsJmkySBn6lHRanqfVBhaP3JS1tiFtFHGGOTQ+dcQvx511y1Iap38n/dDY+MIRqbPWMyeVTApR16KTCSbVdXAG9xLTiGq1EasaFSqyHexlZCJZeMMBc2ta1pgJGLv+GwFE27WIjPsNzVm41X5rhq2ZQGib4Cm0PNYCSurLvWIo5iJ4n5YNL/lAMiC+lixnHI7H6/envA/flxmLVPnTE5/vsDK6VmeVmvHQwX2I6xHlSEmQrSJkQbua6bNzYgz2jsXOPRAFmY4EzQNpPUIbmMY7Cz3CH3N16du0sJh2nIy0fZIfaFU6+MriV87EXEwetoM20canj0vtQtkG9GSqqQRYDfVZDsk8gwGAiZRLLO8ZNKgoFDA9ieCyKJ8GGc62N9JKGaZzwL+2e+9iEtHc6broZa5hz8pTS47aUIaSSJHCVdmaqCbwu0ICBJJIw+rPeg7ZciMYkDuyT/ffkd5TiCvlZ2Z2h+QDUdbH9BmAKDg2AQPLtge5PlCv+dvc/Wrnkuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(7696005)(478600001)(71200400001)(76116006)(110136005)(6506007)(26005)(53546011)(9686003)(186003)(2906002)(66946007)(41300700001)(66556008)(64756008)(316002)(66446008)(66476007)(52536014)(8936002)(8676002)(5660300002)(122000001)(38100700002)(921005)(82960400001)(86362001)(33656002)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUZTNmxXL3FmNFhQZ243OGliOGJBallVRGR5ZVQ3NGtpSWhhNjNGblJBS2JY?=
 =?utf-8?B?R3JiT0ZGMjNtdnV3elROeWRTblRpOEJKT0xydmpBS3huelFsdkR3eGM4UU9n?=
 =?utf-8?B?aWFuL3NWeU1nV1Nnam56aEN3cmdyN3c4WFJpR01vQWxPVFdYSHRSU2Rad09z?=
 =?utf-8?B?dElFN25xOVpxVzE0dEwyRkcrYkdLYTlCM3RGS0FmOHZZdzE4ODZFTmxvSVly?=
 =?utf-8?B?MDl6NUVrSFR0U0hkajVudTc0a1lLWHF5TWd5R21ZYTN5K3dweGxML2taeFVR?=
 =?utf-8?B?eEQ5UHVBZTNzSmpST0Uvby9OTy9wNWo2T0t0RFZMUnFrdWtUblpjRiszVExs?=
 =?utf-8?B?VmJobzJ4NlFraVlndnE3bU8xZXBDYmJuRzJ5N1BhSlZ3dUFkM01uVGh1ZVZT?=
 =?utf-8?B?SWdzcmJjSytNNjJIbUVLWE5UQWM4OTA0cVU4WTRVZUFVMlhtUW05YmQvSlB3?=
 =?utf-8?B?WnpyS0ZWZ1VmVzZlSWZzenVFeGIyU2YrcVhIUy9ib3B5WVlwTUlTNnd0R3hv?=
 =?utf-8?B?S1JGV2xvc1dOVEMrVnVuck9KNkR1RVRUR0t5V0ZTUGlyR2VHQ2k1UFdtaXRq?=
 =?utf-8?B?SlM5KzZkQitTakZzbmdLT01FbWhTTmxzQWNJanhwZEVGTjdPeFRJTlM3K0x5?=
 =?utf-8?B?M056Ryt3cjNoV1hVZVliUlUybXB2cklaandNSTllR0RFZlVIdVB3cnNBM1p5?=
 =?utf-8?B?cnpxRmVUNVZ0VmhONGtYbExRaTQvcHprVi80N1hZZ1RTSUZUcnRXQ0wyZ3l1?=
 =?utf-8?B?Nk4rckdCU3N5WnFOQm93UjNzQ0FEVkk2bjYrMkV5V29tbWNyQUNuOHkydklQ?=
 =?utf-8?B?Y1oweHd5U0xWRWVZUVhUc2M1TzAzZUtCL2E4OEl3Zk8vbThycmFpL1VERVpE?=
 =?utf-8?B?MFU2WWYrNXQwOVREeXZraS9UOTRjT0RVTi9NamFqOWRFcUg4MkI0L0NHUVBE?=
 =?utf-8?B?OWpEUEVhLzI2eUtJbGUzQlhHb0NqMGxhUkd3WUJDZVEwK1dVajYyeFBKbnNM?=
 =?utf-8?B?MHpscFltcDJUYnJvK01RWVhHRktRYzZMODY2RTlsdmtsNm90RHk0eVRvQkt0?=
 =?utf-8?B?L2FUWStHQ0c1dy96elVkR3dBT3pjUkd5azhSLzdFMm94TjBiS1JUUFJvTmJs?=
 =?utf-8?B?QXJzTWpyZ2N6OUNnZHp0TWYrcUxiZGNrS3FQSnVtR1pzRUVzOHphbmQrUDFp?=
 =?utf-8?B?RCtGTE1lZGt2MHFxZW1mdG8xWjc1eldKRE84T3hTeFh2a1pEUlNmVEZHbFpG?=
 =?utf-8?B?Y3lMNUJMTG96Wk9RWXdNZERDMFBtWTBUMjQ0bzBuNEsxS2NpVytxdFFvV0hH?=
 =?utf-8?B?eWhFM0VOQ1RkOVNaTXg5MUxpRytScldrekNhcHBHYmQ3WWhidXpmNXc2emMv?=
 =?utf-8?B?WFUwZHU0dlJ2VEhscVBDbGRiNjYxUWtkRkpSZ1JwN2U2b2xGZDIvN1ZvTUNv?=
 =?utf-8?B?N2VVMGsyU2Y3ckRvUGFZSjA5c3JIZVpzZmZFNGZZL2h1bEQwWStuRTlmdkdr?=
 =?utf-8?B?QnRDODJIUHBQUndFOTJuOC9rZFh5a0JjVSs1ZHVmWnh2eEhnZFFJK0pkWUZs?=
 =?utf-8?B?WlN3b3YwejlHVnpZdTlvVS90emtYWGdBUzJRMDZ5cWFYVTFEUVJJSXZkQnlD?=
 =?utf-8?B?WmsxdUZUS2h3NGF6Y01VSDY0R2VsdlF2TWY1UWJzcTZ5VTY0Z1I4TTJuVVJX?=
 =?utf-8?B?UFhraXIxd1Znb29wK1VlS0MzTXhsQzJhZzRTRXpVdFZBbmxuRDhMWHVSVnFL?=
 =?utf-8?B?WUlCZ2hpaGF2c3BreXVxR29CZUxLNk1ub3ErU01QdXJjL3J6NnJPaks1Vjhp?=
 =?utf-8?B?VWxJdlRrbXBlenMrT0ZwenA0YkJyN1cwZ01kOGk5TGJGczZDTkV1d2JNYk9Y?=
 =?utf-8?B?M2RhZHI2ZWFBOUpQV2NMbFFSdUhIejdpQkRlb1RnMTZOMEJ3N0U3Q3UzMXpv?=
 =?utf-8?B?alBpMENQZ1A2RWhRa0hmelRHZnF2M0VzWmVWdWNKb0o5SU1TRGpsdHdRTmhB?=
 =?utf-8?B?UVdqaTdYemV1b3BxNHV2ci95QWpoUjdTR3pGOVBKajh0V0FEcU1nY0t3Vmp6?=
 =?utf-8?B?TWVYZEdoV2xOK3dGYU9MNFVCWENoMzFZNlJjZ0w3TkFwOXozR0t3OUlMUUYz?=
 =?utf-8?Q?3hbQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd6bc61-b352-4bce-1ea8-08db7e33cea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 15:15:17.8475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wj+c3QHjaAAEPRWrv0yOTGfCNZyZ+QtpQ7uqDfPA+bqiqrlTSLDbdYPT+eLWXTS6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7532
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLaXJpbGwgQS4gU2h1dGVtb3Yg
PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSA2LCAyMDIzIDM6
MDYgQU0NCj4gVG86IExpYW0gUi4gSG93bGV0dCA8TGlhbS5Ib3dsZXR0QE9yYWNsZS5jb20+OyBN
YSwgWXUNCj4gPHl1Lm1hQGludGVsLmNvbT47IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IENo
ZW4sIFRpbSBDDQo+IDx0aW0uYy5jaGVuQGludGVsLmNvbT47IGxpbnV4LW1tQGt2YWNrLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gSGFuc2VuLCBEYXZlIDxkYXZlLmhhbnNl
bkBpbnRlbC5jb20+OyBXaWxsaWFtcywgRGFuIEoNCj4gPGRhbi5qLndpbGxpYW1zQGludGVsLmNv
bT47IHNoYWtlZWxiQGdvb2dsZS5jb207IERlbmcsIFBhbg0KPiA8cGFuLmRlbmdAaW50ZWwuY29t
PjsgTGksIFRpYW55b3UgPHRpYW55b3UubGlAaW50ZWwuY29tPjsgWmh1LCBMaXBlbmcNCj4gPGxp
cGVuZy56aHVAaW50ZWwuY29tPjsgdGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb20NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gbW0vbW1hcDogbW92ZSB2bWEgb3BlcmF0aW9ucyB0byBtbV9zdHJ1Y3Qg
b3V0IG9mDQo+IHRoZSBjcml0aWNhbCBzZWN0aW9uIG9mIGZpbGUgbWFwcGluZyBsb2NrDQo+IA0K
PiBPbiBXZWQsIEp1bCAwNSwgMjAyMyBhdCAwMTozMzo0OFBNIC0wNDAwLCBMaWFtIFIuIEhvd2xl
dHQgd3JvdGU6DQo+ID4gKiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbEBzaHV0ZW1vdi5uYW1l
PiBbMjMwNzA1IDEyOjU0XToNCj4gPiA+IE9uIFR1ZSwgSnVuIDA2LCAyMDIzIGF0IDAzOjIwOjEz
UE0gLTA0MDAsIExpYW0gUi4gSG93bGV0dCB3cm90ZToNCj4gPiA+ID4gKiBZdSBNYSA8eXUubWFA
aW50ZWwuY29tPiBbMjMwNjA2IDA4OjIzXToNCj4gPiA+ID4gPiBVbml4QmVuY2gvRXhlY2wgcmVw
cmVzZW50cyBhIGNsYXNzIG9mIHdvcmtsb2FkIHdoZXJlIGJhc2gNCj4gPiA+ID4gPiBzY3JpcHRz
IGFyZSBzcGF3bmVkIGZyZXF1ZW50bHkgdG8gZG8gc29tZSBzaG9ydCBqb2JzLiBXaGVuDQo+ID4g
PiA+ID4gcnVubmluZyBtdWx0aXBsZSBwYXJhbGxlbCB0YXNrcywgaG90IG9zcV9sb2NrIGlzIG9i
c2VydmVkIGZyb20NCj4gPiA+ID4gPiBkb19tbWFwIGFuZCBleGl0X21tYXAuIEJvdGggb2YgdGhl
bSBjb21lIGZyb20gbG9hZF9lbGZfYmluYXJ5DQo+ID4gPiA+ID4gdGhyb3VnaCB0aGUgY2FsbCBj
aGFpbg0KPiA+ID4gPiA+ICJleGVjbC0+ZG9fZXhlY3ZlYXRfY29tbW9uLT5icHJtX2V4ZWN2ZS0+
bG9hZF9lbGZfYmluYXJ5Ii4gSW4NCj4gPiA+ID4gPiBkb19tbWFwLGl0IHdpbGwgY2FsbCBtbWFw
X3JlZ2lvbiB0byBjcmVhdGUgdm1hIG5vZGUsIGluaXRpYWxpemUNCj4gPiA+ID4gPiBpdCBhbmQg
aW5zZXJ0IGl0IHRvIHZtYSBtYWludGFpbiBzdHJ1Y3R1cmUgaW4gbW1fc3RydWN0IGFuZA0KPiA+
ID4gPiA+IGlfbW1hcCB0cmVlIG9mIHRoZSBtYXBwaW5nIGZpbGUsIHRoZW4gaW5jcmVhc2UgbWFw
X2NvdW50IHRvDQo+ID4gPiA+ID4gcmVjb3JkIHRoZSBudW1iZXIgb2Ygdm1hIG5vZGVzIHVzZWQu
IFRoZSBob3Qgb3NxX2xvY2sgaXMgdG8NCj4gPiA+ID4gPiBwcm90ZWN0IG9wZXJhdGlvbnMgb24g
ZmlsZeKAmXMgaV9tbWFwIHRyZWUuIEZvciB0aGUgbW1fc3RydWN0DQo+ID4gPiA+ID4gbWVtYmVy
IGNoYW5nZSBsaWtlIHZtYSBpbnNlcnRpb24gYW5kIG1hcF9jb3VudCB1cGRhdGUsIHRoZXkgZG8N
Cj4gbm90IGFmZmVjdCBpX21tYXAgdHJlZS4gTW92ZSB0aG9zZSBvcGVyYXRpb25zIG91dCBvZiB0
aGUgbG9jaydzIGNyaXRpY2FsDQo+IHNlY3Rpb24sIHRvIHJlZHVjZSBob2xkIHRpbWUgb24gdGhl
IGxvY2suDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaXRoIHRoaXMgY2hhbmdlLCBvbiBJbnRlbCBT
YXBwaGlyZSBSYXBpZHMgMTEyQy8yMjRUIHBsYXRmb3JtLA0KPiA+ID4gPiA+IGJhc2VkIG9uIHY2
LjAtcmM2LCB0aGUgMTYwIHBhcmFsbGVsIHNjb3JlIGltcHJvdmVzIGJ5IDEyJS4gVGhlDQo+ID4g
PiA+ID4gcGF0Y2ggaGFzIG5vIG9idmlvdXMgcGVyZm9ybWFuY2UgZ2FpbiBvbiB2Ni40LXJjNCBk
dWUgdG8NCj4gPiA+ID4gPiByZWdyZXNzaW9uIG9mIHRoaXMgYmVuY2htYXJrIGZyb20gdGhpcyBj
b21taXQNCj4gPiA+ID4gPiBmMWE3OTQxMjQzYzEwMmE0NGU4ODQ3ZTNiOTRmZjRmZjNlYzU2ZjI1
IChtbTogY29udmVydCBtbSdzIHJzcw0KPiBzdGF0cyBpbnRvIHBlcmNwdV9jb3VudGVyKS4NCj4g
PiA+ID4NCj4gPiA+ID4gSSBkaWRuJ3QgdGhpbmsgaXQgd2FzIHNhZmUgdG8gaW5zZXJ0IGEgVk1B
IGludG8gdGhlIFZNQSB0cmVlDQo+ID4gPiA+IHdpdGhvdXQgaG9sZGluZyB0aGlzIHdyaXRlIGxv
Y2s/ICBXZSBub3cgaGF2ZSBhIHdpbmRvdyBvZiB0aW1lDQo+ID4gPiA+IHdoZXJlIGEgZmlsZSBt
YXBwaW5nIGRvZXNuJ3QgZXhpc3QgZm9yIGEgdm1hIHRoYXQncyBpbiB0aGUgdHJlZT8NCj4gPiA+
ID4gSXMgdGhpcyBhbHdheXMgc2FmZT8gIERvZXMgdGhlIGxvY2tpbmcgb3JkZXIgaW4gbW0vcm1h
cC5jIG5lZWQgdG8NCj4gY2hhbmdlPw0KPiA+ID4NCj4gPiA+IFdlIGhvbGQgbW1hcCBsb2NrIG9u
IHdyaXRlIGhlcmUsIHJpZ2h0Pw0KPiA+DQo+ID4gWWVzLg0KPiA+DQo+ID4gPldobyBjYW4gb2Jz
ZXJ2ZSB0aGUgVk1BIHVudGlsIHRoZQ0KPiA+ID4gbG9jayBpcyByZWxlYXNlZD8NCj4gPg0KPiA+
IFdpdGggQ09ORklHX1BFUl9WTUFfTE9DSyB3ZSBjYW4gaGF2ZSB0aGUgVk1BIHJlYWQgdW5kZXIg
dGhlIHJjdQ0KPiByZWFkDQo+ID4gbG9jayBmb3IgcGFnZSBmYXVsdHMgZnJvbSB0aGUgdHJlZS4g
IEkgYW0gbm90IHN1cmUgaWYgdGhlIHZtYSBpcw0KPiA+IGluaXRpYWxpemVkIHRvIGF2b2lkIHBh
Z2UgZmF1bHQgaXNzdWVzIC0gdm1hX3N0YXJ0X3dyaXRlKCkgc2hvdWxkDQo+ID4gZWl0aGVyIGJl
IHRha2VuIG9yIGluaXRpYWxpc2UgdGhlIHZtYSBhcyB0aGlzIGlzIHRoZSBjYXNlLg0KPiANCj4g
UmlnaHQsIHdpdGggQ09ORklHX1BFUl9WTUFfTE9DSyB0aGUgdm1hIGhhcyB0byBiZSB1bnVzYWJs
ZSB1bnRpbCBpdCBpcw0KPiBmdWxseSBpbml0aWFsaXplZCwgZWZmZWN0aXZlbHkgcHJvdmlkaW5n
IHRoZSBzYW1lIGd1YXJhbnRlZXMgYXMgbW1hcCB3cml0ZSBsb2NrLg0KPiBJZiBpdCBpcyBub3Qg
dGhlIGNhc2UsIGl0IGlzIENPTkZJR19QRVJfVk1BX0xPQ0sgYnVnLg0KPiANCj4gPiBUaGVyZSBp
cyBhbHNvIGEgcG9zc2liaWxpdHkgb2YgYSBkcml2ZXIgbWFwcGluZyBhIFZNQSBhbmQgaGF2aW5n
IGVudHJ5DQo+ID4gcG9pbnRzIGZyb20gb3RoZXIgbG9jYXRpb25zLiAgSXQgaXNuJ3QgYWNjZXNz
ZWQgdGhyb3VnaCB0aGUgdHJlZQ0KPiA+IHRob3VnaCBzbyBJIGRvbid0IHRoaW5rIHRoaXMgY2hh
bmdlIHdpbGwgaW50cm9kdWNlIG5ldyByYWNlcz8NCj4gDQo+IFJpZ2h0Lg0KPiANCj4gPiA+IEl0
IGNhbm5vdCBiZSByZXRyaWV2ZWQgZnJvbSB0aGUgVk1BIHRyZWUgYXMgaXQgcmVxdWlyZXMgYXQg
bGVhc3QNCj4gPiA+IHJlYWQgbW1hcCBsb2NrLiBBbmQgdGhlIFZNQSBkb2Vzbid0IGV4aXN0IGFu
eXdoZXJlIGVsc2UuDQo+ID4gPg0KPiA+ID4gSSBiZWxpZXZlIHRoZSBjaGFuZ2UgaXMgc2FmZS4N
Cj4gPg0KPiA+IEkgZ3Vlc3MgaW5zZXJ0X3ZtX3N0cnVjdCgpLCBhbmQgdm1hX2xpbmsoKSBjYWxs
ZXJzIHNob3VsZCBiZSBjaGVja2VkDQo+ID4gYW5kIHVwZGF0ZWQgYWNjb3JkaW5nbHk/DQo+IA0K
PiBZZXAuDQo+IA0KVGhhbmtzIEtpcmlsbCBhbmQgTGlhbSwgSSdsbCB1cGRhdGUgcGF0Y2ggYW5k
IHNlbmQgb3V0IGZvciByZXZpZXcuDQoNCg0KUmVnYXJkcw0KWXUNCg==
