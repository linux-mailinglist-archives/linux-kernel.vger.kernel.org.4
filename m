Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA3868E922
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjBHHiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBHHh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:37:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF874ED0;
        Tue,  7 Feb 2023 23:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675841846; x=1707377846;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kvH4n4c8q9G9NYKRKS9FVbyKRgPm/IAQHjXvwOYOKrc=;
  b=H/C8wkTWPeZbKaF8Ln6ItVZaWV0uLT46uleOHIPagaQ1Vc63ytGN/QKB
   HqoeaMXjJ0djRuELzUQwDD3aWW/ixSbKxmB93Ulx/1NSMB+Kh3ObVSNNo
   zgKjUUXAUspHdGgM8SvfvQwtQVIIPmdCw8yrfSKQtR/QKOFeUA1XEzWdj
   2AoHABbSwCNikaajp0DingfAXBTlqTesnEvWdElcW3Dko+X+gsVX+OAkd
   BLqDTWrE39OomboyQ5Gs1DlWeFrzrMKEwMfCgKZHDjnXrRE8sF4qZWPJS
   PIE3MBqzFCFVJIxrwk5vPsZFPcHiTeTyBRfb6O+HybeVM6sxwst1tntup
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331865094"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="331865094"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 23:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="775905935"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="775905935"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 07 Feb 2023 23:37:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 23:37:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 23:37:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 23:37:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 23:37:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4jcM7KcEcMoj+Qs/Q3nSU7TRWW8xIC+pWINkk79SIKyiOX7hJYtg/GvgvcOy0o9URXNRdkJlw+sYZrB+ndCnnYdf2U+CDtXw3BXB/0SnX7HAYOK3q9O5A36RG8v6IgTJsUFv7D9LqgUiiq9qUvmiKbQX1Yd0jDc8jeABCQancvlql+0CIth9mV4xmBun371xCUw668dTYZBTrvVHBhOFlvtPt7JCJ0iJ46DJdK3hqkeHZMQ2aaFJMdEzxDEuxjL+3Xz3WnsGzBh91/XgPCsIBSMzgckedo6sFDX44yNo2hX5oRc1dAbo5YG0o6Rqafis+xiN71ajGo9oxXYxXl8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvH4n4c8q9G9NYKRKS9FVbyKRgPm/IAQHjXvwOYOKrc=;
 b=aCDaBUZsW/AwRGTub2SYqZeOcaOnkIVKAx+4K3FNJc22z/BIbgvBDVD/e22zbfqZkJle4RtyCJtv3mgG1mJ6DHCZYpLir/BN0vWsbiAJ9Os4ifD/dRVhTQmUT2DOXylSaCFuDy0VWm4hlcXdX5GeQE7BEG81eJqU7BcVloQQRXuwfKtYB3yiN+g7Tmxaz7lDQ638YzdE1uQYHbXe2uFFOXbZsr+5LDaqhVoAUNhbOJ6BeIRXpQzx/b1w2HgekxraYRKpQKEsPm0NLAXB9WNi9I5PSs4hs/paWgVWpJcCpyCdF7sEu5biYAth3meXtGne4Xf6ywAuXLtoustl5+IFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 07:37:05 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 07:37:04 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] intel_powerclamp: New module parameter
Thread-Topic: [PATCH v3 0/2] intel_powerclamp: New module parameter
Thread-Index: AQHZOxosHIfaJG4CoEegtKy38Om3va7EqhAA
Date:   Wed, 8 Feb 2023 07:37:04 +0000
Message-ID: <15d47ea973c3ac46d68352bef2786faea9bd405d.camel@intel.com>
References: <20230207173219.4190013-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230207173219.4190013-1-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB6408:EE_
x-ms-office365-filtering-correlation-id: 7e4028b0-44be-4cb8-c570-08db09a74644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /W33LkE+DfpnbC7qMYSkfOQPDrhBR1rCG0+R3FLxRh7C9ZPJ7vMO3UPE+Z2ulI1JmM/r5aeQiwYiVRztbRfSO0dp+wzI1dGXLaa9IdLBhZ4rTkh0+xZAHrWjQpMV5Y6SLPFoQMi7nrViXXptojPq/Ns2B/GYi4KvKX5zjezPcrpLfNGQn4Fx+LWYwYcpLqsl3xW2vvF6uBMHB/s6LIQvjPA4nnaOlQrGKhLIsxY++5YK0MtT8UQy8lD/uwZpGvyma+0o1LbRHooKnqxijoKTPVnWw7gv0bJTxsuyjRYRMBMQCEChGjfqrkHtKU+Bwl9fPtqrxbxE4e4h+CM7IXE5tz16fw5rkA3XPUHwmQJABsh50bTDm2tBq3SahiwnjdKODHvt8vOjEzm6nJIH8sjecG7GoY8DvLH4Mk3TenzzrlxcSs+h+Az40qdJvFP/Ps5c9p1eklFujeXtNukgC2fVRLwjUMEUMiLnyJeE19+XoaOKB4eIrFmzAl3NJSfr24mWcoPaljy8O/0Dn36kfwUDRqw3KF7QQ4dmInWwWYdOCPQPTOS1zmaKP7GeK2ubkX5FBaQNdpvHGZuMYXM0HI50I32mVcCitYna5gsEQN5R1f3TzoGeb1uF+PXBfKiVqz9m2wszNMN6VofzdRcLoNRfYG2fp0/FJIIXfMpHKkP7ry0LBXMlM59jIQKxa5kDWno4RDso0W7rKVvys8B57zMHxcGjbpYvxrAccF4DcuM9fY0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199018)(38100700002)(82960400001)(91956017)(122000001)(316002)(38070700005)(66946007)(66556008)(66476007)(66446008)(64756008)(8936002)(4326008)(41300700001)(8676002)(2906002)(5660300002)(76116006)(2616005)(6506007)(6486002)(966005)(478600001)(26005)(6512007)(186003)(110136005)(86362001)(83380400001)(54906003)(71200400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlhkUDFWNlNXVm9yWEVYUWdTSmpFcEJtMFAyM0JNUW16bzRYQnJGVndzWkdu?=
 =?utf-8?B?VWhIQlBOcTJtTmdpL2FtSDcwVXRmMWV5NllBbTk5VmErbitzeUw2NXJ1RnVs?=
 =?utf-8?B?eUl2TG1aWmlSYXNtZkNWcGdOZlgrWnNzWUhMc1VmemtDelB1cHY0WFhGSjYy?=
 =?utf-8?B?QldaRHJGaHFibDJwZ3ppOTZRdlFqZzlIKzRWWUpxNEVOVXVmM2owekp2U05S?=
 =?utf-8?B?RHlIeUluWVF1Zk9WaWd0dk8wcFlKeG5LajQwdlRkZDY1VEVYNEZlM0VESVNF?=
 =?utf-8?B?U2lLdkdobHF1ejRIUEt1THBJTktOMVFnOXorbWk1WE5EN0RDYUh1UnZ6OTJw?=
 =?utf-8?B?cDJ4b1JIaG95c1c3cmxUY3puMVhDU0VUNTVFcGdta2s5RnFmWjFJck14THg5?=
 =?utf-8?B?Z3MxV2Q4amRDRStuM01vU1UvbHpsVHFIWnozQUJ3RW4yczNCVlhlT20yNWlk?=
 =?utf-8?B?NUpwa3dSNlNJUmNpUHM1RkRVaWl0eEdhaEVWRS9HWmQrYTljbUNUa2tUaUxB?=
 =?utf-8?B?QW5mUzJ6cnFOa2dUUUdZcDJ0MzRXKzY0b1hodG9EWGpseDlIZzF2dDU5RnEz?=
 =?utf-8?B?djVoZ010TTB2cE5sdlQ3RVFVNkYyaGVxVHg4Z29UYWRSNmxTNWxuYjFOWFBG?=
 =?utf-8?B?azZlQm5hNnJ6LzN1MGg1QVZma1pmSzJFaC8zSU9jSFFJZnJLdmRoQW51SDdN?=
 =?utf-8?B?VFhnWFVOcDRmcFpCRVJUU2tWTmN6bXU5NFhqV0JLZ0dnZTdxejQ1Nmc0L2c3?=
 =?utf-8?B?RWQ2UmR1STJWK1dSQVFQS2huay9uM2tzbEVtRC9XUVBIbFo1K1NLSGhQcDd5?=
 =?utf-8?B?VzM3eS84eGhUZU5XdGs5cUJFSWk1V1JwcDBhV2dvemdXbUpERk10QjJjNS95?=
 =?utf-8?B?MVlGazNHNCtDZm82YkZJL0Y2SGJHQ1BHQ0hjOGtuUmUvamZVcHZ1dUZNaDRW?=
 =?utf-8?B?am0ra1BkUXVRUDFNY0VjNHdPNmFzRmRETllKVnlPdFV2T2YvMzhIcFIzRGRi?=
 =?utf-8?B?R1dGV0p3bXZUdmhtUmhkTHFWMnQzd1ZwN3NLbzJXbjgwaS9LMEJJTGlIZFlt?=
 =?utf-8?B?WE8xdlFIZXZXN0NwRUtZODc1TjRxQUR5ME1ydnhmL0NqRFhIUXRqVHhwMDZ1?=
 =?utf-8?B?eGc0MjhGQnRIamh4dDM0ZGpGVE56ajRCWkgwakZaeG11bDlldUNMY0daU0lv?=
 =?utf-8?B?VFk5ckQ4c3RndVVyWGFuckp3ZGVkN2dya1lqQkFiNDY2Q3paOFY5dkxLQmM0?=
 =?utf-8?B?bllzSGNPakIxR2xjZWJJUlZ3MEp2TEFqcVV3RlgvTlZ1VzN0U0dGQUx6MFhH?=
 =?utf-8?B?bDVGUmUyK1Zxb3NJR00raldDYkVQYkU2NVgyQXNPc2dTOXY1c2dEZ3B2MW95?=
 =?utf-8?B?OFAvT3hOQWQzaTlORkxUQWFzbWlnR1FDSEthbWEyTGN0eDBpNkdHOVVwNVhO?=
 =?utf-8?B?TTlBekI0VVZBb3IxVUtpcDVIQTFvRkpjeWpYY1I4djVxSDNJTFBGWVJCQWhV?=
 =?utf-8?B?S0dnb3F6aVZNRlFEV3pLZ1oxZDJOOXg4Ry9pMkNtcFJFM1hQbWNpT0I4bVJk?=
 =?utf-8?B?Mk1wWjVuN0RsdE0yYStkT0lpMEVuZFVMZXlPV2hsenM5RXV5TmFCcnBYNjVK?=
 =?utf-8?B?L3JuclZqSFFCQkRuUW9UcnpwS2RqU0RERHUrWjlTY3MzWkJyOFNvb3piN295?=
 =?utf-8?B?eUwxbVNBVGZjK1plTFBhVzh5c0o2aTdhcTN4REs0OFpPSnF1VHhHNC80Nk1E?=
 =?utf-8?B?M3NaZ3JTY0tDYzhqd2k5aFhvNU5tazlJZnlxaWd3WmZNZEJmdmtyajhkVDUv?=
 =?utf-8?B?eEIwM0g3amMwNHUxUXlTY1BzaVNuRDlDekNGYWZFTE1KU1o3R2x2blAyb1pL?=
 =?utf-8?B?VytUeS9Eb2lweHpnQ3dWTGc4bm5aSSsyU1pycWpmclhoY3JaL3NVRkcza0Zw?=
 =?utf-8?B?a3d2T2VIQjkwalNRN2lwMktoNDAyUVJoSFQ0TkFPSjZzRWh6bmc5SW1GMVpJ?=
 =?utf-8?B?SUZ6RnB3MEk0cXYrMUhFUXFGVG53YlNlejkwNWlTZHhyMUN0WE9hekdZUzNO?=
 =?utf-8?B?MVgwNjE4alVsN1lRL2dCQzI2QkJXNHRUUG5jbStRMUJpc1Nia2NWdytybUxh?=
 =?utf-8?Q?80mYOijqZaPbr0FIWTthqjPix?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0971322B8C847048897BF543759063FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4028b0-44be-4cb8-c570-08db09a74644
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 07:37:04.5533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixFJPxxsuoeMhw16rB1lRDeeDmIAVv+zIgghoRGy8JxL1n3ARg2CbkqLHl4FwlsJmGRYOJA0SBnUodyDdLmFjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTA3IGF0IDA5OjMyIC0wODAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOg0KPiBTcGxpdCBmcm9tIHRoZSBzZXJpZXMgZm9yIHBvd2VyY2xhbXAgdXNlciBvZiBwb3dl
cmNhcCBpZGxlLWluamVjdA0KPiBzZXJpZXM6DQo+IFVzZSBpZGxlX2luamVjdCBmcmFtZXdvcmsg
Zm9yIGludGVsX3Bvd2VyY2xhbXAgdmVyc2lvbiB2NS4NCj4gDQo+IA0KPiB2MzoNCj4gbWlub3Ig
ZG9jdW1lbnQgY2hhbmdlDQoNCkkgaGF2ZSB0ZXN0ZWQgdGhlIFYyIHZlcnNpb24gb2YgdGhpcyBw
YXRjaCBzZXJpZXMgKyB0aGUgd2hvbGUgc2VyaWVzIG9mDQpSaWNoYXJkbydzIHNjaGVkdWxlciBm
aXhlcyBmcm9tDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwMjA3MDQ1ODM4LjEx
MjQzLTEtcmljYXJkby5uZXJpLWNhbGRlcm9uQGxpbnV4LmludGVsLmNvbS8NCg0KVGhlIHByZXZp
b3VzIHNjaGVkdWxlciBwcm9ibGVtIGlzIGdvbmUgYW5kIGlkbGUgaW5qZWN0aW9uIHdpdGggYQ0K
Y3B1bWFzayB3b3JrcyB3ZWxsLg0KDQpHaXZlIHRoYXQgd2Ugb25seSBoYXZlIGRvY3VtZW50IGNo
YW5nZSBpbiBWMywNCg0KVGVzdGVkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+
DQoNCnRoYW5rcywNCnJ1aQ0KDQo+IA0KPiB2Mg0KPiAtIEJ1aWxkIHdhcm5pbmdzIHJlcG9ydGVk
IGJ5IFJ1aQ0KPiAtIE1vdmVkIHRoZSBwb3dlcmNsYW1wIGRvY3VtZW50YXRpb24gdG8gYWRtaW4g
Z3VpZGUgZm9sZGVyDQo+IC0gQ29tbWl0IGxvZyB1cGRhdGVkIGFzIHN1Z2dlc3RlZCBieSBSYWZh
ZWwgYW5kIG90aGVyIGNvZGUgc3VnZ2VzdGlvbg0KPiANCj4gU3Jpbml2YXMgUGFuZHJ1dmFkYSAo
Mik6DQo+ICAgRG9jdW1lbnRhdGlvbjphZG1pbi1ndWlkZTogTW92ZSBpbnRlbF9wb3dlcmNsYW1w
IGRvY3VtZW50YXRpb24NCj4gICB0aGVybWFsL2RyaXZlcnMvaW50ZWxfcG93ZXJjbGFtcDogQWRk
IHR3byBtb2R1bGUgcGFyYW1ldGVycw0KPiANCj4gIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUv
aW5kZXgucnN0ICAgICAgICAgICB8ICAgMSArDQo+ICAuLi4vdGhlcm1hbC9pbnRlbF9wb3dlcmNs
YW1wLnJzdCAgICAgICAgICAgICAgfCAgMjIgKysrDQo+ICBEb2N1bWVudGF0aW9uL2RyaXZlci1h
cGkvdGhlcm1hbC9pbmRleC5yc3QgICAgfCAgIDEgLQ0KPiAgTUFJTlRBSU5FUlMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gIGRyaXZlcnMvdGhlcm1hbC9pbnRl
bC9pbnRlbF9wb3dlcmNsYW1wLmMgICAgICB8IDE3NyArKysrKysrKysrKysrKystDQo+IC0tDQo+
ICA1IGZpbGVzIGNoYW5nZWQsIDE4MCBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4g
IHJlbmFtZSBEb2N1bWVudGF0aW9uL3tkcml2ZXItYXBpID0+IGFkbWluLQ0KPiBndWlkZX0vdGhl
cm1hbC9pbnRlbF9wb3dlcmNsYW1wLnJzdCAoOTMlKQ0KPiANCg==
