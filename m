Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55337617DEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiKCN3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiKCN3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:29:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A700C95B8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 505E2B827CF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF807C4314C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667482168;
        bh=nYB3RB+AjUVoOwO1yDeiaVxLJ0D31WZD8FZbQ8TSmNg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QOPPXS5e0ASzWMACM+JrTIUGNfwGgYeUpV2IfcynlwdO1Alh3NqgCfsKgpRhz1MxT
         JN7Y9INd2skjnLQ0U9lrhtuZW5hpKWHwfbsBja3qs4tQTfwcRaP8p4W3uvE4wsUzA2
         o/+fVXncBf3Pm14dlBjgXWDBqHJXEYGEc0eQJKpatc9kFrdYBpQm/fzEm2Fk+4LChf
         j1th2ZNWsyh5NwENjUXSIsRNt4fk2Q6t/h7nL5bge4s7O6kFrCd+BiR7+ZrvY+mCRB
         NEKF8v5MjAg6oNfdWORbh1YSjCMw5H0BGcfLzEui0RZuZwpd55BekhGivAuFApSJWM
         XOgvOG3kiFEWA==
Received: by mail-yb1-f177.google.com with SMTP id 187so2228227ybe.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:29:27 -0700 (PDT)
X-Gm-Message-State: ACrzQf3iY31eZA+LnS6CQChDbQAijrgLs9BhUqqpGuDmHSicvjQp0FJy
        i2weIBHr2Hl25aOcsfPeEQXGksHHHerH4bx3wU4=
X-Google-Smtp-Source: AMsMyM7CWMX1wMsAxUqb0LEcvpP3bRnpLq13T6TY1U2hkCREcb5k3XiZQu0BvoxlFgSmAdWpotlBz2+3ZEC4sjb0Ik0=
X-Received: by 2002:a25:1e89:0:b0:6bf:9e55:5cb4 with SMTP id
 e131-20020a251e89000000b006bf9e555cb4mr29629923ybe.642.1667482166923; Thu, 03
 Nov 2022 06:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221102203405.1797491-1-ogabbay@kernel.org> <20221102203405.1797491-2-ogabbay@kernel.org>
 <e526752f-94e4-335b-6164-ed7597b75a53@infradead.org>
In-Reply-To: <e526752f-94e4-335b-6164-ed7597b75a53@infradead.org>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 3 Nov 2022 15:29:00 +0200
X-Gmail-Original-Message-ID: <CAFCwf12OSuUWP8pgO3CpPBDoCY2-1_-PmS10HxLJn7oGVDM-xw@mail.gmail.com>
Message-ID: <CAFCwf12OSuUWP8pgO3CpPBDoCY2-1_-PmS10HxLJn7oGVDM-xw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] drivers/accel: define kconfig and register a
 new major
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 12:58 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 11/2/22 13:34, Oded Gabbay wrote:
> > diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
> > new file mode 100644
> > index 000000000000..282ea24f90c5
> > --- /dev/null
> > +++ b/drivers/accel/Kconfig
> > @@ -0,0 +1,24 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Compute Acceleration device configuration
> > +#
> > +# This framework provides support for compute acceleration devices, such
> > +# as, but not limited to, Machine-Learning and Deep-Learning acceleration
> > +# devices
> > +#
> > +menuconfig ACCEL
> > +     tristate "Compute Acceleration Framework"
> > +     depends on DRM
> > +     help
> > +       Framework for device drivers of compute acceleration devices, such
> > +       as, but not limited to, Machine-Learning and Deep-Learning
> > +       acceleration devices.
> > +       If you say Y here, you need to select the module that's right for
> > +       your acceleration device from the list below.
> > +       This framework is integrated with the DRM subsystem as compute
> > +       accelerators and GPUs share a lot in common and can use almost the
> > +       same infrastructure code.
> > +       Having said that, acceleration devices will have a different
> > +       major number than GPUs, and will be exposed to user-space using
> > +       different device files, called accel/accel* (in /dev, sysfs
> > +       and debugfs)
>
> Please add a period at the end of the help text.
>
> +         and debugfs).
sure, thx.
Oded
>
> --
> ~Randy
