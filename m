Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE678709606
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjESLPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjESLPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:15:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB679107
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:15:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so30050705e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684494941; x=1687086941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5c4ty46BvJfw5n+WQXNqxdOzyvhYQj2lS/o5S3NUabU=;
        b=gCgs4y5Y76wNOd3v5ENX1M97HG7iTU4N0D1XXLXCiW2Dahw6xjjO8Uz8VhYvKL/owf
         yY6izNLepEPal9uDWeNiBEi47hRk+2RX5WFPzvEDWLoJX371r8fLn/QwVYVtAIMG6SWz
         uQww68eFLAOE4iXykJoKk8LXbWF3Iu9GmVVO15edm4J7W7svCpmth1q7Azez6N+40xkE
         QqZO2Qlw9sExtyJISfGSC4hC9wMqLS4YZhwRc7wQIcIeADApdiXTIeJtufoa/EFG8qfU
         mzUeUeE5CsbRt6+f5P+mS70NILLO/ZZkXj1/iek69HTogCG5f+uATcvSzjKhyyJNkUrW
         Yawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684494941; x=1687086941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c4ty46BvJfw5n+WQXNqxdOzyvhYQj2lS/o5S3NUabU=;
        b=SPdRf1FGj7kXI7PpSKwwCVfm4smYgY5gfz5pDOeurPVrxkR70gZf6bu6pCct3z/kHd
         t1l/d5VYxQqzD3RBtlH63iKRhQoXsag9EzT2HrN4yn4zkDjPIOemkivkHKcmaLU5eY6Z
         L9Z+5ej0VdDsue40XgcW2+YsoZKJa6d206zThc30VCr6uzLcL3OHH4AcFYLtXXkQjlOc
         6udE0jaRvd+OMTS1ncf3NxeNf4SNjnYucOHePqun0j6xA1zQV/44rHP0J+n6WRzUWv4B
         VXNcOP4QnOzLap5FfxIJmJ6VurQNRBI9KXTVGRGm2isiijlknwPxpUM/a1pnjHn92oe9
         iduQ==
X-Gm-Message-State: AC+VfDw5QnJyJmxsD3ODK9AKsIW4b+aktiei1G3I7Cwpg/LpayhZBYUI
        h88oTndDnYJ7RavyWiTsTwvZcFtbUA==
X-Google-Smtp-Source: ACHHUZ6zeOwMJdajQJb+0Q5VwQ+IpfOoaMbJGZbHTnHZpwScrL+3j1XcvmjZiUuIC7T/wzkuDEeZoA==
X-Received: by 2002:a1c:f30a:0:b0:3f4:f012:5cae with SMTP id q10-20020a1cf30a000000b003f4f0125caemr1085622wmq.20.1684494940957;
        Fri, 19 May 2023 04:15:40 -0700 (PDT)
Received: from p183 ([46.53.249.116])
        by smtp.gmail.com with ESMTPSA id u3-20020a7bc043000000b003f4f89bc48dsm2066538wmc.15.2023.05.19.04.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 04:15:40 -0700 (PDT)
Date:   Fri, 19 May 2023 14:15:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] auto, kbuild: flatten KBUILD_CFLAGS
Message-ID: <0c693356-b26e-4e3e-a043-33580dd1294b@p183>
References: <20230518154648.581643-1-adobriyan@gmail.com>
 <20230518133732.ee586408921d6f77c3a96bdf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518133732.ee586408921d6f77c3a96bdf@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 01:37:32PM -0700, Andrew Morton wrote:
> On Thu, 18 May 2023 18:46:42 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Make it slightly easier to see what compiler options are added and
> > removed (and not worry about column limit too!)
> 
> I wish you'd cc'ed Linus.
> 
> Turning those four upper-cased macros into upper-cased inline functions
> is just sad.  If we're going to do this we surely should go around and
> make them lower-case.

I always wanted to rewrite division functions and get rid of our
countless variants:

	q = kdiv(n, d);
	q = kdiv3(n, d, &r);

if it gets in they will be renamed again :-)
