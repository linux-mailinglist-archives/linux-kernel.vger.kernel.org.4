Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D0072CEB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjFLSrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFLSrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:47:49 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC6C189
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:47:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-56d05daf0d5so23575467b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686595667; x=1689187667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxyhqstePeQfYqzLq3Lp9OYUr4bYf695tH9QHUQdHmQ=;
        b=O81aDnr3tRyEiHzVtbMrq8h22172aZZfn4XcltPOoNEqW5pc3TIi4wbi7NlW31vKgb
         nEA3Tn/ISxYUxKggrFsDhypK1rnJZHSl14Ud6vXxovPQVjAr8XYnMUTEoqmH5cIArNrk
         FuDMfsI7ZXHUdsRuupWeDR0OwQTV6b3IYlJZ2yTaqQncIQoS0Af7iuzMgrfMoGsBz1Dd
         kVkiJScel3Hl74T5PT0DGz97UaRpEwtSt64FarcUIsAi9IDHzJhTR3PJNn4pSG0sgVXD
         xvyAd8j8KwNBKbmaNwkLOfTk43VpNTuEZh57lF9F8Oj1Or22eV61MapXq2pkXl8OEPEh
         Tlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686595667; x=1689187667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxyhqstePeQfYqzLq3Lp9OYUr4bYf695tH9QHUQdHmQ=;
        b=G9QNYju2S2tejHqZ6vG3ZYBVLXFAeu3Kk8EKZRl15zjd1VMm/oOy0OjtIYMGYoILCZ
         pqxU2idoHDYrFjwHiU6riuWQPBKrGzyjqnLrpv1T6yPOsmSgfJUxdp2cYd0p7Pe0ISgc
         OQZkT+O1P2fTjy5Sm5ZKASWYodmYNqVeZC/FO7MrIsj3PUhKtP5rTLebcqULDnu50E0z
         gTapHf0xQ0LEs+jutcCgZ2WEYqmhL4VwdKMetALH15URwhewNcV0T8ApWF0jjVoSXOiF
         /T9rvq6E6YbXL72uzzaze4Dj/LuzUBcRgrHIvzPkK3U6hyqjEoPWVWLvLNnzXgwSq7ST
         ozPQ==
X-Gm-Message-State: AC+VfDyw+v4Mr1FAaGslOJ5WS5afZjrO1Y1BiIeiBbv64aBaG2JYsJwE
        OxoAklY9xeDW2XDzxUqwPhn07g==
X-Google-Smtp-Source: ACHHUZ5oxeJJILFEWlLmpgSf5tV7m9tDDXdClQ+/v7tSgiw6o3zbxm8PZJKbaGMnBokIIit4ZQoDcQ==
X-Received: by 2002:a81:6ec5:0:b0:55d:a9d7:521e with SMTP id j188-20020a816ec5000000b0055da9d7521emr10386835ywc.18.1686595667030;
        Mon, 12 Jun 2023 11:47:47 -0700 (PDT)
Received: from localhost ([2601:58a:8200:2b0::e699])
        by smtp.gmail.com with ESMTPSA id t202-20020a8183d3000000b005619cfb1b88sm2708807ywf.52.2023.06.12.11.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:47:46 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:47:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 7/7] mm: zswap: remove zswap_header
Message-ID: <ZIdoUesPevg5ys4a@cmpxchg.org>
References: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
 <20230612093815.133504-8-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093815.133504-8-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:38:15AM +0200, Domenico Cerasuolo wrote:
> Previously, zswap_header served the purpose of storing the swpentry
> within zpool pages. This allowed zpool implementations to pass relevant
> information to the writeback function. However, with the current
> implementation, writeback is directly handled within zswap.
> Consequently, there is no longer a necessity for zswap_header, as the
> swp_entry_t can be stored directly in zswap_entry.
> 
> Tested-by: Yosry Ahmed <yosryahmed@google.com>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Very cool.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
