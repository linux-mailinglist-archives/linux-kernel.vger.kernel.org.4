Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809E26B8328
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCMUyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCMUy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:54:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58D1EBDE;
        Mon, 13 Mar 2023 13:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5E371CE1255;
        Mon, 13 Mar 2023 20:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0729C433A0;
        Mon, 13 Mar 2023 20:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678740851;
        bh=MYQwf6KctSJtumO6fsN6jX588zERPrdiWZ6qfszos7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iBSbapGqwp8hBDUKZcR/Q9mACab2zERCWP3GJQlq8JrhyKumag7ZvUxKId2gMvJ7B
         rUYs5S7osbU8QTLTFH3pljUTCiZlVv3zCOS95eVrgzHFimjmL8lN3rcaEcJx5Wk9k8
         3O50Q9ID5GqzQKVDpPTOWUmzsjlOmlsChFF7l7Jsx6OofjtE6Qesq5mNbqt0uJ0FIp
         wADjqdbpnXQ5TVbxNDs03yJb1pcCwCQKLObdrNqif0l0ql12ujIEU3p/vqe+fittKi
         9reOUe32e2aaG4WCS2hMaO2wjdkmjfks7n1h8mFqaGervcgpmKVuCmAksrgwpoQrE/
         eN5QYtrGQVQPQ==
Received: by mail-lj1-f179.google.com with SMTP id a32so13979662ljq.1;
        Mon, 13 Mar 2023 13:54:11 -0700 (PDT)
X-Gm-Message-State: AO0yUKU/9SMIIOmdQ21qRrvRyqIz3baq75CuR+3sBtuQB4y9DJB307nB
        lvtOVDq0YAiK4REMgTtMKDvxIJ5KmXczPdYF3Ew=
X-Google-Smtp-Source: AK7set8voxXRtH8vVN1V5tbROqFwZrqKBW38Q3v0EZhY8X8NnrFii2tWlewgif51uEYXY24GXAoEJNswk44K0+EK4Xk=
X-Received: by 2002:a2e:b5a5:0:b0:295:93eb:e790 with SMTP id
 f5-20020a2eb5a5000000b0029593ebe790mr10899913ljn.5.1678740849649; Mon, 13 Mar
 2023 13:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230222041000.3341651-1-linan666@huaweicloud.com> <66c29a8a-9888-8ebc-d4cc-9cfea750a0fc@huaweicloud.com>
In-Reply-To: <66c29a8a-9888-8ebc-d4cc-9cfea750a0fc@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Mar 2023 13:53:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6w8g+1++RWy0RT5D0kfTU5X6pDy8iDttmwFwcfXRGofQ@mail.gmail.com>
Message-ID: <CAPhsuW6w8g+1++RWy0RT5D0kfTU5X6pDy8iDttmwFwcfXRGofQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] md/raid10: random bugfix
To:     Li Nan <linan666@huaweicloud.com>
Cc:     ncroxon@redhat.com, vmayatskikh@digitalocean.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, neilb@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 5:00=E2=80=AFAM Li Nan <linan666@huaweicloud.com> w=
rote:
>
> Hi,
>
> friendly ping ...
>
> Thanks,
> Nan

Sorry for the delay. Applied the set to md-next (as these are not urgent).

Thanks,
Song

>
> =E5=9C=A8 2023/2/22 12:09, linan666@huaweicloud.com =E5=86=99=E9=81=93:
> > From: Li Nan <linan122@huawei.com>
> >
> > Li Nan (2):
> >    md/raid10: fix taks hung in raid10d
> >    md/raid10: fix null-ptr-deref in raid10_sync_request
> >
> >   drivers/md/raid10.c | 26 +++++++++++++++++---------
> >   1 file changed, 17 insertions(+), 9 deletions(-)
> >
>
