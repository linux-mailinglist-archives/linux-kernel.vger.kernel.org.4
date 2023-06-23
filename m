Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7C73BA05
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjFWOXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjFWOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:23:46 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2422107
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:23:44 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40079b6fc56so194591cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687530224; x=1690122224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyw5NvaHNf0s6qb2NNjcFKinlUQFcCOImuYYWVyo7VM=;
        b=UkyAHbsGxDfbFHlDDivnokWxXQJPR+iWsSCpbBf1DrEP4jG7s9/XtfzjFmBVrNFpTB
         l/ILwL+RDA7HJzQ+5cX1yOCZ/1uusJPYaQI7sqkfoIdBFhHBAwo3XkpMPvcC69HmpLsU
         AAgwT6ZInsmyZvnnkbqCobaYeGRMsxNUtpQLMbx7qFBaINMAs5W4trlpDrkFJh3PSgIj
         vT8YDU/RoEOImUKys1WQ9ehD/JVZw4vMyib2ANuNbGibVuBEkTRsuO+HbHM/9CXivThS
         ORbPkQBq1+aABI01/MchIPL7WC/jRr50ujpkUL1GkdpHQ6HmZ6xkOoXrSdabNfiNxLHb
         omMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530224; x=1690122224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyw5NvaHNf0s6qb2NNjcFKinlUQFcCOImuYYWVyo7VM=;
        b=T6XxCHD7SxmQ1i5EJo+QxkQTuyOhdEZhUHyjxMtZxOIF0pWbzdbVZBbui0mbYeUW5K
         eki7sjkDud5uzJ0ifd+/bznukcV7vbch94rhfqV++Mzz7Ncu757GApHTED82HcfEh3Xl
         sR/Wpq/GWZS/oWyx1zvng7TXCmus0lP5Vl1ZgBYflpgVHAkb7ZL4rqI+W4kFQn7ZxJKh
         zK2RxmemaSFa3X/O2l3B2srQSCr/f3A5/Ya+A0n//LiXcL5ugkAeVWE/mJdM4UmCFlHW
         2NMuzbetscOPtwH5HGQ9Bjx03SGe6EllYbKgby8ZFXtcGkci6FPYPj9P4SUj1y3/6Uix
         bw+Q==
X-Gm-Message-State: AC+VfDx4uK827Z2lytQad1pLjCuGjaPxevGTpFTkJ1FcKfYfI1ggk20d
        hiWx9h1hR6xoU2EjtvDMmYtcT9D6gvj02MWTU/oJjA==
X-Google-Smtp-Source: ACHHUZ7g0esSl94tqGqLlnRWrtRoFE76g7PFbvPY7sgQtz5qBSQF8CltOxcB2kFwGJk1xerdcWF862WEfhcco/VqOZU=
X-Received: by 2002:a05:622a:1991:b0:3f4:f841:df89 with SMTP id
 u17-20020a05622a199100b003f4f841df89mr139576qtc.1.1687530223788; Fri, 23 Jun
 2023 07:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230622150423.3726894-1-kyletso@google.com> <20230622150423.3726894-4-kyletso@google.com>
 <2023062345-hassle-septic-b8b4@gregkh> <CAGZ6i=3BP4ssx31roJoGL_VT=o3mq9Lj_VfZ_HSywzPOEt3v7g@mail.gmail.com>
 <CAGZ6i=1uD-baR+Tht4+D1oC7O04K4L-RDBdDLSo6gZhNqN=2rg@mail.gmail.com> <2023062327-bucked-backrest-c20d@gregkh>
In-Reply-To: <2023062327-bucked-backrest-c20d@gregkh>
From:   Kyle Tso <kyletso@google.com>
Date:   Fri, 23 Jun 2023 22:23:27 +0800
Message-ID: <CAGZ6i=2gzw59EPKQNPodt2aiNv2djyej-CV20tt+=PYc_1nLKw@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb: typec: Use sysfs_emit_at when concatenating the string
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 7:14=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Jun 23, 2023 at 06:11:00PM +0800, Kyle Tso wrote:
> > On Fri, Jun 23, 2023 at 6:06=E2=80=AFPM Kyle Tso <kyletso@google.com> w=
rote:
> > >
> > > On Fri, Jun 23, 2023 at 3:51=E2=80=AFPM Greg KH <gregkh@linuxfoundati=
on.org> wrote:
> > > >
> > > > On Thu, Jun 22, 2023 at 11:04:23PM +0800, Kyle Tso wrote:
> > > > > The buffer address used in sysfs_emit should be aligned to PAGE_S=
IZE.
> > > >
> > > > Why?  Are you getting warnings about this?
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > Yes, here is the warning.
> > >
> > > [  223.243123] invalid sysfs_emit: buf:00000000eda2d647
> > > [  223.243197] WARNING: CPU: 4 PID: 8860 at fs/sysfs/file.c:735
> > > sysfs_emit+0xb0/0xc0
> > > [  223.244335] CPU: 4 PID: 8860 Comm: cat
> > > [  223.244363] pstate: 62400005 (nZCv daif +PAN -UAO +TCO -DIT -SSBS =
BTYPE=3D--)
> > > [  223.244378] pc : sysfs_emit+0xb0/0xc0
> > > [  223.244394] lr : sysfs_emit+0xac/0xc0
> > > ...
> > > [  223.244560] Call trace:
> > > [  223.244568] sysfs_emit+0xb0/0xc0
> > > [  223.244582] select_usb_power_delivery_show+0x134/0x18c
> > > [  223.244626] dev_attr_show+0x38/0x74
> > > [  223.244654] sysfs_kf_seq_show+0xb4/0x130
> > > [  223.244668] kernfs_seq_show+0x44/0x54
> > > [  223.244683] seq_read_iter+0x158/0x4ec
> > > [  223.244727] kernfs_fop_read_iter+0x68/0x1b0
> > > [  223.244739] vfs_read+0x1d8/0x2b0
> > > [  223.244775] ksys_read+0x78/0xe8
> > >
> > > The warning comes from
> > > https://elixir.bootlin.com/linux/v6.3.9/source/fs/sysfs/file.c#L734
> > >
> > > if (WARN(!buf || offset_in_page(buf), "invalid sysfs_emit: buf:%p\n",=
 buf))
> > >         return 0;
> > >
> > > Kyle
> >
> > BTW, to print the buf address, it should use %pK ...
>
> Patches accepted :)

The patch (sysfs) has been sent to the mailing list.

Kyle
