Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E339708ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 06:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjESE12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 00:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESE10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 00:27:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B7710C6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 21:27:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso27793285e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684470444; x=1687062444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyFM93RzBlgtSRyLXC0sFHIwfhC6uq3yHL0+V1L9n0I=;
        b=vCKLFmmg/i4kc9lFKQ3UDMrG4viFbiz/AMY7yIqcq9q9mfOgR5thbtJBlN9ra9IQNW
         mF8TozjYgO4YOlI3j01BeF9tS7UnKM6oD2kUUTRu1D7B2sosBcgl1R68qKpWR3qZiB/T
         mqej1IvTji26ZzDXpxCWkkl4h4pJ4EIKdHu8raB0uH3Pk9knNxyWDIz0nLs9IlAKvWpA
         RS/x7Nbsv6xjFsolKeN1oSrglx149c59sMrUaLqsbO6okaHYz3O20Xz3w2aggY0/7sEc
         nc2eeAAt9e77Ts9nog3xVL1++O8eiZrFCRUy3fGteWmXK0cBLpCNkly0P9O3wtSBx93J
         IrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684470444; x=1687062444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyFM93RzBlgtSRyLXC0sFHIwfhC6uq3yHL0+V1L9n0I=;
        b=CB9uwseOc0ENtq5ZruCjxDGlLuO1+E/1JT3mKpq2Z8bVvfEE6Ov27kZlp/ZKHgQJ7t
         aVJNoUxYqleN0r3QzI9MXXEd7BSEYRNyT8vG8dBgMANd607bxCctCHaVPH6aNvHYHtpN
         7qySPgJAAvZ3Ix/XjcLAA9YtQf6+CCJobihi21APkTZpKE9i6t2d3U/7yqlTaty/4W8+
         0XpFkmPXsJfPvLjfheznbnKaodia++RsIa1bZfU/raRUlIIQHbtNDsC+RaqMGpq3d9f9
         ZYAbmM36wxWzeuTseeeAXcxHv2zHccxiBO2VTY3P4KP1nTM4x5Fl/5UW/v7h+VwiBkQI
         WAXQ==
X-Gm-Message-State: AC+VfDzZK/X+4BNK8E75DqCrhQUELtbJwNElicYt996iu3w0B9oe+hls
        wWsBHCW4sXKkjaV9uGlL1dzknQ==
X-Google-Smtp-Source: ACHHUZ6IsK9uRWYPAimlxBjpgAATciYWUW9n3V4nuOe4CsjyR0sMXNVrt8PjeWMtZZPmDM2MylrfEQ==
X-Received: by 2002:a5d:4291:0:b0:309:4fb8:6eeb with SMTP id k17-20020a5d4291000000b003094fb86eebmr522913wrq.5.1684470443702;
        Thu, 18 May 2023 21:27:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m14-20020adffa0e000000b003062ad45243sm4005541wrr.14.2023.05.18.21.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:27:22 -0700 (PDT)
Date:   Fri, 19 May 2023 07:27:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Leeder <nleeder@codeaurora.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: qcom_l2_pmu: Make l2_cache_pmu_probe_cluster()
 more robust
Message-ID: <0898a8ee-1d41-4ad5-8312-a0b417026aea@kili.mountain>
References: <6a0f5bdb6b7b2ed4ef194fc49693e902ad5b95ea.1684397879.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a0f5bdb6b7b2ed4ef194fc49693e902ad5b95ea.1684397879.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:18:08AM +0200, Christophe JAILLET wrote:
> But it looks cleaner and could silence static checker warning.

Thanks Christophe,

Of course, you found found this with your Coccinelle script so
technically it already silences a static checker warning...  But I
ran into two list related use after frees yesterday so I'm definitely
going to create a Smatch warning which will trigger here as well.

I'm NOT going to add a if (if_list_is_devm()) exception because I feel
like that encourages subtle code and because devm_ lifetimes are
complicated.

regards,
dan carpenter

