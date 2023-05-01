Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B96A6F3AFF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 01:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjEAXUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEAXUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 19:20:50 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E80830F2
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 16:20:48 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3542240E49;
        Tue,  2 May 2023 01:20:47 +0200 (CEST)
Date:   Tue, 2 May 2023 01:20:45 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jonathan Cameron <jic23@kernel.org>
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
Message-ID: <jj7taer4qk5whekl5tugkgdlmmxsokihxd2ay33ikvhhkig5uc@zgd4phhyb4zr>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>, 
        Jonathan Cameron <jic23@kernel.org>, phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>, 
        Bjorn Andersson <andersson@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
        Martin Botka <martin.botka@somainline.org>, Jami Kettunen <jami.kettunen@somainline.org>, 
        Lars-Peter Clausen <lars@metafoo.de>, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
        linux-kernel@vger.kernel.org
References: <20230116220909.196926-1-marijn.suijten@somainline.org>
 <20230122165947.62e8652d@jic23-huawei>
 <20230122234137.fyziba55n3b6tx3j@SoMainline.org>
 <20230501172151.4a4b6dce@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501172151.4a4b6dce@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-01 17:21:51, Jonathan Cameron wrote:
> On Mon, 23 Jan 2023 00:41:37 +0100
> Marijn Suijten <marijn.suijten@somainline.org> wrote:
> 
> > On 2023-01-22 16:59:47, Jonathan Cameron wrote:
> > > On Mon, 16 Jan 2023 23:09:04 +0100
> > > Marijn Suijten <marijn.suijten@somainline.org> wrote:
> > >   
> > > > Implement read_label in qcom-spmi-vadc to see DT-specified label names
> > > > in userspace.  At the same time clear up some documentation around
> > > > extend_name to promote read_label, and normalize similar code in
> > > > qcom-spmi-adc5.
> > > >   
> > > 
> > > I think this is a good route forwards, but it is making changes
> > > to ABI so I definitely want input on this from at least one of
> > > the qualcomm maintainers before I pick it up - particularly
> > > the changes in patch 3.
> > > 
> > > Don't want to cause anyone nasty surprises.  
> > 
> > Ack, patch 3 is the odd one of the bunch (as discussed many times
> > prior).  It is an ABI break and would effectively obsolete "iio: adc:
> > qcom-spmi-adc5: Fix the channel name" [1] as it then only affects a few
> > dev_err/dev_dbg.  Let's wait and hear from Qcom maintainers.
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20230118100623.42255-1-andriy.shevchenko@linux.intel.com/
> 
> Perhaps time for a resend of this series (drop the RFC marking as that
> tends to mean people don't read things if they are low on time).
> 
> I'm going to mark this in patchwork as changes requested on basis a
> v3 will show up shortly.

v3 is out now after once again messing with b4 to import an older
series, with a RESEND to include all the email addresses which b4 only
addes after using prep --auto-to-cc, and there not being any obvious way
to retroactively add the bunch of To:/Cc: commands to a previously sent
version before running b4 send --resend v3.

Fingers crossed it all went right and reaches the right people.

- Marijn
