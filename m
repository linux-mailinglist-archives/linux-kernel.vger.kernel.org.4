Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D68871EFE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjFAQ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjFAQ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:57:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2E11A5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685638656; x=1717174656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fwWF/Gy9Rnn01MNcEZTbrQhC277/QH+VMbqZkWIZ3UU=;
  b=mLAqu2nzXzv++XKyYuWM8zYJj6STUedGa4VKvHe3sc3UG7tfmNtI1viN
   UKrA6JoHCfiLNGmjShFD0iGvxi/gDMw9SF5OICkC8qntggwQsE0W0wBoH
   nVFIiWMytUcrL7kKGhwDZbds40VuPvwlVVHX0piHM4Z5f28YA5mrLBDCM
   wbqbsO61mkSrRczR7e9+//X5nM7mhbHCCtGxVkB+78VNI+qT/dZ/8ypOq
   MG5vmPEgI+6DveCpuj71IGsPV/2oyPBt2sWna8GkHFr5vNogdibu6gLDz
   lE32vI7Qd7kIcGM0tWxam8XVw8NhGWhMsFydEtoga/zAO/Ju/7lIhHcuw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="340237757"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="340237757"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="737181505"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="737181505"
Received: from jdboswor-mobl.amr.corp.intel.com (HELO [10.212.227.45]) ([10.212.227.45])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:57:30 -0700
Message-ID: <5aae0317-72cf-fc3c-6ce3-7e1fe1d6b699@intel.com>
Date:   Thu, 1 Jun 2023 09:57:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Content-Language: en-US
To:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
References: <20230530150106.2703849-1-ross.lagerwall@citrix.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230530150106.2703849-1-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 08:01, Ross Lagerwall wrote:
> Since firmware doesn't indicate the iBFT in the E820, add a reserved
> region so that it gets identity mapped when running as Dom 0 so that it
> is possible to search for it. Move the call to reserve_ibft_region()
> later so that it is called after the Xen identity mapping adjustments
> are applied.
> 
> Finally, instead of using isa_bus_to_virt() which doesn't do the right
> thing under Xen, use early_memremap() like the dmi_scan code does.

This is connecting Xen, iSCSI and x86.  Some background here would be
*really* nice for dummies like me that deal heavily in only one of those
three.

One or two sentences like this:

	Firmware can provide an iSCSI-specific table called the iBFT
	which helps the OS boot from iSCSI devices.

can go a long way for dummies like me.  As could some background about
why this:

	... add a reserved region so that it gets identity mapped when
	running as Dom 0 so that it is possible to search for it.

These are all English words, but off the top of my head, I have no idea
why reserved regions get identity mapped when running as Dom 0 or why
that makes it possible to search.

The addresses and size here:

> +#ifdef CONFIG_ISCSI_IBFT_FIND
> +		/* Reserve 0.5 MiB to 1 MiB region so iBFT can be found */
> +		xen_e820_table.entries[xen_e820_table.nr_entries].addr = 0x80000;
> +		xen_e820_table.entries[xen_e820_table.nr_entries].size = 0x80000;
> +		xen_e820_table.entries[xen_e820_table.nr_entries].type = E820_TYPE_RESERVED;
> +		xen_e820_table.nr_entries++;
> +#endif

also appear to be conjured out of thin air.

As does the move of:

> +	reserve_ibft_region();

I'm sure I can go figure this all out with some research.  But, I'd
really appreciate some extra effort from you in this changelog to save
me the time.  I bet you can explain it a lot more efficiently than I can
go figure it out.
