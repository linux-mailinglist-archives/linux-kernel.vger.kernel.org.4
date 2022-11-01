Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC5615545
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiKAWr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiKAWrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:47:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CE81EC62
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:47:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k5so7005853pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksO/1o1BhIzE4SsfOIUs7zxu3Erb/eLFTep4apIgRAw=;
        b=D20PIvH1BHu5njgDPzCx60DympS69ZgpbmXpXi+nQlXKBq8o17e0F/beS8GRCG5Lao
         R0kW2cV5tSEJTOMwlSLwrtG7lTWZFPWjR5EzEtNtLfeOny32RBuHDoadgl/C8ZMtK8ml
         40VmpnsWC2oUgisaDM/Wv7rrYrP3zekplVk68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksO/1o1BhIzE4SsfOIUs7zxu3Erb/eLFTep4apIgRAw=;
        b=YOWROeLuc5JouuTFm08q8sMDqbuXtMoVK3qvPUFhn7ygNIaxZrdIh3oRzSZiSBk141
         zRzthQPEiCHrowVezrEX0A7SBYm8IJ/HEhWcnKh38uojwzEff140UJPR/pTDD72ho7He
         XJ58QDs+ru9aW5UsVVpubMvmYa12Gl0zL2tpqNuVJfsZcstK+HYp5och2mEBnz7DdrC5
         0/Zxou2cEcaW7oD3I9yRb8kn0mQDrUchPtQ7w/vKFbTzc1mdnM9BJFw0s9TD51qg+FFl
         atXltEcQI3HC2md2bLWNLk8ks08jYgKwukEYh75tvLmI+vFajvbjpOhG2u9+1bDGiFtd
         ULvQ==
X-Gm-Message-State: ACrzQf16zVWPjsEFuZ0grLYsZQbHXFwuUpDmSVU8vTMr5VbSSx1OukoH
        JvkigAaQVUUhN1rUw8tabqcN6Yc5diDT6g==
X-Google-Smtp-Source: AMsMyM5u3nuWvNn0ECPBs1EaQXXyP85rU7+pHq9IxMRQruYWSIVY8JDFNZv4t+RXdDCYleU33I356w==
X-Received: by 2002:a17:903:289:b0:186:a8a8:e99a with SMTP id j9-20020a170903028900b00186a8a8e99amr21389283plr.104.1667342841715;
        Tue, 01 Nov 2022 15:47:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709026bc800b00177f4ef7970sm6859012plt.11.2022.11.01.15.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:47:21 -0700 (PDT)
Date:   Tue, 1 Nov 2022 15:47:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 21/30] mm: Use kstrtobool() instead of strtobool()
Message-ID: <202211011543.20ACBF9@keescook>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <03f9401a6c8b87a1c786a2138d16b048f8d0eb53.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f9401a6c8b87a1c786a2138d16b048f8d0eb53.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:14:09PM +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is part of a serie that axes all usages of strtobool().
> Each patch can be applied independently from the other ones.
> 
> The last patch of the serie removes the definition of strtobool().
> 
> You may not be in copy of the cover letter. So, if needed, it is available
> at [1].
> 
> [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/

This seems in keeping with the removal of the simple_*str*() helpers:
https://docs.kernel.org/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
