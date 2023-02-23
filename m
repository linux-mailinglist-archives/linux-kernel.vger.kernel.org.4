Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E7B6A1117
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBWUQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBWUQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:16:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0CE301A6;
        Thu, 23 Feb 2023 12:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D75E46178A;
        Thu, 23 Feb 2023 20:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04B2C433D2;
        Thu, 23 Feb 2023 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677183367;
        bh=VKgrxDWTun0mawFhuVSbHo2yhrnEv4U6behYpbjsLYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fK6W76VXpltD0be6KDImQ4h91t+qiIKMVm34rFH/SRjn8apAV3hBiWb9pFPbnScdp
         srV4UyvnT1DTFsZtj5HsjnY53u48Bzp3IbxSRJ8KVjrCe+g/8GEWNHHZWejRCZeGOb
         5ePS2YCbMwHEYepdAVPkJhmY6rDqZHAVkLzxoP1L12sCs6jpuNHo3AaRx8BZgN0sti
         ZG7Tss3kAcGYTeL9EM9fGF6hf8xzgK9KhcdHZ3k+7dzn//1Az5A/48+ltVOZchDJsS
         91Juaer0dTUfDMbaCaHRIqyDDvxXsPmDy9FSLy0rGV4H59lLuZKr/PlkjF15CeMoBO
         vgIhebUDyj8jQ==
Date:   Thu, 23 Feb 2023 13:16:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>, kernel-dev@igalia.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: modinst: Enable multithread xz compression
Message-ID: <Y/fJhOME2OAPWILK@dev-arch.thelio-3990X>
References: <20230223001607.95523-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223001607.95523-1-andrealmeid@igalia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 09:16:07PM -0300, André Almeida wrote:
> As it's done for zstd compression, enable multithread compression for
> xz to speed up module installation.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

This seems reasonable to me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

If for some reason Masahiro does not want to take this, you could set
XZ_OPT=-T0 in your build environment, which should accomplish the same
thing.

> ---
> 
> On my setup xz is a bottleneck during module installation. Here are the
> numbers to install it in a local directory, before and after this patch:
> 
> $ time make INSTALL_MOD_PATH=/home/tonyk/codes/.kernel_deploy/ modules_install -j16
> Executed in  100.08 secs
> 
> $ time make INSTALL_MOD_PATH=/home/tonyk/codes/.kernel_deploy/ modules_install -j16
> Executed in   28.60 secs
> ---
>  scripts/Makefile.modinst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index 4815a8e32227..28dcc523d2ee 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -99,7 +99,7 @@ endif
>  quiet_cmd_gzip = GZIP    $@
>        cmd_gzip = $(KGZIP) -n -f $<
>  quiet_cmd_xz = XZ      $@
> -      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
> +      cmd_xz = $(XZ) --lzma2=dict=2MiB -f -T0 $<
>  quiet_cmd_zstd = ZSTD    $@
>        cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
>  
> -- 
> 2.39.2
> 
