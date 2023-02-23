Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CB36A0C02
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjBWOkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjBWOkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:40:08 -0500
X-Greylist: delayed 360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 06:40:06 PST
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE7C57093;
        Thu, 23 Feb 2023 06:40:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABD2ADAD33;
        Thu, 23 Feb 2023 15:33:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1677162842; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=gSBnOAKSlwYgZRq5lZL+i93DmKNx4vzN6Q9wkUn3Q5k=;
        b=gxFRh++8hGnMi3A97kGudlj0tNF002PWwqVliQqG+Q9Fu5eYM3Q6h9ylLfDKxWUJw8/Hh9
        cAW2HKc1eBrrD8N6ANprgekyaRnJXQSIrYMUEM5857MQ6chxe5+hne57xRvTItGUPWc10c
        /tbNx0rlrHDiulWdrVq+XE2m8t3ezPnHJ+6wrGsMqteAyWxnLkaQx/jn+z5vVsKH/Hqmp0
        O10wu8pAx+JsvPdeqv7SwqezScqxAMNYrRnYBmk/A8s4Zak/C6/hOXmuTm71xgq9zPewqw
        xjcXCPVK8dYsvH1MfmrcwDohKjvgSk1oBB+Q4ytmsxN3LRBeIIVGOicJ1T+haA==
Date:   Thu, 23 Feb 2023 15:33:56 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Florian Bezdeka <florian.bezdeka@siemens.com>
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [ANNOUNCE] 5.10.162-rt79
Message-ID: <20230223143356.fa6tqrflmhrcqx33@carbon.lan>
References: <Y9KOvZH61omPpn/3@uudg.org>
 <2ad9f8a7528818b9509f62278b42e5bc6d210054.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad9f8a7528818b9509f62278b42e5bc6d210054.camel@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Thu, Jan 26, 2023 at 06:41:27PM +0100, Florian Bezdeka wrote:
> From the CIP projects perspective we would like to improve the
> situation.
> 
> From my perspective the following could be done:
> 
>   - Instead of (or in addition to) building and testing released -rt
>     branches enable testing of -rt release candidates
>   - Make sure the build results get back to the maintainers
> 
> I'm not sure if every -rt branch has a -rc branch. I'm not familiar
> with the -rt release process yet.

The process so far is, that every stable maintainer updates his tree (merges the
stable tree) and does a local build and local tests. Usually when merging latest
upstream stable release there are no or little fallouts. When the maintainer is
happy he does the release by pushing the changes to the usptream branch. The
release candiates come only into play when there is something the maintainer is
not sure how to handle or -rt patches are backported which need some more eyes
to look on. That means Sebastian's approval :)

IIRC, I did give a presentation on the workflow some time ago...

https://lpc.events/event/4/contributions/293/attachments/237/416/maintaining-out-of-tree-patches-over-the-long-term.pdf
https://www.youtube.com/watch?v=2ab4Knwlmo4

When we started with this process kernelci didn't build these branches but that
is long time ago.

Personally, I don't mind doing an official -rc for every release and getting
some additional builds and tests run by kernelci.

Though just piping the results back is the easy thing, the time consuming task
is to fix those problems. Do you plan to help out here?

Thanks,
Daniel
