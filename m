Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800F35F2363
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 15:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJBNdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 09:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJBNdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 09:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5E193DD;
        Sun,  2 Oct 2022 06:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6BC560EC4;
        Sun,  2 Oct 2022 13:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2991FC433D6;
        Sun,  2 Oct 2022 13:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664717581;
        bh=ip2SEwPEk79/NVSLR/aKzp9lX2c3j+xDgmd4CAEEvAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MfjLc+nyXECLHzOijUKe92NOenb1ZvhnQKXYzLVDJHC6T9zVC3J+zo3iCcjyskjqF
         k/NOePyASmXK/x/pMlRhTUaPrXIKEnu3xjRuq5OQ4AGot1ywkF54TO/58xlxAmT0gp
         qSjqDc3Upw/IwYnQLxRIhAvSvO6PKdSi70UopjKIclFpX60UA8Nl3pIF9cxh/9RBJt
         Zz92vVPrWrvx8YpaKc3XbU4azjzhXhre3yEto8BljAj4uAwskH8xNZgvE7IHAaRcb0
         Ycym//1UGWiVY5vkciQLNcjKkyKLA18q5C8LpUH3OgI7rkdQHtaUTs7BuGCLGrBJFz
         9Pk2FmEeF7mzA==
Date:   Sun, 2 Oct 2022 14:33:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        nuno.sa@analog.com, Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/8] iio: adc: stm32-adc: fix channel sampling time init
Message-ID: <20221002143315.05b867a2@jic23-huawei>
In-Reply-To: <CAHp75Vf1rJRVK5Emuwk4863DTb9JjTswJefJM-1oX+2gQvLMRg@mail.gmail.com>
References: <20220928164114.48339-1-olivier.moysan@foss.st.com>
        <20220928164114.48339-2-olivier.moysan@foss.st.com>
        <CAHp75Vf1rJRVK5Emuwk4863DTb9JjTswJefJM-1oX+2gQvLMRg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022 19:51:04 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Sep 28, 2022 at 7:42 PM Olivier Moysan
> <olivier.moysan@foss.st.com> wrote:
> >
> > Fix channel init for ADC generic channel bindings.
> > In generic channel initialization, stm32_adc_smpr_init() is called
> > to initialize channel sampling time. The "st,min-sample-time-ns"
> > property is an optional property. If it is not defined,
> > stm32_adc_smpr_init() is currently skipped. However stm32_adc_smpr_init()
> > must always be called, to force a minimum sampling time for
> > the internal channels, as the minimum sampling time is known.
> > Make stm32_adc_smpr_init() call unconditional.  
> 
> What is the text width here? It's okay to use Up to ~72 (or slightly
> more) as a limit and format accordingly.
> 
> > Fixes: 796e5d0b1e9b ("iio: adc: stm32-adc: use generic binding for sample-time")
> >
> > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>  
> 
> Tag blocks mustn't have the blank lines.
> 
For this one, please make it clear if this is breaking current systems
or if this is more theoretical, so I can judge whether to rush it in (and
potentially slow down the rest of this patch set!)

Jonathan


