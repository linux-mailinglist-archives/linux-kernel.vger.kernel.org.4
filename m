Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB71A6F336B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjEAQGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjEAQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADA8E42;
        Mon,  1 May 2023 09:06:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B83EE61DE3;
        Mon,  1 May 2023 16:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A721EC433D2;
        Mon,  1 May 2023 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682957167;
        bh=6lXizQOywjXgkuuj9flE2rzjtZg3/aSUBHv9yJ4qH2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ia0H0rq7/MlE5HTJx4T3AiWYks5rSNkHPFQ2vQJj8ZOJLp0bn733sGJLcOkdww/cq
         owfDuu7UqaWEdmKq0xYGsbXKplLnKJqKzmrSTw8b9GxnhV39oe/3rOLnbeKrx4DFAY
         FB9ft1ZNfr5ANXURzdfe0BKFBobKylDRX7C1SYGHM+rKUQVPuTlDvvQ63PyoWNcZci
         XlcJ7WdrXAbODjmLdKPHq5ZFyc2WkjEbSDxhLVJfS8L/YQFG2io7ysW4nT72qcf68W
         jxq/aRZOToStHkbz89pprNhZOOJdJ8s5uEsGMtX0XxDIjovGXFSlUBlQWHG2RCaUeQ
         7cKIQN3GQlznQ==
Date:   Mon, 1 May 2023 17:21:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/5] iio: adc: qcom-spmi-vadc: Propagate fw node
 label to userspace
Message-ID: <20230501172151.4a4b6dce@jic23-huawei>
In-Reply-To: <20230122234137.fyziba55n3b6tx3j@SoMainline.org>
References: <20230116220909.196926-1-marijn.suijten@somainline.org>
        <20230122165947.62e8652d@jic23-huawei>
        <20230122234137.fyziba55n3b6tx3j@SoMainline.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 00:41:37 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> On 2023-01-22 16:59:47, Jonathan Cameron wrote:
> > On Mon, 16 Jan 2023 23:09:04 +0100
> > Marijn Suijten <marijn.suijten@somainline.org> wrote:
> >   
> > > Implement read_label in qcom-spmi-vadc to see DT-specified label names
> > > in userspace.  At the same time clear up some documentation around
> > > extend_name to promote read_label, and normalize similar code in
> > > qcom-spmi-adc5.
> > >   
> > 
> > I think this is a good route forwards, but it is making changes
> > to ABI so I definitely want input on this from at least one of
> > the qualcomm maintainers before I pick it up - particularly
> > the changes in patch 3.
> > 
> > Don't want to cause anyone nasty surprises.  
> 
> Ack, patch 3 is the odd one of the bunch (as discussed many times
> prior).  It is an ABI break and would effectively obsolete "iio: adc:
> qcom-spmi-adc5: Fix the channel name" [1] as it then only affects a few
> dev_err/dev_dbg.  Let's wait and hear from Qcom maintainers.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20230118100623.42255-1-andriy.shevchenko@linux.intel.com/

Perhaps time for a resend of this series (drop the RFC marking as that
tends to mean people don't read things if they are low on time).

I'm going to mark this in patchwork as changes requested on basis a
v3 will show up shortly.

Thanks,

Jonathan

> 
> - Marijn

