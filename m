Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B4E674B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjATEoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjATEoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:44:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFABFF42;
        Thu, 19 Jan 2023 20:39:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9CD6B82540;
        Thu, 19 Jan 2023 15:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800D6C433F2;
        Thu, 19 Jan 2023 15:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674141501;
        bh=JcHAprxViTW27LiN8vECaU2CDGOIsbYEXbyr3dIH3Pg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MQJbriCTVVBLobWOhIwXqh595aJQQN0hw412H4Da3v44pBPrIKIGK6Aws+uGa5R+d
         LyHGdwE3FIHfEOncXp/VSo9THXfVa6ycdf0/MoEJFrdUsH0p4AliCE8BklwoPcNIj7
         VnL03ATDnyXBGwICKebR7m3f+JRB+BHhSR6UloYVAv7r9tJilqZOuHwj0vX07jZRcx
         glOWzBBMQpztIXqYLEC1ONxR+nEV1JabYcQhovw6y3bB31OHQEb63GSxMP/Cu+wMBK
         YKIc9AmKnu58V6UOL7rKZ2rFM1oT9PmuGGYb1YdDLvWvD694jyjNa1r4+5rhRKxa6C
         IPJ9535BJ65eg==
Received: by mail-vs1-f47.google.com with SMTP id l125so2489624vsc.2;
        Thu, 19 Jan 2023 07:18:21 -0800 (PST)
X-Gm-Message-State: AFqh2koa+uGnxxFPYLUobOVekp6zrjxVizPjV9A4ju9NsDYJsHcyx8AG
        0vV4ekWRvYorEDSOIjYhs/e5XKQy6skT/YWUpQ==
X-Google-Smtp-Source: AMrXdXvkUacgq+O0G+DNQxSt4Q01vk5Rv0h4bouueIFI45ImsXgVxNixuhePotF+178agY5GuSDYnJJrey3NDEoWHXs=
X-Received: by 2002:a67:eb86:0:b0:3b1:4b76:5b44 with SMTP id
 e6-20020a67eb86000000b003b14b765b44mr1479061vso.53.1674141500420; Thu, 19 Jan
 2023 07:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20230118215045.5551-1-msuchanek@suse.de> <20230119095323.4659-1-msuchanek@suse.de>
In-Reply-To: <20230119095323.4659-1-msuchanek@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 Jan 2023 09:18:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL-0Mi_QgNnZS4UNheKhOUx8uYZWG58EK7kRGFk7QW0iA@mail.gmail.com>
Message-ID: <CAL_JsqL-0Mi_QgNnZS4UNheKhOUx8uYZWG58EK7kRGFk7QW0iA@mail.gmail.com>
Subject: Re: [PATCH v2] of: Fix of platform build on powerpc due to bad of
 disaply code
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     "Erhard F." <erhard_f@mailbox.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 3:53 AM Michal Suchanek <msuchanek@suse.de> wrote:
>
> The commit 2d681d6a23a1 ("of: Make of framebuffer devices unique")
> breaks build because of wrong argument to snprintf. That certainly
> avoids the runtime error but is not the intended outcome.
>
> Also use standard device name format of-display.N for all created
> devices.
>
> Fixes: 2d681d6a23a1 ("of: Make of framebuffer devices unique")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2: Update the device name format
> ---
>  drivers/of/platform.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

As this is the only fix I have queued, if you respin, send the
original fix with fixes squashed.

Rob
