Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700206CD1D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjC2FwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2FwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:52:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFFD2127
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680069133; x=1711605133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p3usiXT0OWvx7c48hcpWmQTs7HQA37+WXnj5dhkVQcc=;
  b=ltI0deZcbRAgswofkTJJLH7JdF9QnDp2JnEd/SkNeKODvNbMkvuWi78/
   LUkrJVhF18pOpFt+Sd8jNzK4AtnfriAc0mKmRw7lem1driKeuA7PoKwBH
   RHCORp4fuppvx2MZ7Ht03EHDnIsNlDeA0++Dbew4GwDEJubfCqOxxCkbH
   Yr4ND/FA22IKyt07p0KXIrgXaZbQUFlTM+wY5/bDEsReJv7DE9dYBicRA
   9xuyADoJ6dV66rt/E1WxcQ15GZoa5KlGc0XhJlYg5hDKqvH0bB4Ike/Py
   LtTBGzZMPqrQ20zghFVxpvRZ+ZD5PONWD+hopKJyaJVtN22DRmsFIkPPu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="427061569"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="427061569"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 22:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="661468728"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="661468728"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 28 Mar 2023 22:52:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 22:52:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 22:52:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 22:52:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 22:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIPUf1is8mmxXV+seW99oXBvOFwSKjwafS/1Qq6LN2LJ2MFatczFhCduTLJJJFY26tVW5Abd5UI32jpd5zOH06oZW2sPrb0ub0qoFP0oPjxcLeG/vlW/bc9dR4YDowno9g9fYc13PyzhBmiOEcYsV5mBNObkDD69qBvpAiE9+djwxhTE2YmTJu8ntxy1Fa0GkgbST7d5Yw5IS8/CYQIHapcGW4NtCS8cF+W8mPdZUImYqHcj1ozrRXw/jlbI/vM6zGljbPyHuHQzmRuuLtAs1i5ApIt5nYcNJLcb2yjjeYh6WTiWiAtEqJnXSzTwjpAUS5ymgDXoFx73sWGPhdT+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3usiXT0OWvx7c48hcpWmQTs7HQA37+WXnj5dhkVQcc=;
 b=GsJWThhq2yt7HNM4nzjbbaBF5Swr/9yYRB3Fho5gybkStPBW+r7FUhHWz75PWn1Fp1u7h2KMB2lt9DXbcrGj0kJlpL/cZk6CfaEL05xvj4Iwvenmq9Utqu0na/rOOqZIH+iXEiL8S9cXk6t36usbn1udfUu51hlBWWhdLjzbeYUU46jlteRCrfrqzthBcBD9LRSqKXURU+oLvsgBVTnqaC7oBHQZH/4GwJ9yITUM45im97tpYxuMoGb+1PBjK6e6iclXgwopoULWpc0xUlylUBc0DmrAWhn1lRHnWthTv71VR2PCLXAkD39HTfuZ96X7bL+6Fqj6YpzM50ck00RiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BN9PR11MB5515.namprd11.prod.outlook.com (2603:10b6:408:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 05:52:07 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5ac7:aae0:92aa:74f0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5ac7:aae0:92aa:74f0%5]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 05:52:07 +0000
From:   "Liu, Yujie" <yujie.liu@intel.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        lkp <lkp@intel.com>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "will@kernel.org" <will@kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: Disable EL2 traps for BRBE instructions executed
 in EL1
Thread-Topic: [PATCH] arm64: Disable EL2 traps for BRBE instructions executed
 in EL1
Thread-Index: AQHZXrH5KcpVz1+Jz0eMuCLzHZNBrK8OJ74AgAMfWYA=
Date:   Wed, 29 Mar 2023 05:52:06 +0000
Message-ID: <1aed64aff49b74bfe2e7295c0ae7e40fe6d68055.camel@intel.com>
References: <20230324055127.2228330-1-anshuman.khandual@arm.com>
         <202303250802.KytExIHw-lkp@intel.com>
         <4feeae36-f6fe-1422-9f0f-081b9106e91c@arm.com>
In-Reply-To: <4feeae36-f6fe-1422-9f0f-081b9106e91c@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6392:EE_|BN9PR11MB5515:EE_
x-ms-office365-filtering-correlation-id: 804b91a0-717e-49c3-3129-08db3019bac8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smkq2ifTYNT3jHCppeRC4sLEBJeTYgez2z2Pksm2iMu5ZaWM/Nf/ZVbpnEWhRNHRAb/MipEETmZc7Fn38CNLeNbSpiGyAaYOqWo3+NFaIv2zkJlRDad1cxBbFMRhL6Gntaqy8fnDrl2WMHqowHxqTbnI9c08BzoFRGkaFPc/1uXworpMuFJNM3XVmkgUyFD09kSEBKr5Wp3ZU9R6FwdzcZzQvxbHqDi0DOZ9OJafzIdPdaBJGyAFF4CvOmGOAg/tWCNYZCGkBI1AuQ3X5IwzzZGSnj5wL1nBqhaCZ/yRjBCifIO+91ttBsFbJ4ZKR6d4zO79scVZQKGpT18vT5XnYBCSXmKtthE8RqyXlt0X6rJJKzjLeR6TbV2/YJMKDtlzUknNPIqFgcIKcr3YcNd00UUzW6OQ6jyDe8oG5FylwLhAJ+FQiC9k90PMlbydmWUAFtbwEawnmui2Z+GBHHdSwjYQO+W22g6ydxuOUaPT7cqiPjXnQj8Ltw4LiGrdteDgGEwXTmHY0sFre/bMnazTZkz86Mz1j1dtLWbYEqBgh8gTdcnZdkGSR8dZUo1CqQs0Pi1IZ+d5/OYNM/2ur/+4wb53ih3i1Bj/0KmnZa1F/K5fzuLEsWgCIF7XBD8+5JfoCj1kg4KgFZSMdCa5Qa+5Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199021)(82960400001)(122000001)(53546011)(26005)(6486002)(966005)(38100700002)(2616005)(186003)(2906002)(8936002)(5660300002)(6512007)(6506007)(36756003)(54906003)(6636002)(478600001)(110136005)(316002)(38070700005)(71200400001)(91956017)(86362001)(41300700001)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WllXU3FsdFkvamYzam5tK2VESlp4b0FoVnNQQkd1YmtDMXRocVlhVXJnbUk0?=
 =?utf-8?B?Q05qR0w5S0h0d1A2OWplYXBGbEpmTjR0MEZmdkoyOVJaT3Z3RXBhMVI2aHIz?=
 =?utf-8?B?ZVFISTdhOW9EYkZSRTR3RDFQdUJmRDQzL3NpbGV4bkI4M0VkRC9jb2JxQ0ph?=
 =?utf-8?B?cCtRUStMekRnOGtjSmJnRGtqamdjWGVLd1FKSURJVDNsaGpMdWxGUHRib3RI?=
 =?utf-8?B?YUNVWDh2MWhQUE1GeEhIeWRMTkpLdDQvVDRNVld3M3lpcC9IaFpvemtxSm5r?=
 =?utf-8?B?bEtqeEFoMnlaVmpTaVlsbTBBU0JVZU1qWC8wRGU4eGJoK1lJUjZSSE1xQ3kw?=
 =?utf-8?B?Q25CbXNuQVBNZWNWSUV0TS9MbXVLS0w3OE43TWtzRkdiZnZIcTFFTWd0WmQy?=
 =?utf-8?B?b0k5UUE1Qlg1dHNXbmZ1N1lnbWY0Zm1nMzRRcFZXMkJmSi9RL3RUbkU1SEpD?=
 =?utf-8?B?K25QaEpTMmtHd0czWkd1bjdnL252cWFjL0tXRGFxdXltcE02UFdTV1JDdEsw?=
 =?utf-8?B?cWs2VWc3cFFxeHdYN25zaHZkZ1BFN1Y4N0hkaldNZ3VITVR6Skgvbk5NME1i?=
 =?utf-8?B?Z3dhRi9Wam9YOUlQSHZ1YzBNelBGYU5KNENTOWNPeXRsK0kyWkZKUFlBdlNW?=
 =?utf-8?B?b1Zld2E4aXpmK3FSVS9IQUxVT0RFVWdHOHBscXlITUVEbHFJVjI0VUhNNDZ6?=
 =?utf-8?B?cXZwcktZOUJ6Q0dtaEo2ZG1ROVcwc2x5SWNqNmx1SWlrQkdBaGtMQWh5blY2?=
 =?utf-8?B?UGV2MmZaTnFtdFE0YlFWSFhMbmgzTEJhUHdZQnVkbE1lR3J2SGNhdGxNdmhH?=
 =?utf-8?B?YVFsUFJNK3VzQ0tvRWk4Q2hJOG9rWE1MWkNNRzRILy9ML2V5M0dTTTdyOGZ2?=
 =?utf-8?B?ODVDNHZFUVp2eUxleWYyTVRXTU9QR09VY1ZEbXFqNUNwVTdQdUdtNmdlSnNU?=
 =?utf-8?B?MHpDT3RIdDIrZkpKVlJ1UEIrTE4wazFCOTNvTzZqZVhnUkZqSXFxTTBEWWk3?=
 =?utf-8?B?bkNuMmNaam9WZ3htQ1lON25uOGpyRlYybDA1d0F6ZHpvbHdZa3kwK3Q2U09U?=
 =?utf-8?B?Zmh1NjFOUWR6ODJlRU5OdlZNWjg2UUVGRlQ0QjB0ZjljREJnV1JRQUIxYlI2?=
 =?utf-8?B?c09PRUdmWDlFcUV3OEszOWlPd1c1VXhXZ1BaVTBITWVrTFQ3NCsvUFZoNldS?=
 =?utf-8?B?MkExbkxJZWtTWWlTWjd4L3ZaVzBDTUlDSlZNZzF1M1VheHRPTUI2bHdFMVVG?=
 =?utf-8?B?L2NhL3dHQTVlaDhIWXhQWDFCRzN1VWU3eGdBSmhUdXdyeTRPOUF3bVNrbm5W?=
 =?utf-8?B?WWcwYkg4RGU4OHJzeUszT2J2RWt0Z1l0U05JY0FWVXF5Mk5nN2NLR0hBc3JN?=
 =?utf-8?B?cDZmNFAvT2t0RDdraE5GaUpwLzNTWFhqOWdGeGl1MTdRU0k0ZWd4ZlVNVkty?=
 =?utf-8?B?Vk9mNzBUOEpvQy9TbC83S29JSWdNY00xZDNsR2JJN0crc2NNZFRuWkJaWU0x?=
 =?utf-8?B?ZnBFQXpjMHRtbjhNZUlpOXg5QWlrbFg4UFdRcUVQMXdQdHVrWS91YlBtc0pN?=
 =?utf-8?B?SktBbzhrVXI0bEtrTjZjUERMbEtrbjJhREFIVjVvS2ptWkxWemVDaUx1ZENN?=
 =?utf-8?B?eGhkTU5GL0xPZ2lPSjBOUVM5Mkt0OVpDaGNuK3pUNjhYb2U0ZDB6bDFwam9v?=
 =?utf-8?B?RmdROEE4SkxBbmpVckZGTnhWb1pkNmtoZGZxUFJ4NkFyN25xUU51a1FiZUor?=
 =?utf-8?B?ZXNPbTNPdzdhNnlKY21ZdzZZSXJFeGhWZDhBVjFEa2t0VWJ1Znp1TTByc0Z3?=
 =?utf-8?B?Nlp6ZG9BQ285eW93WU5JSWRmdmVOV3M0RWZuWVNTMDZxaHhNQ2U2dVF6ZnBy?=
 =?utf-8?B?Q05OTTJZa29RYUJhZmVyVjJja1FCN0pRMGlLNDlKaWM0ZlBFU0lINTJzK3Rj?=
 =?utf-8?B?eGxUR2Zyamwzem5VeFVJTVBaSkZFaHFuZ0d5bDdwZi84RXJHcmxJQnFtSzBn?=
 =?utf-8?B?WjR5QTZSMklna05LUFovTXRXcjUzQjNTZmZlTitCVlZidnc1QjV5cDRXd3l3?=
 =?utf-8?B?UVZrazJ2SFV6N2IrOWtxTkVHWkpRWmJYemUzeUQrdjgvRTlRcStHOW4wT0pC?=
 =?utf-8?Q?14sZ6QwHOk6Ugto1HUkVVywme?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA28B0081A6EBC4FB491FE04BC5BDDEF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804b91a0-717e-49c3-3129-08db3019bac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 05:52:06.8932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iw+DcCZye1cdN1C1anv/Gj4wZuBqdtn18WTPlqMFwZCu7BbfMPzhafk+JdwOUb5Z0XTcGr/+grKrwI2XZU86Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5515
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTI3IGF0IDExOjM4ICswNTMwLCBBbnNodW1hbiBLaGFuZHVhbCB3cm90
ZToNCj4gT24gMy8yNS8yMyAwNjowNywga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6DQo+ID4gQWxs
IGVycm9ycyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiA+IA0KPiA+ID4gPiA8aW5zdGFu
dGlhdGlvbj46MzY6MTQ6IGVycm9yOiBleHBlY3RlZCBjb21wYXRpYmxlIHJlZ2lzdGVyIG9yIGxv
Z2ljYWwgaW1tZWRpYXRlDQo+ID4gwqDCoMKgIG9yciB4MCwgeDAsICNIRkdJVFJfRUwyX25CUkJJ
QUxMDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF4NCj4gPiDCoMKgIDxpbnN0
YW50aWF0aW9uPjoxMDoyOiBub3RlOiB3aGlsZSBpbiBtYWNybyBpbnN0YW50aWF0aW9uDQo+ID4g
wqDCoMKgIF9faW5pdF9lbDJfZmd0DQo+ID4gwqDCoMKgIF4NCj4gPiDCoMKgIGFyY2gvYXJtNjQv
a2VybmVsL2hlYWQuUzo1Nzc6Mjogbm90ZTogd2hpbGUgaW4gbWFjcm8gaW5zdGFudGlhdGlvbg0K
PiA+IMKgwqDCoCBpbml0X2VsMl9zdGF0ZQ0KPiA+IMKgwqDCoCBeDQo+ID4gwqDCoCA8aW5zdGFu
dGlhdGlvbj46Mzc6MTQ6IGVycm9yOiBleHBlY3RlZCBjb21wYXRpYmxlIHJlZ2lzdGVyIG9yIGxv
Z2ljYWwgaW1tZWRpYXRlDQo+ID4gwqDCoMKgIG9yciB4MCwgeDAsICNIRkdJVFJfRUwyX25CUkJJ
TkoNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXg0KPiA+IMKgwqAgPGluc3Rh
bnRpYXRpb24+OjEwOjI6IG5vdGU6IHdoaWxlIGluIG1hY3JvIGluc3RhbnRpYXRpb24NCj4gPiDC
oMKgwqAgX19pbml0X2VsMl9mZ3QNCj4gPiDCoMKgwqAgXg0KPiA+IMKgwqAgYXJjaC9hcm02NC9r
ZXJuZWwvaGVhZC5TOjU3NzoyOiBub3RlOiB3aGlsZSBpbiBtYWNybyBpbnN0YW50aWF0aW9uDQo+
ID4gwqDCoMKgIGluaXRfZWwyX3N0YXRlDQo+ID4gwqDCoMKgIF4NCj4gDQo+IEkgZ3Vlc3MgdGhl
c2UgYnVpbGQgZXJyb3JzIGFyZSBjYXVzZWQgYnkgdW5hdmFpbGFiaWxpdHkgb2YgdGhlIHByZS1y
ZXF1aXNpdGUNCj4gcGF0Y2hlcyBmcm9tIE1hcmsgQnJvd24sIGluIHRoaXMgdGVzdCBlbnZpcm9u
bWVudCA/DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAzMDYtYXJtNjQt
Zmd0LXJlZy1nZW4tdjMtMC1kZWNiYTkzY2JhYWJAa2VybmVsLm9yZy/CoA0KDQpUaGFua3MgZm9y
IHRoZSBpbmZvcm1hdGlvbi4NCg0KV2Ugbm90aWNlZCB0aGF0IHRoZSBiYXNlIGFuZCBwcmVyZXF1
aXNpdGUgcGF0Y2hlcyBhcmUgbWVudGlvbmVkIGluIHRoZQ0KY29tbWl0IG1lc3NhZ2U6DQoNCi0t
LQ0KVGhpcyBwYXRjaCBhcHBsaWVzIG9uIHY2LjMtcmMzLCBhZnRlciB0aGUgZm9sbG93aW5nIHBh
dGNoIHNlcmllcyBmcm9tIE1hcmsNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMw
MzA2LWFybTY0LWZndC1yZWctZ2VuLXYzLTAtZGVjYmE5M2NiYWFiQGtlcm5lbC5vcmcvDQoNCg0K
VGhlIHJvYm90IGNvdWxkbid0IHVuZGVyc3RhbmQgYWJvdmUgZGVzY3JpcHRpb24sIGFuZCBpdCBp
cyByZWNvbW1lbmRlZA0KdG8gdXNlIGBnaXQgZm9ybWF0LXBhdGNoIC0tYmFzZWAgdG8gZ2VuZXJh
dGUgYmFzZSBpbmZvLg0KDQpQbGVhc2UgcmVmZXIgdG8gdGhlIGRvY3VtZW50cyBpbjoNCmh0dHBz
Oi8vZ2l0LXNjbS5jb20vZG9jcy9naXQtZm9ybWF0LXBhdGNoI19iYXNlX3RyZWVfaW5mb3JtYXRp
b24NCg0KRm9yIHRoaXMgY2FzZSwgdGhlIGNvcnJlY3Qgb3JkZXIgb2YgcGF0Y2hlcyB3b3VsZCBi
ZToNCg0KICAgICAgICAgICAgIGFybTY0OiBEaXNhYmxlIEVMMiB0cmFwcyBmb3IgQlJCRSBpbnN0
cnVjdGlvbnMgZXhlY3V0ZWQgaW4gRUwxDQogICAgICAgICAgICAgYXJtNjQvc3lzcmVnOiBDb252
ZXJ0IEhGR0lUUl9FTDIgdG8gYXV0b21hdGljIGdlbmVyYXRpb24NCiAgICAgICAgICAgICBhcm02
NC9zeXNyZWc6IENvbnZlcnQgSEZHW1JXXVRSX0VMMiB0byBhdXRvbWF0aWMgZ2VuZXJhdGlvbg0K
ZThkMDE4ZGQwMjU3IExpbnV4IDYuMy1yYzMNCg0KUGxlYXNlIGNoZWNrb3V0IHRvIHRoZSBwYXRj
aCBhbmQgZG8gYGdpdCBmb3JtYXQtcGF0Y2ggLS1iYXNlDQplOGQwMThkZDAyNTcgLTFgLCBpdCB3
aWxsIGdlbmVyYXRlIGJhc2UgaW5mbyBpbiB0aGUgZm9vdGVyIG9mIHRoZQ0KcGF0Y2g6DQoNCmJh
c2UtY29tbWl0OiBlOGQwMThkZDAyNTdmNzQ0Y2E1MGE3MjllM2QwNDJjZjJlYzlkYTY1DQpwcmVy
ZXF1aXNpdGUtcGF0Y2gtaWQ6IDZmNDQ4NDQ0YzdhNDBhNDQxNDZkNGVjYmZhNTcxOTBhZTMwYTI1
N2YNCnByZXJlcXVpc2l0ZS1wYXRjaC1pZDogNDg0YzYwNWZhOWQzNWQ3NzZlZGEzYzQ3YWI5NWEy
NDg0MTcxMjg4NQ0KDQpUaGVuIHRoZSByb2JvdCBjYW4gcGFyc2UgdGhpcyBpbmZvIHRvIHNlbGVj
dCBiYXNlIGFuZCBhcHBseQ0KcHJlcmVxdWlzaXRlIHBhdGNoZXMgYXMgZXhwZWN0ZWQuDQoNCi0t
DQpCZXN0IFJlZ2FyZHMsDQpZdWppZQ0K
