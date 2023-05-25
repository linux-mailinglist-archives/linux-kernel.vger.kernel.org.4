Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2784710AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbjEYLcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjEYLcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B90F191;
        Thu, 25 May 2023 04:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F907644FE;
        Thu, 25 May 2023 11:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B606C433D2;
        Thu, 25 May 2023 11:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685014329;
        bh=VG5yn04NwanfKjO6oV4SFyhVMVBXC+08ULhNZEAi/hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNIBsA5Kecihknz9JIsRewQ/BluS/1kWTkDalIqsvkS8A/kettLyAmvamRcKESvKZ
         JoP6PsXCeN2hyV3Xmu6Nu+JtXQ2Un6d02LUWbk0YmfNoF87GILE1dvm8FLoyWc/2Qa
         X+lMKHec+NuPys+uEFVx1jW42DoFj1MbdQ442SQbItJlTfw8Ka22469sHK/Cck+iwd
         rIb6s5tdobRvvp6GX8HH9vca+56BEarK5t9smvn57acwbmubZjeMJklxM23mzKJ7nw
         v3L24M24uM/qtXIIJI8dO5f5Qgzv5xY5Bxd7tMMvDFLCfzh11s4mhRC1ZvzsHPtT4x
         Win4q8BoJ/xRw==
Date:   Thu, 25 May 2023 12:32:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-hardening@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Replace all non-returning strlcpy with strscpy
Message-ID: <20230525113205.GE423913@google.com>
References: <20230523021451.2406362-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230523021451.2406362-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023, Azeem Shaikh wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/leds/flash/leds-aat1290.c |    2 +-
>  drivers/leds/led-class.c          |    2 +-
>  drivers/leds/leds-spi-byte.c      |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
