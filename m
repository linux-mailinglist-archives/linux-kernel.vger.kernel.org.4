Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36E46F0B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244102AbjD0RsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbjD0Rr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:47:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7584ED2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:47:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24736790966so7378143a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682617650; x=1685209650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AowLft9EBX5gUxctKSIUsNiudl4F28FeVro2d7oaOEM=;
        b=K4EdX966gif7u1ukpy0llJYHxfFkYWdfFwMYcKVy6usRHt/PkkR2YDimen8qEqOwE8
         fGzRXODQ5CUo/tjE5+XIHaBeRBSqAYhjo9uObcaIaNjCodLXxRbWT9aG3cBAoPuBk5OL
         mNdKOFueqrBJqJbPEXDVDz55E7hKGLTusoanE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682617650; x=1685209650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AowLft9EBX5gUxctKSIUsNiudl4F28FeVro2d7oaOEM=;
        b=cvE4HYy4+yW1+JjBRCjnKv9ilW711Sn9I5ZAoJKpRML1+lTbRfa/6xvNqzVB3q+A8m
         V3xZOXs+ZOcwXXCFHiuAWobbQz+r/trxa8YxzkBX4VY8bLae96MGiAeVFGyr/iScTD81
         E3qSRsD6MKafuOpvWCdwheJ5FcWpQ8LPGi2/I4h9NLy8xex5SQg1UPVXnDK1Qqy+JZvv
         12bYv6elvvmkP5K0rTdcyzGj7G0cWpbEwSKtNL7JxNXxPeyAylt6TI5iG2bo2sd5RETP
         rhQkdYhorx2nZURgFuO8lxflIxB1DapRG3c/x1brLn25NHI+0nPa8jWKO7bksc6fg9TB
         8imQ==
X-Gm-Message-State: AC+VfDxl/49FYmG/mJa+51QIDDtA9073DEm9C3/b87t0iE7NGfC9xdPt
        XgS40CgyoTYYDocAUHZ2YoNZGQ==
X-Google-Smtp-Source: ACHHUZ7oDO17oEmp71hXDgibg5WFVW2Jl6Z+LeyB/FPq2+qXtjm2demldilHFox1tX28JgToNRGZYA==
X-Received: by 2002:a17:90b:3e82:b0:246:c223:14ab with SMTP id rj2-20020a17090b3e8200b00246c22314abmr2645491pjb.41.1682617650051;
        Thu, 27 Apr 2023 10:47:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:17bc:8fd4:f9e:3e41])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0023d0290afbdsm13597610pjb.4.2023.04.27.10.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:47:29 -0700 (PDT)
Date:   Thu, 27 Apr 2023 10:47:27 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] wifi: mwifiex: Use list_count_nodes()
Message-ID: <ZEq1L4LAXvY6yXbw@google.com>
References: <e77ed7f719787cb8836a93b6a6972f4147e40bc6.1682537509.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e77ed7f719787cb8836a93b6a6972f4147e40bc6.1682537509.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 09:32:36PM +0200, Christophe JAILLET wrote:
> mwifiex_wmm_list_len() is the same as list_count_nodes(), so use the latter
> instead of hand writing it.
> 
> Turn 'ba_stream_num' and 'ba_stream_max' in size_t to keep the same type
> as what is returned by list_count_nodes().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/wireless/marvell/mwifiex/11n.h |  4 ++--
>  drivers/net/wireless/marvell/mwifiex/wmm.h | 15 ---------------
>  2 files changed, 2 insertions(+), 17 deletions(-)

FWIW:

Reviewed-by: Brian Norris <briannorris@chromium.org>
