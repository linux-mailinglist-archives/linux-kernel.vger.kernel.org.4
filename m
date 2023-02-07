Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E144768E36E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBGWdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBGWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:33:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2621238B4B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:33:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B126A61320
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70521C433D2;
        Tue,  7 Feb 2023 22:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675809183;
        bh=pRMdbCPpUDgsLpUiYoKb0mWWBWHKfkLHQvPGx+ldOq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vII49AhK7i9eNITaQdC/CphaA4sDWF6OZrjsJWgLxXzOAvL3gYgYPjM7A3BU4NdNQ
         XQR8/Po1n8EPIz3ovQdeCyEbotF7NwVjtgm2SV7K1wNTwL3gR0aJJCiacZ38OGV4gw
         THVXAD0CqDV2jBOWsD0IDXc4V/37oZBuoLwWeaONcRXCmcUBLr0ip+ZqqrXM3tG/YF
         0A2mn/n9AK6nTTaQaYISAlhNYI6nzX6KRadAGM9C58UhleqiupKgcESH+grn83Tl5A
         AbPvpQATe843oO0h150TxyUrKrFr5BZke9LOayEtBzHNL/DlcGZKR6+Ca1S1OL/e38
         XbuY4NccTp0ag==
From:   SeongJae Park <sj@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] UML: define RUNTIME_DISCARD_EXIT
Date:   Tue,  7 Feb 2023 22:33:00 +0000
Message-Id: <20230207223300.74593-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207164156.537378-1-masahiroy@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Wed, 8 Feb 2023 01:41:56 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:

> With CONFIG_VIRTIO_UML=y, GNU ld < 2.36 fails to link UML vmlinux
> (w/wo CONFIG_LD_SCRIPT_STATIC).
> 
>   `.exit.text' referenced in section `.uml.exitcall.exit' of arch/um/drivers/virtio_uml.o: defined in discarded section `.exit.text' of arch/um/drivers/virtio_uml.o
>   collect2: error: ld returned 1 exit status
> 
> This fix is similar to the following commits:
> 
> - 4b9880dbf3bd ("powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT")
> - a494398bde27 ("s390: define RUNTIME_DISCARD_EXIT to fix link error
>   with GNU ld < 2.36")
> - c1c551bebf92 ("sh: define RUNTIME_DISCARD_EXIT")
> 
> Fixes: 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv")
> Reported-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: SeongJae Park <sj@kernel.org>


Thanks.
SJ

> ---
> 
>  arch/um/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/vmlinux.lds.S b/arch/um/kernel/vmlinux.lds.S
> index 16e49bfa2b42..53d719c04ba9 100644
> --- a/arch/um/kernel/vmlinux.lds.S
> +++ b/arch/um/kernel/vmlinux.lds.S
> @@ -1,4 +1,4 @@
> -
> +#define RUNTIME_DISCARD_EXIT
>  KERNEL_STACK_SIZE = 4096 * (1 << CONFIG_KERNEL_STACK_ORDER);
>  
>  #ifdef CONFIG_LD_SCRIPT_STATIC
> -- 
> 2.34.1
> 
