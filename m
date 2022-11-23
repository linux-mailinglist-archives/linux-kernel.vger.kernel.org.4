Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CF66360A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiKWN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbiKWN4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:56:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0485A38
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669211408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HVSKF0YEcutduq/n8rv06TUhVfzj6CviBu1s4EiRloE=;
        b=NB/wrhErex25DrMHSyDkGdvRKywffiK237jBryG7oHCJNBQSnSoLoEY04KuNYDL93Qx91F
        GmF/OqZZ6K2UVSCORdsl8ECOXOKPvYVabQa3oaJY049osg0IeTU6/rlVS2onJT2qWELkkM
        1j3dIPVJAO7LQQvVyD+ahJZ1Vawx0Mc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-350-S2KSHkjANkyV0IukBB-UoA-1; Wed, 23 Nov 2022 08:50:07 -0500
X-MC-Unique: S2KSHkjANkyV0IukBB-UoA-1
Received: by mail-ej1-f71.google.com with SMTP id hb35-20020a170907162300b007ae6746f240so9906175ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVSKF0YEcutduq/n8rv06TUhVfzj6CviBu1s4EiRloE=;
        b=TnQKbyzDbJVvPPWxypyt9V8Mi5rQmXByhtx8gC4xBbw5gSGuEB5inDOgnkiYczhyee
         +h4qBR+oB9Q9boXaoSPOgO4njXb2V55KgyGHUv4Lj4w/LijPl0tScCnrZSrDxT2nLFRT
         XrhdHFHb6in8NINY6oYANSwEOpvwGrX1UnVQvPhPhH8vlyrkMLUbSOttUlfqyFFT5ulp
         u4yW0JpOr91pBZtNsOb5B3dVSH1MzIwpB8COsU+jcylTWnVMaP/LnLTAD565k9tdSdWw
         BbVyDarcHl+BaGRYl/Hu1e36J3Ie8Alu3lUopeZXWPfwHPPs0PBlIj+B81rGDW52s3D5
         jusw==
X-Gm-Message-State: ANoB5pn1ycx9biN5PUMZ9OhL55nx0837AT7th48yjRl2tOQpMB32jdjm
        TD/rQJ8hMxi8pTHlhzNUYtuWDJadfXXPJD9wGAqGeABrOyPzyPtFOG1zKbnX7ucyMI5e+fZqxr1
        4E0bpPXFioLfZVGhG56k6FW3bw7A299cSiqXTgWoY
X-Received: by 2002:a17:906:16d4:b0:7b9:f0fd:47b1 with SMTP id t20-20020a17090616d400b007b9f0fd47b1mr2402060ejd.462.1669211405873;
        Wed, 23 Nov 2022 05:50:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7TcDEb99zr9yX79Qu7+GTLJM7BVi7LV+y79ONebrgHXbpuPdta2f2Ab9rl1yKFfhdFHqVDQHahSKGbYN9YYVY=
X-Received: by 2002:a17:906:16d4:b0:7b9:f0fd:47b1 with SMTP id
 t20-20020a17090616d400b007b9f0fd47b1mr2402053ejd.462.1669211405724; Wed, 23
 Nov 2022 05:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20221123065319.56756-1-zhengyongjun3@huawei.com> <CAK-6q+gWK3g-g+6ox240hEmVQu2xjq4ZfxGdO9AHoqKG-5Myfw@mail.gmail.com>
In-Reply-To: <CAK-6q+gWK3g-g+6ox240hEmVQu2xjq4ZfxGdO9AHoqKG-5Myfw@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 23 Nov 2022 08:49:54 -0500
Message-ID: <CAK-6q+gb074RyyfVnbkeQWiY7FDQf0j-jwJ0LfmM8ojafwy7-w@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH -next] fs: dlm: Fix build error without DEBUG_LOCK_ALLOC
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        zhengbin13@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 23, 2022 at 8:39 AM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Wed, Nov 23, 2022 at 8:37 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
> >
> > If CONFIG_DLM is y, DEBUG_LOCK_ALLOC is n, building fails:
> >
> > fs/dlm/lowcomms.o: In function `lowcomms_queue_rwork':
> > lowcomms.c:(.text+0x2ac): undefined reference to `lockdep_is_held'
> > lowcomms.c:(.text+0x308): undefined reference to `lockdep_is_held'
> > fs/dlm/lowcomms.o: In function `lowcomms_queue_swork':
> > lowcomms.c:(.text+0x3e0): undefined reference to `lockdep_is_held'
> > fs/dlm/lowcomms.o: In function `restore_callbacks':
> > lowcomms.c:(.text+0xd8c): undefined reference to `lockdep_is_held'
> > lowcomms.c:(.text+0xdcc): undefined reference to `lockdep_is_held'
> >
> > Make DLM select DEBUG_LOCK_ALLOC to fix this.
> >
>
> Thanks, there is a different approach already in dlm/next and I think
> we don't want to have dlm selecting a debug option.

btw. I am curious why lockdep defines a prototype and not an
implementation for it if LOCKDEP is not set. In my opinion there
should be some no-op functions for it that the compiler puts it out if
it's not set. Then we don't end in #idefs inside the implementation...

- Alex

