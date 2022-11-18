Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E717062FC3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242534AbiKRSMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiKRSMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:12:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19B7C5D;
        Fri, 18 Nov 2022 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668795155; x=1700331155;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a5XYRuFsTWq7kic2uFkZnRtD13iqt4AWhF3B29PLMp4=;
  b=LMSXzJRCpRkq9JXWwSHID5d6LqNAs1HYDLXA62D/gof2wAMMZn4wZ2aY
   p5iBdGEQxtMFWlX4AluuDkaqR9E+nj6Yupk4Tell5l1gjwlnQgK/j3say
   x5bm46jJWto31MAxe7MaOgNpiZlNbs3770Yy5Dytec5ifoGFa5xNUWWzi
   +z1gIMXFdSj4DJhFeEpMG2XZFdqERCLup3BPtWaiho3F4WoqlpflxOmeL
   nunxlq2MhsCUQmumGcb6wwLAZanVZ0cLQGJfX6YyiQRaKkMSgv6cT50Fx
   ISP+Aa+Ky28eMwzqytieWKvgr+lBCRIVBRuaHbXsKcoXgtHnzEUEyATl+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="340041947"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="340041947"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:12:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="969361944"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="969361944"
Received: from mbeebe-mobl1.amr.corp.intel.com (HELO [10.209.82.240]) ([10.209.82.240])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:12:32 -0800
Message-ID: <dc39988c-7b44-63b2-9ddf-6fa986fe7c3b@intel.com>
Date:   Fri, 18 Nov 2022 10:12:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/2] x86/pm: Add enumeration check before spec MSRs
 save/restore setup
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
 <c24db75d69df6e66c0465e13676ad3f2837a2ed8.1668539735.git.pawan.kumar.gupta@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <c24db75d69df6e66c0465e13676ad3f2837a2ed8.1668539735.git.pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 11:17, Pawan Gupta wrote:
> To fix this, add the corresponding X86_FEATURE bit for each MSR.  Avoid
> trying to manipulate the MSR when the feature bit is clear. This
> required adding a X86_FEATURE bit for MSRs that do not have one already,
> but it's a small price to pay.
> 
> Fixes: 73924ec4d560 ("x86/pm: Save the MSR validity status at context setup")
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: stable@kernel.org

Thanks for fixing this up.  The X86_FEATURE approach is a good one.  The
"poking at random MSRs" always seemed a bit wonky.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
