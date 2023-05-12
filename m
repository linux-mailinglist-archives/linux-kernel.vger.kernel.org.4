Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FF970093D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbjELNbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbjELNbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A136E1FCD
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683898218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ukyw32JRJGiabHOmgdKRXIVOrAFdfaiaSm7mhvRcLR8=;
        b=V6rntGoGxNP381ref2EzFixMhySjXqx7pA8FscemTfOJJf0ocXLFVd7nyVaFzFJ9Gc4Smp
        xkyofQuIgSxvpxN03+NT0VY/elj57w0ugNdYhC5/RWO3ByGhhavATxiuWk+e9KH7GguZwH
        RzzVSXVcgjcP4Z7r0qNu3B5VM6P5SDA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-r2QS19wLORer4lPFYUpEDg-1; Fri, 12 May 2023 09:30:17 -0400
X-MC-Unique: r2QS19wLORer4lPFYUpEDg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f420742d40so26062795e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683898216; x=1686490216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ukyw32JRJGiabHOmgdKRXIVOrAFdfaiaSm7mhvRcLR8=;
        b=LLidBvORWlZDjAIgk+78Q2oTg9nnzy4+gBpYXl3+/QNwg6krlMsG0rTeeb43GOSLLd
         qAahzfwtlPK/gWuwDM5tcJWvqOimh8OzeS+y6kWzHxYn1z7VbBLjthNPRoWLiiCOZIQf
         pTBPp14t+jywZdtNxRHqjFyc8cVN49byWGNh59fzkq/D2R07LYTngCXeOUSi4BL9J2Z9
         DAKaieP/EVObdCvTl8um6HypjBLbkKCDo+6eDxRaAtyswiLTM2hVyftRv2td69LP3mz1
         kbauLHpvRExcLOiWM0mmaI+CMbc33Kfc2F060u3BO5b6JvH3Zx4h+ioPp2520nPOU3pN
         tnLQ==
X-Gm-Message-State: AC+VfDzgtUg/nJte568dsoVszVDhhhDI5G3QCG0x1ZLMTjRfqlVU0i2X
        kYHbvwibsuPIrvcQsl4RY0qe7363RJtRKgSSrRpw8wjNDQaKWDJowPvHw0S24oVk0TQYmiYyXH5
        EbkU/bc5Q8ZrOY9O2aDpdMqfKlGfcNchN
X-Received: by 2002:adf:ee49:0:b0:306:2701:5346 with SMTP id w9-20020adfee49000000b0030627015346mr18528763wro.39.1683898215931;
        Fri, 12 May 2023 06:30:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4F10zBx+Lys1LHJzFIqbci4nxbtSgAdy2EOozucQR2jHZDFL9MLbYUg4Mew1HRJ6TnFGHMEQ==
X-Received: by 2002:adf:ee49:0:b0:306:2701:5346 with SMTP id w9-20020adfee49000000b0030627015346mr18528743wro.39.1683898215596;
        Fri, 12 May 2023 06:30:15 -0700 (PDT)
Received: from redhat.com ([31.187.78.61])
        by smtp.gmail.com with ESMTPSA id c22-20020a7bc016000000b003f4e3ed9912sm6660077wmb.46.2023.05.12.06.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:30:14 -0700 (PDT)
Date:   Fri, 12 May 2023 09:30:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     Feng Liu <feliu@nvidia.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Gal Pressman <gal@nvidia.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Message-ID: <20230512093000-mutt-send-email-mst@kernel.org>
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
 <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
 <20230504145110-mutt-send-email-mst@kernel.org>
 <8e1f076cb09560ee2bcda2092c0de10a701ba00b.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e1f076cb09560ee2bcda2092c0de10a701ba00b.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 12:51:21PM +0000, Dragos Tatulea wrote:
> On Thu, 2023-05-04 at 14:51 -0400, Michael S. Tsirkin wrote:
> > On Thu, May 04, 2023 at 01:08:54PM -0400, Feng Liu wrote:
> > > 
> > > 
> > > On 2023-05-04 a.m.9:50, Dragos Tatulea wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > The referenced patch calls set_vq_affinity without checking if the op is
> > > > valid. This patch adds the check.
> > > > 
> > > > Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading
> > > > mechanism")
> > > > Reviewed-by: Gal Pressman <gal@nvidia.com>
> > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > ---
> > > >   drivers/virtio/virtio_vdpa.c | 4 +++-
> > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > index eb6aee8c06b2..989e2d7184ce 100644
> > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > @@ -385,7 +385,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device
> > > > *vdev, unsigned int nvqs,
> > > >                          err = PTR_ERR(vqs[i]);
> > > >                          goto err_setup_vq;
> > > >                  }
> > > > -               ops->set_vq_affinity(vdpa, i, &masks[i]);
> > > > +
> > > > +               if (ops->set_vq_affinity)
> > > > +                       ops->set_vq_affinity(vdpa, i, &masks[i]);
> > > if ops->set_vq_affinity is NULL, should give an error code to err, and
> > > return err
> > 
> > Given we ignore return code, hardly seems like a critical thing to do.
> > Is it really important? affinity is an optimization isn't it?
> > 
> > > > 
> set_vq_affinity is optional so it's not an error if the op is not implemented.
> 
> Is there anything else that needs to be done for this fix?
> 
> Thanks,
> Dragos
> 

no, it's queued already.

