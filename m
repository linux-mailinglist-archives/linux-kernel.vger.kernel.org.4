Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E55701868
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjEMRM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEMRM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23B03583;
        Sat, 13 May 2023 10:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 329456100B;
        Sat, 13 May 2023 17:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03C5C433EF;
        Sat, 13 May 2023 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683997975;
        bh=4M0dii1ESCI8ZzKoU7dzZMbO4MfuosVCc3BPmvrj6Ds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=htIknne+vC5XljuDs98+kHEbiMocVJE/nuXne28EnyBP07AEUEahxbVvNNUGxG6b7
         E5Jy7SBSfRzlekyrrhpgk/YnUjNqjlO2AZuUagaPuSRGxYmcUo/3Fyi7sEkoQI2doT
         BNdneth0czJY2CuYEMe5m1gyTqPfatIhUE0l/DSp1niektGsz0qLX3LWfPdWMHFcvX
         oHh4iRKPcH9PdugfeCyvyrcBnOpdpQ5tL9xI3kFxUEy8Nq5iB7IDpHzrBcg6ZOzyTU
         nUJZ1IpOy/MB3xBFRlcbfPIxp/B6AJny5sRWo5FhiwcV12s+5ssmggwJMwi+8s7f6h
         YF8ZF+YTnSsKQ==
Date:   Sat, 13 May 2023 18:28:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND v3 5/5] iio: adc: qcom-spmi-vadc: Propagate fw
 node label to userspace
Message-ID: <20230513182855.7ed9fd08@jic23-huawei>
In-Reply-To: <55538c42-b348-71ab-4aff-7cccfb14f8ab@linaro.org>
References: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
        <20230502-iio-adc-propagate-fw-node-label-v3-5-6be5db6e6b5a@somainline.org>
        <55538c42-b348-71ab-4aff-7cccfb14f8ab@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 May 2023 18:43:16 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> On 02/05/2023 02:17, Marijn Suijten wrote:
> > Set the read_label() callback to return a friendly name provided in DT
> > (firmware), in order to make in_{therm,voltage}X_label attributes show
> > up in sysfs for userspace to consume a channel name.  This is
> > particularly useful for custom thermistors being attached to otherwise
> > generically named GPIOs, where the name is known by the board DT.
> > 
> > If the channel name isn't set in DT, use the datasheet_name hardcoded in
> > the driver instead.
> > 
> > Note that this doesn't fall back to fwnode_get_name() as that provides
> > suboptimally readable names, with an @xx address suffix from board DT.
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >   drivers/iio/adc/qcom-spmi-vadc.c | 19 ++++++++++++++++++-
> >   1 file changed, 18 insertions(+), 1 deletion(-)  
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

Thanks,

Series applied to the togreg branch of iio.git - initially pushed out
as testing to let 0-day work it's magic before I go potentially making
a mess in linux-next.

Jonathan
