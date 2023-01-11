Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDD6653F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjAKFo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjAKFow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:44:52 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF4811C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 21:44:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 09CC442165;
        Wed, 11 Jan 2023 05:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673415888; bh=ZUBDEZ3HqGVgxTGdK2mXvKaJwqs1erYRaHc5pOijmRo=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=B4p13oHISRpIZ/9Jtac7401X6Q3uOv/Kc2nrTWLIQKNwud7HuAWege3QXDhDCjgGQ
         v6dISmgIX55nDfp4jGlmL7Ovq9q8YaqfzkHmkCvNu/NRK69zzKHS+aPBl+tG262fm1
         hRvAqyZvj7UVeMq8NXKzjjrxhaKAJ+OT9TOqYpVmBYqkihlcrQ9PPXw0A9gvin2ygY
         HUOrwf+kzh9+gB9RiOu2+lVpB8we4jKasHbFRgraDowZsH1+MvOtMWkkkGkHrzGP4r
         xPxDfZfqAnkFoAkM4xCWfUnk4t5Jyqe+aeFop+hrzFRg7Wv5Waf6T/GNkMkBJv365a
         jbN4FQjnuUtFw==
Message-ID: <0e7f9ef4-6660-5842-821b-7492f7ecbc61@marcan.st>
Date:   Wed, 11 Jan 2023 14:44:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Eric Curtin <ecurtin@redhat.com>, Janne Grunau <j@jannau.net>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230111043614.27087-1-marcan@marcan.st>
 <20230111043614.27087-2-marcan@marcan.st> <20230111045402.GB15520@lst.de>
 <fc2e03ea-5404-e768-0cab-e95adcde6da7@marcan.st>
 <20230111051836.GA16576@lst.de>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/2] nvme-apple: Do not try to shut down the controller
 twice
In-Reply-To: <20230111051836.GA16576@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 14.18, Christoph Hellwig wrote:
> On Wed, Jan 11, 2023 at 02:10:42PM +0900, Hector Martin wrote:
>> OK, so the first question is who is responsible for resetting the
>> controller after a shutdown? The spec requires a reset in order to bring
>> it back up from that state. Indeed the PCIe code does an explicit
>> disable right now (though, judging by the comment, it probably wasn't
>> done with the intent of resetting after a shutdown, it just happens to
>> work for that too :))
> 
> We need to do the reset before banging the registers to make sure
> the controller is in a sane state before starting to set it up.
> 
>> Right now, apple_nvme_reset_work() tries to check for the condition of
>> an enabled controller (under the assumption that it's coming from a live
>> controller, not considering shutdown/sleep) and issue an
>> apple_nvme_disable(). However, this doesn't work when resuming because
>> at that point the firmware coprocessor is shut down, so the device isn't
>> usable (can't even get a disable command to complete properly). Perhaps
>> a better conditional here would be to check for
>> apple_rtkit_is_running(), since apple_nvme_disable() can't work otherwise.
> 
> So on a resume the controller should have previously been shutdown
> properly, and this shouldn't be an issue.  Does the apple implementation
> leave some weird state after a shut down?  In that case the resume
> callback might want to do an explicit controller disable before doing
> the reset.

The controller is *shut down* but it's not *disabled*, and the existing
code was only checking whether the controller is enabled to decide to
issue another disable.

The higher-level resume path can't do a disable since the firmware isn't
up at that point, and the subsequent reset (which is shared with other
conditions that cause a reset) is what brings the firmware back up. So
the disable has to either happen in the suspend path, or in the shared
reset path after we know the firmware is running.

A shutdown but enabled controller is in "limbo"; the only way to know
it's nonfunctional is explicitly checking the shutdown status bits.
Other than that, it looks like a live controller that plays dead. This
is documented in the spec as such.
>> Alternatively, we could just revert to the prior behavior of always
>> issuing a disable after a shutdown. We need to disable at some point to
>> come back anyway, so it might as well be done early (before we shut down
>> firmware, so it works).
> 
> So the disable before shutdown doesn't really make sense from the
> NVMe POV - the shutdown is to cleanly bring the device into a state
> where it can quickly recover.  While a disable is an abprupt shutdown,
> which can have effects on recover time, and might also use way more
> P/E cycles than nessecary.

That's only if you issue a disable *in lieu* of a shutdown (and in fact
if you do that on Apple controllers under some conditions, they crash).
Issuing a disable *after* a shutdown is required by the NVMe spec if you
want to use the controller again (and should basically do nothing at
that point, since the controller is already cleanly shut down, but it is
required to set EN to 0 such that the subsequent 0->1 transition
actually kickstarts the controller again). If you don't do that, the
controller never leaves the shutdown state (how would it know?).

To be clear, the sequence I was attempting to describe (which is what we
were doing before the patch that regressed this) was:

(on sleep)
- NVMe shutdown
- NVMe disable
- Firmware shutdown

After the firmware shutdown, we can't do anything with NVMe again until
we start firmware back up, which requires going through the reset flow.

Right now we're doing:

(on sleep)
- NVMe shutdown
- Firmware shutdown
(wakeup)
- Oops, NVMe is enabled, let's disable it! (times out due to FW being
down but failure isn't propagated)
- Firmware startup
- NVMe enable (thinks it succeeds but actually the controller is still
in the shutdown state since it was never disabled and this persists
across the firmware cycle!)
- I/O (never completes)

- Hector
