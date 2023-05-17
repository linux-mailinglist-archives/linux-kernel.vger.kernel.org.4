Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2361705E41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjEQDod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjEQDoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BE040F2;
        Tue, 16 May 2023 20:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B1D461631;
        Wed, 17 May 2023 03:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701DBC433EF;
        Wed, 17 May 2023 03:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684295039;
        bh=Q2ZbDs6s6Qb4ow2/OkPPdJPXinCRf1wvSh2xDl0bANU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmUEVUPMUu7tHPzGAeEv5ytuXrKtHB42dhqUTv15zKAMY2EM1sx/kW7CVlKRD/Xtw
         FIeO/PFkb78wR/nRnxBllzYD/cJNyNbyJeFKXEtLFjE3ICunclMIbWgejDHzyPMYew
         gOXanAeOUQGVMEiO2deXaRoPAuFo4Al7760SG7Nqpk1pWdd8zxsez5+BsfodX959A4
         xmSRT7p4Xpax6KJfgmCkkwOHCMYyuNGhtsP4IDq4D5pKODBEU0l00nfR4+p9aMKa9w
         Y3t+eW+0b+HBPPJLLERl1W9gvbtMIwHLj+c22a9FrStpId4cNkQQVU1zhhiS3/v1In
         C5D/EGWQbfGBA==
Date:   Tue, 16 May 2023 21:44:46 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: venus: Replace one-element arrays with
 flexible-array members
Message-ID: <ZGRNrvl3xwgMqTWF@work>
References: <ZGPk3PpvYzjD1+0/@work>
 <202305161318.4AF9203EB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305161318.4AF9203EB@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 01:18:39PM -0700, Kees Cook wrote:
> On Tue, May 16, 2023 at 02:17:32PM -0600, Gustavo A. R. Silva wrote:
> > One-element arrays are deprecated, and we are replacing them with flexible
> > array members instead. So, replace one-element arrays with flexible-array
> > members in multiple structures, and refactor the rest of the code,
> > accordingly.
> > 
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> > 
> > This results in no differences in binary output.
> > 
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://github.com/KSPP/linux/issues/291
> > Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Oh fun, a subtraction variant! :)

This code has everything, subtractions and additions :p

https://lore.kernel.org/linux-hardening/ZGQn63U4IeRUiJWb@work/

> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!
--
Gustavo
