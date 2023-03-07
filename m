Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3C6AD4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjCGCsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCGCsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:48:51 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1361526580
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:48:50 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-536c2a1cc07so220910457b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 18:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678157329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgt5jS4yhQSzCPdn/ZYUqLkl8CzdntpQ4aotvK0s7Ps=;
        b=bC6kQALSLNuqRTQaZ9igs0e7tU+DTMVX5l5fByB2rDw3UpbJvuu4T4oK5oVM5Rk5Ll
         8tNu6u+ARj5BDUkLjlpb/lWKave+lwglVLoJW+jFM8RpDgJA9W+2vfXnvqiMxMoXdefi
         iO34NjNBfN1UcOL7SAPpSeMHim7rP8rzFEMbuNPyEV1Giw+C9U5DhMRNvd0bryLVE8XZ
         Wun1sSNfTcMaxK5PpcAjejMKFzAwJ3WFKA63gcj+m7bPbfebZ+imgMZQgeLBHFjyZeip
         Lb+g+O93DLWbhXJLzekN1UG4Qe6St9jVVW7AMlNiDNko/G5KKb3jh3T6GLWsUSX+d2Qr
         YrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678157329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgt5jS4yhQSzCPdn/ZYUqLkl8CzdntpQ4aotvK0s7Ps=;
        b=YIT69nUkN7XWlTm0x6xPToNLr3N+CESZNhumu1pCRp5wkJljkuyqtRT3n4Yd75lDCo
         o+XQZVah1JFzhYnbDsYiKRiJBXQPzSy2Oo+57igouqJQXFh8ln6FMCrBXLm+dquvlaG0
         ubSJiWSUH1oU0Bkvuo0R5VlFWCJ2n4BXbNX3ZIYgMOey0gUbLtSrWFytQiAqWHTnAU1m
         TKsIOpXo8CGi+fkC0Hn72xbXv4NOsYoEzo04r/NBoSyMHYyJLb4HH2DrJAm3imIuRxNh
         qK13/emykJB9Ok8E+TNQwxU+IbLkYi3H6munlHIdkqoNBPDH2tM3C3ZmC+B/Sdn2PnPi
         6yGw==
X-Gm-Message-State: AO0yUKWvBPwGf7U4R1reV+bHUY2oXB9fmnzWjzVFradBvqSLJwcCVN1F
        gjzh7mc0A7pa6ELt6x/yiINUQ6W6/xwPwwFKrs3R
X-Google-Smtp-Source: AK7set+7qSth69cARYvLTy3vreAuG4eBzkkkrdpMtT+rT9KG8bg3ULr3mNo/gsLruekyoNHGRNGr/PNwa95c+Mbf36Q=
X-Received: by 2002:a81:b604:0:b0:52f:2695:5d05 with SMTP id
 u4-20020a81b604000000b0052f26955d05mr6829568ywh.3.1678157329171; Mon, 06 Mar
 2023 18:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20230306165143.1671-1-afd@ti.com>
In-Reply-To: <20230306165143.1671-1-afd@ti.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 6 Mar 2023 18:48:38 -0800
Message-ID: <CANDhNCrzi+9BszTj+9v9t6cHOcxv=4C1yQZnZZ-_7FWoxwAd5A@mail.gmail.com>
Subject: Re: [PATCH v3] dma-buf: cma_heap: Check for device max segment size
 when attaching
To:     Andrew Davis <afd@ti.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 8:52=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>
> Although there is usually not such a limitation (and when there is it is
> often only because the driver forgot to change the super small default),
> it is still correct here to break scatterlist element into chunks of
> dma_max_mapping_size().

Hey Andrew!
  Thanks for sending this out!

So *why* is it "correct here to break scatterlist element into chunks
of  dma_max_mapping_size()." ?

> This might cause some issues for users with misbehaving drivers. If
> bisecting has landed you on this commit, make sure your drivers both set
> dma_set_max_seg_size() and are checking for contiguousness correctly.

Why is this change worth the risk? (If this is really likely to break
folks, should we maybe provide warnings initially instead? Maybe
falling back to the old code if we can catch the failure?)

I don't really object to the change, just want to make sure the commit
message is more clear on why we should make this change, what the
benefit will be along with the potential downsides.

thanks
-john
