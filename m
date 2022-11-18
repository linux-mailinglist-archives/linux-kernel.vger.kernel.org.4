Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE7762FC38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbiKRSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiKRSLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:11:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BEF8754C;
        Fri, 18 Nov 2022 10:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668795097; x=1700331097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qySCtFgqmMLMr3vc7i29wNNm4ljo0VreS/eNDPEYfm0=;
  b=dqw73ia+dtN8h8MAV0o/v8zJ/LyVsVmV9PIxPnGqDNkchUiNdbtOqzfB
   8/1QO0/Ayg/9ln3TKxRMUbB0nxIUzOdnx5R9T84OFkHwvpmWc+1HJmqIc
   cV2UA/KA8PD0DWTH/zTNnFQbo+0/ADEoMaysJYN59d+MlTX6SVgsPSK59
   PkO0LtNQdO5bRZXSYY8+W/vkbwq1t9TQx14urixBK0KDUihugnO7gerpu
   5yYTkxgBnSBgpVGf6TAlxOQmZEV9gjO6ZdQzkwxDNbP5iuVlI/8AVEPEx
   vHw56Yl7qmZTL3M/mkyVK7fDNJt/ktBu2Z4Kkihcy89l8V9dqcEPbKZmm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="399485818"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="399485818"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:11:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="969361767"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="969361767"
Received: from mbeebe-mobl1.amr.corp.intel.com (HELO [10.209.82.240]) ([10.209.82.240])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:11:36 -0800
Message-ID: <22398efc-15c2-4cc5-87a1-7c47c762b283@intel.com>
Date:   Fri, 18 Nov 2022 10:11:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/2] x86/tsx: Add feature bit for TSX control MSR
 support
Content-Language: en-US
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        thomas.lendacky@amd.com, "H. Peter Anvin" <hpa@zytor.com>,
        hdegoede@redhat.com, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David.Kaplan@amd.com, Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
References: <cover.1668539735.git.pawan.kumar.gupta@linux.intel.com>
 <de619764e1d98afbb7a5fa58424f1278ede37b45.1668539735.git.pawan.kumar.gupta@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <de619764e1d98afbb7a5fa58424f1278ede37b45.1668539735.git.pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 11:17, Pawan Gupta wrote:
> Support for TSX control MSR is enumerated in MSR_IA32_ARCH_CAPABILITIES.
> This is different from how other CPU features are enumerated i.e. via
> CPUID. Currently a call to tsx_ctrl_is_supported() is required for
> enumerating the feature. In the absence of feature bit for TSX control,
> any code that relies on checking feature bits directly will not work.
> 
> In preparation for adding a feature bit check in MSR save/restore during
> suspend/resume, set a new feature bit X86_FEATURE_TSX_CTRL when
> MSR_IA32_TSX_CTRL is present. Also make tsx_ctrl_is_supported() use the
> new feature bit to avoid any overhead of reading the MSR.


Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
