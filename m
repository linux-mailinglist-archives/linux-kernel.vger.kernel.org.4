Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891FF73867E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjFUONp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjFUONX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:13:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5FC2102;
        Wed, 21 Jun 2023 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687356756; x=1718892756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0kKbZCqOJ7/wXVcgkK8CPA1v4z1NRp045K5ZUtsg1tM=;
  b=lvOfnxkPx48B521NRipnxockutIFEPhqr3sFsT8u2lQ8WYNbZn3wwNoV
   1NA0sKO4vPx2NLxR+GuT3kRd1Q1m7Vy1ec+mjJYhA9nzjuhXOWFoCTBji
   w/JOYD+jZxkJpi54fCuyYHkb3+9oHFai+yPgexoG7RCbvkV52GgJ5ckJ2
   TFAIwk5Qb6Qyr2BPb3gS+AIaDdLINMEcrkAJCOQeoZeT+pL09Fth6BkC4
   U0RkcG1EyORXARLFaAcwTlXOMGTBB0WHinow1x0/CTIlxJl42g65Iyxfe
   Qd0GLmNoo8SCQCQSnvplrh60B/7ayCPDnj0r3Khd2X6FCerFHjImH+gq5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="362723498"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="362723498"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:12:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="664675228"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664675228"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2023 07:12:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 07:12:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 07:12:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 07:12:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 07:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqDMBmnOru5ya5scC7b20rSP+Kt3FgEhCSqtaAdFhpUDKwKfVpCv6Da/78VuB/MA0kp+rbeoTZ007KR0xisQykkkACVq/mGscWfnPZVp/wMsKDHW8i74w6k4YN/5SU4c82mnnfM93Glms8SeIhiVLrcU2L6OvtJZSDCudCcmsRZAZ6j0t940/EboZPFcjd4XwYasNUTe4/QD+IG2Ne96dxK2e3ebE05U2XQIYmks5h/9ncOzHFINJpaZn9dBj7B/05JrsMHS+jQUIDjOEAh1GqiXDSALqoF9KlfEbAHSoq748KhRs1b0imiNBwmZ0PAevDB1SCyJJ+u1aBh3GQTrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kKbZCqOJ7/wXVcgkK8CPA1v4z1NRp045K5ZUtsg1tM=;
 b=AusIIzfwUu7bY1AmSLJMTGXK72XhGoji0fW/2gyYJTx8x89h0fd8iAdLdgGGMCYJGr++N9ukHvONg2P+sGo5OascgH6qJy/S14BrznBggHRXRtqJaPkdh19dl2AJTiMh6rzzjEg46lGvxARnIHG706WJC58/o5mCU2Q2P5kBvhCryCvS2GkTiclx5NrW5TS5rnIfxNKq4CKqBqZksa+HY1OvKXPg3rKRFbICdXcJO2Z4xIKtuk0Io/vt4jdWEJuNnz4m/l8yjouTbEZPd5LyPnapFYa5xRpEG0MK0H/0CWP2QYPIWW9YCDXVAHDPBW0uDsFA2t5QA44wWrR9VUuXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com (2603:10b6:a03:4ed::18)
 by PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 14:12:17 +0000
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf]) by SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:12:16 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] thermal: int340x: processor_thermal: Add workload
 type hint
Thread-Topic: [PATCH 5/7] thermal: int340x: processor_thermal: Add workload
 type hint
Thread-Index: AQHZo8s6h9BoRumU+02U+eyrAZabVa+VTSYA
Date:   Wed, 21 Jun 2023 14:12:14 +0000
Message-ID: <7a30d512c5994575466c4d67901ba6ab0fd2fd81.camel@intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
         <20230620230150.3068704-6-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230620230150.3068704-6-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0086:EE_|PH0PR11MB5880:EE_
x-ms-office365-filtering-correlation-id: 05891195-d7c6-4aab-36d6-08db72618456
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Ino89bNjMPYud2Xqfe/Luh85Uibs1dRftZ//Z/zzkUOhc1or7bdcetjCHPfv9EuPRH34f3E8dfdZEzwBWC5c/echZs95uSBX3/iCQLrVRtjnMbzJUG1BIgQkCLiYyCCZp1JKNr4yIdinv+ESzCWv7vDsmBdxwlHdDREJLqr4nt23tP/QYgNfr4tiQSP7/85neZDYcdXeKqUnUWKR/Q1QjqYZKXoNXpcREeFAQ4OA9ZnaSbi43x1pA3Zzjv6WrfOXxfKZxRy2mNgbeSLPxS4oG2edWEnqGd2B+ENW8E7EAj877d0guf3UwEyUYnu211YGqEnVBhiIZbNXhUGOkGuAgR20yvs/QJApRtJJLbKSKvbMjCPgchvjVUsE1UaxHsOkqCKaC3vyHrBeKpNHV75ZkPUHAwL/3eIMGW2ypGjHSmUUN9F05FI54KhVTh504x5n4fZ95Xmg1b54tWVhXNX9iBIJN//Q98ipwsoppIfeQkVXeH+8fPM6SAmuQMzslMY5CfMi8PZ0+DUFjKm6a8DcLiCSQAemSC+dEOSPG9dnl1rI0/si6VtuVg1hf9YeAntrA+wUFKlHZCWidimJYoqSUWafpAz96k1uqYhB7Y2xlOfZ8AbRJNjk//HuwzjS3+r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(2616005)(6506007)(26005)(6512007)(2906002)(186003)(66946007)(76116006)(316002)(91956017)(66476007)(66556008)(41300700001)(64756008)(4326008)(478600001)(83380400001)(5660300002)(54906003)(110136005)(82960400001)(8676002)(66446008)(6486002)(38100700002)(122000001)(71200400001)(8936002)(36756003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHFWblJ6WjJxZlUvWlg5RXhiNG1MclJJcEtSVGNqZlNjSmJHcm5YTWRMS1pv?=
 =?utf-8?B?V3BXUDRMUVJmbHFmdDY4RFkybThEUW5sZ3k2dGkyTUlwOXVtakNWR1ZlSENZ?=
 =?utf-8?B?M1ZBeHVGRjVlMmRjWERKcFNiYUhzdEJybnRHWEVZd0tCT3M5bklMdTZCYjRw?=
 =?utf-8?B?SW9nT2JUak9nWldHd3BXeE04cDFGR0RMZUJaVjB1NlgyTEZ3QjVmU2hGOGYr?=
 =?utf-8?B?dHdrTVdJQUpkM1NWSU1YeDhVazJQa0tOUWs2WkloOWZBQVZoQUJabE43MG9P?=
 =?utf-8?B?ZEJMUEtycE5YNnNHTDR0VnZObE5nNmV1TURaZ1FPVjhpTU4rUXlSb3Ura2kz?=
 =?utf-8?B?Q0RaY3BzWWJveE1PWnQ2TWg5aGF6QWFZNlpzU3YzZ0JLRm5nZHAzTFd2QmlM?=
 =?utf-8?B?ZW0xU05tOGlMdlJaY2ZnbVpkZVlLcEFrODVZeEFtRm9Vd0RvUVJhOE5DejFs?=
 =?utf-8?B?MERoSklyNk5MSjBSTFd6aTl2U3BSelNncTVVakJ1NW9ZK0kyTVJuSm1JSVM1?=
 =?utf-8?B?ZXEwdi9qeFNSY0pkL1AwaDhxR2JmakJ1Uy9aYXVhMVdEQUJpOXVrRnpoY2Ry?=
 =?utf-8?B?WXM5WmRNeU03UzU1bUs4WkZudHpYNzVqQW4xa09zdnNrbDRBZHNVcVJhQXpI?=
 =?utf-8?B?bm5GanFQdEtBUnU5VjQrYlNwQXRCRTdIVlpKeVpSZDlFZUhmdzJXbG1oODcr?=
 =?utf-8?B?TVdLSVhGSGVRZG43TlFKakdCOWxUQnk1S3lMSk1EMTNtRHlxS2x3RXA4MUsr?=
 =?utf-8?B?V05pWjNCOWFFVU4xdmdiUW1WdG0vZlE3dmZXeDloUHlUcStwTnB6MURYcFJJ?=
 =?utf-8?B?ZHlDTDlra1FEUUtrUVVGbmRIYVpQUmxYMlR1dzlSNlg1TTFBMldYQTc4NUVh?=
 =?utf-8?B?dXlBdFVQSjlmeUV3NHBYVmFWb2gyOXBFRmZGbWxuSlVUL09sMGtzelYzL0w2?=
 =?utf-8?B?TUNoUGJFQ3I4M2ttY3IyYXQ3V3RWclQwUEtxUWZKNWlsaFZXcG01dXJiZXda?=
 =?utf-8?B?a1gvQ2pzREJXN05QRUFFenNOdzRsanBPTXRsVm1PSjVucndHNFVOSnBha2tS?=
 =?utf-8?B?KzZPelp2dzhMZjhUNUFYK3pOZG9Da0RUdXNWKzBST0J1djAycTdscS9oM0dG?=
 =?utf-8?B?WU5SYU9OZjM2eE9PbEp1NzBzK1BRbXNMemVUa3lURzhERFNGdElHT1FuYURv?=
 =?utf-8?B?VWVjK2lqV3YvR1RFOEFEc3Erck5rNVdsSXFsWkNiMHpOcHo3K3BxRjBuUmwz?=
 =?utf-8?B?bzV2MzgxTXg2cERoODl0Znp3bTkxazlLMDFQZHZmUmVxTlI4UHdOUGhKTE1u?=
 =?utf-8?B?SjJUK1NUZUVrRkZMVkhodU9JUEk2Q1FpMmJ3OUVUNWwzRzFmcDJObm96TmVT?=
 =?utf-8?B?RUFwRjd6b04zOGhYUDl2Q2VhNm1YZFJEL3hQVThFbENINEpYZ2p6RDFhcUE2?=
 =?utf-8?B?K3I4MEkwTUZmdlAzcnRSbUFNU3JzTnM3b2tRSkR4REJwRGQxck85TFJxWGJL?=
 =?utf-8?B?REdUdGVzeVJXTG9XNDVFeTJ1UjlFenVGQjlnc3dCcm1rZS9YSXlhN2FyT2RY?=
 =?utf-8?B?NDFUKzZxQTN0clAzcDdQTUZ1aU5MeGUwNEdrMjV3YlExWUJHZElwOWs4SE96?=
 =?utf-8?B?bmRkRkQ4d3F4S2dONjZjdURYcWExdU1VelFXWGo3U3pwaG15d3hSdkxoSlRB?=
 =?utf-8?B?NE9Db3lORjVLeGdiV0JBVEFSbktha1VtUHpPOEdiSGZ3cjVaU09jWHBpcFRM?=
 =?utf-8?B?QlJzeWhnd2JQNVhHcC9nV1dPeWpNY1I3RUFvaklmQTgrMkhwN0ZJbW1McUNz?=
 =?utf-8?B?bGtHV09VWVRRTVV1d0RaQWw4eENMYTBkTWtyUWZOMlV2TDJEbmxHeG1TbFhK?=
 =?utf-8?B?aHBiMnU2bkRhZ2Y5di9iektBb3ZvRUNxQWRNaVl1MXFVdFU4TDlmZjQxdDlm?=
 =?utf-8?B?djNmL3pYVUpSY0FYZGoxUVdzM1IwL3hkSXZNcDNMd0o1MWRqaTNjcHJwY3h5?=
 =?utf-8?B?K0IwNEc3L3kzQlk0azR1cUhmdXY1Yll6cjhYMTgvWlQ4ZzF3b2YrNzBldjVR?=
 =?utf-8?B?ckpzNE9aOG5iL2xmYjg4bnM5WUVLdU00VE9UZGFsYi9scDBiWFhEdXYrZ2Jx?=
 =?utf-8?B?TDhJNnNLeXVjTE91RWFqRDhZYTZOc2YzWGlsVUFHbUljRXBJZGdzTW1TL3h0?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC7156D5DA045F4C819B27D5CBAFF5B4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05891195-d7c6-4aab-36d6-08db72618456
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 14:12:16.0469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAVkt78QUKkpGAUPm7U8yDTRUfePG+4DZh+aKlI5OYYPB+uOqjlfCS6MySQUHbcgnEgMRqNSOAWgRRDFAVBNnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5880
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTIwIGF0IDE2OjAxIC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOg0KPiANCj4gZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4
X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfd2x0X2hpbnQuYw0KPiBiL2RyaXZlcnMvdGhlcm1h
bC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfd2x0X2hpbnQuYw0KPiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjZiNzJiYTY2NTE2Nw0K
PiAtLS0gL2Rldi9udWxsDQo+ICsrKw0KPiBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4
X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfd2x0X2hpbnQuYw0KPiBAQCAtMCwwICsxLDIzOSBA
QA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiArLyoNCj4g
KyAqIHByb2Nlc3NvciB0aGVybWFsIGRldmljZSBmb3IgcmVhZGluZyBXb3JrbG9hZCB0eXBlIGhp
bnRzDQo+ICsgKiBmcm9tIHRoZSB1c2VyIHNwYWNlLiBUaGUgaGludHMgYXJlIHByb3ZpZGVkIGJ5
IHRoZSBmaXJtd2FyZS4NCj4gKyAqDQo+ICsgKiBPcGVyYXRpb246DQo+ICsgKiBXaGVuIHVzZXIg
c3BhY2UgZW5hYmxlcyB3b3JrbG9hZCB0eXBlIHByZWRpY3Rpb246DQo+ICsgKiAtIFVzZSBtYWls
Ym94IHRvIGNvbmZpZ3VyZToNCj4gKyAqwqDCoMKgwqDCoENvbmZpZ3VyZSBub3RpZmljYXRpb24g
ZGVsYXkNCj4gKyAqwqDCoMKgwqDCoEVuYWJsZSBwcm9jZXNzb3IgdGhlcm1hbCBkZXZpY2UgaW50
ZXJydXB0DQo+ICsgKiAtIFRoZSBwcmVkaWN0ZWQgd29ya2xvYWQgdHlwZSBjYW4gYmUgcmVhZCBm
cm9tIE1NSU86DQo+ICsgKsKgwqDCoMKgwqBPZmZzZXQgMHg1QjE4IHNob3dzIGlmIHRoZXJlIHdh
cyBhbiBpbnRlcnJ1cHQNCj4gKyAqwqDCoMKgwqDCoGFjdGl2ZSBmb3IgY2hhbmdlIGluIHdvcmts
b2FkIHR5cGUgYW5kIGFsc28NCj4gKyAqwqDCoMKgwqDCoHByZWRpY3RlZCB3b3JrbG9hZCB0eXBl
Lg0KPiArICoNCj4gKyAqIFR3byBpbnRlcmZhY2UgZnVuY3Rpb24NCg0Kcy9mdW5jdGlvbi9mdW5j
dGlvbnMNCg0KPiAgYXJlIHByb3ZpZGVkIHRvIGNhbGwgd2hlbiB0aGVyZSBpcyBhDQo+ICsgKiB0
aGVybWFsIGRldmljZSBpbnRlcnJ1cHQ6DQo+ICsgKiAtIHByb2NfdGhlcm1hbF9jaGVja193bHRf
aW50cigpOiBDaGVjayBpZiB0aGUgaXMgaW50ZXJydXB0IGZvcg0KPiArICogY2hhbmdlIGluIHdv
cmtsb2FkIHR5cGUuDQoNCnMvaXMgaW50ZXJydXB0LyBpbnRlcnJ1cHQgaXMgPw0KDQo+ICsgKiAt
IHByb2NfdGhlcm1hbF93bHRfaW50cl9jYWxsYmFjaygpOiBDYWxsYmFjayBmb3IgaW50ZXJydXB0
DQo+ICsgKiB1bmRlciB0aHJlYWQgY29udGV4dCB0byBwcm9jZXNzLiBUaGlzIGludm9sdmVzIHNl
bmRpbmcNCj4gKyAqIG5vdGlmaWNhdGlvbiB0byB1c2VyIHNwYWNlIHRoYXQgdGhlcmUgaXMgYSBj
aGFuZ2UgaW4gd29ya2xvYWQNCj4gKyAqIHR5cGUuDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChj
KSAyMDIwLTIwMjMsIEludGVsIENvcnBvcmF0aW9uLg0KDQpUaGlzIGlzIG5ldyBjb2RlLCBzaG91
bGQgdGhlIGNvcHlyaWdodCBzdGFydHMgZnJvbSAyMDIwPw0KDQp0aGFua3MsDQpydWkNCg==
