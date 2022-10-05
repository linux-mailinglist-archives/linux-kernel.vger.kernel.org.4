Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081C05F5CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJEWYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJEWYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:24:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439B23FD50;
        Wed,  5 Oct 2022 15:24:00 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d196so3449729iof.11;
        Wed, 05 Oct 2022 15:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PBQAdfl2FcAetVP79a7BmHKTI8rOne6a7XU+buA6PoY=;
        b=EfQPNvrc7V4w8OaySbDv7YpELz+xohw9/TTNwDYU3HP3P9xxjHQKPAqHpLbZX7RyAM
         wF0KaspbxNfMgpvjTiIUjsz44otXYrQqNS5ZtKEcR4JJQmPWZuogTB+MojMg8MyyD5GW
         IxOM+aTdqagyOjpaApZH/KxPYAoCrRPA9e2NF/aFSal8eBbG4oS2rqai/94ulPnNpY8t
         h6745mj2Dr6Hyg0y+cd3ZPHAbwdLIEoHM4WIIgRboHZilPaT/GVln7PxphtF+UwL6jZz
         Sr+Cl98lMbjPtkrfVATIYzwNz8nJHulA6EqPKa6jnXZcnFhpCCiJW08GSgsJHMnXqy1U
         gnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PBQAdfl2FcAetVP79a7BmHKTI8rOne6a7XU+buA6PoY=;
        b=Iu1GTfe0TdAL7zQddFpBbc19s3u+ZM5O+gv8YYv31lbILlzwpD6G1ac44kjGaWUNPM
         7OKl4OGHkW6bfFkcWOPG7Upcp+iVayW6DL4/mFGyQPOrOumzH9ax86jQV9UZ7tiWaG08
         yTzDWCAHyV4Tyns/i5VIiiDBBYqaqAO17vQbPSN/2EYIFj/601mFyehtKuPL27V1XvxZ
         5xVeOtq8Irr3koRNqDXv4q+33bS5l4KsOwOt7HuUEWD3UgMag5+yR6Cu4VCuyhCu8k9O
         FyddoZ7wyw6cpnFQwL1s4/NJarnPplhBUEAkX4+l7r79HdmPLnIca5pOQztlbEjHcky+
         prWg==
X-Gm-Message-State: ACrzQf26vxjnS2zZjTe9x14RIQe5Aq5jOl7573cQQvWmDvO6dD5+hRQ1
        9gu9qx/cU01ROluc4/bZpZA=
X-Google-Smtp-Source: AMsMyM7FIvBR83b1QCpIUMkydqEgN/EL2pCkEn7iksPhOacYbTA6KLg0RuDK+9b5o9pO4lBlHVgEiQ==
X-Received: by 2002:a02:6d04:0:b0:363:39b7:faa3 with SMTP id m4-20020a026d04000000b0036339b7faa3mr885328jac.156.1665008639719;
        Wed, 05 Oct 2022 15:23:59 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::cb3])
        by smtp.gmail.com with UTF8SMTPSA id q18-20020a0566380ed200b0036241880dc0sm4926104jas.148.2022.10.05.15.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 15:23:59 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v7 3/3] pinctrl: qcom: add sdm670 pinctrl
Date:   Wed,  5 Oct 2022 18:23:50 -0400
Message-Id: <20221005222350.47420-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <1ed91afd-74d2-1ab0-0d15-1b6e0dfba13b@linaro.org>
References: <20221004215814.11694-1-mailingradian@gmail.com> <20221004215814.11694-4-mailingradian@gmail.com> <1ed91afd-74d2-1ab0-0d15-1b6e0dfba13b@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 04/10/2022 23:58, Richard Acayan wrote:
> > The Snapdragon 670 has a Top-Level Mode Multiplexer (TLMM) for various
> > features. Add a driver to support it.
> 
> (...)
> 
> > +
> > +const int sdm670_reserved_gpios[] = {
> > +	58, 59, 60, 61, 62, 63, 64, 69, 70, 71, 72, 73, 74, 104, -1
> > +};
> > +
> > +static const struct msm_pinctrl_soc_data sdm670_pinctrl = {
> > +	.pins = sdm670_pins,
> > +	.npins = ARRAY_SIZE(sdm670_pins),
> > +	.functions = sdm670_functions,
> > +	.nfunctions = ARRAY_SIZE(sdm670_functions),
> > +	.groups = sdm670_groups,
> > +	.ngroups = ARRAY_SIZE(sdm670_groups),
> > +	.ngpios = 151,
> > +	.reserved_gpios = sdm670_reserved_gpios,
> > +	.complement_fw_gpio_ranges = true,
> 
> This still fails to build... v6 was not compilable, v7 is still.

Sorry, I only see the problem with complement_fw_gpio_ranges being removed from
the struct and not being removed here (in v7). Is there another issue that
affected v6?

> 
> Best regards,
> Krzysztof
