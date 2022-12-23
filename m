Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642F2655552
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 23:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiLWWoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 17:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiLWWo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 17:44:29 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9C41B781
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 14:44:28 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id j16so4745136qtv.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 14:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vSvLPbLq/C9FCOrpReOfkegMxmEq2CG+zmnUg15rfnE=;
        b=O0nO2npcsEuGz+0NX8LmllWKqOioCXhGuOHySQlyMTXGG2F9CCkQXekZJapL/wB5cN
         luHDk0NeFDIYSI6+va2fCWh86HzpC4ARJaWu10Enp9BH5cG/n36UP46NrRtnmKYV2mdp
         6PrsrjtqGbBhZOiPYxKOD7XSXcAkSBUcrfYFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSvLPbLq/C9FCOrpReOfkegMxmEq2CG+zmnUg15rfnE=;
        b=6ZNu+m3VZ1+PACM+wjm/PfbzqS5BYqezmPdBFkRfyqZkSCn5XpSJAqylIpa4hPxpW6
         +1FbU5HbwhLz2/8e0XPv84VJjiJf1f5SZq/NplOXBm7RcYCNTL/6qmGON1rzF4RuSCax
         j0Jof2UG4DLVGQxjnBcG3UCz383MOGjVFysGNBp1QoVmiWMEeXlp8GK/MwMWY9OtY23v
         DcZK0damBAHvfodGi2ZDXVn+I6Rfw0GnLgNK/1vKuKaDOchfbIwMMatN5E89J0Hrt12v
         84Z/p8+3CLovghlFANrMww7KP6kCWVfjXztOYTwMFfjcZQ6YjtxsgXSNw/nZGjMkv/vs
         s6KQ==
X-Gm-Message-State: AFqh2korHzTPHYp3/ELs1+sI/jMoazUSbyf9a53NxiNFVDVMuGl8oD0V
        1Axah7ohK7CL3jqIFnCx5lyKEXdjzB7uEAVa
X-Google-Smtp-Source: AMrXdXvKWRYgM253fqSMY6Y4jr72dAE5ryEpVMjnl1nkzFFNBoohwwmEm1PQj9vY6mnblLFlAZ33rQ==
X-Received: by 2002:ac8:6e9b:0:b0:3a5:274c:611b with SMTP id c27-20020ac86e9b000000b003a5274c611bmr13311853qtv.62.1671835467381;
        Fri, 23 Dec 2022 14:44:27 -0800 (PST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a0bd500b006fa4ac86bfbsm3072118qki.55.2022.12.23.14.44.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 14:44:27 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id h21so4709850qta.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 14:44:27 -0800 (PST)
X-Received: by 2002:a05:620a:1379:b0:6fc:c48b:8eab with SMTP id
 d25-20020a05620a137900b006fcc48b8eabmr367434qkl.216.1671835022820; Fri, 23
 Dec 2022 14:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20221222144343-mutt-send-email-mst@kernel.org>
 <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com> <20221223172549-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221223172549-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Dec 2022 14:36:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpdP7X+L8RtGsonthr7Ffug=FhR+TrFe3JUyb5-zaYCA@mail.gmail.com>
Message-ID: <CAHk-=whpdP7X+L8RtGsonthr7Ffug=FhR+TrFe3JUyb5-zaYCA@mail.gmail.com>
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

On Fri, Dec 23, 2022 at 2:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> They were all there, just not as these commits, as I squashed fixups to
> avoid bisect breakages with some configs. Did I do wrong?

I am literally looking at the next-20221214 state right now, doing

    git log linus/master.. -- drivers/vhost/vsock.c
    git log linus/master.. -- drivers/vdpa/mlx5/
    git log --grep="temporary variable type tweak"

and seeing nothing.

So none of these commits - in *any* form - were in linux-next last
week as far as I can tell.

             Linus
