Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B436E7446E6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 08:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjGAGYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 02:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAGYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 02:24:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532022118;
        Fri, 30 Jun 2023 23:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C632A60F33;
        Sat,  1 Jul 2023 06:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A95C433C8;
        Sat,  1 Jul 2023 06:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688192661;
        bh=+2+3PAJ4QmjkEMR1Cw29bcot9gUloeq3lSVBiMtBPw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5nezvdlQrisSyM8da4gSmjw1W/zxn01PaegLh4sIIdpBuvIrapfLs6hREmCYdBjJ
         ghhtO8I+rx7Pz2++s179RsVpX1izWrFduuxjES3A4FiAM8kvGNVw/jPJEXyVboWPS2
         ls4iu5L2oJq6cYRCl/iikbMtRQP/FowvbUBcsZtCLD7E2mQrIV8dtncCY4A1397xvs
         rmVvW8LycGamz5HIE0zj6snOkYIahR76IudgtTvmG65iNT/u/FvkwkGKDCT3D9+oQr
         d9IsOviEDmsa7rfeJl4UVYUQz6e38a8AnL/QoJJc2j3EWp8r27vIEVJpSA1yNUOT/M
         cQirb0s+ChPMA==
Date:   Sat, 1 Jul 2023 08:24:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] pid: Replace struct pid 1-element array with
 flex-array
Message-ID: <20230701-umspielen-wohin-de72fcaa7bbc@brauner>
References: <20230630180418.gonna.286-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230630180418.gonna.286-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:04:22AM -0700, Kees Cook wrote:
> For pid namespaces, struct pid uses a dynamically sized array member,
> "numbers". This was implemented using the ancient 1-element fake flexible
> array, which has been deprecated for decades. Replace it with a C99
> flexible array, refactor the array size calculations to use struct_size(),
> and address elements via indexes. Note that the static initializer (which
> defines a single element) works as-is, and requires no special handling.
> 
> Without this, CONFIG_UBSAN_BOUNDS (and potentially CONFIG_FORTIFY_SOURCE)
> will trigger bounds checks when entering a pid namespace:
> https://lore.kernel.org/lkml/20230517-bushaltestelle-super-e223978c1ba6@brauner
> 
> For example: unshare --fork --pid --mount-proc readlink /proc/self
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Daniel Verkamp <dverkamp@chromium.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Jeff Xu <jeffxu@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Reported-by: syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/000000000000c6de2a05fbdecbbb@google.com/
> Acked-by: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
>  - drop pointer math to array index conversions (torvalds)
>  - use struct_size_t now that it exists (torvalds)
>  - updated commit log with reproducer example

Thanks for that. Linus already merged the other version I gave him with
his requested changes but without your struct_size_t() update. It didn't
exist when you originally sent that patch afaiu and I just realized that
it existed right now. In any case, I'm just going to send a trivial
follow-up patch switching the two places to struct_size_t().

Thanks, Kees!
