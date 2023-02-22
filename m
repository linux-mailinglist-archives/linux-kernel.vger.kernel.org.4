Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD9169FE84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjBVW3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjBVW3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:29:06 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E05619D;
        Wed, 22 Feb 2023 14:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677104944; x=1708640944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tb0CU1hOIcF8YfLnEGDkQsq99wv6qzkZVCjQBnACc0s=;
  b=gfm9OcsUGi1BHbQN32X/VpkUhIyCtGXeL0nDWpUkycHdxYOZXGvXjN4p
   a+WB8ahH+1W5I4KLndfKBmpVVm+qu0BeIA8xBCCB/lbSAV1IDQCCk8HOC
   AfWqtSBaElGycYnDw/0CiXegXyiRHbl+taoU9+h6XV2pi9nWuQZdlyLuC
   PLj9qG8pK+CruNqPQNRyWgRBAYpZ/seo2M3tlRp++pj58w7xcdOOsTQeL
   NZxOAVf7vrqLaub14FHodEkw78zpnqdYFOpNAAaWnktxICNzB29Peyujs
   nHoWU3mhbdh4O1CFh4NmdBDOdOS2UiiEKnM5fK241C6EeNA+WVMIxC76Y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="334418936"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="334418936"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 14:28:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="665511550"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="665511550"
Received: from tzinser-mobl.amr.corp.intel.com (HELO [10.209.49.182]) ([10.209.49.182])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 14:28:56 -0800
Message-ID: <8fb5ebbf-d468-169d-5603-b267e7b42516@intel.com>
Date:   Wed, 22 Feb 2023 14:28:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/7] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-5-jithu.joseph@intel.com>
 <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
 <d9d18954-8434-4c85-88b8-8e1d99cd6a4b@intel.com>
 <dd501d6a-e7e9-be82-24fb-33b18fb6192b@intel.com>
 <b67d2125-4075-4eac-4cad-8e315b866144@intel.com>
 <5d57f42a-1bfc-5e6a-bb49-556ecb7402af@intel.com>
 <9c55a34b-c17e-2a62-9989-902ce940dde5@intel.com>
 <42ac85ea-0ffe-55fc-57c2-6f4555e8dc5b@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <42ac85ea-0ffe-55fc-57c2-6f4555e8dc5b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 14:07, Joseph, Jithu wrote:
> Since the trace has to be explicitly enabled (I thought it is okay to
> add a more convenient custom one only to be enabled for detailed
> analysis when required).

	man perf-script

You should be able to write one to do exactly what you need in about 10
minutes.  No new tracepoints, no new kernel code to maintain.  Knock
yourself out with whatever conveniences you want.  Just do it in userspace.

I still think this patch should go away.
