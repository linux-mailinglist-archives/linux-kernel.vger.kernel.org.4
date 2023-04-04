Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64D06D7033
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjDDWhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjDDWg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:36:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA4010DD;
        Tue,  4 Apr 2023 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680647818; x=1712183818;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X5/3Eof9b8cxvFRqmlKBT0kPiHsGp/8xc+8AclKWkTo=;
  b=L9DjmHjgGDP4Ynz1FK4lIGDtKlVzBp7sGnfIcLZ4+SY24pLpddAYitgX
   NrChjNk4TNVcR4CdsIsCo8UMtCKid0UbC0KkkNKR14i05YaEWpQwtvNEz
   TU6oKPE6HQlHo/IoUklf0J+YbOaZRQ2oT9RkaVH+ISxjOnhrMk9g1Kv5n
   zpd3eL0b37IxhH8SnUPvGoOzEncANiLqAknEkaAgips+Cxsf7aFyVtXjR
   WoxbOso21bcmlSFOrofBl/lnD7YQYApMytq466gn7H3R8v9Cq8jCgvo33
   3heWAgw6M40aecbo95VNrjI5XF5RFPmNw7i4Sq2ocZup/0nt2W1Cmq7sn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="339812459"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="339812459"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 15:36:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="686541664"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="686541664"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 04 Apr 2023 15:36:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 15:36:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 15:36:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 15:36:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 15:36:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyPhcvV47R3gWyk1Wj8tJU/QgZRxEtV2j7erzjBYn07qm7ueSqmintn83Xil9IJ3B4zx6hjQd074cRVhDZ50oeK1Fw8goLc8vGyYsmHsNZ6GBhweCb5BoJYA1H3wsUEvAOGh3X2c9F8GCqpyomjXD3FnnyYCiP//zB9pBzWrkYBDVY2h/zxtkeUdqKIQVrMihjPZ4hRxN5n8bzBw53zWf6rnDs4U+Uc2Tb3Ch8xIa3L7uc5v+RNyWPCTdoBi2M5F6aHfqpCYV/xZLm2oHW6wft94uK+c/vfSL3PmZriOHilRazjMruomd3KGs5FCDDP+KkNmbP7+V+7VwAaQkKbRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EWA1eCJ4XIOiuEOglz4HsU7m6w9meCProgKqo7xgHs=;
 b=DnBG8kNRblZsYarQZ1eyx145JtbPbibojwsC/7WAR7z0+sRDcEVB8La29rtXixUk4up4ZKEK8EweyyK3F4fZ78pQ+eOwP0TuCD1bULXYjQiRv3rrOrV6CAfBRlA9Zbo7I1bF4uSedEp9QwhAECW1cpffg9M2rNK4ckO/ND37fdy7rHgZBc+mxYpe6sdo99Ckx2MVJSpsMu7a9Qo0f9sqsqS3/CoTkAn9rdhkwqVIxODhJa9a+1KJUJpp8mmT5XVzErSWCxLRXw/FAa8YWzpVXhoUfl1SZPir9RlCErmRpm7yMGfP9PpU/GSuXUQjwYG1nedm59Om1HwMSfvbW9uwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 22:36:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 22:36:52 +0000
Date:   Tue, 4 Apr 2023 15:36:50 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: RE: linux-next: Fixes tag needs some work in the cxl tree
Message-ID: <642ca68223b2d_21a8294df@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230405075704.33de8121@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230405075704.33de8121@canb.auug.org.au>
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cb2a84-1c3f-49a3-2711-08db355d1614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGr8q4RCas6lEPtco9P1vmyGWaUwmPO4WE6Hdx71eINspMHJEqX3XQaFiZ0K4wtyn38cjCtlK9CmIoxhHsbcEJH91vvMYNG4oBvv65r0ACRkIchleqo22lANNG036cvnUrUfByjnprYuYKKo8lVIbj6nAwopYZK9I3e0nIBD82GnrmPIu7FaCAzrlcK3tZYjWonG3DsM9a8P7ORz1L2wUasiTOdKpkCZN+9IOdH2Ju9KNTB8LOC5YvjGlkW2Mpmm1T5/Fvg+9uun8Zn8yqWeFDA1NIL3KpeZNTaReuB0TlEHoHT/BtTpD8kaQXtNs9L/lVz8S15AAQN0GFqpkiXbNl7+QvC0e/lXvfy5w2Blm9HCc9870EqwE1qtZynbFBuNmsqDaU5MOFZiDs8SklIK6WfN8BcQsFV4A3oe1cvUh34Rb/XnJAqBRzlnzHypMyTms8KuboXJfajhtN3ms1EtWFF/St2P1htU3Gg8syhE3DfT9RI7TC9sGJO2Z7Y/ehrT+Prq/nzbxVYrob09qhg0R058TUU3Ve96jvTPuWnRwQIaX+c268PbZ6MJzbSO2OCS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(186003)(6506007)(6512007)(9686003)(26005)(2906002)(4744005)(82960400001)(6486002)(5660300002)(8936002)(478600001)(38100700002)(316002)(41300700001)(54906003)(110136005)(8676002)(66476007)(86362001)(66946007)(66556008)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Ff3HWIRsL5Q3pkjg+o4j5EsnjHfF2mN8tsx7WAVRN0ftOi+25pVRL8RSNXz?=
 =?us-ascii?Q?psaJx+t9zV/D3IabtHVotT34dQMm0Ho+O/xDt3jMAwnzcEjhaNRa+DJM30BD?=
 =?us-ascii?Q?5cTIQNDLv8D4JArGMMYw8CnI38L+/KCpydx6bLp9vsYYlaDGOnxxcYGD5Fxh?=
 =?us-ascii?Q?cXUmgtGvPdVBcEKT29BeCDSakCAcOSSUy8k1nanmSvU5oxf+pLaekyX7w/jE?=
 =?us-ascii?Q?8XSEnSE6VCeepXnkQIj2IkP5AHULBKoOhbgt2+CLgNVMc9gnbhnj3kU3deXa?=
 =?us-ascii?Q?7jEv1F2KrlwKBcjLIy06rAWol2Y40L8brfu7YLB2mtoybp3PkYUT1TtwlzhZ?=
 =?us-ascii?Q?kPgYIeJ60u3oDZfRW//kR9+Bm0GVG3LXHP7qLwmEFyPUywR1jxpmeL8VCybx?=
 =?us-ascii?Q?DVI0bBzY8fPkFM5pDZA2zyeFkXQsbDbJ6MbQQuAQRKuudfJ73u7ZIhfQttDN?=
 =?us-ascii?Q?gk7SesMoUsnSccuxPKeO/8lDDGq/V+YDTU0ODGTBfkO1LyatQH+p5Lla0VQB?=
 =?us-ascii?Q?fsntF3hgr95I07nnD0CvUuET4ClZrGOlzVU4m4kBEecflrR9JmsBddnG2RGY?=
 =?us-ascii?Q?/fSXBKlucKHjcU4uXifTEgM+yTqqnZEWhR1ILJSrVYTYAVMTMnyqy7uG9gL+?=
 =?us-ascii?Q?J/vwMuH2ncO1r8dR0AORs5Tm65UVOgdar5Eo0o0jAsWGbHoaqgqIPzUViDCH?=
 =?us-ascii?Q?fwR2t5D5HDn3ZBqtb9OQHqGRtQnEQdHVLIppScFBLLHbh4JYgSlzyJAh9gvA?=
 =?us-ascii?Q?NoMBZIkMrBHqWcVSKpKXl51j4eYxG3orWsbO6QijaWOTiME6zopXpTtOXMvN?=
 =?us-ascii?Q?TuARlc1QRpTvaO25ZkpFQZh62oQDYpl07dhzSX4BDbdlyesPhXhMNe4e89XP?=
 =?us-ascii?Q?0ev2vS4CxS418wBubd8EaiDSwNQUiQZKDDRkfVMUSuDKsNzjDPCsMntV2GGs?=
 =?us-ascii?Q?KrteeBPPhtIQONzUz/nis0T3WlHtX7Sc0/Uumyn5AlaYyhP8l42LwmBAmMib?=
 =?us-ascii?Q?q3mFDfQyFLdP4r2rCAKHAdhL2Bsca7t66fvxXYKJ/WolVmEufYdvlW1iJr6e?=
 =?us-ascii?Q?z484d2fYFdYGZDkfrS1gsOQ17fkOWZQu+JNEujB42lWlhhu2idnXMJQ/o3FI?=
 =?us-ascii?Q?iHyE948ydQqrtDxqTEgecISv58dZiCQKhFO8/nrPxUhtWTLxEPF48cXEanSM?=
 =?us-ascii?Q?pXJYtJMeJAzrJHiFONS0i/0zP7jeCZzm0MjihbUdQNZspw9QsWeZi7hc3xAp?=
 =?us-ascii?Q?aUTh7pzwvziL7KM/Gw/wtDZAwYsghmMeyZpYE7grmouhv0UM5fegc48Ay0Xp?=
 =?us-ascii?Q?2Txim20tZDX+7LqGSrrY3OxeH3Vn2WTBejMZCzbt6AH9FazbEh90RcqStCne?=
 =?us-ascii?Q?UlCxy+ClSSB70o+NbBCNkAvE6ngZgrvlb6disakNq1bxTtYvqGhcBItrFYAN?=
 =?us-ascii?Q?hi7PpniQqdmH723hCdkDrrxkCFRTz9rGfHVM0sRkVOsYCaFajFmb8PKtMI6a?=
 =?us-ascii?Q?QDiaDlVnz3XxUc6OsjBaAAj67ECWV3fWw8NW0hA4BdcTIm2iLjsRd8+LNRdt?=
 =?us-ascii?Q?7GKA/RfjSkzPNCCn9KJXILlXplp4aJIUEXke2Rm6DagxY1z0KJ2r5QJTidHc?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cb2a84-1c3f-49a3-2711-08db355d1614
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 22:36:52.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHubKGP9a8DIkBzIi4QclPAJF5Oqb5Fq+BQybswjWe8Aoe5yJ1dN0tWcFuCkZQDelF9tAjCAXaeTUY8F9h3O8UaamlFgotqey0tHIhoBbx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   570739ce619a ("cxl/hdm: Avoid NULL deref when component registers are missing")
> 
> Fixes tag
> 
>   Fixes: 757f6448b100 ("cxl/hdm: Fix double allocation of @cxlhdm")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 518dd2bfb981 ("cxl/hdm: Fix double allocation of @cxlhdm")

Thanks for the heads up. What happened is that "cxl/hdm: Fix double
allocation of @cxlhdm" was an old fix that had been sitting in my queue
for while and I discovered the bug in that much later. Treated the
commit as upstream when it wasn't.

I went ahead and squashed the follow on fix to clean up the upstream
history.
