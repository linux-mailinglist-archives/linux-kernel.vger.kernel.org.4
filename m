Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E345F6770B1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjAVQqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjAVQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:46:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAE819686;
        Sun, 22 Jan 2023 08:46:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AC3E60C7A;
        Sun, 22 Jan 2023 16:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B82C433EF;
        Sun, 22 Jan 2023 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674405962;
        bh=AQ/kuD1UpuybXY4NA/nKCIQdS+nCP13moa731pzrRyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gus3NgHyX23OzLtbKxKhVzQCqZr9NFO8HTjFyYB0JpgVfH8E3JLdSO2igRcR12Qsz
         lv3x95Yb5XZby/0rQU0XlrbuN8EDxi6kcXromwqTQjLKIH/fRY2UBNhMhSrcimm/O2
         3B21MM5gN7fJVBzFKaPM//bbS0jA1/WdY0h4zxGNDEaAkwl1F7tCUg9cb38X/MFd13
         i8OSoUIPT5jn49KtpdB+YgTCNdc3nGPBEIb5nfSM4a1EQz/L0NNTrmN2jjue1r1afX
         K5G7EYhRg8ipkXD3IFXmZiseacQA2VfiDOltgOnbs3hkJi9sPFNqUdvovn6qcp3otW
         eKMQKQzkRICpQ==
Date:   Sun, 22 Jan 2023 16:59:47 +0000
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
Message-ID: <20230122165947.62e8652d@jic23-huawei>
In-Reply-To: <20230116220909.196926-1-marijn.suijten@somainline.org>
References: <20230116220909.196926-1-marijn.suijten@somainline.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 23:09:04 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> Implement read_label in qcom-spmi-vadc to see DT-specified label names
> in userspace.  At the same time clear up some documentation around
> extend_name to promote read_label, and normalize similar code in
> qcom-spmi-adc5.
> 

I think this is a good route forwards, but it is making changes
to ABI so I definitely want input on this from at least one of
the qualcomm maintainers before I pick it up - particularly
the changes in patch 3.

Don't want to cause anyone nasty surprises.

J

> Changes since v1:
> - qcom-spmi-vadc: Use read_label instead of extend_name;
> 
> New since v1:
> - core: Point users of extend_name field to read_label callback
> - qcom-spmi-adc5: Use datasheet_name string literal for
>   iio_chan_spec::datasheet_name;
> - qcom-spmi-adc5: Fall back to datasheet_name instead of
>   fwnode_get_name() for iio_chan_spec::extend_name (gets rid of @xx in
>   sysfs filenames and labels);
> - qcom-spmi-adc5: Remove unnecessary datasheet_name NULL check.
> 
> v1: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/
> 
> Marijn Suijten (5):
>   iio: core: Point users of extend_name field to read_label callback
>   iio: adc: qcom-spmi-adc5: Use driver datasheet_name instead of DT
>     label
>   iio: adc: qcom-spmi-adc5: Fall back to datasheet_name instead of
>     fwnode name
>   iio: adc: qcom-spmi-adc5: Remove unnecessary datasheet_name NULL check
>   iio: adc: qcom-spmi-vadc: Propagate fw node label to userspace
> 
>  drivers/iio/adc/qcom-spmi-adc5.c | 15 +++++++--------
>  drivers/iio/adc/qcom-spmi-vadc.c | 19 ++++++++++++++++++-
>  include/linux/iio/iio.h          |  3 +++
>  3 files changed, 28 insertions(+), 9 deletions(-)
> 
> --
> 2.39.0
> 

