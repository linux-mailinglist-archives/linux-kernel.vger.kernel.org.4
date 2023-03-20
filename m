Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998B36C093C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjCTDQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCTDQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:16:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6812412CCF;
        Sun, 19 Mar 2023 20:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679282161; x=1710818161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Jf6jy90CqCoIxPplf2kVM+Cdt2GsWSFER+t1RwpBFw=;
  b=ZB1d9S3pq+JrpZ/Pya6cdKRZyDgUU3eRH+X2Y5NU0LsWc3uv8XyHtXuD
   3vcnysRciKGjrcL2eyCOzqoKUCKRkc1EGNOeBbVzRgZtyFV0tpi+9bm7I
   CnUWjur7Wk1FF0+RoWm44/geMzY4o5oDCF83zvTsgH8B4Lqd6CCGg+VfY
   Rls5knTHKNLTY2kxaBEHlP/MYS2bZqHDVVW5oRKy/BiqWvLa6mxPz06dn
   knOHyAbdVQy11OA9oJGXB1ilkmnSk/8gPSCRcaoihm2VFJjHRcmSr63Zi
   dEnPUfrg9tAf4fyCOM2LiRlrx9N+c3wGH35uToC8jKgHmc8i49rljzKhO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="338589656"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="338589656"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 20:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="804758555"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="804758555"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 19 Mar 2023 20:16:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 20:16:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 20:15:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 19 Mar 2023 20:15:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 19 Mar 2023 20:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miXbv3vjhLF84skKBoh9H8HrJxaVnirbvVKslcqwbfu92p1UGG5wFxTvkf4Xv54PKJk2zitt0LVUYo3j9X39fATjsQ2p3r+ByvpN2FHdKh1iUHfjLaMWXr3CCm+mBsT1POsmRdNtxE84anhIoXx8OLSdwRJHBXpdhu0W9bT+haqCia57S/rZhcwSGvoSV6grbO0xmJztP3D/+wnuYT+vM1LtMrKdyWU2p1+mWBzN5A9RFDWJaDLQiLFpwDQYrCX7syV/KRRRR8etKTW5uBTpe9jFAUVyve/jNQTtFBTPch1ZiTgkCN1+jjaGzBT6TxSzFDcvnF5dnqol9zGq0TB6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Jf6jy90CqCoIxPplf2kVM+Cdt2GsWSFER+t1RwpBFw=;
 b=Vcd6/8eEFuvZu9zDLsFSqgNw8v6wML2OL5lGOmkTg+ZL+3z+yQ8CKTFUwgWcJaBeKKJ/JyCyLPMPqO8GmmPcfJJwbS0l4yiIFM+3MUKL7fPf+E5Ms0iN9HxVC+rOJKcfsel+mriaRzguwWYHV8BrVcmqXYxYGcDEGcLfIlAGwrS0+kLzCJ8oJ5FGr3088rpPLuHajdWEbBGGJImPtZFdaqYhTiW1Kz7GIpK5KSsfjTYf65q10rdUf3KNODwNbu+Ulct7jTjh3sZk6aOSrpaCKGO2/iF7ZMOTrwc+UrOg9dQVMNDPcLE74vMKFwcaBCaP0Emz3Zp2Kt20H9Jc4NbOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 03:15:56 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 03:15:56 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Fix some incorrect trace log in rcu_boost and
 rcuc kthreads
Thread-Topic: [PATCH v2] rcu: Fix some incorrect trace log in rcu_boost and
 rcuc kthreads
Thread-Index: AQHZWtUr97R83znsk0CEDC0DDfgDPa8C+I+AgAAETFA=
Date:   Mon, 20 Mar 2023 03:15:56 +0000
Message-ID: <PH0PR11MB588000D59C94F8CF45E72FEDDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230320024341.3956543-1-qiang1.zhang@intel.com>
 <CAEXW_YTMVF4qhFya5kW=xi5pLGd_gb_n-ZA+8+41iaG1S4YdMg@mail.gmail.com>
In-Reply-To: <CAEXW_YTMVF4qhFya5kW=xi5pLGd_gb_n-ZA+8+41iaG1S4YdMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM4PR11MB7328:EE_
x-ms-office365-filtering-correlation-id: b654f3fa-21b6-4cbf-5853-08db28f16be4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJeuYE6BDPC2pQ0Vllu7qY+azS2+fJ9CjHE8YO6OODWH/6cJ+FFjnqOcjwE7ohzHtAx13/trhFTi/Kv7Z+v3OO8WlZS29xJx9ENUt6jLRhxxak3uz9S9+5GcQI1VrATx6Lncfecq+qxTWEK9QAopku4sXho6FCXi9z+aL/FNt9bEhckgnb+B7dpjGRioOFskL9zJ4GmbcNordk7u3/c7HkTykfzVjM4cRqrslgUZ5ANTI18Ur3MjmS0L31rGdxqSct8r/zEd3rE12rqurYuaYs8nYDucaObODSYtynQsRA0gK0F7kMExgnkcQlhSoLiGOO8I/bCsTajG6/uSpw7529RJ2atg3WCAIDf4peLu2ACHmVJCmPd2++2GqB+n+PpTse0CovEK0Z5+RZTVH8HMkZFbo/C5LluIA9AOEuzYE1P6v/pVPwAFmkc1l+g/J0exEbYSzBnAqd3aNX5AO+OhJYhr/vfOlfcubGPA9h74M1JKAeQrSWae08sakWiTgRkAS3kJBmx+lK/S6oZnZAVI0OQrVyKTbJyrei1RM1NLOTgVhgE9QE2OjGn+NNuc5m1HI/LepO8/ofsyi3b4QSGLnii7UOzI0wbCSeZuLG0wEIABceRLGqMhm+r14i3wEeQvN4npN9dNI6qlSI91+oNOcNKPEnIYkaH1910gr/6kKsI5QriYlGVTherfSbn4ma/BUERxG3t/PL1J6uOxJ270jQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199018)(38100700002)(478600001)(2906002)(316002)(33656002)(82960400001)(122000001)(186003)(66446008)(66476007)(64756008)(66556008)(66946007)(8676002)(6916009)(76116006)(54906003)(6506007)(9686003)(83380400001)(86362001)(4326008)(26005)(7696005)(38070700005)(41300700001)(71200400001)(5660300002)(55016003)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2VEMEF3VnNyZnFqWEJiaGNuZ0trdEFqM2V3d0ZGc0FRd2g1WGZEM1ZBaFJM?=
 =?utf-8?B?SGN3M2FmNnNQWFBqbi8rd2YvQ0h6SzBQTnhJRGxMcEF2Q2p5cy9Ub2hzYWth?=
 =?utf-8?B?ZG5TZTBhbG9hdzU5ZG40Y0V5M1RFbk9EWVdNTG11cXJoTEtCQ1Eza3lLOEsz?=
 =?utf-8?B?UFVvNC9lK0k0a0VBcjlzUUVIWDFUNWsxekQ2cTZEOUQvbS9DODFYK0xZdTN4?=
 =?utf-8?B?TkdSSTVQaXFsdWZoRTVtc2xpTzkyclc4elhSczZkR1hkTXB5dFJNM21FZ3da?=
 =?utf-8?B?aTZ4Q0ZsNEdHZEJmZXRab0wzSG9xWUhDTkdRMU1RZzJvYmkwZ1dWSXlSNkxJ?=
 =?utf-8?B?aDgwSW5JejNUY2s4NEJsQiszcEVLOWhRME5YTXJxRXNUTW92Ym9zUHBKc1Na?=
 =?utf-8?B?bzVWS0x0K0l2SEkvT3NCOGV3Q3V5bGh3ZkRPM29WYlBmSDkwdFNKb2hjNk5D?=
 =?utf-8?B?b3FwOEx0VTZ2OXFQNEVvdFF1THdkREMxV0xiV0JhTmZHemtteWoxeTlKOFNX?=
 =?utf-8?B?dEpha3JNZzhCckNVMElIQTdIUktpaE9RUzJLNFpIUlBSZ25PUGEwWVRTcFBV?=
 =?utf-8?B?NUpvYi9kTnlZYkRjbVUzSXBTV2N3YTlCMVYzUW9xc2FQdFNubGNCN0lzeEg3?=
 =?utf-8?B?YWM2VnFmSWxFS3ZyclV4NTdIeEZKcjRYc2J1SDd5ampNWW84V3JIdnNINVJG?=
 =?utf-8?B?SFJjUWpzNVFkekFDeTJDaFh2TGNFOFZlcHBWMEJiNGJTbHAxMkNWZ1p2ZFhF?=
 =?utf-8?B?Tkc2ZXNXa3B1elVMY2h4eW40Q3RuVlBKUHBWTXQ0VERWdC9mdTFyWGthVWQw?=
 =?utf-8?B?Y3JheDBPNWhybEhLOHg0K0p0WkxBc1F4M081aHptdmswL01kbGR0d0hoWFFF?=
 =?utf-8?B?VUJXK0dzemxWdlRadC8wcU90NGxYeHBNL3FRcFNYOVppUkxUYUpPck52OVhx?=
 =?utf-8?B?NWtVZDBvMGdpZ04yZEZUQkpBNXVIOG1meGVGd2lGZlA5RHkrYW9KWTlwMVVo?=
 =?utf-8?B?bWdNcGtid3htUmJuZ2R1RjdjNTFQYXYxR05iMTREWGlyN1BwVTNzcG9mWVZX?=
 =?utf-8?B?anFtYlhaS3doZk4wMm9JczhyQ2RhUExrVVg4ZzdIMlBDZWIrQ1hzRGxDTm0w?=
 =?utf-8?B?NnY2VjBTZVFJb0Z5L2ZRTXo1YlJqb0FIWWxIcWhtNmpGQ3pnYUIwQWJ1MS9N?=
 =?utf-8?B?dGd0Vmg1ZllRRXpyTm5wTE42aUt5UERWZkpMQlJlQnNyZGE5bEd3c1FRNkhs?=
 =?utf-8?B?SlJ3NW9aVmpGbzYrL09NMmthYXEwSlp6T1E4bkJOWEFBUm4wd01GVisyTkt2?=
 =?utf-8?B?UFFCbTFuRkdDNFI1aEFQa0ZMZWJVWjRMUnEvN1dEb0lrUGN3NDFjbDNzMk4r?=
 =?utf-8?B?Vit0Z20zZjBmWHFIamJXUlRLeVRIL3pYMGlJcUgvYW9SWmJ0VW1lZXNaeHg2?=
 =?utf-8?B?NXZYeEF1S1hpNW1kT2RRL1pOeHhSSTBOcWVINUJZVkN4Snk0SEdFTVZOMXd6?=
 =?utf-8?B?dWlORTViZk5TTzJNaVhzWUR4aXRqU2Fzc3IvQm5VNGFjOURocWpmTHNHNWZo?=
 =?utf-8?B?S1VxSnhDYXEyNkhKMkNyVStrNGM1UStKK1dHR2laL1laR0xpQXZxQnd1WEhX?=
 =?utf-8?B?ditpN0JmSnVaTFJQSnh4RDdncU9pcDhkb2NzRllLYi9kR2RZcTI0bk5zZTdl?=
 =?utf-8?B?YnRyMG9pN0FxNVNyTXlpYjFVNXRnOTR0c0tOUzA2VStqanVlQWMxNnJlUW9G?=
 =?utf-8?B?ckg0TmJ1bk81KzNhUXRvSGw1Z044TW5GdjMrRzRIYndxS1lSVVE4RGpoa3V1?=
 =?utf-8?B?Q2l6cDlRN1JydWZkR3F0VnJTRnhiRDFwN3Rvb1pzdjVkaVNDY2RZWG9kaStW?=
 =?utf-8?B?MlFwT0hlczJDNXcvSkhSQ3lrcExYZzdPcHptMHhXd2U3RThUTUUvd1Bqa1Zr?=
 =?utf-8?B?R0FFRVU1NjJCTnFMV3M1WVk1TmhxQmg1dmNvSzRKMllzaGRFRUtWa0h5NFVF?=
 =?utf-8?B?K2xKQUZ6dmNaZzAwWDJkT1A4cDVZN0ZWcEtoUCsza0xWRFU5VUwzREppK2lY?=
 =?utf-8?B?NnIxeHVIeWt0YWFLQSt0OFZ6cHU5TzFTUytFTE1ZK21MQmN0d08zazRBdmVI?=
 =?utf-8?Q?DRgxMhDMpIv0s2h4WvBPM8Fg3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b654f3fa-21b6-4cbf-5853-08db28f16be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 03:15:56.4944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: no23hYL0kmXBqg0TRQg8KkVf18EgLnxLFD6HRqGFw7Kptm+KBA8m4exIA2ikSQ234OJGA9EqG1Ha/gWPezZ5Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIFN1biwgTWFyIDE5LCAyMDIzIGF0IDEwOjM54oCvUE0gWnFpYW5nIDxxaWFuZzEuemhhbmdA
aW50ZWwuY29tPiB3cm90ZToNCj4NCj4gSW4gcmN1X2Jvb3N0IGt0aHJlYWRzLCBiZWZvcmUgaW52
b2tlIHJjdV93YWl0KCksIHRoZSB0cmFjZSBzdHJpbmcNCj4gc2hvdWxkIG1hcmsgIlN0YXJ0IGJv
b3N0IGt0aHJlYWRAcmN1X3dhaXQiLCBhZnRlciByY3Vfd2FpdCgpIGVuZCwNCj4gbWFyayAiRW5k
IGJvb3N0IGt0aHJlYWRAcmN1X3dhaXQiLiBmb3IgYm9vc3Qga3RocmVhZCBlbnRlciBpZGxlDQo+
IHN0YXRlLCB0aGUgdHJhY2Ugc2hvdWxkIGFsc28gZG8gc2FtZS4NCj4gSW4gcmN1YyBrdGhyZWFk
cywgd2hlbiB0aGUgcmN1X2NwdV9oYXNfd29yayBpcyBzZXQgemVybywgaW5kaWNhdGVzDQo+IHRo
YXQgdGhlcmUgYXJlIG5vIHdvcmtzIHRvIHByb2Nlc3MsIHRoZSByY3VjIGt0aHJlYWRzIHdpbGwg
ZW50ZXINCj4gd2FpdGluZyBzdGF0ZSwgc28gdGhlIHRyYWNlIHN0cmluZyBzaG91bGQgbWFyayAi
U3RhcnQgQHJjdV93YWl0Ii4NCj4NCj5Ob3BlLiBVbmZvcnR1bmF0ZWx5LCBpbiB0aGlzIGhhcmQg
dG8gcmVhZCBjaGFuZ2UgbG9nLCB5b3UgYXJlIG1ha2luZw0KPnRoZSAiU3RhcnQgQHJjdV93YWl0
IiB1cC4NCj4NCj5UaGUgdHJhY2UgY2xlYXJseSBzYXlzICJTdGFydCBib29zdCBrdGhyZWFkIEAu
Li4iLA0KPg0KPlNvIGZpcnN0IG9mIGFsbCwgZG9uJ3QgbWFrZSB0aGluZ3MgdXAgcGxlYXNlIGJh
c2VkIG9uIGltYWdpbmF0aW9uLiBMZXQNCj51cyBnbyBieSB0aGUgYWN0dWFsIHRyYWNlIG1lc3Nh
Z2UgcHJlY2lzZWx5IGFuZCBub3Qgc2tpcCBpbXBvcnRhbnQNCj53b3JkcyBpbiBpdC4NCj4NCj5O
b3csIGFuIGludGVycHJldGF0aW9uIG9mIHRoZSB0cmFjZSBtaWdodCBiZSAsIHdlIHByaW50IGEg
IlN0YXJ0Ig0KPndoZW5ldmVyIHRoZSB0aHJlYWQgaXMgUlVOTklORyBhbmQgIkVuZCIgd2hlbmV2
ZXIgdGhlIHRocmVhZCBpcw0KPlNMRUVQSU5HLiBUaGF0IG1ha2VzIG11Y2ggbW9yZSBzZW5zZSBz
byB0aGUgZXhpc3RpbmcgY29kZSBmb3IgdGhlDQo+Ym9vc3Qga3RocmVhZCBpcyBhbHJlYWR5IGNv
cnJlY3QuDQo+DQo+SG93ZXZlciwgSSBkaWQgbm90aWNlIHRoaXMgYml0IG9mIGNvZGUgaW4gdHJl
ZS5jIG1pZ2h0IGhhdmUgYmVlbg0KPmNhdXNpbmcgY29uZnVzaW9uOg0KPg0KPipzdGF0dXNwID0g
UkNVX0tUSFJFQURfWUlFTERJTkc7DQo+dHJhY2VfcmN1X3V0aWxpemF0aW9uKFRQUygiU3RhcnQg
Q1BVIGt0aHJlYWRAcmN1X3lpZWxkIikpOw0KPnNjaGVkdWxlX3RpbWVvdXRfaWRsZSgyKTsNCj50
cmFjZV9yY3VfdXRpbGl6YXRpb24oVFBTKCJFbmQgQ1BVIGt0aHJlYWRAcmN1X3lpZWxkIikpOw0K
PipzdGF0dXNwID0gUkNVX0tUSFJFQURfV0FJVElORzsNCj4NCj5TbyBwZXJoYXBzIGEgcHJvcGVy
IGZpeCBtaWdodCBiZSAtIGluIHRoaXMgZnJhZ21lbnQgdGhlIFN0YXJ0IGFuZCBFbmQNCj5zaG91
bGQgYmUgc3dhcHBlZCBpbnN0ZWFkLg0KPg0KPnRoYW5rcywNCj4NCj4gLSBKb2VsDQo+DQo+DQo+
DQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4gLS0t
DQo+ICBrZXJuZWwvcmN1L3RyZWUuYyAgICAgICAgfCAyICstDQo+ICBrZXJuZWwvcmN1L3RyZWVf
cGx1Z2luLmggfCA4ICsrKystLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZS5jIGIv
a2VybmVsL3JjdS90cmVlLmMNCj4gaW5kZXggNzM0YzI1MmMxZTgwLi5jMTkxNTQwODc5NmYgMTAw
NjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQo+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZS5j
DQo+IEBAIC0yNDY1LDcgKzI0NjUsNyBAQCBzdGF0aWMgdm9pZCByY3VfY3B1X2t0aHJlYWQodW5z
aWduZWQgaW50IGNwdSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmN1X2NvcmUoKTsNCj4g
ICAgICAgICAgICAgICAgIGxvY2FsX2JoX2VuYWJsZSgpOw0KPiAgICAgICAgICAgICAgICAgaWYg
KCp3b3JrcCA9PSAwKSB7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHRyYWNlX3JjdV91dGls
aXphdGlvbihUUFMoIkVuZCBDUFUga3RocmVhZEByY3Vfd2FpdCIpKTsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgdHJhY2VfcmN1X3V0aWxpemF0aW9uKFRQUygiU3RhcnQgQ1BVIGt0aHJlYWRA
cmN1X3dhaXQiKSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICpzdGF0dXNwID0gUkNVX0tU
SFJFQURfV0FJVElORzsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiAgICAg
ICAgICAgICAgICAgfQ0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlX3BsdWdpbi5oIGIv
a2VybmVsL3JjdS90cmVlX3BsdWdpbi5oDQo+IGluZGV4IDdiMGZlNzQxYTA4OC4uN2I2MjJiNTE5
NmE4IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmgNCj4gKysrIGIva2Vy
bmVsL3JjdS90cmVlX3BsdWdpbi5oDQo+IEBAIC0xMTE0LDEwICsxMTE0LDEwIEBAIHN0YXRpYyBp
bnQgcmN1X2Jvb3N0X2t0aHJlYWQodm9pZCAqYXJnKQ0KPiAgICAgICAgIHRyYWNlX3JjdV91dGls
aXphdGlvbihUUFMoIlN0YXJ0IGJvb3N0IGt0aHJlYWRAaW5pdCIpKTsNCj4gICAgICAgICBmb3Ig
KDs7KSB7DQo+ICAgICAgICAgICAgICAgICBXUklURV9PTkNFKHJucC0+Ym9vc3Rfa3RocmVhZF9z
dGF0dXMsIFJDVV9LVEhSRUFEX1dBSVRJTkcpOw0KPiAtICAgICAgICAgICAgICAgdHJhY2VfcmN1
X3V0aWxpemF0aW9uKFRQUygiRW5kIGJvb3N0IGt0aHJlYWRAcmN1X3dhaXQiKSk7DQo+ICsgICAg
ICAgICAgICAgICB0cmFjZV9yY3VfdXRpbGl6YXRpb24oVFBTKCJTdGFydCBib29zdCBrdGhyZWFk
QHJjdV93YWl0IikpOw0KDQpIaSBKb2VsLA0KDQpTb3JyeSBub3cgSSB1bmRlcnN0YW5kIHdoYXQg
eW91IG1lYW4sIHRoZSBzdGFydCB5b3UgZGVzY3JpYmUgaXMgZm9yIGJvb3N0IGt0aHJlYWQsIA0K
YW5kIHRoZSBzdGFydCBJIGRlc2NyaWJlIGlzIGZvciByY3Vfd2FpdCgpLiAgDQoNClRoYW5rcw0K
WnFpYW5nDQoNCg0KPiAgICAgICAgICAgICAgICAgcmN1X3dhaXQoUkVBRF9PTkNFKHJucC0+Ym9v
c3RfdGFza3MpIHx8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBSRUFEX09OQ0Uocm5wLT5l
eHBfdGFza3MpKTsNCj4gLSAgICAgICAgICAgICAgIHRyYWNlX3JjdV91dGlsaXphdGlvbihUUFMo
IlN0YXJ0IGJvb3N0IGt0aHJlYWRAcmN1X3dhaXQiKSk7DQo+ICsgICAgICAgICAgICAgICB0cmFj
ZV9yY3VfdXRpbGl6YXRpb24oVFBTKCJFbmQgYm9vc3Qga3RocmVhZEByY3Vfd2FpdCIpKTsNCj4g
ICAgICAgICAgICAgICAgIFdSSVRFX09OQ0Uocm5wLT5ib29zdF9rdGhyZWFkX3N0YXR1cywgUkNV
X0tUSFJFQURfUlVOTklORyk7DQo+ICAgICAgICAgICAgICAgICBtb3JlMmJvb3N0ID0gcmN1X2Jv
b3N0KHJucCk7DQo+ICAgICAgICAgICAgICAgICBpZiAobW9yZTJib29zdCkNCj4gQEAgLTExMjYs
OSArMTEyNiw5IEBAIHN0YXRpYyBpbnQgcmN1X2Jvb3N0X2t0aHJlYWQodm9pZCAqYXJnKQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBzcGluY250ID0gMDsNCj4gICAgICAgICAgICAgICAgIGlm
IChzcGluY250ID4gMTApIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgV1JJVEVfT05DRShy
bnAtPmJvb3N0X2t0aHJlYWRfc3RhdHVzLCBSQ1VfS1RIUkVBRF9ZSUVMRElORyk7DQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHRyYWNlX3JjdV91dGlsaXphdGlvbihUUFMoIkVuZCBib29zdCBr
dGhyZWFkQHJjdV95aWVsZCIpKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgc2NoZWR1bGVf
dGltZW91dF9pZGxlKDIpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICB0cmFjZV9yY3VfdXRp
bGl6YXRpb24oVFBTKCJTdGFydCBib29zdCBrdGhyZWFkQHJjdV95aWVsZCIpKTsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgc2NoZWR1bGVfdGltZW91dF9pZGxlKDIpOw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICB0cmFjZV9yY3VfdXRpbGl6YXRpb24oVFBTKCJFbmQgYm9vc3Qga3RocmVh
ZEByY3VfeWllbGQiKSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5jbnQgPSAwOw0K
PiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgIH0NCj4gLS0NCj4gMi4yNS4xDQo+DQo=
