Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F20661FFA5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiKGUiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKGUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:38:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DB29C8C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:38:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E846AB81619
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 20:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143AEC433D6;
        Mon,  7 Nov 2022 20:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667853524;
        bh=2CPeClRuc5C9p5rm4iumA7wQInldkQ1fN+K3/RZZesM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAIeExdHegxfdgJSayGo6D/Q+PPibAbSVVQuB7DO5w4yz0/Ieds2NQtsSUhqA9cHD
         yhy3jU8YxYU65hSo79MF75cMQgW3tsMVbI/biqZLPWyUvWA8lSTAjKbx++1gNk9QOR
         7y4EaXlBiFa8LU/VsulpFus6kPlVM1vzE5wDrleFkYlvXU8BVuKwwEUB+qaIgdE7I2
         YvKKR1jWZnfEnoVYNAPXezR+TOXlC/s8y69s9BulCTnP+PQPdLUy2J1IbElLmaZCz5
         7hQfSEUOdnfQqapvYpSHutpsLvooOu7mEBgkW3u0RXqIUZDIQm0pAMrlVbG9DCwnQT
         Ws7apDDtTG5mw==
Date:   Mon, 7 Nov 2022 12:38:42 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>
Subject: Re: [PATCH v2] arm64: Enable data independent timing (DIT) in the
 kernel
Message-ID: <Y2ls0vS+ZsW4iL3N@sol.localdomain>
References: <20221107172400.1851434-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107172400.1851434-1-ardb@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:24:00PM +0100, Ard Biesheuvel wrote:
[...]
> 
> Currently, we have no idea whether or not running privileged code with
> DIT disabled on a CPU that implements support for it may result in a
> side channel that exposes privileged data to unprivileged user space
> processes, so let's be cautious and just enable DIT while running in the
> kernel if supported by all CPUs.
[...]
> 
> - tweak the commit log so that it doesn't read as if we are fixing an
>   actual vulnerability

I think the above undersells this a bit, as crypto code often relies on
instructions being constant-time to prevent leakage of secrets outside the
system itself.  For example, consider WireGuard, which includes network
attackers in its threat model.  So it's not just about attacks from userspace
processes on the same system.

The patch itself looks good to me though -- thanks!

- Eric
