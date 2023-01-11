Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C9665E84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbjAKOzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbjAKOyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:54:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCB2193EE;
        Wed, 11 Jan 2023 06:54:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF4EB61D4F;
        Wed, 11 Jan 2023 14:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60016C4339C;
        Wed, 11 Jan 2023 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673448857;
        bh=5991q1wXtvebgUykJ5NYVRTE1uZrMxXzr1nAKepdlS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KPh/G+50T7UA6MM56f8kwkC7JRGti8dM8QkU7Fxa5slwTvHjNEgCot25mpm4QZ7BP
         ZBiebJftwP7lOO7l+7g9JUlFg7H37CsriodR+cmKmP3WA8anAwD0dF+LYaaRDO26p1
         OnLNrFsdAaguSc26UyRsKv6n5rvjOdI9h/kQDs7+Tkw5bjqa5w+wpiwhCnOP90YEUe
         FkKBJ74jTS+659FEb3pPjJ1FoRZki0Njj420eOTO+i2/E/Q+ID9LNtC2t/d0NzBOBx
         LU9qQQBY30RDoh7gKDyBIh6Ske1YYN3CZHHhjPZA0B0j59JTFQKeNyNZvgh4yzCXPO
         D6vi0GpD34NYg==
Received: by mail-vk1-f177.google.com with SMTP id v81so7309185vkv.5;
        Wed, 11 Jan 2023 06:54:17 -0800 (PST)
X-Gm-Message-State: AFqh2kpz9jcaAVtl/D3fxpADc2eyqBYKM5Cq4vuOm7nZrijD91fQBd7Z
        nMWGW5B2HZEEzPVeZXvw+JZ99KyUT6WGKJQn3A==
X-Google-Smtp-Source: AMrXdXuLjGWkrJgzvCsRL34zMGz/o9XODdn1icG/0kwllXKQUYcQoLyaKOC+UHWHVBhznJfC3GM3r3lDlYFHXzS35BM=
X-Received: by 2002:a1f:1e50:0:b0:3c1:1c3b:c4d9 with SMTP id
 e77-20020a1f1e50000000b003c11c3bc4d9mr9659628vke.19.1673448856184; Wed, 11
 Jan 2023 06:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20230111113018.459199-1-gregkh@linuxfoundation.org> <20230111113018.459199-2-gregkh@linuxfoundation.org>
In-Reply-To: <20230111113018.459199-2-gregkh@linuxfoundation.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 11 Jan 2023 08:54:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ4QsLym-bQGGjUpzT14MYuTE1n8BQkGn6Ey9NiFF7u7w@mail.gmail.com>
Message-ID: <CAL_JsqJ4QsLym-bQGGjUpzT14MYuTE1n8BQkGn6Ey9NiFF7u7w@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] of: device: make of_device_uevent_modalias()
 take a const device *
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Liang He <windhl@126.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Zou Wei <zou_wei@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 5:30 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> of_device_uevent_modalias() does not modify the device pointer passed to
> it, so mark it constant.  In order to properly do this, a number of
> busses need to have a modalias function added as they were attempting to
> just point to of_device_uevent_modalias instead of their bus-specific
> modalias function.  This is fine except if the prototype for a bus and
> device type modalias function diverges and then problems could happen.  To
> prevent all of that, just wrap the call to of_device_uevent_modalias()
> directly for each bus and device type individually.

Why not just put the wrapper function in the DT code instead of making
4 copies of it?

Rob
