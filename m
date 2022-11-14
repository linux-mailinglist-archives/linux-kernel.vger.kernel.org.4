Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2016289D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiKNTum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbiKNTud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:50:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D7C12AD9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:50:31 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w23so4618170ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aeYV7fDkLER/6GDtsBmzPKt14c7SuI0JOECUHSx1zDk=;
        b=M6HioAcUd9+V0vOi9nn77C1cQZ+yuMKdHtjqJasI7QmXmRQ8uC2szUrUKvbkrkfQr9
         4Y01GrpR1X1HpMQeAno85q+LMFPlBpy6CbJ4mJrczv4D8jcWmb7B4FYnW4U4wD6xhLRd
         oMUhqGXDvYMiUHdDfFYDBNuQTJx6SdYI15EvAZJrOxtgHmgIh6bEmpzFaxmWjrS/65kP
         VnZMWisqdZKYYNEIp9jiwDd+bS/VZai+OND0GNCNv9jUjdlk8XBykGKEVduXG/7cHPC7
         BeUx8JDRSXzQyD4qtIZ6lHNvcrDUJX36jiqrLZXlzGPWbyLVA3AMhGmXYo3qFm3p6/oq
         mcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeYV7fDkLER/6GDtsBmzPKt14c7SuI0JOECUHSx1zDk=;
        b=QTKG6M64CxR1EXebemAB8WSeGTIOxB8adfLdgkmfnxfiUC/sSFHTSyy3Ags9PL8urw
         wklQN89GKDOi3mBVBhIqg999DsMOr1U2pAd+UPPJvevQqA15oSrGE2ZK+5BO5SrvojxC
         wLi4jYk71PHEPsh7WKzgEXCF8V7lg2vUUwZ3LhHhtVaPVOd9dENDp2OR+Lqc5i9Piham
         Ay2AaTtK3kbDNCUHD0SEmnhLUieerExMGN7KlI8dsVwMfg4kEnzsyBjCunCtyGXTYwtm
         mIhkmejFe9NpA5mqFrbeoDobOR389RG1phi0C/NN//7N0LQU26zvqY0SZRHTaPw4uG0o
         GpCg==
X-Gm-Message-State: ANoB5pmBSCQJM4aZK/AvdwSW1dyHFgdzUk90s7zDjCHRScDmiCqAq0Yu
        xEv8Sx56uCkxFIwwRk45D4jJuE0QC0REwg22RYnoNA==
X-Google-Smtp-Source: AA0mqf4hSdec3Om+IZl6dvO0bLDNDJnaPYiFm4//JZu9ysk7gnawgAc89XgfoUMHBNTwplgX6FIngd8yPW9ZeuPeYFQ=
X-Received: by 2002:a17:902:a584:b0:186:be05:798e with SMTP id
 az4-20020a170902a58400b00186be05798emr790394plb.37.1668455430845; Mon, 14 Nov
 2022 11:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20221024043925.25379-1-marcan@marcan.st> <20221024043925.25379-5-marcan@marcan.st>
 <CAPDyKFqYr5NDhZNT=EHWzWq=eCZKbF8Z3Y0eRHY8-nY7Ej0PBw@mail.gmail.com> <c791b776-c90f-4ee5-b025-79352937bf62@marcan.st>
In-Reply-To: <c791b776-c90f-4ee5-b025-79352937bf62@marcan.st>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Nov 2022 20:49:54 +0100
Message-ID: <CAPDyKFpnzmRkgRHsRoRRSpzFGPT7oMx0u+d1g5Rmu_mCA_nC2A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] cpufreq: apple-soc: Add new driver to control
 Apple SoC CPU P-states
To:     Hector Martin <marcan@marcan.st>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 at 19:17, Hector Martin <marcan@marcan.st> wrote:
>
> On 02/11/2022 00.16, Ulf Hansson wrote:
> > On Mon, 24 Oct 2022 at 06:40, Hector Martin <marcan@marcan.st> wrote:
> >>
> >> This driver implements CPU frequency scaling for Apple Silicon SoCs,
> >> including M1 (t8103), M1 Max/Pro/Ultra (t600x), and M2 (t8112).
> >>
> >> Each CPU cluster has its own register set, and frequency management is
> >> fully automated by the hardware; the driver only has to write one
> >> register. There is boost frequency support, but the hardware will only
> >> allow their use if only a subset of cores in a cluster are in
> >> non-deep-idle. Since we don't support deep idle yet, these frequencies
> >> are not achievable, but the driver supports them. They will remain
> >> disabled in the device tree until deep idle is implemented, to avoid
> >> confusing users.
> >
> > Out of curiosity, may I ask if this implies the need of a
> > synchronization mechanism on the Linux side? Or is the boost frequency
> > dynamically managed solely by HW/FW?
>
> It's managed by hardware - Linux gets to request whatever frequency it
> wants, and the hardware will limit it to what is achievable given the
> current idle states within the cluster (and it will change automatically
> with them). So if Linux asks for 3.2 GHz but there are no deep idle
> cores in the cluster, you get 3.0. If there's one deep idle core, you
> get 3.1 (I think). Three, 3.2. So this driver doesn't have to do
> anything (and will report the correct current-frequency as long as the
> per-SoC compatible is matched; without that this feature is disabled and
> it just reports the requested frequency). We could enable the boost
> states today just fine, it's just that they would never actually be
> reached by the hardware.

Thanks for sharing these details. It's always nice to know a bit more
about how the HW works!

From the reviewing point of view, I don't have more to add at this point!

Kind regards
Uffe
