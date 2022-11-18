Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC33762EDD5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiKRGna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbiKRGmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:42:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978818CF31
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:41:23 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a14so7805347wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FvKOgk3tDLWwb1NWyXvWAnYN0/RQ3NdysbGyQyA74cI=;
        b=oRbo7GGhWbJy2l8Rp7U1zQwZT6/x3xPfk/o5CkW3c8VNo4reSbqCG8/TCGHEesG5q7
         DDh2Ktjw+wy/gcb4aoTuTXgByV27VgTT8fC7JvOTWwcSndMkN3MCHzYGx687pJKdIUPn
         B4TbhU1quOtj4jCTQr96QRTcM00sN8Ixkifas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvKOgk3tDLWwb1NWyXvWAnYN0/RQ3NdysbGyQyA74cI=;
        b=jOvHQOxt2siUw991DXOEgrE5kZGzLqguhuFYdb7QTBr7+31fu7DJ1KnjjC6UieEbXm
         SA3PddsolaoSXDLrALHaTrKpgd/nOR97KS3SB/WjZSk9RGtG4/Iv5tsjYRZ07tvK/9Rz
         gocFAN9BWAX+1t7RGO8ILc6V0AT3pIMfleAM8z9g9JNty4bqjB1WVfzIA8Jm7ssLqC8y
         qFZS1RyJ/qWM0KEqlnWCXskE06QIX7GlrRE9AKjMRx2ll3JKP5eQC4cg5YHhIEAlZNib
         /BPRaMoDS7tWnXKtr1x6nM7891QCLHzKe8UNO0TWowUh7VFfh6dIsWSBTGcH0euT0hL2
         vFxg==
X-Gm-Message-State: ANoB5pmMWavzOmLfNnpT5+XWr/3vnAzpYlhW1fqZ6t/n9mcw5iS1NAc0
        otD8wony4Ot8o9ufaCa4TIkSFEsvfO1Ej+DIEDMq7w==
X-Google-Smtp-Source: AA0mqf6h3mCbrB9fesYTUW/Zh1uZgkTjjRfkkWD8QVK+210QpaWdfoKKF4ZKM2dDciAWSdEY40yuLUPeWnMYjyb04EM=
X-Received: by 2002:a5d:6a85:0:b0:241:bd77:f243 with SMTP id
 s5-20020a5d6a85000000b00241bd77f243mr1744786wru.393.1668753677438; Thu, 17
 Nov 2022 22:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20210804213139.4139492-1-gwendal@chromium.org>
 <20210804213139.4139492-2-gwendal@chromium.org> <CAPUE2usQX_uQewpCYOs3SRUo7vDDMfg=n7idNvCgThDHMqTf7w@mail.gmail.com>
 <CAPUE2uuj1qde16QWHb=0+yMW3ERhXzV7ehGcViWCfij7ADeyWg@mail.gmail.com> <Y3bnYT6TXGXhkh/T@google.com>
In-Reply-To: <Y3bnYT6TXGXhkh/T@google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 17 Nov 2022 22:41:06 -0800
Message-ID: <CAPUE2uuUn33yRMz77+XxZvK9bDzAA8u3SLBx=iDfAJc6WrUEEQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] platform/chrome: Poke kb_wake_angle attribute
 visibility when needed
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     dtor@chromium.org, jwerner@chromium.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 6:01 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Wed, Nov 16, 2022 at 10:23:38AM -0800, Gwendal Grignou wrote:
> > [+chrome-platform@lists.linux.dev]
>
> Please also Cc to the mailing list if the patch gets chance to have
> next version.
>
> > On Mon, Nov 14, 2022 at 8:10 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> [...]
> > > > Expose the attribute group to alter to close a potiential race between
> > > > cros-ec-sensorhub and cros-ec-sysfs (that creates the attribute group
> > > > on behalf of the class driver).
>
> I failed to realize the potential race.  Could you explain it a bit?
The decision to show or not an attribute is done at the attribute file
creation time, once. If the module cros_ec_sysfs is loaded before
cros_ec_sensorhub, the attribute kb_wake_angle will never be shown. If
it is loaded after, and there are 2 accelerometers, the is_visible()
function will return true and the attribute is shown.

This patch ensures the attribute is_visible() is run again after the
sensorhub driver is loaded.

Gwendal.
>
> > > > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > > > index 02599687770c5..c6dca260bbd5d 100644
> > > > --- a/include/linux/platform_data/cros_ec_proto.h
> > > > +++ b/include/linux/platform_data/cros_ec_proto.h
> > > > @@ -191,6 +191,7 @@ struct cros_ec_platform {
> > > >  /**
> > > >   * struct cros_ec_dev - ChromeOS EC device entry point.
> > > >   * @class_dev: Device structure used in sysfs.
> > > > + * @groups: sysfs attributes groups for this EC.
>
> The field name has extra "s".
