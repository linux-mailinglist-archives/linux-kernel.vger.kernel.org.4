Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40575EAFE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIZSaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIZSaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:30:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44291275DE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:30:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lx7so674173pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MCZYDn+YVfx+EQNPPsd9wcvedMh5vvetNCp1L39ZYgw=;
        b=LvpGREEjm7+8YmtYqLvXQFOfbiNUNMEfQrpxyC5BkclXWEny0UJBPmTvSx4QkXYmYB
         ey8/EWrwFMuz5IsXLDV2X/oooIv5PToh+X+7bb/vrHAtp/u8Vl+5nrzxKZxU6nYEc0dW
         /oFDMvYnnz+EyQR//b8uTzW9gwGoX1++/xqbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MCZYDn+YVfx+EQNPPsd9wcvedMh5vvetNCp1L39ZYgw=;
        b=o8RRUnFCLFaMBOxwvmGtQIAni7u4jRu5VrdoFgsUoUnAFk8zWKkTy4E0vkhnYWx+wV
         1TXteP0oqTWH5NooHmY8iKwA4LUDlRIUS3TX8lMHxfz1KwqJVC6REqr1g1y/rBBEk43u
         Bf3Bsn3PDulBXdCmmlEInRqZ7QbZtYroY5Ovp0L1JsQpPQ71vBjikAncHsL/47FBJ9L2
         NILVVcrWHZgVqmo52Q244WApxxeFknOJP1LQ7n5MShrNivsgCKabIR8YpFG+s+/JMMnI
         anZzbQWBcGCF3A31NVIZl7ECP/ep+XrbyCHefcwoleeyaYR3CC1RQ2L1rjiCFbJEcSto
         eODA==
X-Gm-Message-State: ACrzQf1QYWeUFh2ncaFF0J5sM8pPjTcvfJ4tMilUf9cTp2H0ZDCeR1OB
        3zmWgIYLthLen/joj3+7CJRiRUN+jw7o/g==
X-Google-Smtp-Source: AMsMyM5Yzhy5P43og0jIvEGltlA0NX7N7Y28XUeKNSnFmP9iQTkOpTxO5kRO8PPkvnb+CHZo3iXABg==
X-Received: by 2002:a17:902:ec8a:b0:178:488b:cbc2 with SMTP id x10-20020a170902ec8a00b00178488bcbc2mr24262251plg.114.1664217016793;
        Mon, 26 Sep 2022 11:30:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001782aee4881sm11689283plk.153.2022.09.26.11.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:30:15 -0700 (PDT)
Date:   Mon, 26 Sep 2022 11:30:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/2] minmax: clamp more efficiently by avoiding extra
 comparison
Message-ID: <202209261127.0FBA8B7@keescook>
References: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
 <20220926133435.1333846-1-Jason@zx2c4.com>
 <20220926133435.1333846-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926133435.1333846-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:34:35PM +0200, Jason A. Donenfeld wrote:
> [...]
> In this case, we actually gain a branch, unfortunately, because the
> compiler's replacement axioms no longer as cleanly apply.
> 
> So all and all, this change is a bit of a mixed bag.

I'm on the fence -- I think the new macro is a more correct way to
describe the operation, though on the other hand, the old way provides a
simple way to compose the bounds checks.

I suspect we should probably optimize for _performance_, not code size,
so if the new branch is actually visible via cycle counts in "perf"
output, probably we shouldn't use this patch, and instead add a comment
about why it is defined the way it is.

-Kees

-- 
Kees Cook
