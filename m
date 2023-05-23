Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325FB70DD46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbjEWNNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbjEWNNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:13:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39996184
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:13:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E931E22AB7;
        Tue, 23 May 2023 13:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684847623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgL1MIRZX3Y+FVWSNOkU++9NMPuYvd0QkuZ4FyLBVfU=;
        b=EEwAnJIezFPmi/jB0fiajqlAZJHIaxDV0zOANdyOK0hO689bBOzb/mtstSMAicqCiLWpgi
        VWoRDfh9JktX8kDoVzhMX+5Z7Yhu0Y3fuI6S5Upzq2H1mcROy/h9kdyzxNLHX6CGYpdroW
        q+ItsLN02lg13wI4KBgfd1VsfG5wYK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684847623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgL1MIRZX3Y+FVWSNOkU++9NMPuYvd0QkuZ4FyLBVfU=;
        b=Xv3rH11f9CNEqWknjeqH8ehvmD/QHsE90UXWMIa04KXsgEt4haFtk2+5bTJJ9k28zp5kuR
        GK2i3+MUcqaFjODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF16713A10;
        Tue, 23 May 2023 13:13:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6ojXMQe8bGTUPwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 May 2023 13:13:43 +0000
Message-ID: <856dbc05-5046-04c8-cf6f-9d0b13e9d229@suse.cz>
Date:   Tue, 23 May 2023 15:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/mmap: refactor mlock_future_check()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>
References: <20230522082412.56685-1-lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230522082412.56685-1-lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 10:24, Lorenzo Stoakes wrote:
> In all but one instance, mlock_future_check() is treated as a boolean
> function despite returning an error code. In one instance, this error code
> is ignored and replaced with -ENOMEM.
> 
> This is confusing, and the inversion of true -> failure, false -> success
> is not warranted. Convert the function to a bool, lightly refactor and
> return true if the check passes, false if not.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/internal.h  |  4 ++--
>  mm/mmap.c      | 33 +++++++++++++++++----------------
>  mm/mremap.c    |  2 +-
>  mm/secretmem.c |  2 +-
>  4 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index bb6542279599..66dd214b302a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -576,8 +576,8 @@ extern long populate_vma_page_range(struct vm_area_struct *vma,
>  extern long faultin_vma_page_range(struct vm_area_struct *vma,
>  				   unsigned long start, unsigned long end,
>  				   bool write, int *locked);
> -extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
> -			      unsigned long len);
> +extern bool mlock_future_check(struct mm_struct *mm, unsigned long flags,
> +			       unsigned long bytes);

This would have been good opportunity to drop the extern.
