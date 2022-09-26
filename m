Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D295EAFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiIZS1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIZS1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:27:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D55655D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:26:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b21so7003892plz.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6iI2OJuE9PFdOoJjE/nC7ls9dnBCslGVfZGAd4mI3dw=;
        b=H6PDdDptW7rajCEeAQtW4ZbXRWtdj5LMxv0w0c6O5gRw0xaWSv1qBL/EIzMw6z4BGy
         IExd1qE1byVntAwKnjSHuLU2Pnxy6kU4rR7nIDZPBHhbAw9n4fVTza3WAor4o6HQ1DX7
         l7xZLbBHl1r3XIsy2Dfn26pSltlDEc5CKpPtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6iI2OJuE9PFdOoJjE/nC7ls9dnBCslGVfZGAd4mI3dw=;
        b=wu0Xd2atDOT/t5Rj6X1AtyNN1PJthGcWugEQ/hLGmneqb8uSB48O5nssnoxfY7bGoA
         PssvC29y0e0MESFmlpYJabv6AcczGNCeE/Ok+yHL1itXxD2ISM+F1oI8wdFBTfp7urgQ
         h2U/vYCGjd7I/fKXSP3HbtXXI/yTphxA5HJhFSdIqTb5EnSEK0odP/T4ys2aLN7g4mDa
         luJ/RBknrDMeIxNL4gbSLwVRWiqVSOb5en5LWe9FEjdMw9qikbLW96mUM9Z0rhz5FI/8
         4pMDsubDaz7lqC33PYrIbcodxLbJHe5p7KmN1NaY5ZoFdsX2YDGN6FVGi2/9Q4q2WmSB
         1NTQ==
X-Gm-Message-State: ACrzQf0hIW5AEtb19ZdRsvU1ypwMSqd6hDp0ualjRr3fG2bQHmZKQ7iE
        CBdazOw21SVnGcEZxksaERGtdw==
X-Google-Smtp-Source: AMsMyM6uSKwJRfDr0gn6aGBQgtK2hC5xPHMmTFslCDkXobh3WiGb6o4LysUAbSSJmJWGwz2l1dko+w==
X-Received: by 2002:a17:90a:cc04:b0:200:b869:5ba4 with SMTP id b4-20020a17090acc0400b00200b8695ba4mr70487pju.234.1664216764494;
        Mon, 26 Sep 2022 11:26:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090ace0a00b001fffbad35f6sm6817674pju.44.2022.09.26.11.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:26:03 -0700 (PDT)
Date:   Mon, 26 Sep 2022 11:26:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] minmax: sanity check constant bounds when clamping
Message-ID: <202209261125.8AEBF245@keescook>
References: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
 <20220926133435.1333846-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926133435.1333846-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:34:34PM +0200, Jason A. Donenfeld wrote:
> The clamp family of functions only makes sense if hi>=lo. If hi and lo
> are compile-time constants, then raise a build error. Doing so has
> already caught buggy code. This also introduces the infrastructure to
> improve the clamping function in subsequent commits.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
