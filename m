Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E946E0354
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDMArs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDMArq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:47:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272A33C31
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681346866; x=1712882866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gv0iDNId1ztsZubQP6wTKQEPVqBsBgCN2y3d2A8oFxE=;
  b=Zg18sWZa7frqhCFNyOmlQsvipMnrZI5n6b6ND5L4MHGdHFdESvbbUBDZ
   WKmRkgUT5oHH8NhdHDbl3hxsKjWSJBe3SGhGJ1dZr9nJMyXRfMAsKmrV0
   LXubyNfsr4RnroSTh9M8Tn6FnQJHLotJl+uX9aPICYhMbI/KH8RYx9OFi
   EAFol/HSrbh64ve8mJ6vBZoQBply2ZLn6ipJ+S8vFwPxmCsDXXJnVYAF+
   08QUUt9ERvpiKxo+bRvGiD+9wsVA4zfCdC6NeJQ1voDSQMNx0auHoxhid
   eYARehOdcdxXVmgx0HpvE+DUXhADbI5tHJzFx1ZIiXMf96Rv59wogSh6n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="409203534"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="409203534"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 17:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935326111"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935326111"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 17:47:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 17:47:44 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 17:47:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 17:47:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 17:47:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZgXfixRUV5dSLLcv+1q+eGBpRHYLwLMEyrki7JmBVixz1RAwuk+c7ajwfekz5PMK2e1VFF9jcqZlj9rNghSo8suxdR7US/jFVnRUQGKNLUBDrsFtGJQ+QwaY18+OMfOaHPvmeamkQYNBvS4k2OojBplRnSa+ni907IDl4VYjvwL6+bkFHk1W3yyo6yV+QJ8w3MU3oDUDNDEa5TEQ/QIUPWLf8YBAtr9wjPAi6yYbNWe42zI8amS6bGk1E4B85KaG78JCZ+QRaCjKq+yTMZmIk2gXvNYZ+i7pT+PKeGgECx0xpfbeVTPQf6tVR87fzF1peESNPXESb3v2wadyWCT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAaV8J9pG+fJHGqEydvHqm24D1IvxozSywJevjTukps=;
 b=h1vNdoJmprpaXaEX6R5FveVqDfFo0tGV28HzYFEaaJzy9D30wUgDyQDk78RZYuAIpvhkYp9r9QwLqHryz+GIKY0/9y0AKTb9IZm/3nT8Cw91f36dZscUihAVUUpbE5iXuC0MVfbAibzjuwjXb5PDxjFs3Nw7dduT0JljrBXspuUFztlDjVFwAid8gBx0rYA7xgI1h6En3pvjI8ztmy1yh9f0hk3ubm1JAETaKDmIrlYZseWmYNZqW5lp4fZOqVSilCHwb2f7U4WTW472F+pyWkWzDKC3QNAAihnVkBmL5H3LqV5At7TGRTf3FUAwRz6aI6YRtljBn35uow+WoIzS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Thu, 13 Apr
 2023 00:47:38 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::259a:3153:7a85:9179]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::259a:3153:7a85:9179%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 00:47:38 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liu Shixin <liushixin2@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <muchun.song@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] mm: hwpoison: support recovery from HugePage
 copy-on-write faults
Thread-Topic: [PATCH -next] mm: hwpoison: support recovery from HugePage
 copy-on-write faults
Thread-Index: AQHZbFDq19fMxv6l/0SbTe2cXT0UDa8n/G4AgAA+bwCAAAbNAIAACa8AgAALdoCAABLfsA==
Date:   Thu, 13 Apr 2023 00:47:37 +0000
Message-ID: <DS7PR11MB6077389EC65455200379F872FC989@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20230411092741.780679-1-liushixin2@huawei.com>
 <20230412181350.GA22818@monkey>
 <20230412145718.0bcb7dd98112a3010711ad0b@linux-foundation.org>
 <20230412222138.GB4759@monkey>
 <20230412155618.720e6b3aa5be6444f7889ea6@linux-foundation.org>
 <20230412233719.GC4759@monkey>
In-Reply-To: <20230412233719.GC4759@monkey>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|MW4PR11MB7125:EE_
x-ms-office365-filtering-correlation-id: f6966695-adf3-4331-e430-08db3bb8addc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: viW0cC91c9u4bQpET16iALQQ7HK3H7ZPAKH68CIUlm1DNLraGOEWwHJcJlqQVApYgOe+BzU+k4MxKRZObUNM5yn5xa7ygKA+3Das0X4zBxDDIyq8ulnGWeApedCLL4R5Dde80Lh2UUIGTVaHG6kmBhP02bHzZLwVsqJyEs7BxqhV6S+7BefhJUyCQYIDBlvm5m1/0X+XLwgu+SRj+y/iDVClHMxvB63EGqOoOBRTLFn12qbvNSoa0s4tO8u+ShUtGwpybxGo6VBk/BkX4OLLkiM5pgQTX9O5f4iH40MgCXudAsQAPbdjaMVHuv+BEb5jhpkIMoAUkU+xE6Z8R3RWfN6FAnKEk8Y14xObGIcSK9knx6yatAWB8Yda6gf5IzxWCRM3mNx9glAg6F79cHLATSJjlZbaeJXNGj7Ck8IUIHke+AN+EgkvURQJN7gquRuZWZPpB/2E+t0JrBx3g1EW/2r/2R+xvSauT4H6BMZxY0NWsU/EFKEpyoIbGLBNvDS5muR0kwnda54cK+zmAyvzB95BH6YVPT+VV3mTtxkibdLX7T4OU/yXdCnSqM5SaLY2aKwjIZlziIG4IakWNYG2c205ka9t+CGEwPBlgPKUb7UFLlkZCy9eA5qcVdtLxwHr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(55016003)(52536014)(4744005)(7696005)(8936002)(5660300002)(86362001)(4326008)(66556008)(66446008)(66476007)(76116006)(66946007)(8676002)(64756008)(478600001)(33656002)(38100700002)(38070700005)(316002)(110136005)(122000001)(82960400001)(54906003)(83380400001)(2906002)(9686003)(71200400001)(6506007)(186003)(41300700001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hi12X7HAbgE6EPN6/exTdHnYzxX7vg46mRzErX99acxncwfWEH2ESIjmCr/Y?=
 =?us-ascii?Q?flm5T2aAIluI2CLf4QmAcIqQJymAvgyohbSooKbNux9dkXLsD3WSA+7LjzIs?=
 =?us-ascii?Q?ipc0S1TOTQak48V2e3gZGOVCKoI4SgPWocwuPObkJt2A0oX0dR+RxtKNXF4w?=
 =?us-ascii?Q?ct1vM51jNLlzCr3Q5fAL2OOZA3L6mkVFcdXcowzTBkoT4wueogfDL76NDV9d?=
 =?us-ascii?Q?T8Lcir3EkDJWE20bcMngqbRfJuN1SoEVWsaFwObtt26MdCmpgqrcvCXf+m40?=
 =?us-ascii?Q?mEq8FTkErsNcx0Jr/KrxAnNQAEqJwjpntjWcps/IhEKjnRxJzCrrGDl8n3Sy?=
 =?us-ascii?Q?U84v8/ayeJjPdKE83wdb9y7aIrX2yXYy27HFvRKe5n1qYBGtxpI4klRB7JOf?=
 =?us-ascii?Q?f/bi/FsJ35K58d1dMCX2ZQ9jL+zzTUQws+XRxD3vPr9okSEW6X8UPCJpXbXU?=
 =?us-ascii?Q?0QaxTerLqOiLRtFbCQDqU2kflk+i00BDLrUk1+TyVfonkpjw2gImkVQQwnQ/?=
 =?us-ascii?Q?+v9+LaWCFn23chfxO9nYQM9H7Jjz1vNsHWgas1IGOY0jXxG/gSJb4bJ0RxIG?=
 =?us-ascii?Q?igzQQDADvcpgmgD4ZLKjjm5ArpT0d52VTvNkxxSQpuaSjo8AM7xohhPAFynK?=
 =?us-ascii?Q?VeGe1bcXykRjL/oLz4d4N+m75v+ICIWjHkgP7oz6r89+wMJHYVqnl/RK+AA6?=
 =?us-ascii?Q?unrHb7UeTJXDYEjmRP5VP7PkvSDS93Ev3CK/W97pcfgKEXWAWfBzzyz9UGYM?=
 =?us-ascii?Q?uOsdYMpmRSQb3lkatkgDxvx87naHLXMZ12JZAlACxsxH+rcTifpwssSVwN/0?=
 =?us-ascii?Q?HRcragZY/4OqRIjtU9gQ5LMvZ9Fu959D3YdjFFwsAZQL80y0h7fJ57KaNiVr?=
 =?us-ascii?Q?QXtpWQmw7leQgb6mJsX34ecJfWfdiJBRVg3HsmSQkYH8+SzClU/fHvDEYpCG?=
 =?us-ascii?Q?UMEkS85HXykBZPmJVJI8wdtmSh37ANmXxyx7m/SBNxqnRpsKmAeb5YBnaVtw?=
 =?us-ascii?Q?uQquy9iQn893mFLseOik9rJhKAl3vtwPnSt4IdiPmACScY7C6pBzAwh65Mw1?=
 =?us-ascii?Q?5LkGb/d95Y+IbqDHUIJa33Jkvthbl344kw/mHrynDJSpWn2XDJRjMNMu5C77?=
 =?us-ascii?Q?l43RezItw7ofwebs5wYCkS7/QaUQvZY+f2Ozm7yVwog3WXvlLGZhyWhDagNJ?=
 =?us-ascii?Q?bKL5GtOMZM5PvdidkvEQutXf3qW2VEy08W3lrxlFqqQynBvFXo9IZEe4FBNj?=
 =?us-ascii?Q?a49IzDU13TouMNAwJBvlsKc7IKufkLxg43nm4Tj2NiDjUm1KkzbLHSzPODwU?=
 =?us-ascii?Q?VM1EpHJkX0NQ9eZCpe5j7GfTUaANsITxkH8a+WcXkpPaGTJfVdc+5lKePB1G?=
 =?us-ascii?Q?bruhhaUSoGXYP7MTCOCF1t1n+ehq46Y0Mb9zhJIcIays4ol5HlYejWkPDJx5?=
 =?us-ascii?Q?/+0mR9Mj+v30PcVW9hg9naQtiH5awIjypt5Z3xuI78zzQTFVtmSuW0bdf6DN?=
 =?us-ascii?Q?VYLpb2AiIrJt1fI94CYw1lytadxHjSoKBSgkp5hoven8IUGSkOJUQIr/BeRs?=
 =?us-ascii?Q?wF3xRXRqETENAm1DeoA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6966695-adf3-4331-e430-08db3bb8addc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 00:47:37.9907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79TaNht0qLCNIP3IV/hdHh6hIQYctLqm3D8hUzmuj8KyiH5f4To7SjIn1d3JvaXnHM59g6c/hnqdctTcnHzumw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7125
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I do not think cc:stable is necessary/desirable.  Why?
>
> a873dfe1032a was an enhancement to better handle copying pages with memor=
y
> errors in the kernel.  IIUC, we never handled that situation in the past.
> I would not call the fact that it did not take hugetlb into account a bug=
.
> Although, some might argue that it should have addressed all callers of
> copy_user_highpage which would have included hugetlb.  IMO, There would b=
e
> little to gain by backporing to 6.1 as the issue of copying pages with
> errors has existed forever.  Perhaps Tony will comment as I was not invol=
ved
> in a873dfe1032a.

I concur. We are gradually fixing more cases where Linux consumes
poison data in kernel context. But this is an incremental process to
improve overall reliability. Backporting to stable and long term releases
isn't a priority.

-Tony
