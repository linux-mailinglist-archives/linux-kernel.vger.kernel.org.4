Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEE163B239
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiK1T1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiK1T1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:27:05 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200752C109
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:27:05 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id i9so8088097qkl.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+SmLsoc27xFag5ARuHfj6TypVjVskdQ5vSn+k51kG8=;
        b=pkoosKQDtkrFVY44Ag/pr/Uu4XnaBe/IOdq+PQRSUStQ2z1/RcWzOd43d9G8IIpOK+
         cBRGVyxbNDunIRwfhqmV72rp4Pd0ERjnFzA7PxzWExI0ylUQHkGXUddlM6MX9ExvmMSY
         UQfP0RPc0AXC7+AkH/pOkUj30KVG2ONGNf8rk5eoOuwA007JcgS3E1cjNO+YSnpeR9G5
         js8/JDMzhuBfpEfpNWJS/JdGTxjZNphTiZm+H3v5W90IOlsSZ77BeTcAqQkqxOGntfhx
         HCO4Oa+XUOrToJTd+mZ/S3s9yMXPQnYiCkhh26Qt0VzBxF0w5il8/s+BHY7VtZDkH5UY
         JJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+SmLsoc27xFag5ARuHfj6TypVjVskdQ5vSn+k51kG8=;
        b=hfR6iydzq35ABUT3sVkuZu8KzrbF1Vu4xaROzVYAhe98YbCm1feebfSlV50lMIomX/
         sDRXUqCJH+jnQT81GW4T5Xc/a2TJ5DFRicDm90AUE8iIX8VGQVPS/d/EEjupG/gdr1RW
         Beg1vGx4NMR8do4RerzxF4CGmfROcbH+pg7DHuB6HUq1W+elvvUMViP0TJok2dcuvsxE
         eQDWHUG3fuN4aEaxDvPzvS8eVWnqydsoanwASJA+zpcMcHn6T8NDdH8FF25tXubpJKXY
         OHpk/JbQTcmam8xLJffkqnhVNlM78t69r0GpJKimOQeW2A3xvBqJaO2QsUycIt1i3Cy0
         nMTQ==
X-Gm-Message-State: ANoB5pmtQH3QoHJLQIT/eryQbQL9jD7t5uJqJI6XddXas4ULcNe2Lojp
        oZW3PLLBT9mlUDeirNZR4myXeE3RWOOXcQ==
X-Google-Smtp-Source: AA0mqf4E4aamrsyrnY8O8FXBEVrpesw6NTYsRgYyKiW2KMpp0Y/42B38gnzLNqJd5Fo7vpSssukwKA==
X-Received: by 2002:a37:583:0:b0:6ec:76df:83d1 with SMTP id 125-20020a370583000000b006ec76df83d1mr47454459qkf.749.1669663624238;
        Mon, 28 Nov 2022 11:27:04 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id cc16-20020a05622a411000b003a5416da03csm7355426qtb.96.2022.11.28.11.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:27:03 -0800 (PST)
Date:   Mon, 28 Nov 2022 14:27:03 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v7 5/6] zsmalloc: Add zpool_ops field to zs_pool to store
 evict handlers
Message-ID: <Y4ULh1Jh85StwTNy@cmpxchg.org>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
 <20221128191616.1261026-6-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128191616.1261026-6-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:16:14AM -0800, Nhat Pham wrote:
> This adds a new field to zs_pool to store evict handlers for writeback,
> analogous to the zbud allocator.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Minchan Kim <minchan@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Sergey was happy with this too:
https://lore.kernel.org/linux-mm/Y3wh0i5r+9Gk2Okf@google.com/
