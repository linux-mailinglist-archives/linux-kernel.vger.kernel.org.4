Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BCB622327
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 05:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiKIEed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 23:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIEeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 23:34:31 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3440A2D3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 20:34:30 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g62so15620487pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 20:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XSf7688EJgmfyljltIZDbWFwZCjWLdc9zQ1QubG37Ho=;
        b=l+VZhxngS/3lLjWx3Pb9NIgO6+fYMFmIKFIqRWSyuGweWNtx+83D3yoywYg2/+/w2v
         80wf9Gryu1OqELFfPsBKyV2em1UB0i15E02p/ttx0OanLJUSXl3U6LbF2JH5KTLIAAs7
         Tx1MOe5siEYzf3mxqlPA9IOO3uTz4tuof+tjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSf7688EJgmfyljltIZDbWFwZCjWLdc9zQ1QubG37Ho=;
        b=j45Yz6RE2daMvArydto7boKSD3fF718w6DcNWTXxLU7/dSfxfc/N2PHNDcbeTXb8HL
         TLUv1WVWM048v0FCCYmRqBVhZ4dK1drVMoI80Iz37CK8HtTsDGpAZ11vkBluBzJtfFu+
         TUzNoEZMl2xzJWkN/VQItrOssnWCsxq8gdJIaw0+pBD8eHkXHpGJmp1cF8u8ixLb5VDi
         GXccPaDd1aR0Dp69TdJ+KvythuobSfCm0lM1r9PdIftV5V1iHscC7fS95Y4toRtMKOLb
         PznSYCELCb688uD5t+txLoFkoMi9UFDAQU9unEwoMUm0KpVqGbvuiGXIlaUORXrrP6Wk
         dgvw==
X-Gm-Message-State: ANoB5pnZN62r4zwj7bdwP9g0ZfzVf7ssZnF6ZeIxiOYEhkxwJL07Lgab
        9Jt0O7/+beOLLk754QunI7+mgg==
X-Google-Smtp-Source: AA0mqf7rxEJjGKHmIBA8JCt/2QNZ7p06LKC+84VQiLmyJT0AFAG5+dCHqmWnbCkI1Od0jW/X0iZtaw==
X-Received: by 2002:a63:a552:0:b0:470:6a2c:7d25 with SMTP id r18-20020a63a552000000b004706a2c7d25mr14404518pgu.468.1667968469754;
        Tue, 08 Nov 2022 20:34:29 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e98a:ab9b:7583:cb8a])
        by smtp.gmail.com with ESMTPSA id c72-20020a621c4b000000b0054ee4b632dasm7184941pfc.169.2022.11.08.20.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 20:34:29 -0800 (PST)
Date:   Wed, 9 Nov 2022 13:34:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 7/9] zram: add pages_per_pool_page device attribute
Message-ID: <Y2st0b00KHTK0nrI@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-8-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031054108.541190-8-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/31 14:41), Sergey Senozhatsky wrote:
[..]
>  	zram->mem_pool = zs_create_pool(zram->disk->disk_name,
> -					ZS_DEFAULT_PAGES_PER_ZSPAGE);
> +					zram->pages_per_pool_page);
>  	if (!zram->mem_pool) {
>  		vfree(zram->table);
>  		return false;
> @@ -2174,6 +2213,7 @@ static DEVICE_ATTR_RW(writeback_limit_enable);
>  static DEVICE_ATTR_RW(recomp_algorithm);
>  static DEVICE_ATTR_WO(recompress);
>  #endif
> +static DEVICE_ATTR_RW(pages_per_pool_page);

May be we can have a more generic "allocator_tunables" device attribute,
which will support named parameters instead. E.g.

	pool_page_len_limit=INT

And more in the future.

Having hard times coming up with good names here. max_pages_per_zspage
is too low level and exposes zsmalloc internals, while in theory zram
can use different allocators at some point, and those allocators can
have different tunables.
