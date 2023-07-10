Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60674CE79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjGJHcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGJHcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:32:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1B4103
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:31:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-314417861b9so4134722f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688974311; x=1691566311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=byJr0xmC46iBq743abJgximnkiOFt20UZMaO06opogY=;
        b=X5fiH7o4AsekI7mkLf4fPTiLgEdyue6pPjKezkmqKfV3CDsrCmYH9m6ICfqZHgHjGg
         tJfneRt+0gzz5bBiAglMGwS8J25IcBbg7RodSTFa2BiPVK0qQbLKNGovfduSxekD3HTB
         yZ9AZKZd5cbF4GdZv/8cQ2mYpW9PPp19BgLcC1Vn6dvAbTRrFdQu4wGKeIK4u5fAj7sV
         il8NXX66xaP7FtVhd/CCOn3GMyH4gzdhfBHtJfuqt7gO+FgnGsaciGOnKm14m6Cb/B5Q
         KhAVeQMMoFvKwpAFoa3+gYDsEp6ZocF20Dh3fXWZoRaxg4NPh+z0NMfR9lV61gyDIDTk
         jl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974311; x=1691566311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byJr0xmC46iBq743abJgximnkiOFt20UZMaO06opogY=;
        b=c2q37NV1fvMQU67Xqby+euHpZJpANaAKLQebnOju+xdkVPYIRVZBX70VGvNPhmfE5+
         6X5UbfXfA/MBFDKJ+/HbZp382wpnuGKo9EGYzk8ck1yAlQgykVpid7z4X9++saG4oqhp
         vGtZIqElrYRzs2LCtEV/Vve4VUyrDpph5pDLJa1U++Bn/oBvzqe0zOeUtKzAJ6s3X6fO
         C46TBiEJtwiNGFfpLzbZFXT8+MIuzjmzCJ/MHaNOaWr38j9H1NBc7x2IbVv7ONwto3en
         FHfTj7nSVKOYiFsKUiEcp0lqGa5SGA1poT5hco/ggbLtjYBOCG48sm65nSoNUVeqY2Px
         +1wA==
X-Gm-Message-State: ABy/qLb54vVEpz4lDrNKsIPNzvC4BWtNISp4dqsO51MSTeImIdg0RDXg
        ydEJUdEIWxYgZXXaDmXZumLZzA==
X-Google-Smtp-Source: APBJJlGIJJG1aP9zcuRcTkdGAGVFewfD/2w036VUMfXBREZDOxc7KHHwsQ2h+DL5uPflOXk9HHB8lA==
X-Received: by 2002:a5d:6b0b:0:b0:313:e5f2:7cbf with SMTP id v11-20020a5d6b0b000000b00313e5f27cbfmr10307005wrw.58.1688974311144;
        Mon, 10 Jul 2023 00:31:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y5-20020a5d6205000000b003145521f4e5sm9813695wru.116.2023.07.10.00.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 00:31:49 -0700 (PDT)
Date:   Mon, 10 Jul 2023 10:31:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     irusskikh@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, yunchuan@nfschina.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/10] net: atlantic: Remove unnecessary
 (void*) conversions
Message-ID: <494050a5-4bed-44d0-90d0-e76726168791@kadam.mountain>
References: <20230710063952.173055-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710063952.173055-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:39:52PM +0800, Su Hui wrote:
>  static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
>  {
> -	struct hw_atl2_priv *priv = (struct hw_atl2_priv *)self->priv;
>  	u8 *prio_tc_map = self->aq_nic_cfg->prio_tc_map;
> +	struct hw_atl2_priv *priv = self->priv;
>  	u16 action;
>  	u8 index;
>  	int i;

In this case moving the variable is fine because it's related to
removing the cast.  But in the other case it was moving other
decalarations so it wasn't related.

regards,
dan carpenter

