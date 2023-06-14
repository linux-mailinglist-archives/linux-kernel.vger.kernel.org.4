Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA672F8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243975AbjFNJPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244038AbjFNJO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE7B1FE2;
        Wed, 14 Jun 2023 02:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01642636FA;
        Wed, 14 Jun 2023 09:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AD5C433C0;
        Wed, 14 Jun 2023 09:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686734092;
        bh=ktKsxwyCzGMiOE7Itoa6Qrkzgf2zcOZjEs7n5abIRvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNipdY7bUCwd5RVt4RwtD9G+NXmTtHIoX9Ze7xAs4LnYsyfeLgG1n8EOqrHTqwAM6
         iNe/Ptd4L8MhBbLGO8iuHewE7VdB1EPmtlaKAwPIgcInb7qZZNeh7yPT+Sruj6rcLx
         13KYcMDQyyfxD5F7QxsIXdVli3zfj5lGjPCejkOU=
Date:   Wed, 14 Jun 2023 11:14:49 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc:     bigeasy@linutronix.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, luizcap@amazon.com,
        abuehaze@amazon.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Observing RCU stalls in kernel 5.4/5.10/5.15/6.1 stable trees
Message-ID: <2023061428-compacter-economic-b648@gregkh>
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

Oops, missed this.

Yes, there might be, can you do 'git bisect' and track down the patch
that fixed this?

thanks,

greg k-h
