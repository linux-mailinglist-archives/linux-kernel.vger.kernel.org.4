Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C145EB3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiIZWAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiIZWAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:00:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33661AD9B3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:00:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v4so7733117pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vA/6myQNQnJHYk+EUx6DGwR93ze/m7/gJ74a1YFBZ2E=;
        b=U8sJtotxHMan7w/+4cTY25Ek0IfBdX5nCMlrmk+usONkjHNzmc7aD7dc0o8CYs171r
         tQ/XiitLYP4hzQ8L64lYJumQEojtI9TgQluFVjbRZDcyZ4/NDftB8giHUEk0o/af7Yca
         4HFZaiM/0R/tiAmzw0SY5Bbr5mQZqxk6Esb7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vA/6myQNQnJHYk+EUx6DGwR93ze/m7/gJ74a1YFBZ2E=;
        b=zt8WjBKoMBIj6t+6XI1npkebWYkke8rWlQddcdnePy0Rk/Ib1h9Jj2qkUBlECFDisc
         HaxKAa5utpq6I7lorT2j7aiUPJuOXIi4CjXXE0HUd02wroHKZ6cpFxiTJRjc9XROMnqU
         PitwKveueu90bbT3RBTaUzt3WoAAhtKHEEpOkkUaOvTRf6vmnI5SWtqHZo4EhlYFIpzY
         JCruRDoBodRPAQDvS+Rf5fSnZEprtcCDjFb6QXo5sl7/1opY9gGGVd7ESzDrzdHAiZfb
         6tW4FWQv5Y1lKB+9hJ48p9osoAZkzWlI6R6QDDsAB71F1NDxJBmrYJjMImRoUyD8T/Jp
         9BJQ==
X-Gm-Message-State: ACrzQf2htFudikzyHLiQ1pj0aZFbn0Tf2tePCgVoFWvVlTTkdgQ0sz3o
        NC4uuYtNW9hNeZa1myFlvy5aNg==
X-Google-Smtp-Source: AMsMyM5JiIgVIgSTi23Z1w9ajKUhq1aAliulpHYeL13NSOYqKW4HOG61sl4hc17hHP8PREpsKCyqHA==
X-Received: by 2002:a63:fc5b:0:b0:43c:3f90:ca07 with SMTP id r27-20020a63fc5b000000b0043c3f90ca07mr18295865pgk.110.1664229632744;
        Mon, 26 Sep 2022 15:00:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 7-20020a621507000000b0053e80515df8sm12685410pfv.202.2022.09.26.15.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:00:32 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:00:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ath10k: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261500.38CBB07FB0@keescook>
References: <YzIcoloIQBDqGlgc@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIcoloIQBDqGlgc@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:41:54PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/212
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
