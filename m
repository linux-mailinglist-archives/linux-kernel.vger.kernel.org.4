Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D577105C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjEYGoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjEYGoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:44:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EF39C;
        Wed, 24 May 2023 23:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684997072; x=1716533072;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+4/r9oF6dU0Hy6oZ7Gzueuky1SFLNFY9hvkQuvTUbz4=;
  b=e3iKEYiMW6gjtAUBosfG/Kc/DYLBrjFI26NxQornkDXM8pqsByMP4zOs
   WZgQ50dJLKzEjB5XXkD1bqEm5eAxSoWGqpY5je1GNgEpgJ7dHFpYUVVwv
   FyUERWa2Wb7GfCMhlGDrKIJxR4n8sVWLP60ExOipFUh+Gw0zuJXwTaDMv
   OUe3s8h0bZ7kUwy8n6i2m/SVom4gmlM1dILnpBze/VCeRZqin696KwKCB
   UpQPsBmMxd6s322dSxzwOlOte9H2CpcjWy5lBwZTQk8Hl8J0H8fXxoKsx
   e5hL7d+mXHIN5cJaD3VxtTgIdQznUmaH4gIEbHSBhWXZYyEUXT4r/ad01
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="352644114"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="352644114"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 23:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="698864440"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="698864440"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 24 May 2023 23:44:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 23:44:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 23:44:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 23:44:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 23:44:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOLJ5c8tin6JbcDilbYsVNw/f85G5H91dGR5hpG/DrKbYxrdyDubHP6yK23bDVR0V1Qp3kORkm+nxw5ruG55+ZEeCkZg9qH3wsAiBq+WODSKqL74MaPF243E1bLJ6t4PoilR12N7DqiFAkhnszbFxu9zdOfcmp+Kv6UwuBdjVKi+tprx//buC5c1TNsjWYSutSnBJgWotFKmQCI7o0WAZmU3U6CulySeYF6VjjZMAqAd6o8JA3P4iSrX0Y2Jg6HDtOzTmWdVHd9xdfJ4NoZdetksLy5/Zd6/gEj503NWxkNuzsISZISByXaT/6TMXcvUrP4DUpEfeo2cKlbX0bwffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0RhA1m690ALkUa/nFoAZvXyHl/KVGvg91fwMJ4AYL4=;
 b=hu0glDxkvQbFk10RQFRjnPVt0973OeCo0Kl2hd+DC/Nt2SYmXaTa4ckLle2aG4UdqxIAozRtERaKT6hQPfW2UHaTlP3tFQ8RBEqGuuQM82SLxhF9t5vN9Nj8KCDJVwTxo8La67sz/rUULqRRodc73oaYM6OTm0wss114p3QssnVGhscaGDE9Q5PIpHNxnpOVRfbllFL6hGMnmxbq5WBaOsUIFs6lwg3meB//Oism2TJPKcS+WmbEczudDvtafftaenpevCK++yPBEv37sRLCh8GBCmvI388/OaWEzWxDVJcxyDe6AOMzlquF6AAWiFYIMoVHobxICoNyWh/qcmIjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 06:44:25 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 06:44:24 +0000
Date:   Thu, 25 May 2023 14:41:09 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-modules@vger.kernel.org>
Subject: Re: [linus:master] [module] 8660484ed1:
 WARNING:at_kernel/module/dups.c:#kmod_dup_request_exists_wait
Message-ID: <ZG8DBbIuNNe5muY6@yujie-X299>
References: <202305221508.753c7b78-yujie.liu@intel.com>
 <ZG2doZJrCK7Nlrqf@bombadil.infradead.org>
 <ZG3Ho7eK+KqoAdda@yujie-X299>
 <ZG5OGRDfIbMs6sxz@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZG5OGRDfIbMs6sxz@bombadil.infradead.org>
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW3PR11MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: d4282c25-ffa9-4259-c340-08db5ceb7a3e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f430uoNHvzhNgRJcK31VeaBqliTXy5BPbgRn0rPQgRJlYCP7rck8Rl27a2lpOF8z0+z+7iD2iLbOwVWDWrM2uNstjN44IK9YD2GW2cX0SlrNEzxUMtm+rezZOdi9QvU7W+hnTAbZnNdYCQXFZBOXcuWkgxbRx1zb3kJ6TTACQ2pdhuSTQb5OcS3ZSM/NaWnDjL8/TbwMkPf/ot5RMxzsPj0qU/udmB8OHA7CZo/kqiMB84pwI5GfOlmxLDzS6Ubv1cJOEuDsL9GJUaaqf1WUvFORB/ECGU4UWiJEmZCXiulXCbCWH7YtDDAvNemxFH41ovOnac25ptI+A6rd1dqKi/njA27Dgtpvv3Y9nEuS+uxO/i450XWX8Hm57h9WkTmflzfMQpz0scKtZcxq79nXRGMjCR5oc/0puP+KerLZQ75JP5JJ2eEj/7B0tm1gdPWHkpUsXCOl5e+uRR6vp1nhvZBqX1Pz6K4lGcvrzlW1UdgO2D8CgMyCU4h6vBShTd3AdDPYSgiNNGW3lL+AOA2ty9v25OQ8TOuZzV6KOBbmYWpIl9C2ik9mk0i558LeJdsWMa3t5Ggf+lAwiuI/bhahrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(38100700002)(82960400001)(33716001)(66946007)(66476007)(66556008)(478600001)(86362001)(6916009)(4326008)(6666004)(83380400001)(6486002)(66899021)(41300700001)(316002)(186003)(44832011)(966005)(2906002)(9686003)(6512007)(26005)(6506007)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W24fIr1FjIS11UHL6+BBno54rRN303dLxZrovOM/uqxMA3iL0BZUWHc9btNS?=
 =?us-ascii?Q?kPNAEfeifS2AaBq7Do3/4W0e4gZC3TNHwXE2Y4RL451tK/d3lw/8pYGN3tAK?=
 =?us-ascii?Q?i3trQQQCVnhO/PL3woV59l+MgpRMk584zbE8uiyXNmReI/nT4R5Wv4tUYUbN?=
 =?us-ascii?Q?hKzeVzEedLgWBnx1dv4SqUY76IAY5aoL1llXwvNXAnh6ciLLO9pVYGtbYeGi?=
 =?us-ascii?Q?iYFchYm+WDrNuEYuia2CbMd5QdiHGXcs/is0mHcpvSQ3lf1ajZuTV3a49D7W?=
 =?us-ascii?Q?2/SHXw4uJOMbM1mH4TLFCImV5T5A08RQw5vHygNFhMKlwNslNY6KIOzLBajM?=
 =?us-ascii?Q?zYol1bLuAKt8z5MpJ0fA6V4nd/gP1VUBdyQIHc42Jmi75/kkihida0fAoWUX?=
 =?us-ascii?Q?y43QoWeqzo/ABVDeGleXp6IM86WH0Cj9ByA6RgQEYtPjXHNwarHtLHTDDeHJ?=
 =?us-ascii?Q?/zbZGU3a7iuUHTax/5nL0fBsGo62ZsLJ+9qYIrXiRuoSWISLVoZHZpNBNlel?=
 =?us-ascii?Q?z7kVjcLXynYJ54Th+dqZ7X/ESA5ZlSNYTybwv46/1zR1+yE5NXjmsbAt3tFt?=
 =?us-ascii?Q?fxqfufiL3u+DBXTY8r8apyd5yJ8pQ4979A3dpB+SGEDIJpwDejQX90TFEMET?=
 =?us-ascii?Q?idEUjjW6HlN6BgUG6AbQjgZmuu/F4QAHl1u40XDKYNo/VUowzX7iBavYDe6o?=
 =?us-ascii?Q?1YG1WwfS+0IBCXPocnfTWIheQZblA4/tps8NVpoFiPxV6ieXJyZBgWAenDJr?=
 =?us-ascii?Q?YrAs6Zy2+bocBhpsjPNWNCv36k7w2H/SucqfVXKjmibNYbrpUrMOUItDSCk1?=
 =?us-ascii?Q?0QIp2jwu36/x2wplMmCsGNEYmN6Ybi4MF0laf/dI13W6dJIqHNQrayQ4/DuJ?=
 =?us-ascii?Q?rHZaq0c+RdYYHpgF12jrXd4ITeUniB29ExVhBAGyvKRiuAC6E3PpsaB/369x?=
 =?us-ascii?Q?J5V/JgbNNob9uPuyqd0wcUJjOQdIsJDnsi9flEcbCdh+Poph8z4+5Fw/Qojo?=
 =?us-ascii?Q?tcNNyFPjWHKbOS6+A+l2Un01e/ufvyCHRUv0nBHS0Jm0Gf8xYjwvucXsVlFI?=
 =?us-ascii?Q?0JeLGKIzoUDyP9Is7zMwQKtkp1c/U3O31Os3xts0F9HkeMkSYUvswyfX0XhL?=
 =?us-ascii?Q?Y6csoPOoiDoGrYX4dFYAmf9C6updzIM2U8nnaDDun7G7v8xALWxhSoE90464?=
 =?us-ascii?Q?odEpfEdAwzjpbvq8d0Ewwe7aObhmJnh1dgVTF94qumdP3qqw0njNrY5jb8fP?=
 =?us-ascii?Q?5S2y88pAK5jcNGMUg7KwDDZw/FJuiT7r13YrDY463F37I7Tvr+3YcATWFDjr?=
 =?us-ascii?Q?7H9chS5+Q4dJZBGm9G5D6S47GPqbdMt05gsrHHS+YssCgbL3fCs2wqzB5YvV?=
 =?us-ascii?Q?vhd2lJ2/EnakkOhcLu8qREnY96DG7vcrfvt0cOfhOhN1KGzNp3HGHLQwrI2f?=
 =?us-ascii?Q?Q0JVHNMxENcMH2NMmDUgaT7L+e9s7llcBOqA4A7VvHJOjNXBx+IyIs/ishYj?=
 =?us-ascii?Q?B17Yi6N6fTkg6gFtOJMDIzSQtVJpYiTlh9n8X6t8SnmOXQ27WTkK+NUU56Uh?=
 =?us-ascii?Q?YE/1s/crnEbcmPVuAWnQXGgYaRgTjGJVgDyKLIPv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4282c25-ffa9-4259-c340-08db5ceb7a3e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 06:44:24.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkSo6LxhCRHpL2g4ndI44/H+kA4tliWNu70GIrWE+nXeLhCHsylcy3UyILNp5kgaN6ecn+EpxXoTkRn2OhFicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 10:49:13AM -0700, Luis Chamberlain wrote:
> On Wed, May 24, 2023 at 04:15:31PM +0800, Yujie Liu wrote:
> > Hi Luis,
> > 
> > On Tue, May 23, 2023 at 10:16:17PM -0700, Luis Chamberlain wrote:
> > > On Mon, May 22, 2023 at 03:51:59PM +0800, kernel test robot wrote:
> > > > Hello,
> > > > 
> > > > kernel test robot noticed "WARNING:at_kernel/module/dups.c:#kmod_dup_request_exists_wait" on:
> > > > 
> > > > commit: 8660484ed1cf3261e89e0bad94c6395597e87599 ("module: add debugging auto-load duplicate module support")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > > [test failed on linux-next/master 798d276b39e984345d52b933a900a71fa0815928]
> > > > 
> > > > in testcase: boot
> > > > 
> > > > compiler: gcc-11
> > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > > 
> > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > > 
> > > > 
> > > > We are not sure if this is expected as this patch is for debugging
> > > > duplicate module requests issues, so we are sending this report for
> > > > your information. Thanks.
> > > > 
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-lkp/202305221508.753c7b78-yujie.liu@intel.com
> > > > 
> > > > 
> > > > [   48.705567][    T1] ------------[ cut here ]------------
> > > > [   48.706519][    T1] module-autoload: duplicate request for module intel_qat
> > > > [ 48.707866][ T1] WARNING: CPU: 0 PID: 1 at kernel/module/dups.c:183 kmod_dup_request_exists_wait (kernel/module/dups.c:183 (discriminator 1)) 
> > > 
> > > This is a real issue since CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE was enabled.
> > > If you enable CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE and these warnings
> > > come up a bette detailed report would be better. In this case the goal
> > > was to capture races of request_module() and so the idea for developers
> > > is to identify the module that caused this, in this case intel_qat, and
> > > then see who called the request_module() for it. They could try things
> > > like try_module_get(), but could also ensure that multiple requests
> > > won't be done in the code by using locking schemes or whatever. Only
> > > one request should be issued.
> > > 
> > > The trace below would show possible users but I don't even see
> > > drivers/crypto/qat/qat_c3xxx/adf_drv.c in my kernel tree.
> > > 
> > > If you don't to deal with this reporting you can just disable this
> > > config option.
> > 
> > Thanks a lot for the information. Does this indicate that there is
> > indeed a multiple requests issue in that crypto driver and we could
> > report to its author/owner? Thanks.
> 
> Not for the crypto driver, there are multiple requests for
> something like:
> 
>   request_module("intel_qat")
> 
> the trace shows who it could be. A git grep shows:
> 
> git grep request_module | grep intel_qat
> drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c: request_module("intel_qat");
> drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c: request_module("intel_qat");
> drivers/crypto/intel/qat/qat_c62x/adf_drv.c: request_module("intel_qat");
> drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c: request_module("intel_qat");
> drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c: request_module("intel_qat");
> drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c: request_module("intel_qat");
> 
> And so there should be one request issued, ideally.
> 
> Nothing bad happens of multiple request are sent, however duplicate
> requests means that you can end up userspace trying to load multiple
> requests just for one to be freed.
> 
> This is not a serious bug.
> 
> Soon, I'll implement a solution so that even if duplicate requests get
> to userspace it won't trigger a duplicate load in-kernel, and therefore
> duplicate module loads won't have to free the extra ones. At that point
> this becomes less of an issue.
> 
> request_module() just calls to modprobe, and modprobe is supposed to
> check if a module is already loaded before trying finit_module(). If
> two duplicate requests end up calling modprobe though there is a small
> race that two concurrent finit_module() calls will happen as userspace
> would not have seen one load request going in before. The issue is that
> finit_module() uses vmalloc space multiple times for the size of the
> module, even if the module is a duplicate. One vmalloc space is for
> kernel_read*() call, the other is for the copy we want to keep around
> in kernel, the final copy. If module deeecompression is used another
> vmalloc is used. So in the worst case 3 vmallocs.
> 
> A duplicate request could end up being failed only to find out a module
> is already loaded, and so about 2-3 times the size of vmalloc space of
> a module size could be free'd just due to a duplicate.
> 
> We could avoid memory pressure proactively by trying to issue only one
> request out.
> 
> CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS was added to detect these possible
> duplicates when they were triggered by module-autoloading, through the
> request_module() API, directly from the kernel. It turns out that there
> aren't many of these duplicates. That was the point to the exercise.
> To proove the kernel likely wasn't the one causing tons of duplicates.
> 
> Because if you enable CONFIG_MODULE_STATS and then cat /sys/kernel/debug/modules/stats
> you will see tons of duplicates. This gets worse  by the number of CPUs
> you have. Seeing little reports of CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS
> proves the issue is elsewhere and at this point I'm certain this is
> coming from udev kmod library usage and it forking and not being able
> to detect the same context for the kmod library for loading modules,
> and so duplicate module request go out for tons of modules for each CPU.
> 
> See commit 064f4536d13939 ("module: avoid allocation if module is
> already present and ready") for a graph of this.
> 
> That commit also prevents having to do one vmalloc allocation if the
> module is already present. I'm going to work now on one which prevents
> the first, and so duplicates requests coming from either userspace or
> the module-autoloader should be harmless. But that is not merged yet,
> and I still have to post the patch.
> 
> So in the meantime CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE should only
> be enabled so to try to help those who wish to be proactive and want
> to enhance the kernel module auto-loader so to only issue one
> request_module() for a module needed by the kernel.
> 
> Technically CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS also implements a
> way to unify requests for the same module into one, and they all
> share the same result, but this works only for non-async calls to
> request_module(). That config option is a debug mechanism right now,
> but we could make it default later.
> 
> > Not sure if I undertand this correctly: enabling
> > CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE can help detect multiple
> > requests issues in existing code, so we should report to the original
> > author of the modules that have this issue,
> 
> It would be an optimization that they could make. It is not a serious
> bug. It would be a more serious bug if we had tons of these reports
> all over. But a few, no.
> 
> Come to think of it, at this point in time CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE
> should just be considered informational and debugging, no need to report
> anything to anyone becuase I do think I can get the vmalloc wasted
> space issue figured out for userspace and kernel module-autoloader,
> and so this becomes a non-issue at all. Yes, it would still be nice
> to reduce latencies by having duplicate requests not be issued, but
> the developers keen on that would enable CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE.
> 
> So I'd say enable CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE only if
> you want to avoid help avoid duplicates yourself. The kconfig language
> already is a bit clear about that, but we could enhance it to explain
> the gains for developers who may want this. Since we can't talk about
> the future though in kconfig, I think the language now is OK.
> 
> The bigger source of duplicates has been determined to come from
> userspace, I'll Cc you on a patch to fix the last vmalloc wasted
> space, so that this would never incur tons of wasted vmalloc space.
> 
> I'd recommend for now to just disable CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE
> unless you want to make the reports informational and describe the
> situation as I just did.
> 
> Actually, could we talk soon about testing? Because I want to automate
> some more tests for modules with kdevops.

Thanks a lot for the detailed explanation and guidance! We will disable
CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE in the regular tests of kernel
test robot, and will keep an eye on the latest updates in the thread of
"module: avoid all memory pressure due to duplicates" patch series [1].

[1] https://lore.kernel.org/all/20230524213620.3509138-1-mcgrof@kernel.org/

--
Best Regards,
Yujie
