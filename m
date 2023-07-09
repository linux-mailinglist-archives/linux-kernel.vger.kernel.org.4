Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5B74C4D4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 16:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjGIO5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 10:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGIO5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 10:57:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9541E1B4;
        Sun,  9 Jul 2023 07:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 065AE60B83;
        Sun,  9 Jul 2023 14:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED66C433C7;
        Sun,  9 Jul 2023 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688914574;
        bh=s/KLEUrpUPS3pZCuQPjKoUSGuWuJeNp/7nLddxJ79rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJ8gC1F5cddng7dJg4Ip4ExhBbTtaLPrv7spAw+OKkco6XZTsTv1alvqxJPLPeJE+
         GPZbHtz2ssfXahUqVEaQ0JLAMrGMmJetiTLA5iKX5kJ1L7Edf8aNv8PBLlNKBnNFTL
         p2QAZSFIVDJPgcEyZbHt4ujCv9cNIBDPwYhO2x4FlLY1mSUs9ZVkMEkSScxws+i8r5
         ur4nlhF9JtrzooSnWvcG+5d6V76hYOmnfOemy3GXqZz3+LZFsyLtoy/O8kOsDpm7oM
         GYtTThvTyu9md0EYgFIQdIbuYVQ84uRY0Hidv+zU05YMlbWAdvOvUHtY2UYrVpa5Bp
         e7ksEuXc6+HvA==
Date:   Sun, 9 Jul 2023 10:56:13 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com, amit.kachhap@arm.com,
        maz@kernel.org, anshuman.khandual@arm.com, joey.gouly@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.4 07/12] arm64: cpufeature: detect FEAT_HCX
Message-ID: <ZKrKjS7sDFxhKoJT@sashalap>
References: <20230702195057.1787686-1-sashal@kernel.org>
 <20230702195057.1787686-7-sashal@kernel.org>
 <b37a9f79-97a8-4f74-a25c-b51128fbc9bb@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b37a9f79-97a8-4f74-a25c-b51128fbc9bb@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 12:51:57PM +0100, Mark Brown wrote:
>On Sun, Jul 02, 2023 at 03:50:52PM -0400, Sasha Levin wrote:
>> From: Kristina Martsenko <kristina.martsenko@arm.com>
>>
>> [ Upstream commit b0c756fe996ac930033882ca56410639e5cad1ec ]
>>
>> Detect if the system has the new HCRX_EL2 register added in ARMv8.7/9.2,
>> so that subsequent patches can check for its presence.
>>
>> KVM currently relies on the register being present on all CPUs (or
>> none), so the kernel will panic if that is not the case. Fortunately no
>> such systems currently exist, but this can be revisited if they appear.
>> Note that the kernel will not panic if CONFIG_KVM is disabled.
>
>This is a new feature, it's not clear why we'd backport it (especially
>since it's a new feature which is a dependency for other features rather
>than something that people can use outside of the kernel)?

The second paragraph (above) suggested it should be.

-- 
Thanks,
Sasha
