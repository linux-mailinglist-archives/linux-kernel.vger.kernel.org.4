Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8866C2DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjAPOzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjAPOyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:54:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD90227AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673880103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NOdvTIf1x9tQkJ1orPjPgaQ6ppXgSvc8Pon55J0dM/o=;
        b=h6BpwuVnDAj/m1HKKGRIYV13TK1ZazKwRMVE58UgX8Z2J1vPigDjHTtnq58KjXitKg2kXG
        CVfvBCtTTRzlIe18vFK+Usn3m/lm9jqRE3KEsE9ZqLGnDiGNOgWobubDRs803CxPzOcZS8
        CM26zgjaGtSgrgv7ibehLvRpQLhECN8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-ep_E4F33O4S9eyHjsF0bbg-1; Mon, 16 Jan 2023 09:41:42 -0500
X-MC-Unique: ep_E4F33O4S9eyHjsF0bbg-1
Received: by mail-lj1-f199.google.com with SMTP id y8-20020a2e9d48000000b0027f1feabc75so7522571ljj.16
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOdvTIf1x9tQkJ1orPjPgaQ6ppXgSvc8Pon55J0dM/o=;
        b=v1Pf60UFl150gT2NMCs5EwK00RvIIgzXUcSx2OczFyRONwPuMSEo0mgXTFBP3R2HZ7
         SDM3z2WuEE4qs+qHDqjIcX7ubdj3lH0ffq5srjpLy6bKyzfYBgZdZ9QBDYjIDjs4c0on
         ByiA184sFNFaLW7/xfJGkI629C5xO7rcM8CJ3T37dP2gMGOgBkzosVmVyQizBNZZ0yrq
         jT7GikXhbnvQQjI0kR7Nt9ZjN/vejI52r3/bgZlJ9B16nocY+wLttheObxzOp9VqI4YU
         zl6IRb1hdNd0vWtnHMV2K4OZTTPOno9HWDlrh4c7l1xtFZUcPclmazg+Vd1MIPRDK2rb
         vV1A==
X-Gm-Message-State: AFqh2kpmow+rd10yxRMfwk4jb1mH9qJz7LoaU+0UTci/huMlRezB9xmT
        PVLH6o/4WP0WtJC7MDLRh9KNiyuA3d1/8Z/CWWzDBdV4GeYmprDPLxyuhtWxOFvI5vbMaPcCb/K
        XItWBOe91bI9urDZ7CTM9CUSEneOHfDnWjJUKxIwr
X-Received: by 2002:a2e:a278:0:b0:276:4462:2d20 with SMTP id k24-20020a2ea278000000b0027644622d20mr2375ljm.19.1673880100988;
        Mon, 16 Jan 2023 06:41:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt9sY30K02/f5zO7kr1kC+X6IUBM2xn7/y8ozy2/Ri3RfIQeuDJUUrDrh1bQKXOq8bdG47xKQOTvByre+UJEzQ=
X-Received: by 2002:a2e:a278:0:b0:276:4462:2d20 with SMTP id
 k24-20020a2ea278000000b0027644622d20mr2374ljm.19.1673880100820; Mon, 16 Jan
 2023 06:41:40 -0800 (PST)
MIME-Version: 1.0
References: <Y7zB0q2pr7lEpHGs@work> <202301121449.EE489AA@keescook>
In-Reply-To: <202301121449.EE489AA@keescook>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 16 Jan 2023 15:41:29 +0100
Message-ID: <CACO55ttCY1KbqWqzGS1adrJno6kUs7b5_QY7X1AE6qYUqztWNQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/nouveau/nvkm: Replace zero-length array with
 flexible-array member
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

will push in a moment

On Thu, Jan 12, 2023 at 11:49 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jan 09, 2023 at 07:39:30PM -0600, Gustavo A. R. Silva wrote:
> > Zero-length arrays are deprecated[1] and we are moving towards
> > adopting C99 flexible-array members instead. So, replace zero-length
> > array declaration in struct nvfw_hs_load_header_v2 with flex-array
> > member.
> >
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [2].
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> > Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> > Link: https://github.com/KSPP/linux/issues/78
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
>

