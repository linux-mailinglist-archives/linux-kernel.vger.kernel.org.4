Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5695E91B2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 10:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiIYImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 04:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIYImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 04:42:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD0201B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 01:42:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lh5so8416641ejb.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cJUTL4HFF5c6MSiqmCutUWIA1DXPBObRTJgFy/60YBM=;
        b=gdfFkPoy+sjSzheO281CK+V0J0F4BgcjkxUH6izI9WtHt54gKtFGD7QgkaysgXdJkC
         4auBIYerNe8lJFh9zx5/muqLer5XYM1/ECf05uNTE8yOC/v5z/DJIwsRgubImL/kz/i8
         B0EvknVrWdyZy3PIoAa+KrBbRwdwE9a2nyLFsS8Uxz2MLrNdgI28dj76lURnEDQftPiD
         2aGOzk7BDzThKsW0RnRZkUKnrhF1Pg86t7INqfzArAjlBLMvyiUR44naqq8ooM6kFUQG
         GBL8OyDSh9KT5NoPJch78q76RUHNcvBocR+HgHlGDHFZ1aVVB4chXYOasGhMe5bs36wm
         +wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cJUTL4HFF5c6MSiqmCutUWIA1DXPBObRTJgFy/60YBM=;
        b=h6+YeYSt/HSEdsd1dzeyXsYmzJ+t5rfztl5YMax8SQyMOybRDT2Dw2KCWK9M44AJ2t
         UtZSjd3fdcLijTDBdp+/qNepSco8ekADwL5yVdYS9dU/yg2zaz4x7CyP3/6KhbD1SZQl
         ebLAUN46dOdDFQfEM+oBePvL/0ZAhNruDqlelGJYi0/NGG4aUJ38zpkZ4heWAK3qmiK/
         RrJ8h3ms7fOj4ouLu83bd5CLoxaid60O+maOCTeUHFva/QYBdZSkzBJRwBR1nvurRFv5
         0fSyFpRwFrq18K6odY71WwtgyQzTS0vMPdkeRC2fMKieqhzXlY51wWr+sKQ7huQNOo8L
         kPCw==
X-Gm-Message-State: ACrzQf3e+O5b2JMUz82WIdsrerxysFDEsvz/ic90qqexVv/4om3DODzK
        FSg6KAdwKlhk/qDMhEs1LV0L2tZK1RcQHZI4Ryc5fg==
X-Google-Smtp-Source: AMsMyM6OSFYOXBsFVMQ90Gb6cn0rRSQK1qfOqXfYNLMwlitCbmsao98abUnUIKfKNY/OUc8jwBDe10fcOBpM0McBlj8=
X-Received: by 2002:a17:906:da86:b0:740:7120:c6e6 with SMTP id
 xh6-20020a170906da8600b007407120c6e6mr13805697ejb.44.1664095360679; Sun, 25
 Sep 2022 01:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtt-921LH=fcVtaOkzfb-sA-0Qht4hrNhmGS5f_S0P+cg@mail.gmail.com>
 <YyytP71y2GosUOhr@fedora>
In-Reply-To: <YyytP71y2GosUOhr@fedora>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 25 Sep 2022 14:12:29 +0530
Message-ID: <CA+G9fYtLwCiJeVO1UeJSU5iTrz9MmX3VWZZVFZxFPeSyGWT98g@mail.gmail.com>
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual
 address 00000010 - PC is at mempool_alloc
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sept 2022 at 00:15, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Sep 21, 2022 at 08:11:42PM +0530, Naresh Kamboju wrote:
> > [Please ignore this email if it is already reported]
> > Following kernel crash noticed on qemu-arm with linked config [1] running the
> > Linux next-20220916 to next-20220921.
>
> Does this mean the test passed with next-20220916 and failed with
> next-20220921?

I mean to say like this,
GOOD: next-20220914
BAD:  next-20220916

- Naresh
