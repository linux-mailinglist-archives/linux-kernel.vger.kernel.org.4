Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C24069D492
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjBTUQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjBTUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:16:34 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F2211DB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:16:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id az11-20020a05600c600b00b003dc4fd6e61dso1944203wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fGak+zsOgIQZ+8TqKX/HgsRSP6dYLmVmlCHgRlwlcjA=;
        b=e8suUiCvjcLliiLOLCFqYaiVi40vCxOt/ewVVKV2pd7zHDzc3iGPEQrfSjbaGIThlm
         QfCj/UKBB6fJts7pcqPhGy7E0vD8PbTeShbu1fCB5R9r/GuxCDqihart0B27eflpBbuL
         l1RbVh7Qsw9N8xaYvGQSJSxTZMDgGAK8kR0xx3Q/XN/k/LZeWAFIlOefaR1oSdjObOWn
         z9MEkin3JG4Vas2K5MluAXn39aYFI3x8x5r13SpKopZthhDX2LsiLetfZI8Lb5jpk/Fr
         EUF8Tu3QkKfTqWfxKOILuBrv/Hl8SFgTU1t5xayUOYD+xSNRmLzS9j3AWnnSbjt5TGkD
         mSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGak+zsOgIQZ+8TqKX/HgsRSP6dYLmVmlCHgRlwlcjA=;
        b=cvtTsuoM/7+LlXutcHEOFusLSCfekIe8Wcm30GpjDRtdGM/nk0k1YGrkzaHuEsu8E2
         RZGld8l6CE80bPAWejtDd+MsFwIDP7T7VoA8f7fskdLEhkMGXUwu4Z0M865UnjvO6oZT
         NZhWY9PzOUptgRAqP04zb8t4x/SxtgQxCGi8TX2SK8DCG5r8T+rlAQNYiO/iAKc8ypgU
         pVC1uE7pSCTFWojwTwJjy1LxKc/r40wGcbOBi5kkariLW90YtY1vEG8g0Uba9OLZX+2W
         IPJpThn0rTZl7ZyhmWCQd+uJeBW93ArEyQkmk8MuNKZo+rN8LBGZ6icMVqoi1KWCIzl2
         FNxg==
X-Gm-Message-State: AO0yUKVqaaHdnL0EnEhd4dQI15VUOxuOoJEL4kZ/uKIL3YxAWTpYD0bv
        b+d7oizbHNjkn+EPVot3ow==
X-Google-Smtp-Source: AK7set+rvQtYHVDRsAQzQcbTQ0F/VLMZ6D1hvMu9D5g5Wr6vWrhHYLOqiQj8pLLUHueAPDkzoC44Bg==
X-Received: by 2002:a05:600c:30d3:b0:3da:db4:6105 with SMTP id h19-20020a05600c30d300b003da0db46105mr6748439wmn.37.1676924178485;
        Mon, 20 Feb 2023 12:16:18 -0800 (PST)
Received: from p183 ([46.53.248.76])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c231200b003e20fa01a86sm1657190wmo.13.2023.02.20.12.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:16:17 -0800 (PST)
Date:   Mon, 20 Feb 2023 23:16:15 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 7/7] selftests/proc: Remove idle time monotonicity
 assertions
Message-ID: <Y/PVD58nzv8gDhFL@p183>
References: <20230220124129.519477-1-frederic@kernel.org>
 <20230220124129.519477-8-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230220124129.519477-8-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 01:41:29PM +0100, Frederic Weisbecker wrote:
> Due to broken iowait task counting design (cf: comments above
> get_cpu_idle_time_us() and nr_iowait()), it is not possible to provide
> the guarantee that /proc/stat or /proc/uptime display monotonic idle
> time values.

Those test uptime _and_ idle time? You aren't sacking uptime, right?

>  delete mode 100644 tools/testing/selftests/proc/proc-uptime-001.c
>  delete mode 100644 tools/testing/selftests/proc/proc-uptime-002.c
