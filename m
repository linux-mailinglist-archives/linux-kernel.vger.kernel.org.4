Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC786AB71D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCFHcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCFHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:32:21 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0FE1E1F6;
        Sun,  5 Mar 2023 23:32:14 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id x3so34435811edb.10;
        Sun, 05 Mar 2023 23:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pm0x4fqlfAeEzJPriOrQAjntt1zRX/Yfaoag++nZIAU=;
        b=JH5w0pfZny281nPZgAswTSEKMSZk5BAFKDW3G1zsnvrEA2ua7gPT0GDifreZHpGEKo
         rZx6gMvJ/NsquGEpmD3765L8AefkDFqvT/uyH1FePqquz+Zyx+PiqvoTDhABqd+0E8z3
         XptAKD8Zr/ykHUGwLzwYbzsLr9D+I9nOLkZ+DJS+8zRszF5nIh9GHiuNh09/qsIiiGj2
         etUrd2GfHyy2Pn2FgHPldHaaACTeUhHYx1Ha8FJMvKb77eiW6ylzz88ABBr3/CQTxyHC
         AbQK+ip45qU9pE/kXsYnkgIA3aU8iUkubb9fdnMJM9EWAMN+HnO8y44C0jl1GAKPzQR/
         7RcA==
X-Gm-Message-State: AO0yUKVK2T0bLEf3B0V5JXyMk3gBBhezCH9RZnoLlW8o/jGWo0omMzdS
        vqOEXUUAAJCFGOSL2pjH4us=
X-Google-Smtp-Source: AK7set9dbhyXhawSmKkm+JAltjTchBJ76X1X+ibGzFyFJ9uagZEWW8FUL417SbzurwsRWXQfaYtV5g==
X-Received: by 2002:a17:907:6d89:b0:8b1:3f5b:af5f with SMTP id sb9-20020a1709076d8900b008b13f5baf5fmr12613632ejc.73.1678087933060;
        Sun, 05 Mar 2023 23:32:13 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906078f00b008ea8effe947sm4174975ejc.225.2023.03.05.23.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 23:32:12 -0800 (PST)
Message-ID: <5758e4f4-a37b-91c1-0a60-850b4152e7db@kernel.org>
Date:   Mon, 6 Mar 2023 08:32:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kees Cook <keescook@chromium.org>,
        syzbot <syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <0000000000001d1fb505f605c295@google.com>
 <64026f89.170a0220.7940.49ff@mx.google.com>
 <20230305175457.kp6b5lmwwdxw4ii6@begin>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in con_font_op
In-Reply-To: <20230305175457.kp6b5lmwwdxw4ii6@begin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 03. 23, 18:54, Samuel Thibault wrote:
> Kees Cook, le ven. 03 mars 2023 14:07:04 -0800, a ecrit:
>> #define max_font_width  64
>> #define max_font_height 128
>> #define max_font_glyphs 512
>> #define max_font_size   (max_font_glyphs*max_font_width*max_font_height)
>> 	...
>>          font.data = kvmalloc(max_font_size, GFP_KERNEL);
>> 	...
>>          if (op->data && copy_to_user(op->data, font.data, c))
>>                  rc = -EFAULT;
>>
>> it is correctly seeing "c" (4194560 in the report) as larger than
>> "max_font_size" (4194304, seen reported by "folio_size(folio)"). The
>> "c" calculation comes from:
>>
>>          unsigned int vpitch = op->op == KD_FONT_OP_GET_TALL ? op->height : 32;
>> 	...
>>                  rc = vc->vc_sw->con_font_get(vc, &font, vpitch);
>> 	...
>>          c = (font.width+7)/8 * vpitch * font.charcount;
>>
>> So yes, 4194560 is larger than 4194304, and a memory exposure was,
>> in fact, blocked here.
>>
>> Given the recent work in this area, I'm not sure which calculation is
>> wrong, max_font_size or c. Samuel?
> 
> They are not wrong. It's the vpitch value (coming from userland's
> op.height) which is out of bound and missing a check.
> 
> The patch below should be fixing it, could you check?
> 
> I don't know how I am supposed to properly reference the syzbot report
> etc., could somebody used to the process handle submitting the fix?

It's as simple as adding:
  Reported-by: syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com
to the tags.

> VT: Protect KD_FONT_OP_GET_TALL from unbound access
> 
> In ioctl(KD_FONT_OP_GET_TALL), userland tells through op->height which
> vpitch should be used to copy over the font. In con_font_get, we were
> not checking that it is within the maximum height value, and thus
> userland could make the vc->vc_sw->con_font_get(vc, &font, vpitch);
> call possibly overflow the allocated max_font_size bytes, and the
> copy_to_user(op->data, font.data, c) call possibly read out of that
> allocated buffer.
> 
> By checking vpitch against max_font_height, the max_font_size buffer
> will always be large enough for the vc->vc_sw->con_font_get(vc, &font,
> vpitch) call (since we already prevent loading a font larger than that),
> and c = (font.width+7)/8 * vpitch * font.charcount will always remain
> below max_font_size.
> 
> Fixes: 24d69384bcd3 ("VT: Add KD_FONT_OP_SET/GET_TALL operations")

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 57a5c23b51d4..3c2ea9c098f7 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4545,6 +4545,9 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
>   	int c;
>   	unsigned int vpitch = op->op == KD_FONT_OP_GET_TALL ? op->height : 32;
>   
> +	if (vpitch > max_font_height)
> +		return -EINVAL;
> +
>   	if (op->data) {
>   		font.data = kvmalloc(max_font_size, GFP_KERNEL);
>   		if (!font.data)

-- 
js

