Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA29169873C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjBOVSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOVSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:18:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752C726879;
        Wed, 15 Feb 2023 13:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676495902; x=1708031902;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GTT4gNma+UDtlhtKszlXJRnKYRr1ieBb5P4RGFVL3g0=;
  b=O2PD86DQpQbToHdsSVAk/I6AvSf8DvKYqY9HGW8yWGpblpkq8LhpOO6h
   lEwuop5DjeSu01Me3KwjCrRdg/43OPMRvndvBcmeo5NdM7GtWZd+PCaT8
   XecGls5/s27q5KEtzS6tLuV7sQMGFcuW5LUAAee8yJwheMl49cB/XyRwP
   r0vfRCfJvpXMVolGg5QEThG9WoJSTwO4Sd/8Hac7Wpnjnv8Mv3oF6RenM
   /4Ip5NWIkhBmAUTA53R0z1ogvjq8sOV8Iw/nenoBzIiWzcapR/f2662s/
   l9XP2iMj2O+raf9/nbgh5QIY5pame77Nm6yJUmRW3ygyNnReq8rDlblSj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="330186706"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="330186706"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 13:18:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="733558396"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="733558396"
Received: from chakanog-mobl.amr.corp.intel.com (HELO [10.209.64.107]) ([10.209.64.107])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 13:18:21 -0800
Message-ID: <76c527e3-b376-18df-bc93-f5a75e029d76@intel.com>
Date:   Wed, 15 Feb 2023 13:18:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <5d57f42a-1bfc-5e6a-bb49-556ecb7402af@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 13:13, Joseph, Jithu wrote:
> 
> On 2/15/2023 12:26 PM, Dave Hansen wrote:
>> On 2/15/23 12:22, Joseph, Jithu wrote:
>>> 		trace_ifs_array(cpu, *((u64 *)&before), *((u64 *)&command));
>> Uhh, you control the types in the tracepoint.  Just make them compatible
>> so you don't need casts.
> will change it to:
> trace_ifs_array(cpu, before.array_bitmask, before.array_bank,  *((u64 *)&command));
> 
> i.e will pass compatible types for array_list and array_bank. And for the last argument, we need to dump the whole 64 bits within "command"
> into trace output . Since the suggested change replaced the union with a struct, it is simplest to cast it to u64 needed by traceoutput.
> So I would prefer to keep the cast for the last argument alone.

<sigh>

Your trace even can literally be:

+	TP_STRUCT__entry(
+		__field(struct ifs_foo,	before	)
+		__field(struct ifs_foo,	after	)
+		__field(	int,	cpu	)
+	),

and then you can just use structure assignment or a memcpy.  *That* is
what I mean by compatible types.

But, also, I'm not sure these tracepoints even make any sense.  You're
passing raw MSR contents back and forth.  Why not just use the MSR
tracepoints?  They'll give you the same data.
