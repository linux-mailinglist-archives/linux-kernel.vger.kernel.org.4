Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A502B6636DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjAJBro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjAJBri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:47:38 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E46DF26
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:47:37 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so6208397oto.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 17:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kbDcjQtwcmYIyMwYrj6WVATDcFAVZZpovnNCEJKINmc=;
        b=qFcyM27Xbo5tKN2io6bi2zLc6Pb2fKgrzjr3usL6fFZ/eMmZxf8JV4ni8ZtxQ84vAK
         sK7qmXC5dNvM6ePIGeUbtF1s1lsumaDCC+I605W8zUdwevk9B5yPJIMO3YAYb3nyQSOV
         wXbLqNy/gkvObGh/MoTWxeSCtuyeJL9NlLLtcEtnsLlcpKmN1wGMDnvdTCYXlXT69jz7
         Q0cNNkh94qHckX4ck7DlWz+YkJjk+nwbuHHWzK9oCrNfhh6duJha5SIhBEJJuxCwApVM
         7Oq0Fu8hueRCOFcwf8PL9+UTPMRLqHQl817LRAMO6Q7B15QnQrc6Ft2mD1uhrw15QvLx
         VlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbDcjQtwcmYIyMwYrj6WVATDcFAVZZpovnNCEJKINmc=;
        b=11cd8DHVPdEo231K/7UnddtFdX2FDAi/1taZBRtIZfy3yvcOse6jmgY0wQLHThNtde
         6jGjpHL3AOmIjHgyEtfWd2Vqg5XfBhxmaZmtv0SPAHin+uMHKB/bY5DBpTo6bvvT7Lti
         dL6JX46zpd8jt/sfOryJvq4v7NCIx4ULlmA9Cjt2IKupTzqDJ+xKXfCZgwn55VgBX1B8
         +PIq8cUW8Uia/IvQrWq6racYruoe0PygFTdHBdPQ2FMq/zbmGpXSFj3sMFzzdJpnGTt2
         5k8RQOk4A++0lcEKk9gz/XqpiDgxGUtZh26LxBrXzK1AyPij3pn84baINQoeQeUw43K3
         Z8vg==
X-Gm-Message-State: AFqh2krrV/ekdlL4vokM348D81y+H7IEtNwmpzNCsXLJdZVGH7Nwz+s5
        19hcAUlnIR45dqK/qU4SN7/5qmDUnBdg4j/sQhU=
X-Google-Smtp-Source: AMrXdXvvOgJPNnYtha/68FhbwNYmEh+bLUpMyl+dlv1Y6ezF1RZbS7ig7ahlDY/Aoks9r8hpVJT5WzWwe7Zkbrw1ABs=
X-Received: by 2002:a9d:7310:0:b0:678:272b:41e1 with SMTP id
 e16-20020a9d7310000000b00678272b41e1mr3478533otk.328.1673315256862; Mon, 09
 Jan 2023 17:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20221216233355.542197-1-robdclark@gmail.com> <20221216233355.542197-2-robdclark@gmail.com>
 <3ae74f28-580b-3b53-3d7b-e8bde97dabe3@collabora.com>
In-Reply-To: <3ae74f28-580b-3b53-3d7b-e8bde97dabe3@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 9 Jan 2023 17:47:34 -0800
Message-ID: <CAF6AEGvGb66L7cXod40PiKijJRTCOhWL+qCz4bgmi-69ZxJt8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Fix GEM handle creation UAF
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@redhat.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
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

On Mon, Jan 9, 2023 at 3:28 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 12/17/22 02:33, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Userspace can guess the handle value and try to race GEM object creation
> > with handle close, resulting in a use-after-free if we dereference the
> > object after dropping the handle's reference.  For that reason, dropping
> > the handle's reference must be done *after* we are done dereferencing
> > the object.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
>
> Added fixes/stable tags and applied this virtio-gpu patch to misc-fixes.
> The Panfrost patch is untouched.

Thanks.. the panfrost patch was not intended to be part of the same
series (but apparently that is what happens when I send them at the
same time), and was superceded by a patch from Steven Price (commit
4217c6ac8174 ("drm/panfrost: Fix GEM handle creation ref-counting")
already applied to misc-fixes

BR,
-R
