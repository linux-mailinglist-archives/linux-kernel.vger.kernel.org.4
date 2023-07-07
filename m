Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAAA74ABE4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjGGH1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGGH1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:27:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9D0E72;
        Fri,  7 Jul 2023 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688714831; x=1720250831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AIowfVb19LFlF7CzCCJNlpGunnkTtiwMN0qIbsIefXM=;
  b=B5KjmQmfSfRbFhSKeWopnIazhch2yBJu2GJk2DEWcErlGsY6iM/KHPuj
   AKA6SH7K1Qfz8LvVl+L62mF9MIcLgZSRuDtdFh7JmPY6fKXNBnv0A3PKS
   KfuxS4mZ4x/izXF593JYLvn1056/cXoLumZfTnzQSXAOVpuyezO0dz5p1
   k1bbaVZKUAcSDYQVbzV3U2CexdBd4wyifhn4HB36+cv/NgsuQZAYd4TjP
   uDxHTzMoS4kRGluZdbhRftJkDRrR/LeIZWD1yX4h3Ye6XRg4llTgI53xN
   yY1/8jUidZifmR3hzhHq+sovIt93Ohazbp5nWK8bFmAETyuQJamasqNyv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="427509655"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="427509655"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 00:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="713903893"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="713903893"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2023 00:27:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 00:27:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 00:27:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 00:27:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 00:27:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdHU0kg2jBrtGW1lFfh3RbBw7faakJVaBf54tIkTpuUNu/OXuOeYBr5X4C4yQJCsx44eTbb9wxPrQ6BDnUoGLwsa6il7Ier3WVV2Jqn+RYlq2IX+8ZEOj82Mj5mUpyNXplPKuPMQl0Bi95JlyEpxjp6gHqhdcaxc7aRWEX3WVrmh5e5hYiXzLolcWpqslGXKl/8acb06SxmNt06cM4DZTB1IzYsdTf4rX1ZSrNdCVppYAYQl10yWw/lzIpX9iFx5vHrB2zpaMqnGeDWNC+LzbesL5+8dxskpufEzAjXdw7ZkiDH9zxBUjZvXQpuk3/bMLIQj9Q94tU8ZbhvpetqQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIowfVb19LFlF7CzCCJNlpGunnkTtiwMN0qIbsIefXM=;
 b=d7q/CiFV0zICBr6NgmDPatRnwQlSXs+pLfQw6aevdWBawoIGLFCMIffH+OhvjpnkmUlctcrP0lPZwb6OPSYNMv9BhNepP0KZR80Dd5OeuHquIPdDBANHwKbiyp/97IWd7rs0ALes/bnwmr251ChuI6X9d4Fo+iwWKajv83shm9K2tpVPqqzNZWXuI9RufY3C9ruaPgp5ElAczPE3naXKmOl7G5F/2UgJxBuNcTcjT3ReN19yyM0y2sMqyCjyb+eVsI0xYCynK67zlP7Km015OdDjyT4NvYuJXwdZbop1+OAVcZQW9ZUJISEzIlqxXisQ4ruKhAzigqkJ04wRyH6m0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH0PR11MB7564.namprd11.prod.outlook.com (2603:10b6:510:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 07:27:07 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 07:27:07 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] refscale: Fix use of uninitalized wait_queue_head_t
Thread-Topic: [PATCH] refscale: Fix use of uninitalized wait_queue_head_t
Thread-Index: AQHZsGZTWMMAhp7N10uMLBpQCh8AV6+t40Cg
Date:   Fri, 7 Jul 2023 07:27:07 +0000
Message-ID: <CY8PR11MB713490FA7B31E495E8B5FB65892DA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20230707000117.2371697-1-longman@redhat.com>
In-Reply-To: <20230707000117.2371697-1-longman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH0PR11MB7564:EE_
x-ms-office365-filtering-correlation-id: 1882181e-5b75-4f12-67d1-08db7ebb91c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yIgFk5gJArXOsQmyxAUP/UWAYq1UMz9YPzIyjtcw9tFwYY09/3dcP7jWtQ/d3dY1t9Bjl6Q9vJEHrUOBUXteRvaEIcDxUK7UPHSbGa4NQT5Hf/AkeDT3KX50ds+/tPI8e8VI0oa8Gob1Pe8ZSLHtKN3P3bfrHY5vq96G2Twz/MihmuAAW2J6dFmbryzL2h5C7gl03jeITZtDhOnHOGeaJsPqRqbfS7B1sOb6pVXZwXvTDs7m9MK7dIkPRZPftGBPalwff4rxNQEl52ljyzvnTdHViaCcK0arm2mECDkQPhjn9/9LwHjRFCLrPKn+I5+4lISuJV5V7xP0cpI189kMo6sy7SU3xRm0TDOglzsZuh1bGvmQAjE0YEt0f7sun1LlC5pQMAgBfwxZ+bKfr24AlJHFO99qh6Yk4OlP3WIwKEff1UL5SHn7eucCCcGRLPHWjRY/+k7D36zcGyOoIMZ2Y9joR3CX/dwck5gUOmZNODgK1NW9TIYUAgbpkPHro3gBYB7Q+e/DQT070htxz7mjvrFO0AQ5x4RhPEYkoK/eSdQkelamKZKXstnS1jGryWe/fJQKx5mLHtG//eRfB+N37uRRrCzwihMb7WOk+7G8EbD37KphA0WqO60144KWNhxvh0PML4qtPaa3yI2VaYNpaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(66476007)(2906002)(52536014)(7416002)(5660300002)(86362001)(55016003)(8676002)(8936002)(6506007)(186003)(26005)(7696005)(478600001)(9686003)(110136005)(71200400001)(33656002)(38070700005)(38100700002)(122000001)(921005)(54906003)(66446008)(66556008)(4326008)(83380400001)(66946007)(64756008)(76116006)(82960400001)(316002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnZsZmJvR3gvZENjMzlUcXloa25wT3FMQW8vTHZHZWhnZHI2TVVWbG1nNkQ2?=
 =?utf-8?B?a2kvTVd2dUpldXpCWkZLOWN4UFRtMzgxMnFObnZhTXh1NStaUEdoMlUyMm9S?=
 =?utf-8?B?OUNsNG4vbzVMeW1LSTF2WmloZ3B6UU1GNktkWlBsQ3pvMEJ5dkN4L3B6Vy90?=
 =?utf-8?B?eHlrZGZoYWliZnF2YmRlaUZuc3NJZkRqVGY0c0lETGxYOXlIL0JVWWxuM04r?=
 =?utf-8?B?TjE4N2tERTRvcmpMQWtSb1QvS2dqbWp0NEs2Q1ZTbDRoeFg4V2RBY21NWisw?=
 =?utf-8?B?T1VoUGI0OGxLSnBjQ2dBenJBMDduam5hdG5PNVl6QkxzMU5XZ1dZSkhjZ3pk?=
 =?utf-8?B?WEdjSWJTcHdSS04wRjVWZzFqNXE4UkdraktqdktCd0R1aXN6enpuWElhWHVw?=
 =?utf-8?B?bVdWdThsVU5pZ1cxK0R5UmVDVEdOakM4b3E4VkhlcW15WG9FUzE2VklTYW8z?=
 =?utf-8?B?OWd2R3JoVmwvWW40RXltcWQ1TmM1UUV1cis0MXZCUysvM2JIeFFYelkzelYv?=
 =?utf-8?B?Rkl0MUpJbTBCMnM4aFdiMStpT1lWU0s3REFCc1ZNZEhiL2hQK3h0SXBkb29Y?=
 =?utf-8?B?dTZvVlJxS1gzQThSbjBxT2NOMFVKV1l2UTQ0YlhFaFU3ODBQSUZzWVFwODBp?=
 =?utf-8?B?bkpnYUh1Uzk1VFRzZTRSWVBIbjhXSmVoTGh2MHhZWXArZHZmMWdQbGI0Q1lu?=
 =?utf-8?B?TXBBNWV1R0N6SnpGWm5WZit4bHhuM2JyaytmR0VDK2JVQ3N5QjRHeERydTBm?=
 =?utf-8?B?YVhOd1Y5enUrblZiZW91Yk1tZS9IR3ZGcVdNVlEyM3RycW1nSGxWZGhZbGg3?=
 =?utf-8?B?cGoydllkSVNEWnhYQXNJbjlmcEgxWWlKZC9sNmttcytCdzFpWUZpc2Ryaytr?=
 =?utf-8?B?TmRuYlNjakJEU3QybW5vQ2VtV0FoRmVFaGljdUY4TVR0b0ZxeFliU0lZQytU?=
 =?utf-8?B?Z2lOVGY3bjVicHZHeTQxSm1GSEl2VGJ5cElNN3A0ZHB2QUR4S2RENk9tK1Bw?=
 =?utf-8?B?ZVQ4b0s5VUxMZkxoL1VqSE1aaVo2MVlBYXQzQjFNeVd3YzYvQlVPQ2o1L2hG?=
 =?utf-8?B?MTJhTmxJMCtpTzViTHhQNUwvTStMN0RrbmhRelZFNzJENXBJWk9uMEEwVHAw?=
 =?utf-8?B?UkJRa3F3NDFFU0VRLzRpT2N2Q3lQYmt3Yi9MTG1jemFMQ0k2dDlqcW41T2dN?=
 =?utf-8?B?cXNaU2hpMHlZbjJoKzZ2SnNIaitZdWVmL1ZMOStzSG1KcEF6YXlKRXorOXFI?=
 =?utf-8?B?K0JEZ3lNZXpYZHhEeCtzR2F1QUxJSjZ3WmRtejg5UU81RmpyK3dXT1hZV3U3?=
 =?utf-8?B?alZGaS9xWFc3TW56SE9IU0ZOa0FER29DcVlqQk5NWkpMRHVsYSt6U0phUzhD?=
 =?utf-8?B?dnAzMWRHak1NNWtNQWJSSzhtSGZqTkZqNElySDdrOW92VlRETDRXZ0cwZ2JX?=
 =?utf-8?B?UGkyQytoZzZHSXdIVmt6Z0hVakhhQm8rd1JublQ4UU00Q2pwSzdzWjUxS2Jy?=
 =?utf-8?B?Y0xnc3lqOHBEai93eWR3MGZYdlR0ZnM4RWVYSzNValNhTkVCR0dKNUl0dTA4?=
 =?utf-8?B?V0tlQlBrSWZpelorSitJVEplL2E0a21QNk11ajhWVkhicVk0bFJIYThaenZz?=
 =?utf-8?B?aWh6dHoxa0k0MjFKekthajY0S1NpK2FSVnlqMmxIKzgybnovbExlbnl1K2V1?=
 =?utf-8?B?SjlHYTU0c0RMTDM0ZUpGMExEWHNWTjVtQzNlZHBTZnI0WmJtSHNjdDNoYnBk?=
 =?utf-8?B?aFl6Z2ZLTHFidk92eFpoSGlYd055WGpKU21oOW1mUS9sWUg1V09xdFpyeUhD?=
 =?utf-8?B?YnpYWUkzTXErSnNsQUx6RVRnT1gxVHhHM0o1a2NUcFVmWWZQSWpMeVFWZ1RF?=
 =?utf-8?B?clEyLzlpekxkeUxBQXlRS2VVMnBQaXdhT2V4MVhXMXluK2ZKT2xxeXdRVkhU?=
 =?utf-8?B?am1OQ0M5eHdOc0dkVTFPcm5XZUVESXpLR3hleDB0ejZPRDgydVFxcExBTFBl?=
 =?utf-8?B?TitZZHpHQ2Zkd0JDcU93blJlaGVQekNTbFJ3ZXdqTUtEQUdYRjNPalVZS21U?=
 =?utf-8?B?YVJoSCtUNEV4WlVOdUJiRXdjM1NsdTZ4N3RNbkdiQjhwMVNwRWU2aEhTWHpn?=
 =?utf-8?Q?raYd6HWdEYjeVU7awrilXERQI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1882181e-5b75-4f12-67d1-08db7ebb91c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 07:27:07.2247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKpOmMl5+RcT7Lhch4O6LShi2BuSpQe/AJQYjn2XtDlARGsszKaXLGzcLHuhJRJRryoBSFklpfMymomWIi/mdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPg0KPiAuLi4NCj4gU3ViamVj
dDogW1BBVENIXSByZWZzY2FsZTogRml4IHVzZSBvZiB1bmluaXRhbGl6ZWQgd2FpdF9xdWV1ZV9o
ZWFkX3QNCj4gDQo+IEl0IHdhcyBmb3VuZCB0aGF0IHJ1bm5pbmcgdGhlIHJlZnNjYWxlIHRlc3Qg
bWlnaHQgc29tZXRpbWVzIGNyYXNoIHRoZSBrZXJuZWwNCj4gd2l0aCB0aGUgZm9sbG93aW5nIGVy
cm9yOg0KPiANCj4gWyA4NTY5Ljk1Mjg5Nl0gQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1
bHQgZm9yIGFkZHJlc3M6IGZmZmZmZmZmZmZmZmZmZTgNCj4gWyA4NTY5Ljk1MjkwMF0gI1BGOiBz
dXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlIFsgODU2OS45NTI5MDJdDQo+ICNQ
RjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZSBbIDg1NjkuOTUyOTA0XSBQ
R0QgYzRiMDQ4MDY3DQo+IFA0RCBjNGIwNDkwNjcgUFVEIGM0YjA0YjA2NyBQTUQgMCBbIDg1Njku
OTUyOTEwXSBPb3BzOiAwMDAwIFsjMV0NCj4gUFJFRU1QVF9SVCBTTVAgTk9QVEkgWyA4NTY5Ljk1
MjkxNl0gSGFyZHdhcmUgbmFtZTogRGVsbCBJbmMuDQo+IFBvd2VyRWRnZSBSNzUwLzBXTVdDUiwg
QklPUyAxLjIuNCAwNS8yOC8yMDIxIFsgODU2OS45NTI5MTddIFJJUDoNCj4gMDAxMDpwcmVwYXJl
X3RvX3dhaXRfZXZlbnQrMHgxMDEvMHgxOTANCj4gICA6DQo+IFsgODU2OS45NTI5NDBdIENhbGwg
VHJhY2U6DQo+IFsgODU2OS45NTI5NDFdICA8VEFTSz4NCj4gWyA4NTY5Ljk1Mjk0NF0gIHJlZl9z
Y2FsZV9yZWFkZXIrMHgzODAvMHg0YTAgW3JlZnNjYWxlXSBbIDg1NjkuOTUyOTU5XQ0KPiBrdGhy
ZWFkKzB4MTBlLzB4MTMwIFsgODU2OS45NTI5NjZdICByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMA0K
PiBbIDg1NjkuOTUyOTczXSAgPC9UQVNLPg0KPiANCj4gVGhpcyBpcyBsaWtlbHkgY2F1c2VkIGJ5
IHRoZSBmYWN0IHRoYXQgaW5pdF93YWl0cXVldWVfaGVhZCgpIGlzIGNhbGxlZCBhZnRlciB0aGUN
Cj4gcmVmX3NjYWxlX3JlYWRlciBrdGhyZWFkIGlzIGNyZWF0ZWQuIFNvIHRoZSBrdGhyZWFkIG1h
eSB0cnkgdG8gdXNlIHRoZQ0KPiB3YWl0cXVldWUgaGVhZCBiZWZvcmUgaXQgaXMgcHJvcGVybHkg
aW5pdGlhbGl6ZWQuIEZpeCB0aGlzIGJ5IGluaXRpYWxpemluZyB0aGUNCj4gd2FpdHF1ZXVlIGhl
YWQgZmlyc3QgYmVmb3JlIGt0aHJlYWQgY3JlYXRpb24uDQo+IA0KPiBGaXhlczogNjUzZWQ2NGIw
MWRjICgicmVmcGVyZjogQWRkIGEgdGVzdCB0byBtZWFzdXJlIHBlcmZvcm1hbmNlIG9mIHJlYWQt
DQo+IHNpZGUgc3luY2hyb25pemF0aW9uIikNCj4gU2lnbmVkLW9mZi1ieTogV2FpbWFuIExvbmcg
PGxvbmdtYW5AcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBrZXJuZWwvcmN1L3JlZnNjYWxlLmMgfCAz
ICstLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvcmVmc2NhbGUuYyBiL2tlcm5lbC9yY3UvcmVm
c2NhbGUuYyBpbmRleA0KPiAxOTcwY2U1ZjIyZDQuLmUzNjVkNmY4YzEzOSAxMDA2NDQNCj4gLS0t
IGEva2VybmVsL3JjdS9yZWZzY2FsZS5jDQo+ICsrKyBiL2tlcm5lbC9yY3UvcmVmc2NhbGUuYw0K
PiBAQCAtMTEwNywxMiArMTEwNywxMSBAQCByZWZfc2NhbGVfaW5pdCh2b2lkKQ0KPiAgCVZFUkJP
U0VfU0NBTEVPVVQoIlN0YXJ0aW5nICVkIHJlYWRlciB0aHJlYWRzIiwgbnJlYWRlcnMpOw0KPiAN
Cj4gIAlmb3IgKGkgPSAwOyBpIDwgbnJlYWRlcnM7IGkrKykgew0KPiArCQlpbml0X3dhaXRxdWV1
ZV9oZWFkKCYocmVhZGVyX3Rhc2tzW2ldLndxKSk7DQoNClJ1bm5pbmcgY2hlY2twYXRjaC5wbCB0
b29sIHdpdGggdGhlICIgLS1zdHJpY3QiIG9wdGlvbiwgaXQgY29tcGxhaW5lZCB0aGF0IA0KIkNI
RUNLOiBVbm5lY2Vzc2FyeSBwYXJlbnRoZXNlcyBhcm91bmQgcmVhZGVyX3Rhc2tzW2ldLndxIi4N
Ckkga25vdyB0aGF0IHlvdSBqdXN0IG1vdmVkIHRoZSBjb2RlIHBvc2l0aW9uLiBUaGUgdG9vbCBz
aG91bGQgaGF2ZQ0KY29tcGxhaW5lZCB0aGUgb3JpZ2luYWwgY29kZS4g8J+Yig0KDQpPdGhlciB0
aGFuIHRoYXQsIHRoaXMgcGF0Y2ggTEdUTS4NCg0KICAgIFJldmlld2VkLWJ5OiBRaXV4dSBaaHVv
IDxxaXV4dS56aHVvQGludGVsLmNvbT4NCg0KVGhhbmtzIQ0KLVFpdXh1DQoNCj4gIAkJZmlyc3Rl
cnIgPSB0b3J0dXJlX2NyZWF0ZV9rdGhyZWFkKHJlZl9zY2FsZV9yZWFkZXIsICh2b2lkICopaSwN
Cj4gIAkJCQkJCSAgcmVhZGVyX3Rhc2tzW2ldLnRhc2spOw0KPiAgCQlpZiAodG9ydHVyZV9pbml0
X2Vycm9yKGZpcnN0ZXJyKSkNCj4gIAkJCWdvdG8gdW53aW5kOw0KPiAtDQo+IC0JCWluaXRfd2Fp
dHF1ZXVlX2hlYWQoJihyZWFkZXJfdGFza3NbaV0ud3EpKTsNCj4gIAl9DQo+IA0KPiAgCS8vIE1h
aW4gVGFzaw0KPiAtLQ0KPiAyLjMxLjENCg0K
