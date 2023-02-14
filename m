Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F36970BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBNW3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjBNW3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:29:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479E626CCB;
        Tue, 14 Feb 2023 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676413743; x=1707949743;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=69AO54e0FOitJk/3DWsTTX5m5wdhAmsJJgBxUPA+LZc=;
  b=VsnK2FYX/l09rHDPwE8CEwhsw3vxZuK5rQzZJuCYD+m847fD8FdO62yg
   VaswZ5G0YcUzhvIa14PfCG32JBsofph1iZ9OB5PsWkAVq36g7glzLh/1T
   cJAKtu0J2zp3tiRqCPwbWU1WmrXL6QYHwWHUEwirJDitayL3d7a9J//Do
   F3oQzBPhD/6zmykGHrRNqdSRA2uNXh2k3D0LiebsJjqNeCrg+ke+BF+7v
   WpxfbdZukXgRiSybxvxMLavEdUzezGK1wSMgl5YUK1Kx4Bcj7FoukWOvT
   USWg2WoN4wCd06hWLTZ4OmpARBNfFxOwm7IQmI2OgXRCtf+Hj+TbAPjhC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="333424827"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="333424827"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 14:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="998230564"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="998230564"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2023 14:29:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 14:29:01 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 14:29:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 14:29:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 14:29:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJzcCVTzPAzhQQ1+6L0+tiVFvH58NWXTcsCHcJtCnuNM5rsHq6Wr9XtDzWs3R6uoteiPWtrl+hTdXN50lCncd2zyZiG1VtU9IJIp3f7P7HcJazkxXHor3LveJyycLW3p7p5toWF8iRW8VgnQrUAgMaYHSvtRhIZoIwxmq7TtOWMJvDtq3msUPdauKul/LhalEHK4LdLggGvfRcA1Q/sUOoCmyPxuU2TD2WqevsYg51WxB31L6KZZtYI9/IbFyez0YOmlqq3nnkF83nRKPR3znKgcWJkiKk9v0eussiJvxSrV9XnxY+WgF3W0T+SxonhepzyHOmYkZVwYs64uEM24Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Kibffnjt4egx0ngRt/0Nmf8fKweA9YGOLNbU7Q22vQ=;
 b=h880SZ+36QFJED14XxVnZdzBzcVKSnryZQeCIxJTtVyvzEH12Et9JJQ+F0r18/hIS/85smTI1vG0//Vrngl7Sf2XGR9rFUAf45JZnPL2xFsWnygwXBVOLvoge0TA54NZwsbigZZZvfj7AhSe1irusU+164lp3Izj8j9fJ7mjjirA6f+5qqmErWnO7cfs47U2KyAay26XypXGBcHlKmTT+t5KWYLgihv0wv4X/cCl9/6kTMv+iTctGQnadHcrPnC7sBfQZAMsUvJGVst4eE4rPvBwlIFzP416NVUgeZO6rhOxxYjonbeDZomPXsh2We7+yNK27c8+hfvdKBukVvwP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7450.namprd11.prod.outlook.com (2603:10b6:510:27e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 22:28:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 22:28:59 +0000
Date:   Tue, 14 Feb 2023 14:28:51 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rric@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/port: Disable decoder setup for endpoints in RCD mode
Message-ID: <63ec0b2370e46_32d6129434@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230208071758.658652-1-rrichter@amd.com>
 <63e52846175ae_36c729428@dwillia2-xfh.jf.intel.com.notmuch>
 <Y+pOD5+DAsm3IKup@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+pOD5+DAsm3IKup@rric.localdomain>
X-ClientProxiedBy: SJ0PR05CA0158.namprd05.prod.outlook.com
 (2603:10b6:a03:339::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 713a62cf-a7a7-4fbc-54ee-08db0edadd9f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdoMu5WJQDpCPVgpDH5kt/uDRU0JxK3lGncCRhBpaz0oSAaPdZHgl5RII/W9O/L63lKoVKZnYLD4FQ+sJH4jtOApLmXsr51y4F7zvsThQlgcJ3zc9HUy2JCTpLLLDgwnbJgzroxQlcW2YgOA0a2UPUo5JfNiJG3/f9RE78CROs3qI8vBGK3VRz6PV0Y7sw57Vb9bVJorpvbXvqoMVhY+5KjHDbg5nbwXFYDylls9/1cPIEYyJoEiRj7PnAwq1kIdoLuaaPpj8//fjL13J8mG+DIAiKkTO6/+OY5KNLV4sbVR4tPBvpBZNd8Kq4uYM/zxyEr+39Mqu8hHzqBawIzAwm16LJmI/twStP/x68Tn2Fl+YPQx8FRWtlol1Q+PPyuhBhRAjyMnDB2MiBLxmlNwipymoo9k2OIQZtTZXQDETfnST5JAaw8CP4XUVoGCQStjYS9xRoHnY7ySC4+I8nzZ13adRafT8aBAEmIcSTS6T1rQ925RBZAYb0Rod5Jnk0+9fXmy1stb6NYsiVoGt5dD8Zl2V3Tx/qAZRAAgpxjIy4+3JROx2mjhW24dmLbcycJjwmdFGt9toOwHM3Qf7Kb3/P247QD/8ZDgUKMg0I+P8fsdTBxa/aMJssc7+4GEZvBd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199018)(2906002)(9686003)(186003)(26005)(6512007)(82960400001)(478600001)(6506007)(5660300002)(38100700002)(53546011)(6666004)(8936002)(86362001)(316002)(41300700001)(8676002)(966005)(4326008)(6486002)(66556008)(83380400001)(66946007)(66476007)(54906003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDzi05eG7wliQuzp/jSx8HsRhCAy65jwZ9VYUQJzZ7JDFGogIz4+dzJ3whEU?=
 =?us-ascii?Q?O5XRi25ZLcV7cL9WcmZa6EdDmYoD0qPn1VUf+M/OnyCMfjqowxJkf7EL4Cht?=
 =?us-ascii?Q?QbIW/NftOb00MwGUs8oKL70ihGWgI7WtClVmTKtq3YrNntVKpw82NLcfNJBM?=
 =?us-ascii?Q?d1tUekC2VLEBkJSUwmMSJ5zfutf1IzHzmdhxJ5OBI0OvO/RWCYoFVeGLPPzF?=
 =?us-ascii?Q?bzF1ltV1GQf4CE0PMld6dha+Q9ErODKVx6qtAP8hw2Cqfj28qtTXDhS1Pfeo?=
 =?us-ascii?Q?jMP1sWq0or186r5kSJfNR1yzQaSGIj+nm4fLs3xa/RDXjSpKd/mdxXqEAUWh?=
 =?us-ascii?Q?RbmEH9spNCTsbndNcTiG/kDsRhyTS4tcC7XssfhpQq01EPor/47l8b1NJKoF?=
 =?us-ascii?Q?QG4JZRxNqhKQgwMb0P5BhUpkarGE7kBpTznCLUlk/hzGvjF5SL+UCaDpY+rD?=
 =?us-ascii?Q?qe8chS7uCUPO+6ctE5auxyEfWcpJXk+QQ7FrjmqpGqAeTSsuDT9msaefiDp3?=
 =?us-ascii?Q?W/tASFMTUCFleVGFSrOtD4oOX3mo+MHbzRwf/iYo2vQEqTt8PjuG13FaQi07?=
 =?us-ascii?Q?zUGvL4As+KVQFVuiKMttPVfCUcTqVTtP80CeuotbAnfPZuFWW0jFBABNjoxk?=
 =?us-ascii?Q?kowqAASSmJOSDWlmUBsUkSwcOVwqHeiTs9PLepkZsgD3r2oTup8lmrk4GXJ8?=
 =?us-ascii?Q?sK/YKyEY48gwFNKjF69/qxUy/sSIOq5G5ARMlxXsO4FI17TQXHbZZ9vtA2xm?=
 =?us-ascii?Q?0IjhtUMNbtb/X80k1B2lFSnOqK57n6T0fdHb2u6lHsxiIMmnMPTOgylMM8AK?=
 =?us-ascii?Q?oTweJ9LOVV9ecYjXLyDEqGpdTS7yiCyRImDUjZMyHQ/KKtm/F2Vu834fdSfX?=
 =?us-ascii?Q?AF4wgUMgpn9OWifhfSPWhySC/X+pQUaR17E9rdNlFfqLHrj+pOkZQN18Luo+?=
 =?us-ascii?Q?uD3FpjPwi2cSKujHeu3uI7TjhLU3v/7Or4EDYnK3j8dHF9eMw3FT775fIOhM?=
 =?us-ascii?Q?+ci4Q+k6g08qZT+664Utz6s9qYIrwixoklzvXuUcpi/BMP8mlvhfIEfNwwhO?=
 =?us-ascii?Q?X4IyYwD3GNu3LeW6aMOXiKTt4VQ99CC8yRdKbYPZwdV1bVdcEROJPthSJ/t/?=
 =?us-ascii?Q?S9FlzAYQR6g3IEhh9+hYD0HaQkpCpB9YWl3mdT9Zien212Bx9NBxSHkUnNu9?=
 =?us-ascii?Q?nzMrA1Umy1CCWp9Q32RcFBAHkLcxLNQFDqWKnhBlqTsjXzzOzig58YxjOYMv?=
 =?us-ascii?Q?Da+edTIT/KV/jg4bxCuCoUqbWOZ0OO7DE1MXHhQhX5U26+Yzz3jMuQWj8HGU?=
 =?us-ascii?Q?A3y0kz5w7E2layJnVmTojtRBaPuGmaIbR4hPTzuIEPXCzBuFLVi8pgBjArBH?=
 =?us-ascii?Q?zI6/JnHgtPbAE3U24b9J3Y1vWRj0aE24489kFlQjHaOemJY9cyx1+DJiZCrx?=
 =?us-ascii?Q?Ix0kF9Nl4XijHjdA28co73u8RX3TN3yuNpe1uDfQ0kCk6b+n9HL/KvPT5Upg?=
 =?us-ascii?Q?8abRhH1Mh+0LylapsFkIcwOEtWYV0fusWUa2ShVLN6Jfx8nK6j49u+89rM08?=
 =?us-ascii?Q?vL2UWveJsIZHbFktjGwhrVqaaJNay8vgVRZAj8mIsL0/7Ls/X7XtNA1onsLn?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 713a62cf-a7a7-4fbc-54ee-08db0edadd9f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 22:28:58.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RePCr9s1tPwbNVA0Y8wFJEugmU0QsFikJZPQcf9SqieAW/uuAS2dWQHTlL8ZyyIC9PXm4Nc72WfW3tm+a2wPt3u+LQOk+kwwzxpu3gjehDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7450
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> Dan,
> 
> On 09.02.23 09:07:18, Dan Williams wrote:
> > Robert Richter wrote:
> > > In RCD mode the HDM decoder capability is optional for endpoints and
> > > may not exist. The HDM range registers are used instead. Since the
> > > driver relies on the existence of an HDM decoder capability, its
> > > absence will cause the initialization of a memory card to fail.
> > > 
> > > Moreover, the driver also tries to enable or reuse enabled memory
> > > ranges. In the worst case this may lead to a system hang due to
> > > disabling system memory that was previously provided and setup by
> > > system firmware.
> > > 
> > > To solve the issues described, disable decoder setup for RCD endpoints
> > > and instead rely exclusively on system firmware to enable those memory
> > > ranges. Decoders are used by the kernel to setup and configure CXL
> > > memory regions, esp. to enable and disable them. Since Hot-plug is not
> > > supported for devices in RCD mode, the ability to disable that memory
> > > by the kernel using a decoder is not a necessarily requirement,
> > > decoders are not needed then.
> > > 
> > > Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > 
> > Does Dave's series address this problem?
> > 
> > https://lore.kernel.org/linux-cxl/167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local/
> > 
> > ...that is arranging for the driver to carry-on in the absence of the
> > HDM Decoder Capability.
> 
> it might only solve the missing hdm decoder capability. I need to take
> a closer look if that also solves a system hang I was debugging which
> is caused by clearing the memory disable bit in the hdm dvsec range
> register. So the best would be to use this patch now to fix decoder
> initialization in RCD mode and then have Dave's patches on top. I am
> going to test the series too.

My concern with this patch is that it skips HDM decoder enumeration
entirely in RCD mode. The CXL cards I have seen are CXL 1.1+ and do
export the HDM decoder capability.

The driver turns off mem_enable in a few scenarios, one of them indeed
looks buggy, but does not seem to be the one you addressed. The driver
should only disable mem if it was also the agent that enabled mem, but
looks like it does not always do that.

Can you confirm if this fixes this issue?

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c18ed1bbb54d..2db3b5cf41e9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -385,7 +385,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
         * If the HDM Decoder Capability is already enabled then assume
         * that some other agent like platform firmware set it up.
         */
-       if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
+       if (!info->mem_enabled &&
+           (global_ctrl & CXL_HDM_DECODER_ENABLE || !hdm))
                return devm_cxl_enable_mem(&port->dev, cxlds);
        else if (!hdm)
                return -ENODEV;

Otherwise can you confirm if the platform provides a CFMWS window that
matches the range-register programming? If this is the problem then I
think this needs a platform quirk to workaround a BIOS that violates
kernel expectations.
