Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9DE655410
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiLWTzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiLWTzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:55:03 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD9A13F49
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:55:02 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s9so4471304qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ytlGRN+Zvf1GCedPeHeIV0/Bc2Bxmm4MYRgni7UZ0VA=;
        b=T/HZO1Z86a/yucKbo8fCYB94xGQsaTO4ihOAnJOljMUc9OICiF/xMdXrc4ryg28DpR
         eFl/E3g3ID+1rnnglCWSW0jyixUPXe1uLYogNis+p2d9rOzDyOEgoIH4uPfAhY1MCiEh
         FRVU9oEHU2CS0vZvFc4uxoQNQVaMpW4BUYnLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytlGRN+Zvf1GCedPeHeIV0/Bc2Bxmm4MYRgni7UZ0VA=;
        b=h0t2d3/2SevRwbLJvervWz4q+BSuY/NFa2vV4hMDLvfRc2SJR1GPcFJKcqdlKKkOFw
         5c3IVwmZMSB36+nj3UvGSy12/MBIZGl2FtOBTT2+fbH+JffvP2SWFUwMbH8FwEnK6IIF
         BgkIYW7HrPuFXqL03+vzpQo0rc9DmLQ1fe2QenIwwPkV6Bz87yHSoJDYAAt0vwQR0wzE
         IFZhJ9fXXcc5b59HQlYbrobnOXGy0b3xzBlvK10S7qon0+uwHXV2n/OO4flXPAhLXBli
         +GdurmYIP99/pBfy88HlkNvoJCZORu0DoeCBbGm7imjYDy0MtDKJTWGqLM8WezVNM+lN
         9LnQ==
X-Gm-Message-State: AFqh2kpF6/iom38SUonBdYlSA7Z0JR4euVr1YjqyOfMemBGW/VfYAicg
        icJiOoRMcPmxXldKbrNJNrJQo8l+v+rq8N37
X-Google-Smtp-Source: AMrXdXucMoVhW0ee0GVeEN1HR9KIcJ0KZV5AxfdaxDao9pI5FtgUr3OHJa+3WfyTjj8/ajZEGBbXMg==
X-Received: by 2002:a05:622a:4185:b0:3a8:12b3:8bf2 with SMTP id cd5-20020a05622a418500b003a812b38bf2mr14084965qtb.49.1671825301043;
        Fri, 23 Dec 2022 11:55:01 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a255000b006fa12a74c53sm2878060qko.61.2022.12.23.11.54.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 11:54:58 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id i2so2029413qvq.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:54:58 -0800 (PST)
X-Received: by 2002:a05:6214:2b9a:b0:4c7:20e7:a580 with SMTP id
 kr26-20020a0562142b9a00b004c720e7a580mr551504qvb.43.1671825298226; Fri, 23
 Dec 2022 11:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20221222144343-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221222144343-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Dec 2022 11:54:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
Message-ID: <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
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

On Thu, Dec 22, 2022 at 11:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

I see none of this in linux-next.

               Linus
