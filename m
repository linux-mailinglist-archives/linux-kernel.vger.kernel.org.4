Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD2D6B7DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCMQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCMQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:47:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACC725E03;
        Mon, 13 Mar 2023 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678726036; x=1710262036;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w46GUPUWhgps8ZWqGEIEChw9sGpVMrtunCBUCNZ/CHY=;
  b=iF0+z5uuSp3QfR1995hNWA/HDjD5UQnD4XQJeQ8E76EF8P+woxNtDDDk
   JbmtHjeebAQFUJvmYOzi3kIK35VFCX2eBS8sPrSWeXh7RX2bOZZLCLXk/
   heMYuYkR4YiC8G94DZSwQfKJoBKe+YQWdcnZKizlkFN8/Ew/htw8aaNaH
   53s9Wk/GKA632E9d/Wng90+DlThcoKoIDFJ4romPgr8pk9EheY7WMAGx6
   hhhptGUtw5nrD3ceq0ffrJtd7jXEu67fA4yjx4N69tal8VN0pFoyexPSK
   JWNDvcbuXaGjRb9CvFXLRPstrFsVNY2AmHL3X0Ez7VrBFQR3JxyEvdv0X
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="364861626"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="364861626"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 09:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="767769524"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="767769524"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Mar 2023 09:47:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 09:47:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 09:47:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 09:47:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 09:47:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acyomPFNSyllBdM3E54m5iFCs63N39fZXs0UceFDZH1SXjuqFPV1x7Hhj9kPT+2Ogct5YhLqLvPU/L/WOw5gNpu/beZpPA9iiqWa89ce/sHXR0Zgui6z43D+411dxwhbXjEGdD4OfI3bwLTG2N/ngwHJbeit9VbFlxNeVoQ23GcwnyVhADNWGYVfbL5zkQ17TPRWnVN1Vu/MVcZzrSQU7CsMORx99Myei2rxVJDHuVNMpIa8MPWwfFEPnqzVRNCdxt3WKl/H00w7X5M7Fhb9ssGi0lxTZCPU749aupOBN2z2Z8nP8xrbIWXo+aqlWb9dOg0IdvzQ4gO12DvbtBq9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w46GUPUWhgps8ZWqGEIEChw9sGpVMrtunCBUCNZ/CHY=;
 b=UTjgVFHwGyQpeVOndF+rSyMzBcnff2GYFCVw4jxXe/kClk8fplMIAzpXZMCKm+Teo5d/ufH38J006O9l5aTjwEnEQ9GIozkFIo7YRlWsSicSSIgc1i18VCl8ReU5G+VrNpvy5C3kj+K9NMXZy0X9sDJ7y/3MEl24RxCM38pY88iVQUdKER0lXmhGWVfDReHjhtvOrzdaDft5WT+FwVpUnLf/xzJHRTw3nEf47miqO5SmOU8roeghZgmONmtM+jxNLfzUAU/NDmQj2uecplqgMu332kj+RpKIdREHLlM4IUsNNxi/YBg6x5y1mAmV5MWSZqM+Cd2jrv1XahhPl1+uIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 16:47:13 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 16:47:12 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] thermal: core/ACPI: Fix processor cooling device
 regression
Thread-Topic: [PATCH v2 0/4] thermal: core/ACPI: Fix processor cooling device
 regression
Thread-Index: AQHZVbj8FTvJKZhXvkW+gLYgFo6Pa67463eA
Date:   Mon, 13 Mar 2023 16:47:12 +0000
Message-ID: <043b2c3e3024ffaeca69046ae546303ff65694ed.camel@intel.com>
References: <2692681.mvXUDI8C0e@kreacher>
In-Reply-To: <2692681.mvXUDI8C0e@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|DM6PR11MB4531:EE_
x-ms-office365-filtering-correlation-id: a74df8a6-d049-4e48-0786-08db23e2983a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gVfzxrJ4rXIAqxdUhqyyErcHGlMHF4JlX6d6caaM9yYq8ZpqiAIKASfhHE8G1JgUNqho/De4gejWvpUdyc34MRMsa4a2avAXH106rx0gKWP3/YQvJk+OhUjpxiUtjY0ogpyktcsxku5Th5J/ekzov2mkV3lkLksn/7/gbJxD1VLDik7dLvoMKdCqVRUzzvOu6B4Z7TF7P1M15l7QhEpHYUn/pxs9k08ZzYb5EhbJqm4V8WAlBrN93768qgLugSGWbEEVGpqRR09a/G6DFAm9VArPGS6gu2HZ7J/cP2blfZAkvQm4aru6l1IlO6SMo909U8/sRdfpWQNk2GM4nYpL9MyF1kfkWkNo/584eVzZqHg7CspjXa7GPBva3ddiFKpl0G9Q33+im1uIjYoUKe/EbjJ8bGVEcbPPEz+i2sR5BPB9aj0dLw2D1Jl+RHmSelNjCb9fz2tzQlefY/CTm3zYScDErE6qVb3ijwmJBI7SCvBpALTJ9azWhzD7nZLy+A/iRYf+JEjYUOqmxf8fnHYdo0QyDVAGOBGgKhYS9lApj6sCw5UcvcPzt9i/L650E+C/SslydwpUgfj6rBriQfq5cZUq+uF6hxtR0l3nOvReGoCQuIeT12UhLRluf4UruatXM9z1S8cJjx4z2hyowHAtBF2aLJiOvf1X7SXNidqAfgMIPKP2AwdednE44/nmoIEFhr5gZCgSM4NvFFaZP9b0WZ+zMEV/EPpffva+Pdeplh4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199018)(36756003)(86362001)(26005)(186003)(41300700001)(6506007)(6512007)(5660300002)(4326008)(2616005)(8936002)(54906003)(71200400001)(316002)(478600001)(91956017)(66446008)(8676002)(966005)(66556008)(64756008)(76116006)(66476007)(110136005)(66946007)(6486002)(122000001)(82960400001)(38070700005)(38100700002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWVaQlFKcE9IdWx6MG9DaEFJbEdUcVptcGcrS2orUStpa3h1Y3pIK1c4SDhs?=
 =?utf-8?B?YkEycFRjcWNDcGVCSDVDNTdyYWdXNlNtWjZSMVVlTkphdjQycUpjOUpxZlVo?=
 =?utf-8?B?eFBTL0w1V0pJanZuQ0lKSnI1ZXdjU09lM3pQVVlPRXpsTVoyUXZCeUN6Zk04?=
 =?utf-8?B?OG16TEt0NzVoVEhIbGVlOFNVMTkyNlBDeE82a1NQNUVxKzA1NzlGLythT1g4?=
 =?utf-8?B?UkFiUmhRTjdrWDdCeDlqRWw1QzkzOS92OGdnZEdtdW91TCt0MEpzU0l3c1RS?=
 =?utf-8?B?aFlTYmpyM0krZGNaUzFOMkJISlc2YmJTbyswcnhla21ocDdiSXU3SFl1WmQx?=
 =?utf-8?B?ZzdQOFNYS1B1QWlYK3ZHV1lZdWhZOXJmcUJNRHpyNGRzNlVJN3ROOWtsem9F?=
 =?utf-8?B?cTNXaEhKdHpwM1VTVEtIRWdiaVFGNzNudE5NR0VHM3lCZWdsa2xDWXB4S2J6?=
 =?utf-8?B?b3NjYm1LUWhudDFIM1hhb0VmalMvb2hmNWxlT2srK1RNUml2K2dyNkk0OVJw?=
 =?utf-8?B?dmtFdWEzRzA2dHhtalBhVnRhZllQa3ZxVnE2Y08vYTZtN2lOOUhUU2VvblJx?=
 =?utf-8?B?K2hYRzBMSXIrSmdqb2cvNmlYbGdRTWlrUEszbnNvUlFQMlZqbVZiZzRWcitZ?=
 =?utf-8?B?V3llV3hHNDcwb3poY3h4UTZ0SGt4VndHa3BJaG9qM0gwbllzeklOZXdmMXdJ?=
 =?utf-8?B?bzJHTE0wd2xiT1RzeThyWmRvQjM5dHNOSmNpNDJ3NnJTbHBGdUY2WktONzBO?=
 =?utf-8?B?bllBaGFkZ00xbEQ0NHQzVC9IeG5pVTA3Tmh1bWU2K2xQdVRnUWJHditIQzQ5?=
 =?utf-8?B?OEg4ajBjZlFteVc5UzN1NUFnVVFtSUJVV1VXTWVYclRubTAwN0RzNDc4djNl?=
 =?utf-8?B?aDJoWmF5L1Erczc4NHZkbER0bDJqY3JjNE1jaStJNWtNQk5GcE13ZldLbFZM?=
 =?utf-8?B?Uks3ZStTclQwa1gwSHZrZHJEand1dHlEREx5dS9pUlg3RitjM1haMG5sTUVj?=
 =?utf-8?B?cmd1SEJXd25JcTBnNnc4S29lWi9KbkxqZjZjODVoTW5UZUZWNUlxUWcrYXFV?=
 =?utf-8?B?ZlJ3SHdLNVU1SWJ2TnlzOTVSNGowNWx2V3hUSElvOXhGOU5IM05SY2J2UjA3?=
 =?utf-8?B?VmxpdXEvWGw2NXhrWUVpMTdxWEEzQzVYUStqQUoySkhmcFdiNDJJWkdDTm14?=
 =?utf-8?B?WWZDODBtWUtQSjZzUnU1UmZDRlJkYkRCcFhXaEU0QVkrcEVuemt4V0h6ZmQw?=
 =?utf-8?B?VXkyNEhWU1RFL2k5V3FKSzdjd0JHaGJDeVE5U0o3a2VJQVl0QjNZSnhqQ3hs?=
 =?utf-8?B?UndlNEF2L05CZ3hqSklpZkxMTEZUY1FDckxvV2FJcXFUamhkdDVjY0Z1Z01p?=
 =?utf-8?B?WldGZmxZamtnS0hQODZyNWVhVlcxcXVSSUJsZE8ybUt2dVVndHk0MWNhV3dD?=
 =?utf-8?B?Ymc4cVN2anJZMzQ1RUlFUk5GRlRycURZVDhhanZ3Q09NTmNTaFYwQ3doYyta?=
 =?utf-8?B?VGJmM3M1b3BSNEJuYVBFYUpmUmFzNXNyVHk2amR0S1F2ZDdzdkc1Tys4T1V1?=
 =?utf-8?B?eGo2N3I5Nmw4cFdISjFtTm9Jc0I5ekM0NXVSSHhxSTFHZmRKVTczaEhTc1pj?=
 =?utf-8?B?aFdGZUJMNUp2TUZ4elZWLzR0K1FtVnE2RTYzUVpmbnRhU1RSL3dpc2NwQnVV?=
 =?utf-8?B?STZEbTZXVjg3THJWUDg1cE1SVmNsUm1KM2RiL1hJYlFRNFJ3YnRxVktpemp2?=
 =?utf-8?B?czlSNWZJVXZhdlpHaVdmZmJ0OHZpb0Q1WGpRYit3T0dCZGtLRDAzQ2EzQUta?=
 =?utf-8?B?L0tnSWEwcE1BS0NKQ3MxdW05a1NhQXdQOVU0REw1ZWhsNTBWZ2t0TndRSXFD?=
 =?utf-8?B?VUJia25PQXBVYzAwbGJxdHoxdWFzeFlPaXI4Q2pXSURUVi9rTHV2QjRRVExX?=
 =?utf-8?B?MWtGNEJ4NzJUeFRGQms5ajFYNm52U0xGWWZTTkxXTjZkZEI3WmF5VW52YWM1?=
 =?utf-8?B?ZHQxZzVpYTRxRVZNd1ViMWFKOHZrMHpjZXdCcWlkbEhuNGNFZjlnZXg1bnZL?=
 =?utf-8?B?aGN1eXc3S2dRRnMrSkFLSDcreDVEN1BxTWdUdnRINmZBelRNMTdhdlVSMEhC?=
 =?utf-8?Q?fo8/FoszvgFsqRvnpr3/FhmAs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37AD62EA7E7F6449B27BBAE5524F0BBF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74df8a6-d049-4e48-0786-08db23e2983a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 16:47:12.6109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIpu/9yvp95t77GrFyKON19F+ZJqs0bhyoZ2PpWWvqahDLeV8lul7aWHsK4JuzQdAugx/nhez5lLmcj/i7B74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
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

SGksIFJhZmFlbCwNCg0KVGhlIG9ubHkgY29uY2VybiB0byBtZSBpcyB0aGF0LCBpbiB0aGVybWFs
X2Nvb2xpbmdfZGV2aWNlX3VwZGF0ZSgpLCB3ZQ0Kc2hvdWxkIGhhbmRsZSB0aGUgY2FzZXMgdGhh
dCB0aGUgY29vbGluZyBkZXZpY2UgaXMgY3VycmVudCB1c2VkIGJ5DQpvbmUvbW9yZSB0aGVybWFs
IHpvbmUuIHNheSwgc29tZXRoaW5nIGxpa2UNCg0KbGlzdF9mb3JfZWFjaF9lbnRyeShwb3MsICZj
ZGV2LT50aGVybWFsX2luc3RhbmNlcywgY2Rldl9ub2RlKSB7DQoJLyogZS5nLiB3aGF0IHRvIGRv
IGlmIHR6MSBzZXQgaXQgdG8gc3RhdGUgMSBwcmV2aW91c2x5ICovDQp9DQpJIGhhdmUgbm90IGdv
dCBhIGNsZWFyIGlkZWEgd2hhdCB3ZSBzaG91bGQgZG8gaGVyZS4NCg0KQnV0IGdpdmVuIHRoYXQg
SSBoYXZlIGNvbmZpcm1lZCB0aGF0IHRoaXMgcGF0Y2ggc2VyaWVzIGZpeGVzIHRoZQ0Kb3JpZ2lu
YWwgcHJvYmxlbSwgYW5kIHRoZSBBQ1BJIHBhc3NpdmUgY29vbGluZyBpcyB1bmxpa2VseSB0byBi
ZQ0KdHJpZ2dlcmVkIGJlZm9yZSBDUFVGUkVRX0NSRUFURV9QT0xJQ1kgbm90aWZpY2F0aW9uLCBw
cm9iYWJseSB3ZSBjYW4NCmFkZHJlc3MgdGhhdCBwcm9ibGVtIGxhdGVyLg0KDQpUZXN0ZWQtYnk6
IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NClJldmlld2VkLWJ5OiBaaGFuZyBSdWkg
PHJ1aS56aGFuZ0BpbnRlbC5jb20+DQoNCnRoYW5rcywNCnJ1aQ0KDQpPbiBNb24sIDIwMjMtMDMt
MTMgYXQgMTU6MjQgKzAxMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBIaSBBbGwsDQo+
IA0KPiBUaGUgZmlyc3QgcmV2aXNpb24gb2YgdGhpcyBwYXRjaCBzZXJpZXMgd2FzIHBvc3RlZCBh
cw0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcG0vMjE0ODkwNy5pcmRiZ3lw
YVU2QGtyZWFjaGVyLw0KPiANCj4gQXMgcmVwb3J0ZWQgYnkgUnVpIGluIHRoaXMgdGhyZWFkOg0K
PiANCj4gTGluazogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBtLzUzZWMxZjA2
ZjYxYzk4NDEwMDg2ODkyNmYyODI2NDdlNTdlY2ZiMmQuY2FtZWxAaW50ZWwuY29tLw0KPiANCj4g
c29tZSByZWNlbnQgY2hhbmdlcyBpbiB0aGUgdGhlcm1hbCBjb3JlIGNhdXNlIHRoZSBDUFUgY29v
bGluZyBkZXZpY2VzDQo+IHJlZ2lzdGVyZWQgYnkgdGhlIEFDUEkgcHJvY2Vzc29yIGRyaXZlciB0
byBiZWNvbWUgdW51c2FibGUgaW4gc29tZQ0KPiBjYXNlcw0KPiBhbmQgc29tZXdoYXQgY3JpcHBs
ZWQgaW4gZ2VuZXJhbC4NCj4gDQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIEFDUEkgcHJvY2Vz
c29yIGRyaXZlciBjaGFuZ2VzIGl0cw0KPiAtPmdldF9tYXhfc3RhdGUoKQ0KPiBjYWxsYmFjayBy
ZXR1cm4gdmFsdWUgZGVwZW5kaW5nIG9uIHdoZXRoZXIgb3Igbm90IGNwdWZyZXEgaXMNCj4gYXZh
aWxhYmxlIGFuZA0KPiB0aGVyZSBpcyBhIGNwdWZyZXEgcG9saWN5IGZvciBhIGdpdmVuIENQVS4g
IEhvd2V2ZXIsIHRoZSB0aGVybWFsIGNvcmUNCj4gaGFzDQo+IGFsd2F5cyBhc3N1bWVkIHRoYXQg
dGhlIHJldHVybiB2YWx1ZSBvZiB0aGF0IGNhbGxiYWNrIHdpbGwgbm90DQo+IGNoYW5nZSwgd2hp
Y2gNCj4gaW4gZmFjdCBpcyByZWxpZWQgb24gYnkgdGhlIGNvb2xpbmcgZGV2aWNlIHN0YXRpc3Rp
Y3MgY29kZS4gIEluDQo+IHBhcnRpY3VsYXIsDQo+IHdoZW4gdGhlIC0+Z2V0X21heF9zdGF0ZSgp
IGdyb3dzLCB0aGUgbWVtb3J5IGJ1ZmZlciBhbGxvY2F0ZWQgZm9yDQo+IHN0b3JpbmcgdGhlDQo+
IHN0YXRpc3RpY3Mgd2lsbCBiZSB0b28gc21hbGwgYW5kIGNvcnJ1cHRpb24gbWF5IGVuc3VlIGFz
IGEgcmVzdWx0Lg0KPiANCj4gRm9yIHRoaXMgcmVhc29uLCB0aGUgaXNzdWUgbmVlZHMgdG8gYmUg
YWRkcmVzc2VkIGluIHRoZSBBQ1BJDQo+IHByb2Nlc3NvciBkcml2ZXINCj4gYW5kIG5vdCBpbiB0
aGUgdGhlcm1hbCBjb3JlLCBidXQgdGhlIGNvcmUgbmVlZHMgdG8gaGVscCBzb21ld2hhdA0KPiB0
b28uICBOYW1lbHksDQo+IGl0IG5lZWRzIHRvIHByb3ZpZGUgYSBoZWxwZXIgYWxsb3dpbmcgYW4g
aW50ZXJlc3RlZCBkcml2ZXIgdG8gdXBkYXRlDQo+IHRoZQ0KPiBtYXhfc3RhdGUgdmFsdWUgZm9y
IGFuIGFscmVhZHkgcmVnaXN0ZXJlZCBjb29saW5nIGRldmljZSBpbiBjZXJ0YWluDQo+IHNpdHVh
dGlvbnMNCj4gd2hpY2ggd2lsbCBhbHNvIGNhdXNlIHRoZSBzdGF0aXN0aWNzIHRvIGJlIHJlYnVp
bHQuDQo+IA0KPiBUaGlzIHNlcmllcyBpbXBsZW1lbnRzIHRoZSBhYm92ZSBhbmQgZm9yIGRldGFp
bHMgcGxlYXNlIHJlZmVyIHRvIHRoZQ0KPiBpbmRpdmlkdWFsDQo+IHBhdGNoIGNoYWdlbG9ncy4N
Cj4gDQo+IFRoYW5rcyENCj4gDQo+IA0KPiANCg==
