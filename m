Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1376A6E2F66
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 09:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDOHEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDOHEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 03:04:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AFC5270
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 00:04:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-246eebbde1cso1103853a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 00:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681542251; x=1684134251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eTa+lMBCHO7L0+7TksYhT30u4fuGH0rCCtPfzsrDaJQ=;
        b=h3Kji2rL+3AGHSzdFNT4HonixfuhvfvaJe60hfy6cHGXyCEo9yQdU+ThBKdcn60O4w
         /fdMS2slTzx73JX4OeTm7JcjVafLWKYq5TC5Ok4ZtIYZRonHlwte+B7uVOgTHkRvFzZy
         GozprQnr3Lg2Uma+P2YI35XesALQmcBhlsndg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681542251; x=1684134251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTa+lMBCHO7L0+7TksYhT30u4fuGH0rCCtPfzsrDaJQ=;
        b=dz27gMP0IJ8oaPk6M4MteM3o6Q11/2dz5XzzCRhGByA67+qlT0/uEnrguylA98JYFw
         AptNmYN/TptA2i+ODawp9+0GKwjYejcHAEjfffm1uYCfPKKfYJFc6HRTNmAsoFselyFP
         ToRMWEz9V3IOuRsBA7/la5A3BVAMT0SbZCvPbFHJY9y0kFDC/ULkMjA6oSVptiNmVyAU
         YUt7E6N+c4eq+OZaxbhxuId3agwyzH6uxkklzSoX3Z7bi8eevdZwlP06+3EMF0mSu/GV
         YdYBdf/xTSiLVdfsGk4FF0xd+zNv7lEDiRflwtFr11ni6gnfVTfDkNdjYoHc7V1lzumc
         v0tw==
X-Gm-Message-State: AAQBX9dVm8K9RfkJ+P1E+WaA5YTBqmTfQF5fBDZeDk3+ney5YhfSYlzT
        J8Gpf/sm+kHTZ4EUII2RPv8E4A==
X-Google-Smtp-Source: AKy350Z60V6Vr+RpGT84P8Uw/d/6nDYM+rMN8WwclaxtWOIOgyDSBtUPqMUV02gFrfPtT45VQCqi2Q==
X-Received: by 2002:a05:6a00:1949:b0:635:120e:ff65 with SMTP id s9-20020a056a00194900b00635120eff65mr11948709pfk.25.1681542251219;
        Sat, 15 Apr 2023 00:04:11 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id c21-20020aa781d5000000b006363690dddasm4049704pfn.5.2023.04.15.00.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 00:04:10 -0700 (PDT)
Date:   Sat, 15 Apr 2023 16:04:06 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] seq_buf: add seq_buf_do_printk() helper
Message-ID: <20230415070406.GJ25053@google.com>
References: <20230411143852.868524-1-senozhatsky@chromium.org>
 <ZDkWR2lq2MZ4r1aG@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDkWR2lq2MZ4r1aG@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/14 11:00), Petr Mladek wrote:
> > +void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
> > +{
> > +	const char *start, *lf;
> > +	int len;
> > +
> > +	if (s->size == 0 || s->len == 0)
> > +		return;
> > +
> > +	seq_buf_terminate(s);
> > +
> > +	start = s->buffer;
> > +	while ((lf = strchr(start, '\n'))) {
> > +		len = lf - start + 1;
> > +		printk("%s%.*s", lvl, len, start);
> > +		start = ++lf;
> > +	}
> > +
> > +	/* No trailing LF */
> > +	if (start < s->buffer + s->len) {
> > +		len = s->buffer + s->len - start;
> > +		printk("%s%.*s\n", lvl, len, start);
> 
> We know that the string is '\0' terminated, so the last print
> might be easier:
> 
> 	if (start < s->buffer + s->len)
> 		printk("%s%s\n", lvl, start);

Indeed. Steven, let me know if you'd prefer a v3.

> Anyway, it looks good. With or without this change:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks Petr!
