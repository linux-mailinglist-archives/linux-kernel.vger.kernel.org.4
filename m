Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0305ED9BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiI1KEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiI1KDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB6F1D44
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664359394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uGN/gn+YJZ4VIu5yaP7PXBIwmM0Ss1jImh/D5mV3zS0=;
        b=YLR5qZwW23DTerVqwkrNXEow/mMw1EyIJ+zmpstf05xcEjlfnV06FjEHRisXSgs5yLjJMr
        mNj+FE+F1ISuxHigp27nUdfXvHGWPZl1TmSqDdfcO6JBUO+UL81MfYPfTAtUTarmmTxnZv
        Bc//qWIEqQo9AD5wTLU0EfGrXI/0QG4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-4ZLEbh9GPHirM-J-QBuZ9Q-1; Wed, 28 Sep 2022 06:03:13 -0400
X-MC-Unique: 4ZLEbh9GPHirM-J-QBuZ9Q-1
Received: by mail-wm1-f72.google.com with SMTP id i129-20020a1c3b87000000b003b33e6160bdso922945wma.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uGN/gn+YJZ4VIu5yaP7PXBIwmM0Ss1jImh/D5mV3zS0=;
        b=vHdJjF5kCIcCKCEpyA3AoxAJl3c1IxKY0HInitX8MLY+4tUB6z6Emilk4+YlW9O+Zw
         kT9t6zbhuaYWbFpvwZ/Oj5OsXcECKJIC54RvsVFZYmRHrTr+/n4SXHOfLJ6/WzNYFY7z
         RvFSiEbqJkoABnl3em9MISttfV8j15LEdmjSZFVQYTc8swKU7DPJ0nCrR/3q8TtmloUh
         m4cSX094kSwPUsFcCDbfUiMWdl54Z03RdyQg2vPx4Hyzm4n3PUKMP2SY2iprkKuaCTGD
         FudpVV9kmGv95S/7LsBvFCgYj1o9EH9ymKzxSL4WRplAx7fd1NSly9kmyOwFP5VBcCQ0
         n1Fw==
X-Gm-Message-State: ACrzQf0J38NtjwdFQw1wvp8TR1Xc9tdbjerZRk/IgX28Og7DWv2giYAw
        FnGykLnwbhg+ioW6yubMCl4JMg7bi4DkvsJKzF702h64ooYAHeYlhYkCSJrU1ZfOFAx1sjVXa1O
        zY7w59UXwH3pYVuPBoxiZkyG1
X-Received: by 2002:a05:6000:1845:b0:22a:4b7a:6f55 with SMTP id c5-20020a056000184500b0022a4b7a6f55mr19857125wri.288.1664359392583;
        Wed, 28 Sep 2022 03:03:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6DD+7gws/rgYCF8YbDNblzEgE00DKcFR13//n9kKka+r2jpPDo/QMjf3VuTYnwOCnvOIKbew==
X-Received: by 2002:a05:6000:1845:b0:22a:4b7a:6f55 with SMTP id c5-20020a056000184500b0022a4b7a6f55mr19857103wri.288.1664359392370;
        Wed, 28 Sep 2022 03:03:12 -0700 (PDT)
Received: from redhat.com ([2.55.17.78])
        by smtp.gmail.com with ESMTPSA id q16-20020adfcd90000000b0022cbf4cda62sm4051657wrj.27.2022.09.28.03.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:03:11 -0700 (PDT)
Date:   Wed, 28 Sep 2022 06:03:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Angus Chen <angus.chen@jaguarmicro.com>, jasowang@redhat.com,
        pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liming Wu <liming.wu@jaguarmicro.com>, stefanha@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Message-ID: <20220928055718-mutt-send-email-mst@kernel.org>
References: <20220924034854.323-1-angus.chen@jaguarmicro.com>
 <20220927163723-mutt-send-email-mst@kernel.org>
 <20220928094545.GA19646@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928094545.GA19646@lst.de>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:45:45AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 27, 2022 at 04:47:20PM -0400, Michael S. Tsirkin wrote:
> > > The log :
> > > "genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
> > > was print because of the irq 0 is used by timer exclusive,and when
> > > vp_find_vqs called vp_find_vqs_msix and return false twice,then it will
> > > call vp_find_vqs_intx for the last try.
> > > Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
> > > flag IRQF_SHARED.
> > 
> > First this is a bug. We can fix that so it will fail more cleanly.
> > 
> > We should check pci_dev->pin and if 0 do not try to use INT#x
> > at all.
> > It will still fail, just with a nicer backtrace.
> 
> How do we end up with a pci_dev without a valid PIN?

This patch is broken but there's no v3 which looks right,
and includes an explanation.

>  Btw, that whole
> vp_find_* code looks extremely fucked up to me.  The whole point of
> pci_alloc_irq_vectors* API is that it keeps drivers from poling into
> details of MSI-X v MSI vs INTX.

Poking? I think that code predates that, a minimal change was
made to support affinity... but again, it does not look like the
main issue has anything to do with that. Or maybe I'm wrong ...

> > - because of auto affinity, we try to reserve an interrupt on all CPUs
> > - as there are 512 devices with a single vector per VQ we would
> >   have no issue as they would be spread between CPUs,
> >   but allocating on all CPUs fails.
> > 
> > 
> > I don't think the issue should be fixed at blk level - it is not
> > blk specifix - but yes this looks like a problem.
> > Christoph, any idea?
> 
> I think this goes into the low-level interrupt vector allocator.  I think
> Thomas is still the expert on it.

syzbot is also telling us there's an issue in next (and not due to
virtio changes - I intentionally removed most of them for a while
and the issue was there) but I could not figure it out.

-- 
MST

