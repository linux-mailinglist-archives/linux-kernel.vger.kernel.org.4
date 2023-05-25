Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79CC71178C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbjEYTn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbjEYTnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:43:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CD3E78
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:42:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so7163065e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685043755; x=1687635755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7NMbT2YdIMrqMQsEZ82lgEO8OSkjFBY3sGV3h+uAcAY=;
        b=YCO41YRi1ZMzvGGFVVlZPvs6dIRiJRYrCc8vWQdSe+nTL6Fi2am6Rvi2CKPWd5XVom
         Y88OTW1si93b5Uu4MjcPyp2JjOvV3Vfsd4gIdKp3WFxk6FBwwaf+0EB0snMSgR3IJE33
         s/cQ5jHIAntOYEAKJ2LitYGJddOWocZXFIdN6zjBZwKSs5RaeqWD5orMJyuEfQ7m4Lrc
         o+x1zr4dfupuVn1CZpAuFquEnV48tA2SzYn57S2T3c2JRW5/KbkS2kkFyQ/rVF3sL27t
         fgxNYd6vzZUM7LhnK4pNzA89DpX7das7nO9lsW/OM1rtfAPsioHXUjgNaOKkzsCsFKSk
         oXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685043755; x=1687635755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NMbT2YdIMrqMQsEZ82lgEO8OSkjFBY3sGV3h+uAcAY=;
        b=FrjExfTGfH1pqExczgfHxWTBejlSwl8MFUqXTibNVWv8hMuTid8oFydZj3GtwBy6tf
         aLgkEoA2itUTlrAisjFB4vHy4PqhlIDyXG8dpLI+Az/P8BPyUTnxNZnCNJX3rDMReKET
         5KhqD7+4gl7pkSpNo+t8XNz6UFZQIg0AYzz9ET3NRLt51hQ/RkNR9qvYQbCcqm7B9tQw
         wuKxu/Kf0TZgpvR/39RbRzAQ+mbrDFrNx7wYfBtQZ8jM1W1zE9onjolqU26FwWDkmoh9
         dCroWzntyDDzkAp8rH1hFsmcXkr+6trYr+/JU848rUFgJ1d9SbQUwluDQNIkF7vo8DBd
         WNwA==
X-Gm-Message-State: AC+VfDylRmNdliFX15D/LjJUTFboDaALlsDNtL+fwXKpKbu9f3oHsjDe
        W1eZYSJ8wFFFz8dXVtync/jdHg==
X-Google-Smtp-Source: ACHHUZ7MR4izT0ZwRRpeleq/5bCnFlwjq19+lIxGvN/01yzQePGbdveziISmCJHVwM+aPb2DvwdsLw==
X-Received: by 2002:a7b:c406:0:b0:3f6:e13:b268 with SMTP id k6-20020a7bc406000000b003f60e13b268mr3832943wmi.22.1685043755591;
        Thu, 25 May 2023 12:42:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c214700b003f4f89bc48dsm6758859wml.15.2023.05.25.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 12:42:34 -0700 (PDT)
Date:   Thu, 25 May 2023 22:42:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Wells Lu <wellslutw@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
Subject: Re: RE: [PATCH] pinctrl:sunplus: Add check for kmalloc
Message-ID: <ac995ef4-b9ab-4771-a3a1-46054ba303c6@kili.mountain>
References: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
 <ZGztCHNr1jmpFq0A@surfacebook>
 <1560e9c0e5154802ab020b9da846d65f@sphcmbx02.sunplus.com.tw>
 <ZG0V6_bUaz3Thy0q@surfacebook>
 <b9207257-b04f-ee2e-7025-015b0f22358a@wanadoo.fr>
 <dd0ea27640d2420eb3b521076c643919@sphcmbx02.sunplus.com.tw>
 <dbb3c0bd-3b09-2b59-8cd1-2838b9880abf@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb3c0bd-3b09-2b59-8cd1-2838b9880abf@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 08:37:36PM +0200, Christophe JAILLET wrote:
> 
> Hi,
> (adding Dan in copy because the initial report is related to smatch)
> 
> I don't use kmemleak, but could you share some input about its report?
> 
> 
> I've not rechecked my analysis, but it looked promising.
> Maybe Dan could also give a look at it and confirm your finding, or dig
> further with smatch to make sure that its static analysis was complete
> enough.

Smatch doesn't really complain about memory leaks.  I wrote that check
13 years ago and focused more on avoiding false positives instead of
being thorough.  It turns out that avoiding false positives is
achievable but pretty useless.

Checking for the of_get_parent() leaks is probably easier.  I could just
add it to check_unwind.c or create something custom.  The heuristic for
the custom check would be to print a warning if the success path
releases it but the others don't.

regards,
dan carpenter

