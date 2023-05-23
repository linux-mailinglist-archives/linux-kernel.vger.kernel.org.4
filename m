Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031CE70E4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbjEWSpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbjEWSo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FC3119;
        Tue, 23 May 2023 11:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35ED7635B7;
        Tue, 23 May 2023 18:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EADC4339C;
        Tue, 23 May 2023 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684867495;
        bh=oLZLX7e9OttPtAve4YYCJFG+jnA4VanrsKclXw7yNkM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lsmKxCE6LwMrHrZRHCjQesAciu3ljZwjYypnnyjuj1BE2CXshiCbynBv8oROmGfRw
         0SHgh1kvY1VS0XgLcgQKtfIF3CfQIXiRCA4xe1tIm774bNGaTA2UWzBJXFiTso2GH4
         t2IQ0dqwqHq3ogXgjQB4wvVCUK/Ns08Qx3ww5TNPvC1BnrxnwA4RgMDR275ayp5nbz
         oE7O05bvUKff49LPsug6jjvsAmrskpJU62Q45MsYUxYoxY/N7rJedZrc1Wp74KEZhZ
         3JS/Q/8QqXKWpScAFX8g+/rMr28cfRwbherCdd1+KT+FW3DqkacncSe3iluhE6/gK7
         mL6VBhpI3nv+Q==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2af28303127so1809881fa.3;
        Tue, 23 May 2023 11:44:55 -0700 (PDT)
X-Gm-Message-State: AC+VfDzeBTxr2Wzvm0XPnbJwmWZLBnXyhQU/4g7Kr1NRnjRe/vWNc5b0
        PydhkM31kv51z/9XeXlLVjYx2mBVA2M8teK4DHY=
X-Google-Smtp-Source: ACHHUZ5ZdThj7MNe+igeJ7r2C4bJ4efWtXig1nEUpiZwtxjROBDD1dRtFqFNs1KREpoq2mqyDK+ZxVYfV8tF2Ku0Rfg=
X-Received: by 2002:a2e:9185:0:b0:2ad:d422:f334 with SMTP id
 f5-20020a2e9185000000b002add422f334mr5228281ljg.17.1684867493480; Tue, 23 May
 2023 11:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230522115449.2203939-1-linan666@huaweicloud.com>
In-Reply-To: <20230522115449.2203939-1-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 23 May 2023 11:44:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW72GX2BrSmacuK9V2sD3V5DqL4AA_1datAbwNTYKm=LGg@mail.gmail.com>
Message-ID: <CAPhsuW72GX2BrSmacuK9V2sD3V5DqL4AA_1datAbwNTYKm=LGg@mail.gmail.com>
Subject: Re: [PATCH 0/3] raid10 bugfix
To:     linan666@huaweicloud.com
Cc:     shli@fb.com, allenpeng@synology.com, alexwu@synology.com,
        bingjingc@synology.com, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 4:56=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> Li Nan (3):
>   md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request
>   md/raid10: fix incorrect done of recovery
>   md/raid10: fix io loss while replacement replace rdev

Please address feedback and send v2.

Thanks,
Song
