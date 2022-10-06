Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34575F7209
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiJFXqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiJFXqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:46:02 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9061B5E325
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:46:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z20so3072833plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SXIyK1qhAFzYku+XMAwTO5SsuTiW+z+CUM/bi0M+oVY=;
        b=cQNQsZN5V0cLpfD+qReSmh6yMS6vg9zkat2mnEwqEeL5JrMsu9LFdFPmp8KYq5kOQo
         xZQI0ZQNZ9gc1cT/DnIZQFHa9qVi4AXXJax/b4L633fAcfYqKCACD+sXvYyxY1pnh8tC
         d2vLw53KGHixXtXAm9YLsn9NJVGU/F0OrFNlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SXIyK1qhAFzYku+XMAwTO5SsuTiW+z+CUM/bi0M+oVY=;
        b=qnfn+7Y3W1P9Qp1rk4yN/olTdRN9Si4wtq0UscGXbkvCZR0eFxUpal2Ef8iIBO8n1G
         hHgLfvufmYvOZJtrGXJCBD7xE7I2QqRJAI4UJOcTb5HxORD0qctBu1A+MWFVJlrLzuL2
         cdzh0L7LilPqQ2+Xb0QwY3VNeogFQTRZqji0KIFDwDEcYujMkm0Am86s4EPBQk/G3Ay2
         GP9I8+pWvUslqfW/M31pDqo+1PAYmvy8jBZS6zpG0PJt7FYYwPxiiLRCdfDLdkR3TvS3
         7sf48kRMZshGhjz5I8RJgliiPPI5c2kQf37DATZQAzLfZ5UDHevkvIrttSgigLs0Y8WL
         MkTg==
X-Gm-Message-State: ACrzQf0UxQfNyILgss5dU+G63j1iuj7haeacjQ8DxzGeLRCZDvJ8bogH
        1DgLJ6nY8NQ5QTYciSR5WspxWw==
X-Google-Smtp-Source: AMsMyM7S0DLXGaLHUTHuIwrz5s3/eHznEXFoLvCJF4JxofB+RnHtoNnvjhbdN1UqX7UB5q2C9Gctvg==
X-Received: by 2002:a17:903:110f:b0:178:a07e:e643 with SMTP id n15-20020a170903110f00b00178a07ee643mr1822628plh.41.1665099960119;
        Thu, 06 Oct 2022 16:46:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b00178b6ccc8a0sm196000pld.51.2022.10.06.16.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:45:59 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:45:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Message-ID: <202210061645.1BA58DED4D@keescook>
References: <20221006234138.1835739-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006234138.1835739-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 04:41:38PM -0700, Kees Cook wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The crypto 'compress' interface is deprecated, so before adding new
> features, migrate to the acomp interface. Note that we are only using
> synchronous implementations of acomp, so we don't have to deal with
> asynchronous completion.
> 
> [ Tweaked error paths to avoid memory leak, as pointed out byGuilherme
                                                              ^^
gah, I'll fix this typo locally. :P

-- 
Kees Cook
