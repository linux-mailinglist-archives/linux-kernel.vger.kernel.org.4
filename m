Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1B9644419
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiLFNHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiLFNHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:07:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0292C130
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:05:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so6007314pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 05:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsirKpdP0CfKhoTgNVDEM5IiWovPwvVngaB5BGDoZKs=;
        b=IAnD9feziYzBDgH1vGA42RRh++QMPgElSoKUznefAOBu9T3PXWYquBguGryhoChzGU
         v4Lar+22f9uVJ0gD5vNYOsj7hSddLV6fF0C4jtmnhRcMiN5Be0NOIlOel2eytI4om9ii
         a67BNM6uqOjXVj+hCDI5eGPMCFBo82SecZ2GXlTvXd4DejBOuQPNlbJ+Hhb1sX5Cx5yP
         aM9Lw+2xXWYKXol7LmNlMvvNew1Y5y0tKhaTQcdndNCtylOEfqfkcYlWUoSEHfVk2Y14
         XL3mxcRF+MiF+rdDQFZT6nhQCxZETmhOt9JupdXPSYelXmBXqqm2LL54ECcvtuDKjPGS
         4qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsirKpdP0CfKhoTgNVDEM5IiWovPwvVngaB5BGDoZKs=;
        b=isbWMfnqBXcZVPHiPX5d0jUwPU9SbpDBpSmHP5YP+fxeBM3eaODce0ohKvnO0SAX7M
         obkx3KG0mZV+XEoWO4GwJYRoi/7qG0/Nph76SSNyTIAZVl8dtOxcYmWuxyqTPLLe1dyc
         7CpEyRyJJ9b6+Xe/wXqIkLzatjpxtK/3KeeReNgPYjghBKy2O0s+ZRcVqro12DcQliyj
         sdjB55xldSwcoEnrRfJbrd5MvZOpTu5bgWmvbAV1afYUhpuZftKc1B1pMrhR2eRzKqRU
         +gWIG20WK1WfqrFoRD4sExb4nVWkNhUWD1GsadLuxB7V8nlt8P8u7MyTMmcBlCxs1Q8K
         nhyw==
X-Gm-Message-State: ANoB5pnTbGM/vPGHlnPmqjvHjSt6plkJvFFCukbWY0U66ctaGgb22bEV
        iOqD6FzkpvPAUvOoKJ4E6N+ftQ==
X-Google-Smtp-Source: AA0mqf4uiCr4rEXdMlHinSQYsz6GcoLqrKx0r6b8L4mWTRaRwDt/z11/nLxpi39beGa9Sv0DQXmnNQ==
X-Received: by 2002:a17:902:9881:b0:188:62b8:2278 with SMTP id s1-20020a170902988100b0018862b82278mr75419515plp.96.1670331907871;
        Tue, 06 Dec 2022 05:05:07 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b00174c1855cd9sm12461140pll.267.2022.12.06.05.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:05:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1p2XdB-004arD-HJ;
        Tue, 06 Dec 2022 09:05:05 -0400
Date:   Tue, 6 Dec 2022 09:05:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lei Rao <lei.rao@intel.com>, kbusch@kernel.org, axboe@fb.com,
        kch@nvidia.com, sagi@grimberg.me, alex.williamson@redhat.com,
        cohuck@redhat.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
        eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
        Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Message-ID: <Y48+AaG5rSCviIhl@ziepe.ca>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-6-lei.rao@intel.com>
 <20221206062604.GB6595@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206062604.GB6595@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 07:26:04AM +0100, Christoph Hellwig wrote:
> all here).  In Linux the equivalent would be to implement a mdev driver
> that allows passing through the I/O qeues to a guest, but it might

Definately not - "mdev" drivers should be avoided as much as possible.

In this case Intel has a real PCI SRIOV VF to expose to the guest,
with a full VF RID. The proper VFIO abstraction is the variant PCI
driver as this series does. We want to use the variant PCI drivers
because they properly encapsulate all the PCI behaviors (MSI, config
space, regions, reset, etc) without requiring re-implementation of this
in mdev drivers.

mdev drivers should only be considered if a real PCI VF is not
available - eg because the device is doing "SIOV" or something.

We have several migration drivers in VFIO now following this general
pattern, from what I can see they have done it broadly properly from a
VFIO perspective.

> be a better idea to handle the device model emulation entirely in
> Qemu (or other userspace device models) and just find a way to expose
> enough of the I/O queues to userspace.

This is much closer to the VDPA model which is basically providing a
some kernel support to access the IO queue and a lot of SW in qemu to
generate the PCI device in the VM.

The approach has positives and negatives, we have done both in mlx5
devices and we have a preference toward the VFIO model. VPDA
specifically is very big and complicated compared to the VFIO
approach.

Overall having fully functional PCI SRIOV VF's available lets more
uses cases work than just "qemu to create a VM". qemu can always build
a VDPA like thing by using VFIO and VFIO live migration to shift
control of the device between qemu and HW.

I don't think we know enough about this space at the moment to fix a
specification to one path or the other, so I hope the TPAR will settle
on something that can support both models in SW and people can try
things out.

Jason
