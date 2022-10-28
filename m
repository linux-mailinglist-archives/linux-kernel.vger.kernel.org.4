Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968EF6115B7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJ1PTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiJ1PS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:18:57 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC06821827
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:18:55 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id i12so4272682qvs.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwOzV2q2gswd0J8/E9zZ/Pe+D1iExvQAsMOLRmOBDhM=;
        b=2aracjlQ9pAx4AjpKSSWB6a7/BcmnIszcNlW2iJJyRZOreEjkYFMrdN28VoRqMRomv
         1AJd0nVrpgdaNwfOo2xUigg1fhf2JTme3muHqlvs2Ql6Brt9ynxjCBTWaBNycuSgjtgf
         yz6jaW3o0LGXdAxt5smSe8A1yYIwqYrEjguvdwnDeIErEMQeaAZx+Op+nXk4vZtmVJAD
         9oGIFrPf4cD+peHoIqHAeQDN/8AMTM84VolEo7HwhalBhGdn9IXosp7IGieWpnbPGgeV
         MT9N2Qonsux40iwtBbXog8V+j21nnrBXyDbiusoX+4FsCV8a/5Pz/ceYTzbytYFzOUaq
         5K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwOzV2q2gswd0J8/E9zZ/Pe+D1iExvQAsMOLRmOBDhM=;
        b=2alg9WNP9nGfBe//X93eqbi+qk24gXsjOLPTWbUmgxNXk47RfCifZq4Q1tjR+IebrJ
         vWUJuNANf/MjyuJroQiNEf2b0gFt+abTPGk0Q3trBXrUMPUFof4caPWIvv+HBdn3zL3P
         1WcTYzUD32DY/WLM1t8sUPE6sZP6Ebau/z7LCOtXyp/DpqA/bGCx4W+Mh3QAHvF0cLOO
         f1hC0dckGS5yPqAiiSwCIgzWbJLpi53UOBt8vzgNcszguMReAeK6dWF9OOV/DATLy3SV
         x19sYwYsbetiqkknQdm5t2+x7/8oOSDOZcOyfgbeZZfKRNvhFctSv7GvQGuU/v2obHAv
         mf0A==
X-Gm-Message-State: ACrzQf3HGqm3wI7Enf8F8YDRwu0bswHHXh2JhNe/cAqrrGzo1d07Ct1B
        GLvhst8O0zh3ZhCtybAtalNCRg==
X-Google-Smtp-Source: AMsMyM4xR7bYLx8Vw62ow+SU54+zaofsnx2x0ghY+Rd87nETHNB4WM8AeqetSnCa89xWMfEd8gKnJw==
X-Received: by 2002:a05:6214:226b:b0:4bb:6500:8f44 with SMTP id gs11-20020a056214226b00b004bb65008f44mr26151296qvb.109.1666970335104;
        Fri, 28 Oct 2022 08:18:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id k2-20020a37ba02000000b006bb83c2be40sm3052174qkf.59.2022.10.28.08.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:18:54 -0700 (PDT)
Date:   Fri, 28 Oct 2022 11:18:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH 4/5] zsmalloc: Add ops fields to zs_pool to store evict
 handlers
Message-ID: <Y1vy349XUe3P8WUu@cmpxchg.org>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-5-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026200613.1031261-5-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 01:06:12PM -0700, Nhat Pham wrote:
> This adds fields to zs_pool to store evict handlers for writeback,
> analogous to the zbud allocator.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> ---
>  mm/zsmalloc.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)

Sort of tangential, but this patch highlights the boiler plate that is
involved in supporting multiple allocator backends.

We evaluated zswap with a variety of workloads, and found zbud and
z3fold simply not dense enough for the compression ratios we would get
at the higher end. They also seem more limited at lower compression
rates due to the space they require for the in-line metadata. With
writeback support, zsmalloc finally appears to be a superset of the
others. I believe Google in their DCs is using zsmalloc exclusively,
too. Android is using zram, which only supports zsmalloc.

Given their impact on the codebase wrt maintenance and hackability, it
begs the question zbud and z3fold are worth keeping around.

Seth, Dan, are you aware of usecases where zsmalloc would be a no go?
