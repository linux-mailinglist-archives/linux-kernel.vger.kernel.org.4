Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567456BEF00
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCQQ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQQ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:57:36 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ED7B7D8C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:57:35 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id s12so6259945qtq.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679072253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9dNM5x4oEV/eACFTwRAEYcuMGzTPuMAMyLjmcgT0x4=;
        b=Ofr/IXMxIfg0qBXEXCWDyU/2rkOwZjxElsHTzUq0uEBalUuB4qpQ6H3oWQAf4qi4TM
         3LLdQgoTZIlA64DTZK8QQZxK8ksuXsmB21qK4fqQr1Xc8Ow/OLSF7FEGs9WsMtrIUcJv
         NypDCIF8rNHtmoi33osJpz+n1G8lE8uhLdPYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679072253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9dNM5x4oEV/eACFTwRAEYcuMGzTPuMAMyLjmcgT0x4=;
        b=EzbiSJvcy7sOJFH5nncRqV6VBUvJKEk0nWGSgfs0bDud7mG0PrPh3Lj7oVM67mEbSv
         uzfWQvzjHOy6jGhyOVRPB/sN/Zp3HQe+MyUgdJp2dTN/w6ebzrSZtqx5uT4v0lkj+1FL
         Hvuqi86A4wu18QlmQhr7c6hU35M/U7msiULHCxEirDEBDmkJpwXZTBY3SYfs3AJiGbKr
         GlXS5r1xoUjtYUaOY3tN9emvXWkWp89JdM8F2VPnzRDYLVmUhQamwuH7E7kShiFQ7Xuj
         S1pIPvB2/VvR/z92/IIvuV3KRDIzfFWAJw/lIOmkCMxXSBnyRAYoeKfo44ev8/ftZiPf
         5aag==
X-Gm-Message-State: AO0yUKWPNGVMsoOBUaR4MwR92lGWwCL6ojYknc0sPrQ7UkOMjuOegvuw
        44JIkOwC9Ncy89hHzn/7slLzqtkP84m4btoZFi8=
X-Google-Smtp-Source: AK7set9gkvGcADK+t+tlWRGukAIdcSbupG8L/K1eQOkzeM554S/SBQ5W72ahqiKLljw3lkse+CRLqg==
X-Received: by 2002:ac8:5f0e:0:b0:3d7:3cf4:33f9 with SMTP id x14-20020ac85f0e000000b003d73cf433f9mr13051830qta.68.1679072253655;
        Fri, 17 Mar 2023 09:57:33 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id r14-20020ac867ce000000b003c034837d8fsm1560417qtp.33.2023.03.17.09.57.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 09:57:32 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id p203so6372460ybb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:57:31 -0700 (PDT)
X-Received: by 2002:a05:6902:707:b0:b45:5cbe:48b3 with SMTP id
 k7-20020a056902070700b00b455cbe48b3mr236008ybt.0.1679072251542; Fri, 17 Mar
 2023 09:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230315010732.633992-1-saravanak@google.com> <ZBR1WHPpcrOMFwVe@kroah.com>
In-Reply-To: <ZBR1WHPpcrOMFwVe@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Mar 2023 09:57:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUe194BqM42QhZzxQ1M1uDmVbeya34p7shEGjTr2C1SQ@mail.gmail.com>
Message-ID: <CAD=FV=XUe194BqM42QhZzxQ1M1uDmVbeya34p7shEGjTr2C1SQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 17, 2023 at 7:12=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 14, 2023 at 06:07:31PM -0700, Saravana Kannan wrote:
> > Add a build time equivalent of fw_devlink.sync_state=3Dtimeout so that
> > board specific kernels could enable it and not have to deal with settin=
g
> > or cluttering the kernel commandline.
> >
> > Cc: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/Kconfig | 12 ++++++++++++
> >  drivers/base/core.c  |  5 +++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 6f04b831a5c0..aac247512d69 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -230,4 +230,16 @@ config GENERIC_ARCH_NUMA
> >         Enable support for generic NUMA implementation. Currently, RISC=
-V
> >         and ARM64 use it.
> >
> > +config FW_DEVLINK_SYNC_STATE_TIMEOUT
> > +     bool
> > +     help
> > +       This is build time equivalent of adding kernel command line par=
ameter
> > +       "fw_devlink.sync_state=3Dtimeout". Give up waiting on consumers=
 and
> > +       call sync_state() on any devices that haven't yet received thei=
r
> > +       sync_state() calls after deferred_probe_timeout has expired or =
by
> > +       late_initcall() if !CONFIG_MODULES. You should almost always wa=
nt to
> > +       select N here unless you have already successfully tested with =
the
> > +       command line option on every system/board your kernel is expect=
ed to
> > +       work on.
>
> As nothing can actually select this, it doesn't make sense to add this
> now, right?  We need a user, otherwise the automated tools will come
> along and remove this option when they figure out that it can't be ever
> used.

I think the hope was that it could be setup as a config that would
show up as user selectable (like in menuconfig). Saravana: the problem
is your bare "bool" above. That should be changed to a description
shown to the user. Like maybe you'd want to change that to:

  bool "sync_state behavior defaults to timeout instead of strict"

-Doug
