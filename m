Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A785E9D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiIZJYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiIZJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:23:45 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B022AC4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:22:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id jm5so5649881plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=z34IoLMo4N/tZbhNNm119rJSop1B4giR+c+9BX86tb4=;
        b=aIsemP6PNKWhMgQ0ocIwr50VrKucycnzKZTNB3PWfsZ4Dm+HzlWD8IcTQGdFCsUSeZ
         JC8uWl1FVSOJYhiIyPtTzXUxnKaKRLEO/FdMPFDOV/EZIQ3tQWU6mS2xDTM/y9qux2LH
         CcgSkyVculAp1x90CmVCwqB0CBEcYtcpHojxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=z34IoLMo4N/tZbhNNm119rJSop1B4giR+c+9BX86tb4=;
        b=acrGjIQR9U53jxY5PKygfmrnx2NGMp+tw4uVUExZYzfv4KgFucepAq/ORuvetzrGdT
         idO0kpAxk1cTujeZOP01RA531cUV4RBDhFrKY/nL/TF21obxg7bK/TB2DriQr4qYq8SZ
         lcpIyh6W5+w9qcSH/RTJboJsCE/nWyBwAwDYHTUeZpJT90ToNqpjiRh90l+nfCmWQ3Qu
         E9O6No3mHJosufIkqe6Tok40wj+/X7b3b3g6uDfCr/+3ZkjZgb47IIfdBaIR2pVawg7+
         iEWT9KikG++tIQhCht+onAmgYu5xIFLVwYZJf7IcsaSYDTxIeQ12G9CP3YcGqjEP+38g
         1a3A==
X-Gm-Message-State: ACrzQf3MbpbX6SRCDzYRYMMOJvDMsAfrWwm4I2Ed3mr84/zeOyO8Kg6G
        6n8fna4lygJw+CDm6LBEO+AWWQ==
X-Google-Smtp-Source: AMsMyM4X8OnEq4IPKj8gch2ZFiDirdAUpYSJKvVvjdkpEZjWgnAuSjnznnA4jT5LOLoEux8VNCVGQw==
X-Received: by 2002:a17:903:244a:b0:177:f32b:19ff with SMTP id l10-20020a170903244a00b00177f32b19ffmr21474690pls.103.1664184141443;
        Mon, 26 Sep 2022 02:22:21 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:2a7d:69c:905d:1926])
        by smtp.gmail.com with ESMTPSA id 201-20020a6215d2000000b00537daf64e8esm11742806pfv.188.2022.09.26.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:22:21 -0700 (PDT)
Date:   Mon, 26 Sep 2022 18:22:16 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 18/18] printk: Handle dropped message smarter
Message-ID: <YzFvSC2Afizxm+eB@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-19-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-19-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/24 02:10), John Ogness wrote:
[..]
> +/**
> + * cons_print_dropped - Print 'dropped' message if required
> + * @desc:	Pointer to the output descriptor
> + *
> + * Prints the 'dropped' message info the output buffer if @desc->dropped is
> + * not 0 and the regular format is requested. Extended format does not
> + * need this message because it prints the sequence numbers.
> + *
> + * In regular format the extended message buffer is not in use.
> + * So print into it at the beginning and move the resulting string
> + * just in front of the regular text buffer so that the message can
> + * be printed in one go.
> + *
> + * In case of a message this returns with @desc->outbuf and @desc->len
> + * updated. If no message is required then @desc is not modified.
> + */
> +static void cons_print_dropped(struct cons_outbuf_desc *desc)

A silly nit: as far as I can tell printk API uses console_foo for
naming, so my personal preference would be to spell console_ instead
of cons_ (in this and in previous patches).

> +{
> +	struct cons_text_buf *txtbuf = desc->txtbuf;
> +	size_t len;
> +
> +	if (!desc->dropped || desc->extmsg)
> +		return;
> +
> +	if (WARN_ON_ONCE(desc->outbuf != txtbuf->text))
> +		return;
> +
> +	/* Print it into ext_text which is unused */
> +	len = snprintf(txtbuf->ext_text, DROPPED_TEXT_MAX,
> +		       "** %lu printk messages dropped **\n", desc->dropped);
> +	desc->dropped = 0;
> +
> +	/* Copy it just below text so it goes out with one write */
> +	memcpy(txtbuf->text - len, txtbuf->ext_text, len);
> +
> +	/* Update the descriptor */
> +	desc->len += len;
> +	desc->outbuf -= len;
> +}
> +
>  

An even sillier nit: extra blank line /* can't help noticing it every time
I read this function :) */
