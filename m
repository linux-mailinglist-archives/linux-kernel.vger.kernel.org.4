Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2A1694B95
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBMPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjBMPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:48:13 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBAF1C5B4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:48:10 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E5D1F3F12A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676303286;
        bh=LS3uJV4RoNcYDITLeaGCVTEoPkqiwpzZCjKSsb4C24g=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=QCxmrpKFEffpsLiIukGsOirx4xadDvWiBBOgTTjdY2v1Jq+HsB6qFmf0eIQinwJh8
         aojGKsT4KoVPWnYWMkPiKyS/TkNQyxUhwedoPpvVuTtCBAxL+qH21A5tdEZEhZ+gtA
         3sQXOzMQ/rStx31oZbh99cGyymavXBzogdS9ZB8jN/kv2pS4CVbwBsvjp+O/WWrHP3
         yqf9TO+VbwfVXUVkvDVMFP+CCeiy+b3JetijbOIUPxJ07vQ8EqkIr34wgJvuJnvKgv
         hIhUfP7g+L6ia7WiA1VRb/MLfX3Ip/We6pBl8lNrwx33Nt0pf2DzOCJYGiIuRTpNQM
         A9KdJKTYp++Gw==
Received: by mail-ej1-f72.google.com with SMTP id qa17-20020a170907869100b0088ea39742c8so7897912ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LS3uJV4RoNcYDITLeaGCVTEoPkqiwpzZCjKSsb4C24g=;
        b=CoPTarr6M0yOB5PA0GazyzEJe1JTndYGljX7Iuyhmho1a0/ec4B6CMBcJn6aLc2Aum
         ejqJaV4yZ5fW37aS7yLF69MZDqQsbzcY0r2hiCgk/+YR4oTymUNR7+4/sDSwVbu7ogHo
         J9v2rk6VVsV2wmG3UjyQsUaFl6hyDB7ZRbakWB61GRYzDBWGxObJEmMPtpNBaypGF9bY
         sqnAc4QIn1J1p4hUeU9MTR6r8MGwLV+L5Qztml4XnqcOvFFGkJanq7QP7zw0EwvhGGau
         omaKyRqImmG9Vo0/sqeL1ntzIwKHhXXXwuMPeHl3zgGlllzhLYsv9GYExCHANowBA/DI
         ZFfQ==
X-Gm-Message-State: AO0yUKWgydVFEP8JArOrbgdWnUdXNME/8JGlCs3XM1YFICblZr5nRGNK
        ckB734OF20NUgsq0lqjVlKoXGdWUT8mr8gIz3iaN7JqLT+JRPbF/R6CWLQ8gCp5OHrJp/rdSLH5
        RQQBLU6jNoIakMRaFadq1OqKoD9/RlZCUX8bXSA5G7A==
X-Received: by 2002:a17:907:6d1b:b0:8b1:fc:d737 with SMTP id sa27-20020a1709076d1b00b008b100fcd737mr8167201ejc.19.1676303286399;
        Mon, 13 Feb 2023 07:48:06 -0800 (PST)
X-Google-Smtp-Source: AK7set/8BhyNgYyInCWuLKLaLzmUGYSgc92oXYQypaK3rCWpKmw3G4blSiKEz6pJhZv18iTKl9fY/Q==
X-Received: by 2002:a17:907:6d1b:b0:8b1:fc:d737 with SMTP id sa27-20020a1709076d1b00b008b100fcd737mr8167180ejc.19.1676303286144;
        Mon, 13 Feb 2023 07:48:06 -0800 (PST)
Received: from localhost (host-87-7-128-191.retail.telecomitalia.it. [87.7.128.191])
        by smtp.gmail.com with ESMTPSA id kq15-20020a170906abcf00b0086ffe8a00fdsm6928135ejb.84.2023.02.13.07.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:48:05 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:48:05 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     miguel.ojeda.sandonis@gmail.com, alex.gaynor@gmail.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dxu@dxuuu.xyz,
        ecurtin@redhat.com, gary@garyguo.net, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Subject: Re: [PATCH] rust: fix regexp in scripts/is_rust_module.sh
Message-ID: <Y+pbtZUaRM+gkOUC@righiandr-XPS-13-7390>
References: <'CANiq72=FZtNmYvbb-YPHmQ=bm8rH8VO3M9nemT4i03g9A2PD2Q@mail.gmail.com'>
 <20230213151339.661225-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213151339.661225-1-yakoyoku@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:13:39PM -0300, Martin Rodriguez Reboredo wrote:
> On Mon, Feb 13, 2023 at 1:19 PM Miguel Ojeda <ojeda@kernel.org> wrote:
> > On Fri, Feb 10, 2023 at 4:26 PM Andrea Righi <andrea.righi@canonical.com> wrote:
> > >
> > > nm can use "R" or "r" to show read-only data sections, but
> > > scripts/is_rust_module.sh can only recognize "r", so with some versions
> > > of binutils it can fail to detect if a module is a Rust module or not.
> >
> > Do you know which versions? If so, it would be nice to document it here.
> >
> > > Moreover, with this patch applied I can also relax the constraint of
> > > "RUST depends on !DEBUG_INFO_BTF" and build a kernel with Rust and BTF
> > > enabled at the same time (of course BTF generation is still skipped for
> > > Rust modules).
> >
> > Even if that build succeeds, can you load the modules? i.e. the
> > constraint was there due to
> > https://github.com/Rust-for-Linux/linux/issues/735.
> 
> Issue was that the kernel couldn't even load C modules, Rust CUs must be
> skipped in vmlinux for it to work, and because of that the constraint
> !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE [1] cannot be relaxed until
> version 1.24+ of Pahole is the minimum requirement by the kernel. I'm OK
> with this change but keep in mind that it won't remedy that condition.
> 
> Link: https://lore.kernel.org/bpf/20230111152050.559334-1-yakoyoku@gmail.com/ [1]

Oh yes, I'm using pahole 1.24, that's probably why it's all working for
me. So we can't just drop !DEBUG_INFO_BTF, but we can definitely relax
the constraint to "!DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE".

-Andrea
