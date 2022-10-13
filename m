Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2C35FDC68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJMOb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJMOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:31:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94BBA0273
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:31:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 957D321BBD;
        Thu, 13 Oct 2022 14:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665671515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MHXO/VcwDd2Zl4hT/pNxqi1pKywIsb48dxy9NcH1w0=;
        b=o/9xIdbPAnQcVAEW8DeoieMLQecxGY4CNEkADiXkB+zytkQa4HjiqtdCTTSP789AP7MPbG
        C6PUbGtMJ8CluFdLwNIfpf1ESrIpbkIet7pNyZvVjbPRGKFl3eUV0AmnoA3r6+c2a0KayO
        XSujkWskoPxIJG5Q0MZEsy755tC5uew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665671515;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MHXO/VcwDd2Zl4hT/pNxqi1pKywIsb48dxy9NcH1w0=;
        b=rP/0aiCDVD8XDyVFAO4zYC01A4sydphKpL5r6s0v+aSlKmIg39vx9N1iuxZhhbijmxYDQc
        nkpaCPhpAi/jAJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0F23139F3;
        Thu, 13 Oct 2022 14:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qaqQM1ohSGMRXAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 13 Oct 2022 14:31:54 +0000
Date:   Thu, 13 Oct 2022 16:31:53 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] mm/hwpoison: move definitions of
 num_poisoned_pages_* to memory-failure.c
Message-ID: <Y0ghWfP4n5XNWDg/@localhost.localdomain>
References: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
 <20221007010706.2916472-3-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007010706.2916472-3-naoya.horiguchi@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 10:07:04AM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> These interfaces will be used by drivers/base/memory.c by later patch, so as a
> preparatory work move them to more common header file visible to the file.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> ChangeLog v3 -> v6:
> - remove static in definition of num_poisoned_pages_inc() to fix build error.
> 
> ChangeLog v2 -> v3:
> - added declaration of num_poisoned_pages_inc() in #ifdef CONFIG_MEMORY_FAILURE
> ---
>  arch/parisc/kernel/pdt.c |  3 +--
>  include/linux/mm.h       |  5 +++++
>  include/linux/swapops.h  | 24 ++----------------------
>  mm/memory-failure.c      | 10 ++++++++++
>  4 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
> index e391b175f5ec..fdc880e2575a 100644
> --- a/arch/parisc/kernel/pdt.c
> +++ b/arch/parisc/kernel/pdt.c
> @@ -18,8 +18,7 @@
>  #include <linux/kthread.h>
>  #include <linux/initrd.h>
>  #include <linux/pgtable.h>
> -#include <linux/swap.h>
> -#include <linux/swapops.h>
> +#include <linux/mm.h>

I am probably missing something.
num_poisoned_pages_* functions are in swapops.h, but why are you removing swap.h as well?

Also, reading the changelog it sounded like both functions would be in mm.h,
but actually only the _inc part is.

The rest looks good to me.
 

-- 
Oscar Salvador
SUSE Labs
