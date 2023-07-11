Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265BB74E5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGKEG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGKEGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAB1135
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689048337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sanp52G7qe4emaxcQItrkn4g0y24nEg66UbSkbqz794=;
        b=e+Z9cLEzq+yZ4M+eUzzHl1G9CV6nL7emo9Qy+kzQciQ9BDP/ymVgNPUOLVUaaisUVpYQED
        w1yU5zwUEOTdjmAp/6m5g32Y33Y7I3hqd8PZhvt+mTJAExxHB9b2kVvZTUgl94LqRTxsoG
        JtaYX65U+J+9kvga/ayGgt4vfGpasAI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-usLv1MgwPzqyMLFYEeDmjQ-1; Tue, 11 Jul 2023 00:05:36 -0400
X-MC-Unique: usLv1MgwPzqyMLFYEeDmjQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6351121aa10so55607866d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689048336; x=1691640336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sanp52G7qe4emaxcQItrkn4g0y24nEg66UbSkbqz794=;
        b=E6FRnouoEweQig7fswyPWzicvFBr/BO1vnSBn7dKC9zHShraaW9eCcuJHtYReMyqMZ
         rR1vxwj6GRO5B2sHtRrT6zFnJHDLYYBafFTJLsLIKpf2jdv5loyyjD59IXVOYm3S7qfQ
         exHpKTaz3rEnRs3NhKJUHpfUh789JFvAwSKdhDGSz73MVBIInfE2iW7mLUxXjHwesewH
         BmiSxsfd9KeWUnSdmcTmPf5dpvmRB4a+ZWZVYXcMkTHflNRZBWLwi0pgLSgJDF2JW0+g
         KNmuA8G+vbysbh6OkHDtfEVdDsMXVUoCHgxph+8c/bwRU1TejBo+C45EnSonvpRoNtTP
         1hnQ==
X-Gm-Message-State: ABy/qLYTZ6bIWhIW7r7xm5p3kcNUo+eGn7VYkLWBeB6R9dKtaim1N89F
        4WfFq03v3yncLz36FUOfkLP3auHwf15fyDl/n53rVNZZZcjhZ6FYaxnv5VQ8mz2T39netExrXt3
        xHA493AeLYYd4nOSHftBgz6rIs9fDvOgHvKxgAv/w
X-Received: by 2002:a0c:e44d:0:b0:62d:ef66:ff1c with SMTP id d13-20020a0ce44d000000b0062def66ff1cmr12076653qvm.24.1689048335874;
        Mon, 10 Jul 2023 21:05:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGTtnbv4lplqsuwMA0lcF/2QRhbSnqCLDEDGVhD6GZ6v3vRL7xgj3ixm6UdOxJvERNjVYrT8Aw+QUQlev+2Ls=
X-Received: by 2002:a0c:e44d:0:b0:62d:ef66:ff1c with SMTP id
 d13-20020a0ce44d000000b0062def66ff1cmr12076645qvm.24.1689048335643; Mon, 10
 Jul 2023 21:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230708020259.1343736-1-ming.lei@redhat.com> <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de> <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
In-Reply-To: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
From:   Pingfan Liu <piliu@redhat.com>
Date:   Tue, 11 Jul 2023 12:05:24 +0800
Message-ID: <CAF+s44T5Hn5ikNq+YMp2Nucb6rBT=e4VHW8WN8YDhZHe9JmqGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

Having no [PATCH 1/2] blk-mq: add blk_mq_max_nr_hw_queues() in inbox.
So I reply here.

At first glance, I think that  the cpu hot plug callback hook should
be the remedy for the newly introduced blk_mq_max_nr_hw_queues(),
although it is more complicated.

Consider the scene where nr_cpus=3D4, which can speed up the dumping
process, the blk_mq_max_nr_hw_queues() can not utilize the other three
cpus.


Thanks,

Pingfan

On Mon, Jul 10, 2023 at 5:16=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > Take blk-mq's knowledge into account for calculating io queues.
> > >
> > > Fix wrong queue mapping in case of kdump kernel.
> > >
> > > On arm and ppc64, 'maxcpus=3D1' is passed to kdump command line, see
> > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > still returns all CPUs.
> >
> > That's simply broken.  Please fix the arch code to make sure
> > it does not return a bogus num_possible_cpus value for these
>
> That is documented in Documentation/admin-guide/kdump/kdump.rst.
>
> On arm and ppc64, 'maxcpus=3D1' is passed for kdump kernel, and "maxcpu=
=3D1"
> simply keep one of CPU cores as online, and others as offline.
>
> So Cc our arch(arm & ppc64) & kdump guys wrt. passing 'maxcpus=3D1' for
> kdump kernel.
>
> > setups, otherwise you'll have to paper over it in all kind of
> > drivers.
>
> The issue is only triggered for drivers which use managed irq &
> multiple hw queues.
>
>
> Thanks,
> Ming
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

