Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEEE5F0353
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 05:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiI3D3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiI3D3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 23:29:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B815935A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 20:29:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 9so3115500pfz.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0zaardMzdo84BBvC7uLDBzbOjA8ewhAN7uNbK6h7JYY=;
        b=hak1ujvX5jTWm1bp22t3vvMvyrJfC7KVeR+wnUfTiMT/TkDO2//7l09Hqsrq3dso+U
         r/+vNueM2Jfq6sqqvs6Q0UUY+2JHVC6SmHAX/Oiml7SwCWEVZq+BJ6sjJ1m+ev0VMIml
         +FkWG/9yBijRNE1zf8r/C6Uye4TU/KsXFoCnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0zaardMzdo84BBvC7uLDBzbOjA8ewhAN7uNbK6h7JYY=;
        b=WFNh7mxykKBD7OyujVMW/o8uMUUzX9iKQ2igv+76ogkUwVV9d4seYRkcRdJYDKurph
         zMtCw9o46LgFdO5N7vUbegQWa5XZ6OdGQ3ieVwLIvcMwcsBlVnj1fUJV93DaZPPfQEAm
         F2GXj0GZ8xvXnwp/oH1+twMlWhFwCO/OYXvA2HD89kxn1jK3/w7Pd89v5WReYdzQ6Q+H
         6CQ/NZ/Oie1eiM2UDkaetZbyVKYpdpWWH1OVjidsA2q0K7fyQAb8XyTM4bmWGo3jSaoS
         eANGQI2KYjijrAABPpHhpmA27+qZxRN277p+TUbetHZkRqANfEiR8cg0vUxGFdMMI0Qh
         vNUA==
X-Gm-Message-State: ACrzQf2sEVoxJBj0Bwi4nGdUph8bc5Wly59rljSXBpnw/4U+DC7bTNf1
        OokrUhqLTD507zErKZBtaoPbwg==
X-Google-Smtp-Source: AMsMyM4JXfjw5J0pg8BvozxvbT4YFf0amxr8UZn56f9CUF33dNGBam37Az8ZM+1h5fm9QIVf1YKPhQ==
X-Received: by 2002:a05:6a00:22cf:b0:545:90f3:8b96 with SMTP id f15-20020a056a0022cf00b0054590f38b96mr7040659pfj.58.1664508554280;
        Thu, 29 Sep 2022 20:29:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nn10-20020a17090b38ca00b0020669c8bd87sm224328pjb.36.2022.09.29.20.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 20:29:13 -0700 (PDT)
Date:   Thu, 29 Sep 2022 20:29:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [REGRESSION][PATCH] Revert "pstore: migrate to crypto acomp
 interface"
Message-ID: <202209291951.134BE2409@keescook>
References: <20220929215515.276486-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929215515.276486-1-gpiccoli@igalia.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 06:55:15PM -0300, Guilherme G. Piccoli wrote:
> This reverts commit e4f0a7ec586b7644107839f5394fb685cf1aadcc.
> 
> When using this new interface, both efi_pstore and ramoops
> backends are unable to properly decompress dmesg if using
> zstd, lz4 and lzo algorithms (and maybe more). It does succeed
> with deflate though.

Hi!

Thanks for looking at this. I wasn't able to reproduce the problem,
initially. Booting with pstore.backend=ramoops pstore.compress=zstd and
writing to /dev/pmsg0, after a reboot I'm able to read it back.

> The message observed in the kernel log is:
> 
> [2.328828] pstore: crypto_acomp_decompress failed, ret = -22!

Hmm, that's EINVAL.

> The pstore infrastructure is able to collect the dmesg with
> both backends tested, but since decompression fails it's
> unreadable. With this revert everything is back to normal.
> 
> Fixes: e4f0a7ec586b ("pstore: migrate to crypto acomp interface")
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

A reminder to myself, I keep getting surprised that systemd is
stealing the pstore filesystem contents and moving them into
/var/lib/systemd/pstore/

> Hi Ard, Thorsten and pstore maintainers. I've found this yday
> during pstore development - it was "hidden" since I was using
> deflate. Tried some fixes (I plan to submit a cast fix for a
> long-term issue later), but nothing I tried fixed this.

What's your setup for this? I'm using emulated NVDIMM through qemu for
a ramoops backend. But trying this with the EFI backend (booting
undef EFI with pstore.backend=efi), I _do_ see the problem. That's
weird... I suspect there's some back interaction with buffer size
differences between ramoops and EFI & deflate and zstd.

And I can confirm EFI+zstd with the acomp change reverted fixes it.

Ard, anything jump to mind for you?

> So, I thought in sending this revert - feel free to ignore it if
> anybody comes with a proper fix for the async compress interface
> proposed by Ard. The idea of the revert is because the 6.0-rc
> cycle is nearly over, and would be nice to avoid introducing
> this regression.
> 
> Also, I searched some mailing list discussions / submission of
> the patch ("pstore: migrate to crypto acomp interface"), but
> couldn't find it - can any of you point it to me in case it's
> in some archive?

Hm, it's possible this was just sent directly to me? If that's true, I
apologize for not re-posting it to lkml. I suspect I didn't notice at
the time that it wasn't CCed to a list.

> Thanks in advance, and sorry for reporting this so late in the
> cycle, I wish I'd found it before.

No worries! Whatever the case, there's always -stable updates. :)

-Kees

-- 
Kees Cook
