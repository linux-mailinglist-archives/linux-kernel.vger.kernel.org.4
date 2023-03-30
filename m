Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A486D059B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjC3M77 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 08:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjC3M7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:59:48 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220259EE7;
        Thu, 30 Mar 2023 05:59:43 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h9so19514916ljq.2;
        Thu, 30 Mar 2023 05:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680181180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGoTpAkzvPXZTogVoj8kdq2GxGxpgvtqWQ8RuMpPxVo=;
        b=KKyOlNAEflmYpHiQc6XuVmm/RTk0kRUjRqufi+EDudYI2OAYYPZ88FLphjs2cU7zm3
         t0+PkGc5Z+2bwkZn7hNb2H7K5P0gpHcImyrOGoSOWNBeWcIUpFCRSONOE5tXfZxiEK1G
         4XSl7GN4AJIVbXzjJw/hsSfe/ogGgoWo2S3MauXsNma+NAOKdeZfKV6PvIStQPyb7Etp
         p9Ow3OUtFLt8gwjrXncf2UD2+mz0I8LcJ54VReTe84HTxMPUOi2ZIxkyooFO1lePWC+f
         Gk3ZYPVGAGJIH/4apc4m2yaVVa+Kg1HWLumuYkuytebrffFwEnBhvVZHOBByI91Yvuts
         rCGg==
X-Gm-Message-State: AAQBX9fkv+3c98e8+yYEbqk5XEqQZzQKVLv4JoZT57UDwcjHbfPO0Ska
        JyOymwbX02MZbU2HQ6zTuJYH4fFVbI8UcUxY
X-Google-Smtp-Source: AKy350b5FEvUkeqbiPIF8q//VsLTZrSk/T6ulAPE9F8UaeGFJXwsUgS3FscdDnrnH/qsurtrosxsRQ==
X-Received: by 2002:a2e:9e98:0:b0:29c:d0ef:481c with SMTP id f24-20020a2e9e98000000b0029cd0ef481cmr7029567ljk.28.1680181180446;
        Thu, 30 Mar 2023 05:59:40 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id c1-20020a2e6801000000b002a421ac8629sm2514124lja.49.2023.03.30.05.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 05:59:38 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id q14so19488939ljm.11;
        Thu, 30 Mar 2023 05:59:38 -0700 (PDT)
X-Received: by 2002:a2e:b60d:0:b0:299:ac4e:a8a6 with SMTP id
 r13-20020a2eb60d000000b00299ac4ea8a6mr7200190ljn.9.1680181178291; Thu, 30 Mar
 2023 05:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230327205228.573456-1-robh@kernel.org>
In-Reply-To: <20230327205228.573456-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Mar 2023 14:59:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX742MrnXhYJUSRqXnG_ctzcH0ee=og_6-7K=62yFLaDQ@mail.gmail.com>
Message-ID: <CAMuHMdX742MrnXhYJUSRqXnG_ctzcH0ee=og_6-7K=62yFLaDQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: sh-mobile: Use of_cpu_node_to_id() to read CPU
 node 'reg'
To:     Rob Herring <robh@kernel.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Mar 27, 2023 at 10:52 PM Rob Herring <robh@kernel.org> wrote:
> Replace open coded CPU nodes reading of "reg" and translation to logical
> ID with of_cpu_node_to_id().
>
> The original code called of_parse_phandle() CONFIG_NR_CPUS times
> regardless of the length of 'cpus'. Optimize the loop to bail out once
> of_parse_phandle() fails as the end of 'cpus' property has been reached.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Optimize the number of loop iterations

Thanks for the update!

I have tested this on:
  - R-Car H2: 4xCA15 + 4xCA7, booted from either CA15 or CA7,
  - R-Car M2-W: 2xCA15,
  - R-Car E2: 2xCA7.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
