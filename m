Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6659173FA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjF0KyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjF0KyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:54:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAA01FDE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:54:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso4172552e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687863249; x=1690455249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/3/Pl0tuPRbfuDP1AdE9VlIh+h2E8Q6RrXICwnGYhU=;
        b=CQF/TOzOM+o3Tl4syLqqTQMovqHI3RYpBuWiZqTJDKA2lQNqYuAszrUeZp7uVPX8mR
         qY0AtmnYE6PvnYvBEYfl0l1nSfj/oghQOfXOzs2eb98qYDjbPasVkWVwImlYmsSymPoz
         GZggbbW0+GaxE5EkZGGdua+q7/SfjObckb4EqELceMcLju1a9+ec06eAHj8qxkgYt2X6
         zMc85RzZqCbynJeiNLbU+x5NTalIwpjgSTScijO0IydI4AsFzHyjjlQ4MVMCcr+Ggp2M
         ipPfIwvgvIQiolDKxxvn05eTWiqqNU/cQn4VZ/oua8pIF2gDyGm1D6U4QMEzl9RFrQvy
         XY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687863249; x=1690455249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/3/Pl0tuPRbfuDP1AdE9VlIh+h2E8Q6RrXICwnGYhU=;
        b=cIC1VHaCkcoR7NOcor38XHsp6NR/i2lMJNJ/L5GbR/E78W7CzweTIw4lf9rx22JMYe
         bArbCfuhHhr3ZU/rVDPFrPX6ABHYRBb0qt4UTls3Qcklxuqp05Jx39iSsooALgej0+ao
         lhqqIfu1PNTOgj7vH/0JplQrBPjj+RL4WO+RohOunH/tgyEDAWc0LD+m2UqSM+E0BZ2M
         a8bFQEaQp67SQPuy5Z7VWWEIialuVMCuVUcoD2p2Ucvs7AmF1iyi9xUck8wCBcYI6IwQ
         lo2svVX4i2t53r/oN7y/qmZ0/RIVQHZ6VptwAMgD/ZU2TlgzevFiucrO5UzRfVNl5a6o
         nxng==
X-Gm-Message-State: AC+VfDwUFMQSGGOtjCAIDAszlebVCut2kYuI97dh+kTIbIbsOfMF2yye
        IRZKF7WfVhsKORfQRRy32nOWzg==
X-Google-Smtp-Source: ACHHUZ7k9Ag/F1Rx0JLwrCSKfm0c8Qh4irFFfk1A/Ij8ZpFTwvoIjYcFx6pE/Sm2leBHKfGgUy/DAg==
X-Received: by 2002:a05:6512:2343:b0:4fa:9817:c1da with SMTP id p3-20020a056512234300b004fa9817c1damr5082080lfu.21.1687863248768;
        Tue, 27 Jun 2023 03:54:08 -0700 (PDT)
Received: from linaro.org ([62.231.110.100])
        by smtp.gmail.com with ESMTPSA id i5-20020a05600c290500b003f9b66a9376sm13378426wmd.42.2023.06.27.03.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 03:54:08 -0700 (PDT)
Date:   Tue, 27 Jun 2023 13:54:06 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        avel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] PM: domains: Allow devices attached to genpd to
 be managed by HW
Message-ID: <ZJq/zgFC+O2MoiEw@linaro.org>
References: <20230627104033.3345659-1-abel.vesa@linaro.org>
 <2023062741-passion-scarcity-2390@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062741-passion-scarcity-2390@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-27 12:46:28, Greg Kroah-Hartman wrote:
> On Tue, Jun 27, 2023 at 01:40:32PM +0300, Abel Vesa wrote:
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > Some power-domains may be capable of relying on the HW to control the power
> > for a device that's hooked up to it. Typically, for these kinds of
> > configurations the device doesn't really need to be attached to a PM domain
> > (genpd), from Linux point of view. However, in some cases the behaviour of
> > the power-domain and its device can be changed in runtime.
> > 
> > To allow a consumer driver to change the behaviour of the PM domain for its
> > device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
> > let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
> > which the genpd provider should implement if it can support switching
> > between HW controlled mode and SW controlled mode.
> > 
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> You can't forward on a patch from someone else without also adding your
> signed-off-by on it, right?

Oups, forgot to add it. Will do in the next version.

> 
> Also, why is this a RFC series?  What is left to do with it to get it
> into a state which you feel comfortable having us review it "for real"?

There is a bit of back story here. This HW control support is something
that Qualcomm platforms support for some of the PDs. Sent this as RFC
as I thought it might open up a discussion of such a generic need at
first. But now that I think of it, it might've been a non-RFC patch as
well.

> 
> thanks,
> 
> greg k-h
