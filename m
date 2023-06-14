Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE8730226
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjFNOp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbjFNOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:45:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF951BE8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686753926; x=1718289926;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6v6TbjeMW8U/IbxBNH5DXiK4YQ9SM1BrYJGznxX5fKw=;
  b=BiZlGtQ1EVqEb+3BOg/cyg5WN9Zg+XxJBSxrmpvLJiVi55HySylQZ0go
   ObYGjX9tA95MTO7FG1wPF+9bJga+LK+GsTVmOQ19FOfFhCyjzAM4muRi5
   kwwfHusm0LWkvGCxy997WONk5ewZ463rZHq9qOzWqU0Q+oSubFpgTNJYi
   wfVKJFmAaWIDZF/Af9TTztS0PsEtEWxY5c/qL7AJDYS/6N5UrTTsQ2y+X
   tK3U08JkElhAwYsviJOSuhWm4Tmz1QbCPRbExHxLTnXJOnagD2iCnLHf7
   Y74knSMGz9We3ycU/szCOb43E/VXfB54vYsoPuF/NqxE/oYRWs4j2vNQd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362002433"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="362002433"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 07:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="662420636"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="662420636"
Received: from ngarg3-mobl3.amr.corp.intel.com (HELO [10.212.191.43]) ([10.212.191.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 07:45:24 -0700
Message-ID: <0cefb67a-6fae-daa2-c871-ae35b96aac08@intel.com>
Date:   Wed, 14 Jun 2023 07:45:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: x86: pgtable / kaslr initialisation (OOB) help
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230614132339.GS3635807@google.com>
 <20230614141654.GA1640123@hirez.programming.kicks-ass.net>
 <20230614143732.GW3635807@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230614143732.GW3635807@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 07:37, Lee Jones wrote:
> Still unsure how we (the kernel) can/should write to an area of memory
> that does not belong to it.  Should we allocate enough memory
> (2*PAGE_SIZE? rather than 8-Bytes) for trampoline_pgd_entry to consume
> in a more sane way?

No.

I think this:

                set_pgd(&trampoline_pgd_entry,
                        __pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));

is bogus-ish.  set_pgd() wants to operate on a pgd_t inside a pgd
*PAGE*.  But it's just being pointed at a single  _entry_.  The address
of 'trampoline_pgd_entry' in your case  also just (unfortunately)
happens to pass the:

	__pti_set_user_pgtbl -> pgdp_maps_userspace()

test.  I _think_ we want these to just be something like:

	trampoline_pgd_entry = __pgd(_KERNPG_TABLE |
				     __pa(p4d_page_tramp);

That'll keep us away from all of the set_pgd()-induced nastiness.
