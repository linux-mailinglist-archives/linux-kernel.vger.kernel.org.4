Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C7A6242E3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKJNIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiKJNIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:08:06 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C1C1A225
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:08:03 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id c8so1288632qvn.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMoH4oExOgGPlBDG9nVH77ZD2bYk9EKd7RsG/Ihmq0E=;
        b=KDK5MYkZSHWMEnvK7fiBfjP4zcf3g2yVUtIPEKAs74xyLSuVbENZPCgtAoczDJYF47
         5qBdY4tqu0nevNCA/kYA6Se/yG5LDX/unq4C3r5PEFQO4/qoXhiDHNUhJzVIyNlZKCNq
         p5GmW5j6VMecv2FJsjc4rt/uXJfVdgs1+/EsqOJ/XXo5sKDx5dFF63EUdB+PvE+x+umk
         fVyjBdGB4o3YGpVik8g4qLI3vQzYO0VT0L7D704LlEz3KdHQ7MJUOcz6nF7sXFSdWtIS
         lCKIe49TuAwB/3qVsNhikKsnGFJYfng70VxS+typK434HiyTmxwcmhvqvSVhCldGlldW
         d7Ww==
X-Gm-Message-State: ACrzQf3gtOErmBTUIedFfyoRmJQUCLc0UvTqZ6Frcw/ZJUaILm/2dr9g
        eWbjq7JUKm+dsU3Y/jciSoRbI+DyMmNrRh8FT7Q=
X-Google-Smtp-Source: AMsMyM5fBPX/p0pDbEKYLf1yJss9gIJdmLRGrejGDURJ1328LkxCzR3mgZbzX37sQ8TDRiJ4EGl+8PlwNYYnje5q0rI=
X-Received: by 2002:a05:6214:f63:b0:4b8:c0bc:c43e with SMTP id
 iy3-20020a0562140f6300b004b8c0bcc43emr59279158qvb.119.1668085682896; Thu, 10
 Nov 2022 05:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20221109140711.105222-1-gregkh@linuxfoundation.org>
 <CAJZ5v0gv6L9Q+Nu3U0JAWqJk4MPt7kGVGiOAKuX5FcF=znyfTA@mail.gmail.com>
 <Y2wXYxrr/qed/j//@google.com> <Y2zFtWcytaIRWNqu@kroah.com>
In-Reply-To: <Y2zFtWcytaIRWNqu@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 14:07:51 +0100
Message-ID: <CAJZ5v0jpm92CDHsH33aWNn97w5tpf-gust7ghkwdpmNbQf0ZDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver core: remove devm_device_remove_groups()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
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

On Thu, Nov 10, 2022 at 10:34 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 09, 2022 at 01:10:59PM -0800, Dmitry Torokhov wrote:
> > On Wed, Nov 09, 2022 at 03:11:47PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Nov 9, 2022 at 3:07 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > There is no in-kernel user of this function, so it is not needed anymore
> > > > and can be removed.
> > > >
> > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > For both patches in the series:
> > >
> > > Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> >
> > I find it really weird to have an asymmetric core API...
>
> I'm working on fixing up that asymmetric-ness.  We have only one user of
> devm_device_add_groups() and only a handful of devm_device_add_group()
> left in the tree.
>
> But it turns out that no one ever called these functions anyway, so they
> aren't needed even if we did keep the "add" functions.  So they should
> be dropped no matter what.

Totally agreed.
