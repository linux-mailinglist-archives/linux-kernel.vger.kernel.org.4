Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2335E82AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiIWTsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiIWTsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:48:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05EA1323E9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:48:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l10so1071192plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LWXlTBMzBHY8/RDjz/XaxuIaQimJV8NYOPXjURO0DVA=;
        b=AwzKiLnafZK7mBFElsrxYgXpuhCcb0V8YNmMnmimU0hlaAcOqbnznpqv++v6Zu1XXK
         T77MV+nH09MUxz4NMYF1oT9jrYu8SyiU7YyIQWmBromBpxB+k7eFJ+ZxRaGjNLaPyyIe
         AyAujNKZZo2sLqJdakfSaT4GAUHD7H2e8Rld4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LWXlTBMzBHY8/RDjz/XaxuIaQimJV8NYOPXjURO0DVA=;
        b=24RKVi7PDy+QsvHwi6Y1gxWXDBxefxGKU8M4Mc1r9SZQBdGG8vSMvmt2BtG3PMJwMp
         p9evRZCEXntyj0gLXgyO7HSgCI1ql2eagUrrLKVQp0Yx75g+6yZrRL0gUdBCjXKYbRtJ
         tbAQR1B3ByhJsEo64AhTg+ym6+XOPITcLbMSnpZBDkUf4ArHzz/hwEtx2DPP8I8SLiIk
         FNy5fFafyXXcwksvpUzOIQgH44WAS2cjmVbEpFpXmkQr0HtH8tXhyioHftDX4kepmKRe
         onGYXpkl118qQnJOCW1CH0ggnlQ2Ao9N/Tj/jhxClKhc9p2VqX7xneBZ3876KDOG03im
         IdjQ==
X-Gm-Message-State: ACrzQf26u7wdaxFmG0hfeRA3punr07Gt69V79xncRfwMkvQmCQ/KkzdP
        UFTBYhvwHxx7AVpNmLURaIhAPg==
X-Google-Smtp-Source: AMsMyM7bDZajh6oHdZnatHqDhw0iyyGb6dwwHuzZ6SxbHCuTloaEzkC1FhfRge/dE2kdLj7JlkBSXQ==
X-Received: by 2002:a17:902:f707:b0:178:77ca:a770 with SMTP id h7-20020a170902f70700b0017877caa770mr9982812plo.54.1663962489579;
        Fri, 23 Sep 2022 12:48:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o13-20020a63e34d000000b00438e0db80dasm5990756pgj.65.2022.09.23.12.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:48:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        Jason@zx2c4.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra comparison
Date:   Fri, 23 Sep 2022 12:47:19 -0700
Message-Id: <166396243656.2664601.3410906576496436654.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923154001.4074849-1-Jason@zx2c4.com>
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com> <20220923154001.4074849-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 17:40:01 +0200, Jason A. Donenfeld wrote:
> Currently the clamp algorithm does:
> 
> 	if (val > hi)
> 		val = hi;
> 	if (val < lo)
> 		val = lo;
> 
> [...]

Applied (with the little changes mentioned in v2 thread) to
for-next/hardening, thanks!

[1/1] minmax: clamp more efficiently by avoiding extra comparison
      https://git.kernel.org/kees/c/97dd4f05a2ce

-- 
Kees Cook

