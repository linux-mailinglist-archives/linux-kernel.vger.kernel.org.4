Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12A76DCF13
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDKBRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjDKBRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:17:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC62D4B;
        Mon, 10 Apr 2023 18:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B80E06204F;
        Tue, 11 Apr 2023 01:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B335C4339B;
        Tue, 11 Apr 2023 01:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681175771;
        bh=ODaecMr+wJPSHtC8hYe20feIEPMjvcTTCHqXR7iGKOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KXMCsiDlHJK5+SPk1oi/4xjuIPdjXnTKcdYVbg59ndsgv0tvucVDno7yXIT2EFUCu
         LJ3KwwIHpNtL2PqpdiWltx+3t+KwrsrcziFXfIJqdKWO4KAYvBTLtXsFj+9nVTik1u
         payvKNIRtPowiMZYTIC1iSGh6++zh4UiwoZJzEZu3gopaM6WNPy1MtUcvJiUTM5W8m
         w0B6CrLpfoo1VfnPpx1MPv8tl5ghyX7cziVSEBgHu9grVqnvYu+cyFG5sdRVlILo5Q
         R+UDOFAwZh4O6rMODrvKQIw8DFHZXfmW0QLO6LAqOcVxax5GSssh0qHjz2tUXsLU8G
         hYsF9bl6oknWA==
Received: by mail-lj1-f179.google.com with SMTP id x31so2845194ljq.10;
        Mon, 10 Apr 2023 18:16:11 -0700 (PDT)
X-Gm-Message-State: AAQBX9eoP45pWDugYFf6A6v23Az/9EXc9TUb2TmK2mIf+BdQOMs+s9Fr
        779umArp0VCoHaU3mW4dx3t2mEwNtjXMGNO8D0I=
X-Google-Smtp-Source: AKy350Y2xfVxBP7Vu9TD/upNGfxDqae0YwlFFpdnNBgbocvqzYteiKUGsv79YBWGh99PmGynLpDCXmRXqxWVRqCa75s=
X-Received: by 2002:a2e:9d1a:0:b0:299:9de5:2f0f with SMTP id
 t26-20020a2e9d1a000000b002999de52f0fmr3371112lji.5.1681175769183; Mon, 10 Apr
 2023 18:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230410113559.1610455-1-yukuai1@huaweicloud.com> <20230410113559.1610455-2-yukuai1@huaweicloud.com>
In-Reply-To: <20230410113559.1610455-2-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 10 Apr 2023 18:15:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7rUQ9KFxCQw-iAAA64=x==b-Qu0nnp32TXn-85Okb00w@mail.gmail.com>
Message-ID: <CAPhsuW7rUQ9KFxCQw-iAAA64=x==b-Qu0nnp32TXn-85Okb00w@mail.gmail.com>
Subject: Re: [PATCH -next v5 1/6] md: pass a md_thread pointer to md_register_thread()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     logang@deltatee.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 4:37=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Prepare to protect md_thread with rcu, there are no functional changes.

Why do we need this change? To add __rcu later?

Can we do something like:

struct md_thread __rcu *md_register_thread(void (*run) (struct md_thread *)=
,
               struct mddev *mddev, const char *name)

Thanks,
Song
