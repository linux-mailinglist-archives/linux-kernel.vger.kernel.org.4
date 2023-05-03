Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1286F53C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjECIyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjECIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:54:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45991E4F;
        Wed,  3 May 2023 01:54:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3064099f9b6so387000f8f.1;
        Wed, 03 May 2023 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683104089; x=1685696089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f2p0yoo0i5p3EfddnZbh5yG5oSchLdGvcnS9WBAzF48=;
        b=EHtvlf+qv5+8pmPJ2JRdBdO45v8SNHSizF3F1V6dZY2/UK5W3h+D6P/nZjqF5IJs2P
         hO8ojtoXO+C6iZFJqQsDmpzJn4x/l+scAfNuegluhhzAoml1eY9mhu8mw5zBAZetpXY1
         KCic7dJ5tbkctiDHaB+7henMb9PTsJjmhDwIMrwgCpjS9GxioYblhDeEKxM87QZQVvvp
         bBVUkQeuHvNB6qzfpq/pMOzvMBGrMzih2ecEaF2ca8UAweuEy7RFZgXgab95ZY8H2K5i
         Bt2zdnhTuKvShyKz2yiPbPy+t1ivk8/jbInxRHv+XUhWsBMdfyZNnrH5gv2B0d2e5qSU
         QY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104089; x=1685696089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2p0yoo0i5p3EfddnZbh5yG5oSchLdGvcnS9WBAzF48=;
        b=lDRQbZRd/rBWZ5UaLFwkJm+Pz6IACWzvOYnL5WJp/rYFcu4fBclIW9IUIVAt1PFGUa
         IH6vZ0I1Gohlw4eg2Z24a2BdR/o39tG8RGNtCTRigQhoiZGLCJdc/gUR9JLMRFl9GXmV
         PJ9XoAse9XD8X8WfCtwZXYyLo8/NWXThCJA9eBj9VZgD52PduNTDDCj/O7ewjC9wDcxU
         tLiSpnYEODXI1rXbRw6IUby/p4ANFPhyEKex7M7t/+37P5hcQXmtjNit9FNworA7xSVo
         8b3lHV2W1p0NTjy3qxtKrbHqfn0UDf/fV+c+Rvwb2y0xfIf9nKJ7DNALZMWFs4f2Ywfy
         JcQA==
X-Gm-Message-State: AC+VfDyEscUeRLX84Uw1Aj6oNHZREoG1yK7H60py/lSJV6oYsk3o49NM
        WZmSRlIbHojdr1QwM1vlcL2o/CJHQngI6wKxUWOtVOzVRg==
X-Google-Smtp-Source: ACHHUZ76C7h3pCTp93J3BNUiRv2goG0fxJQVWnMgNbV6RMd/YFSGitH8MI8s1qmSFEgV0buGilHBZzwm3EwhliR5SFc=
X-Received: by 2002:adf:e5c2:0:b0:2fb:ca40:e42c with SMTP id
 a2-20020adfe5c2000000b002fbca40e42cmr13636086wrn.6.1683104089624; Wed, 03 May
 2023 01:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <ZEnErxfnSn2JOpvm@nixie71> <20230428102015.810686-1-tomas.mudrunka@gmail.com>
 <ZFHOwEu6tKDjoPA4@nixie71>
In-Reply-To: <ZFHOwEu6tKDjoPA4@nixie71>
From:   =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date:   Wed, 3 May 2023 10:54:37 +0200
Message-ID: <CAH2-hcJYVpBNwnMS6qUp4=MW8kSryDAz7G5cNA8R00QabC9bjg@mail.gmail.com>
Subject: Re: [PATCH v4] Fix freeze in lm8333 i2c keyboard driver
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Just to clarify, my stance is that this call should go _before_ the handler
> is registered.

Ok, i will fix the patch later today.

> Any events that come before then are off the table, and this is OK because
> user space isn't going to start consuming key events until well after this
> driver has probed anyway.

Well, that was never my point. I don't care about capturing events
that happen before driver was properly loaded.
My only concern was to limit possibility of deadlock which happened previously.
Because that makes device unusable till the IC is power cycled.
Which might be especially annoying on devices that have power button
implemented using this exact IC :-)

> The reason behind my assertion is that as a matter of best practice, you
> should not have two asynchronous threads that can in theory access the same
> register.

Yeah, this makes bit more sense now. Didn't realized IRQ might
interrupt that lm8333_irq_thread() call immediately.
While not very likely to cause problems like deadlock of the driver, i
think it's a valid point.

After all this is what happens with IRQF_ONESHOT anyway right? Each
time the IRQ is triggered it's disabled, lm8333_irq_thread() is run
and then it's enabled immediately after that. So i guess the behaviour
on each keypress is very similar to calling lm8333_irq_thread() before
registering the IRQ handler, which gives me some confidence there
might not be huge chance for deadlock under normal circumstances.

Though i wonder what would happen if some EMI burst would create rapid
train of randomly timed keypresses, that might just hit the
unfortunate sweetspot after while... Might test that later in the lab,
since i really need the software to remain operational after such
condition had passed.
