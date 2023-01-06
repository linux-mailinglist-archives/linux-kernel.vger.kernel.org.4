Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F3065F9A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjAFCnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAFCnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:43:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A2B65AF1;
        Thu,  5 Jan 2023 18:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672972983; x=1704508983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tmswc8LN4luU9y94CXpI57IJYfMCvT/UsB7maTe2zcQ=;
  b=L0SnsuJipsfyPK7bEuZ3kMb/ZP/N270BDjn96SCvHaAfz4mltpsYBbKz
   k2Mk2ZKjlTSNcTgtrnzJfBIP2JRYGBiTy4H96IoXpTpG4xIsGEa3pGYr1
   A4UBvDGDcfnFgXhztPd3wL8YflGDwdwQo26f6g+HBaK8uBsa8SQOwKPGv
   RTIwto9uP/thGT/9zKV7hWWo0y5JYrlAomunQWu+ZpWwWZ+QeKvvh6UW7
   9utgv0npMiUTUoULnHT68RcOAeVun34fnDIJdureGi7bpcovdNOvEHR1H
   v/DAdg6AHOH2VUbANyxV+uvfhLzbevjmSMYK4pu1E7Sbqi0PlFBJPqKOI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="323636897"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="323636897"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 18:43:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="763368315"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="763368315"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jan 2023 18:43:01 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 18:43:01 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 18:43:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 18:43:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 18:43:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flUuT+2MKOfRMAYEWHfW+baSAkm4YzzMkyJZwvqT+Btu0dagnqZoDjvwOGm8D68sYrzn6OQShDF4ZabbkoKira6+gz6PjnYYTroTSRTBjH+hbQA2rIFARfJd1p63qrnsiRqiSu80qLoxYcFO3a7tamCi4pw8z6ojqflyxvqJGyLm0wgpXsPIKto8Jwj544vkb1vlGugoJVhsWHoksVSJkzu+c261CaxVRSnwkQJKZNUv4ZwW4q3TCaKKek2EiVq6oBCO1ucNbYdJ43LEjVFut+DTeVBi6eTkG1tNpWDV+T9F72J3lMrZsYuSCvOxzQYVPv+YcRn6MwZOqRQDVcPnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tmswc8LN4luU9y94CXpI57IJYfMCvT/UsB7maTe2zcQ=;
 b=MffxtWJfdzYPqxy0HR7ScSOFihOSLeq0eXYQlB03RtwbNglZuh38OuUrXfRzja8Rj/P4YF5Z1zgDJ5laA1YE/QETESTgCnVJ0pBPfjeDDjJunkI4HmT+MYy8XVPM0x5JCT+9T+dFq6Ptgv+lFgRneT0axbruydMStdif0tGHMLTigTPLP2mij5O690ADvPjeJMbfWKVHFoO0naI/ZMxx+pvsJTOfGtwDUcUQfdlAXXeEAsIYzE1/gwYjJmngxYhZMjiIvalHApF7XiBWHUxPSbJPT14cXiDJEvoaRO6OCpEU/1aRBzscoSzDyhadR2CkFZW2440O7J0WUKxncsBc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB4885.namprd11.prod.outlook.com (2603:10b6:510:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 02:42:59 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 02:42:59 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>
CC:     "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Rework tick dependency setting into
 rcu_exp_handler()
Thread-Topic: [PATCH v2] rcu: Rework tick dependency setting into
 rcu_exp_handler()
Thread-Index: AQHZILarPPJyP5Q5VEGzw9rc7oSJZK6PRvwAgAFkYGA=
Date:   Fri, 6 Jan 2023 02:42:59 +0000
Message-ID: <PH0PR11MB5880A74D08B09F139D9AC19ADAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230105034000.971748-1-qiang1.zhang@intel.com>
 <20230105051146.GN4028633@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230105051146.GN4028633@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH0PR11MB4885:EE_
x-ms-office365-filtering-correlation-id: 982fadff-2bf1-42e4-b4bf-08daef8fb918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBAvPqp6Y1EIuGdkYonAjnzAuurhAlatwmWwFSXJ+UNw3rcNWjGkEBF1EwektEk73C8yQ9QEOdDJyQDwSHJm8gArKqvrqn5mMz47EIAJssfftRcNfjLYh6aat3UW+EavUH2XI2+69H6LvfJQVHFMgoZgbBJ1s+GJq1HURSR8BLhegnApwTbh82JlmmTC9incMijwm2FQ+GKpMejzXrM+Rz0gFNh5EdCOQ0KkiDEPXPwWvxPhwalLSFmSU/Twrca8ADOIkPw1KgKxQPKMnfejhcEum/3sWHVObEubGs+38xSStUOIdqxKHnF7c9ottvFBruQWEDAbv1eGaPFQKwTwKfbXhlGtjKAC9dZ2zqoVOoYTQ1WGGKF8C9rAqXQFET2EIX1pK9Lhj+njhioQgkr/mUb5cKI5+XsUWCauGY/lt2JTo63o8fhd7B4sSVLbRarzyeIdXuUI5v6yREDc4gTwiMXLldNn03RL7yfC7xnR2v2L9bp5e9a+euqeqNQtQ9QijKGeavQw1nEbR+iLGkAwrML8UW1i2g1JWeEypfiMtfOMReWu1TYNSAf4POZ9gEDSJpN9zjmu+Cx1brAcnaMgh6iPRtc7Q2NDcjWtqiyEusvKIx/+GxjpFY93RYt9i0SQvlwSA+sQyBMHl/hZJcWJnf8YtqimF44Q0YN1oEYDoCaK1YUBwXXWcHTamBPlO9tQJ4cklZZX485MgNuYkHq64w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(9686003)(186003)(2906002)(478600001)(26005)(71200400001)(7696005)(6506007)(33656002)(8676002)(76116006)(66476007)(66446008)(66946007)(66556008)(4326008)(41300700001)(64756008)(316002)(66574015)(110136005)(38100700002)(83380400001)(5660300002)(82960400001)(122000001)(8936002)(55016003)(52536014)(54906003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXcxVGpOMnRXWk5xRXoyWkJpd1BIbkZWcnUyZFp2SnZHNWVXWTdzRnJta21N?=
 =?utf-8?B?VnJ5eW10UG94SGNxOHozY3ZodkZvUHZTdjdZbld6YXVPaVB6c1NSNFZnd1lC?=
 =?utf-8?B?WmhYTnZDb2FxOFg5bjJpblhueDZhZStrajRKUzA5YU15azJ1S1dyT1hTcW1j?=
 =?utf-8?B?dTVtamhEaVVxYkpzQXFvcGVDeWpJRlpTa0pETDhITVdUbjNIdy9VaEFsZkx6?=
 =?utf-8?B?eXcrVVA4QW5yS2l5TFBuN2E1K3VyWDR2bEZhVmFOUnhabnc3QmZVUlBuT0dn?=
 =?utf-8?B?NFZGRG9YR0pjbFVRN3ZPSjZOVjJRd29lWW5zdThrNlFONTRkWTNqWVFjb0Vs?=
 =?utf-8?B?NGVkcmkyR2RwWnZtZklTbXRITzlGelhyN28yUy8yN1pKcHhXVEN1dkJvRlkw?=
 =?utf-8?B?aHduR0owSjhWZ0RvWng0U1paaGJEcDIxRFZQMzNGVzhMdDY2dTF5a0h3S3hk?=
 =?utf-8?B?WXdYb2RnMm5ydTRLNjJXd1pwV3hJN3d3QmZUMEhueDFwbVJtb1luNjFpbUV0?=
 =?utf-8?B?ajdYS1EzclRpdjVTQXZXY2MwaVVsbjVFdVEyejQwcFNsd3BDdEFZV1B4VDND?=
 =?utf-8?B?cCtJNjhwVmY1RXNvd0p3NUlDSHl5NUNYbTg2RVJHdndHcGtwckw1dWZvSk9S?=
 =?utf-8?B?bzVETGJOaHZVUmhyUWNVRXVQaXJ6aDU1aHhLTlNVeG5BKzFwcVpuNFNBVjc4?=
 =?utf-8?B?dmkyOFZyK2c1QTBMcGMyUlZ4MU5HTVdJWmloemdFd2wrbEQ2K0NNdS9pY1RG?=
 =?utf-8?B?MXFtMEtrUmV5RTBveFExZytlWll4NFZEREROcVdBdVVFcUc1S1VaTS84WUUx?=
 =?utf-8?B?aXdKd1lxN21ReWlHV0FzRG1VanJKdXB5bGIzM1dSdXJTbktmbGR0NkRTNnZO?=
 =?utf-8?B?RU9KS3Nsc1lxZXB4dlBHSUxlcmRPc0llVFcxa2IxZDF1SWNza0Y3NTM2Lzhj?=
 =?utf-8?B?Vk5RTGgzS1UrT3JjcFEyNm9PODJVeUhCRlNrVW9sSTN0c0Z5SFRWem13L2Jn?=
 =?utf-8?B?Q1V1eTZmcXFCcVY1KzVOK0tBUEFCVktXTXF1R2dsUUVpT3ZlN21zc21KQnF3?=
 =?utf-8?B?Wmp0amRHNjdlYlFUYmw5QzQwZkxiRXdwVEU5UkdwK205cWhQbE82Y3RoRzhn?=
 =?utf-8?B?amxvOVN4d3BFSW42MHZaL0MzSkVGaFBJN3BnWFh1cDl0RkQvK3hTZXNyRVA0?=
 =?utf-8?B?ZEw2VG03MVBzcE5HZnpsTnF6cmR0dTlsbmNjWmlTTWNqN0cxdS9ZdUt3aGIw?=
 =?utf-8?B?eVpWeVk4YjdRa0swL3lkY3pvTjdQMHMrUXE3OFZlK3pOdDRib2hTd2daMmRr?=
 =?utf-8?B?QkttbHhEY0VMeHNpaXVWVFdEd1RTczVzYUtZbDJNOUtxK1Z6dzFBOCtUQkxt?=
 =?utf-8?B?MEwybDVEd0JLVGJhRCs2Nlg1SGdmTW1yK3VTdGxOa0NVaWhCOTV6cjJHMjFY?=
 =?utf-8?B?YTBHTW5YQ3FCRURPVHpkTytHTG5qOGtJR2FLeXJjY1lSaEV5bTVWWW5KQ2FL?=
 =?utf-8?B?ZGthUHpjMHZXa3VoSFFvNU9objhDOWtFMkFPRmt0ZlBORnpQOGRoMnhmVWZE?=
 =?utf-8?B?MGlOK1JzMHV2VElSS3ZLelZqMXNBWlVDcVB0SEFJakZ4TWJCMlFJRnRzNktE?=
 =?utf-8?B?K0M0T2ozODRuYisrdk0wMXZoMTR0SjR6U2YrWUdDOVpZWnBSZ0RYelVxNXhy?=
 =?utf-8?B?QTQ5aldrVzh1eHUrMGczMEVuaXhSQytYcktEdW1FUzJRK0YyQncyYkV2SWI1?=
 =?utf-8?B?V1JkREtNL1E3TSt1cnlrL0lwZHZnVjZoT2pUaEpweG91ZUtDOURyWkdqdnBi?=
 =?utf-8?B?dVpSQ3J2NnRRT2FWSmV4UGJWWFBPVit0MDBJVGRWMnd5S25sdUorZmFTTDli?=
 =?utf-8?B?b3BEaDllOTRwM3B1S2JURjNWdmFpODd0aEgyTTNEM3dQV3p6YnFwMXhTMTZM?=
 =?utf-8?B?bXFxZnM4NTJ4endjTWhKZEF5MS9TYk94cDNUUU0rZE9KOEJ4bTBHdzQyY0xk?=
 =?utf-8?B?S09TTjZYSFA5UDRxcU5nd3p5ZHRFS2lnVGxnM3BLK1Qyc25lNzlqaUh0TkhK?=
 =?utf-8?B?U2ZGalBhMjdMblg0dUNCSytNMXZmY3dvTk56QWpxVi81MjhZcWNiR2hJOHBC?=
 =?utf-8?Q?Li1El1yOLNmEnCjgriq/LQJfv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982fadff-2bf1-42e4-b4bf-08daef8fb918
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 02:42:59.0956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0WD67vCfecExs3ZoTGxBd2f1DAuVWO+glg1sSWyoJTrTyWmaCRLoK1X7UbvAhQeteK/gRC+DJ39zh7TMH4FjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
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

T24gVGh1LCBKYW4gMDUsIDIwMjMgYXQgMTE6NDA6MDBBTSArMDgwMCwgWnFpYW5nIHdyb3RlOg0K
PiBDdXJyZW50bHksIHdoZW4gZmlyc3QgZmluZCBvdXQgdGhlIGV4cGVkaXRlZCBncmFjZSBwZXJp
b2QgaXMgbm90IGVuZCANCj4gYW5kIHRpbWVvdXQgb2NjdXJyZWQsIHdlIHNldCB0aWNrIGRlcGVu
ZGVuY3kgZm9yIENQVXMgdGhhdCBoYXZlIG5vdCANCj4geWV0IHJlcG9ydGVkIHRoZSBxdWllc2Nl
bnQgc3RhdGUgaW4gdGhlIHJjdV9ub2RlIHN0cnVjdHVyZSdzLT5leHBtYXNrIA0KPiBidXQgbmVl
ZCB0byBlbGltaW5hdGUgcmFjZXMgYmV0d2VlbiBzZXQgYW5kIGNsZWFyIHRpY2sgZGVwZW5kZW5j
eSwgDQo+IHNldHRpbmcgQ1BVIHRpY2sgZGVwZW5kZW5jeSBuZWVkIHRvIGhvbGQgcmN1X25vZGUg
c3RydWN0dXJlJ3MtPmxvY2suDQo+IA0KPiBUaGlzIGNvbW1pdCBtb3ZlIHRpY2sgZGVwZW5kZW5j
eSBzZXR0aW5nIGludG8gcmN1X2V4cF9oYW5kbGVyKCksIHNldCANCj4gdGljayBkZXBlbmRlbmN5
IHdoZW4gZmFpbCB0byByZXBvcnQgYSBxdWllc2NlbnQgc3RhdGUgYW5kIGNsZWFyIHRpY2sgDQo+
IGRlcGVuZGVuY3kgaW4gcmN1X3JlcG9ydF9leHBfcmRwKCkuIFtmcm9tIEZyZWRlcmljIFdlaXNi
ZWNrZXIgDQo+IHN1Z2dlc3Rpb25dDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5n
MS56aGFuZ0BpbnRlbC5jb20+DQo+DQo+Rmlyc3QsIGEgYmlnICJ0aGFuayB5b3UiIHRvIHlvdSBh
biBGcmVkZXJpYyBmb3IgaW52ZXN0aWdhdGluZyB0aGlzIGFwcHJvYWNoIQ0KPg0KPlNvIHdoaWNo
IGlzIGJldHRlciwgdGhpcyBwYXRjaCBvciB0aGUgb25lIHRoYXQgSSBhbHJlYWR5IGhhdmUgcXVl
dWVkPw0KPg0KPlRoZSBhZHZhbnRhZ2Ugb2YgdGhlIHBhdGNoIG9mIHlvdXJzIHRoYXQgSSBhbHJl
YWR5IGhhdmUgcXVldWVkIGlzIHRoYXQgQ1BVcyB0aGF0IHJlc3BvbmQgaW4gc29tZSBvdGhlciB3
YXkgd2l0aGluIGEgbWlsbGlzZWNvbmQgZG8gbm90IGdldCBoaXQgd2l0aCBhbiBhZGRpdGlvbmFs
IHNjaGVkdWxpbmctY2xvY2sgaW50ZXJydXB0Lg0KPg0KPk9uIHRoZSBvdGhlciBoYW5kLCBpZiB0
aGUgQ1BVIGdvZXMgdGhyb3VnaCBhIHF1aWVzY2VudCBzdGF0ZSBiZWZvcmUgdGhlIG5leHQgc2No
ZWR1bGluZy1jbG9jayBpbnRlcnJ1cHQgYXJyaXZlcywgcmN1X3JlcG9ydF9leHBfY3B1X211bHQo
KSB3aWxsIHNodXQgZG93biB0aGUgdGljayBiZWZvcmUgaXQgaGFwcGVucy4gIFBsdXMgaWYgdGhl
IENQVSB3YWl0cyBhIGZ1bGwgdGljayBiZWZvcmUgcmVhY2hpbmcgYSBxdWllc2NlbnQgc3RhdGUs
IHRoZW4gdGhlIHRpY2tfZGVwX3NldF9jcHUoKSBjYWxsZWQgZnJvbQ0KPnN5bmNocm9uaXplX3Jj
dV9leHBlZGl0ZWRfd2FpdCgpIGlzIGdvaW5nIHRvIHNlbmQgYWxvbmcgYW4gSVBJIGFueXdheS4N
Cg0KQWdyZWVkLCB0aGlzIG5ldyBwYXRjaCBpcyBzZXQgdGljayBkZXBlbmRlbmN5IGltbWVkaWF0
ZWx5IHdoZW4gd2UgY2FuJ3QgcmVwb3J0IGEgcXVpZXNjZW50IHN0YXRlDQppbiByY3VfZXhwX2hh
bmRsZXIoKSwgdGhpcyBzZWVtcyBhIGxpdHRsZSB0b28gYWdncmVzc2l2ZS4NCg0KDQo+DQo+RXhj
ZXB0IHRoYXQgaW52b2tpbmcgdGlja19kZXBfc2V0X2NwdSgpIG9uIHRoZSBDUFUgaXRzZWxmIHdp
bGwgYWxzbyBkbyBhbiBJUEkgZnJvbSB0aWNrX2RlcF9zZXRfY3B1KCkgYmVjYXVzZSBvZiBJUlFf
V09SS19JTklUX0hBUkQoKSwgcmlnaHQ/DQo+V2hpY2ggbWVhbnMgdGhhdCB0aGUgcGF0Y2ggYmVs
b3cgZ2V0cyB1cyBhbiBleHRyYSBzZWxmLUlQSSwgcmlnaHQ/DQo+T3IgYW0gSSBtaXNyZWFkaW5n
IHRoZSBjb2RlPw0KDQpZZXMsIFRoaXMgbG9va3MgbGlrZSBpdCB3aWxsIHRyaWdnZXIgYW4gYWRk
aXRpb25hbCBJUEkgaW50ZXJydXB0Lg0KDQo+DQo+SW4gYWRkaXRpb24sIGRvZXNuJ3QgdGlja19k
ZXBfY2xlYXJfY3B1KCkganVzdCBjbGVhciBhIGJpdD8gIFdvbid0IHRoYXQgbWVhbiB0aGF0IHRo
ZSBuZXh0IHNjaGVkdWxpbmctY2xvY2sgaW50ZXJydXB0IHdpbGwgaGFwcGVuLCBqdXN0IHRoYXQg
dGhlIG9uZSBhZnRlciB0aGF0IHdvbid0PyAgKEdpdmUgb3IgdGFrZSBrZXJuZWwtdG8tdXNlciBv
ciBrZXJuZWwtdG8taWRsZSB0cmFuc2l0aW9ucyB0aGF0IG1pZ2h0IGhhcHBlbiBpbiB0aGUgbWVh
bnRpbWUuKQ0KDQpZZXMsIHRpY2tfZGVwX2NsZWFyX2NwdSgpIGp1c3Qgb25seSBjbGVhciBhIGJp
dC4gbmV4dCBzY2hlZHVsaW5nLWNsb2NrIGludGVycnVwdCB3aWxsIGhhcHBlbi4NCg0KU28gSSBh
bHNvIHdhbnQgdG8ga25vdyB3aGljaCBvbmUgaXMgYmV0dGVyIPCfmIo/DQoNClRoYW5rcw0KWnFp
YW5nDQoNCj4NCj5BbSBJIG1pc3Npbmcgc29tZXRoaW5nIGluIG15IGF0dGVtcHRzIHRvIG1vZGVs
IHRoZSBjb3N0cz8NCj4NCj4JCQkJCQkJVGhhbngsIFBhdWwNCj4NCj4gLS0tDQo+ICBrZXJuZWwv
cmN1L3RyZWVfZXhwLmggfCA0MyANCj4gKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZV9leHAuaCBiL2tlcm5l
bC9yY3UvdHJlZV9leHAuaCBpbmRleCANCj4gN2NjNDg1NmRhMDgxLi5mMWU5NDc2NzU3MjcgMTAw
NjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZV9leHAuaA0KPiArKysgYi9rZXJuZWwvcmN1L3Ry
ZWVfZXhwLmgNCj4gQEAgLTU4NiwzOSArNTg2LDE2IEBAIHN0YXRpYyBib29sIA0KPiBzeW5jaHJv
bml6ZV9yY3VfZXhwZWRpdGVkX3dhaXRfb25jZShsb25nIHRsaW1pdCkgIHN0YXRpYyB2b2lkIA0K
PiBzeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkX3dhaXQodm9pZCkNCj4gIHsNCj4gIAlpbnQgY3B1
Ow0KPiAtCXVuc2lnbmVkIGxvbmcgajsNCj4gIAl1bnNpZ25lZCBsb25nIGppZmZpZXNfc3RhbGw7
DQo+ICAJdW5zaWduZWQgbG9uZyBqaWZmaWVzX3N0YXJ0Ow0KPiAgCXVuc2lnbmVkIGxvbmcgbWFz
azsNCj4gIAlpbnQgbmRldGVjdGVkOw0KPiAtCXN0cnVjdCByY3VfZGF0YSAqcmRwOw0KPiAgCXN0
cnVjdCByY3Vfbm9kZSAqcm5wOw0KPiAgCXN0cnVjdCByY3Vfbm9kZSAqcm5wX3Jvb3QgPSByY3Vf
Z2V0X3Jvb3QoKTsNCj4gLQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgDQo+ICAJdHJhY2VfcmN1
X2V4cF9ncmFjZV9wZXJpb2QocmN1X3N0YXRlLm5hbWUsIHJjdV9leHBfZ3Bfc2VxX2VuZHZhbCgp
LCBUUFMoInN0YXJ0d2FpdCIpKTsNCj4gIAlqaWZmaWVzX3N0YWxsID0gcmN1X2V4cF9qaWZmaWVz
X3RpbGxfc3RhbGxfY2hlY2soKTsNCj4gIAlqaWZmaWVzX3N0YXJ0ID0gamlmZmllczsNCj4gLQlp
ZiAodGlja19ub2h6X2Z1bGxfZW5hYmxlZCgpICYmIHJjdV9pbmtlcm5lbF9ib290X2hhc19lbmRl
ZCgpKSB7DQo+IC0JCWlmIChzeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkX3dhaXRfb25jZSgxKSkN
Cj4gLQkJCXJldHVybjsNCj4gLQkJcmN1X2Zvcl9lYWNoX2xlYWZfbm9kZShybnApIHsNCj4gLQkJ
CXJhd19zcGluX2xvY2tfaXJxc2F2ZV9yY3Vfbm9kZShybnAsIGZsYWdzKTsNCj4gLQkJCW1hc2sg
PSBSRUFEX09OQ0Uocm5wLT5leHBtYXNrKTsNCj4gLQkJCWZvcl9lYWNoX2xlYWZfbm9kZV9jcHVf
bWFzayhybnAsIGNwdSwgbWFzaykgew0KPiAtCQkJCXJkcCA9IHBlcl9jcHVfcHRyKCZyY3VfZGF0
YSwgY3B1KTsNCj4gLQkJCQlpZiAocmRwLT5yY3VfZm9yY2VkX3RpY2tfZXhwKQ0KPiAtCQkJCQlj
b250aW51ZTsNCj4gLQkJCQlyZHAtPnJjdV9mb3JjZWRfdGlja19leHAgPSB0cnVlOw0KPiAtCQkJ
CWlmIChjcHVfb25saW5lKGNwdSkpDQo+IC0JCQkJCXRpY2tfZGVwX3NldF9jcHUoY3B1LCBUSUNL
X0RFUF9CSVRfUkNVX0VYUCk7DQo+IC0JCQl9DQo+IC0JCQlyYXdfc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZV9yY3Vfbm9kZShybnAsIGZsYWdzKTsNCj4gLQkJfQ0KPiAtCQlqID0gUkVBRF9PTkNFKGpp
ZmZpZXNfdGlsbF9maXJzdF9mcXMpOw0KPiAtCQlpZiAoc3luY2hyb25pemVfcmN1X2V4cGVkaXRl
ZF93YWl0X29uY2UoaiArIEhaKSkNCj4gLQkJCXJldHVybjsNCj4gLQl9DQo+ICANCj4gIAlmb3Ig
KDs7KSB7DQo+ICAJCWlmIChzeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkX3dhaXRfb25jZShqaWZm
aWVzX3N0YWxsKSkNCj4gQEAgLTcyOSw2ICs3MDYsMjQgQEAgc3RhdGljIHZvaWQgcmN1X2V4cF9z
ZWxfd2FpdF93YWtlKHVuc2lnbmVkIGxvbmcgDQo+IHMpDQo+ICANCj4gICNpZmRlZiBDT05GSUdf
UFJFRU1QVF9SQ1UNCj4gIA0KPiArc3RhdGljIHZvaWQgcmN1X2V4cF9zZXRfdGlja2RlcChzdHJ1
Y3QgcmN1X2RhdGEgKnJkcCkgew0KPiArCWludCBjcHUgPSByZHAtPmNwdTsNCj4gKw0KPiArCWlm
ICh0aWNrX25vaHpfZnVsbF9jcHUoY3B1KSAmJiByY3VfaW5rZXJuZWxfYm9vdF9oYXNfZW5kZWQo
KSAmJg0KPiArCQkJCQkJY3B1X29ubGluZShjcHUpKSB7DQo+ICsJCS8qDQo+ICsJCSAqIFRoZSBy
Y3VfZXhwX2hhbmRsZXIoKSBjYW4gYmUgaW52b2tlZCBmcm9tIHN0b3AgbWFjaGluZSwNCj4gKwkJ
ICogYXQgdGhpcyB0aW1lIENQVSBoYXMgZGlzYWJsZWQgYWxsIGludGVycnVwdHMgYW5kIG9mZmxp
bmUsDQo+ICsJCSAqIGluIHdoaWNoIGNhc2UsIHdlIGRvbid0IG5lZWQgcmVxdWV1ZSBJUEkgb3Ig
aXJxIHdvcmsuDQo+ICsJCSAqIHdoaWNoIGlzIG5vdCBhIHByb2JsZW0gc2luY2UgcmN1X3JlcG9y
dF9kZWFkKCkgZG9lcyB0aGUNCj4gKwkJICogUVMgcmVwb3J0Lg0KPiArCQkgKi8NCj4gKwkJcmRw
LT5yY3VfZm9yY2VkX3RpY2tfZXhwID0gdHJ1ZTsNCj4gKwkJdGlja19kZXBfc2V0X2NwdShjcHUs
IFRJQ0tfREVQX0JJVF9SQ1VfRVhQKTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBS
ZW1vdGUgaGFuZGxlciBmb3Igc21wX2NhbGxfZnVuY3Rpb25fc2luZ2xlKCkuICBJZiB0aGVyZSBp
cyBhbg0KPiAgICogUkNVIHJlYWQtc2lkZSBjcml0aWNhbCBzZWN0aW9uIGluIGVmZmVjdCwgcmVx
dWVzdCB0aGF0IHRoZSBAQCANCj4gLTc1Nyw2ICs3NTIsNyBAQCBzdGF0aWMgdm9pZCByY3VfZXhw
X2hhbmRsZXIodm9pZCAqdW51c2VkKQ0KPiAgCQkJV1JJVEVfT05DRShyZHAtPmNwdV9ub19xcy5i
LmV4cCwgdHJ1ZSk7DQo+ICAJCQlzZXRfdHNrX25lZWRfcmVzY2hlZCh0KTsNCj4gIAkJCXNldF9w
cmVlbXB0X25lZWRfcmVzY2hlZCgpOw0KPiArCQkJcmN1X2V4cF9zZXRfdGlja2RlcChyZHApOw0K
PiAgCQl9DQo+ICAJCXJldHVybjsNCj4gIAl9DQo+IEBAIC03NzgsNiArNzc0LDcgQEAgc3RhdGlj
IHZvaWQgcmN1X2V4cF9oYW5kbGVyKHZvaWQgKnVudXNlZCkNCj4gIAkJaWYgKHJucC0+ZXhwbWFz
ayAmIHJkcC0+Z3JwbWFzaykgew0KPiAgCQkJV1JJVEVfT05DRShyZHAtPmNwdV9ub19xcy5iLmV4
cCwgdHJ1ZSk7DQo+ICAJCQl0LT5yY3VfcmVhZF91bmxvY2tfc3BlY2lhbC5iLmV4cF9oaW50ID0g
dHJ1ZTsNCj4gKwkJCXJjdV9leHBfc2V0X3RpY2tkZXAocmRwKTsNCj4gIAkJfQ0KPiAgCQlyYXdf
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZV9yY3Vfbm9kZShybnAsIGZsYWdzKTsNCj4gIAkJcmV0dXJu
Ow0KPiAtLQ0KPiAyLjI1LjENCj4gDQo=
