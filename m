Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E8466DF86
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjAQNyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjAQNxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:53:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB0935B4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673963547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zCNIOWyp6BvkZ2wh9MfUHSp5MAA9j0ACgJb6RoOlUO0=;
        b=RAzPTz2WXsIRDRK96l3OjVCRglq+2hqU+Isb4trMR6yVuDDhpAD1WOsS3R4si9W19LunoR
        uG/0v9XcBKpJ/r9VYbJpR4pQIiseKJJy6I8zqqrI+x1ruYfrwX0M+KZ6xjBPR6KJACIVeS
        jYmmzHtUKZ++RgE7FeLM3q+kyHHleOM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259-hu6OFv5APaSdpkBEg2VCnw-1; Tue, 17 Jan 2023 08:52:25 -0500
X-MC-Unique: hu6OFv5APaSdpkBEg2VCnw-1
Received: by mail-lf1-f70.google.com with SMTP id x12-20020a056512130c00b004cc7af49b05so10245683lfu.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCNIOWyp6BvkZ2wh9MfUHSp5MAA9j0ACgJb6RoOlUO0=;
        b=FBQLKQ8eeX5X0dApKlxCCtPST95tgrPAUgBuh42ZixmLcSc0gH725SaWElAp+EIddj
         v3BgOJCpshrhqDqpFGxDpxJwtn5irpHY0JV55t9Q3R5zL+lmryCkfbugzRxdivsPsJNz
         QLY8S4znJC8kPUZ7LZYgfOOMdkFJx9xzUPK8Rwlb0Uw6F331cvdUctYdTKnTqe7BJkuo
         03tgAIa2eZxwcO73wdax7q7tWVLH7AwYGiN+5lfqoQ/yYhO//1DFotQvUvKxUXfgLN/m
         W1izyhWemfv3EnSN/34QImHYQCCokY0i6ZNpP3/EydJSzluU/AQq4Gm8QnXto+sbsL6g
         uJJA==
X-Gm-Message-State: AFqh2kqggIuA51QjL12EEu0JPYV5b15JC2ISbqaF2go7v2qOCEYJCpk2
        DSAVidWqgenhANm4x5KrHe9hi9nvaqngOCyerYbHqTpLTHFZydw9XLNbS3mNIWNlNCRT9nACJ8J
        3L3xHNpzeynhaWk2yUXJIs5FjLGcEGqffo15j2XX/
X-Received: by 2002:ac2:4ade:0:b0:4d0:7b7:65dc with SMTP id m30-20020ac24ade000000b004d007b765dcmr133417lfp.122.1673963544333;
        Tue, 17 Jan 2023 05:52:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs9jCpstio+iSjdAor3NZ75bz+2Dnozw/p6Ykmo64gLJfiYXc3udp+wH4Z3eIPBKX1dEiSO07P7nXfvqprRwdo=
X-Received: by 2002:ac2:4ade:0:b0:4d0:7b7:65dc with SMTP id
 m30-20020ac24ade000000b004d007b765dcmr133416lfp.122.1673963544131; Tue, 17
 Jan 2023 05:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20230117150212.3d8ee843@canb.auug.org.au>
In-Reply-To: <20230117150212.3d8ee843@canb.auug.org.au>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 17 Jan 2023 14:52:12 +0100
Message-ID: <CACO55ttvqwnmGS=4gig-AOy+67bDesdj2S9HDJ3hS=uyN0NGOQ@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the kspp tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Tue, Jan 17, 2023 at 5:02 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> The following commit is also in the drm-misc tree as a different commit
> (but the same patch):
>
>   06b19f46455c ("drm/nouveau/fb/ga102: Replace zero-length array of trailing structs with flex-array")
>

which branch? Because I just fetched the remote and don't have this
commit in my local repo

> This is commit
>
>   54d47689c6e3 ("drm/nouveau/fb/ga102: Replace zero-length array of trailing structs with flex-array")
>
> in the drm-misc tree.
>
> --
> Cheers,
> Stephen Rothwell

