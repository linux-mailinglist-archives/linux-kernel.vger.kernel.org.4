Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE186FEF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbjEKJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237424AbjEKJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:56:52 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E393FF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:56:34 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7576deacbd6so291964585a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683798994; x=1686390994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SSI1132STpqumEpf5Ec2V/BEc2eB+fNK9tPTW1B97gw=;
        b=Nrx9UrUdsK+HUWMkWqBZ3TLP43oATk4+Hg2L6O/B52KpFdhsmhgxU0R59nQuNE1D6K
         RAqIIx/MyIBOmDErPHfk0NiYNjvGSagoMAQHx/zaBfuGNKkVbnefpTh6RV4rAkKKw5OJ
         o/9KjWLXQFoUqPTOk3L39Ql1q33x3UaGGBTTVQ4zgMyshDyYFtv4IfpPqR0MTk43NOWF
         +ZSiSJRj7TuobBu4y8zpryafBQzwhN2qLR/5wkr6PmZlejq/N74usVCz7rnWNa4dXaCM
         kkEuQGaEIcFcIrHJemeAQZb79a374m6vZI2Co0qvTlvr18XO9heswrGiytaankpJu7qN
         uzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798994; x=1686390994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSI1132STpqumEpf5Ec2V/BEc2eB+fNK9tPTW1B97gw=;
        b=PXTfmtP5L8m4R6HIS7gn3m5zwn1N+X8IlM284/YDyjIqw510gM1v2Suc15fjAa1jaz
         lqh+6ZlMZtesGgz/jSrzt4DIlTuyYI8N65vli2bmCz3Lo4bp0E5ZFpKE2+PqPyiF5Xfm
         4ot8gR6ZhQVYjWw7PLMA4ge7bza9W2H3BdJia3d8xiTrH6Vs8+t1JVtbPjUaDPt0PAlN
         Qhy7lCTFYH6BM6j2E2hGAP5Kz+jpB7HpgNlalsVfm+QuEHQTBtkjZt8UMazwFQJao4JI
         QyLTjRGm7eb6tnQgUh4ZOPQHgC+pTqi8prPGPbg5q2e/vmz+oRtFvGfX1t15X1FzYnLY
         PdqQ==
X-Gm-Message-State: AC+VfDzKLR7thuUud/5MwxUr2Iu5hE5LFFrOySn8upHbKwPIBDA1bCy1
        qY24JeCM6FAGf7guVr94cs1nv5H2loGlJ1BTO7TWMg==
X-Google-Smtp-Source: ACHHUZ5bi4evVw/MWVk/X4ejN7KBAO9fofHVgw5h5YbfPQNpRXCyI4vomN3J3/EutpsbTV9kvWDN2FQUML/KQYU0bxw=
X-Received: by 2002:a05:6214:27e1:b0:56e:a96a:2bdc with SMTP id
 jt1-20020a05621427e100b0056ea96a2bdcmr24213392qvb.40.1683798993806; Thu, 11
 May 2023 02:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230511021553.44318-1-zhangfei.gao@linaro.org> <20230511040508.GF3390869@ZenIV>
In-Reply-To: <20230511040508.GF3390869@ZenIV>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Date:   Thu, 11 May 2023 17:56:22 +0800
Message-ID: <CABQgh9HURQ9r32p7TOpznOhEYSJJ=0VrVrVZyA88mRHvR+Ksmg@mail.gmail.com>
Subject: Re: [PATCH] uacce: use filep->f_mapping to replace inode->i_mapping
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jean-philippe <jean-philippe@linaro.org>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux.dev, acc@lists.linaro.org,
        Weili Qian <qianweili@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 at 12:05, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, May 11, 2023 at 10:15:53AM +0800, Zhangfei Gao wrote:
> > The inode can be different in a container, for example, a docker and host
> > both open the same uacce parent device, which uses the same uacce struct
> > but different inode, so uacce->inode is not enough.
> >
> > What's worse, when docker stops, the inode will be destroyed as well,
> > causing use-after-free in uacce_remove.
> >
> > So use q->filep->f_mapping to replace uacce->inode->i_mapping.
>
> > @@ -574,12 +574,6 @@ void uacce_remove(struct uacce_device *uacce)
> >
> >       if (!uacce)
> >               return;
> > -     /*
> > -      * unmap remaining mapping from user space, preventing user still
> > -      * access the mmaped area while parent device is already removed
> > -      */
> > -     if (uacce->inode)
> > -             unmap_mapping_range(uacce->inode->i_mapping, 0, 0, 1);
> >
> >       /*
> >        * uacce_fops_open() may be running concurrently, even after we remove
> > @@ -589,6 +583,8 @@ void uacce_remove(struct uacce_device *uacce)
> >       mutex_lock(&uacce->mutex);
> >       /* ensure no open queue remains */
> >       list_for_each_entry_safe(q, next_q, &uacce->queues, list) {
> > +             struct file *filep = q->private_data;
> > +
> >               /*
> >                * Taking q->mutex ensures that fops do not use the defunct
> >                * uacce->ops after the queue is disabled.
> > @@ -597,6 +593,12 @@ void uacce_remove(struct uacce_device *uacce)
> >               uacce_put_queue(q);
> >               mutex_unlock(&q->mutex);
> >               uacce_unbind_queue(q);
> > +
> > +             /*
> > +              * unmap remaining mapping from user space, preventing user still
> > +              * access the mmaped area while parent device is already removed
> > +              */
> > +             unmap_mapping_range(filep->f_mapping, 0, 0, 1);
>
> IDGI.  Going through uacce_queue instead of uacce_device is fine, but why
> bother with file *or* inode?  Just store a reference to struct address_space in
> your uacce_queue and be done with that...

Yes, a struct address_space is enough.

>
> Another problem in that driver is uacce_vma_close(); this
>         if (vma->vm_pgoff < UACCE_MAX_REGION)
>                 qfr = q->qfrs[vma->vm_pgoff];
>
>         kfree(qfr);
> can't be right - you have q->qfrs left pointing to freed object.  If nothing
> else, subsequent mmap() will fail with -EEXIST, won't it?

Good catch, will fix it.

Thanks
