Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5056834A5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjAaSD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjAaSDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:03:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5937EC5;
        Tue, 31 Jan 2023 10:03:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2232FB81E4E;
        Tue, 31 Jan 2023 18:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8367EC433A0;
        Tue, 31 Jan 2023 18:03:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="av409FU0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1675188192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zs0xfF0E8MYOsooiH3Yn3u/N9LwvQJIAusMEj2bJoE4=;
        b=av409FU0RYy8sJ+rPqyvnRIIaGRsw7vx5H9w54+EUdZn0Wrp7FGjAiziCtRFkmduxsibPC
        kxH4tRJs+zzE7ZP95rEvf4qdc642stISmvDxwiqqIx7N4mo0A1nhUD79OkqXzIl+YoMPLA
        bVGZj8hGIWecrthViXkFYa4ruE8auHI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83cd8b34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 31 Jan 2023 18:03:12 +0000 (UTC)
Date:   Tue, 31 Jan 2023 19:03:12 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jia He <justin.he@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Message-ID: <Y9lX4FtlOf2htnxj@zx2c4.com>
References: <20230131040355.3116-1-justin.he@arm.com>
 <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 08:18:49AM +0100, Ard Biesheuvel wrote:
> (cc Jason for awareness)
> 
> On Tue, 31 Jan 2023 at 05:04, Jia He <justin.he@arm.com> wrote:
> >
> > I met a hung task warning and then kernel was hung forever with latest
> > kernel on an Ampere Emag server.
> >
> > The root cause is kernel was hung  when invoking an efi rts call to set
> > the RandomSeed variable during the booting stage. The arch_efi_call_virt
> > call (set_variable) was never returned and then caused the hung task error.
> >
> 
> Given that EFI variables work on this platform (as far as I know), the
> problem may be that we are calling SetVariable() too early.
> 

On my phone and with very limited connectivity for another 10 days, but
I wonder if there's a later place we could move this block:

    if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
        execute_with_initialized_rng(&refresh_nv_rng_seed_nb);

Is there any additional initialization that happens after
efisubsys_init() that we're maybe missing out on there?

Jason
