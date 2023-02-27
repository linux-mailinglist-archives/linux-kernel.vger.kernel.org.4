Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C96A4636
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjB0PkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB0PkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:40:24 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B861E5FB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:40:23 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r40so4472049oiw.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CyTB/8yjHEGeVb5eYubYQqNDzW1fdOoIcMGH96ABpv4=;
        b=oI9zcZYjxrQqI5sYOaUtqe/5zhMZErmABdHSldC6FrXKdAHLIc51dMDe5gV3uHW+Sj
         WduVlXX2H1y0qnMrwVnxVOL79HAsX+q/8PqyZmSxC3+q7tzpSAdM6VvzBN8SwQ1x7DMV
         IYzXTUyH7EroFrtoQC45sSNzp7yFQDODcKIMPCKQMKXnkZtC3eohfaP5y3+hME4QLIUA
         zx9gWufCFU8QRWqia6+SjTJSW+nLIgw2Z164GAbcHI3Q9e1UmOTnGU1/R86td0RUWYe8
         yFfrdDSXHf/vtV5Q2HbH0bMJ0ssqfaOizzn0u6O7K12fvzRYES8no82mhajBy8V7g6gC
         oYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyTB/8yjHEGeVb5eYubYQqNDzW1fdOoIcMGH96ABpv4=;
        b=NOBYb+izfeMo47YSjyjiyHq1XDjbsCc002GRs0L+4YXPwGAXDHMXdaOGceWFqsuxlX
         tSLni2KVPxDWMqZFf5Z445t1GwSx3TxWaFANF8X7FVDRuv/z672OGTVbjnuGFUxNrYmx
         f255FPpVNfD2Qpva+Q1spIZB/kSzrsnFAEJJ0uTx0MX3biO2SHBMyPUf2TbeKNeaw9dy
         BpY3m1UTgNSoXtpqXFPC+v2OGKQghH8s00VEXSYq1uCVAtMmQ3n0KcgoPIW6ZXZXO9XE
         FhQJo73sHMpDWWsD4PM/eCZWr2LEQTN9HN7Xw/b99VJYl2wx7xXY95dxuojklHcD9Dqm
         Eznw==
X-Gm-Message-State: AO0yUKViHuDoz5zMi6Pxc2MOXlRn5WI8XLzdH9HS16IrOO02lMVpQ09W
        9q7CQiR7+D7ca77hEnFGMo08GAi/GAKHunB9ibM=
X-Google-Smtp-Source: AK7set+WPiN+PMC33D7dGKvMOq4tjpD5BANv/fOXy/omKUC1JZ4GUk6hlHvST2Ba9zIlMFuhIdoN5PtweesP99tGF+U=
X-Received: by 2002:a05:6808:486:b0:384:23ed:1ff6 with SMTP id
 z6-20020a056808048600b0038423ed1ff6mr1448259oid.3.1677512422552; Mon, 27 Feb
 2023 07:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20230224180225.2477641-1-robdclark@gmail.com> <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
In-Reply-To: <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 27 Feb 2023 07:40:11 -0800
Message-ID: <CAF6AEGsv1G7CPSkCPe3iHGB9JEO4iy+bTbkFLoitmx64U78RJw@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Add option to disable KMS support
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
        Ryan Neph <ryanneph@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 10:38 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Feb 24, 2023 at 10:02:24AM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add a build option to disable modesetting support.  This is useful in
> > cases where the guest only needs to use the GPU in a headless mode, or
> > (such as in the CrOS usage) window surfaces are proxied to a host
> > compositor.
>
> Why make that a compile time option?  There is a config option for the
> number of scanouts (aka virtual displays) a device has.  Just set that
> to zero (and fix the driver to not consider that configuration an
> error).

The goal is to not advertise DRIVER_MODESET (and DRIVER_ATOMIC).. I
guess that could be done based on whether there are any scanouts, but
it would mean making the drm_driver struct non-const.  And I think it
is legitimate to allow the guest to make this choice, regardless of
what the host decides to expose, since it is about the ioctl surface
area that the guest kernel exposes to guest userspace.

BR,
-R
