Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D488F6B91E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCNLm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCNLmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:42:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BDA9B9B6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7043B818E6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ECEC433D2;
        Tue, 14 Mar 2023 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678794152;
        bh=k05QGfx1arHrwiiLHy5DHQ+oZgcbv9cY9ExDp4VPUB0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CKc6xm6By9zpQu89e22wIB1jIHNpr6scQKIlCJTDsJdE4pAe0wZphnYU1Ix+AZYuD
         o9wR8j0c9m9YKdWD3WbdzK+UcwZ/xrmF1SaomrR/tyHHO2yjU0eYihV7ISdfja93oA
         uTGYoL/AY1JMRwCRRHiTN8zGEVhqsHJhU5HdZLEsUY0PVsmgC/N6kd+xMP2HgyLfXA
         6MmQkV9bPSi6cnDCmxPZ1Ur5Xsc4nKMUMOwpx3nyw/2FR5Ftr+iDG2PyMAewdoMA9p
         EXldV8AjTLxM6USlmRiieDc2oZtreTQU7gc/NBHwpLY59TIGZI6SUFKpmSIsRzo1s6
         WNLKwW3U1z00w==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pc330-00HXd5-2O;
        Tue, 14 Mar 2023 11:42:30 +0000
MIME-Version: 1.0
Date:   Tue, 14 Mar 2023 11:42:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: Circular lockdep in kvm_reset_vcpu() ?
In-Reply-To: <ZBBUoBsfGokxiBzC@e120937-lin>
References: <f6452cdd-65ff-34b8-bab0-5c06416da5f6@arm.com>
 <Y+bnybGEkMpZzm/y@linux.dev> <ZA72c+TT9epTcvX4@e120937-lin>
 <3496a6a10b2d8693825e733b871938f5@misterjones.org>
 <ZA9pUNZPyFtLDfxC@e120937-lin> <82978ec75c0b34203dd1df693e7adf83@kernel.org>
 <ZBBUoBsfGokxiBzC@e120937-lin>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <eaf66d70305bbaf96ae6d326dc30c2f1@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: cristian.marussi@arm.com, oliver.upton@linux.dev, jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, dwmw@amazon.co.uk
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-14 11:04, Cristian Marussi wrote:
> On Tue, Mar 14, 2023 at 09:28:25AM +0000, Marc Zyngier wrote:
>> On 2023-03-13 18:20, Cristian Marussi wrote:
>> > On Mon, Mar 13, 2023 at 02:09:55PM +0000, Marc Zyngier wrote:
>> 
>> > > And -rc2 works just fine here.
>> >
>> > Thanks, I'll dig deeper what's going on un my setup.
>> 
>> Actually, you really want this patch[1] which is on its
>> way to Linus.
>> 
>> It could explain the issue you're seeing with SMP.
> 
> Hi Marc,
> 
> thanks this just solves for me on JUNO with guest SMP.
> 
> Indeed with earlycon on JUNO with SMP I was seeing, beside a lot of
> workqueue lockup that finally hanged the guest, some puzzling
> 'time-traveling' stamps that seemed to align more with the host time
> than the guest.

Yeah, my bad. Thankfully, Paolo just pulled the fix, and it should
make it into -rc3 (fingers crossed).

         M.
-- 
Jazz is not dead. It just smells funny...
