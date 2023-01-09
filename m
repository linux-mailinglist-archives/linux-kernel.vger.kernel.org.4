Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB556624F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbjAIMDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbjAIMDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:03:48 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222D61A05D;
        Mon,  9 Jan 2023 04:03:47 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id g10so6092632wmo.1;
        Mon, 09 Jan 2023 04:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue8ZryD4OifG+765s/NA7Xed1V4rDSbbS8QMK3/tzlg=;
        b=rwP15RZ0/1+7LfVx7XBYnG+G6kD11N2IpUvoEHprCauge55D02wPrdW5tAVeXQLuwA
         Gh+GKYkU5kEbJTGo0dOQfhJzA4/qRsIIeGfMwavJchfcFaCJAx8lLw+NaNNsTlMcF+za
         fE5ba6+9pjze3rxssw6Yq1nzsdoKwx+PUtsFr7btAIw9O6mwzYTHbg3ozvjf69R5hlJw
         yGMWqA8ou9EvwSRJh54ol8xbrCOz9Qm4F/tya/egct/bms2r3x3BHf53wfBfGLd7UwCf
         vRXxeCqW6H3yVOmBDMxbSeAJovXaL0s/KTAz8bMkxDDg8TGHpHLco+Oq90ldtUeDYWUS
         egiQ==
X-Gm-Message-State: AFqh2kqtQCyzJ1FZzkJyFeZXUwyOYP0ehCoyiSoOWqGgPXeNfYiVYQjq
        lCqSDefGkzbRV4L/bdpBIPg=
X-Google-Smtp-Source: AMrXdXtLv5zMRtlHf28izagU9USocWvJAY0fOaTudBh4u/kLkBBlRTf+qGPE8Y+UfFC+J+OgiTYPeA==
X-Received: by 2002:a05:600c:4fce:b0:3d9:ee01:60a4 with SMTP id o14-20020a05600c4fce00b003d9ee0160a4mr3264887wmq.1.1673265825676;
        Mon, 09 Jan 2023 04:03:45 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id z9-20020a7bc7c9000000b003d9ef37ec1bsm4563989wmk.5.2023.01.09.04.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 04:03:45 -0800 (PST)
Message-ID: <6e18fcfc-2d65-716f-a0bd-81611af39b9d@kernel.org>
Date:   Mon, 9 Jan 2023 13:03:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230105220549.never.529-kees@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] vt: Replace 0-length array with flexible array
In-Reply-To: <20230105220549.never.529-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 01. 23, 23:05, Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace struct uni_screen's
> "lines" 0-length array with a flexible array. Detected with GCC 13,
> using -fstrict-flex-arrays=3:
> 
> ../drivers/tty/vt/vt.c: In function 'vc_uniscr_copy_area':
> ../drivers/tty/vt/vt.c:488:48: warning: array subscript dst_row is outside array bounds of 'char32_t *[0]' {aka 'unsigned int *[]'} [-Warray-bounds=]
>    488 |                 char32_t *dst_line = dst->lines[dst_row];
>        |                                      ~~~~~~~~~~^~~~~~~~~
> ../drivers/tty/vt/vt.c:335:19: note: while referencing 'lines'
>    335 |         char32_t *lines[0];
>        |                   ^~~~~
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/tty/vt/vt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 981d2bfcf9a5..b1445f00f616 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -332,7 +332,7 @@ typedef uint32_t char32_t;
>    * scrolling only implies some pointer shuffling.
>    */
>   struct uni_screen {
> -	char32_t *lines[0];
> +	DECLARE_FLEX_ARRAY(char32_t *, lines);
>   };

Perhaps I am missing something, but why don't we simply have:
   char32_t **uni_screen_lines;
? And even if we don't, we should likely convert to array_size() on the 
alloc site.

And a side note: what's actually the purpose of all that 
NO_VC_UNI_SCREEN and closely connected get_vc_uniscr()?

thanks,
-- 
js
suse labs

