Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A749C6A9A85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCCPXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCCPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:23:02 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661A4C66A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:23:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso2615261pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677856981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5kFGmiQs4hGB3dsTaclN/rSlgnX+dGLmiGsx43g87JM=;
        b=ibTjnqNydigtkjuGTZ8oxgeIrUCESyIFqu2HZII0I47ZCpZpePGTEOwrccAEJtQ3ZW
         8gEV9HlqX6vgKWl9gT/8uE55UeI4pK37AdnvPxW1boqQ1cgX2xVcDeAFtpzt9xjLVGCB
         E76H0M7hwAuP1zo//OM73S2pV2/91tQgHydV10ETQ0JN0kYy0yiwPMZa45+iASy5mWhk
         ZIw08AR8LeXCErc4uMFVoMP/NI45nYqjTsLrHypoPpsxd2cpYiQvNY5Rptv3AOWQq6s2
         0gfbvs15WC/aNGXwE2xmu8LVyllaQzOoUs/ae4fNDxvikf1Y7TGOwa3TVtiPZCXPoqJD
         Esxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kFGmiQs4hGB3dsTaclN/rSlgnX+dGLmiGsx43g87JM=;
        b=69iee+1mmPFFw7byoHA/hPn+W1Z07JngqxvzLHyTRqP40/ZXHdokPkf0dawGWvvfo6
         vUCzG/zzVK9gLtcVVQWc3i9WD8yUp1o5dIWPpUm2W7ZOh1ADtErovE+uysx/o+Yl1PFk
         47keSvqbG5lUQvXm09vh5VeFT4mQgGp0A1Q93XWQ5NbGGWBfS1M3C9Ykv8GNZ7Tbseac
         gAXa6FznXb/ECi2oFIr17Ol5Rkg5OJUEY9VineSdMqXz0g+znqPzl+Lq91e7TjCuiJ4a
         w05Pfg8sxpksTmU/tPO8dc1P+KKFhr0bQVDAdGshKq9/yTeiDfzmqwBI6yz4zYyNR+xo
         m++g==
X-Gm-Message-State: AO0yUKUIrqjNxn9o2dTMWfgNY3dpeg1FfcRWHyi7QyyvmtpWn07Jo6Dy
        8HD+XD7D68dCstPxbFPzf5/EcQ==
X-Google-Smtp-Source: AK7set8DydMAHy4wQVqZlksBBXv1wwVArVnKGPE6agOkluF9u0jqeeP0aC5cBDUvf+a4Myo6kXqRkQ==
X-Received: by 2002:a17:903:2cd:b0:198:af50:e4e2 with SMTP id s13-20020a17090302cd00b00198af50e4e2mr250810plk.8.1677856980656;
        Fri, 03 Mar 2023 07:23:00 -0800 (PST)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b005d55225fc07sm1749768pfn.73.2023.03.03.07.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:23:00 -0800 (PST)
Date:   Fri, 3 Mar 2023 07:22:56 -0800
From:   Zach O'Keefe <zokeefe@google.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/khugepaged: Cleanup memcg uncharge for failure path
Message-ID: <20230303152256.a5z3wc2v6wri5ijy@google.com>
References: <20230303151218.311015-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303151218.311015-1-peterx@redhat.com>
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

Thanks Peter!

On Mar 03 10:12, Peter Xu wrote:
> Explicit memcg uncharging is not needed when the memcg accounting has the
> same lifespan of the page/folio.  That becomes the case for khugepaged
> after Yang & Zach's recent rework so the hpage will be allocated for each
> collapse rather than being cached.
> 
> Cleanup the explicit memcg uncharge in khugepaged failure path and leave
> that for put_page().
> 
> Suggested-by: Zach O'Keefe <zokeefe@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Zach O'Keefe <zokeefe@google.com>

> ---
>  mm/khugepaged.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 941d1c7ea910..dd5a7d9bc593 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1230,10 +1230,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  out_up_write:
>  	mmap_write_unlock(mm);
>  out_nolock:
> -	if (hpage) {
> -		mem_cgroup_uncharge(page_folio(hpage));
> +	if (hpage)
>  		put_page(hpage);
> -	}
>  	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
>  	return result;
>  }
> @@ -2250,10 +2248,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		unlock_page(hpage);
>  out:
>  	VM_BUG_ON(!list_empty(&pagelist));
> -	if (hpage) {
> -		mem_cgroup_uncharge(page_folio(hpage));
> +	if (hpage)
>  		put_page(hpage);
> -	}
>  
>  	trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, addr, file, nr, result);
>  	return result;
> -- 
> 2.39.1
> 
