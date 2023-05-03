Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2B6F5D69
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjECR7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjECR7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:59:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D0C3594;
        Wed,  3 May 2023 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683136730; x=1714672730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PWXVYSflTDvWwXV7ZjCS0RBc9DeKhQu1rLXxdZd3DjY=;
  b=M3sAHg0mY6y9UHkQMc+1U3QWW2sezXf2Sco+y5yneSyajEZVUlCrtM1l
   nDU9jxVkdyynU5AslBke78ulXg8RhImKaomoz3B3twv2ihi5brgW13+4L
   gyLMlOX+3S7AsYog/IzTegdCMz6FnuqWjIMluxHHO8zlvjMgsEIsb0Awe
   uYfByhPJs0gU1Me5Wqv6Iw0YWXRcvZdj+ZGsXuf7bqQY/iQxsuK7jS8TM
   B5BsuznSX1ayH3NZeBi/kHWHiKFqlQsXEGm6GURj73fEwvfR00q4rFwmi
   WUJA8zHnd0nybAapfFW0CaDGG+VItGS94gDtkxuDItZZGXIsc45Jadgq2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="337857978"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="337857978"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 10:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="690784649"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="690784649"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 03 May 2023 10:58:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 10:58:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 10:58:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 3 May 2023 10:58:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 3 May 2023 10:58:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkrYQyZH7fahK5xujNTOtYxs9/yu0ZNQJtR+TgEVjTi4H7rcFnvwATt1Fui9aDUaHoXG4USJeiZpm20TZBpJyOSQXrnvCwaHnhDsNHVoLigjcHrn9Iw/YkOZZa7vCUZqvGEZtz0oK0I2Lm/6ng/pbbnB6UJNoYFbL2vjCsiHcNSD0uPEMBE7Mhn7CiP/D/MigT06CsYaIqb7uvwYs4wNX2pMlA5+1bgFKdNFPlmRZqnmZepFHFmxnchzHm6n7E1CPyi+ENG3s51GMMVKHtT6nwBSVzhyYtq/bRWWO9tKJjyiv5yZldri3x8Ns+ao/b63KFtTuvBjmHpVVaU8KaCNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWXVYSflTDvWwXV7ZjCS0RBc9DeKhQu1rLXxdZd3DjY=;
 b=Y2Xh0UT/lIZeUWsAGCstYo/ji7oa2dQVZpUYS7B7VTrb8G1iGUyG7Bu60QYFsr9dRftpIQTfCNxWPokHwTiRkQbnOcFg1kEgYVFR6bH7lhg+DYtCZymnRQZ/WqBJXC5NE6afdCrn1l3yaaMv2F6U5ahYzg5jPkvBwh2Hjw0oryjIXHQB7XoqEglSg/Sxjp6J9IBeIcRE9n1jbsK3ev00rRjjqr6cv1T/fz8qSA8MyDEIwJxyj7P0h5KCznQs4hvPk39iiHSEfipJyuOdInXEGczByvWOA++JJinDS8CHWTzHg/YUoGxiZ8txWrpkKAzNHD70ptekRDQpix20Ie7yOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by CH3PR11MB7274.namprd11.prod.outlook.com (2603:10b6:610:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 17:58:31 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::3403:36be:98a3:b532]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::3403:36be:98a3:b532%4]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 17:58:31 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "raghuhack78@gmail.com" <raghuhack78@gmail.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] cxl/region: Remove else after return statement
Thread-Topic: [PATCH v2 2/2] cxl/region: Remove else after return statement
Thread-Index: AQHZeXAF3PhH394WYEuAf+faRTpEgK9FhmMAgANYeIA=
Date:   Wed, 3 May 2023 17:58:31 +0000
Message-ID: <b4cd9ff666fdbb2d0ff31736ad61b3475d6f4b26.camel@intel.com>
References: <20230428012235.119333-1-raghuhack78@gmail.com>
         <20230428012235.119333-3-raghuhack78@gmail.com>
         <da1dad4b-cdee-76e3-a3eb-cb39b6ee1423@intel.com>
In-Reply-To: <da1dad4b-cdee-76e3-a3eb-cb39b6ee1423@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|CH3PR11MB7274:EE_
x-ms-office365-filtering-correlation-id: a21fe92e-f775-4363-db6a-08db4c00019d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ghcNmsg0gNtr4SLrQ5JbhBxO00KXo+YoBbR+sLLaUGDiL67Sz2qCkTrJgl2FZ6TRu9Tj+ijc/1n+gMsOyPARf5txGpWDVfxem2KuXi1EVW37gJhQGXp4qY7wEtfOQrQKOpDDDu/V6KX8TXoFLXr4CBO255UGWYtjxe6a38FFKuZpjMg+5MxzLcXoDGCs0VTfbXiXR99CAO+/112+7sQukoob1gsCRn8eakGjMy70IJoO8pnug3jpWg0G8pdWhsBCgJN/iEU7cITZYcLUidV5T61rJug/CnPzQYIj7Gq0Y0RwDPRYG3NKAwUKpdtN4MRpUjIDmuX8WW4THrD/ZBoTF1fjPJFFx9v8zGOb9XsjsVOzfc8iE8V/l1NFVYPTMIHrvCV6tJIS0f/B/UIBwo8PHILv4rffF+b93WuT13ET8udKOjOSBSRXkSGcJqXFyoPLFso/64UND/eLz6GnW+W1sWEsOoADk1iaWQQPS/DVWlhPtPodIViHvrZqDI6uiK9ixvyNyyaNTbXa2HED+OD5fpKWReeJNh4VtjuJGdaL+DJS8ttrAkwgpvJE1mjp4GVTS1Wj5loI6W9rfHYTzvEPA7wC+fvgHVi9R3gkEGzpRhVbdoX6aDRK8Yh5pK9W/KYptf0a6wsn64mlACVopTCgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(478600001)(2906002)(66446008)(4326008)(76116006)(64756008)(66556008)(66476007)(316002)(66946007)(91956017)(5660300002)(8936002)(6636002)(110136005)(41300700001)(8676002)(53546011)(6506007)(186003)(26005)(38070700005)(6512007)(2616005)(6486002)(921005)(122000001)(86362001)(38100700002)(82960400001)(71200400001)(83380400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVRlK1NOV2tYTlgrV0pyRXNGbjhhTzRGUWU4blpleDV6NUVOa2poTHRMTWRI?=
 =?utf-8?B?ekpoMXVwSkVPQlhpbGloczhCaHZIczkwbEoxNFhKYWNyL3FWQTNXSjZod2xO?=
 =?utf-8?B?WWp2RWhCRkY0cTQrbjJkWHFpaHhqOUI0RTBWdy9hUlBEOUNOdkVlZlFqN01m?=
 =?utf-8?B?WFRPWXB6MDRUZUphRE9zL3JtUWc5RHNqK3pQVmxoS1pTNDQ5Ky85VHV2OHND?=
 =?utf-8?B?K3V4R3RPaXRvMGtuUGJBRjAwZE9ORDlhczdPaWRXOVJlek8zeWVMSFR4Zlp6?=
 =?utf-8?B?RjFCeXltUkFrSC9ubXpjY2Fjc0FNN2pWcnJxRzNnTVlEcnBrblZia3Q2OTAz?=
 =?utf-8?B?TnJjMGxDMDJKNmFTbG1VWXhaSHR5U2dFVGhKY3RCTHA0K0NFb2dsektPNEhO?=
 =?utf-8?B?ZHFtZ0ZDN25BYjhTZWpMNjg4dEJSTXhUcnNtTmU0ZzlCUjhoUE9BcDFqVkdx?=
 =?utf-8?B?cDNUeUpGVlZncnhJdWxTNXd4N0IvRHFHZy9NUVlsNU5zUEpkeHA4M2I3MXdJ?=
 =?utf-8?B?bTh4eGVuRXpiL1Q3enZRbXJHZGR1cVcxUitheUNwWjhPckdMTmw5Uy9UZDRE?=
 =?utf-8?B?ZXhaekpSSnFxbjlOKzh6VXlodE5ucmhmRVVIdXZYMmdDTDNJbnJ4cis3MHBI?=
 =?utf-8?B?cnpyb1J5SjFmOGlxSHk1R1pLcFA3NS9leHFEVllJUStDa2xhb0lxS2dqekxS?=
 =?utf-8?B?SlRrNFlxY0tQVUdIRGdaR1o3UTREZWs0N0VRQmp1Zm05VTk2a1VmZVdEOWdx?=
 =?utf-8?B?V0hlWjVLWTUvdFlIT0dZTTJQbUUvc2ZWWFQ1T29mRTNwdmlLdWxDOFE3SDBr?=
 =?utf-8?B?YUFkZzY5bzRFRkd3S1F6RnlZaktTMUpReGRrSU52V1ZmRjRPVnJkR0RQWU9q?=
 =?utf-8?B?ZXdKc2xwa0R6RlNwanVwV2t1TGZZUHlFWGwyZE8ydXQzZEVGK0ZTcnBOMEVX?=
 =?utf-8?B?MHY1eHUzaWV4K0J1dzZUWElQaVJBK0t4OUpMRlpzQ3BsSS9sa3kwYUxoN0J5?=
 =?utf-8?B?cEdxSXQyS1RseXlsNHZLSlFuL0dSZmtLSmVPMHdGMkViSUNtNUhQdnptL0dM?=
 =?utf-8?B?OHpDUk5FazNEMTVxaXpuUVJyZm1Db2JHU0NlMW4yWVlpb0owQm8vSWJRbWkz?=
 =?utf-8?B?YnlYQTFDQ0tFa3RMbGZwNWFiWnRxZ04waXVHWDdadm51RXFWRkxvckswL2Rh?=
 =?utf-8?B?cWZaajVwY3NxemZKem96VGtmdmN6RTB3cDl2TzMxK2krOGl3TjNkczYyZk9Z?=
 =?utf-8?B?SlJXd3NhclRhYUpwdmF0eExta203OFQrV3E3VStEN2ozOTdaQWJmL3RUUmxW?=
 =?utf-8?B?d3RzbHQrbjFwNFp3WGdZR2hrNi9COUd5QU4vZWZxUjJKOGtHTEhtOFc3WDE3?=
 =?utf-8?B?ZlNzM0Q1RE5oT0I3QkF6YkU0eU9rU28wbWVFNUtpZGltY0MzSEpFeDVNUXp0?=
 =?utf-8?B?R21USURlOE5ibXZRTGFoVmdsak5sVWx3ZjJ6V25OZFZ2WUovb2xmZ3JWa1Rv?=
 =?utf-8?B?TERGS1VOU1NoK1BOTE5jYU9HaEQvZ0pMOHM2R1QrWjVvVjhmMmo1NTZSS21m?=
 =?utf-8?B?WUF5VWJIck95bFdwUHQ5MWZMM1JxaE1ZMnErRjJXc3E4ZDNmYjVJSHVaMkMw?=
 =?utf-8?B?SjQ4QlpkY0JsZXVLaGJya2dlWFNEcVFSTTBUQWV0c1VYamFYT1NCb3BJcGNG?=
 =?utf-8?B?aitGN24zZXNNVWhGRXZZSTNnK2ZWa2dqc3ZBMG5Qbi9RVGlTTTlZWWc4THBO?=
 =?utf-8?B?ZUdhM1VkY2hEd3RnYXFIcHJFRExRWGxWTHBHVG93aDh3OWErU3ZvbHJRZU8v?=
 =?utf-8?B?QjVSOXdyVVUzZlQvMU16VVJjVkRzdlk1NWJkREl5WHhjcjJoelZEa1MzeTNV?=
 =?utf-8?B?YzVZbEhoL2t0a0thcGtNK2dYa1pKLzJhVFNURHN5RUh6Nk1ES05FZzQyY3lR?=
 =?utf-8?B?akMyYTVDQ1I4QVp1WGVRd1lyWitYbnk1R05VVWtjSkV3VU9VWmdNVVRORlZa?=
 =?utf-8?B?Mm01ZlZ2UnVncHVzWHJyV1NYUi9aeEVZc0QrbUtwcUpsbVNscWkxY2ZzMDI5?=
 =?utf-8?B?WE90MnVPU1pnbXh2ci8zWkFCWDFHUEtiYWVxa1Rla1pOOTBrcHZTMHNic25a?=
 =?utf-8?B?MXA2UkxsNDJZeHBNR3dqSlVhNkZMc3N4ZExBM1FlSkxGbnVaZm84QWY2amd1?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D4D9907F000A74A86537DBC7215BBE4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21fe92e-f775-4363-db6a-08db4c00019d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 17:58:31.3758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtRnjFQhNr3o3DjFPLe/HA9A/gmV8+oIr/GACQMdC1Ti0Rw7YwQYWIsBcxKIPO3Uq4D4CfWvYuladjU/uS0I2+YjJo7+q824YPO2oT/2Uj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7274
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTAxIGF0IDA3OjUzIC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOgo+IAo+
IAo+IE9uIDQvMjcvMjMgNjoyMiBQTSwgUmFnaHUgSCB3cm90ZToKPiA+IElzc3VlIGZvdW5kIHdp
dGggY2hlY2twYXRjaAo+ID4gCj4gPiBUaGUgZWxzZSBzZWN0aW9uIGhlcmUgaXMgcmVkdW5kYW50
IGFmdGVyIHJldHVybiBzdGF0ZW1lbnQsIHJlbW92aW5nIGl0Lgo+ID4gU2FuaXR5IGFuZCBjb3Jy
ZWN0bmVzcyBpcyBub3QgYWZmZWN0ZWQgZHVlIHRvIHRoaXMgZml4Lgo+ID4gCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSYWdodSBIIDxyYWdodWhhY2s3OEBnbWFpbC5jb20+Cj4gCj4gUmV2aWV3ZWQtYnk6
IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPgo+IAo+ID4gLS0tCj4gPiDCoCBkcml2
ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIHwgOCArKysrLS0tLQo+ID4gwqAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCkxvb2tzIGdvb2QsClJldmlld2VkLWJ5
OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4KCj4gPiAKPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdp
b24uYwo+ID4gaW5kZXggZjI5MDI4MTQ4ODA2Li5hNDZkNmFkOWVmMGEgMTAwNjQ0Cj4gPiAtLS0g
YS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jCj4gPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL3Jl
Z2lvbi5jCj4gPiBAQCAtMjY2NiwxMSArMjY2NiwxMSBAQCBzdGF0aWMgaW50IGN4bF9yZWdpb25f
aW52YWxpZGF0ZV9tZW1yZWdpb24oc3RydWN0IGN4bF9yZWdpb24gKmN4bHIpCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IkJ5cGFzc2luZyBjcHVfY2FjaGVfaW52YWxpZGF0ZV9tZW1yZWdpb24oKSBmb3IgdGVzdGluZyFc
biIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Y2xlYXJfYml0KENYTF9SRUdJT05fRl9JTkNPSEVSRU5ULCAmY3hsci0+ZmxhZ3MpOwo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycigmY3hsci0+ZGV2LAo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIkZhaWxlZCB0byBzeW5jaHJvbml6ZSBDUFUgY2FjaGUgc3RhdGVcbiIpOwo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVO
WElPOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycigmY3hsci0+ZGV2LAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiRmFpbGVkIHRvIHN5bmNo
cm9uaXplIENQVSBjYWNoZSBzdGF0ZVxuIik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIC1FTlhJTzsKPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoCAKPiA+IMKg
wqDCoMKgwqDCoMKgwqBjcHVfY2FjaGVfaW52YWxpZGF0ZV9tZW1yZWdpb24oSU9SRVNfREVTQ19D
WEwpOwoK
