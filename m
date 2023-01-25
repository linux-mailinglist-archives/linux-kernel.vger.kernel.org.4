Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BDB67BA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbjAYTLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjAYTLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:11:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877EF5CE44;
        Wed, 25 Jan 2023 11:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674673883; x=1706209883;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+lVhK5+1dgmYygKB+FmrYpDfiJKi8axDWk4Bg4RoAh8=;
  b=XiwuRVPcqLbcr/1zMDNl6ipewu3/ut+yiPdCa8+/68t+B4itFsxKpt0y
   6ZDKCke4D+gEPoojBAWTZJs7edXYQXQ9C87FpQ1g/Uh5j5hLXzEUvnPW8
   ysNruewPwZlWDHcLRsOS7FzY2Q6sRrEckvghBC3KSJIOVdIdI6lWjFLqT
   RsHQcBAuDGCZAe8tQjeVXAflFCG2CfXUCk51cEsiE7Esg3NKMaPW2QUWj
   44nj7M8sjC4J1VqNWMgDcWm1EVhMjSt2fo+wD+wk550HVmFWLEwkKjpSY
   LE4ggjVmnD+jBLZDn8uJ9TPjzIS9gjKXxwQ4Ibwgsail2wXLeYfWsdL7f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="328735303"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="328735303"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 11:11:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="725993589"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="725993589"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jan 2023 11:11:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 11:11:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 11:11:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 11:11:22 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 11:11:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tjkk/xTf3BV5aTuJIlHwpHZe5HnQTZwr++57mIDANUwiHScoogh0S07cBDpvEV+jQfO+R3moxLa+LDSoqET+vtCMQcO0lRB8NRvR5plD00szKWMbjK6TkvI7IsVX17/XJvcI73o8bmMEL0pUp8eRLvQ21wqE2HhxLSlZeH6FS9o9UM/4nHv0oQcyKzs4R2DMjEXkUpDCbOsYG20AelkgZ+1QcD7eNOklHzR9hoItBTloamkECq9ClMG2hPsRxtzxL/7WxNTA0adj7vt+bOjqGxyhrG+NdScvhM2Cr/+eSSkWmbMFW7567Qc7GSRGuSR7OTYbG9DPZMzBeqwDK2qbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjjIKkJIzqcT7p01g4O1DUrO88IPkALzkUqhWHupqEU=;
 b=YH1ydN374Ng3VuIdnuOYJO/G/A8nOhhLvhVdQHtcRjbtqjncllg2MY1iizUq3E/1MSsaS6bWm7AyvS/nDuNWSY7I1o2fPOK5ryssWodN8JnYvPMyz5sLsGytLruqZk1MR1voso2EvKDG0PMpXsg7yokjUKLWlnBKSIe7erjsPFV+J6zF+IpMUf6meD4vMfcIyKNwBypOxOFbihpw3I26gk9xOsrLSFh7aiqG0wpCWOM1l7qPMj1JpLhUPbsJR0h86C+SYTQ/+2mpDTpzrRIq1TbVuQLmKZryK59Wc982qO8dsDeKWChgbhYdLqOcHdQp3yoXtkaArL8BAPZeh6Uc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7079.namprd11.prod.outlook.com (2603:10b6:303:22b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 19:11:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 19:11:18 +0000
Date:   Wed, 25 Jan 2023 11:11:15 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <nvdimm@lists.linux.dev>
Subject: RE: [PATCH v2] nvdimm: Use kstrtobool() instead of strtobool()
Message-ID: <63d17ed343624_3a36e5294ac@dwillia2-xfh.jf.intel.com.notmuch>
References: <7565f107952e31fad2bc825b8c533df70c498537.1673686195.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7565f107952e31fad2bc825b8c533df70c498537.1673686195.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: CY5PR22CA0068.namprd22.prod.outlook.com
 (2603:10b6:930:80::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3b10cf-31c7-4225-f2ad-08daff07efff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMgdJW0YOsnY6ubJMvxPxeLPQMTrEG5h7DM2dTUjhutW52sGADQ+6RAcx1P4iLvJOZl8b5sMdJQy4GMv7AcyIr5mDl3hPE9707ZsIjHOMDcPzYfXJTouaNeYKNLNG2kDjQgHVrks132q8QajQGOIUyXXn4BasjpZ+yQTI5xBJzgEq21HOLjv+mUePLkWfw+7WkzWKqpT0EQ96As/Ll1CDR5ZOgxWTQc1Nj9ACs2R5qqneXn9Ify5LJ0xRNlpvAWaLlu/vJyN5SxjPq83oRPZRpMl73tLIxQjeNmwqQ1OgN+n89JQP2zxrmiW/BOamZYQplzat3KtOoVcG5RaBzvkUV3QjTwKN4ctVkfQI9FiV/2IrQVlHiGqS3m8f/veWQCxyqXOiStGKQOeEAMKKB3WzTv/qnY9zDD6aBZoV+ki5cmS3p5+cPMVdT+4qEsUaON2662DCFBsk92hqrF35zJ5bupQsJOSyW6Tw3Uqtx382D8Ubiar+AL1rWHO1MMp9PPRJUSOAwuQlJcILinqOX8T7pxYjMYPGDKIWDnKSToGlvB5rauTHqHSg3gSzD7qH094b1RPdZYnmgMSX+B7t5OKtrFZ902NeC4zBn5DeGIURWxHT+eTQ1pwHEA4HxYh5WXlzbrk9lFL6/6DnUeiKCeIsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199018)(186003)(6506007)(86362001)(26005)(9686003)(6512007)(110136005)(6636002)(316002)(66556008)(4326008)(8676002)(66946007)(66476007)(2906002)(41300700001)(6486002)(6666004)(8936002)(478600001)(5660300002)(4744005)(83380400001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gXsucJ8TXumOv7ohSVvR0g7a+QyFvdzmcwUaXX6Ek9qKBO3O5tnT59FQr7jJ?=
 =?us-ascii?Q?whUUMD9f6ZU144iAK0x5pV3ZSUWSl/flBCpQ7ntRJJG05WED5pKxsbJ1SKPb?=
 =?us-ascii?Q?qZdO3mJXgFjjdAzGw+g77dbIDordz3uW8fDODouvhqy47lZCv9EtTTtwFWC0?=
 =?us-ascii?Q?kxb9YepulzUwf8XZ1QmPF9G8MjOGO73RJ23wzvnACefv6hyp/vfHDOIRaJvn?=
 =?us-ascii?Q?J9NoiGxYreMZpVK7ZchM7zL1ntH5+5mND8rCJ4XNx+aZ9JBgc1WQc188ogtZ?=
 =?us-ascii?Q?ptb6WaQBh1e++EHrRYkfuRo+qCiO5Mp9qYWOrXZFAIuUx6V/pTLusi/XJJR5?=
 =?us-ascii?Q?GkSLItzxrcKPA0uMJX6QdV7tRddTlyYig1NWR5CT9dmwFpaV0OQQr21yzZVM?=
 =?us-ascii?Q?BfE45eLBaMVqSN+6sjhVzFXgWJqk2Hg9dLx9933a1brINmvtRF3WwzqpzqBt?=
 =?us-ascii?Q?MuH92zKERcetvH6Lx3DiC4g7aBl6Vki/JFqJZGD3R18+xxbXywdp/YuEhDlC?=
 =?us-ascii?Q?G3fME5oIKiS/iM9nFHgKdzbzDL29UXeaH9wFcTd2nK0OfevWPwHYk7+CKf3q?=
 =?us-ascii?Q?VdKwhbsh2VUD6shHOqJVSKTOp4dgeoDV/Ho7P/Kc3MujBNxP5Bokwl7075rD?=
 =?us-ascii?Q?DD3hX7Bu5lEfBf0KUc6EQQYYcuMoqMUZWfhtskR5eeb9L4nX3DtyyYMwcy70?=
 =?us-ascii?Q?zKBQaoXfYJPl5SisyYxZ9LUMHp/NRR6ZayVckjO0g5N70yd6uwz4g+MC34Ft?=
 =?us-ascii?Q?P/8fC5qQTJfl3lI5h/2SuxPRMfQBYPCSR5oWeWOUb8VyxeEza+kgtAYm9VEW?=
 =?us-ascii?Q?GuRr0W1x14aYJdShXR41rJlJFZgULB2tK8hUOSgJWbFnugaC+6gNKnVBr39U?=
 =?us-ascii?Q?bHgXftUvlr3FpzYDgN0aSRK15LDbHbJrqall4CVeykuL7ERyOP9J/gsO+YaT?=
 =?us-ascii?Q?/dbqhspaVZsz69EzBeQrKq8uUJumX5yWXv169TGR3mPavkH8IwRD3C3gHXhF?=
 =?us-ascii?Q?45FEpWjx63Y2U56+9G4diGESxJW3e6oRMKMg1DD8YYjcnn2TafDW5zkgW9dK?=
 =?us-ascii?Q?QGS4Z1Ws2CO6w5MFSs2Zgyhhcnm/hlFTFe/eIdHCBOzn3Ujel3XhJSUDTWav?=
 =?us-ascii?Q?53OF4oZ05LrYvyP0OR9qEXUIHv12xzejAvdi4kZe+TBx1vDVu8/2/7tszCNK?=
 =?us-ascii?Q?nd0aU3C/k6SmHNiM3Ue1g+F7VzKBwdl72VbSdcPvnnoIhjQIcp8Cv9PbCKPQ?=
 =?us-ascii?Q?zRlv5eMyPoyYWe8Vm4qdXWCG00vWxS/NMscTSN75aHd+LSO+hb3z3fiB/Fs/?=
 =?us-ascii?Q?DPm0obvjxHVQm5LSq5X2rrA1Iruu1Nnoh0CWozk28n22xu8qUPXbn4fS6MyL?=
 =?us-ascii?Q?5QwXAN1Ap4YzCAcR0lEEsPZf7D+ve4RzH1YUXe8x+4K38OkRFaBsI/Rcyg8p?=
 =?us-ascii?Q?oFxi9GWcbGD7BTqhjtdF2Ri8rEHgokly2fn7pPxNxdI+EP75TOD4cFwoGY6I?=
 =?us-ascii?Q?e7ZTMR0Gjf9qIIAQskpIt8Q7bIxYuqia94+X586P/Je9yzxvGnX3tENBo0lp?=
 =?us-ascii?Q?De/oS3K6n/gks09gMWTgeprbUZBWe0V8FxlhOcSh5DAA+sLR7ueto32e/XCh?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3b10cf-31c7-4225-f2ad-08daff07efff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 19:11:18.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG70rKsTfrdhcha5rWEgo3sVhIHGzYeenDkqm4VmZAAvix3NiDNBX81xDW6v5kYxNPQlmgAWkRG742LmxiYqfG5nGlAhBxricxyJZT+Izi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7079
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch was already sent as a part of a serie ([1]) that axed all usages
> of strtobool().
> Most of the patches have been merged in -next.
> 
> I synch'ed with latest -next and re-send the remaining ones as individual
> patches.
> 
> Changes in v2:
>   - synch with latest -next.

Looks good, applied for v6.3.
