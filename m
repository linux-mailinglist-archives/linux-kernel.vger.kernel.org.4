Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E120566AC9B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjANQZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjANQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:25:25 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D059019;
        Sat, 14 Jan 2023 08:25:24 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5324B374;
        Sat, 14 Jan 2023 16:25:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5324B374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673713523; bh=lXjetQxvduNoZX1DzzPlMMuJyy3ZRghkv/XFdbhFN/8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AlCIlwBWw5ipPp4ENLIzNu7yem45wANuCWr2V0IvfIksuwYSLaudiUeN1l+KytxE4
         6tJz2WqWRvx90go62ZalPqlzshtQ575WTSMRd2z9RLTFlpdiwLVOxIx4RfgExF9RcE
         zWfGWNJ7IY3LAkJCicGqZWPiQc4xZXJafGp9ZSaK5s/GxpysJudhGluF1HH9zP7UM1
         GBbIsMlMIV0Hr+rHMCu87Kqn+H71xBzhdoXqggd85oPAlqprz+1oDtd5twlXzLNSXr
         Me+SZLYmsAgWVV7f0aDZtWhLhTgoc45prHemsMf2/Rfp7UWbUAmOjXH/EYs9/7F16Z
         M9qhX/N3y24AQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
Subject: Re: [PATCH] Documentation: Avoid duplicate Kconfig inclusion
In-Reply-To: <20230114-doc-v1-1-efec2689e423@pefoley.com>
References: <20230114-doc-v1-1-efec2689e423@pefoley.com>
Date:   Sat, 14 Jan 2023 09:25:22 -0700
Message-ID: <87edrxgk25.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Foley <pefoley2@pefoley.com> writes:

> Documentation/Kconfig is already included from lib/Kconfig.debug, avoid
> including it again and polluting the top-level menu.
>
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> ---
>  Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Kconfig b/Kconfig
> index 745bc773f5670..97ed6389c9211 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -28,5 +28,3 @@ source "crypto/Kconfig"
>  source "lib/Kconfig"
>  
>  source "lib/Kconfig.debug"
> -
> -source "Documentation/Kconfig"
>

The duplicate inclusion does seem worth fixing, but I wonder if you're
deleting the right one?  Having the documentation Kconfig under lib
seems a bit strange, somehow; Documentation/ is a top-level directory,
after all.

Thanks,

jon
