Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287DA6CB466
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjC1C6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjC1C6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:58:07 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9362681
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:58:07 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id df34so9241413vsb.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679972286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4pP9BpVMTE+iluP8oKlc8/OklZFONZeaXv/pNYUX8zA=;
        b=BkQPlX9r8ylc77QnOkqlsqx8+pZJMwwnvN5ByqVe2wM6/j/UQEArrknQRvOmA/Ead+
         Y0cERkfvLmYJLoq6CH3w1Gsl+0nzY9SNQMrUehaZTLquiINERhk9UZSTDd9deYh2JsRm
         pvxqtXjn9vgWzus9km/Vx43VqhPponR8+lFUMFzWVquTVRMgvS49G6xgw1Qf9lsZD/FG
         GjcLJoHfJpE08ips/PkaDW4Dipg2IE0lSZoMI774Sh6ZKJPwTJTUZQjGIsLtNTi3my5S
         qyPMGrf1MSKNG/VT4sdmJe00ugfoz/9OiNCNs+0iTl0oZh0o5HgiDZKdSu327TH//qMg
         3tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679972286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pP9BpVMTE+iluP8oKlc8/OklZFONZeaXv/pNYUX8zA=;
        b=Uo2Ym1V9mAtpjxYtvpubdJ74PETMbpJ8NY3crolmPyeM3WZvKwFZk5YX2v5LwMk5vI
         t9SQ70EqW9PkpYIVUjiU1fb1Xcwvwv5QZH+WhmMKau5oB2dgxI7rKAdi0OfcmEjdnQsC
         CfoyNMMKPEyFJVwVamNobX95uxnyS9d+ZmkGTJyDN4iWwtgH8FQ+5Vw/QkQNS3rGOUaf
         Kx7GzUnb1emv5PEe1YgbRh6Pdt999wlWv9WymD75wgIqHdWDY59l4zN9q8LNDZHhozAY
         k6zMDoO6R224/PYeyET04yM/7Uz836n53r0BVbjiAyXS+Ljegn8rIKkv7gwrucPBGMWW
         ooTg==
X-Gm-Message-State: AAQBX9c51pwASVNf2FJa34492S45zzXfRFBpxOQ1aa6OsdNaLfCTU9Hn
        wHxBXzKb9K96y1JtqwbKbIzUj2MziLwDuS/hqcI=
X-Google-Smtp-Source: AKy350b+79ROympiGDP2VeTXwWhOmhIy5p1SEf5pzH4mGd5x+B301GAggWlZRpqYyenxpiHDz+6ygGd24hGgW6ZkjOY=
X-Received: by 2002:a67:cb82:0:b0:426:40e7:9148 with SMTP id
 h2-20020a67cb82000000b0042640e79148mr7343807vsl.6.1679972286136; Mon, 27 Mar
 2023 19:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230313075017.668204-1-chunyan.zhang@unisoc.com>
 <CAAfSe-tg7JwakdCcoLn3Ws_164HcsT21pWHkjjw0Qqwy8PWkhQ@mail.gmail.com> <ZCFNRfpUHbaGBvJb@8bytes.org>
In-Reply-To: <ZCFNRfpUHbaGBvJb@8bytes.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 28 Mar 2023 10:57:30 +0800
Message-ID: <CAAfSe-stDTabua1EMQBF-xp_=zyn6yzrRR9VFmzyQ6jwzufMfA@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] Add reattaching support and fix memory leak issue
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev, Baolu Lu <baolu.lu@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 at 16:01, Joerg Roedel <joro@8bytes.org> wrote:
>
>
> Hi Chunyan,
>
> On Mon, Mar 27, 2023 at 10:47:18AM +0800, Chunyan Zhang wrote:
> > Not sure if you received this patchset, since I received a rejection
> > letter from mail.8bytes.org.
> >
> > If you didn't receive it, I can resend it with another email address.
> >
> > Otherwise, would you please pick up this series if there are no more comments.
>
> I didn't receive it, can you please send me the error message you got
> from my mail server?

Have sent it to you.

>
> Regards,
>
>         Joerg
