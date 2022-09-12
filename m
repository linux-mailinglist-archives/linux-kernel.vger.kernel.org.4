Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADDF5B57CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiILKFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiILKFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:05:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530631CFD3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:05:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so7681635pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wA+G1rTGQqTYcb1OJ8bJnhg5ULF8AN+cZNRHEqhhtc0=;
        b=Ys1cLfVc+bcTfWM4x+7FFPxbO53/oc5Q137yVhVX6Kp76sOg3QoJZUeGNC+YoBko6y
         8wyh4ivOgFhWEim/YVhn9/Zkc8Ofz7r0NoHvfHM1n134T0fVkSryNqlc1RMv6Yq0/IDl
         M37jI/RzCW9PIeWhErr77+I5ZvQLqRlSGzd1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wA+G1rTGQqTYcb1OJ8bJnhg5ULF8AN+cZNRHEqhhtc0=;
        b=di22QCF1+Lu6u8ezYFozccCANuV/WPvnneJBA6SmmBNeC1Gv8tTVUmhiBFHbPjg+Uw
         tBM9bOiBwtRCfPYlhZHCOYnTW8TQBHL+s3aou8t1dbzdwuZPcBOU8DZVyCtdNxJVsXwc
         +PtxhCKm6FHM09h1LZHHKybbsHImZjHwODO7crZ8omzldvXK5lRkx5gX6IB025gD1iPj
         Maht1+M46aKHUw8e5dlCAw8jyTiOLCfVtYlV+xjfzNakhBTDXEREZeqKEjmC9wzegaGs
         CUFYbQMGrR+eHf6l6jMXRBqc2c4y+osdu8F1wC4Z4VQ8oYcptrh6+zh0TeyC6qYKPyOV
         DAXw==
X-Gm-Message-State: ACgBeo0i1fniHx4TC0+DR9eQBetDDvW8+5R0RL505HvQpGw8TjqzGNgC
        iFIp0ZNW5QrI5aEk9XDTM2O6nw==
X-Google-Smtp-Source: AA6agR4o+ywEOFCjegIHMhQuf4jPIoJG6xexxviUFVMTcXJ8B9+SHhDcSVNWGfbNzBpjpLQR9xhxJw==
X-Received: by 2002:a17:90b:3807:b0:1f4:ecf7:5987 with SMTP id mq7-20020a17090b380700b001f4ecf75987mr22399681pjb.13.1662977138419;
        Mon, 12 Sep 2022 03:05:38 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:7b09:9fce:b16b:c111])
        by smtp.gmail.com with ESMTPSA id lr16-20020a17090b4b9000b002000dabc356sm4755447pjb.45.2022.09.12.03.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 03:05:37 -0700 (PDT)
Date:   Mon, 12 Sep 2022 19:05:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH RFC 4/7] zram: Introduce recompress sysfs knob
Message-ID: <Yx8EbYy2QP1BgS6O@google.com>
References: <20220905082323.2742399-1-senozhatsky@chromium.org>
 <20220905082323.2742399-5-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905082323.2742399-5-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/05 17:23), Sergey Senozhatsky wrote:
[..]
> +	/*
> +	 * Either a compression error or we failed to compressed the object
> +	 * in a way that will save us memory. Mark object as "recompressed"
> +	 * if it's huge, so that we don't try to recompress it again. Ideally
> +	 * we want to set some bit for all such objects, but we for now do so
> +	 * only for huge ones (we are out of bits in flags on 32-bit systems).
> +	 */

This limitation goes away once we move ZRAM_FLAG_SHIFT to
more reasonable value. I can introduce one more pageflag
that will be set for objects that cannot be compressed by
either compression algorithm.
