Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB4763CEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiK3Fkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3Fkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:40:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6FC3FB97
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:40:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E9DAB81A32
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA106C433C1;
        Wed, 30 Nov 2022 05:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669786844;
        bh=cGYM4HbWASBVByr69I639VWeErhXmhz0z9ewvew8r7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgIb9wZHfv69M9YpnGkCZ1SyfCo1JvTo2zk+8c1Mn2mzni7anbYmDHpefoYsaAhTU
         bLg5EMbL2poeol4T0EHUlRqyN9YFp3C61yCA200vKUqQeUhuGpPbVE3B5vBRM35wBG
         RCzoXevGmHQKZr1UqsQ9mSaG9SktpU/IKT5qRiNZ+s6SKUjS2nP+yXAbEJirq2MsaO
         FvwegJuzfvsT/Woutj3zyA1xP2Ebz3CWWky8ujNLQ4VFTmmbjeLDRZKtz2Am/xZK+p
         19B4CNNLwewWxQUgTN76k/CTqHJyhB33jgG7j1G4mBDVf/mz4CdbtQd/QzMpmJ53gu
         mpsUnjW8PkkFA==
Date:   Tue, 29 Nov 2022 21:40:42 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: suppress KMSAN reports in arch_within_stack_frames()
Message-ID: <Y4bs2hoG3MANYgF7@sol.localdomain>
References: <20221118172305.3321253-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118172305.3321253-1-glider@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 06:23:05PM +0100, Alexander Potapenko wrote:
> arch_within_stack_frames() performs stack walking and may confuse
> KMSAN by stepping on stale shadow values. To prevent false positive
> reports, disable KMSAN checks in this function.
> 
> This fixes KMSAN's interoperability with CONFIG_HARDENED_USERCOPY.
> 
> Link: https://github.com/google/kmsan/issues/89
> Link: https://lore.kernel.org/lkml/Y3b9AAEKp2Vr3e6O@sol.localdomain/
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  arch/x86/include/asm/thread_info.h | 5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Eric Biggers <ebiggers@google.com>

- Eric
