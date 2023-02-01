Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DFA686F26
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBATqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjBATqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:46:45 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665A184188;
        Wed,  1 Feb 2023 11:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675280791; x=1706816791;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5d9faIyt3THLEq6wTmtBD/I94RAQ6aWlbTrJuUrhtBs=;
  b=bQQzlckcaP9Yk9nA15Wh+zpkFtdtcSJTtuCguRC6vx7y0DN0t5MlXIEX
   H9GtiYZuhMp7lFN2L4Yd4okJ+lemkTfK//ytj9VpogVyAbRiEbw16Ewfk
   oi8fnraZpZRajDp7FcWbCVHE6uJ8D3+GBDeEeQ0QjmfHDDR62s6oXzSZp
   af2tQrS2NMuDU/x+P0KG7hXFBHcZUMCz10zXwwLBOnMS6wvERDRQdceEH
   A6gQBj8EPBG7dsO8YfZLCpPh6Bc/l5AxD0Fw57iEthUnDfhcupVKRCbx+
   hFpk6Z1uIzM87zJbOKIBU3mu5cPzNliygNOHTFXQWpJQLr+u6iqsaJ8PS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="325951345"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="325951345"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:45:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="993811995"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="993811995"
Received: from sgkhacha-mobl1.amr.corp.intel.com (HELO [10.212.227.86]) ([10.212.227.86])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:45:45 -0800
Message-ID: <6a675f9b-2bbb-9317-2015-0b3362e49fdc@intel.com>
Date:   Wed, 1 Feb 2023 11:45:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
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
 <20230131234302.3997223-5-jithu.joseph@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230131234302.3997223-5-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 15:43, Jithu Joseph wrote:
> +static void ifs_array_test_core(int cpu, struct device *dev)
> +{
> +	union ifs_array activate, status;
> +	bool timed_out = false;
> +	struct ifs_data *ifsd;
> +	unsigned long timeout;
> +	u64 msrvals[2];
> +
> +	ifsd = ifs_get_data(dev);
> +
> +	activate.data = 0;
> +	activate.array_bitmask = ~0U;
> +	activate.ctrl_result = 0;

I think this whole 'ifs_array' as a union thing is bogus.  It's actually
obfuscating and *COMPLICATING* the code more than anything.  Look what
you have:

	union ifs_array activate; // declare it on the stack, unzeroed

	activate.data = 0; // zero the structure;
	activate.array_bitmask = ~0U; // set one field
	activate.ctrl_result = 0; // set the field to zero again???

Can we make it less obfuscated?  How about:

	struct ifs_array activate = {}; // zero it
	...
	activate.array_bitmask = ~0U; // set the only nonzero field

Voila!  Less code, less obfuscation, less duplicated effort.  Or, worst
case:

	struct ifs_array activate;
	...
	memset(&activate, 0, sizeof(activate));
	activate.array_bitmask = ~0U;

That's sane and everyone knows what it does and doesn't have to know
what unions are involved or how they are used.  It's correct code no
matter *WHAT* craziness lies within 'activate'.
