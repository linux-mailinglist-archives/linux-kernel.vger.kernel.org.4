Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6562005A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiKGVGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiKGVFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:05:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1972CCA6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:05:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D7B0B816A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 21:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF39C43147
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 21:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667855110;
        bh=Zu50tGqg124bPyOMVvcoQdIculJ+KYQtsiSpZtdQVq4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AabtWJNmq1Z8Xd62qXornOCd4ZK3WhKppXVm4YynDe4++xb8YguttfBdNQXXw9utL
         ErdH/vNsCDN8KIsmTq9VxUiAtXIeQ4Ym2zOTYTesPPe8oPEIjn8k+qudKhLVrJsiCQ
         rSnVdbr93iQONLOAfi4cgOnEf/svFjIQ6d+uVIiVa2gHuhdFwrTMU5NlhLcyZuFsOJ
         M+/SaZrHlzd31Ao7huJTDQendPxB+OQUJLL6GzEmsFpt4IoDClYFHnxLljwjlPIf2M
         0bVUNEqbvngAnGlGkK4+fQ3I16nfHkCVST+31DDbyv++DM73sb/Cb8PceNxog9/lzY
         kTz3wiMBcWqfQ==
Received: by mail-yb1-f179.google.com with SMTP id e123so10839859ybh.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:05:10 -0800 (PST)
X-Gm-Message-State: ANoB5pmVAs/4KEeyFVx4qkBPY9o7+Htl7ONEM/UXIt2Lef6PFCQFhanI
        omLVCu+nLHQW896hNfeP5/EUItRkdOodtXV6vdo=
X-Google-Smtp-Source: AA0mqf4KjNwhvJXdZttzDTXzxLD0NEeHGqaOOG0YDar2hzM7Q2wpgsR23hYSEEYa6fKsS6NkPJtYHOUyqYwmtjLhNO0=
X-Received: by 2002:a25:2389:0:b0:6d8:7f81:edaf with SMTP id
 j131-20020a252389000000b006d87f81edafmr3758306ybj.443.1667855109196; Mon, 07
 Nov 2022 13:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20221106210225.2065371-1-ogabbay@kernel.org> <20221106210225.2065371-4-ogabbay@kernel.org>
 <2537e41d-f863-4819-57d2-09b9554f801b@quicinc.com>
In-Reply-To: <2537e41d-f863-4819-57d2-09b9554f801b@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 7 Nov 2022 23:04:42 +0200
X-Gmail-Original-Message-ID: <CAFCwf12h2FH_CrPKszWfFVRCfnQeavYY+sXmjk9jChbT-+WBcQ@mail.gmail.com>
Message-ID: <CAFCwf12h2FH_CrPKszWfFVRCfnQeavYY+sXmjk9jChbT-+WBcQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] drm: initialize accel framework
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
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
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 6:25 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> On 11/6/2022 2:02 PM, Oded Gabbay wrote:
>
> > @@ -603,6 +626,14 @@ static int drm_dev_init(struct drm_device *dev,
> >       /* no per-device feature limits by default */
> >       dev->driver_features = ~0u;
> >
> > +     if (drm_core_check_feature(dev, DRIVER_COMPUTE_ACCEL) &&
> > +                             (drm_core_check_feature(dev, DRIVER_RENDER) ||
> > +                             drm_core_check_feature(dev, DRIVER_MODESET))) {
>
> Shouldn't the indentation for the 2nd and 3rd line be such that the
> start of the lines is aligned with the "(" on the first line?
afaik there is no such rule. If there was, checkpatch should have reported that.
Oded
