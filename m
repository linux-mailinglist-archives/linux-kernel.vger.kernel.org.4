Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59DE70D266
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjEWDbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEWDbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:31:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD9B90;
        Mon, 22 May 2023 20:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684812665; x=1716348665;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A/fc/7oMq531j7KpOurejbbDn44fdGqklGwAXntbKYA=;
  b=J7dhvcjco0LF6A2O6Ld2j16HdqqmQrpXoXkTEqwhJJkUXcdg7wRXFrMZ
   /xS5bbQ4Eo5onShrihMCkxAg6jZMLzjWYklCoJg5ecUktbIy2iE7b9ioh
   BA9pnIRZuomioVxNMAdC6xvRT11+H22M/DlL7Omi6eyQ/le/fgnMq9myQ
   W7hlgT214VRcekCW3a4MYgRXDz7Nidls8jmqK4qZ+vcNF3h4ZIDDuz+VJ
   GwKJoXxp9Y4CP1+qBO5S6LBFN0JJcCelHKU7ief2kZ4ilSNvw+OMlAyjq
   WUvJ7p8C1d197OiiT11xBKjIEe/kKmcHEtXg/CP/+3FvrT6Tx6huTOI4p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="333478495"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="333478495"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 20:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="773634871"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="773634871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 22 May 2023 20:31:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 20:31:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 20:31:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 20:31:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 20:31:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9Z4QwyvOrbPW7SRCOcu7AQ3El527pTLa5s9Y40uPyGuNi3aZZSUp2/JxsTbKEElZAeMckhdfRQ5ZKvkrj8+1KchKjsqHDzwWn2YQI6l7ux8ymqwdTF5l6LLiORlv/IbLqHdySjnK0278stNT8tzoRerMAIRLH4TffZnS7FUCUTlUA8HVNhMOp7EAQSHkgz8jT0tDHiLRcTCsbjVhu1Tx74OgqObPKAscl0J3nZC0iQsv/xyT/kMae+KkUGprCG4OK0/jsQ2ca+dbrsp34Jefi2I68XzPt8PYkpKkoqiAZg08bruHhE9n7fN8PJja3WqG2fj/0UqVNhDPH2qgHCxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ1wYwSLBFdcdcnm3saVJ5ENQaF/vvaK977Nd5tzhvQ=;
 b=GqcqyA9bzHa8wjOuUkQ/rET6ZDzaBRJ7upoqxBk9FJ19mhHhsWzId1OrfvzlxNZbzil3azczSlaUa+XrcE7/S6oaAIXECN2FcTF02OqYuxx54hLGQrsj0uOsOYIgxCyTX2VPwTWfCQLxBHtzF7CX0+qF9B4UFAnV5V0vsijJvTmZSjTkH7fJCieK37XWkv7h+0lN8e3gA1/llUOMP81mjSRnlMeQ9wjpQDwY+n2IjZeNr9o1J7li9hdtF4vJ2PvwJflhs2yofsNulNjc9vQmj8/UI1ZIb4iekP1NUrhJ1hhceMpQm22yEub+TgKOEJOqEP1yGCi4hVZz7LYSLEWT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW5PR11MB5883.namprd11.prod.outlook.com (2603:10b6:303:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 03:31:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 03:31:01 +0000
Date:   Mon, 22 May 2023 20:30:58 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>
Subject: RE: [PATCH 4/4] tools/testing/cxl: add firmware update emulation to
 CXL memdevs
Message-ID: <646c3372b3330_33fb3294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
 <20230421-vv-fw_update-v1-4-22468747d72f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230421-vv-fw_update-v1-4-22468747d72f@intel.com>
X-ClientProxiedBy: BY5PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:180::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW5PR11MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: d98f4499-0129-475f-e401-08db5b3e2182
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c33+oJ9uFBVeisWkHEfLyVYlebQ65TSyLRhAC7nNFjRWavtAtBG9qwVATz/hpgYushgrQY+Ty7xfDCWkQJDx2Am53k8rQINQdf8RZwgkJ5hdj4aNVHmY5IGNNqcmKM1+uy2Qu8QS2ruE01TebVr5ewjyblYgVY6AdOCgILLUROYu0txJZJkZOfPoLkDV3DDtYVf9jM3l67Jios2Jx0bp7iumNqFw1nRVk8zuiRPxzx37lAoc9SdRNB5hRWRnOcpLfk+7SE7G2pA0fcXG6UOYO2y4b7hcN6rZ/ncwkdIZgSN6qf2INHWm5sWO79Ju6V+HP6g6YMZa09mir13WragPtgDH60KUp9ek4Ks5fP5VGLR1DeyJGUdxK1vuMrL5Vlf2zuqNIGhTXRGyNzJ6DCiEAcrkYG1/B2PQjhAVx1Jn8p5jHhaE/GgO7ONckNgBfLvZZ3QAMtNSygQM8XFJVujlvMMctxc3l8hQcmRkwJKTNRxldsl2/RzG/zlmvwqumwEpgXDLCyl8TLtvAfFzJahNeFsxjsXf3G3BIjOuCRqUl3oUGahPqJbpuuMSIbj7wc6X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(54906003)(41300700001)(6486002)(110136005)(316002)(66946007)(66556008)(66476007)(4326008)(6666004)(8676002)(8936002)(5660300002)(478600001)(86362001)(107886003)(38100700002)(82960400001)(15650500001)(6506007)(9686003)(6512007)(186003)(26005)(4744005)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3kQNrM+DaGX4JHbsOL+63po2GG2BgdKkQrSxYyLSJbL+RtXhlicm2vC/C2b?=
 =?us-ascii?Q?hIxweXWmAFXp00WSz+qunHzoaACVjA+GBiFbg4n6djUWgSZjusnOcZG1hMNc?=
 =?us-ascii?Q?muvH4tbbuSC6aDqo0LLiu5aHSzC6VH5tt7bYHqImQ04lNbOA2s2QZfGADJkl?=
 =?us-ascii?Q?7iCochkC6uOf7UaGIFiqkPW7GtVBUYsiCqjTszAmz6KqldfLXsrcr32u65O3?=
 =?us-ascii?Q?v6y2IWtSkmf1W9Cwxl7v2qLCnb+LzA249bnoFrValXvUWBD+hUqi8D61WbrU?=
 =?us-ascii?Q?tcq8I0Lh0o6IZlws/3AOjQjAsOA2Me/HYxLsoWjmgZJD3qT7c+ifALWDYOSr?=
 =?us-ascii?Q?I5bL1QDkyz31AuOfJ2r4vqFysY68EnOmtuy184gN7cW3eCLQpJ8tDN5tjy7Q?=
 =?us-ascii?Q?7sQVLw/zS1nzov+SvptCD+XqRLrgjzY7p8SoPwJtdUieCVnBxr2+DY0EpqT4?=
 =?us-ascii?Q?IEmithsCoML+pcYbln0xuCUNFioNXUWRM4vfI0Hbu0fcMYYPKhQJr8X9Ia4L?=
 =?us-ascii?Q?XwvPbeJF9g2vePJlD6uP/7AgdEQeyfVpBv7MsdPkklldvfUwlSbcAqHf0g8T?=
 =?us-ascii?Q?RLBYG2MPOjPRdppgBQ2ByX4OmW/CS9CWNwYF9Blr0ISrnj9G/BLR8iH7OdS5?=
 =?us-ascii?Q?HkNTr2U3DSnjI53yhK9k17CFLHMCblkryaocD2itpxK6qnWUBBqfiADaRRyV?=
 =?us-ascii?Q?T6tYKlzJ3aebbO019cK40EH+T2Tnfe/EiUmtcgvcN6tw3XWsGVI0tI/bf+EC?=
 =?us-ascii?Q?40rxWXOX32/Lgq9GOal60VcMMeJC4VYy9GEw/1JliZESUJMk9FsP88/xtrEi?=
 =?us-ascii?Q?8hB5hfL/UqKrnNWHimN7mGDF9rYDrORei0pd6Xf45SRRlSzVsGQcEWs+vbxn?=
 =?us-ascii?Q?XcjG70/cMsllDpqNzgg6n8OKNGQIvq2PHEcPaG1P7eBsmRnIEdmvRvpzEsDv?=
 =?us-ascii?Q?f6auoGBHKXuAo/srGGayVfX7CXd3O3DJLqWpHQlFAnP1v47kArgVr82ZsmSX?=
 =?us-ascii?Q?ZqD73U/a85Ni/kgi6k/GGkzFzCdLHxXFPTPTmnD8Ret6JITxVg82qIb+iCAx?=
 =?us-ascii?Q?96bPZ/n6LzrunztF27PVqilSe6TQrPqxMcITSKkJcDjYSaY9wpUSjMzcKc6q?=
 =?us-ascii?Q?W+faeFkAZJB04+C1EFjFf02zhMTmVoS6wXl9XOzk9GGWiGjfEK7gYk3oMLic?=
 =?us-ascii?Q?uBg26VhnFhOUjWo/SuYko5hVKpZYvT7fauesV4b7OsBeJbfQmsMoflsRyIq1?=
 =?us-ascii?Q?bKBkTV57mhIdXzNwlKsK5XQvuf3JbcM1HczPk3gKQURc0u5gWw1uTNGdZriJ?=
 =?us-ascii?Q?9qGTacS+lxx6K/WNeB5Z8MO9UYdUiFix96hzo6nVCpOjPZCdYYIBypIcTCLX?=
 =?us-ascii?Q?4URl2jemjo63++CouQH3HDEv4rZmd1w5z0F9qGVSfRALzrZvxCEumjxOC5xM?=
 =?us-ascii?Q?AqjiyRi2QCmVRF6OVJP3X2FBiA+QzKhS9fIsxC/5YZMtkcPyUMs2omBj1X8u?=
 =?us-ascii?Q?rSVQUcBouKOto2BwTUpLQg/r8z0uiJE4e6hkWt1ZoBLWRnMh2ArS+kAqdQwx?=
 =?us-ascii?Q?iHwaWnjkQXxyVze9ucSNj+WHl6KJ1riSIa1lwZBmqgvfdPED2+hweOWhGwLJ?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d98f4499-0129-475f-e401-08db5b3e2182
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 03:31:01.3550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCFdPNk0EMPpbHXZgukFR+vVaJHlIWsoJFFhr34u1VklHpWu/CWc64IDn13diuoZJ4kkbd1DOvmOWYeNa6rTn7voF6NYVuKfOJqyIpSiVs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5883
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

Vishal Verma wrote:
> Add emulation for the 'Get FW Info', 'Transfer FW', and 'Activate FW'
> CXL mailbox commands to the cxl_test emulated memdevs to enable
> end-to-end unit testing of a firmware update flow. For now, only
> advertise an 'offline activation' capability as that is all the CXL
> memdev driver currently implements.
> 
> Add some canned values for the serial number fields, and create a
> platform device sysfs knob to calculate the sha256sum of the firmware
> image that was received, so a unit test can compare it with the original
> file that was uploaded.
> 

Looks good.
