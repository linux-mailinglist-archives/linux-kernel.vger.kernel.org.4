Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F11662F0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241858AbiKRJT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241891AbiKRJTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:19:33 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AEB167CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:19:32 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g12so8274738wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywmGO6HZoPeDk5pta/Zgi0l/H8NSLfPp6KexyZfvyDg=;
        b=XPRDdbxSOzJuW1tJt8/WHHpRnL8IMglbnT7xSVVogruEXcIywo6nDWDMXJnhsh0Til
         +nQRhwutmq5nZmv8aI9NOzyY7aB/KemObkTtxVM8iPd54uYQwHa5VhbuNEG9JdA0/SrL
         FtFdJhWtJBOqEGSYQiJHuSZPgdwXaf49DGFIzFP7h9d3Ht6cLtqQsnN0EvnpT/jWWLOp
         U53ZDhnVotci6ISnopHFOrEe3RpHuPBKHfX+fFnHH/H4x4eDlURpDi2FoNBvgeFugSCo
         2VU81DsEDzHP38mJ3akPjnbGRTBIKdmpcIKti0fFUr6f6iilXuI6bF572+m+jUp+zKMY
         eMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywmGO6HZoPeDk5pta/Zgi0l/H8NSLfPp6KexyZfvyDg=;
        b=eWvg4txfLPzlPPRj4/jeUVdj4+ho774G+fXnOjuvs7rIWJbSzdumT7F3oXMSdA4f/2
         wyNFm1TM1wn03RM+B2GNAWTpMdWpgq/oxCIK1YsAm9WCpT6c7a+hu3Cj5OYV8v8L4sLx
         hjXvOsdlIUSKEYrgnxZ6ZTqkJtaP/0IrCetSfxR2JmjZqk/iX+HoVchM1OXHHd57KDO8
         garPrgccPtE32/bQ7jod6VZzPPyrIIyJTiBQS8ZLCIgj4jEK0LoyqZyAJifLXMxUxAWU
         mgT0ftvhBFOe9AkQHZVmVvHfv44kn1HUZYVqyIUhVZbaGBm9RHxSc1kRlbKwSugip8YD
         u/nA==
X-Gm-Message-State: ANoB5pnmsJjKSFJ+QwpESFyzztPNceM8S7xZdkUBmbqOmppY5oQVgBtj
        Vf3NThrBBVkwL4sB+O09CXIW3w==
X-Google-Smtp-Source: AA0mqf4IvIt8ecYfLqqdpfe2Ie8mTRQ05q6WdL2M9MInxr9ONrK62RPNSh4FwljtDFBhkb48MVrNJQ==
X-Received: by 2002:a5d:53cd:0:b0:231:355b:211c with SMTP id a13-20020a5d53cd000000b00231355b211cmr3562614wrw.509.1668763170487;
        Fri, 18 Nov 2022 01:19:30 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:4799:a943:410e:976])
        by smtp.gmail.com with ESMTPSA id l8-20020adfa388000000b002417f35767asm3200743wrb.40.2022.11.18.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:19:29 -0800 (PST)
Date:   Fri, 18 Nov 2022 10:19:24 +0100
From:   Marco Elver <elver@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>, X86 ML <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/kfence.h:46
 kfence_protect
Message-ID: <Y3dOHNh82NQboctR@elver.google.com>
References: <CA+G9fYuFxZTxkeS35VTZMXwQvohu73W3xbZ5NtjebsVvH6hCuA@mail.gmail.com>
 <Y3Y+DQsWa79bNuKj@elver.google.com>
 <4208866d-338f-4781-7ff9-023f016c5b07@intel.com>
 <Y3bCV6VckVUEF7Pq@elver.google.com>
 <41ac24c4-6c95-d946-2679-c1be2cb20536@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ac24c4-6c95-d946-2679-c1be2cb20536@intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:54PM -0800, Dave Hansen wrote:
> On 11/17/22 15:23, Marco Elver wrote:
> > Yes - it's the 'level != PG_LEVEL_4K'.
> 
> That plus the bisect made it pretty easy to find, thanks for the effort!
> 
> Could you double-check that the attached patch fixes it?  It seemed to
> for me.

Yes, that works - thanks!

> The issue was that the new "No changes, easy!" check in the suspect
> commit didn't check the cpa->force_split option.  It didn't split down
> to 4k and then all hell broke loose.
> 
> Oh, and I totally misread the kfence ability to tolerate partial TLB
> flushes.  Sorry for the noise there!

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 220361ceb997..9b4e2ad957f6 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -1727,7 +1727,8 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
>  	/*
>  	 * No changes, easy!
>  	 */
> -	if (!(pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr)))
> +	if (!(pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr))
> +	    && !cpa->force_split)
>  		return ret;
>  
>  	while (rempages) {

Tested-by: Marco Elver <elver@google.com>
