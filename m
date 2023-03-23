Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF85A6C65C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjCWKxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjCWKx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:53:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5542127;
        Thu, 23 Mar 2023 03:52:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so786491wmq.2;
        Thu, 23 Mar 2023 03:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679568766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OGxSqCO1wN6cKsjc/P0q0kNZx/X424ezsQ5H2UVEuwM=;
        b=W9Cw1LE5Pa8ThYl5Kf08x/ZSYqrmVJBnaqWOOexfSkLSJ/ZIwR3V1HDxITwahYGXB9
         msUhpWQuOS53FLjFK/+z2ukDnR8u8ZGsR/pSJoAuSr3nAhepG3HP03L8DvFw3aeuz8ir
         n6RAFrA7+Pac7SlJnqgpRMm6nfQhCEb+SrU4diS2LZbxnFVQ45ICHwnMALifrBNgk88P
         9mqNc4VSQfTXnXyHr+LA9jIcIW2f10x3LbIzlgr7n53UUl+F3BQsusoU1SH28JWVyQx5
         6P7quqhsxE4Bmi65OoEqMEPwpZ+3pIX7tIfYRJOkBA3cEEuJqbP0NGZxC6DzSpeCv44a
         fvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679568766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGxSqCO1wN6cKsjc/P0q0kNZx/X424ezsQ5H2UVEuwM=;
        b=HtkZhk4yVxyMb0/icjIOtr2bFRQ4UhOy3HhY1t9D8EnsCrXOa4XiOU9w/+4hka2jCd
         yqvDRTpHtrjiYU0JwP5O0CKlEWK8N8Jix/PThkyCWuH3wKorAa6SqU9yPp/oDgb7Xx5P
         ZxaPBwY6fgVcez/TVm5E0/v4GL5s1DICAOcMirCrKF3qN1jHeTd7+3hdLxtbJz44J4KN
         o2r0X7CpbOQRgtVZue8nnDagPEjhbQK4Ckby+Ad/l9wfD0P3MP/5dTnQQFS2cZTv5cGI
         D51ll/Ddp63v2st7dtvXWee9JMN8LRpFPappLwTt6xB8/oRn1Qe0xQa49K5qkSQ0ip2D
         hGVA==
X-Gm-Message-State: AO0yUKVa8+Lb/Qv4py94TWsEoxA0+vjww/NzJrp2RXa2DtaJYiOqEhiw
        ols67Uexo0YLt9s8Pbo/c8M=
X-Google-Smtp-Source: AK7set8luoAjdnxd63YAQKuR7To52BqsQyrCBhWQ8643suYBYdvPFszDaJEbXODZN3u2WsbO10fCyQ==
X-Received: by 2002:a7b:c4d7:0:b0:3ed:3033:496d with SMTP id g23-20020a7bc4d7000000b003ed3033496dmr1985718wmk.0.1679568765683;
        Thu, 23 Mar 2023 03:52:45 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t16-20020a7bc3d0000000b003ed1f6878a5sm1550562wmj.5.2023.03.23.03.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:52:45 -0700 (PDT)
Date:   Thu, 23 Mar 2023 13:52:41 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
Message-ID: <eedbfdca-0eb1-4b01-976b-4ddba516cfad@kili.mountain>
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:53:10PM +0800, Mingxuan Xiang wrote:
> platform_get_irq() no longer returns 0, so there is no
> need to check whether the return value is 0.
> 
> Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
> ---
> v1->v2: remove redundant goto
>  drivers/usb/dwc3/host.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index f6f13e7f1ba1..ca1e8294e835 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -54,12 +54,8 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
>  	irq = platform_get_irq(dwc3_pdev, 0);
>  	if (irq > 0) {
>  		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
> -		goto out;
>  	}

This patch is against kernel standards because we do not use {} curly
braces for single line indents.

I prefered the v1 patch.  It silenced the static checker warning and
deleted the dead code without getting into unrelated cleanups.

I do not like deleting the goto because now the last if statement is
different and I regard "making the last thing different" as an
anti-pattern.  It's better to be consistent.  I also prefer to keep the
error path and the success path as separate as possible.

This function is weird because we are trying a bunch of different
functions until one succeeds.  Normally it is the reverse.  Everything
is expected to succeed and we give up as soon as we encounter a failure.
So normally I would expect that the failure path would be indented an
extra tab and I tell everyone to do failure handling not success
handling but this function is the reverse.

I also do not like do nothing out labels.  It is more readable to return
directly.  Some people think that using an out label will encourage
discipline and force people to think about error handling.  There is no
evidence to support this.  I see plenty of ommited clean up in functions
which have out labels.  On the other hand, there is a lot of evidence
that do nothing out labels introduce Forgot To Set the Error Code bugs.
People sometimes think that error codes are not important but returning
success instead of failure almost always leads to a kernel crash and
for verify_input() functions forgetting to set the error code has
obvious security implications.

So anyway, I would probably re-write this function in a different way,
but it's not related to the dead code.  Next time, if someone asks you
to make unrelated cleanups don't get tricked into a huge discussion
about style.  Just say that it seems unrelated and that it should be in
a separate patch.

On the other hand, I don't really care...

I guess send a v3 of this patch but delete the { } as well.  I still
prefer v1 but since I don't care then let's do whatever is expedient.

regards,
dan carpenter

