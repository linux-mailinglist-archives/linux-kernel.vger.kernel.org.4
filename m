Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2A77420CC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjF2HOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjF2HNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:13:41 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD57B2D62
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:13:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-634f59e7d47so3372746d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688022815; x=1690614815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l5XW0exCS9z+Hy0fRQZ5/K6ds6wj/L09NJ5d7OC64KA=;
        b=OzMuROfJpoLGNgS+ZAcrHuueIY2DERxoPUf07SCErpmh3Jfp6xvCgHF3rgg2y1tYsV
         xM02nfa5f40WRqgKfNt4m7bDjumsiP7WhNIj4D8Cgnlc3qZckwnVuMtXCkbWL8alZVmM
         Lp63h5gsfVjxE1u7AdsceE+Kp/A/PQS162mR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688022815; x=1690614815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5XW0exCS9z+Hy0fRQZ5/K6ds6wj/L09NJ5d7OC64KA=;
        b=Lx9J+tJVuCy7+JSHZ/XqjiPoWV8TLupc2ZlQxwjFY9hZGREMwAnAz7gB28THIETPXu
         JrwOdHQOgeKCU22BnJAbXJ+1nFO8FkfjWc4RQDnkHhn1+3A2sQs2r+X0s9szeLWSVW7w
         WzaCv8nxygDSwIWxyqubOsC5O1P+786K073bRHhAX5cj9v5G8jSm7/V23jPbcbPr7fTI
         4+kUGZLYMqwlssR9V8RMAKNH6aJv4YEwn2waQz84jdmxJL+ek8pnjOMRg6/n8+fuE+Ba
         dWfBRD526nU6hz3hAHn0HvBJgZfL9AHYFUgiYyabp4w2UNzfaZY/g8iRyC3MlIKQMlMH
         A1RQ==
X-Gm-Message-State: AC+VfDzdC4qN1PneeRENWdt5i+G+Uo/Kr/R8P2H9AbJ+XPp2uqTOPPyk
        qI7qDH6Ji9E3Id37EwmKbECAXzohOoMlUMtyeYXGpQ==
X-Google-Smtp-Source: ACHHUZ7X2i8lYgro92I6Ygq6heB0TNtY7NxCbBTcogaLheMud9OayitHJ96B/X2Bm0ggtUlKbDxCWQ==
X-Received: by 2002:a05:6214:d0b:b0:62d:e1ab:a43 with SMTP id 11-20020a0562140d0b00b0062de1ab0a43mr39455561qvh.42.1688022815625;
        Thu, 29 Jun 2023 00:13:35 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id h20-20020a0cedb4000000b00630217f0181sm6741238qvr.80.2023.06.29.00.13.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 00:13:35 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-635e5b06aaeso3458406d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:13:34 -0700 (PDT)
X-Received: by 2002:ad4:5c47:0:b0:635:f546:83c4 with SMTP id
 a7-20020ad45c47000000b00635f54683c4mr8987873qva.54.1688022814565; Thu, 29 Jun
 2023 00:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-mtk-usb-v1-1-3c5b2ea3d6b9@chromium.org>
 <CANiDSCsAgD33gMk9-CTGHuUv_b4KfRnO02ETEt6jFtQvw+6cag@mail.gmail.com> <ZJystxdl0jVoe5b6@google.com>
In-Reply-To: <ZJystxdl0jVoe5b6@google.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 29 Jun 2023 09:13:23 +0200
X-Gmail-Original-Message-ID: <CANiDSCu3WOqK9wdLDXmW+zbckq15gmxKjtFA4Aghv6uoidO_3Q@mail.gmail.com>
Message-ID: <CANiDSCu3WOqK9wdLDXmW+zbckq15gmxKjtFA4Aghv6uoidO_3Q@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci-mtk: set the dma max_seg_size
To:     Zubin Mithra <zsm@chromium.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zubin

On Wed, 28 Jun 2023 at 23:57, Zubin Mithra <zsm@chromium.org> wrote:
>
> On Wed, Jun 28, 2023 at 11:04:20PM +0200, Ricardo Ribalda wrote:
> > On Wed, 28 Jun 2023 at 23:00, Ricardo Ribalda <ribalda@chromium.org> wrote:
> > >
> > > Allow devices to have dma operations beyond 64K, and avoid warnings such
> > > as:
> > >
> > > DMA-API: xhci-mtk 11200000.usb: mapping sg segment longer than device claims to support [len=98304] [max=65536]
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > Reported-by: Zubin Mithra <zsm@chromium.org>
>
> Should this be cc'd to stable@ as well?

Not sure, in most of the cases this is "just" a warning fix. Let the
maintainer decide:

Fixes: 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
Cc: stable@vger.kernel.org
