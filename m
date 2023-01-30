Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5EF680C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjA3Lyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjA3Lyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:54:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5A012F39
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:54:07 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y11so10680891edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAvRFvLZnDSx1Ofa80BIu0AbOJbsf1pLrTIlCYr8QlM=;
        b=kbDRblPiplt86rjhUv7msf1/n8EGk/PntBfg2OWLugBPEopEDUpyhQQAxwcOL3UcoK
         Hez0GAO21XmDYAtaejoOqJJ9UwHagO49v96evOkPv3nJ4cCoA4Rq8vC4sNh71dSFlD8r
         /J/qK7OPTNMRNXgckymHhaNHf7wQobnruNrA9ZXRPHXRkncS01BaH/bTayCOWsGo7ggs
         yLdvXM9W/kVpcj2Z3J8DGGUx35XNHTsORu1+sko5XeMyadgjTFzChh/chVIMZnWESwwW
         xCvESY33Q6suMMqPGQ1ONsmPkzjkidak1Hx2EzRYDeddTisq/Aa3l3ZMYdEC3nZoM4U2
         +ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAvRFvLZnDSx1Ofa80BIu0AbOJbsf1pLrTIlCYr8QlM=;
        b=hHbIvk8l4BwlSaRjwReUVRK3Ufh7fdNaRss57Jc0IZQ3FPvTVr9o/aZsRPoYXCGzYu
         MifumemUcvxUpUbUMPNX1NCRPPlq9rrwcA7Y/xarCaRjbMicU7FZ1KNmEogq5zL3OjLX
         DZTdxiT7Aw2+2kNfIJdzACKRhDeQ8zfrKkP0TguH3DncGId0qN4Hz6S0OwHdR8PhhA+r
         vitV9Rwp6Rac+nVy4o1pfDj4a59Kt76YwugxWZlfvUstnSK1yE6z89kEZsajuz2DoZWw
         wnnNYkNlEuD9RjVnxUXOwPP8t6fW9YBuo0dCEmqTlJcN5ilYUMCjg7TFVZAYoUyJnLQD
         iMCw==
X-Gm-Message-State: AFqh2kq+u+FvaDCUPDGUXxHC2a6rcMp+zAerWGJwFNxOEBF1Q6wsnuWw
        EQaObQsU9sYGiS1Jz3QCdpsCJrhs7C7zeuvCsqostizrvgQV
X-Google-Smtp-Source: AMrXdXvMdbkVNZiXROvCyCgf9Tbix3Ek0gWj+81Jo1m5WfxR+Zk1xtxlL/SDKQC8PAl/gABxS2XJcAveR+bE3iDLbG8=
X-Received: by 2002:a50:a44e:0:b0:49e:36d1:16e with SMTP id
 v14-20020a50a44e000000b0049e36d1016emr9312581edb.42.1675079646043; Mon, 30
 Jan 2023 03:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-2-xieyongji@bytedance.com>
 <20221219023253-mutt-send-email-mst@kernel.org> <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
 <20230127032039-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230127032039-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 30 Jan 2023 19:53:55 +0800
Message-ID: <CACycT3u=vULuZ9-ZakBjxmbu88iUb+xB2mHJUnHA_8SuUV7H4w@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export irq_create_affinity_masks()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
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

On Fri, Jan 27, 2023 at 4:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 19, 2022 at 05:36:02PM +0800, Yongji Xie wrote:
> > On Mon, Dec 19, 2022 at 3:33 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Mon, Dec 05, 2022 at 04:41:17PM +0800, Xie Yongji wrote:
> > > > Export irq_create_affinity_masks() so that some modules
> > > > can make use of it to implement interrupt affinity
> > > > spreading mechanism.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > >
> > > So this got nacked, what's the plan now?
> > >
> >
> > I=E2=80=98d like to check with Christoph again first.
> >
> > Hi Christoph,
> >
> > Jason will post some patches to get rid of the DMA API for vDPA
> > simulators. And the irq affinity algorithm is independent of the IRQ
> > subsystem IIUC. So could you allow this patch so that we can reuse the
> > algorithm to select the best CPU (per-cpu affinity if possible, or at
> > least per-node) to run the virtqueue's irq callback.
> >
> > Thanks,
> > Yongji
>
> I think you need to explain why you are building low level
> affinity masks.

In VDUSE case, we use workqueue to run the virtqueue's irq callback.
Now I want to queue the irq callback kwork to one specific CPU to get
per-cpu affinity if possible, or at least per-node. So I need to use
this function to build the low level affinity masks for each
virtqueue.

> what's the plan now?
>

If there is no objection, I'll post a new version.

Thanks,
Yongji
