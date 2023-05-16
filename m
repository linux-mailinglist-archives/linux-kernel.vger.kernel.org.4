Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3963F7055D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjEPSS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjEPSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:18:55 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194E2735
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:18:52 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-52c30fa5271so7830811a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684261132; x=1686853132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq51/Winy9tdcJdkE3nX1hb1YAR26qiq1QbsKMiUQjw=;
        b=AuNGp7s324pQNR2JPDgYdg7zfF+tEhSJf0t28tdXYYYMmv/8pBaVhUHtuA+q1FrMW3
         GMEecbPpxUfA178sTXMsn1KyAXESzSdPtK8bOSNFMllkT+3myhspkehizpQ7//V4/VoP
         F+ZU5Of6qzXcmAeTdYreTpyPTLR67UyOHb9x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261132; x=1686853132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq51/Winy9tdcJdkE3nX1hb1YAR26qiq1QbsKMiUQjw=;
        b=Go909UVQZ8Upab7P5dLwachVZau2cQq5a32oH04XBCWmg3dTSHLjDvm0KIsAwH9fUT
         HvPu1ecw8IqqGX2mb3D4zEi/7Ql6AkwYvfbZPTWpzxpVFTr1Ujdt4TPfo80coVlD28ZU
         BN6tVr7yilzH3OUeh6vCIlIra2VUfHllSfQd/syz3EU99Hl0AbvekupLijUYjhLjuP9b
         xeQ5Akidta44vm3U4i0M2c1M/gqWAPuzUfouvUh6n6L8JouLs8fVFcDLlumX8cb697xB
         WhvJVU0NN4sjy9WGlcKLu4E4w0E4VwPPTUj70YS0ZxrhayFWKkRypqvbvgs7ydwm7+8+
         DGvg==
X-Gm-Message-State: AC+VfDyn7SRfHJhFcB95x7sJu+tWFj3G8Wr9ML0JOQN9rxd/F8VUARip
        2TMmCTky6fPQg5hPv2sbRGlQTA==
X-Google-Smtp-Source: ACHHUZ7zQa6U94ltPkX3/irOR0s/5miFSFka1PrbPo9jaHvLLlTA+6024nF3xbiAQB4c1NJ6cN+qqQ==
X-Received: by 2002:a05:6a20:914f:b0:106:ff3c:be9b with SMTP id x15-20020a056a20914f00b00106ff3cbe9bmr3263460pzc.7.1684261132182;
        Tue, 16 May 2023 11:18:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z24-20020a63e558000000b0050a0227a4bcsm13895907pgj.57.2023.05.16.11.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:18:51 -0700 (PDT)
Date:   Tue, 16 May 2023 11:18:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, mlxsw@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] mlxfw: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202305161118.86AD596@keescook>
References: <ZGKGiBxP0zHo6XSK@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKGiBxP0zHo6XSK@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 01:22:48PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations alone in structs with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members alone in structs.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/285
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
