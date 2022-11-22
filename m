Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B76633D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiKVN0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiKVN0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:26:43 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712F364A24
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:26:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so8332181pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qP1ro1Xp4KmRIYWh++cut3pCh3rHsw4qLAPVjrGPG0A=;
        b=dv5Q8Hd0KbiTdNFTbG/s9Q1Pk5TVxpzMSp+i6d+ToHSwKLREjLtiJdOKFtCtS9nbdJ
         gjRh1lmC6Gblwqc2s9zYO/o371Xb9+StZLLOvJffUArp9HOMqVlYlpVs7rTgWe24cyOF
         VLRMfSSRFLeCRlmszXHQWTaLbyoLXj6D9gXS9X2DBQxfdacFAfDbdzhUi9WliV8lvA/G
         +HjvrsfR3rHp1yYv2P0FNMv7YzTd5ymASZ++RBGLto8IqtfREujRvAv3Sft8sjPgAMoa
         7jdJBL0R4UYb3uXrsfGONy+UUbGPFODttbhEdO2ELKV+lg7YGBfE6tKpusfkLod7ydA1
         ZeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qP1ro1Xp4KmRIYWh++cut3pCh3rHsw4qLAPVjrGPG0A=;
        b=Dw6s7OuKjdD7anzt2f4L2d1JH9zuJl4E2UnPAWg3JPryeCWiQ9fjEy9V+GF6X+KvX8
         Up1QzL7hj3y0ru2NlzWErv1NXoM5nxBuKW+U21jXV7UdGsLg1c+6Uu7RgcqG4ixEYYYy
         q70tg4+uO68CfgepIDickSLoeWKL6aS8PDTK7okPxJYQxhNQYrHgpBsTnHWbT3cdiLh4
         Jw2Y5bzwaq7ZIYkb3yDojeXGhb+pIXbVtJJ5B+shVY3m2r/kj9vJ/P+L+xqdoZSYP/RO
         hpDzgxTKB87zOgk+jIRUsmUjC9RoWQ9UH4zmIwgOPhXf0eHJQnCL9AFEhPq0mlnKtoKH
         /s1g==
X-Gm-Message-State: ANoB5pl8JhE6OOplwHTQv0ZFwp0hCKeH5vG3VwY+5mUgmFlS3PWK7mAP
        rIYO3avy7167TNctlN4Dt5fo
X-Google-Smtp-Source: AA0mqf6OxytBkKW5vneFasf2lAqfg9u2xGOOekCmuUuFkrB9iZqEIQD6SB5fsFw2eYAcHp0ne1v3+A==
X-Received: by 2002:a17:90a:398f:b0:213:5a55:7dd2 with SMTP id z15-20020a17090a398f00b002135a557dd2mr26174391pjb.50.1669123601870;
        Tue, 22 Nov 2022 05:26:41 -0800 (PST)
Received: from thinkpad ([59.92.98.84])
        by smtp.gmail.com with ESMTPSA id t22-20020a63dd16000000b0047791c6cc10sm1856757pgg.93.2022.11.22.05.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:26:40 -0800 (PST)
Date:   Tue, 22 Nov 2022 18:56:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20221122132633.GB157542@thinkpad>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073817.7ollj7jeixrx5og5@vireshk-i7>
 <Y3sryFh84eK/sWKF@hovoldconsulting.com>
 <20221121083036.ppwfprrheuf7xl7c@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121083036.ppwfprrheuf7xl7c@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 02:00:36PM +0530, Viresh Kumar wrote:
> On 21-11-22, 08:42, Johan Hovold wrote:
> > Ok, I was expected the devicetree update to through Bjorn's tree as I
> > imagine there may be conflicts otherwise.
> 
> Dropped the DT patch now.
> 
> Mani, I believe the first patch in this series is still required.
> Without that, when the cpufreq driver calls dev_pm_opp_set_opp(), the
> OPP core may end up calling clk_set_rate(), which shouldn't be done in
> case of Qcom SoCs.
> 

If there is no .set_rate() callback implemented by the clock provider, it won't
hurt, right?

Thanks,
Mani

> I am not sure though, how it will work with sc8280xp. Can you please
> check ?
> 
> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
