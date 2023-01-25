Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8FD67BC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbjAYUaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbjAYUaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:30:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8C153E7F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674678607; x=1706214607;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D1/qez5DgTmR5bFwA0CMKCv+SxgKSsTviVx5RNLckFw=;
  b=FMYnIPl4ih7uhEwksaCdSBjruUsZI9hPjLa9wYaedLuIFYQtWd43Q/qF
   niFANj8I7iDnqv9wsy9fdgUB6LofZk/9DB/qRa2Uyi8nShBILkmDThh9m
   HTjbEdLs+K6oESkoXTeTEZiFd8oU2lKoNW5DOddui9U+m0FONhff4stFz
   mRIrseVgergeuojP9mjwMMZZU0nnWZ4BeOhuxny0PEn5lNtxR6upe9MwC
   qY77kstxzZEpnnpuT8a2NN3HdHJvgwc0AlJX4B4LfI//y/xA8819KyEm2
   N/G3OwqE7vxzUVGIOqXkOu8O0vbVxwpABFJmx3ODRZQY9f8X9lcXz8uxv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306329983"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="306329983"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 12:30:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="694860483"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="694860483"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2023 12:30:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 12:30:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 12:30:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 12:30:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 12:30:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBeFuI4y49BYsqdLsUKKy6n09IVUgBFaoxf2QhXYpx0OPgrfxDTtsGbuJ4selr/ax5ukUmcN529DVgUORGfevhYDby5H1sTkeOvbcoLQKFv7XPEalOzmLIQCDZh+63P3nohKVh3DQltNULGqAh40jaH1n2ZZZHeDCv5Q3IccOf4HTFDB+iPa/o9kAJIzXX0V0hQfdcOuzGuD1R+yh5MBklvbB8cpX2uXBiHzDISlbJh2Yps6rAPpTLlTJrIY6dge9/fH2gfXElOeUy4qMoee558dGZkZbpet4w2Q9nP1I0xCRHE6IJseDHfDeq1pYsrhAXFMHNkIXSB/5FCbVrnLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChlCC9eo7cmvLliUwo1X634jIn6+IXKTpvaIVBPtBUg=;
 b=mJRwvs5veK18YfLHRlFtBrZcM1dXSLYt8QK/b4+OlqApqTijGfVBC9eJ38fwdWCztnNb+avVgQs6HBMT2bsHMaLRQh4N3+jxERwpgs/dtPKKqK/IRpL2taQsthG5GtUl7E1p2oyaZam047oXNj8jL9B5KqQydBIdDtqruROfrh8/BuwInF0dALDLno7z+U6AJgmxcgGNLN6Wf6RINGPjUvcPBuEl7hEDiH7+NOcqJhEP63mjs+Z298hnWC8KgE7gTBs9pDGjeCjFqfMgVEm4FUfpg3q7IW9EiwlGQi7H3NwMWshN6wpm/5HCGhmTCUN2HBXuEunTuA0Rm4J3Uymc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 20:29:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 20:29:58 +0000
Date:   Wed, 25 Jan 2023 12:29:55 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>, <nvdimm@lists.linux.dev>
Subject: RE: [PATCH] dax: super.c: fix kernel-doc bad line warning
Message-ID: <63d1914342f18_3a36e5294ac@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230117070249.31934-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230117070249.31934-1-rdunlap@infradead.org>
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ad88eb-99cd-47ea-bb92-08daff12ecfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VetfM3pFrn0HcT37XPEoIcHcguF4pmTz2CRvg4ksUt0TRBEQqEGmvHz5Cqq64/C3hTtaxQq7JljjsS6oMyFSxQ6G65GEyIPzgcBMb1IKDK0uJLIJSuYp8wW5xhlHHuT6IPs5BVAi3a27l+7TtaIRsg18NLYHeFi3HOCC5F1lr2oHR+Ok/MzBeSM7osAre+nm9XkPAQcZndgSke+kSslP2fhaaiaNI3hGe9zqZENfYR0FkYQdaWPxw/DxpJWPQhRB+vKev5TKIYVi7txo+hAII6M5EQ35kOrlElWuU5KyqjdXDye5svuBzn1kAuIE+CJNAvXWRQbAbsMdEk4akXyAcKNH8Am6S3V2VptdZLwtkd4nI71n5KRfv33c1OtFfce5U2QgTOUHETAdsqx4lbmzLnN+3FCAQ+/FDEzmk5cDRyw0AUY7PpNSXfg7pZAumKetXTGCdRn0cBbl2RFQ1ZHknrcmWYQmX3JYI97vErtJVKr1XF5fr/SVeI3yG3s/uDCM+HRZ0EhVM6tENavJ3271eIAWphqhEhLKs7gfb5PCM3xYUkKYJ8Z+J7ekrzQyjVQKDreEOZS5cWgiBU8tWtConwYtCayZS/SPUrNYjALMe2p7AFen35XsAqjLC8gNt0njW5DOEzvPrBCpssoLAeh1lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199018)(186003)(9686003)(6512007)(6506007)(26005)(83380400001)(2906002)(6666004)(4744005)(5660300002)(66946007)(8936002)(66556008)(4326008)(66476007)(86362001)(316002)(8676002)(54906003)(38100700002)(41300700001)(82960400001)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g8sERkmoMLr1+crWfRCzvAMX05H0wb6KK2yJiUXZhvCtU5VXVgs4Yq3PGfC5?=
 =?us-ascii?Q?hFyiQaQaXQziwC0syQiMnGdQTkFAZDntW4J1sEBM/V740f3bVBhhcs/p8psA?=
 =?us-ascii?Q?PoAjJqeBqpyunKPUw8IL1139O33+BcQQYb3fB7JC6NHH3Gh/t5qGr8FNQqBf?=
 =?us-ascii?Q?kMtb3EytjJr7z2CEf+lEAsdkxYnuHhd/TWPZ2DqHxN+gnJQB8Sbls3lWPwz3?=
 =?us-ascii?Q?TJxs15QKMdNkhhQU2VXU874x0FrGCqaaVqsWgjo+jjkdsyjaKnolLWtNqHu5?=
 =?us-ascii?Q?7Jhadaq/+XrdwxmAtD39BKjPTI9PfVi2c4teU9NVxGVtZ9a1QdefLSOs76aA?=
 =?us-ascii?Q?8WjokrkadJWT7aivW/m+2++59TA7UDm/wWbRqdyRL4UUgECK/HwEEH7Sl4q6?=
 =?us-ascii?Q?ZPjbjqxkmDY4tJNuJI3BdoxvPMXihfVLOfZeazDbbHBxUyBi5nJWes5C5qJs?=
 =?us-ascii?Q?/Zm97IUFBjo4AUyqahigUdUOe8CQue3P9f45fOW+3hSEn/WnTHMX/aEkKcqa?=
 =?us-ascii?Q?FMWrWqhQz8UiAmLJjNyNsOUi/ZGdVLs2FuuFT+dDU+C3cFUgRTZ1l2uruMBZ?=
 =?us-ascii?Q?cTEmOfhJI1GDOM/Md/jUL+zalZlnua7sAmxRSn6Gix3fk42DIdBA2UcfPIV0?=
 =?us-ascii?Q?kWvih/uZsGNNfy6QTCYbt4wujM0P1kUMW5QrTHXGgKCls4IEgO4p2vi0y6JQ?=
 =?us-ascii?Q?h8UrlcRwsWAhf/YVerTijHAllh6Mejat+2CBxjN1Fjjb+oDMPA6c/FOlmjdh?=
 =?us-ascii?Q?ChDxe2XAKhta9AgO1zN/d030hjQwHrdscf/96sh952zkqLXwRa5DTnxePngo?=
 =?us-ascii?Q?9ehZiNOD1yo4nAs3ACrwnuDSwW1zRk7PXcKeSCFdWoRkpXGLI3j1eMWqI0ql?=
 =?us-ascii?Q?cAjXQgM1Vtpq0N1zgyzqWfWto/3WdnppmUsA8CbPFktluuBadEKLi73/vh9G?=
 =?us-ascii?Q?dIBZLfoOJGumInjZm88B6TK9vH3Wa9AyaQg+CGFG+IK3jyeQtTYRkCdL/Gzy?=
 =?us-ascii?Q?p6KzzbSNJSMJWBYGhuH9b0iwyFGUDY2STvwpwFwuv80/8kWQnX11Fynwbdym?=
 =?us-ascii?Q?9JbASV7bvXQFT+nPpiR8MA/brEroktu6+Pt2PTB3jadyhLg0Q3rpY+W+XdSR?=
 =?us-ascii?Q?x+Gs8Y0BJgMNNaStwmNJddamxKB92bLf5WjPSwDSmC9yo+WsHl1zgzCdHNOT?=
 =?us-ascii?Q?Ddc/Y5wkOCnhrjD08okHdDqPqpm9V6JRhL84IQfuIeVoWNLqq/7SLv2eZuyl?=
 =?us-ascii?Q?SJ90a9FZSQRobMYMhUsOEsdii1iDiPYbvxxMckxbOm+nAY6Cthi7AkkIn/8d?=
 =?us-ascii?Q?z+z8b+SIqauZOoNIUu2r5QIbq1QpH+tnpVwGvIK8Qlx0am5pjOtoAZr9Kgg0?=
 =?us-ascii?Q?otXGF/Bv0kc7ovsPckvfZJ7VJfS/U/xwqEzkbb6/oUGqOpS15AA7rkvScnGX?=
 =?us-ascii?Q?R9aufXbxHc6TXGDMn/KIojeTPKFb7nGbhKaktqyiwFsAsViGat1S02s24VpW?=
 =?us-ascii?Q?s4l5bBNzyvAHN3oytT09MkTCb/gLgPb2PT9FsvDHf0f9+weGJeEvjlktAAJL?=
 =?us-ascii?Q?zMM5sJjtLVytvl1gIevPZWj3nAQ3xUNQrb3noHNiIHxKTlYsYN8ST876E5Xb?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ad88eb-99cd-47ea-bb92-08daff12ecfe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 20:29:57.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HJmB14SZjzgHrCgRrRQAO86/D+60L7010OsF3zWVxReb0vWT3PaDg1umeidLV3Egn0xCm0zJyVigT1/ZbgXMfiCP8Xe7OtS3NC+baeLxrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7727
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> Convert an empty line to " *" to avoid a kernel-doc warning:
> 
> drivers/dax/super.c:478: warning: bad line: 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: nvdimm@lists.linux.dev
> ---
>  drivers/dax/super.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/dax/super.c b/drivers/dax/super.c
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -475,7 +475,7 @@ EXPORT_SYMBOL_GPL(put_dax);
>  /**
>   * dax_holder() - obtain the holder of a dax device
>   * @dax_dev: a dax_device instance
> -
> + *
>   * Return: the holder's data which represents the holder if registered,
>   * otherwize NULL.
>   */

Looks good, applied.
