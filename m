Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2724A6DE8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDLBPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLBPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:15:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48673594;
        Tue, 11 Apr 2023 18:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681262103; x=1712798103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J3MCmSr4lXY56ZCIk4RPIyi5ymC3XTwGGhTcNKUqNY8=;
  b=Nvxu3pfbuazdWv+Na4AWpE6xyGhDjiDtZkh7sTvCFNbOuQOpAjdrNmAK
   oVt7Qf8xEpkYvfcsXBi4xCgByvin7toREXs469wQ2xClTCZ0EcduaLnW+
   IpvnHsQJ3bXvhaLMSXRGjoBULopRU+J/H1WUHHkVjuVcfPucGhvlSCSQd
   lvNWvkF/tYJGCM5LgbTFfMAyspQHgeGXh3EYym1CqjdrE9p6cAxi3Q9da
   DFIpbEbq8sFxPh8pwgDs97yAnBxJtqGhICQ+TxzwjZ8LjiHdCSkVRhyoB
   y8VnyPiJzHylOMp+5x468jeGS+4EaqywG7O/zTgPUY42Igm3rpLrIrlUD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="323401439"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="323401439"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="688775220"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="688775220"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2023 18:14:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 18:14:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 18:14:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 18:14:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 18:14:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qnd0YnzY41VuzJvR2AUwsggCbnymk/Pbc32SYUaLlrtQu4RrDK8Zzp5ZDZivvdwo7x/b1REjO5jLjWSP5fk3KA5vUwX/B7I6Tcq2hCW+M92uc9Rst8hcyARX6cSEVKUYawVI6hJymfUR/7RDgbGFg9dImefWvryLtDe4G394+anZM5vxuD5wfbpfEhMfPzhtn92Wd29A4ZZYjro0VGAqN2cFUCxLGqSSt86wV3cJrDfzB8wDFMLTA5vcUUPDFxgXoajbbm8dYHGQ+HKfmgOsepCmVnMIsPP2CWp3dWCcyjKkt4bxdHfW4koPu+/sHOw05tqXUuAEoKtM6Yhc0lyKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3MCmSr4lXY56ZCIk4RPIyi5ymC3XTwGGhTcNKUqNY8=;
 b=mgx+D8BpFTX1C+KQOgZh7dxuazFg/fjcqlxaX4Aolj36ETWs47zinT+DHtRlPZK/pG6hx+cIMQFKL0vXWw3/0o4W1yJNtm+5peYSyAzVl/ZUf9bzP19sPgmeKpOmkHV6k5TdFSbWQW/BtAiLBKVQTBbW3Ry2yt+TWY5uPYIEcQT1OB06UsQp4y+YSJLRIWb8ZCXEtSpILVNEeP166IXDt0aVHan8iQtFYBq8T9FuOaZoaUvCiKBxHqxbgFjt1z2SVFBi3s0yA7+89PNSZZvzuAda8ao8ibwvrWyqKIPVnfG9rFjAKsB5VejD4Z1Ldpg2MJ0oHytXF1jXdi+0oWnR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 01:14:36 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0%5]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 01:14:36 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "urezki@gmail.com" <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHi v4] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Topic: [PATCHi v4] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Index: AQHZbIGxbWUDlcMT0UGxZ1kF5gEgzq8mUJOAgACNBpA=
Date:   Wed, 12 Apr 2023 01:14:36 +0000
Message-ID: <PH0PR11MB5880BB47DCBDC36F3F432F91DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230411142733.1011223-1-qiang1.zhang@intel.com>
 <16bb9c4c-e27b-4483-a1d4-05245b8b1a51@paulmck-laptop>
In-Reply-To: <16bb9c4c-e27b-4483-a1d4-05245b8b1a51@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MW4PR11MB6618:EE_
x-ms-office365-filtering-correlation-id: 58050cd5-2342-4c98-19e2-08db3af3482b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wXYSRXtyq2T/ftOi4BDyF40qS0mCnIzpRPISvX4ZiNv56hdzCvemEykWpQ58oPm/K80Jem7okMzKJq5g6RkEhCRgdmCvYh+1DEP4KY4aMHef3sems/rf/s5dLHlY4B0W293R5LfORu0OI/7DzchQs/5fPcgEzEF6DDO9oVGkOVbCRmu57Gl2LWm0ICh5v4AYgh51Pai1+OdPeyyJhGdgbyl5JseLstxwbgZatMIzEEzaNxok00lyk9gmgAFQdr00dIDkEIjHM1Lyd5L3s2Q3RX/8NT+dH3LXTijyE7Uvs6N59F3oh/BnhniutAcjMk6kNhf05zvOl18lPLmf0gh9ZAdXuv6eUn1gH7jPrqWt6WoPoHtfPj4ipez+f+4nND/fTS53hXs3FfCGvbuJKrcTozWDxV/jZzvMUNvWNWdSff0j5H5qIvnWhHGD56Ep6bo02FtxZgoQU6cVS/UApUmUDtcUHFHGQP1LBvvTANq1MZ5V9hNLe8lBf36oSPopp4MmkTvcMchii65Fw7AwJ6AjsLl2FFxM8RdDJyfIK1/YUyP3FFpD7mgnvptyseFMF+jNkwxXZOm1ln75OZks/YIHChjwHAwbi6wqcG6M72ns1WzilwpWJpH0ZhKu8+KTxExi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(4326008)(64756008)(478600001)(66556008)(7696005)(66946007)(6916009)(71200400001)(66476007)(66446008)(8676002)(41300700001)(316002)(83380400001)(76116006)(33656002)(54906003)(86362001)(26005)(6506007)(9686003)(8936002)(5660300002)(82960400001)(55016003)(2906002)(186003)(38100700002)(38070700005)(122000001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU4vRTBRNHozb0Q0S2x6cmNRTWNXd1Y3OThUakpDQ3dmclJad3Z5VXlMT2NB?=
 =?utf-8?B?YnlLV1RMTmxKZHRvSVQyRENPaDZEQ3VkYUQ3dkl0YnpQYXZvKzlPdEhrNDFm?=
 =?utf-8?B?T2FvbVBEbE1kenoyc0YyNStkYmVuNWhoTWVMM0ZDKzZiSzVxTTdTTHpSTzlF?=
 =?utf-8?B?WWNXL1pFKzVyYXhpV1Q3SC90enBYTDBRdllXZjAwbTVMY3ExNE54NjNrU3hi?=
 =?utf-8?B?QjJsRVNPSDZtRmtOMkpoT0dtaGlSV3I4RnY2VmQvNUhDd2NXa2JMaVhVMGtN?=
 =?utf-8?B?ODhscjV6d3Y0b1VyVjVYdm5ybUowZGV1WnBJNWFTUXQ5Q0xWamxyVVhybEUw?=
 =?utf-8?B?V0FhSVFKZDNSRU90WE9heThXakdUSFZka2d0RkNmb3hOTUZzUlh3eFl3QmEr?=
 =?utf-8?B?NGdteTNEMi9wSWVUZWNZTWVXbnVxK1RtTVQ1bDQ5Mjc0eWw4RHZqcHp1Z0cw?=
 =?utf-8?B?N29RYUJuclYwRDJvd2pxVjBOZ2Q1RDJ0OHNVdzJUV3dNUTAyd05OWEpaWnpH?=
 =?utf-8?B?UEI3T05ObFBzeStXYTR6ZHpTSERKb05ZanNKTmFWNi9vRGpzL2JYbzgxRnNr?=
 =?utf-8?B?T3pKMUN1SlZJU3lXanFHNzVFYS83S0NSbDZjRmRMZjdaU01NTENObVpjRk10?=
 =?utf-8?B?TFJQWGEzSGFQY2tvQkhyWlNDZWd4VTF5YStlUTIvMUgrS3hTSXQ4ZmFWSDdR?=
 =?utf-8?B?S0VlS1hyZmtGVHNsTURNelFlNXorbnJBaTIrZGVOWmdSTzFMWStSaGxqRW81?=
 =?utf-8?B?cUlPZDZoS2ZIZlQ5TTg4YndxVCtTOHcvMTE5TG5mQ1BIcHkzck9MVVpsV2FL?=
 =?utf-8?B?SmdmU0lra0VzaFhpQnJUaUdSZVFqMGM0azNRbll5VDF2djB1YW9hRFNHa1lL?=
 =?utf-8?B?Zi9vclp5ZEYrZXFjc0JzRFp1U2JYNndUcFUxSHVKSlZZcFhKa2ZmVEkxU0ln?=
 =?utf-8?B?blhReVZxM0pPU2htS20zZG8wVlVhWE9oK2JuMy83UzRvVENzZUNyejU3VDhs?=
 =?utf-8?B?Rm5XVUFLNW1iNVprSm14M2VsVjdFSzdkZnRGSnpOL0RkOThHc3h1OEZFT2pF?=
 =?utf-8?B?NzROSnp4NHlURzRBQUJYbmdyRHplQjUxVUszTkdUeHVNQXUzVWNpMVpGdXI5?=
 =?utf-8?B?NEMzbGJCTWdIMlFsNmZwR3p2a25SYVNzdzBBRElvSi9lRGhJQ012TDA3OG13?=
 =?utf-8?B?RlFnb1RENHFycUsycFROTnZXS3A1dm1lQWEveGhDWnIyOE5FUHNoN1Y4T25J?=
 =?utf-8?B?bWZ4MVFhMXQxS0w1Y2YwWE5lMzFjR0hmM3MzZTVPeGIveDFScWFyMld4UCtY?=
 =?utf-8?B?cG16VXVpYks0cEZ3N2UyVlljS0VWc241c2svRlE3M045S3BKTS9YZkJKRXc1?=
 =?utf-8?B?UmhlcUNxNkErVWdEeiswZzF5ZlIvOEpOOGRCTlUvQWo4aXZQanJaOUxJK3U3?=
 =?utf-8?B?ckllKzZZZ2hSejBBSkNpSENCNzAzb0xmbm9YcW9EdEpWZXFOa1B4Skh0Q3Rp?=
 =?utf-8?B?N0NuYlkrREg1OUtLOEI5NEFHeDU3R3FBc3NhaktCWUpjZzl1Ly9nWGV3TlhE?=
 =?utf-8?B?MkI1THhQVWlQUGkvTTB1V3FqR0Nvc0hlNTdYQU5UeThQMzZnY2NNQUFyK25T?=
 =?utf-8?B?d3h2QkRUZVJzR1dlalVsaDEzQVBNbThTcEUweVR2SjZnV3kvQzJ6dlFydDhM?=
 =?utf-8?B?SmFvMDY5eG9QNlRpcE81Q2ZSVURWR0NZR0V5aFYwcWpDZDVqT3FpeTJYc3Z2?=
 =?utf-8?B?UVo3cUk5NGRudE5LNHgzL1hwdEZwQVlzQVVLbW1EN2lsU0xMRExNOHptNVBo?=
 =?utf-8?B?S2lGNUdDWjFnWkxRRk5BOUE4WWUyNkpWdEZFWUg2QTh6UDNTMzE0WW9ncjR3?=
 =?utf-8?B?SE9MRHpJQWhJcERoeUhnQmUxZVVGekVWTlI1bDZiemNXeFFISEtWWkwrbWE5?=
 =?utf-8?B?Z01oaXkwaHQyUmZoZnJrZk41MVZzaXhlUU90NE5PdG4xSm9CMDFEWGdlUFBC?=
 =?utf-8?B?RlhDV2MrQUx1aTZOMWpMV0hIalJqM1gxbmMzbENBUHhjQndMcmVHSWpnOTNI?=
 =?utf-8?B?U2ducG44MkpjMC9xaTlNdjl0QkZEM2QwWFQ3TVlDRk5UbGJMN2lKYUdvWks4?=
 =?utf-8?Q?QNON3bmTOBgF8ALzCeM1H3Fy1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58050cd5-2342-4c98-19e2-08db3af3482b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 01:14:36.4854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdYIfoP1uDW25Mt8MG/HTPLWMMZjQla4WFVeTlOqWUmw+gihUzGbIyE5ircsu3YrqbI4vx4KE1V2cBZvrMGOaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBDdXJyZW50bHksIGluIGtmcmVlX3JjdV9zaHJpbmtfc2NhbigpLCB0aGUgZHJhaW5fcGFnZV9j
YWNoZSgpIGlzDQo+IGV4ZWN1dGVkIGJlZm9yZSBrZnJlZV9yY3VfbW9uaXRvcigpIHRvIGRyYWlu
IHBhZ2UgY2FjaGUsIGlmIHRoZSBibm9kZQ0KPiBzdHJ1Y3R1cmUncy0+Z3Bfc25hcCBoYXMgZG9u
ZSwgdGhlIGt2ZnJlZV9yY3VfYnVsaygpIHdpbGwgZmlsbCB0aGUNCj4gcGFnZSBjYWNoZSBhZ2Fp
biBpbiBrZnJlZV9yY3VfbW9uaXRvcigpLCB0aGlzIGNvbW1pdCBhZGQgYSBjaGVjaw0KPiBmb3Ig
a3JjcCBzdHJ1Y3R1cmUncy0+YmFja29mZl9wYWdlX2NhY2hlX2ZpbGwgaW4gcHV0X2NhY2hlZF9i
bm9kZSgpLA0KPiBpZiB0aGUga3JjcCBzdHJ1Y3R1cmUncy0+YmFja29mZl9wYWdlX2NhY2hlX2Zp
bGwgaXMgc2V0LCBwcmV2ZW50IHBhZ2UNCj4gY2FjaGUgZ3Jvd2luZyBhbmQgc3RhcnQgZmlsbCBw
YWdlIGZyb20ga3JjcC0+bnJfYmt2X29ianMsIGlmIHRoZQ0KPiBrcmNwLT5ucl9ia3Zfb2JqcyBp
cyBncmVhdGVyIG9yIGVxdWFsIHRvIG5yX3BhZ2VzLCBub3QgYWxsb2MgcGFnZSwNCj4gYXZvaWQg
dW5uZWNlc3NhcnkgX19nZXRfZnJlZV9wYWdlKCkgY2FsbHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+IC0tLQ0KPiAga2VybmVsL3JjdS90
cmVlLmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUuYyBiL2tlcm5lbC9y
Y3UvdHJlZS5jDQo+IGluZGV4IDQxZGFhZTMyMzliNS4uZDU2MzkwMjViZDFhIDEwMDY0NA0KPiAt
LS0gYS9rZXJuZWwvcmN1L3RyZWUuYw0KPiArKysgYi9rZXJuZWwvcmN1L3RyZWUuYw0KPiBAQCAt
MjkwOCw2ICsyOTA4LDggQEAgc3RhdGljIGlubGluZSBib29sDQo+ICBwdXRfY2FjaGVkX2Jub2Rl
KHN0cnVjdCBrZnJlZV9yY3VfY3B1ICprcmNwLA0KPiAgCXN0cnVjdCBrdmZyZWVfcmN1X2J1bGtf
ZGF0YSAqYm5vZGUpDQo+ICB7DQo+ICsJaWYgKGF0b21pY19yZWFkKCZrcmNwLT5iYWNrb2ZmX3Bh
Z2VfY2FjaGVfZmlsbCkpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4NCj5UaGlzIG9uZSBpcyBzdGls
bCBtaXNzaW5nIHRoZSBsb2dpYyB0aGF0IGFsbG93cyB0aGF0IGNhY2hlIHRvIGhvbGQNCj5vbmUg
cGFnZSBkdXJpbmcgbG93IG1lbW9yeT8gIE9yIGlzIHRoYXQgYmVpbmcgaGFuZGxlZCBzb21ld2hl
cmUgZWxzZT8NCj4NCg0KU29ycnksIHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaCwgIEkgd2lsbCBy
ZXNlbmQgYXMgc3VnZ2VzdGVkIGJ5IFVsYWQsDQp0aGFua3MgZm9yIHJldmlld/CfmIouDQoNCg0K
DQo+DQo+CQkJCQkJCVRoYW54LCBQYXVsDQo+DQo+ICAJLy8gQ2hlY2sgdGhlIGxpbWl0Lg0KPiAg
CWlmIChrcmNwLT5ucl9ia3Zfb2JqcyA+PSByY3VfbWluX2NhY2hlZF9vYmpzKQ0KPiAgCQlyZXR1
cm4gZmFsc2U7DQo+IEBAIC0zMjIzLDcgKzMyMjUsNyBAQCBzdGF0aWMgdm9pZCBmaWxsX3BhZ2Vf
Y2FjaGVfZnVuYyhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICAJbnJfcGFnZXMgPSBhdG9t
aWNfcmVhZCgma3JjcC0+YmFja29mZl9wYWdlX2NhY2hlX2ZpbGwpID8NCj4gIAkJMSA6IHJjdV9t
aW5fY2FjaGVkX29ianM7DQo+ICANCj4gLQlmb3IgKGkgPSAwOyBpIDwgbnJfcGFnZXM7IGkrKykg
ew0KPiArCWZvciAoaSA9IGtyY3AtPm5yX2Jrdl9vYmpzOyBpIDwgbnJfcGFnZXM7IGkrKykgew0K
PiAgCQlibm9kZSA9IChzdHJ1Y3Qga3ZmcmVlX3JjdV9idWxrX2RhdGEgKikNCj4gIAkJCV9fZ2V0
X2ZyZWVfcGFnZShHRlBfS0VSTkVMIHwgX19HRlBfTk9SRVRSWSB8IF9fR0ZQX05PTUVNQUxMT0Mg
fCBfX0dGUF9OT1dBUk4pOw0KPiAgDQo+IC0tIA0KPiAyLjMyLjANCj4gDQo=
