Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ECA686BED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBAQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjBAQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:38:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36C7A4AE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675269416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DUTRd/HWxCL5qiIGieZHEITtUq3cOtR+H9zwFOpCb8=;
        b=Ev4mpb0H4bJV6YHwTAQ7N15CXIR5oMErNeqFK1HNlVjjleskX0xTNcPUEdsaOdgNPND+q6
        9BceXTGTZi4eI01Zjc0nOzX9vaww4ru+0IW+7EJB/CiGxoj2WWiRol1ZkeB4wlyfA6D41F
        N7p1zagTBP+ti9jXuKarpVlB5CKpjNg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-573-zcex9cRyPvy9EZfeP8Wl8Q-1; Wed, 01 Feb 2023 11:36:47 -0500
X-MC-Unique: zcex9cRyPvy9EZfeP8Wl8Q-1
Received: by mail-il1-f200.google.com with SMTP id j7-20020a056e02014700b00310d217f518so8879090ilr.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 08:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DUTRd/HWxCL5qiIGieZHEITtUq3cOtR+H9zwFOpCb8=;
        b=B9+HbQesot61vb9cX4E2KyaXT106enalxWCUS4XbWzahyDBbzAar62Q4W9S2yWFW8M
         z7IT27pxk98F+Qkg+xYK/YMZpcid8CzJRUs8jFGyhQ6GuFak7f3SQwzEI5qiDtrSenbN
         xfFGv1G+2uSKKF7CTDXQ0NeIdfBd6BZGc+HAHDriIDPXloy29kuhLLEMv4aYkc8pAwYa
         SDHfq5cEGw83W4AZQbPLHb3RCEgWjAP30gSLk8zckQo+Q4F6qg7a7ekLBV8A07Euo/mH
         MUaBaQlQs/9DRq8Njv9G3z43ntleFTv/N8cfpn3iDdTgvNoon7RsJuqdJGVsHGpB3w2t
         hvsQ==
X-Gm-Message-State: AO0yUKUd9Eo7bCV2/lZxVUzuR0t5MRIGCX6gwF/i1Lim0qwGDU8DSL+G
        3sGDWs/jzHi/xsrZ+z9upY791vZgmoOtjF2I9HtBJl7pKMdGLWZYsBnUMYevekgg1SI3wbkE9Gi
        Pl/oaTy+tCSOpxyOlrhxYyIZ1
X-Received: by 2002:a6b:c406:0:b0:714:ff62:cb18 with SMTP id y6-20020a6bc406000000b00714ff62cb18mr9081558ioa.17.1675269406692;
        Wed, 01 Feb 2023 08:36:46 -0800 (PST)
X-Google-Smtp-Source: AK7set9Sq+jvuM5LhUKUdHPVkvEcT70eV2R4TL+3a+zwu2jZW0RqaAuGnf+KAZ+Lw7zfSXKgBSLfgg==
X-Received: by 2002:a6b:c406:0:b0:714:ff62:cb18 with SMTP id y6-20020a6bc406000000b00714ff62cb18mr9081547ioa.17.1675269406400;
        Wed, 01 Feb 2023 08:36:46 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w1-20020a05660201c100b006f8ee49c22dsm6105876iot.10.2023.02.01.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:36:45 -0800 (PST)
Date:   Wed, 1 Feb 2023 09:36:44 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v7 1/5] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <20230201093644.4983db0d.alex.williamson@redhat.com>
In-Reply-To: <add8f068-3aaa-0707-bfe6-27fd8bf9e10c@huawei.com>
References: <20230120032930.43608-1-liulongfang@huawei.com>
        <20230120032930.43608-2-liulongfang@huawei.com>
        <20230126122759.5aa4d84c.alex.williamson@redhat.com>
        <add8f068-3aaa-0707-bfe6-27fd8bf9e10c@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023 11:20:08 +0800
liulongfang <liulongfang@huawei.com> wrote:

> On 2023/1/27 3:27, Alex Williamson wrote:
> > On Fri, 20 Jan 2023 11:29:26 +0800
> > Longfang Liu <liulongfang@huawei.com> wrote:
> >   
> >> There are multiple devices, software and operational steps involved
> >> in the process of live migration. An error occurred on any node may
> >> cause the live migration operation to fail.
> >> This complex process makes it very difficult to locate and analyze
> >> the cause when the function fails.
> >>
> >> In order to quickly locate the cause of the problem when the
> >> live migration fails, I added a set of debugfs to the vfio
> >> live migration driver.
> >>
> >>  +------------------------------------------+
> >>  |                                          |
> >>  |                                          |
> >>  |                 QEMU                     |
> >>  |                                          |
> >>  |                                          |
> >>  +-----+-------------------------+----------+
> >>        |   ^                     |   ^
> >>        v   |                     v   |
> >>      +-----+--+                +-----+--+
> >>      | src VF |                | dst VF |
> >>      +-+------+                +-+------+
> >>        |   ^                     |   ^
> >>        v   |                     v   |
> >>  +-------+-+------+        +-------+-+------+
> >>  |Debugfs|state   |        |Debugfs|state   |
> >>  +-------+--------+        +-------+--------+
> >>  |   debug_root   |        |   debug_root   |
> >>  +-------+--------+        +-------+--------+
> >>
> >> The entire debugfs directory will be based on the definition of
> >> the CONFIG_DEBUG_FS macro. If this macro is not enabled, the
> >> interfaces in vfio_pci_debugfs.h will be empty definitions,
> >> and the creation and initialization of the debugfs directory
> >> will not be executed.
> >>
> >> debugfs will create a public root directory "vfio_mig" file.
> >> then create a "debug_root" file for each live migration VF device.  
> > 
> > s/VF // In practice it may be VFs, but I don't think we want to
> > artificially imply that the device must be a VF.  In fact, I'm not sure  
> 
> Yes, the description should be modified here, and it should not be limited
> to only support VF.
> 
> > why any of this code lives in vfio/pci/ vs vfio/, there's nothing PCI
> > specific here.  Why isn't all of this done in vfio_main to be shared
> > with both pci and non-pci vfio drivers and devices?
> >  
> 
> Combined with your observations below, I think it is more appropriate to
> create a "vfio-pci" directory here, because the current live migration
> function is still used on pci devices.
> 
> For non-pci devices, if there is a device that needs to add debugfs,
> then it can create a similar directory.

But live migration itself is not specific to vfio-pci, it's device
agnostic.  We'd certainly expect to see mdev devices supporting
migration in the near term.  Thanks,

Alex

