Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7459C6FD70C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbjEJGdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjEJGdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:33:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AD63A93
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 23:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66B58636E8
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BE1C4339B
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683700393;
        bh=UXFt9t+VVTtxPJrYoFkVmVdKoW2R0D40aqtxsRFTN1I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NoULg+fFwhW6CKiAydI0ZgU+HDyZKKT+C9VNHTJV5cO94FizUMZXqSNdLK9RjtOMA
         JHHmg+IOfRob/wuJkUVkeDPT6x6JtQCmNls+fgTSvT8LKCUwAHi696donBaaRHVxpB
         eu1m+qkssRlt1ZYrY32dtGnsaMXLnNYvdulZwAzVp5awY8a5PA0IWV1uPm68pS+ThD
         JmgrP9jtkKfvPc8sJ/5pxZ94UtCzRrNT2Tr3Fq8BX8n/XVXx/7I/MlZvaMwqz3QsFj
         tbG+zuZyoXQ4abs9ca/F3+Qq0vgciwqeLW9Ps1I2lTduuN9YBxFqwat4H3xAdBQ/w+
         d1xkl0zvssQ4A==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ac7c59665bso76707211fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 23:33:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDwT9KHLeiGbbQoWdpwC43wxsZXbpc3UB6EO7ls5Y/rVDtTTxsC/
        M3+8twTtQwA+/J7FbFEbG02Vi8/Iw2/IrHTfxPM=
X-Google-Smtp-Source: ACHHUZ7Luzj76Dwm3bOTc94DglSsmLUJ2p1uhqMdSNnOzLqSWlGBJ0MMT/i7hxmBe4GRZaGnPQCvVE+uhxqqxELCBos=
X-Received: by 2002:a2e:3012:0:b0:2ad:1ba2:eff9 with SMTP id
 w18-20020a2e3012000000b002ad1ba2eff9mr1591572ljw.20.1683700391509; Tue, 09
 May 2023 23:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <ZFs6DNgzBHNarr6D@euler>
In-Reply-To: <ZFs6DNgzBHNarr6D@euler>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 10 May 2023 08:33:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG5+fhKA_+TMT1KfSZ0_hGZOdw5xtwuN9Y+Sev=rt97rw@mail.gmail.com>
Message-ID: <CAMj1kXG5+fhKA_+TMT1KfSZ0_hGZOdw5xtwuN9Y+Sev=rt97rw@mail.gmail.com>
Subject: Re: Kernel 6.4-rc1 ARM boot fails
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 at 08:30, Colin Foster
<colin.foster@in-advantage.com> wrote:
>
> Hi Ard,
>
> I just wanted to give a heads up. I tested 6.4-rc1 on a Beaglebone Black
> and kept getting boot hangs. A bisect led me to commit c76c6c4ecbec ("ARM:
> 9294/2: vfp: Fix broken softirq handling with instrumentation enabled").
>
> The dying message is "Run /sbin/init as init process"
>
> I'm not sure if this has already been reported. I was able to revert this
> patch and confirm things work again.
>
>
> My current kernel version with the revert is below. I can share my kconfig
> if that's needed.
>
> ```
> # uname -a
> Linux buildroot 6.4.0-rc1-00022-g6ceb2f82fe40 #1313 SMP PREEMPT Tue May  9 23:02:58 PDT 2023 armv7l GNU/Linux
> ```
>
>
> Thanks, and let me know if you need any more information from me.
>


Thanks for the report.

This should fix it:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9297/1
