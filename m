Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D606BA173
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCNV3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCNV26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:28:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7301DB95;
        Tue, 14 Mar 2023 14:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA821619BF;
        Tue, 14 Mar 2023 21:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF4FC433EF;
        Tue, 14 Mar 2023 21:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678829335;
        bh=3Xd2e0C4tHRKY8ttLfie/FTu756NF/DDGLIrwdbnRRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrnDapEVZAWiB+mIBAkjNiEv+UGUzEaAXzuMjTzjjEjS1jbpzhk4J2kgwl2c/1DLv
         leWLICG1I34rVaMoFzfS6KT+pDfSKjYUqn/qV27H2Izlzusu/PM9ELuMcVuZs5nbXc
         wiMQ4j/DZZzvknkfWI0XjEcLTr5fvjiRHDqDdIO5S4sbCsFW3ae6cixo9DDsOymiU4
         xdm60qcKIRC2XZyRwIRkMQXETXv9NIYJCA7kkOswpKDjc6IIqXKiE3zulc8GtuzLRV
         fDyJUISdqsbDYK0sZx473KQnK7GIf7PFS+sV5De4ORUzdhJqHaLlzq6JpuHDtE5tuF
         wO2ZHOvbLsEtg==
Date:   Tue, 14 Mar 2023 22:28:51 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kasumov Ruslan <xhxgldhlpfy@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Kasumov Ruslan <s02210418@gse.cs.msu.ru>
Subject: Re: [PATCH] iio: adc: qcom-pm8xxx-xoadc: Remove useless condition in
 pm8xxx_xoadc_parse_channel()
Message-ID: <20230314212851.hqbzs5hhed5apcv5@intel.intel>
References: <20230314193709.15208-1-xhxgldhlpfy@gmail.com>
 <CACRpkdan0Vt_T3aRVAK4rd=hQV=MOARm9Wq7sD8rjoisTW6Dkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdan0Vt_T3aRVAK4rd=hQV=MOARm9Wq7sD8rjoisTW6Dkw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > The left side of the loop condition never becomes false.
> > hwchan cannot be NULL, because it points to elements of the
> > hw_channels array that takes one of 4 predefined values:
> > pm8018_xoadc_channels, pm8038_xoadc_channels,
> > pm8058_xoadc_channels, pm8921_xoadc_channels.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> I am not impressed with that tool. See below:
> 
> > Fixes: 63c3ecd946d4 ("iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC")
> > Signed-off-by: Kasumov Ruslan <s02210418@gse.cs.msu.ru>
> 
> (...)
> >         hwchan = &hw_channels[0];
> > -       while (hwchan && hwchan->datasheet_name) {
> > +       while (hwchan->datasheet_name) {
> >                 if (hwchan->pre_scale_mux == pre_scale_mux &&
> >                     hwchan->amux_channel == amux_channel)
> >                         break;
> 
> NAK have you tested this on a real system?
> 
> Here is the complete loop:
> 
>         hwchan = &hw_channels[0];
>         while (hwchan && hwchan->datasheet_name) {
>                 if (hwchan->pre_scale_mux == pre_scale_mux &&
>                     hwchan->amux_channel == amux_channel)
>                         break;
>                 hwchan++;

ops, yes, sorry, I overlooked at this... This becomes NULL at
some point as there is a sentinel in the _variant structures.

Thanks,
Andi

>                 chid++;
>         }
> 
> Notice how hwchan is used as iterator in hwchan++.
> 
> What you are doing will cause a zero-pointer dereference.
> 
> Whoever is developing "SVACE" needs to fix the tool to understand
> this kind of usage.
> 
> Yours,
> Linus Walleij
