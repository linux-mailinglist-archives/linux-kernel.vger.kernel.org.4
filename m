Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21FA65907F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbiL2Sja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiL2Sj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:39:27 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69B3207
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:39:26 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id v70so17782340oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YL1+jd+bqxEYuNhsfkKoW4Bib0tbO/GWG1d3h67uOqo=;
        b=RqetY5wq3Isg0XpDwrtgF58pMUZ91i3hZQu1kIW/923plJ95a91r8xq2bp9eQz8ztu
         LXaqbR48IrAunbPdY/ItJ2X63rtW1mptuS+uc18XNwHqA10P7wWlBvac79bXmFvgvmst
         D38bUiT123LS6MRFw5oPXHNBsIL7QVoxH2LR+WRb9BjM4NwWaCDAzAO3EU2vC5/BRLoI
         x2v21MSTjSu7REXira0bwgbrODiznCOTX/M08qfqq39q1WOmKEUHZrS34aw3Q0jV7asU
         fEa9/VDLt6g23id++bl7x/yA2FaN+4WAiCiKzfStkoUVGsh5kC+oXUxd8hGPauFxFl7q
         QqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YL1+jd+bqxEYuNhsfkKoW4Bib0tbO/GWG1d3h67uOqo=;
        b=XH/rtiIaHV4fVgx6jbjrZ+uxrrt+vFNpRzgEIr8UDTjIQaqXrenS6jP8tQsXL74TOz
         U6NLgWtwiaoZQ9hEfFEF3J6QtlVNjKTWzSWneyP28EldD18kukgBq5Q71NvIPR2uHpCt
         uz2SQdL6uSTrUjhW/a4d2mTue15kV1eeGgvZnWIDwsleoIVvKJNwztJd0oEqJot4FoJP
         E5DNZneRkkYIARRVRzq2xSPuygQhMvaTLoMf5ES+kIQ3zfCsQyxlECx5LMGveEhfQlxy
         jo5k8xc3etx3WUDOhPPAKQV5bPJXJvAxOKMdFulI6iCXZ99uKPEiB0JQxsCsQguKN2Ae
         UyTw==
X-Gm-Message-State: AFqh2krRKXEP4p/NZX6lFQaJP1nM4jiBeDdDCOvcLJBdmTmXfvrwujcZ
        i0qBKostHSOubEl4cDBiA/4Q5COwqABXhzBWwziL+9eBCTw=
X-Google-Smtp-Source: AMrXdXsENIQJahUj9UFgrkh5/8IScjIPoncvjIGWSO7C76fOzgfaDskmNsrRotPE1nZcskTQO1LK7Ir95OCeh9xUqSk=
X-Received: by 2002:a05:6808:7ce:b0:35e:250d:abc1 with SMTP id
 f14-20020a05680807ce00b0035e250dabc1mr1194682oij.222.1672339165839; Thu, 29
 Dec 2022 10:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20221229060549.3976570-1-ztong0001@gmail.com> <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Thu, 29 Dec 2022 10:39:15 -0800
Message-ID: <CAA5qM4Djc+5p45+isj5Vn47erUR6rY32n-2Epkkx1Pv-PX8wRg@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: free irq properly when cannot create adminq
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        t.zhang2@samsung.com
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

On Thu, Dec 29, 2022 at 10:04 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Dec 28, 2022 at 10:05:49PM -0800, Tong Zhang wrote:
> > nvme_pci_configure_admin_queue could return -ENODEV, in this case, we
> > will need to free IRQ properly. Otherwise following warning could be
> > triggered
> >
> > [    5.286752] WARNING: CPU: 0 PID: 33 at kernel/irq/irqdomain.c:253 irq_domain_remove+0x12d/0x140
> > [    5.290547] Call Trace:
> > [    5.290626]  <TASK>
> > [    5.290695]  msi_remove_device_irq_domain+0xc9/0xf0
> > [    5.290843]  msi_device_data_release+0x15/0x80
> > [    5.290978]  release_nodes+0x58/0x90
> > [    5.293788] WARNING: CPU: 0 PID: 33 at kernel/irq/msi.c:276 msi_device_data_release+0x76/0x80
> > [    5.297573] Call Trace:
> > [    5.297651]  <TASK>
> > [    5.297719]  release_nodes+0x58/0x90
> > [    5.297831]  devres_release_all+0xef/0x140
> > [    5.298339]  device_unbind_cleanup+0x11/0xc0
> > [    5.298479]  really_probe+0x296/0x320
> >
> > Fixes: a6ee7f19ebfd ("nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable")
>
> Right. It's really only needed when called from probe as the reset_work
> handles the cleanup when called from there, but this is safe for both
> cases.
>
> > @@ -2584,8 +2584,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
> >       pci_enable_pcie_error_reporting(pdev);
> >       pci_save_state(pdev);
> >
> > -     return nvme_pci_configure_admin_queue(dev);
> > +     result = nvme_pci_configure_admin_queue(dev);
> > +     if (result)
> > +             goto free_irq;
> > +     return result;
>
> Since you're already in this function, you should also add a "goto
> disable" if pci_alloc_irq_vectors() fails. Right now it just returns
> with the pci device still enabled, and it won't get disabled from probe.
>

Thank you Keith! I have added this fix and sent a v2.
- Tong

> > + free_irq:
> > +     pci_free_irq_vectors(pdev);
> >   disable:
> >       pci_disable_device(pdev);
> >       return result;
> > --
