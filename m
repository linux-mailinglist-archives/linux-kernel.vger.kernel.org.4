Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6E650960
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiLSJgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiLSJgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:36:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E2323
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:36:14 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id tz12so20001154ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ+7/YEsXJ7o3MIvJQtFoH4Ilg02irItFRDq+mzHVhM=;
        b=3KsvzaTy47qpFjnZo4fpiciMNYLqBHqstjV32MgfjMx9ZKrCxSkk7LpjIiMRTugzX3
         ToeS0j263iNm3r/f7V9DfIB8iuMDyejjly0R8fvAejpwICvK3IVAO1XXIMnaIkIbFQq1
         iLJBsTUtkQUuju7o2VTNY0/Swr3fqfZMPfSqhQbqp1f28KUatS/q2Zngluy6hmoxP6o5
         104m6zkH+FoEPkNmSSUIW7tWI1VkCgggK32/2rlmODcqowKn8cbC2fIhm2SHjNtjqZjg
         HRcy5Margr+K02XCWIrbiM4rqF5ulHOCOzpzaTTjnMMYc726imawZK2X8vTGGyvs8U+S
         OGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQ+7/YEsXJ7o3MIvJQtFoH4Ilg02irItFRDq+mzHVhM=;
        b=0GUscl7WQaLHMSJQafZFGkXv42Mvb0RVCjHmFRTq3ISLxqBHbAwNZtp15pjG/ifr8L
         WYkbZ8N4Dx5iKOHTBeji0M1ouj1Gkxvzt4YtXmygGsNjzYdQiYS9nCDs8HzfeJVf1J3j
         eoDzS6xSDcH+qiJ/euHJNBeMtZ2IIGttsuwzYkhFLUoZ52R6Ld+ffA4NZAALGl5bAsmE
         Tlo24WN803F0odwGe6Ia9MhLNwnnAcPZcCAWaZxXkCPoospsnnoNanoU1Zwlfar25Ssk
         Dw5ZkTieczFBc6S4y8273HSZXShArmJY93xT8xgmol75HvrB6+YQQzQ3LXLJsvsf2o4F
         HAIw==
X-Gm-Message-State: AFqh2kquvM9AzIgLMeyOcREQR2a/Ce3gUBBKPolGqMmFRCx1NhAr4FT1
        cVc7ebu/vixfMCKBWeZgLJtF2zSgrVshri58c5hL
X-Google-Smtp-Source: AMrXdXsc5/rW2emwKx61lspcXjQgxHBtu3WB/OOI2ui0Dmp+iqx/vbFip4Hhh8YojbsqbprN75Mp5kBdNCPts+o2gOM=
X-Received: by 2002:a17:907:d68e:b0:7de:de2c:7bbe with SMTP id
 wf14-20020a170907d68e00b007dede2c7bbemr1494069ejc.141.1671442573461; Mon, 19
 Dec 2022 01:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-2-xieyongji@bytedance.com>
 <20221219023253-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219023253-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 19 Dec 2022 17:36:02 +0800
Message-ID: <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export irq_create_affinity_masks()
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 3:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 05, 2022 at 04:41:17PM +0800, Xie Yongji wrote:
> > Export irq_create_affinity_masks() so that some modules
> > can make use of it to implement interrupt affinity
> > spreading mechanism.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
> So this got nacked, what's the plan now?
>

I=E2=80=98d like to check with Christoph again first.

Hi Christoph,

Jason will post some patches to get rid of the DMA API for vDPA
simulators. And the irq affinity algorithm is independent of the IRQ
subsystem IIUC. So could you allow this patch so that we can reuse the
algorithm to select the best CPU (per-cpu affinity if possible, or at
least per-node) to run the virtqueue's irq callback.

Thanks,
Yongji

> > ---
> >  kernel/irq/affinity.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > index d9a5c1d65a79..f074a7707c6d 100644
> > --- a/kernel/irq/affinity.c
> > +++ b/kernel/irq/affinity.c
> > @@ -487,6 +487,7 @@ irq_create_affinity_masks(unsigned int nvecs, struc=
t irq_affinity *affd)
> >
> >       return masks;
> >  }
> > +EXPORT_SYMBOL_GPL(irq_create_affinity_masks);
> >
> >  /**
> >   * irq_calc_affinity_vectors - Calculate the optimal number of vectors
> > --
> > 2.20.1
>
