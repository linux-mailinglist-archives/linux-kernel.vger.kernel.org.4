Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715E061FB58
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiKGR2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiKGR2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:28:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29ED201A1;
        Mon,  7 Nov 2022 09:28:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54441B81604;
        Mon,  7 Nov 2022 17:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE54C4347C;
        Mon,  7 Nov 2022 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667842112;
        bh=Ru6g7W+wGFDyyGJ07Lb68mzCziUt9sT/p5kpehRvmf4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hTf35uVaJ2NdmjJ8BWwrFAe2/tLvd5jRUPvkU0hON8duYnS/0ZWP1IlEeraN/hcuM
         u+0X/fH+3ltrDDABl4/EYi7LJgy8N8c+gIKPFDqsnhX4qp8j4xhMUaU+menuLrWXnP
         OkM9S8l0KE13RlQlZXAo+w3mpJdA+hvZc3+QHJ7D6CPS923CMQxZpw1NMgIjHFBeuD
         0GyGn7qI8FBXvrFTfvz2dy4l/4CFNCWePVwTYhC/5JP1JUDWasBzNR6RWqBR/Z1mkm
         aI3gbuDPBe6aS1AKJUPgYzPj75/9kYB9JWbDZtSB/LaFz4PKBfgQWkqN1pjQN6zFN4
         fwyeWsfZuEYMg==
Received: by mail-lj1-f169.google.com with SMTP id a15so17354768ljb.7;
        Mon, 07 Nov 2022 09:28:31 -0800 (PST)
X-Gm-Message-State: ACrzQf1rTmKHMeet56AKZCvRHmPduYAlQf9cnPt1bIl3iqUn4AotL3de
        FunZp3KmxfTFrdeDgl0v3qm8ZDzz4TaMbjfmrg==
X-Google-Smtp-Source: AMsMyM56CwqhbDHoNYw/xSS5SL73ZpDv4aJh+BZ8cTn0HT/LY9v1kXK7/idR1JlSohpk7P1qdU2lOBBpHwqwMMFihXM=
X-Received: by 2002:a05:651c:114a:b0:25d:5ae6:42a4 with SMTP id
 h10-20020a05651c114a00b0025d5ae642a4mr17881311ljo.255.1667842109994; Mon, 07
 Nov 2022 09:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20221105014613.113503-1-Jason@zx2c4.com>
In-Reply-To: <20221105014613.113503-1-Jason@zx2c4.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 7 Nov 2022 11:28:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKA1_HV5V17mHkKn8X72c_UN2Jg=TYtJkt93YM6SSDMSg@mail.gmail.com>
Message-ID: <CAL_JsqKA1_HV5V17mHkKn8X72c_UN2Jg=TYtJkt93YM6SSDMSg@mail.gmail.com>
Subject: Re: [PATCH] of: fdt: parse early params before adding bootloader randomness
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Fri, Nov 4, 2022 at 8:46 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> FDT is examined so early that it's before the first incidental call to
> parse_early_param(). This is similar to EFI, except EFI actually added
> an explicitly call to parse_early_param(). Let's do the same here, so
> that specifying `random.trust_bootloader=0` is not ignored.
>
> Fixes: d97c68d178fb ("random: treat bootloader trust toggle the same way as cpu trust toggle")
> Cc: Rob Herring <robh@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/of/fdt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 7b571a631639..6d959117fd4f 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1195,6 +1195,9 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>
>         rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>         if (rng_seed && l > 0) {
> +               /* Parse random.trust_bootloader if it's in command line. */
> +               parse_early_param();

I don't think it's good that the timing of calling this is dependent
on "rng-seed" being present or not. So perhaps move it up to after the
cmdline is set.

Either way, the other issue is the cmdline is not necessarily fixed at
this point with some architectures doing their own
append/prepend/override of the cmdline. We can't seem to get common
implementation there finished. I'm doubtful that corner case would
actually be hit though.

Rob
