Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411165E9FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbiIZKaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbiIZK1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:27:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA84DF2A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52B060BBF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE545C433D6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:18:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ca8kz+NX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664187506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPitCDjljE+1/cKCHIXEIuBG6dg931Jal6pxfbqJG50=;
        b=Ca8kz+NXjpnQovPaxTTBjGz8Lj06+Oq17OYzAa4a+p25uD2a9uyo3y3OqdICYJaida5sdR
        PfxENh1ciNBemkT3h0d85SJmZ0WLo4yCjIm9ZQCiNQE9371yD1lVv0BJgtGwLkuJGGhKiY
        Wze94iSACKZCJ0AM3tbWIodTA+x5B98=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id babb1141 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 10:18:26 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id bi53so3143152vkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:18:26 -0700 (PDT)
X-Gm-Message-State: ACrzQf074/7YDf4y1C8r8GjHvkzmQd8PsBBZx7Zi5gCbUB5rPslQVdEI
        ciImbz9PbUlNJ98qB4fj2c7YZDqy3tI93V5fbA8=
X-Google-Smtp-Source: AMsMyM6BZnql+7X0HEuy+6hfAj0blSq1TS/9NzbFmJG3Ns3/H3UwXMEUG4S4g07rNj25WyM63nicfTD8gT+JIWmH3is=
X-Received: by 2002:ac5:c7a6:0:b0:3a2:7f3c:8170 with SMTP id
 d6-20020ac5c7a6000000b003a27f3c8170mr8275071vkn.6.1664187506008; Mon, 26 Sep
 2022 03:18:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2ea6:0:b0:3ae:9878:9be with HTTP; Mon, 26 Sep 2022
 03:18:25 -0700 (PDT)
In-Reply-To: <CAMuHMdWT8dhre5TGjYRnEwn_jCZ6CXxvMpLmKp3KKo_CjPOXRQ@mail.gmail.com>
References: <20220923170340.4099226-1-Jason@zx2c4.com> <20220923170340.4099226-2-Jason@zx2c4.com>
 <CAMuHMdWT8dhre5TGjYRnEwn_jCZ6CXxvMpLmKp3KKo_CjPOXRQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 26 Sep 2022 12:18:25 +0200
X-Gmail-Original-Message-ID: <CAHmME9oTKp=cw9QFHOU6FKT5qSuQufO5Vo+XPELYGoaQK2fPoA@mail.gmail.com>
Message-ID: <CAHmME9oTKp=cw9QFHOU6FKT5qSuQufO5Vo+XPELYGoaQK2fPoA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] m68k: virt: generate new RNG seed on reboot
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Jason,
>
> On Fri, Sep 23, 2022 at 7:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> Rather than rebooting into a system with no entropy, regenerate the RNG
>> seed before rebooting, so that the new system has a fresh seed.
>>
>> Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Thanks for your patch!
>
> I still doubt this is actually guaranteed to work, as the memory containing
> the bootinfo might be overwritten during normal operation.

Thus far, I'm unable to make it *not* work. So this seems like
actually an improvement?

Jason
