Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4563C65CD20
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjADGcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjADGcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:32:35 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE6A14027;
        Tue,  3 Jan 2023 22:32:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nn0C04FZWz4xyt;
        Wed,  4 Jan 2023 17:32:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1672813949;
        bh=yy1Ja7/gN5t53Ult7n0CLa7oWDzh1zFh5lkAWxcgdt4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=O4NB1Mbe8U1HnIqf4kh5MjyenZwCG/UFSMjCR1YYsUv1msRBsq/cOPLS6UtlKekr1
         p6ptRIVwVzzlvJI93Ym02Oo05krdVqvgro5C0ZJsz43Szf6QgOVbpOsmHnW+gP0Gxx
         It+IIdezLasjprYmU/SNgRBa10xEHn9+NA+tiicO7+ipsJRYHocYBPmny2FkZO/+wg
         /epgOSK4vPhFgHXdUqK1IAxlZdB/yJHbn5w69kkhfDL3nd7GL2eD5P212casgM5OdH
         c43Ps7M6A84QPKdoDYHXciU+J4Ulm/M0HKxYmBvID8fagf/DOXadZyPIXS+qRVGPMN
         77iTDos8k8Exg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: Build regressions/improvements in v6.2-rc1
In-Reply-To: <CAMuHMdVX4Yz-zHvnwB0oCuLfiNAiEsSupcyjfeH+1oKTfQKC9A@mail.gmail.com>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <397291cd-4953-8b47-6021-228c9eb38361@landley.net>
 <CAMuHMdVX4Yz-zHvnwB0oCuLfiNAiEsSupcyjfeH+1oKTfQKC9A@mail.gmail.com>
Date:   Wed, 04 Jan 2023 17:32:24 +1100
Message-ID: <877cy24xon.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Hi Rob,
>
> On Sun, Jan 1, 2023 at 2:22 AM Rob Landley <rob@landley.net> wrote:
>> On 12/27/22 02:35, Geert Uytterhoeven wrote:
>> > sh4-gcc11/sh-allmodconfig (ICE = internal compiler error)
>>
>> What's your actual test config here? Because when I try make ARCH=sh
>> allmodconfig; make ARCH=sh it dies in arch/sh/kernel/cpu/sh2/setup-sh7619.c with:
>
> [re-adding the URL you deleted]
>
>> > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/830b3c68c1fb1e9176028d02ef86f3cf76aa2476/ (all 152 configs)
>
> Following to
> http://kisskb.ellerman.id.au/kisskb/target/212841/ and
> http://kisskb.ellerman.id.au/kisskb/buildresult/14854440/
> gives you a page with a link to the config.

It's possible there's something wrong with the toolchain setup, I don't
know much about sh.

But it's just the kernel.org crosstool sh4 compiler, nothing else fancy.

cheers
