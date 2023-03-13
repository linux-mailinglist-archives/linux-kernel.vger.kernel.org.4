Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6D6B6E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 05:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCME0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 00:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCME0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 00:26:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925842A6C9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:26:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so2904790pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678681610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZHWeMo3uo490fL7bQ85wx0a2LnkR/8UzG/czZchrf8=;
        b=jf854F55Vcq7F3Ut9aXZ26+FT4AeDCHj0bX8sCxH5zNW+qvSFvsSBGyJ4JA8Pkd7AJ
         sKpIdflPJomeeVa5j574TP7GMnt5LJBTtQaZC6ZqZSlIZMq0R1jfnSJ1QsEAU6qUqykk
         Yomo+GoWszjl0CWdDAoO96fsojhNqQg9MMRrO3U0uI4SB9tdS6Fmwr+BKlyVHQjgGPjP
         lmUDweFuGcWul7UTPlyP1Ve5lxLxR5OhwcUoMCXDQ8uSQGisjsuoHl/yf2J0TWjPWt3c
         uWM0ZPv8hjy20fNpr2Ve0LeDF9uAM9yQ/ZxS8H3a9c76iOnr1yMeUYyahIAIyvUPSKrg
         HAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678681610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZHWeMo3uo490fL7bQ85wx0a2LnkR/8UzG/czZchrf8=;
        b=uDzGntgKhBPe0fKzOjsXkO6yK/2ys3UeHM4Ep/kA+q18oSfk4KNZ2NApN3MDG5Fmtj
         SKi2xosr+ye3b67AX9w9mish8//xgfhqCsSspdKz3+Ml+EAkItxOUYGsr3SFBK5qqo1d
         TUB4k915izOTi24czhxF1GEtsNUm6eE0SnVqDbVa4gOZsoFjJftWV4VQxCu8UzBVGTBh
         Qk4nWBF526etdMF5xPLiYI4gp8u+qYe6fA6rj6QBWuLW63Y1FpEguTH7CIAIB3zOJ9nO
         NE093BPNvJZE6i7NxFzRS84QL0fYOBO829pUD948lNdu78Q6eHCieiGns6zUKWidAYCr
         67IQ==
X-Gm-Message-State: AO0yUKVam5Ul3M1iIPxnoV759CVjzFm8nRWP8LO8Ncodj20E/j3nq986
        YZ03EDa4+TyNxGDwTmTRPRMBToHmhUBfsWu0p7M=
X-Google-Smtp-Source: AK7set/+pMK+r6zFCsdx7eazA7/dKXtZtSLa46F10nMT940SC7ngN1rfMa60EgFH/xH708++tgZ7pw==
X-Received: by 2002:a17:903:246:b0:19f:31c5:1848 with SMTP id j6-20020a170903024600b0019f31c51848mr6116232plh.27.1678681610031;
        Sun, 12 Mar 2023 21:26:50 -0700 (PDT)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902868c00b001964c8164aasm3594614plo.129.2023.03.12.21.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 21:26:49 -0700 (PDT)
Date:   Mon, 13 Mar 2023 09:56:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pmac32: Use of_property_read_bool() for boolean
 properties
Message-ID: <20230313042647.gkth7prhopaa7nnq@vireshk-i7>
References: <20230310144703.1541819-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144703.1541819-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-03-23, 08:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/cpufreq/pmac32-cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
