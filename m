Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3534175055D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjGLLCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGLLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:02:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E4C11D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EC4261752
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF256C433C7;
        Wed, 12 Jul 2023 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689159769;
        bh=sHlcsAzZoI0UeTeVS6Wp+WgUZq08oaVAI3iN0xZW8R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ErgAIMo2X44VTvdBSlOvmgtZR+YY2nI+H9aIuMTd/WePgChlcO3dECUCsOA6BY4RX
         W4lyUIfW8Mm/xAnaS33NjuINxncBOPPvjt5adKlA3Vl5IQVFrhvXzNtV4nUQ/1zg2b
         5tRliESOYqng5EIcEiS46TZiDazLp8TWfWdWthqxw//Kuh3XwPVyYV5qcCDWWG6VtV
         r1L8YkJhgU4zrvDSXdLpySD4+VcHExwNNWGDSa8B3MIv0p5yz1wy4BNl1DUV0MlZl6
         DPEv+GENGVAqd/eutpeTrRwh7eCOt5NIG1pSVwz5Sygq/SlCuJJNPMwJ37lqKmnbQh
         SGvPvmQrvN0hQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qJXcN-0002Ec-0l;
        Wed, 12 Jul 2023 13:02:47 +0200
Date:   Wed, 12 Jul 2023 13:02:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Oops on /proc/interrupt access with 6.5-rc1
Message-ID: <ZK6IV_jJPICX5r53@hovoldconsulting.com>
References: <ZK16bmOPqe4Ev1Hb@hovoldconsulting.com>
 <86a5w2wc2d.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a5w2wc2d.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 07:14:02PM +0100, Marc Zyngier wrote:
> On Tue, 11 Jul 2023 16:51:10 +0100,
> Johan Hovold <johan@kernel.org> wrote:

> > Konrad reported on IRC that he hit a segfault and hang when watch:ing
> > /proc/interrupts with 6.5-rc1.
> > 
> > I tried simply catting it and hit the below oops immediately with my
> > X13s (aarch64).
> > 
> > Commit 721255b9826b ("genirq: Use a maple tree for interrupt descriptor
> > management") stood out when skimming the log, and Marc soon suggested
> > the same possible culprit on IRC.

Turns out we had a buggy patch that requested an irq using a stack
allocated name. So false alarm.

Sorry about the noise.

Johan
