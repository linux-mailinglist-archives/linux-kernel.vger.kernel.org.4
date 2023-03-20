Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929C16C0989
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 05:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCTEHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 00:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCTEHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 00:07:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1A2A5D3;
        Sun, 19 Mar 2023 21:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 625F1B80D41;
        Mon, 20 Mar 2023 04:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58156C433EF;
        Mon, 20 Mar 2023 04:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679285223;
        bh=LWrLSE3PjI2DAUNQSlxIRlBkpOj6wq3YhB8CFWL5u00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGRdLnMul6m8B4CDoDa6CbkxrnVszS/ygTj4WxwMuRXmuLSvNjBqVRQljfQ6SctS/
         IQ/wjpMjsYFAUMwHSOSWxuxiG8/Ij/MG6Ypr8NRVcOb9PkG/75BJtruB6aK5s26uQI
         3Mucfp7kV7zoRw3EAYmbw/YfAoZxIo8xdkphguarPfG8SRcLSvVHNH2BrdLkXS7Maa
         pWtF1vItEESGJcAj4oTWquhnMnqtUQf3oCBxmpYThCJmSkSA1qsVNsPP7RN89kKUmO
         9idlyuNeDSihCZenmzPhxaKmVQ8mNliJcEIj9HyJNTW4L13OW7R6RQfrg9AO8Wb6Y5
         YWNZgxmy5r9+g==
Date:   Sun, 19 Mar 2023 21:10:19 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/5] pinctrl: qcom: Use qcom_scm_io_update_field()
Message-ID: <20230320041019.5qs6qbztvv45pacs@ripper>
References: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
 <1679070482-8391-3-git-send-email-quic_mojha@quicinc.com>
 <CACRpkdbA27buNiOTz6ad4gyS4FCvcoYru6QB5k9Lqwiu72sf9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbA27buNiOTz6ad4gyS4FCvcoYru6QB5k9Lqwiu72sf9g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 09:58:04PM +0100, Linus Walleij wrote:
> On Fri, Mar 17, 2023 at 5:28 PM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> 
> > Use qcom_scm_io_update_field() exported function introduced
> > in last commit.
> >
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> Fine by me, but I want you to first consider switching the
> custom register accessors to regmap.
> 

I took a quick look at it and there seem to be two ways that it can be
done.

We can retain the MSM_ACCESSOR() macros that generates the custom
register accessors, but plug in a regmap between these accessors and the
mmio operations. But this just adds a few extra hops inbetween the
driver and the volatile read/write, with a slight increase of memory,
without any obvious benefits.


The more alluring alternative is to replace the custom accessors with
reg_fields. This would allow us to replace some (perhaps many) of the
bit-manipulation with regmap_update_bits().

But at minimum we'd need one reg_field per register, per pin, so that's
5 reg_fields per pin which adds up to ~10-24kb extra space, depending on
platform.

Even more alluring would be to have reg_fields describing the actual
fields in the registers, which would allow us to better utilize the
regmap API directly. This would cost us 35-75kb of heap.

IMHO this is quite a significant effort, and given that the driver seems
to be doing its job I'd rather see such efforts being focused elsewhere.

Regards,
Bjorn
