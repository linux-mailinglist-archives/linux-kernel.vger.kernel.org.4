Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CFD61D91C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 10:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKEJ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKEJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 05:27:51 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1005B303CC;
        Sat,  5 Nov 2022 02:27:49 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id k7so6960609pll.6;
        Sat, 05 Nov 2022 02:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcabuyOCyRp/GUeKePhs2D/mGuyiXtjOrLeSsbF2QLQ=;
        b=Sl49yHGoTXfvPinHKyVHAKsq3/lKyjeeQkQMSmLIweqVFx7gjUW8MWC5WG7cA2hNQO
         3eEkmzlbYnkl1g6rjefUoyKTPYDwDoHgvog5eS41UvX6U6Xxlg37OnORzAXvrgg1MVG8
         WXhaAe0UM8HjV6WLyPIpvPdQzjEkKPiYRSglrfvw+RxZS+ajk8as9ZRttRyFSRldlW4x
         Maj4mKXAjBiEmu14LEJbRT+p31Tq+5URuOwEzR8ws/AfyYiHQChXehsOgvrvMxHgpb2W
         1NF018Yv/bqyVxpcyN+y2hDj5GXQysGx0JnW/yfiz78nJxbk8EVMgp8DgGSSh58CKy3Q
         Tnyg==
X-Gm-Message-State: ACrzQf3Jtn3rhdXKCPNS7bBIp5cT7/lbIMg8cSfX3zX/ne3upC3BVKme
        thTMG0P2USFXUIfjaIr0Hy5ydPtX3JxkrbPMzaM=
X-Google-Smtp-Source: AMsMyM5sUIvNQ7y8Gj2BUY6yQ3ZyurJT+teF2q5k3gOct1lJlhHGepOi3xKwwP50AXSal95Y28lyiX5U69v4Tmi69Ag=
X-Received: by 2002:a17:903:185:b0:187:2430:d39e with SMTP id
 z5-20020a170903018500b001872430d39emr30280252plg.65.1667640467936; Sat, 05
 Nov 2022 02:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr> <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
 <Y2Ydf6UxVvTe8Zmz@kroah.com>
In-Reply-To: <Y2Ydf6UxVvTe8Zmz@kroah.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 5 Nov 2022 18:27:36 +0900
Message-ID: <CAMZ6RqJkzag-PGuzHcDQkSXjqH6d8=uAe-UN8VXUoNWX2x+qbw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] can: etas_es58x: report the firmware version
 through ethtool
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat. 5 Nov. 2022 at 17:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Nov 05, 2022 at 02:16:04AM +0900, Vincent Mailhol wrote:
> > ES58x devices report below information in their usb product info
> > string:
> >
> >   * the firmware version
> >   * the bootloader version
> >   * the hardware revision
> >
> > Report the firmware version through ethtool_drvinfo::fw_version.
> > Because struct ethtool_drvinfo has no fields to report the boatloader
> > version nor the hardware revision, continue to print these in the
> > kernel log (c.f. es58x_get_product_info()).
> >
> > While doing so, bump up copyright year of each modified files.
>
> Why not just stick to the normal USB interface here and not try to tie
> it into ethtool?  These values are all availble today in sysfs or in
> libusb, right?

The simple answer is ignorance. I am more familiar with ethtool than
libusb and I just did not think to explore that second option.
Thanks for the review, comments taken. I will study sysfs and libusb
and will rework that.

> What workflow wants this added to ethtool?

No workflow. My work is not bound to any company and this driver
maintenance and anything else I am doing on the mailing list at this
time is pure hobby.

Yours sincerely,
Vincent Mailhol
