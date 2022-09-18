Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDDE5BBDEF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 15:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIRNLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 09:11:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74AC1EC54
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 06:11:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w2so15355296pfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=a4nJECepRzauHzeEcGJem6rFGxUAD2miG6Z8rmpZzdU=;
        b=VwQdThd3OGxmaqf9u8/n7WnXb0roO+NH1j5UYuF7JowjCjN+cAx9IDyWYDcCqMiCtt
         +pQ9WPplRecJcqYdKlt63xTZy3ttYmr7HvAZmHOKdNdXQY92VpFQD60Xb39gvJSomLhL
         4uwWT08ig28b5PTk2kIh0MdRKYqLikoHbVnFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=a4nJECepRzauHzeEcGJem6rFGxUAD2miG6Z8rmpZzdU=;
        b=2XuccOHlTXTjUtb+89dxP/yQcCxF0He3/PTE/qgjZM90ybEyhx+szh2jeH8j60Fjkq
         iMzoi4Oc4S4zX8YZ5zOxHkdCwIeSockb1KsCcT0em2prgeCQ7IxXCPdKAaZh745Gv5XY
         2njWHB+nzBfbQ7cIMRUQ11iJwSxNO8YMZyOVzKDjwiFbZQ4sDhGvHGCeaYKKiD6z79zU
         c+PBRfQ7gtFgK/4FxVF3ZshiLVDJsIuvoovvIfOsJwlKdGaNEhjPnaiKFcIo50kg5EzR
         qaAQqrCWg6n4k4chSwK6NPD8oVTLaU2/TP3WXUBF1v7zaydnztrMeyomLjfB1SjQfIiv
         eHaQ==
X-Gm-Message-State: ACrzQf0LzHRJeOnphEEbQ+rVz0Jg+j1KH8II5TrjGNmMHFS8L5n1F8f9
        cst2BulyNFpO9A4fjk2mA8BQc4wNZBLREQ==
X-Google-Smtp-Source: AMsMyM7fqotQUpCBzeVmRzssXfa4jlX8CppE6RGBkbuZJnt2kFrcBaBv8OWnmtmDpPhqKQUq1solTQ==
X-Received: by 2002:a63:f806:0:b0:439:d86e:1f6e with SMTP id n6-20020a63f806000000b00439d86e1f6emr6140596pgh.46.1663506695455;
        Sun, 18 Sep 2022 06:11:35 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:85fc:8f38:671f:befa])
        by smtp.gmail.com with ESMTPSA id ij4-20020a170902ab4400b00177e5d83d3dsm18384712plb.170.2022.09.18.06.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 06:11:34 -0700 (PDT)
Date:   Sun, 18 Sep 2022 22:11:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        ccross@android.com, anton@enomsg.org, keescook@chromium.org,
        john.ogness@linutronix.de, rostedt@goodmis.org,
        senozhatsky@chromium.org, pmladek@suse.com
Subject: Re: [PATCH v1] kernel/printk: check return value of console_trylock()
Message-ID: <YycYDn82QQZYfpsl@google.com>
References: <20220917015852.3833820-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917015852.3833820-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/16 18:58), Li Zhong wrote:
> Check the console_trylock() return value in case it fails.
[..]
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index a1a81fd9889b..2c6a0484315b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2937,7 +2937,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
>  	 * context and we don't want to get preempted while flushing,
>  	 * ensure may_schedule is cleared.
>  	 */
> -	console_trylock();
> +	if (!console_trylock())
> +		return;

It supposed to be ignored and the comment above (in the code)
explains why: this is panic flush, we want to proceed regardless.
