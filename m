Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD1615A89
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiKBDc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiKBDcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:32:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3826481;
        Tue,  1 Nov 2022 20:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A30C4B82063;
        Wed,  2 Nov 2022 03:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C3AC433C1;
        Wed,  2 Nov 2022 03:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667359970;
        bh=z+Z6VZbpWX1sIyW/6+Qo7h9xWCq56kkiLYfY6H+5Mxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=krNtCIGKaKRe/8K0+pgWXFgyIXUnEoFVzl232FKBjnJDn9q5XHUoptgtGfI0jLyHB
         FK9KgcFeQVpqWeijj6a3PGb+M6bgWLKELXMzGlA5I+C5rl/aDdhKe+MmnaZNbLpXaE
         g0CSvkoopScG1AFv80QQ7oKv42iplc9W7H366M/AyqX8pZhUEJYNoR2EkChrjLe/mz
         2VBHf97yNkxRgrkHBuz895ocQ33Yns/prROABjnvmfigL+qdi/EeJ55ygB66rY+hdU
         LjsC4ppC6n9cdsG3tT/H39sINYGCxAr8htAOl3wqWQFBiSz0FiqszgszOWUt9fyXBs
         JtqTdNKpdJpcQ==
Date:   Tue, 1 Nov 2022 22:32:47 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Deepak Kumar Singh <quic_deesin@quicinc.com>,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        quic_clew@quicinc.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH V3 0/3] rpmsg signaling/flowcontrol patches
Message-ID: <20221102033247.7aadwbj3fojtpsnh@builder.lan>
References: <1663133102-10671-1-git-send-email-quic_deesin@quicinc.com>
 <74224354-8543-559b-240b-0eda4d68fc52@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74224354-8543-559b-240b-0eda4d68fc52@foss.st.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 09:50:48AM +0200, Arnaud POULIQUEN wrote:
> Hi Deepak,
> 
> On 9/14/22 07:24, Deepak Kumar Singh wrote:
> > [Changes from V2]:
> > Trivial review comment fixes.
> > Avoid TIOCM_DTR etc signals in glink layer, use native signal macros only.
> > Glink layer to provide only flowcontrol on/off interface, no specific signal passing/receiving to client.
> 
> 
> Please, could you have a look to my series that implements
> your proposed interface for the virtio rpmsg [1]?
> It would be nice that your API takes into account update to
> support of the rpmsg virtio implementation proposed in [08/10] rpmsg: Add the
> destination address in rpmsg_set_flow_control[2]
> 

Your proposal seems reasonable Arnaud, for virtio it makes sense to
provide the destination address in the API as well.

It's a kernel-internal API so we could change it, but let's try to avoid
that by adding the address from the start.

Regards,
Bjorn

> Thanks,
> Arnaud
> 
> [1] https://lore.kernel.org/lkml/e54bcfcb-8e37-9caa-b330-a7411820b7ce@foss.st.com/T/
> [2]https://lore.kernel.org/lkml/e54bcfcb-8e37-9caa-b330-a7411820b7ce@foss.st.com/T/#m7340a8e70fb0d8935869c4cef96863abda555c96
> 
> > 
> > Deepak Kumar Singh (3):
> >   rpmsg: core: Add signal API support
> >   rpmsg: glink: Add support to handle signals command
> >   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
> > 
> >  drivers/rpmsg/qcom_glink_native.c | 63 +++++++++++++++++++++++++++++++++++++++
> >  drivers/rpmsg/rpmsg_char.c        | 60 ++++++++++++++++++++++++++++++++-----
> >  drivers/rpmsg/rpmsg_core.c        | 20 +++++++++++++
> >  drivers/rpmsg/rpmsg_internal.h    |  2 ++
> >  include/linux/rpmsg.h             | 15 ++++++++++
> >  5 files changed, 152 insertions(+), 8 deletions(-)
> > 
