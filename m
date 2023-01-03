Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F4065BD1C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjACJYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjACJYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:24:33 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A583EE03E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:24:32 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id u19so72146743ejm.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4la+LntIbv1wCYTLkTP+UYU3dGRE5VO/c1OtHKRiE0=;
        b=dtc9wzsURy93AEZtnvych+7w89vbks1rdT/ReSg/jhINa5L6u7gtsBWZHrBYiAsgWg
         TsaLFgXmWLxYef4+M9zKRF6If+zQ7qg7k5H5nwD5rxKXyzjNhNsWa3icEVZE1aSWsIq0
         i/CADii2DTsp+HepZ+DGenFNTulQg6cIJXt+qSd+RsVNC4qI+i5z9DVgjF9ZIOkBQYKG
         3cg93HeoVxJHmrZb52uMnt7AsHjsf5i5g/QYZ1UJD06GOklK3h1gZlu8wme0VIjqkW5U
         srgf9EVNSPwzFOl/LRi7MoYmcorlIU5UHCKUZryfgkI/KGaq26vQWYikkFnFR6g6MT2h
         E6fg==
X-Gm-Message-State: AFqh2koHpQO9UozgQaFz0pKtBX/8+meNM5/j1HLtAuFyLhgikMlA0n3+
        Gr+V1vSYInjgWrtKQNJs/ng=
X-Google-Smtp-Source: AMrXdXtnZPyTLylHQsusZ7+Zm/J0JZ1Bn//ViVEv2MQtpJJzq/c12HEgthTCavI8tb/CEFnpSuxM0A==
X-Received: by 2002:a17:907:8312:b0:7fc:3fef:ab86 with SMTP id mq18-20020a170907831200b007fc3fefab86mr31571784ejc.71.1672737871164;
        Tue, 03 Jan 2023 01:24:31 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090631cb00b0084c465709b7sm11090947ejf.74.2023.01.03.01.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:24:30 -0800 (PST)
Message-ID: <182d36d5-df77-2479-882a-5bb588c5f170@kernel.org>
Date:   Tue, 3 Jan 2023 10:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Hang Zhang <zh.nvgt@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Helge Deller <deller@gmx.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org
References: <20221229064153.23511-1-zh.nvgt@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: vt: add some NULL checks for vc_data
In-Reply-To: <20221229064153.23511-1-zh.nvgt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 12. 22, 7:41, Hang Zhang wrote:
> vc_selection(), do_blank_screen() and scrollfront() all access "vc_data"
> structures obtained from the global "vc_cons[fg_console].d", which can
> be freed and nullified (e.g., in the error path of vc_allocate()). But
> these functions don't have any NULL checks against the pointers before
> dereferencing them, causing potentially use-after-free or null pointer
> dereference.

Could you elaborate under what circumstances is fg_console set to a 
non-allocated console?

> Prevent these potential issues by placing NULL checks in these functions
> before accessing "vc_data" structures. Similar checks can be found in
> other functions like vt_console_print() and poke_blanked_console().
> 
> Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> ---
>   drivers/tty/vt/selection.c | 3 +++
>   drivers/tty/vt/vt.c        | 5 +++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 6ef22f01cc51..c727fd947683 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -319,6 +319,9 @@ static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
>   {
>   	int ps, pe;
>   
> +	if (!vc)
> +		return 0;
> +
>   	poke_blanked_console();
>   
>   	if (v->sel_mode == TIOCL_SELCLEAR) {
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 981d2bfcf9a5..00f8fdc61e9f 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1493,6 +1493,8 @@ void scrollback(struct vc_data *vc)
>   
>   void scrollfront(struct vc_data *vc, int lines)
>   {
> +	if (!vc)
> +		return;
>   	if (!lines)
>   		lines = vc->vc_rows / 2;
>   	scrolldelta(lines);
> @@ -4346,6 +4348,9 @@ void do_blank_screen(int entering_gfx)
>   	struct vc_data *vc = vc_cons[fg_console].d;
>   	int i;
>   
> +	if (!vc)
> +		return;
> +
>   	might_sleep();
>   
>   	WARN_CONSOLE_UNLOCKED();

thanks,
-- 
js
suse labs

