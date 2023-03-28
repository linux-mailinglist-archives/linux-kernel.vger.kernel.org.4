Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B56CB2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 02:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjC1AND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 20:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjC1ANB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 20:13:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A751FC3;
        Mon, 27 Mar 2023 17:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679962381; x=1711498381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MS3iOnHQK8MHvAr+RvIw6b6omxPOumPLHSJPBOAuarw=;
  b=VCDt7k1VcUglUol0I6+rcR7IUbzSMMR7l65WCT5ysvHLLub2ubdNWf+F
   fc6/RJAoYuMxsP9ZUT5sX6wttyKYu9NxIVQEisH1vjHacWXmrUyLduWxq
   T6nGPibo7nq09eVDOdJWE39onT8aYJUMVgwMzd1dwAejs7gmwVOKW2TRm
   FgoMnBXJRLoNo4k1v+z93gqVOj6ol+0tbhXHSp88k7mf6n8NAAecqm5Ob
   ucsbW7QvE0gEa6nk1p5Uuk8j0XMbMdb6W6yz+OJROxeCaH9tQ2GXjdJgF
   nAVQpsj6TAyQdyNd0bp22+zr0sxd4d0luYfstOtnf328GWVQhqqYg8A0u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342005305"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="342005305"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 17:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="633807561"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="633807561"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2023 17:12:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 17:12:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 17:12:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 17:12:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 17:12:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7cbjQJhaNYkPLgX1tOA4D+i5qleNYvCUcE9nOq1Ls4Th/J8vaf3YjEMQEMIG9o7ZtpunYyffU8ndOBFt7hrZRnKYRwI7HBVE622ix3OEzsl6lmCNCVN+Y+29/XHbPk+MSxjynI/W8UbD6WWCaon+l7zFYXPAhMwHyDjKnLYixUvQr4Z0L1qH6LoeQFB4rZji0gdTqmDqa9PYsDiW7hZskG70j802XbjH6xMIxo0FYsKSDKzPSzuCHBiJpqoQxwtDwmnJH7taRFIoSeSMS/A9jZoSkDx4AZIbM/Oc81/I3Ry8l4l5HhWGiQr6zPPZbncaY6a9BhW58pcIGDtA5RiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS3iOnHQK8MHvAr+RvIw6b6omxPOumPLHSJPBOAuarw=;
 b=Bc620qyei+TwSnSlCfy11t93Ouj3tJY/gqfl/fAUIqDw35vNJtiDsBukGXGKYXB8rP0JwDz2vOKvy16rg3nyBbJAwzgEH0tQjku+G/mjbDM3yrip91/qKd5nWZT9W15cHyNgdrVlKG6q18c3BhOlvtIXxgAe77wVEFzvKvkf42lKBAKV+aOodZAdKfrJV+aVngaPizrbdNpRVjcwuuAxYGuRs07Ui6UgtyKdVLOzoQ/EUOL/U6P9TNYx7HLGtW7kCSb1asnZ5vcG5OLU9eeSDmRB3xuPq2NUe3o2BDbeBeDS8TqjktrVryg35EHsOsQ/PO95cBcgl7ZtRECwbJBnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DS7PR11MB7737.namprd11.prod.outlook.com (2603:10b6:8:e0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Tue, 28 Mar 2023 00:12:36 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 00:12:36 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Oleksiy Avramchenko" <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: RE: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Topic: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Index: AQHZW9/cQoPnlerMcUKFbHJCjrW4W68FRAeAgAAUR4CACSeJoIAArRWAgAArYsA=
Date:   Tue, 28 Mar 2023 00:12:36 +0000
Message-ID: <PH0PR11MB5880923368F103D66A44B0CFDA889@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230321102748.127923-1-urezki@gmail.com>
 <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
 <ZBnKKZsSpI8aAk9W@pc636>
 <PH0PR11MB58805561777B77DC69E87711DA8B9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CAEXW_YTRG1y3eCUDtWx_kCzHM0B24bi_qEpoBdjBunW58=b+xA@mail.gmail.com>
In-Reply-To: <CAEXW_YTRG1y3eCUDtWx_kCzHM0B24bi_qEpoBdjBunW58=b+xA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DS7PR11MB7737:EE_
x-ms-office365-filtering-correlation-id: fda542dc-ab42-45da-eecd-08db2f2122a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2WJSXsbrUZ8JesQVqnaQP/QvxGKdjV+FzFW0Sy2OjjVYS5SPFMfAIc4xTRKQ42DPEd3rNEquVLWra7iwXQy1Aim1oJVBUdf0rjNAozduj/gQHZA4RvgUtzRlefZAsJYfOya/9daq7QKQRYsj1Zz9DjDf2cFWDVYYO1ExSGJT5aX6zzrcxQtuH0qm+68gPYo+u12KrrsCaXQXIUt9iS9xIi0Lv6AZjcafM0/Zu3CI9Qii+QCwAThfVFAJBKgq9WvtrJU1ty1I2o+q9AIWzig22b2AkGTRMJb1mRcxrDLBqLNBaakLwFan/IWc221GaFbwX7fLs6ZChItG/ysttUxoj6XXh64ymbGasPJN1+JOuUCbyUsUbXK/AHR/uoU5ss53i3+lyyctWTDTdmmdOmPrXcmJBclFIxb/zqzLugapXn6PJwFOm3zyxjKpxp8Bh8b1Ct2afwyFcF2sn8m/XpHJ+nmrXZfQ0e/WzjFAA+qay/MucdF+NcI31cuqTYAi02INUW8+ahBfK7catyRpqvkVecapEFrLjMhCFEMrCCtdIV9X5SBnXcLmIBrI4CH+lzYZsUy27cyDv57hAvJHGjQSGg2CM8O+7995+DR15nq6n9s2oKTusbxS74m71sA28xZT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(55016003)(478600001)(316002)(7696005)(71200400001)(54906003)(2906002)(9686003)(6506007)(26005)(33656002)(186003)(38100700002)(83380400001)(38070700005)(86362001)(41300700001)(76116006)(6916009)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(82960400001)(122000001)(8936002)(52536014)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTU4cC85QVJ4MjZGVzJDOEpnbE1rS0N5R3VLaERJODNYWVJBMFNBODB1M0tz?=
 =?utf-8?B?VWlKMjFPM3doNXZXWlBEM3BQWmM4UFFMYU9FcEcwR2xHcnAxTnFmcnNhWTBv?=
 =?utf-8?B?dTBlU1JyeVYySWdEMHJSSVc5cnVLWUxlb28zeHZna0VhaXc3dUx2N2g2bjE0?=
 =?utf-8?B?N1lFUjZkMXpxR3FhM0J0VnYxaElQV2QxeFZjVS80dGxJNGV1NFZoR2RlSVgz?=
 =?utf-8?B?Q2lhem1aSVJhenFOY3cyRmJPSWNhSmJ5c1NmRHRlcFlLUk52V3dpQXZ1UlJo?=
 =?utf-8?B?eE1RdTJRcklLMG1GdFdLOFRhY1pPWkRTL3V3QTI1dlZuNVZvRVgraHlMdDR4?=
 =?utf-8?B?WUlUdU0vYWN4Wk5NaXlBZFZhODRLdWt2K0d5YTJnVjNwcFNFbzFTMEc5cWM3?=
 =?utf-8?B?ekJVeWowb3lVaVc5cTFpS2dSMlhMdW4rTUFTcTQ5amxpb1JRaU5YZnBEc0NE?=
 =?utf-8?B?amxiKzdYVXBlcmE0ai8zb1lYRi9tdlppS3kzUUdjNXd2VDVEV2dwRzMzNENa?=
 =?utf-8?B?bFB3ZG5XZmNodWs5Z3o4aXdqblBUTVFjNEhnL0luTUkyQlJkNk0rY2hDQlJE?=
 =?utf-8?B?bHRqcEdoSkkrTTUxNHNXSHFnd21UV0pNZldkMENkY2p0YXZoUUJqcUxENWds?=
 =?utf-8?B?N3lOYitucFZsYmlSOGRYVE9OWjhNSlo5V29BSnUrSGhzcW1EM1k3QndOc29K?=
 =?utf-8?B?TWl5R2xhLzVIQ29EZ2ZPYmg2bVU5YjRCaGZhVEEvWk9ub0RLR0VRRG9vSDFw?=
 =?utf-8?B?MmZpbmtTN1lJQXM0aVduMVNUSjZLd2dTc2t2TE5VNWVYQ252ZGNyNElNNVVF?=
 =?utf-8?B?TzFzZFhqRldoVWduekZJY1lrM29yT0tlNDl2R1NiS0hkdlF3NXFaRUkvMnh3?=
 =?utf-8?B?Qk1GSnZQUmMwUUZtWDFXLzYwdWMzdnk2L0tiaTNGdDYxY2l3dSs3Vit4dW9v?=
 =?utf-8?B?T1pYM1A0bWtsekJoYzFXVmwxUlRZRFM3MTRwTzVFNndRSHdUOENiekhpZW9j?=
 =?utf-8?B?eU1qZXI4c0VmQjZKN042aVlNVWVBYkVvdWpXVEZHaUppZWFpbHlPVE9hVFdr?=
 =?utf-8?B?S3ZBczd6SG5aK1FOemNmaTFGTTg0Z1pvZ0hHWUxKNnJCTnZBdEtidXhSa1dR?=
 =?utf-8?B?VGdwTHJDYlZVK2Y3YzN3dURVVCs0TE1QZFlDWkZOVXVzMGZpaGkvN1U1ZWow?=
 =?utf-8?B?ZGZsUlVNcXdLeG9WRWVlV09qbVdmOU42SDBVMExEeGN4L0RSSkwvZk1DNXBr?=
 =?utf-8?B?OEZFeis2SG5JMlNRSGswWFNSVWlYQUlIT0M0UzlWNWN3dXRWbndNdjRQbWE3?=
 =?utf-8?B?b3NUVE8rbFdUMno1RnNQUnRFam9ScnRNdEEzeGx3cWRMWkdRUklsTnFJak1v?=
 =?utf-8?B?RVNiN3E2dkNlbWJFUHFLZVV4anJKMUgrRTRWamtaQnR0WUR0QmRhTUlVRTh1?=
 =?utf-8?B?VXlTUzJOOGpPZXB4UXUrcTMrWmhpZDRjK2NvZ2hUWmFqK3FzRWJOZkFRSndS?=
 =?utf-8?B?cGZnOU5uM3BnYkMxUmhOOW81ejRrcm9IdHZGeGluOXdzbGNla0ZmdEFWeHRi?=
 =?utf-8?B?L2w4WXNsTE5SMjBLOGFieXJ2clIrZWI1Q2JJZkpnOVpuenNramovcXMvVEVa?=
 =?utf-8?B?eEtDcHplNlZkcGdDdVM0c3k1M2c4SlVjQ3FYYkREa2N3aU5nRDQ3dE94eWhF?=
 =?utf-8?B?SFkvMEpIYXd3RjBwbzZlOUtxOVlRMVM4MThBcURuUUYraDU0UjBPQk9vVXYy?=
 =?utf-8?B?MzFKR2VGZ1JucWd5SlhBZ2JacXdNeVd2UjJSRlpZVUZvSytha045d3BlR21w?=
 =?utf-8?B?RGxTaFBVZ2pzS3BQaVI4Mzc3RGdPb21NaWNqYytORHU0cDhaUXRiNnF0RWZG?=
 =?utf-8?B?cGJ4K2VJWTNTOFdEZ0RteSs4bTB6OWN4MDB0SEtGb1cxdTFQY2lwZWdFS1R0?=
 =?utf-8?B?ZUtyVlc0d0RCOXpIQmsxZFhTYXFnaGtaYldRaUVCaXBpb08vVW9zeDl0NlZR?=
 =?utf-8?B?Snd4YmpPQkpFY0ZYSmRPSVJEbXphdDB2Q0tEbkszbnFHc3BQNEFtVlZoRDZD?=
 =?utf-8?B?eTlZZVB4RDluMXJDa1JQS2prNWpZSEhnT29Vbmc4TytRb2thVFBwd1d3azAx?=
 =?utf-8?Q?ga0pzK1qkoHHcJymxiOE/zMJ2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda542dc-ab42-45da-eecd-08db2f2122a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 00:12:36.3896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2C+umbZlGGAtv7Li5ldgOy8GD55zUrIIRWu4ES0LksFVcR4TzcpQrv3Ee1SaduyNzMFT+HJHxObtVHjxFVEukA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7737
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPiA+ID4gRnJvbTogVWxhZHppc2xhdSBSZXpraSAoU29ueSkgPHVyZXpraUBnbWFpbC5jb20+
DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAyMSwgMjAyMyA2OjI4IFBNDQo+ID4gPiBbLi4u
XQ0KPiA+ID4gU3ViamVjdDogW1BBVENIIDEvMV0gUmVkdWNlIHN5bmNocm9uaXplX3JjdSgpIHdh
aXRpbmcgdGltZQ0KPiA+ID4NCj4gPiA+IEEgY2FsbCB0byBhIHN5bmNocm9uaXplX3JjdSgpIGNh
biBiZSBleHBlbnNpdmUgZnJvbSB0aW1lIHBvaW50IG9mIHZpZXcuDQo+ID4gPiBEaWZmZXJlbnQg
d29ya2xvYWRzIGNhbiBiZSBhZmZlY3RlZCBieSB0aGlzIGVzcGVjaWFsbHkgdGhlIG9uZXMgd2hp
Y2ggdXNlIHRoaXMNCj4gPiA+IEFQSSBpbiBpdHMgdGltZSBjcml0aWNhbCBzZWN0aW9ucy4NCj4g
PiA+DQo+ID4NCj4gPiBUaGlzIGlzIGludGVyZXN0aW5nIGFuZCBtZWFuaW5nZnVsIHJlc2VhcmNo
LiA7LSkNCj4gPg0KPiA+ID4gRm9yIGV4YW1wbGUgaW4gY2FzZSBvZiBOT0NCIHNjZW5hcmlvIHRo
ZSB3YWtlbWVfYWZ0ZXJfcmN1KCkgY2FsbGJhY2sNCj4gPiA+IGludm9jYXRpb24gZGVwZW5kcyBv
biB3aGVyZSBpbiBhIG5vY2ItbGlzdCBpdCBpcyBsb2NhdGVkLiBCZWxvdyBpcyBhbiBleGFtcGxl
DQo+ID4gPiB3aGVuIGl0IHdhcyB0aGUgbGFzdCBvdXQgb2YgfjM2MDAgY2FsbGJhY2tzOg0KPiA+
DQo+DQo+DQo+DQo+IENhbiBpdCBiZSBpbXBsZW1lbnRlZCBzZXBhcmF0ZWx5IGFzIGZvbGxvd3M/
ICBpdCBzZWVtcyB0aGF0IHRoZSBjb2RlIGlzIHNpbXBsZXINCj4gKG9ubHkgcGVyc29uYWwgb3Bp
bmlvbikNCj4NCj4gQnV0IEkgZGlkbid0IHRlc3Qgd2hldGhlciB0aGlzIHJlZHVjZSBzeW5jaHJv
bml6ZV9yY3UoKSB3YWl0aW5nIHRpbWUNCj4NCj5Jc24ndCBpdCBicm9rZW4gYmVjYXVzZSB5b3Ug
YXJlIHRyeWluZyB0byBpbXBsZW1lbnQgc3luY2hyb25pemVfcmN1KCkNCj5vbiB0b3Agb2YgYSBk
aWZmZXJlbnQgUkNVIGltcGxlbWVudGF0aW9uOiB0YXNrcy1SQ1U/IE9yIGRpZCBJIG1pc3MNCj5z
b21ldGhpbmc/DQo+DQo+DQo+QWxzbywgSSB0aGluayBWbGFkIGlzIHRyeWluZyB0byBpbXByb3Zl
IHRoZSBleGlzdGluZyBzeW5jaHJvbml6ZV9yY3UoKQ0KPmJ5IHNob3J0Y3V0dGluZyB0aGUgd2Fr
ZSB1cCBvZiB0aGUgc2xlZXBlciAoaW5zdGVhZCBvZiBnb2luZyB0aHJvdWdoDQo+YW4gYXN5bmMg
Y2FsbGJhY2sgd2hpY2ggaW4gdHVybiBkaWQgYSB3YWtldXApLiBTbyBoZSdzIG5vdCBjaGFuZ2lu
Zw0KPnRoZSBSQ1UgaW1wbGVtZW50YXRpb24sIGhlIGlzIGp1c3QgbWFraW5nIGl0IGZhc3Rlci4N
Cg0KQWdyZWUsICB0aGlzIGlzIGltcHJvdmUgdGhlIGV4aXN0aW5nIHN5bmNocm9uaXplX3JjdSgp
LCAgbWFrZSBzeW5jaHJvbml6ZV9yY3UoKQ0Kb3V0IG9mIG5vY2IgY29udHJvbCBhbmQgdGhlIHdh
a2UtdXAgb2Ygc3luY2hyb25pemVfcmN1KCkgaXMgcmVhbGl6ZWQgc2VwYXJhdGVseS4NCg0KVGhh
bmtzDQpacWlhbmcNCg0KPg0KPnRoYW5rcywNCj4NCj4gLSBKb2VsDQo+DQo+DQo+ICtzdGF0aWMg
dm9pZCByY3VfcG9sbF93YWl0X2dwKHN0cnVjdCByY3VfdGFza3MgKnJ0cCkNCj4gK3sNCj4gKyAg
ICAgICB1bnNpZ25lZCBsb25nIGdwX3NuYXA7DQo+ICsNCj4gKyAgICAgICBncF9zbmFwID0gc3Rh
cnRfcG9sbF9zeW5jaHJvbml6ZV9yY3UoKTsNCj4gKyAgICAgICB3aGlsZSAoIXBvbGxfc3RhdGVf
c3luY2hyb25pemVfcmN1KGdwX3NuYXApKQ0KPiArICAgICAgICAgICAgICAgc2NoZWR1bGVfdGlt
ZW91dF9pZGxlKDEpOw0KPiArfQ0KPiArDQo+ICt2b2lkIGNhbGxfcmN1X3BvbGwoc3RydWN0IHJj
dV9oZWFkICpyaHAsIHJjdV9jYWxsYmFja190IGZ1bmMpOw0KPiArREVGSU5FX1JDVV9UQVNLUyhy
Y3VfcG9sbCwgcmN1X3BvbGxfd2FpdF9ncCwgY2FsbF9yY3VfcG9sbCwNCj4gKyAgICAgICAgICAg
ICAgICAgIlJDVSBQb2xsIik7DQo+ICt2b2lkIGNhbGxfcmN1X3BvbGwoc3RydWN0IHJjdV9oZWFk
ICpyaHAsIHJjdV9jYWxsYmFja190IGZ1bmMpDQo+ICt7DQo+ICsgICAgICAgY2FsbF9yY3VfdGFz
a3NfZ2VuZXJpYyhyaHAsIGZ1bmMsICZyY3VfcG9sbCk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9M
X0dQTChjYWxsX3JjdV9wb2xsKTsNCj4gKw0KPiArdm9pZCBzeW5jaHJvbml6ZV9yY3VfcG9sbCh2
b2lkKQ0KPiArew0KPiArICAgICAgIHN5bmNocm9uaXplX3JjdV90YXNrc19nZW5lcmljKCZyY3Vf
cG9sbCk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChzeW5jaHJvbml6ZV9yY3VfcG9sbCk7
DQo+ICsNCj4gK3N0YXRpYyBpbnQgX19pbml0IHJjdV9zcGF3bl9wb2xsX2t0aHJlYWQodm9pZCkN
Cj4gK3sNCj4gKyAgICAgICBjYmxpc3RfaW5pdF9nZW5lcmljKCZyY3VfcG9sbCk7DQo+ICsgICAg
ICAgcmN1X3BvbGwuZ3Bfc2xlZXAgPSBIWiAvIDEwOw0KPiArICAgICAgIHJjdV9zcGF3bl90YXNr
c19rdGhyZWFkX2dlbmVyaWMoJnJjdV9wb2xsKTsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gK30N
Cj4NCj4gVGhhbmtzDQo+IFpxaWFuZw0KPg0KPg0KPiA+ID4NCj4gPiA+IDxzbmlwPg0KPiA+ID4g
ICA8Li4uPi0yOSAgICAgIFswMDFdIGQuLjEuIDIxOTUwLjE0NTMxMzogcmN1X2JhdGNoX3N0YXJ0
OiByY3VfcHJlZW1wdA0KPiA+ID4gQ0JzPTM2MTMgYmw9MjgNCj4gPiA+IC4uLg0KPiA+ID4gICA8
Li4uPi0yOSAgICAgIFswMDFdIC4uLi4uIDIxOTUwLjE1MjU3ODogcmN1X2ludm9rZV9jYWxsYmFj
azogcmN1X3ByZWVtcHQNCj4gPiA+IHJocD0wMDAwMDAwMGIyZDZkZWU4IGZ1bmM9X19mcmVlX3Zt
X2FyZWFfc3RydWN0LmNmaV9qdA0KPiA+ID4gICA8Li4uPi0yOSAgICAgIFswMDFdIC4uLi4uIDIx
OTUwLjE1MjU3OTogcmN1X2ludm9rZV9jYWxsYmFjazogcmN1X3ByZWVtcHQNCj4gPiA+IHJocD0w
MDAwMDAwMGE0NDZmNjA3IGZ1bmM9X19mcmVlX3ZtX2FyZWFfc3RydWN0LmNmaV9qdA0KPiA+ID4g
ICA8Li4uPi0yOSAgICAgIFswMDFdIC4uLi4uIDIxOTUwLjE1MjU4MDogcmN1X2ludm9rZV9jYWxs
YmFjazogcmN1X3ByZWVtcHQNCj4gPiA+IHJocD0wMDAwMDAwMGE1Y2FiMDNiIGZ1bmM9X19mcmVl
X3ZtX2FyZWFfc3RydWN0LmNmaV9qdA0KPiA+ID4gICA8Li4uPi0yOSAgICAgIFswMDFdIC4uLi4u
IDIxOTUwLjE1MjU4MTogcmN1X2ludm9rZV9jYWxsYmFjazogcmN1X3ByZWVtcHQNCj4gPiA+IHJo
cD0wMDAwMDAwMDEzYjdlNWVlIGZ1bmM9X19mcmVlX3ZtX2FyZWFfc3RydWN0LmNmaV9qdA0KPiA+
ID4gICA8Li4uPi0yOSAgICAgIFswMDFdIC4uLi4uIDIxOTUwLjE1MjU4MjogcmN1X2ludm9rZV9j
YWxsYmFjazogcmN1X3ByZWVtcHQNCj4gPiA+IHJocD0wMDAwMDAwMDBhOGNhNmY5IGZ1bmM9X19m
cmVlX3ZtX2FyZWFfc3RydWN0LmNmaV9qdA0KPiA+ID4gICA8Li4uPi0yOSAgICAgIFswMDFdIC4u
Li4uIDIxOTUwLjE1MjU4MzogcmN1X2ludm9rZV9jYWxsYmFjazogcmN1X3ByZWVtcHQNCj4gPiA+
IHJocD0wMDAwMDAwMDhmMTYyY2E4IGZ1bmM9d2FrZW1lX2FmdGVyX3JjdS5jZmlfanQNCj4gPiA+
ICAgPC4uLj4tMjkgICAgICBbMDAxXSBkLi4xLiAyMTk1MC4xNTI2MjU6IHJjdV9iYXRjaF9lbmQ6
IHJjdV9wcmVlbXB0IENCcy0NCj4gPiA+IGludm9rZWQ9MzYxMiBpZGxlPS4uLi4NCj4gPiA+IDxz
bmlwPg0KPiA+ID4NCj4gPg0KPiA+IERpZCB0aGUgcmVzdWx0cyBhYm92ZSB0ZWxsIHVzIHRoYXQg
Q0JzLWludm9rZWQ9MzYxMiBkdXJpbmcgdGhlIHRpbWUgMjE5NTAuMTQ1MzEzIH4gMjE5NTAuMTUy
NjI1Pw0KPiA+DQo+ID5ZZXMuDQo+ID4NCj4gPg0KPiA+IElmIHBvc3NpYmxlLCBtYXkgSSBrbm93
IHRoZSBzdGVwcywgY29tbWFuZHMsIGFuZCByZWxhdGVkIHBhcmFtZXRlcnMgdG8gcHJvZHVjZSB0
aGUgcmVzdWx0cyBhYm92ZT8NCj4gPiBUaGFuayB5b3UhDQo+ID4NCj4gPkJ1aWxkIHRoZSBrZXJu
ZWwgd2l0aCBDT05GSUdfUkNVX1RSQUNFIGNvbmZpZ3VyYXRpb24uIFVwZGF0ZSB5b3VyICJzZXRf
ZXZlbnQiDQo+ID5maWxlIHdpdGggYXBwcm9wcmlhdGUgdHJhY2VzOg0KPiA+DQo+ID48c25pcD4N
Cj4gPlhRLURRNTQ6L3N5cy9rZXJuZWwvdHJhY2luZyAjIGVjaG8gcmN1OnJjdV9iYXRjaF9zdGFy
dCByY3U6cmN1X2JhdGNoX2VuZCByY3U6cmN1X2ludm9rZV9jYWxsYmFjayA+IHNldF9ldmVudA0K
PiA+DQo+ID5YUS1EUTU0Oi9zeXMva2VybmVsL3RyYWNpbmcgIyBjYXQgc2V0X2V2ZW50DQo+ID5y
Y3U6cmN1X2JhdGNoX3N0YXJ0DQo+ID5yY3U6cmN1X2ludm9rZV9jYWxsYmFjaw0KPiA+cmN1OnJj
dV9iYXRjaF9lbmQNCj4gPlhRLURRNTQ6L3N5cy9rZXJuZWwvdHJhY2luZyAjDQo+ID48c25pcD4N
Cj4gPg0KPiA+Q29sbGVjdCB0cmFjZXMgYXMgbXVjaCBhcyB5b3Ugd2FudDogWFEtRFE1NDovc3lz
L2tlcm5lbC90cmFjaW5nICMgZWNobyAxID4gdHJhY2luZ19vbjsgc2xlZXAgMTA7IGVjaG8gMCA+
IHRyYWNpbmdfb24NCj4gPk5leHQgcHJvYmxlbSBpcyBob3cgdG8gcGFyc2UgaXQuIE9mIGNvdXJz
ZSB5b3Ugd2lsbCBub3QgYmUgYWJsZSB0byBwYXJzZQ0KPiA+bWVnYWJ5dGVzIG9mIHRyYWNlcy4g
Rm9yIHRoYXQgcHVycG9zZSBpIHVzZSBhIHNwZWNpYWwgQyB0cmFjZSBwYXJzZXIuDQo+ID5JZiB5
b3UgbmVlZCBhbiBleGFtcGxlIHBsZWFzZSBsZXQgbWUga25vdyBpIGNhbiBzaG93IGhlcmUuDQo+
ID4NCj4gPi0tDQo+ID5VbGFkemlzbGF1IFJlemtpDQo=
