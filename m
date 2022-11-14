Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C26277DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiKNIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiKNIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:37:50 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0181BE87
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:37:49 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k7so9432561pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=82vXPJwHd8IviU31bXsxdXjyP52czxzjDA7v+DaUSmg=;
        b=jCx5gmGPI0Vp6C3g0MGiimRIwIfmUwI0uYSizF6FBiZfAvKXHoJV2aUVfyC9R+Bazr
         vKxMUD4WMArBQye+lOxpi+HPi+VikbQlIF44VJzJ9CTK0okCj/i4GhEJdANBtKWvvgiW
         6qjP4mUe2uQfvpaO6BlLrgtSYlueMGtog7cPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82vXPJwHd8IviU31bXsxdXjyP52czxzjDA7v+DaUSmg=;
        b=gl3mgYsAx94Zt8n/BLvD42lCDYfGv/JlPx+GvJVs3OgymX7kiPBUQFR/p505xdbGeA
         4v1IDBnx9ELONupvTmoMM8ECpE8REO4UDm2K6pwF8nttJ9obMS/r8Lb3uX6HZhd4xLzd
         djDEdSOJsjhd7GPxhBYDfNjqxSPLECbV1vqKGBMKghH89ppVEulQkvw/csaU4uN/b0DB
         WVZJSyJbMjZUpVy843Vp6S+o7SvelHN1XYDz4/jC4ngsR8urjDgvbvEb6b6XjuWUH2Ub
         gF/9xMDpGPgx9lYc91QYwm85BY/Mktc/T5kZqUvucOpYB+RbseGV11PUMEv/yo5eoTXm
         xDaQ==
X-Gm-Message-State: ANoB5pm7lJoTvWsnOkkcgzMKMNo3JkWGBi++elQFk0117mlRLebK/vyL
        DkJju0Yp/pOopbHFetuU15bTvQ==
X-Google-Smtp-Source: AA0mqf66wBNnymE8ORCnamKzCASzkbTJfPvO0J/lrYDn/VJwJMhjUPgTArRD31piDE0IAsWGK4t29w==
X-Received: by 2002:a17:90a:5e09:b0:212:d299:4758 with SMTP id w9-20020a17090a5e0900b00212d2994758mr12697230pjf.120.1668415069162;
        Mon, 14 Nov 2022 00:37:49 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:68f5:86c0:dcaa:df5])
        by smtp.gmail.com with ESMTPSA id 131-20020a621989000000b0056bc1d7816dsm6254460pfz.99.2022.11.14.00.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 00:37:48 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:37:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zsmalloc/zram: configurable zspage size
Message-ID: <Y3H+WGCH4Xgh21PD@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <Y21+xp52OQYi/qjQ@google.com>
 <Y22dxEcs2g5mjuQ7@google.com>
 <Y26AbHxhPBJdWZQE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y26AbHxhPBJdWZQE@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/11 09:03), Minchan Kim wrote:
[..]
> for class in classes:
>     wasted_bytes += class->pages_per_zspage * PAGE_SIZE - an object size
> 
> with *aggressive zpage compaction*. Now, we are relying on shrinker
> (it might be already enough) to trigger but we could change the policy 
> wasted memory in the class size crossed a threshold

That threshold can be another tunable in zramX/allocator_tunables sysfs
knob and struct zs_tunables.

But overall it sounds like a bigger project for some time next year.
We already have zs_compact() sysfs knob, so user-space can invoke it
as often as it wants to (not aware if anyone does btw), maybe new
compaction should be something slightly different. I don't have any
ideas yet. One way or the other it still can use the same sysfs knob :)
