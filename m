Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF6165AB86
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 21:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjAAUSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 15:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjAAUSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 15:18:32 -0500
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 01 Jan 2023 12:18:29 PST
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1462610;
        Sun,  1 Jan 2023 12:18:29 -0800 (PST)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 8CC8012AAA3;
        Sun,  1 Jan 2023 21:08:35 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1672603715; bh=ksrrnhlf2F6/nQN1F2t1aD2efNdtMH5VDXg092+/TCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lWWKEpvE1IQz3M64Y3wHssh+1OdQ5limQrpmCVteqTfDqdDITMriuzbgWVp3jkE9F
         NvYcCTPq4ENCixrxWwz3WDajJlIt0xiJ8FJbN45V0BvFT1VFVcy1qKybJ0YQGiHK13
         +sndgdSQOYKPQ/Qf76gM3I/IxxJX6w6hOswvOv7Xvjyfz+acWnfwlPB/TA8o+Kb78a
         1wTnWX1VNAioPK6ij1/p6fE2vUWKulo2cjsIsICOp1PoQ6Cev/mFZQOPO5/HzoYoQg
         mC6WOw1BZPk0if3z6EvaL/JO7FwywxO79gb+vDIQyDez/ysaL2mv2BA4iHaLQ0cEsk
         xBxxOfo54lF9w==
Date:   Sun, 1 Jan 2023 21:08:33 +0100
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philipp Rudo <prudo@redhat.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kexec@lists.infradead.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/3] kexec: Introduce sysctl parameters
 kexec_load_limit_*
Message-ID: <20230101210833.6878b6a4@meshulam.tesarici.cz>
In-Reply-To: <20221114-disable-kexec-reset-v5-3-1bd37caf3c75@chromium.org>
References: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
        <20221114-disable-kexec-reset-v5-3-1bd37caf3c75@chromium.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Wed, 21 Dec 2022 20:45:59 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Add two parameters to specify how many times a kexec kernel can be loaded.
> 
> The sysadmin can set different limits for kexec panic and kexec reboot
> kernels.
> 
> The value can be modified at runtime via sysctl, but only with a value
> smaller than the current one (except -1).
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 18 ++++++
>  include/linux/kexec.h                       |  2 +-
>  kernel/kexec.c                              |  4 +-
>  kernel/kexec_core.c                         | 87 ++++++++++++++++++++++++++++-
>  kernel/kexec_file.c                         | 11 ++--
>  5 files changed, 114 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 97394bd9d065..a3922dffbd47 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -461,6 +461,24 @@ allowing a system to set up (and later use) an image without it being
>  altered.
>  Generally used together with the `modules_disabled`_ sysctl.
>  
> +kexec_load_limit_panic
> +======================
> +
> +This parameter specifies a limit to the number of times the syscalls
> +``kexec_load`` and ``kexec_file_load`` can be called with a crash
> +image. It can only be set with a more restrictive value than the
> +current one.
> +
> +=  =============================================================
> +-1 Unlimited calls to kexec. This is the default setting.
> +N  Number of calls left.
> +=  =============================================================
> +
> +kexec_load_limit_reboot
> +======================
> +
> +Similar functionality as ``kexec_load_limit_panic``, but for a crash
> +image.

Is this description correct? IIUC the ``kexec_load_limit_panic`` is for
the crash image, and ``kexec_load_limit_reboot`` is for the normal
image, but the sentence above says again: "for a crash image."

Petr T
