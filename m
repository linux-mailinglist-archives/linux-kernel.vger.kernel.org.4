Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA8C6B8EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCNJ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCNJ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610C43867A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF3E8616D4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46161C433D2;
        Tue, 14 Mar 2023 09:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678786108;
        bh=4Wq+DimwJRCWsYXNLxJIg3GulKjYDMChn3aYr3G0Boc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jjnV93wj9esKa9LllQg9W+Q5AnVH7HDe4ay4KSETMVhXECN+3FTxPW54X1JrxQo47
         nK0yPXaWDnBLAN29CJRsZjiLzwtnxBuUmLwRE063aZ3kiF7CZFtW9N7wFhQQ9//2gC
         5cmPcQhEZ97LcHqJqpOKdFvcwUtWCziFIEKyC+YAFPGtTpQfc29Gt7rIP2HmIb3CX8
         AVR5h+jsrVzx0xygLQWERsffByc1T/5QXCpxy4EPUM1xS6OoWhrgPURqFzr0Dw756w
         2AoPm3vnf5CDSeV3jQqzgpI1QA9ZHRVDSTD4wZvtroVoWcLw2weAUiYoJ/6kLvtj5c
         HUdTvGTD0hBtg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pc0xF-00HVTC-Tw;
        Tue, 14 Mar 2023 09:28:26 +0000
MIME-Version: 1.0
Date:   Tue, 14 Mar 2023 09:28:25 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: Circular lockdep in kvm_reset_vcpu() ?
In-Reply-To: <ZA9pUNZPyFtLDfxC@e120937-lin>
References: <f6452cdd-65ff-34b8-bab0-5c06416da5f6@arm.com>
 <Y+bnybGEkMpZzm/y@linux.dev> <ZA72c+TT9epTcvX4@e120937-lin>
 <3496a6a10b2d8693825e733b871938f5@misterjones.org>
 <ZA9pUNZPyFtLDfxC@e120937-lin>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <82978ec75c0b34203dd1df693e7adf83@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: cristian.marussi@arm.com, oliver.upton@linux.dev, jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, dwmw@amazon.co.uk
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-13 18:20, Cristian Marussi wrote:
> On Mon, Mar 13, 2023 at 02:09:55PM +0000, Marc Zyngier wrote:

>> And -rc2 works just fine here.
> 
> Thanks, I'll dig deeper what's going on un my setup.

Actually, you really want this patch[1] which is on its
way to Linus.

It could explain the issue you're seeing with SMP.

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/commit/?h=fixes&id=47053904e18282af4525a02e3e0f519f014fc7f9
-- 
Jazz is not dead. It just smells funny...
