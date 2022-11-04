Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F24619F45
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiKDRx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKDRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:53:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307DA13F58
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:53:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l2so5539387pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AYqS6mUkjpXYu0T8n2KAq9xhXXH9ady33cw5jnMQfc=;
        b=oa0bWEELOkYXMyGM8Nr2LpiqMV8AeIGsNwMsA2/belHZtqm8lU2Vm32X9ex8K7R/jZ
         a71lzul/ITSf8L72il2yLGy2PVhdERNYB/kU8imcv8WCgAfsx+IrgA3vV9hngSoZN2jh
         Zgse9vFoPwGL962j9enmfSnr+nhUhxfiyjakBnRLBx3psXf8CYsPYUWnledbA98wrgu8
         cWwYX76ZgWV9NRCgqKsrGFa5PnjbM+oZiVMfkWVxLyo3S4VHlU1BW7MTx67QCvIUDwzv
         4hvgrubfRR7dVV6SlYAd5/e+uzbashuY0FrbXSpe+FrB7lB4HubkdldpQM/RocPWpl1q
         s4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AYqS6mUkjpXYu0T8n2KAq9xhXXH9ady33cw5jnMQfc=;
        b=Cymb4srlBJgguP/buINtxr6lrxqnDi4JHGpB8qN8rCR/m15KWsssq1p2jCBfLRxERM
         ru1ksKvmO0DwqZ3zzImUgkwqIy+sk6GrPWg9FAUGfPU305TB/ucO0dXcg4ydWbX0n45M
         LhObXMFMS/L6Nc1xRzhhRBHQB1VT/YS7t2HBAXtNUafXjJd0XZNpR1t1TYG7xzqGpLMV
         Ls7Go9F0p+4vpEmBT8T47FBg3jXrUdctFJylzZLzgzmMvoW4zqUl+iS6XjRj4Gu6HBCf
         fU4UwJDFWGUB7Xc67LlocA7r/p9VpfHFfE7B2Ybhf9bFnL0IKMt2Cx+q3di1qn8YI59b
         WTyQ==
X-Gm-Message-State: ACrzQf0xj4U3pVpTZGONyFdG9OcQ1AMFcc0Z+UloVd3jcZ5S0MQuJ6of
        1rg6UsINOB9xO90I8Bc6wP4=
X-Google-Smtp-Source: AMsMyM6Yx44eGHHswjMF/T+vbjCAyA/4tua1IM0bZYF1atgKJLGGcH6VWOBtIMuQ3FU39KesOAAjyw==
X-Received: by 2002:a17:903:2352:b0:186:aaed:e7b8 with SMTP id c18-20020a170903235200b00186aaede7b8mr35944162plh.47.1667584403403;
        Fri, 04 Nov 2022 10:53:23 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:755f:cdcb:1bd8:5ad8])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001886ff82680sm12698plh.127.2022.11.04.10.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:53:22 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 4 Nov 2022 10:53:21 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2VRkWAWScIF+BDB@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
 <Y2Lbxp6to4QNYyGe@google.com>
 <Y2M0t5etyJiUfeQi@google.com>
 <Y2PzseskzPelrZum@google.com>
 <Y2SLmuxLy8tf1X9m@google.com>
 <Y2S7TWpx6UnQHsZ9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2S7TWpx6UnQHsZ9@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 04:12:13PM +0900, Sergey Senozhatsky wrote:
> On (22/11/04 12:48), Sergey Senozhatsky wrote:
> > > read_block_state
> > >     zram_algo_idx(zram, index) > 0 ? 'r' : '.');
> > > 
> > > zram_read_from_zpool
> > >     if (zram_algo_idx(zram, idx) != 0)
> > >         idx = 1;
> > 
> > As an idea, maybe we can store everything re-compression related
> > in a dedicated meta field? SKIP flag, algorithm ID, etc.
> 
> That's just an idea.
> 
> Something like this
> 
> ---
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index bdfc9bf0bdd5..c011d0f145f6 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -49,8 +49,6 @@ enum zram_pageflags {
>         ZRAM_UNDER_WB,  /* page is under writeback */
>         ZRAM_HUGE,      /* Incompressible page */
>         ZRAM_IDLE,      /* not accessed page since last idle marking */
> -       ZRAM_RECOMP,    /* page was recompressed */
> -       ZRAM_RECOMP_SKIP, /* secondary algorithm cannot compress this page */
>  
>         __NR_ZRAM_PAGEFLAGS,
>  };
> @@ -64,6 +62,11 @@ struct zram_table_entry {
>                 unsigned long element;
>         };
>         unsigned long flags;
> +#ifdef CONFIG_ZRAM_MULTI_COMP
> +       unsigned int incompressible:1;
> +       unsigned int priority:2;
> +#endif
> +
>  #ifdef CONFIG_ZRAM_MEMORY_TRACKING
>         ktime_t ac_time;
>  #endif
> ---
> 
> The reason I'm thinking about it is that we have flags bits that are
> used only when particular .config options are enabled. Without those
> options we just waste bits.
> 
> Recompression is one such thing. Another one is writeback.
> 
> ---
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index c011d0f145f6..7076ec209e79 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -45,8 +45,6 @@ enum zram_pageflags {
>         /* zram slot is locked */
>         ZRAM_LOCK = ZRAM_FLAG_SHIFT,
>         ZRAM_SAME,      /* Page consists the same element */
> -       ZRAM_WB,        /* page is stored on backing_device */
> -       ZRAM_UNDER_WB,  /* page is under writeback */
>         ZRAM_HUGE,      /* Incompressible page */
>         ZRAM_IDLE,      /* not accessed page since last idle marking */
>  
> @@ -68,6 +66,8 @@ struct zram_table_entry {
>  #endif
>  
>  #ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +       unsigned int under_writeback:1;
> +       unsigned int written_back:1;
>         ktime_t ac_time;
>  #endif
>  };
> ---
> 
> So we can use ->flags only for things that are independent of .config

Couldn't we move them into a dedicated field to introduce one more field
overhead in the meta area when we run out the extra field in the flag?
So I'd like to squeeze the bits into flag.
