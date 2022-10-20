Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8369B605949
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiJTIE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJTIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:04:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFD24D157;
        Thu, 20 Oct 2022 01:04:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e129so18524926pgc.9;
        Thu, 20 Oct 2022 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yPKQF1womnv+Nz41FwdqMwP49IwpAg65M5ovOMXDQH0=;
        b=M0jMZM3VsUbFKjPZx7179s28DNJraI6tuTwAIp3S8+33iH1YL88vH7BVGAFmqnpb0X
         gLFPzWF2wsThgYb+7HGBCiYrL5UuSDDfhbRMeLeaFUornkZEtHjzLlborihppHjZSwxr
         PnhRoUThXobtWWpsjR4moxemKzVPka5sGW0RL+927ydHzkJXJEBlDzT1k0I9Uh9frEze
         ft3q04YBXYZjtB4HRgQ68K+7hD5k5tHMA81jfXkfNEY4wWnw4NOmolXKZ99eTVwWl1QW
         rnyHUO/8lrK9xgjlmY580LImTCIEklY/7hDvszUHVLZz/LXiqhneMOzFRu2Y6qyfhJsO
         Rqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPKQF1womnv+Nz41FwdqMwP49IwpAg65M5ovOMXDQH0=;
        b=vt1mBZhV0iBRk2K2T7eYqMH06evGm21M9yk3tqoYdZwc+aq79XDOGTaSE3FBqK7Hcu
         tzMH+1KTp5uKZ3Crrk4UFmNLRXf9BxyVyMYjTNFaV6VYthA6rit6EWXE7u+5f5yRh6Tq
         0ANOvGIMXegtJQRC2Xqi/4WSjXMt4ki4ROlqThNIxYKsMQy4Uz2OajMLV56qkW7vS0vj
         OuB5QdB1OlK68iN9Y8tfDfkcpUugbEu3FItrvzDS46KGVL8XTCWRAClupO38wIFYsjQg
         BOvz5JmKu7GvMzgkSzLiCUd1bAHHIRzaJvTsJi9rEJ3Zz+4stUejCSjVqUXfTOeS/uUU
         H7RA==
X-Gm-Message-State: ACrzQf0b12OcggXOSfX+HwxDOfCFQ1Qpva9wuDBM3GuWIRhUTqMdIdXp
        07ogvOZNz7WLtopgzroSbO5nSg1VvTEP8YZLhKODgotnYqUGQQ==
X-Google-Smtp-Source: AMsMyM7pNDWXpWvbEQnMBK6UgBUO5q2Q4JmBBZ0GbEtZfaKo69/TRRq9MrkaBCapIJrumfcdPbxUtHf8e48y1PK97Kw=
X-Received: by 2002:a63:6b44:0:b0:46a:fa55:b6a0 with SMTP id
 g65-20020a636b44000000b0046afa55b6a0mr10787569pgc.614.1666253086969; Thu, 20
 Oct 2022 01:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221020024529.25227-1-wenchao.chen666@gmail.com> <b9ca56af-cb06-4fb1-d5d8-7426629dfe2b@nvidia.com>
In-Reply-To: <b9ca56af-cb06-4fb1-d5d8-7426629dfe2b@nvidia.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Thu, 20 Oct 2022 16:04:35 +0800
Message-ID: <CA+Da2qx_BzD0JN+O848CWTBdRmmG4NObnodyX=w3NpjODSHuAg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Support Host to control FUA.
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "michael@allwinnertech.com" <michael@allwinnertech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "megoo.tang@gmail.com" <megoo.tang@gmail.com>,
        "lzx.stg@gmail.com" <lzx.stg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:07 AM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 10/19/22 19:45, Wenchao Chen wrote:
> > From: Wenchao Chen <wenchao.chen@unisoc.com>
> >
> > This patch introduces host->fua_disable for MMC host controller.
> > The host can turn off FUA to improve performance.
> >
> > 1. fua_disable = 1
> > /sys/block/mmcblk0/queue # cat fua 0
> > I tested 5 times for each case and output a average speed.
> >
> > 1) Sequential read:
> > Speed: 266.8MiB/s, 265.1MiB/s, 262.9MiB/s, 268.7MiB/s, 265.2MiB/s
> > Average speed: 265.74MiB/s
> >
> > 2) Random read:
> > Speed: 98.75MiB/s, 98.7MiB/s, 98.5MiB/s, 99.4MiB/s, 98.7MiB/s
> > Average speed: 98.81MiB/s
> >
> > 3) Sequential write:
> > Speed: 199.94MiB/s, 199.1MiB/s, 205.5MiB/s, 206.5MiB/s, 191.5MiB/s
> > Average speed: 200.5MiB/s
> >
> > 4) Random write:
> > Speed: 68.6MiB/s, 71.8MiB/s, 77.1MiB/s, 64.8MiB/s, 69.3MiB/s
> > Average speed: 70.32MiB/s
> >
> > 2. fua_disable = 0 (default 0)
> > /sys/block/mmcblk0/queue # cat fua 1
> > I tested 5 times for each case and output a average speed.
> >
> > 1) Sequential read:
> > Speed: 259.3MiB/s, 258.8MiB/s, 258.2MiB/s, 259.5MiB/s, 253.5MiB/s
> > Average speed: 257.86MiB/s
> >
> > 2) Random read:
> > Speed: 98.9MiB/s, 101MiB/s, 101MiB/s, 99MiB/s, 101.1MiB/s
> > Average speed: 100.2MiB/s
> >
> > 3) Sequential write:
> > Speed: 153.7MiB/s, 146.2MiB/s, 151.2MiB/s, 148.8MiB/s, 147.5MiB/s
> > Average speed: 149.48MiB/s
> >
> > 4) Random write:
> > Speed: 12.9MiB/s, 12.3MiB/s, 12.6MiB/s, 12.8MiB/s, 12.8MiB/s
> > Average speed: 12.68MiB/s
> >
> > According to the above data, disable FUA (fua_disable = 1) improves the
> > performance. Therefore, it is recommended to support the host to control
> > FUA.
> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
>
> Based on the data provided seems it does increase the performance.
> Perhaps it is worth mentioning the reason behind the performance
> increase and other side effects of doing so ?

We suspect it will affect the progressive power-down test, but after a week
of testing, turning off FUA did not affect this test.

>
> Also, it is usually helpful to mention performance increase in the
> % in the commit log so you can move verbose log (like above) into
> the cover-letter for documentation purpose, this is based on
> the feedback I got, unless maintainer(s) prefers is this way :).
>
> -ck
>

Thank you very much for your suggestion, I will update it in the next version.
