Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0622633A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiKVKqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiKVKpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:45:21 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8583710B6F;
        Tue, 22 Nov 2022 02:41:51 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id g10so9905164qkl.6;
        Tue, 22 Nov 2022 02:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4bBwFpw/JtzmjBWlLagA7Fmkmm3Jz+aY8iRdpUiYzs=;
        b=X6PMK4u4eXCjU/YfQVm9pP91PijwZoJ4zDv8Wv1uU9DoId+yqGVSRgE18+O9V65ze+
         HYXB9zP46uN/VZqXCie+bz2vlB4P2W2jNNG4kJgdmGMR3RP1IumA+F4Qp9zctLu5CSIB
         tDHBVucXfoFhrzBm8vAYRJ+dBe9EZVlHJDGHKs+/Ear54z1NuIzOeW8DFwL4mXuobQ50
         K9a1EQl8Y2pzk63YS8Js68WBQWxkRiXPdRvTlf38LwAvTEXy/rXtpN/hvnxX9OfRTIhR
         4ifJ69tENom0B+439LHZnZtg4eZbBDESZexnexEE3ODiIP47SLEGy3/GRUV+wSz6oY0I
         H6/A==
X-Gm-Message-State: ANoB5pkRBk8Kt16ZkPza+Y+mewubIBhww83dgw8n85aBuNhWHWocphUj
        PKK0ZH2WORbB6xM+6QX0SUZcq9iapAJ7Jg==
X-Google-Smtp-Source: AA0mqf5JowMB+iZdEP388QDHqPxgMJIBgafjFTYD3xOomsm0bwOhnTkeX60yzimKPLbYh02F+COb1A==
X-Received: by 2002:a05:620a:22ab:b0:6fa:9fb8:c50b with SMTP id p11-20020a05620a22ab00b006fa9fb8c50bmr20048859qkh.48.1669113710144;
        Tue, 22 Nov 2022 02:41:50 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x13-20020a05620a448d00b006fa4ac86bfbsm9848357qkp.55.2022.11.22.02.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 02:41:49 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id j196so865619ybj.2;
        Tue, 22 Nov 2022 02:41:49 -0800 (PST)
X-Received: by 2002:a25:8249:0:b0:6dd:b521:a8f2 with SMTP id
 d9-20020a258249000000b006ddb521a8f2mr2650165ybn.380.1669113709053; Tue, 22
 Nov 2022 02:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20221122183833.6509537e@canb.auug.org.au>
In-Reply-To: <20221122183833.6509537e@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Nov 2022 11:41:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-vHH5b_Qg6-CyB4kRhHaHN=HW=FeRkJ85EM7jL41Egw@mail.gmail.com>
Message-ID: <CAMuHMdX-vHH5b_Qg6-CyB4kRhHaHN=HW=FeRkJ85EM7jL41Egw@mail.gmail.com>
Subject: dlm build failure (was: Re: linux-next: Tree for Nov 22)
To:     Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Christine Caulfield <ccaulfie@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 8:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Merging dlm/next (dbb751ffab0b fs: dlm: parallelize lowcomms socket handling)

noreply@ellerman.id.au reported a build failure for e.g. m68k/defconfig[1]:

    ERROR: modpost: "lockdep_is_held" [fs/dlm/dlm.ko] undefined!

which I have bisected to this commit.  The corresponding patch does not seem
to have been posted for public review to any mailing list archived by lore.

[1] http://kisskb.ellerman.id.au/kisskb/buildresult/14835766/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
