Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958CA655538
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 23:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiLWWgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 17:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiLWWgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 17:36:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622DD10D4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 14:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671834966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAEhCvBqDOSeVJ5cr+C6I0wt8yyHcksJQ4MmdK2pgfQ=;
        b=VCD5XFNNFahNaBun0+u5iYfeEm9ZgbZh694LccFbz5ulG3F/Up354niYevB7PclVcaiKo/
        ms1zcJjgytvUSpwzXHSa0bQf4brfL8eRQgbOVb1sEzMWt/ejZG6htOSeCKPhAjT8MrVvIZ
        fYIWwXQzbNTW3RpQiwqoYU/vOIRHy2M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-2io-KRnvPOmXBPgWbIyFgQ-1; Fri, 23 Dec 2022 17:36:05 -0500
X-MC-Unique: 2io-KRnvPOmXBPgWbIyFgQ-1
Received: by mail-ej1-f72.google.com with SMTP id qb2-20020a1709077e8200b00842b790008fso4143113ejc.21
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 14:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAEhCvBqDOSeVJ5cr+C6I0wt8yyHcksJQ4MmdK2pgfQ=;
        b=ay8uq3skQCU230EV8LhXk0ExsWzG8km2AsoK+sIwoZeZbP+WtFjgtx2toQnTvXNxLE
         CI80nhNs7FN9+CAxhwR5BvZIj4iGHWSME9Me39lkFR/z3jSwAYNpNOIIxAJhRrvbbhdt
         S5JfaySiKNZOilHfjTW9zi+Ci5sfxZ70pKz5bZB9jnsIF8BawcxtivslcTVLyqEvtZVC
         LrJkyzDu7M/V4iQFWfV6iOQ5AOpZmzX0/GoE7vabFF3uCLgvqFX3E2N6f7mG/V3Gf+Ue
         92mz4yms33SvDt5N3y69bw17I3nQPBwZ97tr+hH812gpnx41L9gSv1Ktign8X5zPSuLk
         QN6w==
X-Gm-Message-State: AFqh2kpqscp//aZjddakOu9AttgbOC/BAaE4wlP9ylSKd0GGHrM8IV8Q
        Z56ZsJ1PYp34XE/T4SzCnkM2G6Kg9njV1Bm9+nfdGRYiTrKEpYe9Kjj5LereEjA0rGn4KnRuSFS
        6qwuUPmtSE/R6lRYoR0+bu5kK
X-Received: by 2002:a17:906:7f91:b0:7c1:5a5:f6bb with SMTP id f17-20020a1709067f9100b007c105a5f6bbmr8730250ejr.50.1671834964181;
        Fri, 23 Dec 2022 14:36:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuLH42LmprbIKVhy48/0bhL/K12YuoqsuPbuz81JiRHptRGsUb+Yjw6OoTZMpmBqEdLpDoCRQ==
X-Received: by 2002:a17:906:7f91:b0:7c1:5a5:f6bb with SMTP id f17-20020a1709067f9100b007c105a5f6bbmr8730220ejr.50.1671834963942;
        Fri, 23 Dec 2022 14:36:03 -0800 (PST)
Received: from redhat.com ([2.55.175.215])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709060ac400b007c500ac66b2sm1831409ejf.64.2022.12.23.14.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 14:36:03 -0800 (PST)
Date:   Fri, 23 Dec 2022 17:35:56 -0500
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
Message-ID: <20221223173127-mutt-send-email-mst@kernel.org>
References: <20221222144343-mutt-send-email-mst@kernel.org>
 <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
 <20221223172549-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223172549-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 05:27:49PM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 23, 2022 at 11:54:41AM -0800, Linus Torvalds wrote:
> > On Thu, Dec 22, 2022 at 11:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> > 
> > I see none of this in linux-next.
> > 
> >                Linus
> 
> They were all there, just not as these commits, as I squashed fixups to
> avoid bisect breakages with some configs. Did I do wrong?

More specifically, everything up to
458326ec10d1233399a342263d33878cb0afe710 lines up in next-20221220, and
then I decided to rebase to squash bugfixes.
Plus these are two trivial patches on top that just tweak sparse
tags so 0 chance of regressions, and an also trivial security-related bugfix.


> -- 
> MST

