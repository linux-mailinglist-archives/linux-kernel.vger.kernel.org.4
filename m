Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A566AE20
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 22:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjANVUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 16:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjANVUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 16:20:11 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EA29ED2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:20:11 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c26so14034082pfp.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7HJFHc4vyNhFUudj3U8Zir9W3HGM/Sc0XFfejprVszg=;
        b=CEydilu9g1ansXz7G1S2BeBCyQpd4YoduiBlHNNklVCkxbd4ph0+boHx8qH420rHHF
         x16y/DIWA4d6LDc0qaJ2VPk5xkp8H87dkP7VmUoImuc2mlqLsxfSKHENocg+epzcAN1b
         o+qzFg1lNlPnOnCVBr08+nQUH8S9p+xomO9Qri1BVqEaVGUKVe8V8HNF2coujlm0WmP5
         efWYpxnpFzlpLlSth6UBF4eBvA+Fv7BO2X3BQ2NJrR996YV8tGndvuQCdFZO6VMQXH8G
         /fx8Kqv5ugvM2Xkw/LqOS/3HSfjkqM1NCmvGIuyfshldj8ieDsBBK4X7ce42Tsdhb0jO
         rLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HJFHc4vyNhFUudj3U8Zir9W3HGM/Sc0XFfejprVszg=;
        b=M2zyrDTQzi+6H5ECYcvWGC+bY8Dj+p3t9LwIhP+/ADUz0gBE0QGxp+iSWzfVacYppn
         zIiguO+cdUHLyGP42t+KUO3TSOk8W/NhdPIdgNLgZily7M1It5o5WWrbR32F6Dq5QynN
         1D7l2P3OrZ1vwgfKQ1eZYKNppdTx148a/1ka/D3qcPXAFPodABqKIbzNwOyuKqSJG38+
         I4KP2WL+iRlnA8QcgOo+DBVq3LGvckFYOSUdXLgDB7TLi3c+Ii6ZH3Oa/fHPdIoiYqlH
         78VPLsn8y8zZoUZ0cMuHGOIEYDAzsED8on5BR8Z/LfGs1jIGjB8quMz5Nmoe6kl9YHWy
         OzKA==
X-Gm-Message-State: AFqh2kqq+FatbFJp39dEd8KJ5+teBKrgfVlhSBmkTgSgFMKKOHRUxLu7
        Z9BmKjrRNcZOZqkPnu4aY41F1g==
X-Google-Smtp-Source: AMrXdXstVPAlSo/NAm+0xSYKygizinQbt5AZJsCc6WdSH/2vCmSlfoi9VvwE/ZAMxRaMKQAiwJ3X0A==
X-Received: by 2002:a05:6a00:2a9:b0:588:89bc:7f75 with SMTP id q9-20020a056a0002a900b0058889bc7f75mr22598361pfs.1.1673731210346;
        Sat, 14 Jan 2023 13:20:10 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e6-20020a621e06000000b00582e4fda343sm1975052pfe.200.2023.01.14.13.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 13:20:09 -0800 (PST)
Date:   Sat, 14 Jan 2023 21:20:05 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] android: fix W=1 kernel-doc warnings
Message-ID: <Y8MchYSzhQil3Kc+@google.com>
References: <20230113063617.4129-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113063617.4129-1-rdunlap@infradead.org>
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

On Thu, Jan 12, 2023 at 10:36:17PM -0800, Randy Dunlap wrote:
> Clean up kernel-doc notation, use correct function and parameter
> names.
> 
> drivers/android/binderfs.c:236: warning: expecting prototype for binderfs_ctl_ioctl(). Prototype was for binder_ctl_ioctl() instead
> drivers/android/binder.c:386: warning: expecting prototype for binder_node_unlock(). Prototype was for binder_node_inner_unlock() instead
> drivers/android/binder.c:1206: warning: expecting prototype for binder_dec_ref(). Prototype was for binder_dec_ref_olocked() instead
> drivers/andrond/binder.c:284: warning: Excess function parameter 'proc' description in 'binder_proc_unlock'
> drivers/andrond/binder.c:387: warning: expecting prototype for binder_node_unlock(). Prototype was for binder_node_inner_unlock() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> ---
>  drivers/android/binder.c   |   16 ++++++++--------
>  drivers/android/binderfs.c |    4 ++--
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff -- a/drivers/android/binder.c b/drivers/android/binder.c
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -277,7 +277,7 @@ _binder_proc_lock(struct binder_proc *pr
>  
>  /**
>   * binder_proc_unlock() - Release spinlock for given binder_proc
> - * @proc:         struct binder_proc to acquire
> + * @_proc:                struct binder_proc to acquire

I think we could rename the parameter to "proc" instead. This aligns
with the other macros defined here. Aside from this minor nit:

Acked-by: Carlos Llamas <cmllamas@google.com>

Thanks Randy.
