Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED6962FCC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbiKRS3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbiKRS3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:29:17 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4879976EF;
        Fri, 18 Nov 2022 10:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668796075; x=1700332075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mqjewkRpUIDxGJT0uKLmbhczG2Cqq27+ixwZGMtIhdE=;
  b=Gf5GJ0D7NS5WqrS89mlV82ZTta2DMF22TE1aiIVwS0R4MQNoLOKUd9NX
   wnQcxC+tdAfP+mnhaul9QbpRqxcbVsPiaVh57Hc+IjOa7EP2qxJDvJdAH
   6CIE6QZlcfcItAFxatlk/qdkTB1EVBIGsbJ4ouNfxSasykaccx7qElAwk
   QpkexkXUPmybPn2a4KsVHnHA2m9fHLJhR/Zu7uvdfaM9LhFuVCxLc8Mwn
   eFxjmwJ6h81yd9YDUxcGNhIFJKPQH+QvwirqYx3TAVGVEH46+60uq4f23
   UoBsP7rY7R9EplJluKHTpXu4AeSdG+n+ITA5YauMB/gIBNtiZaRqE/w0I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="315022109"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="315022109"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:27:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="703834773"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="703834773"
Received: from bfan1-mobl1.amr.corp.intel.com (HELO desk) ([10.209.78.213])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:27:54 -0800
Date:   Fri, 18 Nov 2022 10:27:52 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>, thomas.lendacky@amd.com,
        "H. Peter Anvin" <hpa@zytor.com>, hdegoede@redhat.com,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David.Kaplan@amd.com, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH v3 2/2] x86/pm: Add enumeration check before spec MSRs
 save/restore setup
Message-ID: <20221118182752.7ovqckwwle3azzrc@desk>
References: <cover.1668539735.git.pawan.kumar.gupta@linux.intel.com>
 <c24db75d69df6e66c0465e13676ad3f2837a2ed8.1668539735.git.pawan.kumar.gupta@linux.intel.com>
 <dc39988c-7b44-63b2-9ddf-6fa986fe7c3b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dc39988c-7b44-63b2-9ddf-6fa986fe7c3b@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:12:32AM -0800, Dave Hansen wrote:
>On 11/15/22 11:17, Pawan Gupta wrote:
>> To fix this, add the corresponding X86_FEATURE bit for each MSR.  Avoid
>> trying to manipulate the MSR when the feature bit is clear. This
>> required adding a X86_FEATURE bit for MSRs that do not have one already,
>> but it's a small price to pay.
>>
>> Fixes: 73924ec4d560 ("x86/pm: Save the MSR validity status at context setup")
>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>> Cc: stable@kernel.org
>
>Thanks for fixing this up.  The X86_FEATURE approach is a good one.  The
>"poking at random MSRs" always seemed a bit wonky.
>
>Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks.
