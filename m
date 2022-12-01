Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA34863FA00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLAVpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiLAVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:45:29 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4D9BD0CA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:45:28 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l2so2715842qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q/o/4Z0noIcO+JxjS5cRgrs8K8HqcdCL5GKQbuoq6A=;
        b=I9jY2HMZHMNYPnPL/nM3HJtZaIg/7kAOlEsRt6Nj3N8ngJtoWN7ZOIOWGDO4vX0K+8
         FTdanY4u5e5/dAE6HBUnslqZ6vuNcPjRQM3JMKKFwASlFyddjZOGmU9510sZQd8TaYDx
         L3/hUR21sQis+mGBBv6JERXNitrGq7RNzhRAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Q/o/4Z0noIcO+JxjS5cRgrs8K8HqcdCL5GKQbuoq6A=;
        b=rUGpeEpD8ztuQshFoCwQUODysHQ8xnbnS9bjD+UEop9PHdTKfjLz5Xq4DyRDRv8DEz
         WRZ8QMsLIfef2MpjMJiyFaG7ynXM/4Thmylig0TiS2uhbPk/VIu73Iyx+qAJjKRkWs0w
         0+Ytf7PHyDGaP3r8xGkOPqba5He0cuV1WXlb1VdW/VAhbC+f3Fh8Te6x+288C63huXdg
         kWFDpQ6p6rMoTIPabgfEEgeVGjRd6SH0J8iAFUpysd3qwGX3Gp1BW187kaG20evsAF9y
         b36/iOIb0RvHk7uea6kZb46hqXCWZBMc1/8RlxIBes34ZogVmVJLSUnFCGVPBpGXUt8H
         AWww==
X-Gm-Message-State: ANoB5pnLVKd0yIGpfMpS3biJB2wqyXMonCKwqmS7hkKkWBru8Id/Buo8
        Wcq8g0gR9BCUPYYah0MgrIu7+GoJnaDEfa7aGr/4+Q==
X-Google-Smtp-Source: AA0mqf50epzbBUIPTodbZKuNfTiYJv6BUJC3Wm/CKvZTJkVdw9lxmUqDOGaYKdBetNOxDbs2UEYV3jATRJ4F00Jw0+g=
X-Received: by 2002:ac8:4a13:0:b0:3a5:b4ab:cb80 with SMTP id
 x19-20020ac84a13000000b003a5b4abcb80mr37531872qtq.59.1669931127887; Thu, 01
 Dec 2022 13:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20221130131245.v8.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <CACeCKacHWPVv=sDo5-VjpckvvFw6YmqvXCyLqzgbXBmG080mmw@mail.gmail.com>
In-Reply-To: <CACeCKacHWPVv=sDo5-VjpckvvFw6YmqvXCyLqzgbXBmG080mmw@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 1 Dec 2022 13:45:17 -0800
Message-ID: <CACeCKafaZNqtKb8=thALgX4yaVTqsPcGQsHEKUZEVB0XWaNMKg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] platform/chrome: cros_ec_uart: Add cros-ec-uart
 transport layer
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, one other thing:

On Thu, Dec 1, 2022 at 1:12 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi,
>
> On Wed, Nov 30, 2022 at 12:13 PM Mark Hasemeyer <markhas@chromium.org> wrote:
> >
> > This patch does following:
> > 1. Adds a new cros-ec-uart driver. This driver can send EC requests on
> >    UART and process response packets received on UART transport.
> > 2. Once probed, this driver will initialize the serdev device based on
> >    the underlying information in the ACPI resource. After serdev device
> >    properties are set, this driver will register itself cros-ec.
> > 3. High level driver can use this implementation to talk to ChromeOS
> >    Embedded Controller device in case it supports UART as transport.
> > 4. When cros-ec driver initiates a request packet, outgoing message is
> >    processed in buffer and sent via serdev. Once bytes are sent, driver
> >    enables a wait_queue.
> > 5. Since ChromeOS EC device sends response asynchronously, AP's TTY
> >    driver accumulates response bytes and calls the registered callback.
> >    TTY driver can send multiple callback for bytes ranging from 1 to MAX
> >    bytes supported by EC device.
> > 6. Driver waits for EC_MSG_DEADLINE_MS to collect and process received
> >    bytes. It wakes wait_queue if expected bytes are received or else
> >    wait_queue timeout. Based on the error condition, driver returns
> >    data_len or error to cros_ec.
> >
> > Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> > Signed-off-by: Mark Hasemeyer <markhas@chromium.org>

It is not clear who is the author of this patch. I'm guessing it is
Mark Hasemayer, since
they're the sender, but in that case their Signed-off-by tag should be
first [4].
If it is Bhanu Prakash Maiya, then the git commit should list them as
the author.

Also note that for patches which are developed by > 1 person,
Co-developed-by is an option
to share attribution.


> [1] https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
> [2]  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
> [3] https://elixir.bootlin.com/linux/v6.1-rc7/source/include/linux/wait.h#L510
[4] https://www.kernel.org/doc/html/latest/process/submitting-patches.html?highlight=signed%20off#sign-your-work-the-developer-s-certificate-of-origin
