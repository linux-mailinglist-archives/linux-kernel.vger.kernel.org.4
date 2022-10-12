Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61EC5FC70E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJLONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJLONE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:13:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9462EABF2F;
        Wed, 12 Oct 2022 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665583982; x=1697119982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9s41i0HLY1h8lvouX5E/IqrBkzPFgC0Q7QtdRnuiLhA=;
  b=Gs6bwlqxRNIfnUzfa1/GBMOepm+UtrrhKbDAnUDf4FBMF9JDCoeggl2+
   YMaPZqpB+v6hbyeT7ufjUoEeyIQC/Hv0bOaaBuUGwMrZGkTY6D2qbmjWQ
   ku/dPazsO4Pmasj1WrNOTlXO2QLnOpSQ5X2CvGwulvin5/8Czb/fw7/dQ
   WkXju1bK5EWHQfuyuLqPnwcREJ447WHvJ1VXdqinkQhwUXV7FIoKla05f
   92gxtFuJxD1KVv1xQbWsHToBgpEntOhuVfbxNhPjegFUuyu7VKl/Z+6wF
   qYWDcaERQfD7+dGQZqdmXztEybtK8uZJJLRHLOkva8F7fA9PdoqcBkO27
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="331295575"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="331295575"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 07:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="621792286"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="621792286"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 12 Oct 2022 07:12:59 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 07:12:58 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 07:12:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 12 Oct 2022 07:12:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 12 Oct 2022 07:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG1CIfPXUSEHj/cVfjxyTXocaHo7nAPZYcZzZKMHU/P3/mb5F/9ElurpthGeYXae44OZC6pubp7t0CELCwveAbJ7kHWoPXjuyGoAjoPz1Qwxf0uRatuGRPWlc3xYuR3FhqQmqMajEkAa/+7eCrSQs9O44FWIspz+2m4fK2i0eh+YxAO5XOAr2DTyUVIO+yggOT7Fwfom/wMYlX8wLepo37DDHr46rWHym5mrB4lQCeEKy/LGdhIXlLayZmeqzauHTrNj+M8srvHsPbzdQo/16kgRDatX+m3Nd/IU6C3d0YY/dRv/qhFsMYuJlSvfEX8gm5rOJQlSNjRb8Q83ttXPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s41i0HLY1h8lvouX5E/IqrBkzPFgC0Q7QtdRnuiLhA=;
 b=W2FKG1tci2kJjXfHhRbvYPvlNfcH5HT/nMt2Zl0JxFQLg0vqUpkPh2Z0FNwr9AktxfwC/bkuN/NH3UMEbn/IttktV6dRh1NmrXECUhOuOa129t8Bdbvio+zKkUhEhkwf2dCRw/s262Y2FFgOKDxX+aeLaC6NwprJqC37xD1in0mMM7XUyYvNCwmXAnrN96eIi2CmqjzCE5Ktij59mgtIAFq/WHsSHEQPEcZNQiDJtBKAhy/SaQwLpFRXIt1wZGw9IshblDJnyJcuWRaV/j7wsdElvDciyVdbFNkj0/DeWBCeSFdf7VjpJh+XFUSHQvR1yWBQzRPVt9L3AA/SWkxdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CH0PR11MB5362.namprd11.prod.outlook.com (2603:10b6:610:b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 12 Oct
 2022 14:12:55 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0%7]) with mapi id 15.20.5709.015; Wed, 12 Oct 2022
 14:12:55 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH] irq_work: Migrate the remaining work of the offline CPU
 on PREEMPT_RT
Thread-Topic: [PATCH] irq_work: Migrate the remaining work of the offline CPU
 on PREEMPT_RT
Thread-Index: AQHY0Mp8t49cGyCrwE6+EpmYpauLO63+gGIAgAxib8A=
Date:   Wed, 12 Oct 2022 14:12:55 +0000
Message-ID: <PH0PR11MB588010BE988D5C12644538C6DA229@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220925104111.1454100-1-qiang1.zhang@intel.com>
 <Yzxjnhg0kcmSrnHf@linutronix.de>
In-Reply-To: <Yzxjnhg0kcmSrnHf@linutronix.de>
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
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CH0PR11MB5362:EE_
x-ms-office365-filtering-correlation-id: cd31c492-8f61-4347-2f92-08daac5bdbf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dy6BRTw37SLGSS+3FqLPGwChLkA9hc2obxfV2n93Xekc6ksLM+Ce9yCGTGR2ahx0E1LMSaWjbp5KFx9HQH9gCc90o9D8bpFfZ/Cc1ImApAWklVvtCyIvFViuqq3sNXw9bsmtAtEUHAG7SdTROxtSpOMpZlJJRyNn60PU3gjVsc9bKl9Ua/j9SqnMowGeAqV9RWr/h1RZwqptO10wiTzPWxm1S0luxFO2rHRylOwCh9JULgzRZDpvHOx2YsL59r5W25PnuiVYkzMScTVkHWAFbS8XxlOCh2VqAEyuE0hF342tmEQk2mEizOmIkKb4svzji7hVa1ymourpyTAYe3Oj3wAwyjZ4hQCVTXx6ahdEqJS9/L1xnV40btGDHBPJ3xexuxjc+hi+TCqApoU03O/XvHtEMhYKuoNzFgAt6mZuz5vr7IMMRdgnZe/DEICcvIz2IAzDKbrG+RmNQ/4V5W36tLQwgakUuI2DftabDIc5skASB97Lk+peNBuaXtlOskBvnVVnTJgDSiVN34ec7jfiIRV9YgZYcRbtm2cawAwK/6GB06ANNG0mqjLtEY1zdY0xrtSDMxLl0dY5HhhRcG+avGRDg7KwtSnJeAY3/fiMqz5KxAIGh9zssgbZDZ21b09MFREadGkZkqTX3TNe60C3k4RKywVE1o4FhHATGZ5Zfo5C3cGUAC/J5Kuh6L3WQyIeqAkZ+QeqBN4kv08RrI9jYdsRRFoFFSAHMJyX14HFwmLIbIw8RXED8hD94NQv9hBsvw2PC0Ahg/T/85LmYZGDQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(8936002)(66899015)(38070700005)(38100700002)(186003)(86362001)(122000001)(26005)(82960400001)(9686003)(7696005)(64756008)(66476007)(5660300002)(316002)(8676002)(2906002)(6506007)(478600001)(53546011)(52536014)(33656002)(41300700001)(66946007)(71200400001)(76116006)(54906003)(4326008)(66446008)(55016003)(83380400001)(66556008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmtQVjl1bXhsZXIxTXcrbktRL0tzNEZVMU1xODZIYVRhQm9CRWNoVnM1Mnlv?=
 =?utf-8?B?SVRCeHhJMmdNZ3BYNTdtbFhSZTJ5ZUoxY0RtOHVycFVpZWFnUVRXYzBKYzZW?=
 =?utf-8?B?bmM2WWtBcDVXVGN6dTg2YUFWN2NNU0NXNkgyaHBQY0VQeHhuWXhsSXhweE5M?=
 =?utf-8?B?Vlp0ZCtaVEVPMkFMQ051QXRDemtDck1OblRpZEJJcGh1YndQSWc5ZG5tYkhj?=
 =?utf-8?B?aEFrTGRFYlFXNUhKQjZKZ2o0UzlVdTQzOHQyeUlFa052RXNRN2hUVVExR055?=
 =?utf-8?B?SzB0Ym1hVEpCTldLTkdJL1ArUUZJOW9hMzJGVktjVlQ1MGlGUU1KQmpOYkZF?=
 =?utf-8?B?aGw3V2htbkdYQWxsRU9sandabGU2dEZYS2hVclZwbTdNUEpDSVgwUHcybmsr?=
 =?utf-8?B?SHBCcHROc1ZBZ3lmRGs4VFVUbVBuSmJTaUJzcWlqVERwN2NsbW9FdXlTYUo5?=
 =?utf-8?B?a2VEdmNIN1E4KytqS0d3WDlHZHptVm9UeHB6Vzk1aCtFS2gxR05nZU9iUGsz?=
 =?utf-8?B?SWJzQVBnSzVPMWJyTXNaNnRaUmFldUhVT2xneFpXUVQwVm5oemdFRnNsckV3?=
 =?utf-8?B?c0hsNWo5Yks2N0dzVDNxd0UrNTlUVmRnaUcrT2owWWMxL2dkWitKTEdQQXFY?=
 =?utf-8?B?Wnh0MkdPbi9FWTBkdFFlZUIwQm9Ib1RVR01qbEFPa0dVU2kvUjliWityTnNa?=
 =?utf-8?B?azh3cFdMc2hwU3QvRXB0NGg5WkdFQUszUG9GUHdGRXhXVEpFZmpSR3NXYzU2?=
 =?utf-8?B?Umd3bnp2a1hJN2lIeXMvODhwSVVMd0RIQUNieGdRZDg5Uzk3d3hONmo3eWdu?=
 =?utf-8?B?QnhOVU5UT3pTM0xvUE9Sbmtwa1U4MTVkRFFaSG5MUmVXUVRPL3FWUGgybFRI?=
 =?utf-8?B?bXpEZDVEdU51QjFuclRTMVRPaldxRVlDQXZTMUNjMFNNM1FEWnFlNEhER3RE?=
 =?utf-8?B?Ri9yR255eXVNRE04dGNORHRwdUVRMEpZK1UwRTlrQmkxdjRkQzdVeE40cjZ0?=
 =?utf-8?B?dGU3aDdia0owMVp5S0dGL3RDVEJEdEJFcDZzczFtd2YyMlJRampZN0t1QWZu?=
 =?utf-8?B?bDJyVi94MUFuY0x0YWVJODd3QTR4TGt4U25zOHZ5cXpSUlJaNENSdHc5K2xn?=
 =?utf-8?B?WFRNZU5vK1RwTnhreDl2UlVKcWpzWVRtR3ZLOUV3dG1UMEc3SlBYMFc4WElv?=
 =?utf-8?B?bVIwbjdPNTgzRW5ZL0w3Ti80WUVUY2dtTHU4c2E3QzgzbzRhYkpKVno3THIy?=
 =?utf-8?B?aVBPa3B1U3VVSHRMdmUzQXVrYW50RmcvSEdqb0JaS2hpaWI3MXh0ek01dS9J?=
 =?utf-8?B?OWxZK0x0YytzMzA2elNUdEVkUEZDL3RQaVNHaW1iTnA4SGtSeUpETEJybVBK?=
 =?utf-8?B?SDE2ZEZKMllkTmt2Tlh6NkR5dCsyaFhQaHZudEpmZU5tY0M4T0sxTFdPRkZp?=
 =?utf-8?B?VGVKQUVGREJOL1FhM0Fyb0pJNjNZUHN0dWYrM0NXL3ZKMzlQdWpIa1d2eTE5?=
 =?utf-8?B?MnZJR0dqV0JDWkFRRGh1bUJwTFNuc1JmTkRjN2Zlczk0TXlhZ2ltVlRjR2Nt?=
 =?utf-8?B?NTRqU1VpNXNKTCtjK2pDcUFFRVplVGFsNkZrY3dCN2h3QjNyYkhIeThUUGNk?=
 =?utf-8?B?SEpLdHJCQ1NoSDUrMStnRnAzSGY5cnRhMytLSko1TXUzMEwvZHY3NFVkRnJ2?=
 =?utf-8?B?VEFBZ3VBZ2NHL25NZ2F2SkRaSWlESnJxR0dEYktNd2N1U2o5SnFsblE3VGJh?=
 =?utf-8?B?ekFaQzFCTnVYcHYvaEJvRXMwZzJ5eERnOVdZKzR4UlVzMUFreUF5dzF3Z09V?=
 =?utf-8?B?NHJjWjhwVFhiUk5WSkJkU0lsUnhaWWVTclIyOWlQOXhoRC9rdFhoeTRMdmRP?=
 =?utf-8?B?c2UyYTZWY3dva2JJU1dTK3ZWc2ZBZ3E3RjQyejNjVlBNSmJtUm1lSjRpTVFP?=
 =?utf-8?B?MnRMcTRqUWxjb3d3VUZEQUtnWnZMcGw2aVBSQ1JoWVA3QTFUYmRTQWNxTmtD?=
 =?utf-8?B?OUFvSWRwTG1LdUtyUDRlQnpTcVBNR2grT1M4OEJESGxoVHJDeHBCK1BpdmhF?=
 =?utf-8?B?aW5wNER6SjQzYWFVSU1nMENPbWtHTlJhOHl4cnI0ODdPaGdaUDhCUUpIbGNV?=
 =?utf-8?Q?Kexshxy6bmyDHsgSsDSCKMwqe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd31c492-8f61-4347-2f92-08daac5bdbf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 14:12:55.8432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fr8JFTEYR1yaOHX3+Vvr7rcVj+krSkfA6rh8V9L7BaSh1+JOdxIUlulVNvnUE7LESqlj2PBVDBC03zMRLgLTmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5362
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMDIyLTA5LTI1IDE4OjQxOjExIFsrMDgwMF0sIFpxaWFuZyB3cm90ZToNCj4gV2hlbiBD
UFUgZ29lcyBvZmZsaW5lIGFuZCBpbnZva2UgQ1BVX0RZSU5HIGNhbGxiYWNrcywgdGhlDQo+IHNt
cGNmZF9keWluZ19jcHUoKSBiZSBpbnZva2VkIHRvIGZsdXNoIHRoZSByZW1haW5pbmcgaXJxX3dv
cmsgb2YgdGhlDQo+IG9mZmxpbmUgQ1BVLCBmb3IgbGF6eSBpcnFfd29yaywgd2lsbCB3YWtldXAg
cGVyLUNQVSBpcnFfd29yayBrdGhyZWFkcw0KPiB0byBpbnZva2UgY2FsbGJhY2tzLCBidXQgdGhl
IGlycV93b3JrIGt0aHJlYWRzIGFyZSBpbiBUQVNLX1BBUktFRA0KPiBzdGF0ZSwgd2lsbCBub3Qg
Z2V0IHRoZSBhY3R1YWwgd2FrZXVwLCByZXN1bHRpbmcgaW4gdGhlIHJlbWFpbmluZyBsYXp5DQo+
IGlycV93b3JrIG5vdCBiZWluZyBleGVjdXRlZC4NCj4gDQo+IFRoaXMgY29tbWl0IHJlcXVldWUg
cmVtYWluaW5nIG9mIGxhenkgaXJxX3dvcmsgdG8gb25saW5lIENQVS4NCj4NCj5BdCBDUFVfRFlJ
TkcgdGhlIENQVSBydW5zIHdpdGggZGlzYWJsZWQgaW50ZXJydXB0cyBzbyB3ZSBjYW4ndCBpbnZv
a2UNCj50aGUgcmVtYWluaW5nIGNhbGxiYWNrcyBkaXJlY3RseS4gTWlncmF0aW5nIHRoZW0gdG8g
YW5vdGhlciBDUFUgd2lsbA0KPnNvbHZlIHRoZSBwcm9ibGVtIGJ1dCBjYWxsYmFja3MgZW5xdWV1
ZWQgd2l0aCBpcnFfd29ya19xdWV1ZV9vbigpIHdpbGwNCj50aGVuIGJlIGludm9rZWQgb24gdGhl
IHdyb25nIENQVS4NCg0KWWVzLCB0aGUgcmVtYWluaW5nIGNhbGxiYWNrcyB3aWxsIGludm9rZSBv
biB0aGUgd3JvbmcgQ1BVLCAgYnV0IGlmIHRoZSByZW1haW5pbmcNCmNhbGxiYWNrICBpcyB0byBk
byBhIHdha2UtdXAgb3BlcmF0aW9uLCB0aGlzIG1pZ3JhdGlvbiBpcyByZXF1aXJlZCBpbiBvcmRl
ciBmb3IgdGhlDQpjYWxsYmFjayB0byBleGVjdXRlLCBvdGhlcndpc2UgaXQgbWF5IGNhdXNlIHNv
bWUgdGFzayBoYW5nIA0KDQpKdXN0IGxpa2UgdGhlICEgV1FfVU5CT1VORCB3b3JrcXVldWUncyBw
cm9jZXNzaW5nIG9mIGNwdWhvdHB1bGcsIHRoZSB3b3JrIHRoYXQgcXVldWVzIHRvIGV4ZWN1dGUN
Cm9uIHRoZSBzcGVjaWZpZWQgQ1BVIHdpbGwgYWxzbyBiZSBleGVjdXRlZCBvbiB0aGUgd3Jvbmcg
Q1BVIGFmdGVyIHRoZSBDUFUgZ29lcyBvZmZsaW5lLg0KDQpJIGhhdmVuJ3QgdGhvdWdodCBvZiBh
IGJldHRlciB3YXkgdG8gZGVhbCB3aXRoIGl0LCBkbyB5b3UgaGF2ZSBhIGJldHRlciB3YXkgdG8g
ZGVhbCB3aXRoIGl0Pw0KTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHkNCg0KVGhhbmtzDQpa
cWlhbmcNCg0KPg0KPklzIHRoZXJlIGEgc3BlY2lmaWMgaXJxX3dvcmsgaXRlbSB0aGF0IG1hZGUg
eW91IGF3YXJlIG9mIHRoaXM/DQo+DQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpo
YW5nQGludGVsLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2lycV93b3JrLmggfCAgMSAr
DQo+ICBrZXJuZWwvY3B1LmMgICAgICAgICAgICAgfCAgMSArDQo+ICBrZXJuZWwvaXJxX3dvcmsu
YyAgICAgICAgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAy
MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pcnFfd29y
ay5oIGIvaW5jbHVkZS9saW51eC9pcnFfd29yay5oDQo+IGluZGV4IDhjZDExYTIyMzI2MC4uOTAw
ZDkwNTNhNjJkIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lycV93b3JrLmgNCj4gKysr
IGIvaW5jbHVkZS9saW51eC9pcnFfd29yay5oDQo+IEBAIC02Niw2ICs2Niw3IEBAIHZvaWQgaXJx
X3dvcmtfc3luYyhzdHJ1Y3QgaXJxX3dvcmsgKndvcmspOw0KPiAgdm9pZCBpcnFfd29ya19ydW4o
dm9pZCk7DQo+ICBib29sIGlycV93b3JrX25lZWRzX2NwdSh2b2lkKTsNCj4gIHZvaWQgaXJxX3dv
cmtfc2luZ2xlKHZvaWQgKmFyZyk7DQo+ICt2b2lkIGlycV93b3JrX21pZ3JhdGUoaW50IGNwdSk7
DQo+ICAjZWxzZQ0KPiAgc3RhdGljIGlubGluZSBib29sIGlycV93b3JrX25lZWRzX2NwdSh2b2lk
KSB7IHJldHVybiBmYWxzZTsgfQ0KPiAgc3RhdGljIGlubGluZSB2b2lkIGlycV93b3JrX3J1bih2
b2lkKSB7IH0NCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9jcHUuYyBiL2tlcm5lbC9jcHUuYw0KPiBp
bmRleCBiYmFkNWUzNzVkM2IuLjcwNDYxYjZkNzg1ZCAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2Nw
dS5jDQo+ICsrKyBiL2tlcm5lbC9jcHUuYw0KPiBAQCAtMTA3NSw2ICsxMDc1LDcgQEAgc3RhdGlj
IGludCB0YWtlZG93bl9jcHUodW5zaWduZWQgaW50IGNwdSkNCj4gIA0KPiAgCXRpY2tfY2xlYW51
cF9kZWFkX2NwdShjcHUpOw0KPiAgCXJjdXRyZWVfbWlncmF0ZV9jYWxsYmFja3MoY3B1KTsNCj4g
KwlpcnFfd29ya19taWdyYXRlKGNwdSk7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC9pcnFfd29yay5jIGIva2VybmVsL2lycV93b3JrLmMNCj4gaW5kZXgg
N2FmYTQwZmU1Y2M0Li5iZmEyMTQ2OGMyZGYgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9pcnFfd29y
ay5jDQo+ICsrKyBiL2tlcm5lbC9pcnFfd29yay5jDQo+IEBAIC0yNDIsNiArMjQyLDI2IEBAIHN0
YXRpYyB2b2lkIGlycV93b3JrX3J1bl9saXN0KHN0cnVjdCBsbGlzdF9oZWFkICpsaXN0KQ0KPiAg
CQlpcnFfd29ya19zaW5nbGUod29yayk7DQo+ICB9DQo+ICANCj4gK3ZvaWQgaXJxX3dvcmtfbWln
cmF0ZShpbnQgY3B1KQ0KPiArew0KPiArCXN0cnVjdCBpcnFfd29yayAqd29yaywgKnRtcDsNCj4g
KwlzdHJ1Y3QgbGxpc3Rfbm9kZSAqbGxub2RlOw0KPiArCXN0cnVjdCBsbGlzdF9oZWFkICpsaXN0
ID0gcGVyX2NwdV9wdHIoJmxhenlfbGlzdCwgY3B1KTsNCj4gKw0KPiArCWlmICghSVNfRU5BQkxF
RChDT05GSUdfUFJFRU1QVF9SVCkpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWlmIChsbGlzdF9l
bXB0eShsaXN0KSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJbGxub2RlID0gbGxpc3RfZGVsX2Fs
bChsaXN0KTsNCj4gKwlsbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHdvcmssIHRtcCwgbGxub2Rl
LCBub2RlLmxsaXN0KSB7DQo+ICsJCWF0b21pY19zZXQoJndvcmstPm5vZGUuYV9mbGFncywgMCk7
DQo+ICsJCWlycV93b3JrX3F1ZXVlKHdvcmspOw0KPiArCX0NCj4gK30NCj4gK0VYUE9SVF9TWU1C
T0xfR1BMKGlycV93b3JrX21pZ3JhdGUpOw0KPiArDQo+ICAvKg0KPiAgICogaG90cGx1ZyBjYWxs
cyB0aGlzIHRocm91Z2g6DQo+ICAgKiAgaG90cGx1Z19jZmQoKSAtPiBmbHVzaF9zbXBfY2FsbF9m
dW5jdGlvbl9xdWV1ZSgpDQo+IC0tIA0KPiAyLjI1LjENCg0KU2ViYXN0aWFuDQo=
