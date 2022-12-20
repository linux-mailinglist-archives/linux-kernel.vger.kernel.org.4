Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC34651C43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiLTIWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTIWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:22:13 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFFF17583
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 00:22:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id tz12so27376697ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 00:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wMwS7WLNWaoVi/REwG5yN+1a1pFqvysrZT/BbFemtwk=;
        b=7v/S3Dxe78SOlFIpDTj7jv0M6jDTNxrSfweD+m5d8x5mqswiGbWL0bhEhMvL+FnNyJ
         U1MqBj/JzCD9t+xeca3OTuF8D0r1LlVWE75kIZh2Aj1g/1RpQe/O7bywRlaWFhPLrGrR
         3p+X3P4RjzPGOSChw6sco3VsKyClk7PvBIvijSI4cRjiEQGvdMNDHBP8LLpd3lOIiAmV
         uQ7STY3wIqvcMYowwJuVLHQxcxLvYZtJ9lhin/+tk6xrHKh1zM0WiYvVUhCoFxz4hmrI
         vsPcHvaR0Rs0MGIhECf9QqtB4V/64eeDkUK+wNlKvKdlZKgoZdjvbgwSCwIV+TewZVQ2
         6s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMwS7WLNWaoVi/REwG5yN+1a1pFqvysrZT/BbFemtwk=;
        b=lEySVmAq4plkMvHaCp90YFrQUO3I1nOIkEHTSCjFhVNlq5/oVf2xElzb067z6YyoJ2
         fW9V6QMFb4WZQ1lgMDaYOXQLArlIBeLd0k8f4a4HUeg5B4ckYQ/DlYK1wMriqpLAJswN
         2ioD58k8ScrSCVpLsVOQXYaJUFPVOr3icbCz1QhGJ0qSm0ECanhWzcVqsqBKpCYBylP0
         aXtSg7iaLVPbro6tVLQ8WAelw/bZFlTwBJe5lrg/c8OKPvx4U8TuJOfaSKp2wrw3xUtW
         LvOcO0OgwoWf3P8JndAhOqHcBCQN4XDBuHUoTnWsJ0Aw18E4SChJdq0UVTOVnwJfNFml
         tQfA==
X-Gm-Message-State: ANoB5pk6nc8i94+qf056N154vWImen5pOeZE/OlL+pz8Ra2GHNaJziLX
        GPd0Dw5nALV89eBFUWx02+2Ixrn26Q7Ca+autNkS
X-Google-Smtp-Source: AA0mqf6zdu4O/r+OMgyDPlupNjTeQliqNGPybNEWHY6OXMk6CGz8idX5g77MEJjruNNoJKB5AxxGjbrBMx68ForvTG0=
X-Received: by 2002:a17:906:265b:b0:7c1:6fdf:3b70 with SMTP id
 i27-20020a170906265b00b007c16fdf3b70mr2022199ejc.619.1671524530469; Tue, 20
 Dec 2022 00:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205085846.741-1-xieyongji@bytedance.com>
 <CACGkMEuhYO3neFmxwiBp8C0QTaa+Mb13kken+RZ9QuruMct6tA@mail.gmail.com>
 <CACycT3vu0_xCG7SvdP-zkZkuOGdudx2apOwi3CZ4MOFSe-XAFg@mail.gmail.com> <CACGkMEs9nD--8y-dKsv23OK6G7LAC5dLDRRT8sKA5dUrAo0QbQ@mail.gmail.com>
In-Reply-To: <CACGkMEs9nD--8y-dKsv23OK6G7LAC5dLDRRT8sKA5dUrAo0QbQ@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 20 Dec 2022 16:21:57 +0800
Message-ID: <CACycT3uv0KD679uVPCVWj=vW1EZOTKc2qbp8N-cc5Q6i1=R6vQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] vduse: Support automatic irq callback affinity
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 2:32 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Dec 19, 2022 at 12:56 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Fri, Dec 16, 2022 at 1:30 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Mon, Dec 5, 2022 at 4:59 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > >
> > > > This brings current interrupt affinity spreading mechanism
> > > > to vduse device. We will make use of irq_create_affinity_masks()
> > > > to create an irq callback affinity mask for each virtqueue of
> > > > vduse device. Then we will choose the CPU which has the lowest
> > > > number of interrupt allocated in the affinity mask to run the
> > > > irq callback.
> > >
> > > This seems a balance mechanism but it might not be the semantic of the
> > > affinity or any reason we need to do this? I guess we should use at
> > > least round-robin in this case.
> > >
> >
> > Here we try to follow the pci interrupt management mechanism. In VM
> > cases, the interrupt should always be triggered to one specific CPU
> > rather than to each CPU in turn.
>
> If I was not wrong, when using MSI, most arch allows not only the
> cpuid as the destination but policy like rr and low priority first.
>

I see. I think we can remove the irq effective affinity and just use
the irq affinity. If the irq affinity mask contains more than one CPU,
we can use round-robin to spread IRQ between CPUs. But the sysfs
interface for irq affinity should be writable so that someone wants to
stop round-robin and pick one CPU to run irq callback.

Thanks,
Yongji
