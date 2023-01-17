Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF0B66E416
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjAQQvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjAQQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:51:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4197D1E9E4;
        Tue, 17 Jan 2023 08:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673974263; x=1705510263;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DAmxMlbu+x5zp49k+P0zill7H3H48lEvCLdvP9/FK1Q=;
  b=H5axUeiDOmzpM4oNy+MHo7BWfClS1ymLKG3McaeFsKStCSMU+3P68AqI
   tsEoKb24KcrUEyc+C4bopuPw5HS0s3lBgF8GGWHgx1TUXiIAtfYiaYDj7
   oiR5PT4DAxBLWuAd3/9ez59YC92v3dj54Vjg5JSoJD7cikkr7HPgwfKGA
   RkSTQFYKBuBfHO14lMoGgPmF0YLXJHaHR6CMZP035PV2WThqTGy9U20eV
   /i8HvmziqdjE4UXl3kt5hTM06y4KONc9e67a5z6LuYprqxF3+P4lawlp2
   EbAiRnjAzr9j0oxFnnVlE6gnS8rPZGf7DjXErjL+CmHHJZ2JjTZ8FoQyb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="312619380"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="312619380"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:51:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="801812559"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="801812559"
Received: from youli-mobl1.amr.corp.intel.com (HELO [10.255.228.205]) ([10.255.228.205])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:51:02 -0800
Message-ID: <7f969b09-438b-cee3-be4c-e08b97457b12@intel.com>
Date:   Tue, 17 Jan 2023 08:51:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] acpi: fix suspend with Xen PV
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
References: <20230117155724.22940-1-jgross@suse.com>
 <CAJZ5v0iCAT2W-m1T-v1wSBw+GQerhMAp1hT6SioJ53RQY=oA3g@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAJZ5v0iCAT2W-m1T-v1wSBw+GQerhMAp1hT6SioJ53RQY=oA3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 08:47, Rafael J. Wysocki wrote:
>> Fixes: f1e525009493 ("x86/boot: Skip realmode init code when running as Xen PV guest")
>> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>> V2:
>> - new approach, avoid calling acpi_get_wakeup_address()
> I'll queue this up for 6.3 if the x86 people don't object.

That 'Fixes:' patch looked to me like it was applied during the 6.2
merge window.  I would have expected a fix to go up for 6.2 final.
