Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B633972544E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjFGGdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbjFGGdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:33:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267991BF9;
        Tue,  6 Jun 2023 23:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686119576; x=1717655576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UgFOYQGqDzLp4xx5oY7zBmMyA3RJ/nZ8tQokKBNT+N4=;
  b=EvDnJgxPr9wDmL6fo0lkQ5L9CnYsfLMWyxqshU7m3g4B/fx01O0ktmxU
   TlMEtrq2uzlPvgRSvmoIJfpjkwxEtDSIlFUDRO7IZofrlyukD/ky7Rlnz
   wNaVKCSinLiEPIx0AmpIzBB6GYqXkddstQElCFI81WxzydYNBpXrfumix
   ZIRQmlroleWxGXvr4PLVYPxnGtXtuOE50BDBJlEeeTVbZSbIcx0U0NiJX
   uZOvIFRmi/nNpen2mFoUD8gqsS9Y+DX/kXmRoRufSJmHBf7yYqc/bQ2PP
   FljNylgz4N4lc4m4xi4bz+tfs7RemDtTb+XkTL95ZUzD2K1IxrjZ+VMZn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="355756528"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="355756528"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 23:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="703484803"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="703484803"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 06 Jun 2023 23:32:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 23:32:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 23:32:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 23:32:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 23:32:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndw8rLURpRs06TGjqy8MqhOn9qy1mrwwZL5XMr0IosOZVSU1KvLf0Vv53iC/0CjN1/RODAuS6JJT9Kmx2RKGwKQec7aNYKurrH8Hryw8xKK26l/L1Q62E0Uk0eYdyTk76D6+bhfZvRdjY8FBTAYnfI+2r+I9U9mS5gvDZkihYADZIzLUZsaSn5eiVTSsPGrJ0tq4gaCzy+F2hMWeVyQJ+x3fNv07ftrkKgbxpy0+B+UqDtugOK1tVhb7mLdwrwpszSJSEAyGUVvPY4KnJTkXwsSp6TLC6BOIDO+/IQtvzdj4UWIh49BTsfWB4QI4nrCyObbGDhgPRlDVgL4N6AM2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgFOYQGqDzLp4xx5oY7zBmMyA3RJ/nZ8tQokKBNT+N4=;
 b=bB6qy4W7nROs3d15oK7e8HP6yzVHFFfAD9nF2OlmteCgk7fbDPh9jik1ApffNYkEwKrHf55y6abmMmDW5BCXq68tFFgM56rJ9rv7aOkeOf5amR0aoZnRU/dszbnSYlzBTWe+TZC7Su+rbUb17JS2NKVtzFsnsqeVyd3hjltbKfN+HWmyEh+gx+jdMijvN/Hl/honOEwJqMcbt++iMpP8nwdZZm5IeYItJwB6hO5GuucXtHhhLEPfWgMBqvUVi+/0GFm32N/zWEfOFzOuee3xErVlKpZFHkYeU2qPvWFxvaVa1ZMGZyw3yttJdfkLhTbKK412JF2luN0GrnUIwz6x7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by CY8PR11MB7033.namprd11.prod.outlook.com (2603:10b6:930:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 7 Jun
 2023 06:32:46 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8%7]) with mapi id 15.20.6455.027; Wed, 7 Jun 2023
 06:32:46 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Valentin, Eduardo" <eduval@amazon.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "evalenti@kernel.org" <evalenti@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "amitk@kernel.org" <amitk@kernel.org>
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Thread-Topic: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Thread-Index: AQHZmNhPM/sHhzNBMEmsondXNqHQpq9+4gyA
Date:   Wed, 7 Jun 2023 06:32:46 +0000
Message-ID: <27c8bd5ddea62391f9573ea77cfcebb4fa88ff66.camel@intel.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
In-Reply-To: <20230607003721.834038-1-evalenti@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|CY8PR11MB7033:EE_
x-ms-office365-filtering-correlation-id: 50d5d125-ce02-410d-7a6a-08db672101ad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iPBLxTl0TBZAOHd++3B6QH3jwLggLBvCIGggsStrwuyIc40EIbmWmxQsWC0et6zXtcLpljQXCQ/KdAHATs39j8xFYl4SbDsexIXyl7xbfciHlPVDKTtx/JReDfPEfQG4bABxzQ/DmTAKIyioi9J1VEc0rpVCbT+DaTMcgad7kk5ni8ESvEDLl0t27j4e44cbpBN7Yy945YzNkyHx18QRB8fBEbttu93+GY5HffgboSYkR8tU8U3wyiYtVK0sjH1wL+AJ/36z63FeCkhU+ue46FVL7SjnUUSmFovcZ11N9dbGdAFQ9Q1wmpZ3ugthK8BB5kTt3S+H6ZIgQyQLR3QcCQInJF41ofjKWu069lNnHxUm+QxUuU0wz6YqRP1ITvw6nGR/tYc5EBBsejHPO1/pKhOs6CFY4KdOAPV+fYEOq50WrlbvvmQbnuCdLV9bEbuaEHKIbzkIVmPy5SEmrdMJTN+d4VijgexiiJx5PZgNnq66ths9vhq8x8OoRS3Z4qyjl5GqezRlRhA5ycJXMBo8VwwoVHp6dEZl03ec6e7mjNnIyUywYTyr6PuW5dm1TsZwH9eTw1AFRgify06SJFrdH/5n2gkeI5pdcvqZmBDq0ow=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(66446008)(36756003)(66556008)(66946007)(64756008)(91956017)(66476007)(316002)(76116006)(41300700001)(4326008)(110136005)(8936002)(2906002)(5660300002)(8676002)(6486002)(478600001)(71200400001)(82960400001)(83380400001)(26005)(6506007)(186003)(2616005)(122000001)(38070700005)(86362001)(6512007)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2lBUm9lOXozQ3duNDdJRnJCRVpkbThhSDAwNUk5VUIyQWdGS0NsN25Yazlw?=
 =?utf-8?B?NVgwNFpUaExDeFhlYTlCTlRESWs0QmdmUEVtSXc1R1VZeHZVa2hyaVQ2MkFB?=
 =?utf-8?B?MFJhN0YrdkJyMGRFalVKcTFlOTE0TVZzZmYzLzZHSndiRmJVVHozejFTT1JZ?=
 =?utf-8?B?MHZvZjZLSE9md1ptY2hZNDNRZkpWVDd4SXJISlo5R0t0Z1NibnJOcUE0QWdi?=
 =?utf-8?B?UUsrSmRGakxnYWpmUnE1OG1xcmRWVGN1YUV0RUhxWGQ3OVNYa2FGNm1CaDFs?=
 =?utf-8?B?cFhXYzM5VWc4dUxTTTJza24vM3A3L3JDam4yNUJZTk1RdGJLNThNVVYzWmJB?=
 =?utf-8?B?eEJxOFBPWGhITHRrTzBveEZ6QnJYWWJ6SWVxNnRCZDUrTkljMVRmZ1FEWE9k?=
 =?utf-8?B?ZVh0aVNGTExxZFc0Q0tUdzAvcG5jcFQxcmdyTVlxOXRDenoxbTJNYVlXSTNt?=
 =?utf-8?B?bGRWejFZdlR2bDRJdys0NjlIekxoTmo3S1pvd2RzMnFZRzVQODlIU0xlTXl5?=
 =?utf-8?B?OWwvVDBXV1F5QWI0SXlVTjNxdklIekJRaGdlU3pnaStjQlJzUVpUaDJzdEp6?=
 =?utf-8?B?Y3NZNkRua2l1STFGUzBUdG1nZXBYaWw4eDl3bjBTMHNMalE2Mm9mT0ZhbjQx?=
 =?utf-8?B?UFlMRG4yajBUUzRHa0dDRWdONm9qS21FZjBBU09nSnAvMHE0Ni9xSU5lMW4w?=
 =?utf-8?B?K1dZd3R2MnBFTDdXbE5URmlmWkJXaHpXMkx1M3BpTGhnSDVHeHhISEg1YmJa?=
 =?utf-8?B?WVRYWlZSTDZmNS9oazRLZGk5cHh2U3h0eHJreGRnb0VwTEs1T1h2VVArdGVo?=
 =?utf-8?B?NlNWVGtjSWhyU25mQUxMUTJ1WEFqK0FjbEM3MWJIb2NYeU9jLzhEeGZkL25X?=
 =?utf-8?B?bjFlbWVUMWhIUUY0NTBjNW9aZ0NTS0JtVjZIbmxJMVp1NGsxd2U5bG1OVEJE?=
 =?utf-8?B?cGwrTXROY2trZHl5REplSzJPYWJpTmIxbk52RjhkREppeXAxWnd4cUZvSW1u?=
 =?utf-8?B?eVpKaC92dXB6R3F1MTFPejRPUWNOc2U1L2J2R3ZiRjYxSDJPTmhsRUM4azhR?=
 =?utf-8?B?bXgrWEpkMnUyMkNvdWQ4ZW1UUW5EWkVrbWtRQWt0UWxJclVZYVJDbGxDdjgz?=
 =?utf-8?B?SkJ1RnlsVW1wdGFGY3JNNTgxYXZkL2NJMCtxZ01UYkpKckd3SGNvZ2ptWWl1?=
 =?utf-8?B?eCthaEdqNW5nQXNTQTJMdUtuN3o5Sm5YRWtnV2NDNmtCMWRTODZOYlhjeWUv?=
 =?utf-8?B?SVpOSmlCZlBXUzN4TnVVbHJid2tWaWhNNlBkM2JwTkRRTVVHZ2dMNnNXMzRm?=
 =?utf-8?B?eG5PUTFHb0hQNDFjZkVZbVVTc2NoMHVIVENoSkJiVlU5L1dCVXlPN0l5bStJ?=
 =?utf-8?B?Z09icEM0VGZ3eVF4Y1daMTlMYnVocFJIN2RkSy9DWi8xK3RaNmhseVZiVTNR?=
 =?utf-8?B?QkpEcTFzT2tyaWJSUHVEZUE0L3dVMUs5b3gwZzRwVlg3SG5yNi9MdjI3MDZp?=
 =?utf-8?B?SkV2dTI0V2k5eDdrUTJOdVBpMnlhOHZUakZIM01iU1FTS3BFVEsybk53Snpr?=
 =?utf-8?B?Njc0a0M1blB0ZkpxVEhYRVE3QmNiRUIwUU8zT2xxemZhQ0lXOVJmeWU3eXY4?=
 =?utf-8?B?UXJOYWx6OGhuakNaWFpKdnd5RUw5ZTJrTFB4WU5pOHBQY2o1dEcrZG9zUzRE?=
 =?utf-8?B?M2djYzMrai8xM0d4S1dpeGpyWlk2R3ZQSVNUeDYweklCMDhQZjlDTi93UFlC?=
 =?utf-8?B?QnBCS2h5cUN5dGd0ZWp0RTRWYm15NmxubjNHYW5NN0NWNDVoTDlSMUQ2WUR1?=
 =?utf-8?B?MmMzdUhsd1lHbEJrdzVaUGRCejljeTZpN2NzTmFtOXBPTFE4QXpETkZHQ2w0?=
 =?utf-8?B?V0dRMVJmVnJERFNLT0ZBOTdoeDc0QkhHanR0Y1Z1ODVFL3N4ZnpkL01HcU5l?=
 =?utf-8?B?TEZJTlBPcUhOV2RoMUZDKzgyUVB5dFplNWhKZWIyYkl0UVJrQ1AyTzVWT1pM?=
 =?utf-8?B?VWFlUWppK3kwZUFRbVN2SnoxRFcrUGdBaU1CSXUvWmtBMXU5QVRsMnk1TWxq?=
 =?utf-8?B?VTZCVXdyY20zRGJGeDd5UnJZRlpGS3d0Sk5QYk9ZU0tuZlJFT2FEd0E3N2xv?=
 =?utf-8?Q?gHQHragjIYND2ocCApXR4CP+1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B72A07E7C626F4297CA10C68F17FC01@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d5d125-ce02-410d-7a6a-08db672101ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 06:32:46.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNIKLtx75RmsZIelnV1nfSnwJCq789zeAopFyo5CDDh/qXeWoGLplbUuuCWKdd/i9eigZs/HD8sqGKxsqP13IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7033
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

T24gVHVlLCAyMDIzLTA2LTA2IGF0IDE3OjM3IC0wNzAwLCBFZHVhcmRvIFZhbGVudGluIHdyb3Rl
Ogo+IEZyb206IEVkdWFyZG8gVmFsZW50aW4gPGVkdXZhbEBhbWF6b24uY29tPgo+IAo+IEFzIHRo
ZSB0aGVybWFsIHpvbmUgY2FjaGVzIHRoZSBjdXJyZW50IGFuZCBsYXN0IHRlbXBlcmF0dXJlCj4g
dmFsdWUsIHRoZSBzeXNmcyBpbnRlcmZhY2UgY2FuIHVzZSB0aGF0IGluc3RlYWQgb2YKPiBmb3Jj
aW5nIGFuIGFjdHVhbCB1cGRhdGUgb3IgcmVhZCBmcm9tIHRoZSBkZXZpY2UuCj4gVGhpcyB3YXks
IGlmIG11bHRpcGxlIHVzZXJzcGFjZSByZXF1ZXN0cyBhcmUgY29taW5nCj4gaW4sIHdlIGF2b2lk
IHN0b3JtaW5nIHRoZSBkZXZpY2Ugd2l0aCBtdWx0aXBsZSByZWFkcwo+IGFuZCBwb3RlbnRpYWxs
eSBjbG9nZ2luZyB0aGUgdGltaW5nIHJlcXVpcmVtZW50Cj4gZm9yIHRoZSBnb3Zlcm5vcnMuCj4g
Cj4gQ2M6ICJSYWZhZWwgSi4gV3lzb2NraSIgPHJhZmFlbEBrZXJuZWwub3JnPiAoc3VwcG9ydGVy
OlRIRVJNQUwpCj4gQ2M6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3Jn
PiAoc3VwcG9ydGVyOlRIRVJNQUwpCj4gQ2M6IEFtaXQgS3VjaGVyaWEgPGFtaXRrQGtlcm5lbC5v
cmc+IChyZXZpZXdlcjpUSEVSTUFMKQo+IENjOiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5j
b20+IChyZXZpZXdlcjpUSEVSTUFMKQo+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmfCoChv
cGVuIGxpc3Q6VEhFUk1BTCkKPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZ8KgKG9w
ZW4gbGlzdCkKPiAKPiBTaWduZWQtb2ZmLWJ5OiBFZHVhcmRvIFZhbGVudGluIDxlZHV2YWxAYW1h
em9uLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX3N5c2ZzLmMgfCAyMSAr
KysrKysrKysrKysrKysrLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1h
bF9zeXNmcy5jCj4gYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9zeXNmcy5jCj4gaW5kZXggYjZk
YWVhMjM5OGRhLi5hMjQwYzU4ZDllMDggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy90aGVybWFsL3Ro
ZXJtYWxfc3lzZnMuYwo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX3N5c2ZzLmMKPiBA
QCAtMzUsMTIgKzM1LDIzIEBAIHN0YXRpYyBzc2l6ZV90Cj4gwqB0ZW1wX3Nob3coc3RydWN0IGRl
dmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhcgo+ICpidWYpCj4g
wqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eiA9IHRv
X3RoZXJtYWxfem9uZShkZXYpOwo+IC3CoMKgwqDCoMKgwqDCoGludCB0ZW1wZXJhdHVyZSwgcmV0
Owo+IC0KPiAtwqDCoMKgwqDCoMKgwqByZXQgPSB0aGVybWFsX3pvbmVfZ2V0X3RlbXAodHosICZ0
ZW1wZXJhdHVyZSk7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IHRlbXBlcmF0dXJlOwo+IMKgCj4gLcKg
wqDCoMKgwqDCoMKgaWYgKHJldCkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIHJldDsKPiArwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKgwqDCoCAqIGRvbid0IGZv
cmNlIG5ldyB1cGRhdGUgZnJvbSBleHRlcm5hbCByZWFkcwo+ICvCoMKgwqDCoMKgwqDCoCAqIFRo
aXMgd2F5IHdlIGF2b2lkIG1lc3NpbmcgdXAgd2l0aCB0aW1lIGNvbnN0cmFpbnRzLgo+ICvCoMKg
wqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKgwqDCoGlmICh0ei0+bW9kZSA9PSBUSEVSTUFMX0RF
VklDRV9ESVNBQkxFRCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnQgcjsK
PiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHIgPSB0aGVybWFsX3pvbmVfZ2V0
X3RlbXAodHosICZ0ZW1wZXJhdHVyZSk7IC8qIGhvbGRzCj4gdHotPmxvY2sqLwoKd2hhdCBpcyB0
aGUgZXhwZWN0ZWQgYmVoYXZpb3Igb2YgYSBkaXNhYmxlZCB6b25lPwoKSU1PLCB0aGUgaGFyZHdh
cmUgbWF5IG5vdCBiZSBmdW5jdGlvbmFsIGF0IHRoaXMgcG9pbnQsIGFuZCByZWFkaW5nIHRoZQp0
ZW1wZXJhdHVyZSBzaG91bGQgYmUgYXZvaWRlZCwgYXMgd2UgZG8gaW4KX190aGVybWFsX3pvbmVf
ZGV2aWNlX3VwZGF0ZSgpLgoKc2hvdWxkIHdlIGp1c3QgcmV0dXJuIGZhaWx1cmUgaW4gdGhpcyBj
YXNlPwoKdXNlcnNwYWNlIHNob3VsZCBwb2tlIHRoZSB0ZW1wIGF0dHJpYnV0ZSBmb3IgZW5hYmxl
ZCB6b25lcyBvbmx5LgoKdGhhbmtzLApydWkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKHIpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gcjsKPiArwqDCoMKgwqDCoMKgwqB9IGVsc2Ugewo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZ0ei0+bG9jayk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHRlbXBlcmF0dXJlID0gdHotPnRlbXBlcmF0dXJlOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJnR6LT5sb2NrKTsKPiArwqDCoMKgwqDC
oMKgwqB9Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIs
IHRlbXBlcmF0dXJlKTsKPiDCoH0KCg==
