Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9B26559F2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 12:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiLXL3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 06:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLXL3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 06:29:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA13B7C2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 03:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671881306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JQfHFluJStqMAVjm8YivW74tDU05oCwMWLpLFH2ZJDA=;
        b=Ev8e0IWDkSQYTZBaUuHWdlrI4gE78ofg54ksHStDyy0WFNPauRtYSJdjn0NeCAFXzi1DRr
        xZH7f51gdIILBbLvTLacjwX4YhBe8F+pt7NLhdW8Kqh5u6GlILjjuc9Vi+gbtmVQ73svnM
        KtAzYGqKnVI/XftZMYKsbUSUiRUkIQA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-339-U7lsmBAROo6GIXovSRd6Ug-1; Sat, 24 Dec 2022 06:28:25 -0500
X-MC-Unique: U7lsmBAROo6GIXovSRd6Ug-1
Received: by mail-wm1-f70.google.com with SMTP id k42-20020a05600c1caa00b003d971135cd5so1768050wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 03:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQfHFluJStqMAVjm8YivW74tDU05oCwMWLpLFH2ZJDA=;
        b=hrfvV3FbpV+HXH+UDlG+O13qnMPo/rCkj9FFzgx9QjP+pqltQyhUEvQUQkVoJeP+pT
         S60an5h7Dybtw3zb7x6YH+kAgTLELwjsLk6vYpvEnwdLtnqkPbeQh6P0FNhlhBGwvqRX
         T5rbiygQ4c1OdCYNr0+ENUIDWEX8Z+6jOokDcqNzYRmstNwW5q8XZwpqtfRgdkON4y2z
         ewuaVUSG1EV7Xz4mQC6eW9Lu3vrbYZ/lIeAXbg5C5Fr9YwhQYIXjozvZwO+CitFjzsWa
         qPn9rN/udhbLrMVe+piVKd4AkA9Fz2RqgSQ+j/Seyd+7Z6kxn5YFc7jQQc1GhLZqwTjx
         9OTw==
X-Gm-Message-State: AFqh2kqPFUO90Iw6ULu6AIsjFHnru4ICAfZwjY+8ZGlv2OWsYCv5c1Dv
        BVcXZKVC0n7NUltE1kcgakEIBmGoZkVjFbwTmecsfSKpCHqAxeSX2DX2jtIJKhzMe1xHY3YQs7P
        QIU8r843b1xXSodXHsun1krIF
X-Received: by 2002:a5d:49c3:0:b0:232:be5c:ec4a with SMTP id t3-20020a5d49c3000000b00232be5cec4amr11351832wrs.6.1671881304005;
        Sat, 24 Dec 2022 03:28:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuzqzQuZiVw3dHitCdMvuaTddTiExV1+yb8w1dPWupnmnSH1RzpFeJq4F8DeQJZG9fQQBe56g==
X-Received: by 2002:a5d:49c3:0:b0:232:be5c:ec4a with SMTP id t3-20020a5d49c3000000b00232be5cec4amr11351824wrs.6.1671881303791;
        Sat, 24 Dec 2022 03:28:23 -0800 (PST)
Received: from redhat.com ([2.52.27.62])
        by smtp.gmail.com with ESMTPSA id h6-20020a056000000600b002423dc3b1a9sm5127678wrx.52.2022.12.24.03.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 03:28:22 -0800 (PST)
Date:   Sat, 24 Dec 2022 06:28:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes, cleanups
Message-ID: <20221224061932-mutt-send-email-mst@kernel.org>
References: <20221222144343-mutt-send-email-mst@kernel.org>
 <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
 <20221223172549-mutt-send-email-mst@kernel.org>
 <CAHk-=whpdP7X+L8RtGsonthr7Ffug=FhR+TrFe3JUyb5-zaYCA@mail.gmail.com>
 <20221224003445-mutt-send-email-mst@kernel.org>
 <CAHk-=wh_cyzZgYp1pL8MDA6sioB1RndQ_fref=9V+vm9faE7fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh_cyzZgYp1pL8MDA6sioB1RndQ_fref=9V+vm9faE7fg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 10:10:30PM -0800, Linus Torvalds wrote:
> On Fri, Dec 23, 2022 at 9:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > They were in  next-20221220 though.
> 
> So, perfect for the *next* merge window.
> 
> Do you understand what the word "next" means? We don't call it
> "linux-this", do we?
> 
> This is not a new rule. Things are supposed to be ready *before* the
> merge window (that's what makes it "next", get it?).
> 
> I will also point you to to
> 
>   https://lore.kernel.org/lkml/CAHk-=wj_HcgFZNyZHTLJ7qC2613zphKDtLh6ndciwopZRfH0aQ@mail.gmail.com/
> 
> where I'm being pretty damn clear about things.
> 
> And before you start bleating about "I needed more heads up", never
> mind that this isn't even a new rule, and never mind what that "next"
> word means, let me just point to the 6.1-rc6 notice too:
> 
>   https://lore.kernel.org/lkml/CAHk-=wgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16VKoqL7Ok9vv7g@mail.gmail.com/
> 
> and if the meaning of "next" has eluded you all these years, maybe it
> was high time you learnt. Hmm?
> 
>               Linus

Yea I really screwed up with this one. High time I learned that "no
fallout from testing" most likely does not mean "no bugs" but instead
"you forgot to push to next". Putting procedures in place now to
check automatically.


-- 
MST

