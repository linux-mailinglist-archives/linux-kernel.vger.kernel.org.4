Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD3365589B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 07:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiLXGSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 01:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiLXGSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 01:18:39 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54F4B80
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 22:18:33 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id i2so2654317qvq.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 22:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3E3YAkwQ1FMGK0G4c+k3cWhSC99qn+AW2e60BpLd48M=;
        b=h0YtYQKEi5AnsXB7utpqFRidFunGHv4v+XFF72sE8OGP438jrHeRtPo/jQdOSZ1pLE
         oegIRWAaL4+RlmtvXf3fWwBdtxMDrz9wbhjYKbUArB5tP0fzi7/cIsac8j32oj4Hz6Xj
         3+DSLdyaQWX2k4WvvXwK/zYvkz1jN+G7ah7Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3E3YAkwQ1FMGK0G4c+k3cWhSC99qn+AW2e60BpLd48M=;
        b=W1H0sV4tD1qGeuYD+1cUebJYQMhzHX0cGZbZBca0yXAyKKn7ndF6+zzw1+kw4JeSvN
         sXr8uYaoco8G4X1bzz1UpAGSbtfFiDu9MCJUcNnah90WYKCwuCA+i1YqKNv8h7AA2eO2
         pdvBa7m9UwbrOMmthl3N31X57PpEFNl8X+3uxiCQT2OIb6YxO0pQstXQySeAS/v8rWjF
         9T8Yj5EMDCraUlrDPkyKPZwdyL+TYQHe1w79K0ZPZMQrYJ6bCWnzrdS93CxcBlnsc8mt
         meFB7gEgArrD8wu9StnUs+3UDByc49Fd1YxTB/UPSvFKctsAIFgb8abUj8iH0ZR/V8Ly
         ITZQ==
X-Gm-Message-State: AFqh2krpgIDqkJK/1wamQjIk7+Y0834ghWMuFzDZ/D9eVp9tPvzMoQXL
        hSqasfrvMUK/rwLkgkvbXnxvhN7OqoPgg3Eb
X-Google-Smtp-Source: AMrXdXuuhWw8drz6rZfQWlJsO6Iyveq4qzS1XlOyKv6kIgo1F/Zh2kwhOzF3rAp09+eNtXFZp+nyng==
X-Received: by 2002:a05:6214:3304:b0:4c7:7a7e:8067 with SMTP id mo4-20020a056214330400b004c77a7e8067mr17478944qvb.18.1671862712531;
        Fri, 23 Dec 2022 22:18:32 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006b929a56a2bsm3663102qkb.3.2022.12.23.22.18.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 22:18:32 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id v14so2429883qtq.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 22:18:32 -0800 (PST)
X-Received: by 2002:ae9:ef49:0:b0:6fe:d4a6:dcef with SMTP id
 d70-20020ae9ef49000000b006fed4a6dcefmr506882qkg.594.1671862246626; Fri, 23
 Dec 2022 22:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20221222144343-mutt-send-email-mst@kernel.org>
 <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
 <20221223172549-mutt-send-email-mst@kernel.org> <CAHk-=whpdP7X+L8RtGsonthr7Ffug=FhR+TrFe3JUyb5-zaYCA@mail.gmail.com>
 <20221224003445-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221224003445-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Dec 2022 22:10:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_cyzZgYp1pL8MDA6sioB1RndQ_fref=9V+vm9faE7fg@mail.gmail.com>
Message-ID: <CAHk-=wh_cyzZgYp1pL8MDA6sioB1RndQ_fref=9V+vm9faE7fg@mail.gmail.com>
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes, cleanups
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        almasrymina@google.com, alvaro.karsz@solid-run.com,
        anders.roxell@linaro.org, angus.chen@jaguarmicro.com,
        bobby.eshleman@bytedance.com, colin.i.king@gmail.com,
        dave@stgolabs.net, dengshaomin@cdjrlc.com, dmitry.fomichev@wdc.com,
        elic@nvidia.com, eperezma@redhat.com, gautam.dawar@xilinx.com,
        harshit.m.mogalapalli@oracle.com, jasowang@redhat.com,
        leiyang@redhat.com, lingshan.zhu@intel.com, lkft@linaro.org,
        lulu@redhat.com, m.szyprowski@samsung.com, nathan@kernel.org,
        pabeni@redhat.com, pizhenwei@bytedance.com, rafaelmendsr@gmail.com,
        ricardo.canuelo@collabora.com, ruanjinjie@huawei.com,
        sammler@google.com, set_pte_at@outlook.com, sfr@canb.auug.org.au,
        sgarzare@redhat.com, shaoqin.huang@intel.com,
        si-wei.liu@oracle.com, stable@vger.kernel.org, stefanha@gmail.com,
        sunnanyong@huawei.com, wangjianli@cdjrlc.com,
        wangrong68@huawei.com, weiyongjun1@huawei.com,
        xuanzhuo@linux.alibaba.com, yuancan@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 9:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> They were in  next-20221220 though.

So, perfect for the *next* merge window.

Do you understand what the word "next" means? We don't call it
"linux-this", do we?

This is not a new rule. Things are supposed to be ready *before* the
merge window (that's what makes it "next", get it?).

I will also point you to to

  https://lore.kernel.org/lkml/CAHk-=wj_HcgFZNyZHTLJ7qC2613zphKDtLh6ndciwopZRfH0aQ@mail.gmail.com/

where I'm being pretty damn clear about things.

And before you start bleating about "I needed more heads up", never
mind that this isn't even a new rule, and never mind what that "next"
word means, let me just point to the 6.1-rc6 notice too:

  https://lore.kernel.org/lkml/CAHk-=wgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16VKoqL7Ok9vv7g@mail.gmail.com/

and if the meaning of "next" has eluded you all these years, maybe it
was high time you learnt. Hmm?

              Linus
