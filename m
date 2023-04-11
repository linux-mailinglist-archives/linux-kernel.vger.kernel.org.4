Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1253E6DDDAE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjDKOYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDKOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:24:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759251703
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:24:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so7017448pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681223072; x=1683815072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuqZygU4tRUa0+59OIoTV2tHh2kbQKZU77mYLmKYsuY=;
        b=cOYyZmT7p7sBTBSsPuRPgIJvl79HL5HwqAgWnpojVt+pL3XSl7wEASJM/ByNzQPj6P
         qUeqONFbntS8FrqTecjkrlXQRtWgMus+nXHD67Hd+7aPf05fJAg9UnO+8YUSmfGB7ldZ
         sg7m/Xr3WIblDsKbKSx/nnuXCJjFZT9vOe8yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223072; x=1683815072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuqZygU4tRUa0+59OIoTV2tHh2kbQKZU77mYLmKYsuY=;
        b=Ry0+5V/g+fYU/M3qEoKj1Tmuj7c6SL7+qJRqhmO8CxE88llnlkq9fF2wt7iBuQHPDY
         O4ESmU16D/K7oePuB4hCM18PliBHj5r7Rg3pX0s6dHh3kY+iJlNw4hJFBMFOWVn/hXpI
         aF44pj1XJF/lisWRq/xQVAwQl3u/Xy0SVmyDHGTd6oJ73muQTu1FJp6z/GY0ExwiKRQJ
         JfRcRAINC4zeHZz1+LPVVFxDudgx2cINOnXcocpdYG3DdrqFx/SUZC7owgcy/L2HvTTX
         TmHzZ3tf8FFDK4GFus7oxCT4hNYeduMoCKEDqhUzCRfUF+sDwfJ8H2chHmrSdMM2IcNi
         VPyw==
X-Gm-Message-State: AAQBX9cDGO1/y7GeOfdlvGI/lg1ADVQkGdyc1htfSd/DtGwF+RDjZHhm
        5eHSrMiRXbUh5xbsWYIywXBK0Q==
X-Google-Smtp-Source: AKy350ZQf/xjkPTp/TYTRqQ0rznrD4nzrQo7F1MrQSwCaJhVOP5N70RwJ8WyVWEtALvdJW4kj8NYpQ==
X-Received: by 2002:a17:90b:33d2:b0:240:973d:b436 with SMTP id lk18-20020a17090b33d200b00240973db436mr3392657pjb.49.1681223071888;
        Tue, 11 Apr 2023 07:24:31 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id m7-20020a17090a4d8700b00233b18e6fb3sm4782398pjh.1.2023.04.11.07.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:24:31 -0700 (PDT)
Date:   Tue, 11 Apr 2023 23:24:27 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_buf: add seq_buf_printk() helper
Message-ID: <20230411142427.GB25053@google.com>
References: <20230411025556.751349-1-senozhatsky@chromium.org>
 <ZDVPJnx9tjetdm9K@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDVPJnx9tjetdm9K@alley>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/11 14:14), Petr Mladek wrote:
> We might want to somehow distinguish that this is actually
> printing (reading) the context of the buffer.
> 
> The name is similar to seq_buf_printf() and seq_buf_vprintf()
> whose are wrinting into the buffer.
> 
> What about the following?
> 
>      + seq_buf_printf_seq() like the existing seq_buf_print_seq()
>      + seq_buf_to_printk() like the existing seq_buf_to_user()
> 
> I personally prefer seq_buf_to_printk() because it looks more
> selfexplaining to me.

I like seq_buf_to_printk().

> > +{
> > +	const char *start, *lf;
> > +	int len;
> > +
> > +	if (s->size == 0)
> > +		return;
> > +
> > +	start = s->buffer;
> > +	while ((lf = strchr(start, '\n'))) {
> 
> We should rather use strnchr(). It seems that the trailing '\0' is
> not guaranteed. For example, seq_buf_putc() just adds the given
> character at the end.

Good point.
