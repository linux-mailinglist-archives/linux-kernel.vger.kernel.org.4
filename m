Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ABE5BA743
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiIPHMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIPHML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:12:11 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BE13FA11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:12:10 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-333a4a5d495so248932437b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DE2ZdUL2HYhPOqvwzzPmLYQHO8bsfIjtF25iTHmhmzI=;
        b=KrbJtjgM5xbKvqJfC2o989PdTQXSpiSqy2SKQ/metYG2t/49AANGiRKkiNwqu720vS
         CqctyZuZlgH33AT2AMOAPRf2ltzR/iZDNIBPB78Gu99f8OJLK8ARxlsqVyL0WyXLedxy
         UEE3Xm0iM3dT++9xmZOwI7mqItq8Lb6E2nMijcDIaTw5k9JLVABEZYcZMGY+V12T/Ijx
         c8mT3uvnMmr/YMFt0Xe4qgtE7tjQw5KA5OfpDuYdqGZnLCBr/voNtUr/wttl7zuL1LBk
         H/c45izjZe7osBitG2Nx4pl/AVEMr7iwRA8LszzjTlZpSkCMeNS195FHqT74A3HH4Ni3
         c+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DE2ZdUL2HYhPOqvwzzPmLYQHO8bsfIjtF25iTHmhmzI=;
        b=LaanS5TO08Wqq/ThXk+W+dLuv3sDQHVyMwisxlpGUHSrW7+EYwnrrUMOkrBMQbC+pr
         k8n5E+Rtm7ZxoYjLqeZ7pma6Y1IUViOhDa1dKj2TxshmI+/kCU6iHSx92JQTdWdhL6FK
         Xqh3n+wl/3eFNvQwe7VuY+Z5/6BGs9DcqyzuYUjarKi9Sc0cDkP81MY+Hm9UZPsvoQOX
         zdKaxSMkcQCmq2vCQ/aqOuPQ+M+AzcKuWMjLx3w5ahwxuw5UJnVZXW6J5b2SCBbIFl+G
         yqjb4ddyjyW0N/O5B/Ra8SUAJUFxEzm56eARgVEQ67rfFrs8KHwZAElzuVUC00cbDmY/
         JWoA==
X-Gm-Message-State: ACrzQf3MKn+j3Qs/WcFns2hDjEZaGLzcvQnK3zvkqG/N8OKh0RFBF1bo
        SAgpaQRi4D1yVwQtmUEnns8JEo4Y4IMZs0Oi/KY=
X-Google-Smtp-Source: AMsMyM4esr4q3s7N1wM9ko5dALsiqR8ZdczR3dgZiLToL3UdRlZEWO8PyLda8yb76Pqk8fUv66V0X226F4UaXZLoH3E=
X-Received: by 2002:a0d:f445:0:b0:345:89a2:9a8d with SMTP id
 d66-20020a0df445000000b0034589a29a8dmr3264191ywf.107.1663312329210; Fri, 16
 Sep 2022 00:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1663273218.git.namcaov@gmail.com> <a046af7f-7b60-108a-39e8-9ac3b5ce7733@gmail.com>
In-Reply-To: <a046af7f-7b60-108a-39e8-9ac3b5ce7733@gmail.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Fri, 16 Sep 2022 09:11:58 +0200
Message-ID: <CA+sZ8B-93re5277swkO51hMuxqgKaKcR3AWcEJAfwcOS-ytdjw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] staging: vt6655: Implement allocation failure handling
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
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

On Thu, Sep 15, 2022 at 10:58 PM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 9/15/22 22:29, Nam Cao wrote:
> > This driver does not handle allocation failure when receiving data very well.
> > This patchset implements better handling in the case of allocation failure.
> >
> > Nam Cao (5):
> >    staging: vt6655: remove redundant if condition
> >    staging: vt6655: change vnt_receive_frame return type to void
> >    staging: vt6655: split device_alloc_rx_buf
> >    staging: vt6655: change device_alloc_rx_buf's argument
> >    staging: vt6655: implement allocation failure handling
> >
> >   drivers/staging/vt6655/device_main.c | 41 ++++++++++++++++++----------
> >   drivers/staging/vt6655/dpc.c         |  8 +++---
> >   drivers/staging/vt6655/dpc.h         |  2 +-
> >   3 files changed, 31 insertions(+), 20 deletions(-)
> >
>
> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Thank you, I really appreciate your help.

>
>
> Find in this email a comment from Greg about RFC:
> https://lore.kernel.org/linux-gpio/YwS4WDekXM3UQ7Yo@kroah.com/
> This patch is marked as "RFC" but I don't see any questions that you
> have here.  Please resolve anything you think needs to be handled and
> submit a "this series is ok to be merged" version.
>
> May be this is applicable to this patch as well.

I add the RFC tag to "tells maintainers should review your patch thoroughly,
and provide feedback. RFC is typically used when sending feature patches for
the first time, or anytime the patch is more than just a simple bug fix."
(from https://kernelnewbies.org/PatchTipsAndTricks). I was not aware that this
tag may be interpreted differently. I can send a new patchset if necessary.

Best regards,
Nam
