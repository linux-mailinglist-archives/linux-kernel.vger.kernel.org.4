Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD6472F8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243288AbjFNJOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243910AbjFNJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4E619A;
        Wed, 14 Jun 2023 02:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8567563C4C;
        Wed, 14 Jun 2023 09:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F35C433C0;
        Wed, 14 Jun 2023 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686734057;
        bh=kym+UrHXeS/jGQkJSw6IV+Zo6cNmCGpWRmArDg8e61M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbPlxrlV7qjglzs33359c6Wx2qZbEirYt4joYcDwoDrLPq0IHyP/N+6QzcJ1Zw/lF
         KkGKBKmGmdg6oNS/iiVw+jgagITmAN9ca4Wu1y+4SkT5vv+gpTzMiQuP1NxqszO4Xo
         2432Yp+OOc7lDWhrkWU8ls0P225SfekTO/im4c2s=
Date:   Wed, 14 Jun 2023 11:14:14 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc:     bigeasy@linutronix.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, luizcap@amazon.com,
        abuehaze@amazon.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Observing RCU stalls in kernel 5.4/5.10/5.15/6.1 stable trees
Message-ID: <2023061457-king-broadcast-f47e@gregkh>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
 <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:58:05AM -0700, Bhatnagar, Rishabh wrote:
> 
> On 6/13/23 11:49 AM, Bhatnagar, Rishabh wrote:
> > Hi Sebastian/Greg
> > 
> > We are seeing RCU stall warnings from recent stable tree updates:
> > 5.4.243, 5.10.180, 5.15.113, 6.1.31 onwards.
> > This is seen in the upstream stable trees without any downstream patches.
> > 
> > The issue is seen few minutes after booting without any workload.
> > We launch hundred's of virtual instances and this shows up in 1-2
> > instances, so its hard to reproduce.
> > Attaching a few stack traces below.
> > 
> > The issue can be seen on virtual and baremetal instances.
> > Another interesting point is we only see this on x86 based instances.
> > We also did test this on linux-mainline but were not able to reproduce
> > the issue.
> > So maybe there's a fixup or related commit that has gone in?
> > 
> > We tried bisecting the stable trees and found that after reverting the
> > below commit we couldn't reproduce this in any of the kernels
> > consistently.
> > 
> > tick/common: Align tick period with the HZ tick. [ Upstream commit
> > e9523a0d81899361214d118ad60ef76f0e92f71d ]
> > 
> > 
> > Not exactly sure how this commit is affecting all stable kernels.
> > Can you take a look at this issue and share your insight?

Does this issue also show up in 6.3.y and in 6.4-rc5?

thanks,

greg k-h
