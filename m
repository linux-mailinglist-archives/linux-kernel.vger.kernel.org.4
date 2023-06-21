Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491997381B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjFULAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjFULAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0274B6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C379614D8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E96C433C0;
        Wed, 21 Jun 2023 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687345220;
        bh=lXzszQD+zptu3Dhn+zgRvR6h6mdmH5naNO55GH7WfQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezCkDl0dShEAojqKiOZZfJIfIyZOWQ4bsdnFsAMM5buRpqn30urYYfa7ZZ81l8woq
         /X8xYwAtPkZv+W4eJOQA4XUplnt3BPQFC+BYkTPLxDnf7VdtJGSikuEIwgHA7PBPUV
         FRgKH8Oam///jNZmSJx6sdOasO7dlTnSnG8rX+3ek6z6VZXNJCb9nCegCHQfNErx2r
         mEqs1E6CYixsXgnXFSr/VDxY3pdvg75IGMzqztq2EYRKzSt9sGIimbK8DEn1/ZiLPY
         4eOgmJcwjhXqjGojAbqRy4Y0j8376fnrMKTpwSUVnUZoZxXitZM2vA27mx5SdKLuF+
         f0jTzRcdOYqmw==
Date:   Wed, 21 Jun 2023 16:30:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com
Subject: Re: [PATCH 2/4] soundwire: introduce SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY
Message-ID: <ZJLYQCwvvIwEj47H@matsya>
References: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
 <20230531033736.792464-3-yung-chuan.liao@linux.intel.com>
 <ZIF94vZHzeGXfyin@matsya>
 <6c75e986-29a4-d97c-3862-d20397f8b8b4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c75e986-29a4-d97c-3862-d20397f8b8b4@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-06-23, 10:09, Pierre-Louis Bossart wrote:
> 
> 
> On 6/8/23 02:06, Vinod Koul wrote:
> > On 31-05-23, 11:37, Bard Liao wrote:
> >> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >>
> >> This patch adds a new Device Number allocation strategy, with the IDA
> >> used only for devices that are wake-capable.
> >>
> >> "regular" devices such as amplifiers will use Device Numbers
> >> [1..min_ida-1].
> >>
> >> "wake-capable" devices such as jack or microphone codecs will use
> >> Device Numbers [min_ida..11].
> >>
> >> This hybrid strategy extends the number of supported devices in a
> >> system by only constraining the allocation if required, e.g. in the
> >> case of Intel LunarLake platforms the wake-capable devices are
> >> required to have a unique address to use the HDaudio SDI and HDAudio
> >> WAKEEN/WAKESTS registers.
> > 
> > This seems to be a consequence of Intel hardware decisions, so I guess
> > best suited place for this is Intel controller, do we really want to
> > have this in core logic?
> 
> It's a valid objection.
> 
> The reason why I added the alternate strategies in the core logic is
> that the IDA and hybrid approach are just software-based with no
> specific hardware dependencies. If QCOM or AMD wanted to use the
> strategies contributed and tested by Intel, it'd be a two-line change on
> their side.
> 
> That said, it's likely that at some point *someone* will want to
> constrain the device number allocation further, be it with ACPI/DT
> properties or reading hardware registers. The device number is a
> de-facto priority given the way we scan the PING frames, so some systems
> may want to give a higher priority to a specific peripherals.
> 
> This would push us to add a master ops callback to control the device
> number allocation. It's a bit invasive but that would give the ultimate
> flexibility. Reuse between vendors could be possible if 'generic'
> callbacks were part of a library to pick from.
> 
> I don't really have any objections if this vendor-specific callback was
> preferred, it may be a bit early to add this but long-term it's probably
> what makes more sense.
> 
> I'll go with the flow on suggested recommendations.

Thanks, if it all one of the other two controller start using this, it
would make sense to move it to core then, for now would be better to
have this in specific driver

-- 
~Vinod
