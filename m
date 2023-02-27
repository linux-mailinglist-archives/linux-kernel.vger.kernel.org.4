Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6B86A3E57
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjB0JaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjB0JaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:30:01 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B517ED8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:29:56 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id i3so6054397plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=orrUFQepqPS8GeN9rfXGjnnQp/FMyS0GGVp2Umis7mI=;
        b=ylnXtXLbC4YroRtValaCEdd6gZwQ3YJY+oB2gPMozZn7oPwb955TfjYBE9zURSS8Cq
         qq/8Tv+vuqPVyJ/MlPTqoS3jjViiuM5zUIY0VOEEbmoWdKRXoenn6pECdvijZTPcy0/F
         IvIzq+exhHeIO8Uml202DAWV7VSb1Ovd0rktQkCjnRA6uhDMjAd8sffqTTme/CZNzkBg
         jIx20wURc6GaBTEoSiUu81pa0lH0Tm9ZnLoi/MCdSwxZRlhcHYlwEi/lI8E6I3ckS2yG
         5kYqrrx39kzBKEgpYFtjFdV5A5bjUdKQlQposmCedhX9B43tPkB2rzBS2mqRXF0mc0zr
         UBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orrUFQepqPS8GeN9rfXGjnnQp/FMyS0GGVp2Umis7mI=;
        b=Y2evS2OVN+6CGL0jkon9iW3nwp40Afv6WMlrqf7TF9NsyGX8qJUMMbbg/3CCWx6lM6
         8NHFu+IA86Os0i+pDQWjvafh4QNNgIXTmV/j5ayc/8Cbz+DOSbjeZbQLxpCHZtLxx2Yx
         QT7cbvKmICwXm4yCQfC1y52mAP0muf/R6PM/vHjN6ocyxiawl/i9AaCIOGjjrgbLHsct
         kbbddfw2XQCOCwsoXq2vstzC55e+z/hDClgRqKv4NpcDxDafBDVPeh8xQZxaI0JjBcB6
         5sFIvvegJEMNLMatkyn+S+wABYC7Gvi29nD2JcDKkSZqoFpWpxz6GsUCEtjVrjUvkhb5
         /a5g==
X-Gm-Message-State: AO0yUKWRhJkDyqfIJTY6E4g8G3Rca6Fq9215GoftY91IrHcybcEbr1ns
        7Qjhtj7ejWAv0TPS83uEYzbJLQ==
X-Google-Smtp-Source: AK7set/zj4mcmcU9rSQGoc5y7aZGnjUK6AnhP3Dl9Qd3GmqCjAR0w1nC3wYbit6WJwoVrxA+3yFMNw==
X-Received: by 2002:a17:902:d488:b0:199:2932:615e with SMTP id c8-20020a170902d48800b001992932615emr29016356plg.18.1677490196173;
        Mon, 27 Feb 2023 01:29:56 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b0019cb8ffd592sm4118341pld.163.2023.02.27.01.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 01:29:55 -0800 (PST)
Date:   Mon, 27 Feb 2023 14:59:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     cw00.choi@samsung.com, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] OPP: Simplify set_required_opp handling
Message-ID: <20230227092953.ekh72r5h6xcqgusn@vireshk-i7>
References: <cover.1677063656.git.viresh.kumar@linaro.org>
 <CABymUCMhoKoFHy8K6-ohrcAbyTpDe0Hig3oUM_wH4Db0-9yx+g@mail.gmail.com>
 <20230224021713.stpcykx2tjkjwyti@vireshk-i7>
 <Y/hyf+/EqEeTu436@niej-dt-7B47>
 <20230227042349.3p2ijo6s6yyqc267@vireshk-i7>
 <CABymUCNBkr_65JHNVfbUGjxs6rhnj=eUyZ+5j6VtiDwqzLYtcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABymUCNBkr_65JHNVfbUGjxs6rhnj=eUyZ+5j6VtiDwqzLYtcA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-02-23, 17:21, Jun Nie wrote:
> Sorry for not expressing it accurately. I should say devfreq devices
> pointers, just
> devfreq_virt_devs vs genpd_virt_devs. Then you know why I add devfreq-devs
> dts nodes below.

Won't something like dev_pm_opp_set_clkname() would be enough here too ? We
already do this kind of work for clks and regulators.

Having power domain specific information within CPU nodes isn't a requirement of
the OPP core, but the general requirement of genpd core instead.

-- 
viresh
