Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872466327A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiKUPQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiKUPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:15:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FEA317F8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71E17B8108C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C90C43149
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669043496;
        bh=o8vQ0S39k7Gj51hmVKNLSHiZmlt+sn5K6a5TuQg0XPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Or6iQ7EmF30qrf38wid0/iaPYyBoIl7UU3TG4ChfoTwi8sNafEYFjU/d7Yz99mdQA
         GL+tIfN2uWB76P6YyLD4Nv52ky3IBHWPPj5nBvHDEN7SEAjrrz685Q4Io6OBPi6f1Q
         m9QLe0lKrq5XAkKIUmapYeDX+13VTGHHzwgJ7ISpCql/vCuUwpTsnSWCjM4GZYbUB1
         AmF363w/sAjobfOiu2EOp5STp5MwgdpSMD0Q8Rf82HCQCzyWFFXk1x4Y12+RZHK2AC
         UQExql9RQy+PAYBlV4riyuSMK8tNYMxpW4GmVfoiPDorsp+3mw2IbeGJaPoX90Lq6J
         3b9IBvb3S5Bag==
Received: by mail-yb1-f177.google.com with SMTP id e68so13928177ybh.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:11:36 -0800 (PST)
X-Gm-Message-State: ANoB5pkJKI1wwSjd2cvcFKpwIO9ytdrR+gbTH1DgXux3sjrA+SAqy4Ok
        /+7zjcrNrfoabtqcwTLvQiMARyn+JHlwWlKv7KI=
X-Google-Smtp-Source: AA0mqf7cdecOiA15F+REOVFF5mHrpn7dsxpol5esLQE1lNOtTaM+cvW5Grl2jp9Q3ptMJevFZJmUphRiNCr9cWWEapI=
X-Received: by 2002:a25:b53:0:b0:6e7:3a0a:d9a with SMTP id 80-20020a250b53000000b006e73a0a0d9amr8869401ybl.197.1669043494933;
 Mon, 21 Nov 2022 07:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20221119204435.97113-1-ogabbay@kernel.org> <CAPM=9twtQry6S=+Gy2NiUDzX8vrkqHgxCNm8o9UDK8oHtNUZSw@mail.gmail.com>
In-Reply-To: <CAPM=9twtQry6S=+Gy2NiUDzX8vrkqHgxCNm8o9UDK8oHtNUZSw@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 21 Nov 2022 17:11:08 +0200
X-Gmail-Original-Message-ID: <CAFCwf13Vk8KebheQ6b0Dp0EXjyQEnkUk3mEXyrfDW0Opwfeqbg@mail.gmail.com>
Message-ID: <CAFCwf13Vk8KebheQ6b0Dp0EXjyQEnkUk3mEXyrfDW0Opwfeqbg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] new subsystem for compute accelerator devices
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Christopher Friedt <chrisfriedt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 8:26 AM Dave Airlie <airlied@gmail.com> wrote:
>
> On Sun, 20 Nov 2022 at 06:44, Oded Gabbay <ogabbay@kernel.org> wrote:
> >
> > This is the fourth (and hopefully last) version of the patch-set to add the
> > new subsystem for compute accelerators. I removed the RFC headline as
> > I believe it is now ready for merging.
> >
> > Compare to v3, this patch-set contains one additional patch that adds
> > documentation regarding the accel subsystem. I hope it's good enough for
> > this stage. In addition, there were few very minor fixes according to
> > comments received on v3.
> >
> > The patches are in the following repo:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v4
> >
> > As in v3, The HEAD of that branch is a commit adding a dummy driver that
> > registers an accel device using the new framework. This can be served
> > as a simple reference.
> >
>
> FIx the nits Jeffery raised and the one I brought up and I think we
> should be good for this to be in a PR.
>
> Reviewed-by: Dave Airlie <airlied@redhat.com>
Sure, np.
Oded
