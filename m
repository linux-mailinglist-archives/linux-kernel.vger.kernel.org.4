Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59F37321DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjFOVoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFOVof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:44:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836752965;
        Thu, 15 Jun 2023 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686865474; x=1718401474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jqwzdjhSt0prTH9k0Nq/ca98gtmp3eA653DBd0HHxpk=;
  b=LNH3L30vRsoviUglPyt6AaMF6fcN7T6Rmv7OECtNJ1jMJY1TJu9EnMMB
   smxg0ofkO7BeAKBQVoY48L3HVBZ2DhAbSv+S9HPHhSAHzjwnEJoCkicVc
   fc/+ZD6QnEURfgIBAXXjOh/GLjLmB02N45mqg/IbVLt3TFxT4PE2w1A77
   S2IDM0tgxoUrYatSivTN2u0YlLjyyPjiMGbFDwwO/pwjVsc+O7uU1h2HQ
   2AFiyQ2GxOpu+n8LXocar7+Gn5QqJ6OB47kjKiNbnxkQ0kNOlDzZy6OZD
   AbH8oBuq4GDXahD2VlTvhSqrGkzafgLfwKc3hx15S2GY0uUm6GO8DFfVk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348755390"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="348755390"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:44:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="886846796"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="886846796"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2023 14:44:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:44:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:44:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 14:44:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 14:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIxUY4yBhFb4toLjmGCRqus6OKj7cQBpa1gu221XcjXWxxUe8ar8In0q+/nMH+Q77k4GvtafO5kW0qu9ESlN4wUBKRNDLjxqsdff1ybdLNO3g22DDAOzuFJmc/QskciXrbdEdHQhsXHmSqqgyJ3h9FkjClCYuJF3Jvk3uh/gW+Fdo+JE3kLHkbAdMEYE7SyianuF7lxFup/SEaODhPnNXi0mhN+LrERA1c/36EstAfyqB68gBrbofD6O6o0CXsvxohC15WvbdnscDTTGuqpXV85uL42x0OsKL0VdGKHLNlmRuTWSkRRq0wyIXG+c9QvvDgN1rKa8rhBhdEFqYoOlrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqwzdjhSt0prTH9k0Nq/ca98gtmp3eA653DBd0HHxpk=;
 b=JbPCvP41Cm4F9Rh6vpmrB2YBjtasXsm8hSyM0NVpMqRAtLyJjoP81riS0n46eFGN3DfQ4U9FjadLnnRAy8urC+rUycyvxIon6lgcjNnHfCUDc3znhn/a6TZC7fgRcZHT0xOWz74mxJOg6imYLd0u3lOkR0klVo6KFRU3vNGoFzy+wS9KmxQ3EXXD7s8NUx0bzn656ICbWUeACd3KN2eaTXKIg4Blb/kuHjYsQYSTLLIYBqDGavOYoXgs5lULGzl1jYHMMVMzGg4sYs+rbbyEdqrwOVy7sFekco3ZoxwdtTUDuIeNOR08SoFs1Y1qi/RrtrdpMB+PTBIeLPy76eOLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA2PR11MB4779.namprd11.prod.outlook.com (2603:10b6:806:11a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 21:44:13 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 21:44:13 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "darwi@linutronix.de" <darwi@linutronix.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "chris@zankel.net" <chris@zankel.net>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "dalias@libc.org" <dalias@libc.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [patch 12/17] init: Invoke arch_cpu_finalize_init() earlier
Thread-Topic: [patch 12/17] init: Invoke arch_cpu_finalize_init() earlier
Thread-Index: AQHZn9KFWTpjQphU6EGy54KKaxPsoQ==
Date:   Thu, 15 Jun 2023 21:44:12 +0000
Message-ID: <b0be67b75d1c3f6b0e98b46a56b8588b9b9e4b2a.camel@intel.com>
References: <20230613223827.532680283@linutronix.de>
         <20230613224545.612182854@linutronix.de>
In-Reply-To: <20230613224545.612182854@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA2PR11MB4779:EE_
x-ms-office365-filtering-correlation-id: 36c54e95-8df0-4413-f6f8-08db6de9a89e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r8AaIkSiEA96KplMSUI6LGeyYoAB9RNDgdgQc57cfd45jClI9n/79KSy6y3d9N/AyGgS68RsgZaJbadlOhAfLmNQw5ll+KRorTJ3ituZknRAJeFl4+xMt01hAScKHCZ2eHsTiXHfJ4AtIkBLBRhEf/Vn5XC3f4883/+2SvSpBVBUcDJERP1EJULmQqiGM8rmF8DAwxV6slEea6GqxHvqqf8ibr7CVuu22ceN8sNYFd0+oPhCUWe5gLORl8tk6ygNuvfzGfA6U4X7WP/VBYdYsbWqm88JBiM+Kbc86GqvqFUAlrJcGubYYW10eO74ANURO/ws/i32iw4g6W+avzZchnuR0Ymsgv8c0dDKEDR1Dgdvyt0T36A6ZYbIkq9YMZwxWW4x+grAiw9ueMJnOd/1ixqA9VUJ7su785ow3AgC7okhUYE9Dl3bx0u1KFhFSKZquzEu1X9lsmegvoaUgiX9T8hU8Ge0GwOPXFKRTIpKrBxBSwNjOaD4+v00AjPKl4PUYsj+wZuCwjmmY1XL5djGBNj9G88ZJKdAzRlP7Z6kLHQCrDWQinm1jQc0ZJDWkM+ZQfU5LlbpoqZ0VhBK+TAPpLOT+e2aQR1cFFH96TIIcAl5EVml56+gVm8xFJvNx55b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(122000001)(86362001)(38100700002)(38070700005)(82960400001)(5660300002)(7416002)(7406005)(316002)(8936002)(8676002)(41300700001)(66476007)(66446008)(66556008)(4326008)(66946007)(76116006)(91956017)(64756008)(83380400001)(110136005)(54906003)(2616005)(186003)(6512007)(6506007)(478600001)(36756003)(26005)(2906002)(4744005)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmpyeG5XQmRPSi82ZndkKzc1STVMZitJa0VKVDBLMDJYbWVjS21SOU9aUHJB?=
 =?utf-8?B?MjV1ZDJmMmJuQ1FBZkNSbDB2M01OZ082K2V2OVBvdTlwUGJSZWVrUW9zRDkx?=
 =?utf-8?B?d1k3ZUtMVlAwQXp3ajVTMjBMb2toN1hocGNkR0lEQk5IYzQveG9UcjhXdXRT?=
 =?utf-8?B?bDNWQzVQaFhiVjFzeEd2Y3RhMzUzQWRXZndud2xCUnZRSjFNb0tXcnY4UlQ4?=
 =?utf-8?B?bmltbGs1QXdsRnY2aVpwa29KSWJMVDZoYTU5eUVHdzJGK2FGa2h3Wjl2UGgr?=
 =?utf-8?B?THR2cVVLWXNtRDNoeVJUdy9LMUg2WENBT0FkeDhJWGE0V1lrVmhIRTVFNFoy?=
 =?utf-8?B?eFN5eEN3ME5QemYyZFAwUDV0UUYvYXRCUEo4aURFMnRMQjVUYkFqajU5WWtW?=
 =?utf-8?B?NndaR2p4OWVGV3hxSDNIOW56RnVBL2x2NFZhZGpIR1RRYWFrbHZ4RG1DZzlO?=
 =?utf-8?B?eEd4QzdIUE9XOGlnOEVSNEd4YTYwTWZPT0UrOEJNSFlxUHFPSHcxdjZHUk5J?=
 =?utf-8?B?RzFiUllOZ2t3WWVpVWEwQzc4RTZrOXQwZkF6T0NZUE5uUjl6N2liYW9RWDNH?=
 =?utf-8?B?cXJyUDhNOVNvVy91aGJyT3I3QThyYkMrUXVYYmFVazU3SitSZGplMmNuUnNu?=
 =?utf-8?B?ZVp2bVk0UkZwUVFwaExMUUhGbTR5ZjlrV0pMQ3dySjJkUlhtckxSVW1GeUVG?=
 =?utf-8?B?Q0NRNGl6c3BSSEdLNHk2ajR3UVlpY1RDVm9janAvd1k5SGQxaU5qcWd2cnNJ?=
 =?utf-8?B?MU5IbVhJS1E5Qk1GMEUzeHRBNDVZa2pPYVlTaFprQkFjbjFDQkR4K0d4QXBi?=
 =?utf-8?B?anZSWmxuc3owSUM3bHdSc0dVQ283cUg3Qi9HVk9hRGgydmhwV1MvbEMreGdv?=
 =?utf-8?B?WUdQMVFaSzlvNjRQSTJkYUY0YWtOMTBjK2dka1dhd2d0V1pidk5ZMUY2dlAw?=
 =?utf-8?B?cC9zdERERTRVc1ZQYWpleFNiN1JrU2x0SlRsaks4UFJZZ1BJbFRKaWIweXFG?=
 =?utf-8?B?SExaWjB1SzJmeFhrdnlya1U2a1JzdEQ1N254Yytwc3dEQ0htMWNjK3Yva3Iy?=
 =?utf-8?B?VHFLZXRQSGJXNW01SUpUblBKbmJobEhneDJJcFhwOGVGSzcybTRQVExQcGtD?=
 =?utf-8?B?Uk1hRE9LK2VrbGtYSGFIcjRaU2NUNkordmlrVDJ3VllLc2EzRWw5czQ0LzVZ?=
 =?utf-8?B?dGVodEJ5TVZQL2xDS3J6dUZvZHR3ckVhM1d4ejU5SU9sZTliSUVicEs3eVc5?=
 =?utf-8?B?QlZLN1UyUlJaZXZ5YzhNbllWSlVxT1BrVUllb05QSUo4L2JsOGZHTUpvWWxY?=
 =?utf-8?B?cG8yeERTbWpWN3VqNVZYVGk3ckEyYlVSQzFsd0NTRWx2TnNINUpCU3FxbmhN?=
 =?utf-8?B?NFlMQ0twOWhZbVVNTFZtR055YS8ySVRndGtxY2FoNi9Bbm4wRmZoZHJqalBZ?=
 =?utf-8?B?UkkwMGtEQkNhMEdCZkhYRUlReWsyeFE4WmRoQTNiVDVpZTZPWGFkY0Z6Rjcz?=
 =?utf-8?B?Y3JZWDA5Tys5SFoxWVdaL2hRM3VQZzB6aXpWdGZnUDBKUUF0NHNYZFF4eG9S?=
 =?utf-8?B?R0h1aHVKTjRKZVRibFNGeWR4L0R0YWFhNDF3eTMvZTlJVmhHdXUyUjhMYkJT?=
 =?utf-8?B?UVJBMWd1YUIweUdwNWU4YkxKaWlyNmN0akhzY2oxSmYzbjV4TktqWmFScElz?=
 =?utf-8?B?OG8wM0RVSEVES2ZJaFEvMWFlN1JZWE1BQUlrdjY3aXNlSUxVLy9IaU1Rektq?=
 =?utf-8?B?NDNYbm1BKzQwWiszL3hab0dXV2JxaDFML3Y5VDhJazFtbkI2c2pNN2NSd3Jm?=
 =?utf-8?B?NExxaFNQakRRdzYrNkR1YWlTcHR2K251V2EySXFrUDhjazdqMXpKYjRjdGZ6?=
 =?utf-8?B?UVhOU01CUTY4Um54Wmh0bUFLL1FyMXE0WDVVQ1l0OURHWXArU2xRby83cUFG?=
 =?utf-8?B?MVM3SVhYQzVzNkF3S0VudDBSN1VSd0d3bUkxSU9VODdybjZQV2N0N0NwNDJF?=
 =?utf-8?B?YVE3WjBXcTF6V1dZUkM5a2FCSm9nTnJpSUxiS2ZKK1IvMWVueW12cGh3cnUx?=
 =?utf-8?B?UG9YWngyVmxNYkRMYnVwZnN5QTIvenZ1L2RtTys2bzluU3AzbTUyMlFnMmx4?=
 =?utf-8?B?OFpFY3ZxdTd5cFV0TzIrUUIwWjArK2FLckJlaFU2SllDN0dsK2YxS1BrOFRs?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A45E2DE49F57049ACB0CA5269B0AFAD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c54e95-8df0-4413-f6f8-08db6de9a89e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 21:44:12.6801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44MEWmuxNpit5BOAoyCW0T9NROcP9SepkInOGvnaeyEusF8kDFYgQ/mEFpnZ94YiCCI8NOXm3WCyxXpqQFe+Ot/2Y1odMYAyWlIG3c4DM2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4779
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDAxOjM5ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IEZvcnR1bmF0ZWx5IG5vbmUgb2YgdGhlIGluaXQgY2FsbHMgYmV0d2VlbiBjYWxpYnJhdGVf
ZGVsYXkoKSBhbmQNCj4gYXJjaF9jcHVfZmluYWxpemVfaW5pdCgpIGlzIHJlbGV2YW50IGZvciB0
aGUgZnVuY3Rpb25hbGl0eSBvZg0KPiBhcmNoX2NwdV9maW5hbGl6ZV9pbml0KCkuDQo+IA0KDQpS
ZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K
DQpJIGRpZCBteSBiZXN0IHRvIGZpbmQgYSBjb3VudGVycG9pbnQgdG8gdGhpcyBzdGF0ZW1lbnQu
IFRoZSBvbmx5IHRoaW5nDQpJIGZvdW5kIHdhcyB0aGF0IGxvY2tkZXBfaW5pdF90YXNrKCZpbml0
X3Rhc2spIGluIGZvcmtfaW5pdCgpIGlzIG5vdw0KY2FsbGVkIGFmdGVyIHRoZSBzcGluX2xvY2so
KSB1c2FnZSBpbiBzZXRfbWVtb3J5XzRrKCkuIEJ1dCBBRkFJQ1QsIHRoYXQNCndob2xlIGxvY2tk
ZXBfaW5pdF90YXNrKCkgY2FsbCBpcyB1bm5lZWRlZCBiZWNhdXNlIHRoZSBmaWVsZHMgaXQgc2V0
cw0KYXJlIGFscmVhZHkgc3RhdGljYWxseSBpbml0aWFsaXplZC4gSSBtZW50aW9uIG9ubHkgYmVj
YXVzZSBJJ20gbm90IDEwMCUNCnN1cmUgdGhlIGxvY2tkZXBfaW5pdF90YXNrKCkgY2FsbCBpcyBu
b3Qgc2VydmluZyBzb21lIHB1cnBvc2UgSSdtDQptaXNzaW5nLg0K
