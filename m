Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959E664E857
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLPIz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiLPIz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:55:26 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEEF37205
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:55:25 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x2so1630680plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KIfEz81U3HVJ4JhGoBJFjs00sIawE7R6JvvebcBdLcA=;
        b=b3xVmZlRg/35qPV3zrDnmMxZkqYqnSqQ92eIj7WqDRIoee+cdDAs4Ul/3HBALrIqqK
         ubUyl/4ZMRICi20VLa/qyvnIhVeNsUPHmnSesSDprBIlo+BBr5vWDWITYMiGY9Au1vCQ
         HSSzbuGh0EU0goHPY7eXRo96OHIB0DXuXTeNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIfEz81U3HVJ4JhGoBJFjs00sIawE7R6JvvebcBdLcA=;
        b=eHdYqeG4r5jEg5Vt7GMTbD/+tG03noZsKY9YmRXsT36dG3qqZ4iMKYq13tcEz4vQCc
         hw3ESJJtMIDXfoPF3I0h3Y7QyHyVj/CqhK8AnNbzu/LNIGOkNGq2jSqn3WHHtfGKLkF+
         JHOr7UEBKqA0Amf6v9QT++r5N9a6FNODyuhoexZ51CryrAHCxQr3kcy4hHmhVn0qlw1T
         DS1B1ZCmeR9ffeKEulaBgVO259kr58ARrrVJZstRqglZbzmziBGSw+GgSmrisPBpCns0
         F/cqH0EDrcDhrN7yyMAsNAMtpbVXtziz02jUiiW7BTMFFjNCUBOZ9YHGC1hLIRqO4P2L
         GNXg==
X-Gm-Message-State: ANoB5plW4ZI/xBoJwFoqB0BaeCEzS0F/HuHy6zRcp0uafpC9N7gBpAy9
        wibYRd3dSjAodbPDGy7Gd+Lum+o6yBm2k2XbcIA=
X-Google-Smtp-Source: AA0mqf7/5ZeAX0vNPXky6p/TZmbjWh03UKpnFRimSWBXeRanZYWF+SHYMCkZiDBN5itq/CHw+sedMA==
X-Received: by 2002:a17:903:2481:b0:189:b0ff:e316 with SMTP id p1-20020a170903248100b00189b0ffe316mr29049793plw.38.1671180924773;
        Fri, 16 Dec 2022 00:55:24 -0800 (PST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com. [209.85.214.169])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b00189502c8c8bsm1050871plb.87.2022.12.16.00.55.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 00:55:22 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id w23so1635163ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:55:21 -0800 (PST)
X-Received: by 2002:a17:90b:1489:b0:219:8132:70db with SMTP id
 js9-20020a17090b148900b00219813270dbmr697624pjb.183.1671180920433; Fri, 16
 Dec 2022 00:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20221214-uvc-status-alloc-v3-0-9a67616cc549@chromium.org> <Y5s+kuxCAtS8Eixj@rowland.harvard.edu>
In-Reply-To: <Y5s+kuxCAtS8Eixj@rowland.harvard.edu>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 16 Dec 2022 09:55:09 +0100
X-Gmail-Original-Message-ID: <CANiDSCudMRATbHU4=hyjiVhwLr6zQubXPzzpYtXCxdMPsZFcuw@mail.gmail.com>
Message-ID: <CANiDSCudMRATbHU4=hyjiVhwLr6zQubXPzzpYtXCxdMPsZFcuw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] media: uvcvideo: Code cleanup for dev->status
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Max Staudt <mstaudt@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yunke Cao <yunkec@chromium.org>,
        Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan

On Thu, 15 Dec 2022 at 16:34, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, Dec 15, 2022 at 11:57:17AM +0100, Ricardo Ribalda wrote:
> > There is no need to make a kzalloc just for 16 bytes. Let's embed the data
> > into the main data structure.
> >
> > Now that we are at it, lets remove all the castings and open coding of
> > offsets for it.
> >
> > [Christoph, do you think dma wise we are violating any non written rules? :) thanks]
>
> There _is_ a rule, and it is not exactly unwritten.  The kerneldoc for
> the transfer_buffer member of struct urb says:
>
>         This buffer must be suitable for DMA; allocate it with
>         kmalloc() or equivalent.
>
> Which in general means that the buffer must not be part of a larger
> structure -- not unless the driver can guarantee that the structure will
> _never_ be accessed while a USB transfer to/from the buffer is taking
> place.
>

Thanks a lot for the clarification. I was mainly looking at the kerneldoc from:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/usb.h#n1687

and I could not see any reference to the DMA requirements.

Mind if I send a patch to add a reference there?


> There are examples all over the USB subsystem where buffers as small as
> one or two bytes get kmalloc'ed in order to obey this rule.  16 bytes is
> certainly big enough that you shouldn't worry about it being allocated
> separately.
>
Yep, we should keep it malloced. Thanks a lot for looking into this :)


> Alan Stern



-- 
Ricardo Ribalda
