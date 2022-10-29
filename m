Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E2F611FB6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 05:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ2DRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 23:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2DRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 23:17:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D592A9AFE0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 20:17:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so8911158pjh.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd4BB28ylqUVziHfqM61lajVeO2UdyApWimbqI2dNa4=;
        b=BGguppnicqHjW8WfEUzt0WRt/BtvsQBZ/hFQYeUQt7L0+j5PxnRag2L+5pR7ldJmYU
         fxSlt+6U+ssbdD6d90ZD3GEEvaArZ9CItsMeiHNkML+W/y/hV8zS7Fu7/Ma2ZBZyGjwF
         fRFvgWG2IXOYzu8hoN0h3BHns4z72AzKnFWX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd4BB28ylqUVziHfqM61lajVeO2UdyApWimbqI2dNa4=;
        b=IldHZBtc8pH0WGlm5nErDLUFpiUouU7xhfirMkGTDyse4KdkR9ysEHfF5MWFA0NtXj
         V7Wg8fqTUDvWi1PUw8OlVMB9IUwvU91H79IJo3d2oNJknYX/sxNJ3RR9qLvR1/MQUa3c
         sNNYjHyCNicCnbo9K+x2HDmrNKsLEEU2HUm63PR4fnz7v0K+p8hWtBJ7V2GKVgYivEvU
         OXErTsmjg+ox2wtVzxGxvXxFfHjhtw7He+p/SSBh9K56wAbSNl9NJ+RkS/COyMZ/2rSS
         zDQLLlIBtPx4SF4qfuhp6qF/PMpLs+1yZzZrX+Dx4G0yOyJi5YxedTaVQ1cOeBvuVjXs
         hyNA==
X-Gm-Message-State: ACrzQf3V9uUumUl54U6rvfG54hftsqobFZ40bmCy/h5E8FTLDapktDla
        fW7pxT6UVoBu/evmoGPBGrx0WQ==
X-Google-Smtp-Source: AMsMyM5me638ftMDuCR+ussBeXMeJ3H30jUxnuNmVqvD/NnEcnVWySgFAFBzkL8kvpWSPHr7p2FbHg==
X-Received: by 2002:a17:90b:3803:b0:213:9911:5efd with SMTP id mq3-20020a17090b380300b0021399115efdmr2546152pjb.94.1667013456327;
        Fri, 28 Oct 2022 20:17:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b00186b55e3cd6sm187649plh.133.2022.10.28.20.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:17:35 -0700 (PDT)
Date:   Fri, 28 Oct 2022 20:17:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] igb: Proactively round up to kmalloc bucket size
Message-ID: <202210282013.82F28AE92@keescook>
References: <20221018092340.never.556-kees@kernel.org>
 <20221018092526.4035344-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018092526.4035344-2-keescook@chromium.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:25:25AM -0700, Kees Cook wrote:
> In preparation for removing the "silently change allocation size"
> users of ksize(), explicitly round up all q_vector allocations so that
> allocations can be correctly compared to ksize().
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hi! Any feedback on this part of the patch pair?

> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 6256855d0f62..7a3a41dc0276 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -1195,7 +1195,7 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
>  		return -ENOMEM;
>  
>  	ring_count = txr_count + rxr_count;
> -	size = struct_size(q_vector, ring, ring_count);
> +	size = kmalloc_size_roundup(struct_size(q_vector, ring, ring_count));
>  
>  	/* allocate q_vector and rings */
>  	q_vector = adapter->q_vector[v_idx];

Thanks! :)

-Kees

-- 
Kees Cook
