Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D610625017
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiKKCVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiKKCVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:21:00 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2710C326CE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:20:59 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y4so3148231plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6i6KL/hpCXNpABcruUBMYgjhMEOWPp+uaTBGW7BZZY0=;
        b=p4Srq9BBF4Qsrt/CuzRJBQkh5eQA5tPR1+jjoQrvDqTUUJEBTsvAxXGF5ig3NXj94w
         fryCSn6ORHHw/kogN1q7mRYNttBjmOMqMaTw3dtRX8d1YeTLZHNN5a1VRyH7eW6GwYDh
         Lnd1+l1gbVI8yh74zc/yxpk25gQU+WgADZbhkXThJPuDVhU6dDfPKbqObbY8AUJ3Mpm2
         10kStfYX6wjhKuEKfE8iCV897VELM/J//g2nnLfho5+aNAVHBjgxqycx+M1e/idNOeKS
         ehEDGtPQEBKEjZQ7TU1JbXdJ0lzd1G77hsgPcWayzP9eAPNWTfNW6v0KvoHqfBQHUf9v
         VBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6i6KL/hpCXNpABcruUBMYgjhMEOWPp+uaTBGW7BZZY0=;
        b=mIRrBqABxWDGAAB2HxZKCgNU5hzy49jrcCHRd5kU4pc8DvLuWUn6nKEWxRZnurAxZc
         /aSF3yaCmImYHWAz543FiGThw7cWx3Ip2oFeb/iNPMsE9WDgL+Tg4kXfcfe/NTmwy9ad
         mJNbXx8XfTaY1Fa/lxgGzDU25vPXBVY7h4aesUdwHz2ZW0XAdagDNhVtcA4ab5Dctckt
         tQSiY50FrfHfmRJV4p7RLMkup8HHUcVzgJst16nhw989vg7/wm9SzZKmTk+0p5JHTF9/
         tWkS90N9cAmm58hz8S4CtUg5cP1YL+8vytdoYF95Lb8qU7pu1WOKBo/PNuTCQynE8jEH
         73NQ==
X-Gm-Message-State: ANoB5pkYSFccbyL+1FyNqjC+JCNANmCPC9BIRg6w6qSMQ0US778BAWrZ
        9CxHHxiV7IxRJKvKHfdWsql5xWQMoWM=
X-Google-Smtp-Source: AA0mqf7Aj6fFKusF+WM23rFan6S+RRVt19RQy8IRcWuOnINtT7AYSKlD/gssvyUyQWrjaiHH0gchYQ==
X-Received: by 2002:a17:902:7c97:b0:186:91fa:59cc with SMTP id y23-20020a1709027c9700b0018691fa59ccmr468005pll.44.1668133258545;
        Thu, 10 Nov 2022 18:20:58 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8c0b:3260:c81c:119d])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090322d100b0017bb38e4588sm376597plg.135.2022.11.10.18.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:20:58 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 10 Nov 2022 18:20:56 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 8/9] Documentation: document zram pages_per_pool_page
 attribute
Message-ID: <Y22xiLFYb49TGeYm@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-9-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031054108.541190-9-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:41:07PM +0900, Sergey Senozhatsky wrote:
> Provide a simple documentation for pages_per_pool_page ZRAM
> device attribute.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  Documentation/admin-guide/blockdev/zram.rst | 38 ++++++++++++++++-----
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
> index 010fb05a5999..4cb287520d45 100644
> --- a/Documentation/admin-guide/blockdev/zram.rst
> +++ b/Documentation/admin-guide/blockdev/zram.rst
> @@ -112,7 +112,29 @@ to list all of them using, for instance, /proc/crypto or any other
>  method. This, however, has an advantage of permitting the usage of
>  custom crypto compression modules (implementing S/W or H/W compression).
>  
> -4) Set Disksize
> +4) Set pages per-pool page limit: Optional
> +==========================================
> +
> +zsmalloc pages can consist of up to ZS_DEFAULT_PAGES_PER_ZSPAGE (single)
> +physical pages. The exact number is calculated for each zsmalloc size
> +class during zsmalloc pool creation. ZRAM provides pages_per_pool_page
> +device attribute that lets one adjust that limit (maximum possible value
> +is ZS_MAX_PAGES_PER_ZSPAGE). The default limit is considered to be good
> +enough, so tweak this value only when the changes in zsmalloc size classes
> +characteristics are beneficial for your data patterns. The limit on the
> +pages per zspages (currently) should be in [1,16] range; default value
> +is 4.

I think we need to introudce pros and cons for user to decide it since
it's not familiar with admin. I think It would need more explanation about
zsmalloc internal(especailly zspage and size classes)
