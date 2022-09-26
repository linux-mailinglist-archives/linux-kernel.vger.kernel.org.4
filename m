Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0735E9E98
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbiIZKGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiIZKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:06:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A979399F1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0F2760B4A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E15C433D7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:06:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="McsYbKM2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664186769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MTbDAGtdQOyjwr3VuUNM3DoGtToFj5T4CqFl3/zr8u0=;
        b=McsYbKM28gBwvCorerQPM9GQ49ewfnPnXPOfKLQFHihpyhA85IwdjB/VbjDY9+dSfJ/jNo
        UWsoHoBoDByVcefWTwb+yK9mhm47uRv/fK49jmMVeCBACNV4/ebMUSBd1SSUD9vV5H1A0F
        RCwrT8a4Rb7UtVLmNh7q30+tHq6jrCM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 897955d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 10:06:08 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id p4so5992658vsa.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:06:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf1NGCoFP4ySg5oGe9X7MErIqJNalPjEdEgb9QYCMKakw55xDLzX
        +pcJXzHG2na7d93XNKxfZrvGav4VYpBZwTkiRik=
X-Google-Smtp-Source: AMsMyM79BUdnq28YnmRh8VHtHeqr2C1KNXc8JZxpkzJmj5FiEtY+ce7Ei0cxHbTNZscwCnmz+gQTxvmuwRVAW+qgjlo=
X-Received: by 2002:a05:6102:2908:b0:398:ac40:d352 with SMTP id
 cz8-20020a056102290800b00398ac40d352mr6526004vsb.55.1664186767749; Mon, 26
 Sep 2022 03:06:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2ea6:0:b0:3ae:9878:9be with HTTP; Mon, 26 Sep 2022
 03:06:07 -0700 (PDT)
In-Reply-To: <CAMuHMdVJoocGUugnhv=pbgu7z6MFexmRGH1JkQCjm9g-=HiowQ@mail.gmail.com>
References: <20220923170340.4099226-1-Jason@zx2c4.com> <CAMuHMdVJoocGUugnhv=pbgu7z6MFexmRGH1JkQCjm9g-=HiowQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 26 Sep 2022 12:06:07 +0200
X-Gmail-Original-Message-ID: <CAHmME9qnsaUq4PvXM-BW63B=gvgzR3gV6zszEy2VFgzCx=B=wQ@mail.gmail.com>
Message-ID: <CAHmME9qnsaUq4PvXM-BW63B=gvgzR3gV6zszEy2VFgzCx=B=wQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] m68k: process bootinfo records before saving them
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

Hi Geert,

On 9/26/22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Sep 23, 2022 at 7:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> The RNG seed boot record is memzeroed after processing, in order to
>> preserve forward secrecy. By saving the bootinfo for procfs prior to
>> that, forward secrecy is violated, since it becomes possible to recover
>> past states. So, save the bootinfo block only after first processing
>> them.
>>
>> Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for the review.

Did you intend to take these 3 patches through your m68k tree, or did
you want me to take them for some reason instead?

Jason
