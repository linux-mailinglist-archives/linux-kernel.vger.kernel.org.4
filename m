Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72619698A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBPBtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPBtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:49:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BB841B69
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676512184; x=1708048184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AVOZj1z/zl7PZAVcOviOhSs3GuCFqW+R6JIiic2JKS0=;
  b=iZ9ow+zg/xZF/pXMrw2GKjYWWgMacoig/vwTPo9pXlH1GQOSbtXQAOjn
   QZyx58YAiQq8hN0vn6g76w7Zfs2pRbBDe8qYbTlotrLY35xIVVrnzcxnX
   G40a8e0Rly66/ECL3NZs69PyzH4JYGQDXK1wCORG82aTIF2y8VoSeciLT
   KRko4Fjw9BeEbkQedXhYR58vOwxzU2vEkcZ/fmAmJqeiA83nhx/uGcEuL
   NoP3BaakChgQnbealgrpZaHeWXvom4uVrv2p/a/ITHZuVD3lJZ13mYcRX
   CIHZnU0dWAbQ1djDSot7fhjFtNCff5uReqNxN0AX7ml4iruPpqOHFzaFO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="359025513"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="359025513"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 17:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="702390941"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="702390941"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2023 17:49:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 17:49:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 17:49:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 17:49:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 17:49:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFz67Y9HUxRNsf7JV/vAp6ChwmGhS1ZyCelS49Fl32fTSNqsfp5YPQc9bDMN1uNN/h/Qb2we1FoQaFG3uxvgMWD7eWld6LJNZAaSCgXcteF0IoHb/V9gE0WXF7czZ9NxFqi2JeUNbh4df6QQ7oh/rC6XELbNNrjmzyoO4YbNrq3HNQzS9Qr/9o6tbYcah2LM27Xn6pwvGiyxv81h43yhvbQtHA2ZuvJvHz966nABIN/Lfp7cvLW88O5o1v5L6ICFw0+ky12oEpPIEGQoTtsbPdQis8ghIybWsI2Vz4EhG808kNmv5iDrrFRP9XzlTdDguvSk3/DR/3tqSfyJ2zjtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVOZj1z/zl7PZAVcOviOhSs3GuCFqW+R6JIiic2JKS0=;
 b=AhY/YfTtoRsngNMITNzJHDLN/O8aOFGGZ1Is1VHpQEFPO5uanhgDb2wbujpEdu7GsRyxo5JvEot3UJR+3N/4+stIpKL7b1U1nqpj1vfyQOzDBNiiyzszB+CQ6eDhOlMHIKXIiKw3G2IY61ZioJdMrm5ifcGT4AV9egGHeukQjgNsB1SuKItmSW0LvdYuXJ4aKS+/qzdZb2UuDZULIsPRfQGjb/PQC+jmDraAIdNai/g6wMVIua85Aof3k3EagVG5ckrAZuvmGr9oRMoR8Y1A71qLO8AQnx7Fz9hFBkdmA4jzNVHh6xqvZcyvN9Uq7Dzl10AczQ8Ep57l78ftzfbBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA2PR11MB4809.namprd11.prod.outlook.com (2603:10b6:806:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 01:49:40 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 01:49:39 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH 1/2] x86/kexec: Preserve CR4.MCE during kexec
Thread-Topic: [PATCH 1/2] x86/kexec: Preserve CR4.MCE during kexec
Thread-Index: AQHZQajuqwnKk7a2c0Cd8swcb05FJw==
Date:   Thu, 16 Feb 2023 01:49:39 +0000
Message-ID: <bcaf4b7121e20ba27dd2cc2b347feb35ae7bfa53.camel@intel.com>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
         <20230213234836.3683-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230213234836.3683-2-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA2PR11MB4809:EE_
x-ms-office365-filtering-correlation-id: 110682ae-560d-4990-575c-08db0fc01113
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oQaqp4iUkNWQagZ+BqFZvA7K1rZJqwaD+qh5RrVb1joM/BAOVPp/eRWeqoVnO8FYSu4rssA5AgXyKaiGYTM8mS1TZeI714FgXHiEMulGWiGtibeWlUei1f8unqdFNoxZzRi3DRJXrc48amYn0aQ6QNXW5B6ZO+F12k1++eu8PgLa+wq7ZilVKwoxtxlEMomknhhX2+85ZMKN4FRXkm7ND64duWr9Wq6OoZh9a9z1meFIHTbuzU14NAv7lsnWuVMW592mj+cnP6j4MVSskIW2yaYVmHPP2jRUWpVD/wXDZ0rDn+hG/7Nb6u91PoKaSjPwlKM8R7c5jJF8QAiPwkpGbqFZnc7ycbdGWpM7BI4vtQdFyfn0hYIVW3v7D6B6e0eyR3KQHYgG9ErDkDerZELXeBMrhndjqDMGxkqbL4iofcMCyE2nYEmJoczT2m+AZcz1nDIRaietOZpHGrLitzvQfCaA/DHp6Xk96vWDDAxvasi1ebb9mxBn6AmKXC3jh+qJlLlE6n2bPwx3H9QDOkylpHhTOrZuMgh3KIfG5KfQ7XnP21TFr91qpGvMzzGHnNOrS2pZc+CRgsRKw6CMp37BfNwq/1W68rhV98dNerjeVEWIGGB79Qpu8bEUhgdvPZQOiYSuWp2Cd5+rycJJcQP7CzZ63izsRFVY1vv4tjagFK7VqMr2N3fWlRQO2aPSy4UKSRXsMNqdFYomMOMidpJ6v/kem+2NV1LiiEwluePRRpY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199018)(2906002)(71200400001)(2616005)(5660300002)(41300700001)(6486002)(36756003)(186003)(316002)(478600001)(8936002)(6512007)(6506007)(86362001)(4326008)(4744005)(38070700005)(91956017)(8676002)(66476007)(64756008)(76116006)(66946007)(66556008)(26005)(38100700002)(66446008)(82960400001)(122000001)(110136005)(6636002)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW42SDFYMlBMRTVnYXJjV01PRFNjaGVnSUt3S3EybW4rYXB2aVhOQjY1MTlu?=
 =?utf-8?B?STZ4aGRoVE9tUEdYd00vOUF6bmt0ZlpRUXRZVUlDdGVIR3M0MUV3OXJrTHVZ?=
 =?utf-8?B?dGljZkRQSkJ2Q1h2Z2Q2WGJ6dGRQd3hxNjRwU3FVM3JnVW5qKzd0Z2NBcmgr?=
 =?utf-8?B?R29EeFp6eFVYWEVHaUpCSzc2K2RiMm9jcUNDeGptRnZPRmliQWxtajQ1bWFL?=
 =?utf-8?B?cUFKOTJ1U1dsTXRJMWM1OEFmcmxBOHlXelY1VXZZVmNNNnFVdkJzYmdVeCtn?=
 =?utf-8?B?RWtzWi9MN0sva2pJdUZ2akFRbjFXVXpQR2RiTGQ4bXlWd1ZHSzh1YVROOCt5?=
 =?utf-8?B?enEveTNsQ0hmemtWWjNvQ1NXTkVtN3hlYU9BY3pZejJQWDZ2bTlYeTZTeUtE?=
 =?utf-8?B?N3NJdU04a3o1aDg0dkxhWC9JNUM5bEhVdmNsWGcvM3ZRcmNIcDBXS1k4UzBL?=
 =?utf-8?B?U0tFREVFR0FYTUkzQ2dYTjlOS1I3cGpzRFh4TmpLNDdkdzV4dStjQlA0SVZ2?=
 =?utf-8?B?emJpRDE3aFBiWFdrTm1uZC9KMExVMWMwVm5oVlRjeG1yV0RGV3ZOczhLU1Rk?=
 =?utf-8?B?R25pTTJMU1pQWG84Rzc1bnNHY3lTVWJobEdJdE5YeEhkdzg2RExVSk9wU0Jq?=
 =?utf-8?B?dWU1OE1pWW9MN2RkQjBYRnByRTY2NDhoTGlBZlhkTW9QZGdJSmIrZk9xU2lE?=
 =?utf-8?B?REpnVFZiVmd2dDdPV2V3azVrRGJVYk5RZ0RsMEs1RE9JWjJPVlVPcjhSNVpr?=
 =?utf-8?B?dWZIRzEyNlhmTVJyWCtvaGhVcmUwbDZSU0tDVHJ6MnZORUYzWkFtODBXQ1pu?=
 =?utf-8?B?bW5aaUVBLytWWW1QaDJzdW5jNXlpT3NJeElSYkNXR013T0ptMnNQNi9oRXFl?=
 =?utf-8?B?WjgvSDI2WXpocTB5UWhDOUJrWmYyNFRoQmJNQm1UNnZndFVFYi8wc2c3cDFI?=
 =?utf-8?B?Nm5Rb1J4VkxSTUtaVDhQTkFCdjV4U3lvVTJWSStiNmNZckdOTTczTzNVdkM2?=
 =?utf-8?B?MUFBK0Z0Q0FoYUF1MVlJZ2NkRXNsWWNjOFo1MFc4TnI3dERFeGZOdno5TG16?=
 =?utf-8?B?S0o5bUJHVUFIdWFJSTJmd2ZyMmIyOTJrVDFDQ1IreXNWUzF5Q2VOT2ZvbTRJ?=
 =?utf-8?B?Z2NTUmcvR1dHOHh2b3dac2Z1bk1OL2NzdmhFZWdSbjZZVy9hRTF3b29ZL0Jy?=
 =?utf-8?B?KzhzSCtRamlpVGhmWnJqdFh2Qitjd1lnY3ozR2t4VlNxTHJSbkhWbTRvV256?=
 =?utf-8?B?aDJ3SE1YYm5kV0k1eTh5akdqSDJDRkw2VnVBOWR4MG5vbVF5QU9HazZrR3Jy?=
 =?utf-8?B?KyszVUhDT1BId253NHlGRmVmZUZhQUl6SFkzcmlMMHBEckU2NW5qbi9ORkww?=
 =?utf-8?B?MEJNNE5weXJnUW5pTTkweE12VFRPT0dHcG5pKy9RNkVZTUYvQm9YMWhFOXZX?=
 =?utf-8?B?RkZHN3RoZENnckxzVHBLdXJaeTJKUVpYNGxxVThwdHAvVFVzamtNTGJ6QVZ0?=
 =?utf-8?B?enMyeDNOTnJ3bzFGc014TmYxN1pSNXRKMDhXUFFjaEZRYXJDZklpbjMzQkxK?=
 =?utf-8?B?MnlDZGhHbWZkdXNYV3c0MExaU28wTFlMWWRreFEvdUtmbEthYm5IaVhMM0dI?=
 =?utf-8?B?cE9Wdk4yUlhVVG04NFZWQ1VqTzUycHg5UDBJSXMwOEtlWDdhamhtc3hOUHFj?=
 =?utf-8?B?d2RnTEpBc3AyTDBJR3lhOENxQ0JsS05yT1dUL1RrZElNeENJbHpNQmV0N2Zy?=
 =?utf-8?B?SDUzL29UcHRYNDc4ZGhjdXhqdHpHZnJKRG9FWnpCcDdBVndZSENCV3Z0RDVG?=
 =?utf-8?B?bmdOUkdpdFZhWElwMzNUZUpkVTlva0dYdSs1ZmhGTndWd3lkWEhxaFVJYzNK?=
 =?utf-8?B?Wi95OVVvRXdIOU1iRzVldVluVUF2R2JSZkMvUEFmNjlCbElLRnhLWU9sMU5w?=
 =?utf-8?B?dHM0UWVZMEJyemYrUXN2NitxQU12Rit1MU9DWEZXTklaVzZVNXN4c3g1VTI5?=
 =?utf-8?B?RUg0a3VZU1Y2b0FJL3ZLbmpwd2dIZnBPQTkvZHlpN3RWaUIycndSSGg0Uktq?=
 =?utf-8?B?elV0MUh6ZnBieXZwTHBTUkpwblBQc0p6MW5KQmM0YlJjMUY1RkRONWFrTHdU?=
 =?utf-8?B?Y21NK2hOM2lkWjVqd05YRXV5MzR1U1ZnNE43Tkhvd1ppZmVjOU5ydUdXcVNQ?=
 =?utf-8?Q?/QUudbmxXD787bVwVFcbPfk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E72525EB1DC0EC42B7FF1B9B214A3982@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110682ae-560d-4990-575c-08db0fc01113
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 01:49:39.7049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUUTXo+L16hdEIQqHXze7cl5fsXqMKND7ITpctv5OV0QGSwKb6NYTK7b926PjAFNTPEaGCUI90/rtYAJa3r0OPpWZY6OFn5pyVWXrWTmY9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4809
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

T24gVHVlLCAyMDIzLTAyLTE0IGF0IDAyOjQ4ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFREWCBndWVzdHMgYXJlIG5vdCBhbGxvd2VkIHRvIGNsZWFyIENSNC5NQ0UuIEF0dGVt
cHQgdG8gY2xlYXIgaXQNCj4gbGVhZHMNCj4gdG8gI1ZFLg0KPiANCj4gUHJlc2VydmUgdGhlIGZs
YWcgZHVyaW5nIGtleGVjLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92
IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KDQpJIHdvbmRlciB3aGF0cyBnb2lu
ZyBvbiB3aXRoIHRoZSBwcmUtZXhpc3Rpbmcgc3dpdGNoaW5nIGJldHdlZW4gZWF4IGFuZA0KcmF4
IGluIHRoaXMgY29kZSBmb3IgdGhlIGNyMCBhbmQgY3I0IG1hbmlwdWxhdGlvbnMuIERvIHlvdSBr
bm93IHdoYXQNCnRoZSByZWFzb24gaXM/DQoNCkFsc28sIGZvciBhIHNpbXBsZSBub24tdGR4IGtl
eGVjIHJlZ3Jlc3Npb24gdGVzdDoNClRlc3RlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tPg0K
