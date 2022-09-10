Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A725B47C6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiIJRpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJRpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:45:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD9932ABE
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:45:12 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r12so4183171ljg.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aie6ag3LP7KTSHHgJRRXYhySd8yIP5uCy4oQFxQtKGk=;
        b=hHi2dzV802YHAdTbvpVvyMaGrGtEmEJsabGg+h6AIpwWiXRx82cBkFu6dHEXOappI1
         pLz2bCqJilAsa42gTb8Yq23LsdaqWscHiIPd54ibKdZ1ZEghM+yfsBeUzEjKxR5eNOlx
         rv1vK7/WL8e9nwmc4ZiQYx6php+uluY34bEJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aie6ag3LP7KTSHHgJRRXYhySd8yIP5uCy4oQFxQtKGk=;
        b=Xo4+RvE2LVix9CniJGlgPqOvHXTGHnIFO965Wq6fuhi5bL+YrHhWupCeqmHXGLz9up
         mDHsSsRxogZecgOqG4dYsXMQK7TUhJk/UxjHLtHBSr28GYUdhKA6SCEpJ2wWebc8MWu8
         k/kNTPFJqdYUI6XmHZEWGEh/YUnZ6m0EjPIN4Q5k5MAwlZvpYV1lhg5UNPqQDRV+qY8g
         AcXYDQTcq9y+gdNNWpcXjBm7CAnbp7GotjekaqRaPPgs4n8Sum6OTVZurkzr/kccUK1M
         ZKnXj/xx7NmES2JLyn5KdouYp4mtdqy3nyuvvzxDQlZBEjQVxuglKo2CztbA5nmM+BBO
         BQMQ==
X-Gm-Message-State: ACgBeo0Yn4D/82vKQ1IK4H/DbvKmvmbwbLg/2DcVOXBDKMnYT5X4DoUh
        /N6nrnUy+BZiU8Yf7w7u5zRT4N/UZZgYyXa8Wmk=
X-Google-Smtp-Source: AA6agR4JXpBm/jVq1mMqe7OFVf9AD72CHth4b7gYSx9qbFDBk+ug+hiqDPSrs/UMniTjf8JXiMiP1w==
X-Received: by 2002:a2e:940f:0:b0:261:b9ca:6207 with SMTP id i15-20020a2e940f000000b00261b9ca6207mr5819098ljh.192.1662831910295;
        Sat, 10 Sep 2022 10:45:10 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id g22-20020a2ea4b6000000b00268bc2c1ed0sm417258ljm.22.2022.09.10.10.45.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 10:45:09 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id bt10so8085466lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:45:09 -0700 (PDT)
X-Received: by 2002:a05:6512:3d16:b0:498:f04f:56cf with SMTP id
 d22-20020a0565123d1600b00498f04f56cfmr4649996lfv.612.1662831908961; Sat, 10
 Sep 2022 10:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
 <20220905125637.GA2630968@roeck-us.net>
In-Reply-To: <20220905125637.GA2630968@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Sep 2022 13:44:52 -0400
X-Gmail-Original-Message-ID: <CAHk-=whh=0FG6r_YJ4_1pq07b=bqN8gTExU5T_ys-SVn0CRDtQ@mail.gmail.com>
Message-ID: <CAHk-=whh=0FG6r_YJ4_1pq07b=bqN8gTExU5T_ys-SVn0CRDtQ@mail.gmail.com>
Subject: Re: Linux 6.0-rc4
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 8:56 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Revert "scsi: core: Make sure that targets outlive devices"
> Revert "scsi: core: Make sure that hosts outlive targets"
> Revert "scsi: core: Simplify LLD module reference counting"
> Revert "scsi: core: Call blk_mq_free_tag_set() earlier"
>     revert f323896fe6fa
>     revert 1a9283782df2
>     revert fe442604199e
>     revert 16728aaba62e
>     Rationale:
>         The series may result in hung tasks on reboot when booting from USB drive.

This should be in my tree as of yesterday evening thanks to the SCSI
fixes merge.

> Revert "fec: Restart PPS after link state change"
>     revert f79959220fa5
>     Rationale:
>         The patch results in various tracebacks and crashes.

Hmm. No revert, but does commit b353b241f1eb ("net: fec: Use a
spinlock to guard `fep->ptp_clk_on`") fix it?

Or do other issues still remain?

> Apply "amba: Fix use-after-free in amba_read_periphid()"
>     Link: https://lore.kernel.org/r/20220818172852.3548-1-isaacmanjarres@google.com

.. and this should have gotten fixed with the ARM merge on Tuesday,
which got that patch as commit 25af7406df59.

                   Linus
