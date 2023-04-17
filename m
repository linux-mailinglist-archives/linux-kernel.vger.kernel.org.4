Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF106E3DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjDQC4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQC4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:56:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0557D30E7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:55:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f08b6a9f8aso189395e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681700156; x=1684292156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4c8L7VsZgoyPG8O8WEpaQWguavlynHaEcvAogGRYUI=;
        b=zxhkp9OEKijNfW6g/6CYNlaJKDTH4UhRZ56vl423M3dC2Tx6CI+nm7quah+flVOazp
         y0eTRq96Jp32vYBFyrzIbKOcV8LQisPT6UxyxMod/S3XBvbLx545JW8Z8DCVH/JLHlnC
         LT+KTf+a0YfvydkMKMvBZcYe6XOaYAuf0KTwVJGcBy096f1/78jlpEyrhgVN1ociRskE
         i4AwZcF7s1+nos/N6lTzvNiDhvVC4pnFgYAXTUXVczODp2+DHnYarUc0RxDN4RhvCvki
         4vq65dhmT61tXFTrGh3XkMkT64Voa/UHHtbE57ZuKLHN4rTooSyZliwe+FYowQxOMaYk
         tfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681700156; x=1684292156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4c8L7VsZgoyPG8O8WEpaQWguavlynHaEcvAogGRYUI=;
        b=D9H9GMao/kOiWSiFD9RxYUqcK7awgYR73N/O8plVrKuOVdIQT+uymy49mcdqCIeUaU
         Iy03WWnC4qYmXXAJHL04tFij+EMJCTpN6+LtNwNM6yBOz8c+GomtrKUIJQspLPjAsvIs
         Hobb3KNVwEbyTrEaU/OzBEDaLg3bGIJbbX/sOTMjDx1am6/Pr4VWuhzppTvYFf+oNil5
         s/BXqvEhoKIae7dvftZUM2aBMTAcP4oaweP7zp02LNtnU0D8VXYtx5PIVQoUVLOuWaV9
         HtZBQ9e7gBaNb8KSR+kki6vctvc3G4dqfwwPAxPM7QAxY1A08Nu92ErYwIQ0i/8/LadG
         Pc3Q==
X-Gm-Message-State: AAQBX9e/+gC5vmpJ7n0OG4huIqEGEpzQcaxpwnGf1TQmTHy+fXuqZTCJ
        7TryClp/AsQdvxHpB4FzuSSkTY+BOAo8d2YoQZTKNFZVFbtHNP4TrpqvNQ==
X-Google-Smtp-Source: AKy350a/AbTPkNfR9MVzY+0vuXZSs3EmG7yZhMnygYPMmBmJKpiVgIC02MAzSPHURPIOHguRrEtknv6E8BueaelcDPc=
X-Received: by 2002:a05:600c:3512:b0:3f0:aeef:e2da with SMTP id
 h18-20020a05600c351200b003f0aeefe2damr397745wmq.3.1681700156385; Sun, 16 Apr
 2023 19:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
 <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com>
 <20230416151853.GK25053@google.com> <CAOUHufZk+dxE8UXWwGzGbX1BYxomD_25u2xoWt3vnoQp4xSZqw@mail.gmail.com>
 <20230417024446.GL25053@google.com>
In-Reply-To: <20230417024446.GL25053@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 16 Apr 2023 20:55:19 -0600
Message-ID: <CAOUHufYJtB0n314GnMH1ByXL5PTtzzsrMvi2YbHz2YVqTTcYfA@mail.gmail.com>
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction algorithm
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 8:44=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/04/16 13:27), Yu Zhao wrote:
> > > Hi,
> > >
> > > Did you bisect it down to this series?
> >
> > Not exactly -- since this series was the only suspect I had, I cherry
> > picked it to v6.3-rc6 and verified it is the culprit.
>
> Can't reproduce it yet. One of the theories is that get_fullness_group()
> maybe returns an invalid index, but I don't immediately see how would it
> do so.
>
> Is the problem reproducible?

Whenever swapping *multithreaded* heavily.

> Do you run some specific test?

E.g.,
  tools/testing/selftests/kvm/max_guest_memory_test -c 112 -m 800 -s 800
with 112 CPUs and ~770GB DRAM + 32GB zram.
