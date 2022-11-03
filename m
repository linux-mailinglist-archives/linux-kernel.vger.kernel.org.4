Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AB06174BB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKCDFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKCDFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:05:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DD713F7F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 20:05:22 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i9so377980qki.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 20:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R64KECUzDbqJo0RRKWL4JjLGKACzWeVJPV2fXxBJdHw=;
        b=ju3Dknz07FXV4Eja1inVQbLV5EziVz/npKT2GwOg4qm60L2iFaIP9e04iZ9gYRFvIy
         oLMsDFaAW7PVgBNfjby2i8fQZmp6MrvbXW7hJDHFovM3Vh8EV1cy5UAVhJbBGIOvh6T8
         UcwlOuYb0iPCKfeXAhU54nmrjwFKxudH6BQFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R64KECUzDbqJo0RRKWL4JjLGKACzWeVJPV2fXxBJdHw=;
        b=j4dRzdeow/ud7K58PWn2tOJSyZlXjgSRKHiILZSA5FVQ3NvA8zeICBiPVeiMaMY06N
         pGoddRo7z94+jAzir0pZz1CShS6QgS0myZ8Igky+1eESytxk1sGBFI6ziKKEbwDJ8M2I
         3x1hHuKWcx2y/GOD/pPYLH59VP1UTigN5Kyl6NY/mCD++WcSNfoM4phzO3jfVmzcdbJx
         rlP25xkZNe3FezR26WeKA6A2CgVhyTiWKvqvg8mrowWWKFl447mjWP8awNrb3sk8tGmu
         e7XNruMAend/gqaxGJdBSVkbYiiahZYQh/e+5Sb9a4bOU251UttG4ZMQXboWRUhiJf71
         DDuA==
X-Gm-Message-State: ACrzQf0WHWrvMBgtz7fQLCA2q8mnMzoAwKKdQDafaHUHPQWvH6B8qzSL
        FaSYsACWER05kjvoWSBSmz4Wpc1BLFQsXw==
X-Google-Smtp-Source: AMsMyM7247K32oPk39ksBRRrgL+bTA9C/t1ztZFOpGHbiKJFyO6HxalE2mrdjyOHG//IJcbEu1eCKQ==
X-Received: by 2002:ae9:e507:0:b0:6fa:3ae1:cef with SMTP id w7-20020ae9e507000000b006fa3ae10cefmr12375170qkf.717.1667444721237;
        Wed, 02 Nov 2022 20:05:21 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id w128-20020a379486000000b006ce76811a07sm9679137qkd.75.2022.11.02.20.05.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 20:05:20 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id w10so344502qvr.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 20:05:20 -0700 (PDT)
X-Received: by 2002:a05:6214:f23:b0:4bb:f5db:39b3 with SMTP id
 iw3-20020a0562140f2300b004bbf5db39b3mr18157941qvb.117.1667444720007; Wed, 02
 Nov 2022 20:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221103013937.603626-1-khazhy@google.com> <3c0df3fa-8731-5863-ccc5-f2e60601dbf9@huaweicloud.com>
In-Reply-To: <3c0df3fa-8731-5863-ccc5-f2e60601dbf9@huaweicloud.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Wed, 2 Nov 2022 20:05:08 -0700
X-Gmail-Original-Message-ID: <CACGdZYJ0WH+Y9sdchXy30UVTQgPCEo=fW+W9atZh1Ki7Ov4_Gw@mail.gmail.com>
Message-ID: <CACGdZYJ0WH+Y9sdchXy30UVTQgPCEo=fW+W9atZh1Ki7Ov4_Gw@mail.gmail.com>
Subject: Re: [RFC PATCH] bfq: fix waker_bfqq inconsistency crash
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 7:56 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2022/11/03 9:39, Khazhismel Kumykov =E5=86=99=E9=81=93:
> > This fixes crashes in bfq_add_bfqq_busy due to waker_bfqq being NULL,
> > but woken_list_node still being hashed. This would happen when
> > bfq_init_rq() expects a brand new allocated queue to be returned from
>
>  From what I see, bfqq->waker_bfqq is updated in bfq_init_rq() only if
> 'new_queue' is false, but if 'new_queue' is false, the returned 'bfqq'
> from bfq_get_bfqq_handle_split() will never be oom_bfqq, so I'm confused
> here...
There's two calls for bfq_get_bfqq_handle_split in this function - the
second one is after the check you mentioned, and is the problematic
one.
>
> > bfq_get_bfqq_handle_split() and unconditionally updates waker_bfqq
> > without resetting woken_list_node. Since we can always return oom_bfqq
> > when attempting to allocate, we cannot assume waker_bfqq starts as NULL=
.
> > We must either reset woken_list_node, or avoid setting woken_list at al=
l
> > for oom_bfqq - opt to do the former.
>
> Once oom_bfqq is used, I think the io is treated as issued from root
> group. Hence I don't think it's necessary to set woken_list or
> waker_bfqq for oom_bfqq.
Ack, I was wondering what's right here since, evidently, *someone* had
already set oom_bfqq->waker_bfqq to *something* (although... maybe it
was an earlier init_rq). But maybe it's better to do nothing if we
*know* it's oom_bfqq.

Is it a correct interpretation here that setting waker_bfqq won't
accomplish anything anyways on oom_bfqq, so better off not?

>
> Thanks,
> Kuai
