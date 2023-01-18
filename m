Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65045670ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjARAlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjARAkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:40:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30BA50840;
        Tue, 17 Jan 2023 16:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674000915; x=1705536915;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U+FNsffiUiBOhXgQVY2RTqxZzcTli6D4Y1VLa3Irm2Y=;
  b=hFXMQG4xl1NOXXWOJN6D2BnlgSPjnSGhOcow34qZah6swOEy9P2dzAGx
   hPlYOFsxYbmja2/Am9SDIJ5M5r0i7dAJXoO5SVU7uRVO8Ydmzgy55jt0q
   ln58IaHn/BBvAafu18Lg2XlqJSakXjp0SaX311Zm6YOB/rQaK+4vC1qeN
   yFMOD8IS+atuFGj4Knkj5r1c/Ks7GPpLGuLBLFgHEmkbmpP6tV/mMQWGt
   itccpuztPcUawxiDwQL8HEX4uFSC1Nu/Q8v6AHNIKtLl1qGoTmbmOnkZG
   b6YdkVYfqt45P5YL1PzzZY5xImV/d8zZQAMSINeEWWnFUcajchA2XRlv6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="352102383"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="352102383"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 16:15:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="783443930"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="783443930"
Received: from tblanzy-mobl.amr.corp.intel.com (HELO [10.209.6.252]) ([10.209.6.252])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 16:15:14 -0800
Message-ID: <43d0f8b1-0d2e-0e0f-d794-0048641d84f1@intel.com>
Date:   Tue, 17 Jan 2023 16:15:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] acpi: fix suspend with Xen PV
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
References: <20230117155724.22940-1-jgross@suse.com>
 <CAJZ5v0iCAT2W-m1T-v1wSBw+GQerhMAp1hT6SioJ53RQY=oA3g@mail.gmail.com>
 <7f969b09-438b-cee3-be4c-e08b97457b12@intel.com>
 <CAJZ5v0iOmZouhSb_ap0MA3-sk6RWJ7MRpTuGekrJrvOn-Y4JYQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAJZ5v0iOmZouhSb_ap0MA3-sk6RWJ7MRpTuGekrJrvOn-Y4JYQ@mail.gmail.com>
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

On 1/17/23 09:08, Rafael J. Wysocki wrote:
> On Tue, Jan 17, 2023 at 5:51 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> On 1/17/23 08:47, Rafael J. Wysocki wrote:
>>>> Fixes: f1e525009493 ("x86/boot: Skip realmode init code when running as Xen PV guest")
>>>> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>> ---
>>>> V2:
>>>> - new approach, avoid calling acpi_get_wakeup_address()
>>> I'll queue this up for 6.3 if the x86 people don't object.
>> That 'Fixes:' patch looked to me like it was applied during the 6.2
>> merge window.  I would have expected a fix to go up for 6.2 final.
> Right, sorry.  Definitely, 6.2-rc material.

I think the original issue went up in x86/boot, so how about I queue
this in x86/urgent?  Rafael, should I add an ack from you on it?
