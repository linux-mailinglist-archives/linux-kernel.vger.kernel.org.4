Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEEE748860
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjGEPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjGEPuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEE11728
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9056F615F8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 15:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CC6C433C8;
        Wed,  5 Jul 2023 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688572200;
        bh=LKIw2C4zLdq/arYohsNFX5l44L3BXGn1ZG9+kkvZW5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rEzT6KVm4TjVa+PkpwzsjqzovOD8U11GjzMofQOI+l7tZttDYkjFJHKgUDWemaJpD
         Zxa1xpb1rAL9HXuUoTOeF/8yma5F+R6tP/6W2KctPtJ0ROyfx+UdRCHkr8Q3gyTF8Z
         8ZQ1dZfKPNFsntZksx0mZhdXMTFiia2x1khpcGIFUZx0W9Jqkyzm3//hui+N6kDYRh
         GfcDjukmIZPVY86mNQhoeKAhCtXRdWRwLZeQuSViAwtP/FdjNcMeNzTRMr4Z2HaRdG
         Aj5GhKRYxgQFBEe7FBrDuu5DI01SXOe0KEuvaYU14+2W1Dhlah4GwOJSAbI+Zj/Ffj
         x02WaUUycubBw==
Date:   Wed, 5 Jul 2023 08:49:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Breno Leitao <leitao@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, tj@kernel.org,
        Dave Jones <davej@codemonkey.org.uk>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <20230705084958.1c4854eb@kernel.org>
In-Reply-To: <20230705082604.7b104a48@hermes.local>
References: <20230703154155.3460313-1-leitao@debian.org>
        <20230703113410.6352411d@hermes.local>
        <ZKQ3o6byAaJfxHK+@gmail.com>
        <20230704085800.38f05b56@hermes.local>
        <ZKU1Sy7dk8yESm4d@gmail.com>
        <20230705082604.7b104a48@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 08:26:04 -0700 Stephen Hemminger wrote:
> On Wed, 5 Jul 2023 02:18:03 -0700
> Breno Leitao <leitao@debian.org> wrote:
> 
> > The uname is useful if the receiver side is looking (grepping) for
> > specific messages (warnings, oops, etc) affecting specific kernel
> > versions. If the uname is not available, the receiver needs to read boot
> > message and keep a map for source IP to kernel version. This is far from
> > ideal at a hyperscale level.  
> 
> At hyperscale you need a real collector (not just netcat) that can consult
> the VM database to based on IP and record the meta data there.  If you allow
> random updates and versions, things get out of control real fast and this
> won't really help much

VM world is simpler because the orchestrator knows exactly what it's
launching each time. Bare metal is more complicated, especially
with modern automation designs where the DBs may contain _intended_
state, and local host agent performs actions to bring the machine
into the intended state.

Not to mention that there may be multiple kernels at play (provisioning
flow, bootloader / EFI, prod, kdump etc.)

As a kernel dev I do like the 100% certainty as to which kernel version
was running at the time of the problem.
