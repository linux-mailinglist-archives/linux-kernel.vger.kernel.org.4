Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348615FF527
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJNVTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJNVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:19:17 -0400
X-Greylist: delayed 518 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Oct 2022 14:19:10 PDT
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647D71D29AC;
        Fri, 14 Oct 2022 14:19:09 -0700 (PDT)
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 1A24F1E668;
        Fri, 14 Oct 2022 17:10:31 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id B8C27A7F96; Fri, 14 Oct 2022 17:10:30 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25417.53318.731340.683540@quad.stoffel.home>
Date:   Fri, 14 Oct 2022 17:10:30 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Song Liu <song@kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, jonathan.derrick@solidigm.com,
        jonathanx.sk.derrick@intel.com,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Bitmap percentage flushing
In-Reply-To: <20221013224151.300-1-jonathan.derrick@linux.dev>
References: <20221013224151.300-1-jonathan.derrick@linux.dev>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jonathan" == Jonathan Derrick <jonathan.derrick@linux.dev> writes:

> This introduces a percentage-flushing mechanism that works in-tandem to the
> mdadm delay timer. The percentage argument is based on the number of chunks
> dirty (rather than percentage), due to large drives requiring smaller and
> smaller percentages (eg, 32TB drives-> 1% is 320GB).

I've been reading and re-reading this and I still don't understand
what you're saying here.  You say you're adding a percentage based
mechanism, but then you say it's based on chunk counts, not
percentages.  I think you need to clean this up and re-word it.

Maybe you're trying to say that you only take a percentage of the
available write bandwidth per second or something like that? 


> This set hopes to provide a way to make the bitmap flushing more consistent. It
> was observed that a synchronous, random write qd1 workload, could make bitmap
> writes easily become almost half of the I/O. And in similar workloads with
> different timing, it was several minutes between bitmap updates. This is too
> inconsistent to be reliable.

> This first and second patches adds the flush_threshold parameter. The default
> value of 0 defines the default behavior: unplugging immediately just as before.
> With a flush-threshold value of 1, it becomes more consistent and paranoid,
> flushing on nearly every I/O, leading to a 40% or greater situation. From

What situation?  Please be more clear here.  

> there, the flush_threshold can be defined higher for those situations where
> power loss is rare and full resync can be tolerated.

> The third patch converts the daemon worker to an actual timer. This makes it
> more consistent and removes some ugly code.

> Jonathan Derrick (3):
>   md/bitmap: Add chunk-threshold unplugging
>   md/bitmap: Add sysfs interface for flush threshold
>   md/bitmap: Convert daemon_work to proper timer

>  Documentation/admin-guide/md.rst |  5 ++
>  drivers/md/md-bitmap.c           | 98 +++++++++++++++++++++++++-------
>  drivers/md/md-bitmap.h           |  4 +-
>  drivers/md/md.c                  |  9 ++-
>  drivers/md/md.h                  |  2 +
>  5 files changed, 93 insertions(+), 25 deletions(-)

> -- 
> 2.31.1

