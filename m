Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DD6A2760
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 06:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBYFei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 00:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYFeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 00:34:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88198144B2;
        Fri, 24 Feb 2023 21:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677303272; x=1708839272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2jLlhB591QlmCxDAOFMefyZx2uuyNRtDpl5zhvoOf5U=;
  b=Cxk3Du+533tFxDZDDtiXTWGcBY5pNo3bPAv1/I3zga/x3snI5f1GzoEi
   WPu/01iYv4hkqZoEZOG7YEGkWt7tBgAzOLiZCbC9gz3fG1aIlYUzUcbaF
   7V3cjZMdPq7XD+5AnO2lRX733zHue7yBSJ1O+9nCMvdHWvxJshDfjQ1gT
   ggaGmGjEjb2G7X0O8sDcmxQYof3lLNrcOH4CcYtTh2JeDeIK11rYjJ6Jr
   sBdiQva0BM7AZKefYs50LkrIfaMcv1xaOOaOelIe8x4eQGWIGLubKKwG5
   0pFcIKKB9cJyMfbrje6cug223DRwUWA1v1KbIqDUAo5MlZkUEG2unVnh/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="333641396"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="333641396"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 21:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="1002062838"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="1002062838"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 24 Feb 2023 21:34:31 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 21:34:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 21:34:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 24 Feb 2023 21:34:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 24 Feb 2023 21:34:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMs5aDb8Ej5dV/4vW9RQOo2UuBlLKprRZFAL39tLZQ8Em9TsqCkPxg3a/EHSi1bVZMwFhREI/X4pr7YwKZgQePk9Pqh8+yzDvzur8+ZS83msLeo5xM94+Sahx8+rL4lKXrmFMpYnGhLh5/wkNnQIujrVOMexb4iUFR71MocQXr+BcY7zofnZLlvIWJ8ei6r9Ae7/oNX8j2yvxNRJGUqz/NpkvQ6+iKQv6g56MMWi/w0FTOeyA/K3D/bngWBd2mtDtJ7l9zKzMj2aR7iqMjGE0C8sSDkNUpMJlgo8Ve4QUaD6t8C/k+ldZGXm3PHxOnRLYHq9bet2PK3qt+/AG9GssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jLlhB591QlmCxDAOFMefyZx2uuyNRtDpl5zhvoOf5U=;
 b=dlkKcior3+tA7Y2aNvd2gFzf9TtkEXHIow8MV5m1OsZpshh0yz/fGxkgX4olm2HjaVuqbmYAJUk6Bdt8lgHXHnQLkzoo34KS1adTLy5EhjJXx8WP4I5PbuwR3C3/58DWJ2EH4K461lk8yD+heVFtfLZ1GDDJy+C3O47Stk7vATZMLcbADjdkrzybYoiLOrMcAAeDdebuKtoAkYUP6pYYdOeFqLa9tHro6GSKsxKAb+TvGWp6U2esskD8Q+yfj3RxXR66TQEg5eyYs5slC0DpYFHfPWvVT/Dv/2LNktELzwMyOoyvjgcqxQ6dMUWWRVpygzIuzgTWDJoYYtRzUqbfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH0PR11MB5378.namprd11.prod.outlook.com (2603:10b6:610:b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sat, 25 Feb
 2023 05:34:29 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%9]) with mapi id 15.20.6134.024; Sat, 25 Feb 2023
 05:34:28 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] cached max_state breaks ACPI processor cooling
 device
Thread-Topic: [Regression] cached max_state breaks ACPI processor cooling
 device
Thread-Index: AQHZSNo0olfs8HoYakCXdglc2MjI0q7fI/EA
Date:   Sat, 25 Feb 2023 05:34:28 +0000
Message-ID: <1d21b45a453518cfbabd827d46c14bd7ce9ef9d7.camel@intel.com>
References: <53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com>
In-Reply-To: <53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH0PR11MB5378:EE_
x-ms-office365-filtering-correlation-id: 5f9177f9-c7b3-45db-669e-08db16f1f691
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WC1xfuE34ObcNk3IKeByWMp+UiB/H3hmOffLhBa97Amv4CRxX+r3cQyGryTq3/EZCkXAvyOPdewVuJRJON/0LB+C6gh2r7n54d7XDSm7KTPxvaNC8zE19mII3zmFO6AxN4UNBPOzstSS37dYx9ccPCy9yRNhTBEa3hV56pt1JHILirb7E7QrwAlnJOLDC6wTekBkr1GLqB5XBTJfuQWAOWA83RzcUveMnGtaBMz7sdcrSDFIhiKkNEULcQo34nmCUlkK9uiopa8fofwpaxRdEWTTLgGOtwln5+QUcz1MaEfi6e0bO5bbkeBPRMhV9p0K7sefZ6jhUDdX27huyp4nb8HhJQJHNeX0n3l5Ih/dRPwZIJyLm8BbWcRGEZvaIhjcqmpTfV/8iA1VbIrdbDVFJWo/8GozDVWr7H+rwcSsqiPnlFUG5qsexpyQN4lUJgiR+NjqwMq/3zf9owoYH7vH8COZ3tiJ+qLkQQG9kwDHjy5/DdhdRt9ORjpFLrbJSTwxijHukWJvUZZd9fEAykUp/S2MfhdoPc2g/qDozeJJMU1VR3JV38bkx61tnYzOBaNCtspigu+A5UXBg1u66IiyQ/uvvkyWQO/sfu5Sexa7QrEGpLcIY/kqrC+6ZHYGMIiBKwObG1plZXuQI8bkiJ4ETqqCg/Vw0D6st21H5N4BoslZdqt644hdoNzLG9kJXVPF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199018)(83380400001)(36756003)(2906002)(6506007)(54906003)(478600001)(86362001)(41300700001)(8936002)(110136005)(6486002)(966005)(71200400001)(82960400001)(122000001)(186003)(26005)(38070700005)(6512007)(2616005)(316002)(4326008)(8676002)(64756008)(5660300002)(66946007)(91956017)(66556008)(66476007)(76116006)(38100700002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3hjRSt3Y29XSC9wSmlnU1lsNEVzaGpJS2JNcU1NL3pyRlZHd2FQV2VmQ3lx?=
 =?utf-8?B?NEEyZy9KZjl1YUlySVN6QUZvRWQ0eWRzSmc1Z215YW4weGpEYTJlYThidkR6?=
 =?utf-8?B?VEQ0UzlXMjJzMUk5d1JQQ3JLT0RvQ3hjbk14eCtVcWxHdkNqNUNmUUhTaEJq?=
 =?utf-8?B?N1FtaWlxaXlsVFF5OVdlaDIvNzdFTGZENy8rWXpndUhlOTJsRHFHT0tjeTVK?=
 =?utf-8?B?OXZ4bEQ3YmttOVgrN25yNnpPV1kvSHZzOVFmOFRZTzMwUklTOE9kdG43S0VX?=
 =?utf-8?B?ZGZhK0tiT3RDTkJvS1UzajdIclZIZ2t2ekNWeUlmRWFOZk1DSE53cVJGN1RT?=
 =?utf-8?B?b1BNNnZNaDd3cCtiYXZNT0YzVFNYUy95Mm1qZEYzM2tRUnZGZFU4ZThrNVpJ?=
 =?utf-8?B?UXpjSk9UWm9FcTdaV2NFd3dZMjdRdHVYUHpaNVJuOWZoS1ZMS2RZVFJaMWI1?=
 =?utf-8?B?czBzb0FZMUlJbnUvdTBaNjkvYk53R3BZMEluMkRoalhKV003N1psVC8xRk1v?=
 =?utf-8?B?ZzFvc1ZYbDM2MGFjcDJ0RVZmWFovYThyNDYyT05iYjNMaFZDMXZRNlhvNUhQ?=
 =?utf-8?B?NTZWRVJUbmNVaTdhRndqQUpxdkl5c09mb1RWeWU1Y2dMQWJCdk9RTkZ1QVpQ?=
 =?utf-8?B?Qk1YcnpkSUxqNE1kcVlhY3NTMS9XL05FMmtnRVNhVjFZWG5WOFNIc2xuQUoy?=
 =?utf-8?B?TVp0ekpuckJLU2pHR0hEbzRzMnQwK25DWURFSmUwSjQyTmlsNmI2NTI1Uk1S?=
 =?utf-8?B?MkNFZ21wWW5xektKd09xRlE0bWloempSTkNUQzBId3hUTElMQVFJWWxQT3FQ?=
 =?utf-8?B?NDhveFl1TDVlcGltMnpqTWpqN3d1UDVHNEVLWVF4dVErYXQ4b25ObnJ6NGpS?=
 =?utf-8?B?d01nOTl5TEVWRUtZai9MREhDMXV3TGhjK0tZMm1WYXhvTkpnckJobk9PYTk2?=
 =?utf-8?B?S2Q4M0ZEcHd1bnF2REhjTkxyaS9wSTFtVkczQTgwSW5QdFdTNy9lSXpkdGJv?=
 =?utf-8?B?UkZqUUFPSGdDU3piUWN1TmsvNjhsR2NISWIrc0NZY3A4eFhxVXllUlJZMk5o?=
 =?utf-8?B?RWRZd3k3UitDL1RpczM5ME5taXl6eWZIUEJKemFQRVdWTG0rUkMyb2pVc1BI?=
 =?utf-8?B?WUhZVkhRWWZuMmZmQS96dDByVDkxTlZ0a2JBWU1JY0N1bC9RY0NlZm0waitS?=
 =?utf-8?B?ZjBvaUdPaEZkTHRLelF4c29wSnc2RFgxVmVHbXlnZnNRR2tiRHhFMUpiakZo?=
 =?utf-8?B?TmE2TlFJcjlqMytBQkQvLzdtMzZJNmthTDZNL3F5RnpOWHZCcU9lanhyQ3Q2?=
 =?utf-8?B?OHpHZDQ0cWd0Z2Y4b3Rmd053WHRqNHpMcjJWMEJGaTNoWVFFOXpSM1lEN0pz?=
 =?utf-8?B?MHgvTUlzSXNoNlljT2hkeFdCb1BBYS8vOHVZMFhPRXBlU1RmRHFFejFqeXJG?=
 =?utf-8?B?bTQvaTFFejRRTlp6aVNETDhabWJlMG4wZ0llbjlMRHFwNGhUM0pFemZpczJJ?=
 =?utf-8?B?a3NLalpOUVFVeER2QmhCaDFCL21FNXhhdHN4Zlh5aXZESzh4MzA4VHRHeXZn?=
 =?utf-8?B?azVMM0R2ZkNFNm9hSGQxMEhnTWt2RXh3cXM5UzN1Q1E3MGFzekNuSWZ0ckpj?=
 =?utf-8?B?UGJWV0tBR3dqaEdBeTBSbWhXUFRSdmRoY2hjSms4aTFZRm90VSs3OE04dk0y?=
 =?utf-8?B?bEJqaWNKOENVb3dyLzBIQllHdmNYbVk3alVjQkJvMHFEY2x5YjdvaGxIWVNJ?=
 =?utf-8?B?aW92T1J1ZkdOQnFyNzd1NW9JazdmZk5RZGdJQnpnWUo3M24vZ2RLSkVidjFh?=
 =?utf-8?B?S1dYcFV5TzMrcWxUVnVNT0RFUDV1anNrRWptZmlWVHB1Wm0rU1dsdGk1UlRX?=
 =?utf-8?B?WHg0cXZvR01HQzZQL0c3aEdyQW1uUWZibEFqWXdrRUlFMjlUWDBtVXBUK09T?=
 =?utf-8?B?Z2RaK2F3azRtTTdGRGp6bGpyWVNsR2plTGVnaE9QczlHSWw1QUlGUy93L1kz?=
 =?utf-8?B?MjR6V3hjMS9qVFVhdVdDTDBhdzd4MW9FK252LzBtQ00rRm1HSzQ0WkdUdEZq?=
 =?utf-8?B?aHg3RFBvZ3pZWVRyeURxeXNDQVVkZkFzNWs3Q2gzRlM1ektGY1hMd3VhelEv?=
 =?utf-8?B?U0dNQm9aQ3JMZFhFUzhCOWF3dXdQdzBzWWZVNDBYYnAzSkxjN2hJZTZjeEx4?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1E64ACD410AAF42AF74C98388210BCE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9177f9-c7b3-45db-669e-08db16f1f691
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2023 05:34:28.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F27aGdtU/2kfQNtU8Zxl1oNBx1jRY1zVcVuJ9byfh/d1n03OJv/VveugSH4ibPC4FFg4k3QH9tkzzGwgGdmxlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5378
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTAyLTI1IGF0IDEzOjI5ICswODAwLCBaaGFuZyBSdWkgd3JvdGU6DQo+IEhp
LCBBbGwsDQo+IA0KPiBTdGFydGluZyBmcm9tIGNvbW1pdCBjNDA4YjNkMWQ5YmIoInRoZXJtYWw6
IFZhbGlkYXRlIG5ldyBzdGF0ZSBpbg0KPiBjdXJfc3RhdGVfc3RvcmUoKSIpIGFuZCBjb21taXQg
YTM2NTEwNWM2ODVjKCJ0aGVybWFsOiBzeXNmczogUmV1c2UNCj4gY2Rldi0+bWF4X3N0YXRlIiks
IHRoZSBjZGV2LT5nZXRfbWF4X3N0YXRlKCkgaXMgZXZhbHVhdGVkIG9ubHkgb25jZQ0KPiBkdXJp
bmcgY29vbGluZyBkZXZpY2UgcmVnaXN0cmF0aW9uLg0KPiANCj4gVGhpcyBpcyBkb25lIHRvIGZp
eCB0aGUgYmVsb3cgU21hdGNoIHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6DQo+IAlkcml2ZXJzL3Ro
ZXJtYWwvdGhlcm1hbF9zeXNmcy5jOjY1Ng0KPiB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3N0YXRz
X3VwZGF0ZSgpDQo+IAl3YXJuOiBwb3RlbnRpYWwgaW50ZWdlciBvdmVyZmxvdyBmcm9tIHVzZXIg
J3N0YXRzLT5zdGF0ZSAqDQo+IHN0YXRzLT5tYXhfc3RhdGVzICsgbmV3X3N0YXRlJw0KPiByZXBv
cnRlZCBoZXJlIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9ZMGx0UkpSak83QWthd3ZFQGtp
bGkvLg0KPiANCj4gQnV0IHRoaXMgYWN0dWFsbHkgYnJlYWtzIGNvb2xpbmcgZGV2aWNlcyB3aGlj
aCBjb3VsZCBoYXZlIGR5bmFtaWMgbWF4DQo+IGNvb2xpbmcgc3RhdGUsIGxpa2UgQUNQSSBwcm9j
ZXNzb3IgY29vbGluZyBkZXZpY2UuDQo+IA0KPiBhY3BpX3Byb2Nlc3Nvcl9kcml2ZXJfaW5pdA0K
PiAJZHJpdmVyX3JlZ2lzdGVyKCZhY3BpX3Byb2Nlc3Nvcl9kcml2ZXIpOw0KPiAJCWFjcGlfcHJv
Y2Vzc29yX3N0YXJ0DQo+IAkJCWFjcGlfcHJvY2Vzc29yX3RoZXJtYWxfaW5pdA0KPiAJCQkJdGhl
cm1hbF9jb29saW5nX2RldmljZV9yZWdpc3Rlcg0KPiAJCQkJCXByb2Nlc3Nvcl9nZXRfbWF4X3N0
YXRlDQo+IAlhY3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQgPSB0cnVlDQo+IFRoZSBkcml2ZXIg
ZG9lc24ndCBjb3VudCBjcHVmcmVxIGFzIGNvb2xpbmcgc3RhdGUgdW50aWwNCj4gYWNwaV9wcm9j
ZXNzb3JfY3B1ZnJlcV9pbml0IGlzIHNldCBsYXRlci4NCj4gDQo+IEFzIGEgcmVzdWx0LCB3aXRo
b3V0IHRoZSBjb21taXRzIGFib3ZlLA0KPiAvc3lzL2NsYXNzL3RoZXJtYWwvY29vbGluZ19kZXZp
Y2UxMC9jdXJfc3RhdGU6MA0KPiAvc3lzL2NsYXNzL3RoZXJtYWwvY29vbGluZ19kZXZpY2UxMC9t
YXhfc3RhdGU6Mw0KPiAvc3lzL2NsYXNzL3RoZXJtYWwvY29vbGluZ19kZXZpY2UxMC90eXBlOlBy
b2Nlc3Nvcg0KPiBhZnRlciB0aGUgY29tbWl0cyBhYm92ZSwgDQo+IC9zeXMvY2xhc3MvdGhlcm1h
bC9jb29saW5nX2RldmljZTEwL2N1cl9zdGF0ZTowDQo+IC9zeXMvY2xhc3MvdGhlcm1hbC9jb29s
aW5nX2RldmljZTEwL21heF9zdGF0ZTowDQo+IC9zeXMvY2xhc3MvdGhlcm1hbC9jb29saW5nX2Rl
dmljZTEwL3R5cGU6UHJvY2Vzc29yDQoNCkZvcmdvdCB0byBtZW50aW9uIHRoYXQgdGhpcyBwcm9i
bGVtIGlzDQoNClJlcG9ydGVkLWJ5OiBXYW5nLCBRdWFueGlhbiA8cXVhbnhpYW4ud2FuZ0BpbnRl
bC5jb20+DQoNCnRoYW5rcywNCnJ1aQ0KPiANCj4gSW4gb3JkZXIgdG8gZml4IHRoaXMsIHRoZXJl
IGFyZSBzb21ldGhpbmcgd29ydGggY2xhcmlmaWNhdGlvbiBJTU8uDQo+IDEuIHNob3VsZCB3ZSBz
dXBwb3J0IGR5bmFtaWMgbWF4X3N0YXRlIG9yIG5vdD8NCj4gICAgQUNQSSBwcm9jZXNzb3IgY29v
bGluZyBzdGF0ZSBpcyBhIGNvbWJpbmF0aW9uIG9mIHByb2Nlc3NvciBwLQ0KPiBzdGF0ZXMNCj4g
ICAgYW5kIHQtc3RhdGVzLg0KPiAgICB0LXN0YXRlcyBhcmUgc3RhdGljLCBidXQgcC1zdGF0ZXMg
Y2FuIHZhcnkgZGVwZW5kcyBvbiBwcm9jZXNzb3IgDQo+ICAgIGZyZXF1ZW5jeSBkcml2ZXIgbG9h
ZGVkIG9yIG5vdC4NCj4gICAgSSdtIG5vdCBzdXJlIGlmIHRoZXJlIGlzIGFueSBvdGhlciB1c2Vy
IGxpa2UgdGhpcywgYnV0IHN0aWxsIHRoaXMNCj4gICAgaXMgYSB2YWxpZCB1c2UgY2FzZSBvZiBk
eW5hbWljIG1heF9zdGF0ZS4NCj4gMi4gaG93IHRvIGhhbmRsZSBkeW5hbWljIG1heF9zdGF0ZSBm
b3IgY29vbGluZyBkZXZpY2Ugc3RhdGlzdGljcyBpbg0KPiAgICBzeXNmcz8NCj4gICAgSU1PLCB3
aGVuIG1heF9zdGF0ZSBjaGFuZ2VzLCB0aGUgZGVmaW5pdGlvbiBvZiBwcmV2aW91cyBjb29saW5n
DQo+ICAgIGRldmljZSBpcyBjaGFuZ2VkIGFzIHdlbGwsIHRodXMgd2Ugc2hvdWxkIGFiYW5kb24g
dGhlIHByZXZpb3VzDQo+ICAgIHN0YXRpc3RpY3MgYW5kIHJlc3RhcnQgY291bnRpbmcuDQo+IDMu
IGFueXRoaW5nIGVsc2UgbmVlZHMgdG8gYmUgaGFuZGxlZCB3aGVuIG1heF9zdGF0ZSBjaGFuZ2Vz
Pw0KPiAgICBTYXksIGFzIHRoZSBkZWZpbml0aW9uIG9mIGVhY2ggY29vbGluZyBzdGF0ZSBpcyBj
aGFuZ2VkIHdoZW4NCj4gICAgbWF4X3N0YXRlIGNoYW5nZXMsIHNob3VsZCB3ZSBpbnZhbGlkYXRl
IGFuZCByZS11cGRhdGUgdGhlDQo+ICAgIHRoZXJtYWwgaW5zdGFuY2VzIG9mIHRoaXMgY2RldiBp
biBlYWNoIHRoZXJtYWwgem9uZSBkZXZpY2U/DQo+IDQuIGhvdyB0byBkZXRlY3QvaGFuZGxlIG1h
eCBjb29saW5nIHN0YXRlcyBjaGFuZ2VzPw0KPiAgICBTaG91bGQgd2UgZG8gdGhpcyBhcyBiZWZv
cmUsIHdoaWNoIGludm9rZXMgLmdldF9tYXhfc3RhdGUoKQ0KPiAgICBldmVyeXdoZXJlIGFuZCBk
byB1cGRhdGVzIHdoZW4gbmVjZXNzYXJ5ICwgb3INCj4gICAgYS4gY2FjaGUgbWF4X3N0YXRlIGxp
a2Ugd2UgZG8gdG9kYXkNCj4gICAgYi4gaW50cm9kdWNlIGEgbmV3IEFQSSBmb3IgbWF4X3N0YXRl
IGNoYW5nZQ0KPiAgICBjLiBpbnZva2UgdGhlIG5ldyBBUEkgaW4gdGhlIGNvb2xpbmcgZGV2aWNl
IGRyaXZlciBleHBsaWNpdGx5IHdoZW4NCj4gICAgICAgbWF4X3N0YXRlIGNoYW5nZXMNCj4gICAg
ZC4gdXBkYXRlIGNhY2hlZCBtYXhfc3RhdGUgdmFsdWUsIHN0YXRpc3RpY3Mgc3lzZnMgYW5kDQo+
ICAgICAgIHRoZXJtYWxfaW5zdGFuY2VzIGluIHRoZSBBUEkNCj4gICAgZS4gcmVtb3ZlIC5nZXRf
bWF4X3N0YXRlKCkgY2FsbGJhY2sgYXMgd2UgcmVnaXN0ZXIgYW5kIHVwZGF0ZSB0aGUNCj4gICAg
ICAgbWF4X3N0YXRlIHdpdGggYSBmaXhlZCB2YWx1ZSBlYWNoIHRpbWUuDQo+IA0KPiB0aGFua3Ms
DQo+IHJ1aQ0KPiANCj4gDQo+IA0K
