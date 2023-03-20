Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF976C0946
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCTDTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCTDT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:19:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E9D16885;
        Sun, 19 Mar 2023 20:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9480CB80CAA;
        Mon, 20 Mar 2023 03:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06D0C4339B;
        Mon, 20 Mar 2023 03:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679282363;
        bh=rCtb7H/1ZC98DfinCkjJEkMFSPkuanMurLMAkshN2wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJNOdO/KS/+BzEmoG5jJAxpw1vUi6/4Ek2+C4UB6NNgVQ5aEGIJ2KSnllmvImylOV
         62rM7UQrlfSlojDUaNQUxEXV44YTveVEzUvewaMedXJ8wp0QAeeuOhMqd+X3lamgBm
         Ul4GnTJCCaA/7UoETEaChj5bCJvsNcveTzv6huhMWecNvBmj2dNs8aJVuM6g8MyzzU
         pqwliC7lfMIIAkU6VrgJ2rdiQ4yv6EMH2WyiNcLAV+bJHnpCEcR9m7BqMKufbOTCTk
         60oxJ2Puaju6/f4bvIsX9LBfJodqcZGox7j6rVMv8QIwGcHmQgXH+UlUQyoXe44COh
         7O2Sv1AyhJGeg==
Date:   Sun, 19 Mar 2023 20:22:38 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 1/5] firmware: qcom_scm: provide a read-modify-write
 function
Message-ID: <20230320032238.xf5jlt43qebcewm4@ripper>
References: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
 <1679070482-8391-2-git-send-email-quic_mojha@quicinc.com>
 <CACRpkdb95V5GC81w8fiuLfx_V1DtWYpO33FOfMnArpJeC9SDQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb95V5GC81w8fiuLfx_V1DtWYpO33FOfMnArpJeC9SDQA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 09:56:59PM +0100, Linus Walleij wrote:
> On Fri, Mar 17, 2023 at 5:28 PM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> 
> > It was released by Srinivas K. that there is a need of
> > read-modify-write scm exported function so that it can
> > be used by multiple clients.
> >
> > Let's introduce qcom_scm_io_update_field() which masks
> > out the bits and write the passed value to that
> > bit-offset. Subsequent patch will use this function.
> >
> > Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> This is starting to reimplement regmap.
> In this case regmap_update_bits().
> 
> What about just using regmap as accessor for these
> registers instead?
> 

I'm not sure it would be beneficial...

The regmap interface provides a standardized representation of a block
of registers, with the suitable accessors backing it. But in both cases
touched upon in this series, the addressed registers are part of regions
already handled by the kernel.

So it wouldn't be suitable to create a regmap-abstraction for "a block
of secure registers", at best that would give us two kinds of regmaps
abstracting the same register block.


Instead I believe we'd need to extend the struct regmap_config to
introduce a new table telling a new secure-or-unsecure-mmio-regmap which
accessor (secure or unsecure read/write) shoudl be used, and then have
e.g. pinctrl-msm register such regmap, passing the information about
which registers in its memory region is secure.

We'd still need qcom_scm_io_readl() and qcom_scm_io_writel() exported to
implement the new custom regmap implementation - and the struct
regmap_config needed in just pinctrl-msm alone would be larger than the
one function it replaces.

But please let me know if I'm missing something?

Regards,
Bjorn
