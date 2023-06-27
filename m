Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C673FF4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjF0PIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF0PIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:08:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4C10CC;
        Tue, 27 Jun 2023 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687878521; x=1719414521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IA11Aco+T/x16l6i98pdxr6nAnpI3sTZ+UOpKHDDBJQ=;
  b=R8MofxyQ5xqpl+kpl6KBCo1UcWyJWH1iT5VP8FG3gPeXJFDIFo2PxV9e
   a3gAR+1eI3nbXUe8LWhYlvmP/YbDtoRX7supqro3fWKC+0tLvX6kILeVk
   jSBUHmKWZySu50lcVaZaqYAXa6jswOhJUTWbbubi6eKd/QkjHsjcloZQ1
   P+EoFO1wKur/lSOxhYK2Eoztk3m1Y6x4O6tKHahbqvygvKpSlkQpFE3Ko
   X2PIDablPmQCJGOTMH00Q/js82Io6ycdbtNhwVyW9xLh+TRt8e4Anpfey
   Vo8q8605nqn7SXSX4Pixu8GLE6LWMpzZwkFs2nTJWxUjjvfakxBLOO5mC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="364144632"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="364144632"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 08:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="840717944"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="840717944"
Received: from btalbott-mobl.amr.corp.intel.com (HELO [10.212.238.85]) ([10.212.238.85])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 08:06:12 -0700
Message-ID: <487cc70c-9cb1-2b00-acb3-a1410c8be7c0@intel.com>
Date:   Tue, 27 Jun 2023 08:06:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 21/24] x86/sgx: use vmalloc_array and vcalloc
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
 <20230627144339.144478-22-Julia.Lawall@inria.fr>
 <004bc553-4dca-070b-c203-adcb50d4112d@intel.com>
 <896979d6-7365-e75-52fe-ad929e3e8620@inria.fr>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <896979d6-7365-e75-52fe-ad929e3e8620@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/23 08:01, Julia Lawall wrote:
> If it is certain that no overflow is possible, then perhaps it is fine to
> drop the patch? 

It's impossible in practice in this case because the code is 64-bit only
and uses an 'unsigned long'.  But, like I said, I can see that same
vmalloc() being copied-and-pasted or moved to a 32-bit system and
theoretically causing problems in rare scenarios.

I'd probably just drop this patch.
