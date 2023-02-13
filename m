Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419AE69480D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBMO3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjBMO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:29:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2260B7EEE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676298494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kK42BBncE8PZ59rH1v6n9IiUvkFQ/XyA56zF53ME7Os=;
        b=TSDvXQkjm2JIBfdvlvinoc3PCFNId6qUWuGIgtOhFccRChMWVvxp32ov9xDhLZcuTIbOcf
        fUnUus/jrLef/PNOO+nc75Z1xWl8srNEpwWHOMLOl7cEadqUSXdfMJ1y8zyewzrB9yNMBX
        pEJyPWr+UZ41iNqKWnmfyqH7lbdaDzc=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-IiswtgYxMeuXl6Ga87A_pQ-1; Mon, 13 Feb 2023 09:28:13 -0500
X-MC-Unique: IiswtgYxMeuXl6Ga87A_pQ-1
Received: by mail-vk1-f199.google.com with SMTP id bb21-20020a056122221500b003e20d9fec6dso4797110vkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676298492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kK42BBncE8PZ59rH1v6n9IiUvkFQ/XyA56zF53ME7Os=;
        b=W8OD87Vm1CNbZo1ZoMnyiMp/cGeZ/7nSvFNkVVFc9uMPPu63joVt55CJBwqbN16AqM
         CNhSgsb9IuE1ocMdS3Z577+XYyjzgtSYwnZ5kCW8OeBJx++UXu993dv3pXCRcGelmyJM
         gi4DIJjJHFbyD4vqi9OmvxWHscny6Iy0dbo5UIQxwNTJNySF0WSpLKQx+RgtsuQoQFWm
         dHzqHrAsNPVhmfxeS9NSdqItP8f56xVqyv4Dtx2xz3stZyBrxQ6Grm+JVz6yIT4y3/oG
         MeI3jMC89YhNH3SEleTVKKg81c/Jdx/HpJmIHbktmc0lF87ig5ODUlUHzmLicVoF8NHM
         FJ1A==
X-Gm-Message-State: AO0yUKXbCGzPc+ig7VylAPkXZUKbIrZ0vodjhr9JEcbSi1112tnCffC/
        sKIfl0l2UZOQIlam+bCP1YYQ9KxEQBwBZITMSR2NRsaTFOx4dmFtwS/uKwH5weHpWDyMjCkxA0T
        7Iy1obIY0FbSjKc5XKQ1duJ6j+UKSc2WASjtAppEs
X-Received: by 2002:a67:ab4d:0:b0:3f9:b1bf:c0c3 with SMTP id k13-20020a67ab4d000000b003f9b1bfc0c3mr5038675vsh.66.1676298492616;
        Mon, 13 Feb 2023 06:28:12 -0800 (PST)
X-Google-Smtp-Source: AK7set/SsY53V+VLbpCXMW5aGtJJ2R4A1hJbZOgUQ2Hdncg176hFttc0MFBMVZV6AaeEpH/HV4GS7XBaZyY7CC5yvyU=
X-Received: by 2002:a67:ab4d:0:b0:3f9:b1bf:c0c3 with SMTP id
 k13-20020a67ab4d000000b003f9b1bfc0c3mr5038660vsh.66.1676298492370; Mon, 13
 Feb 2023 06:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20230210152622.92912-1-andrea.righi@canonical.com> <CANiq72=FZtNmYvbb-YPHmQ=bm8rH8VO3M9nemT4i03g9A2PD2Q@mail.gmail.com>
In-Reply-To: <CANiq72=FZtNmYvbb-YPHmQ=bm8rH8VO3M9nemT4i03g9A2PD2Q@mail.gmail.com>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 13 Feb 2023 14:27:56 +0000
Message-ID: <CAOgh=FwWzHW0bWuErn6++ngS2-JOoXnS3mB0-3hQoiFqyeda_g@mail.gmail.com>
Subject: Re: [PATCH] rust: fix regexp in scripts/is_rust_module.sh
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Martin Reboredo <yakoyoku@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 at 13:19, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Feb 10, 2023 at 4:26 PM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > nm can use "R" or "r" to show read-only data sections, but
> > scripts/is_rust_module.sh can only recognize "r", so with some versions
> > of binutils it can fail to detect if a module is a Rust module or not.
>
> Do you know which versions? If so, it would be nice to document it here.
>
> > Moreover, with this patch applied I can also relax the constraint of
> > "RUST depends on !DEBUG_INFO_BTF" and build a kernel with Rust and BTF
> > enabled at the same time (of course BTF generation is still skipped for
> > Rust modules).
>
> Even if that build succeeds, can you load the modules? i.e. the
> constraint was there due to
> https://github.com/Rust-for-Linux/linux/issues/735.
>
> Also Cc'ing Daniel, Eric and Martin since they are the ones working on this.

Don't have any issues with the change. Seems simple enough!

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

>
> Cheers,
> Miguel
>

