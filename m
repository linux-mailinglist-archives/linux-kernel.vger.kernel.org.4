Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304636BAAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCOIfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCOIfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB0C7286
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678869281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nYxoCHhxVb8vTTUPAWKIqDPQNM+xZReJ+iO80NpTGTQ=;
        b=Ca/K9Ni4W+ZkoO65ZjLBzezQfmTt5fVorMf1oONfFfA5d9QZV/fcrAdq+bRQ1l+OKAs3WX
        E3bu85TtRpYF820bqKUzYuB4VSISHy0zPoSZdGhA6IBNdzPgs/KWgYi221AAu6YV9hBUOh
        ZoBXt6mq/ZgY1Lwukq6xVf9BwQhFehw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-5gp0u1ATPV6NuYD_XXJ4nA-1; Wed, 15 Mar 2023 04:34:10 -0400
X-MC-Unique: 5gp0u1ATPV6NuYD_XXJ4nA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14791101A550;
        Wed, 15 Mar 2023 08:34:10 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.22.34.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 549BAC017D7;
        Wed, 15 Mar 2023 08:34:09 +0000 (UTC)
Date:   Wed, 15 Mar 2023 09:34:07 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, jikos@kernel.org
Subject: Re: [PATCH 04/12] driver core: class: remove module * from
 class_create()
Message-ID: <20230315083407.pkcqq3igjszuz7ms@mail.corp.redhat.com>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
 <20230313181843.1207845-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313181843.1207845-4-gregkh@linuxfoundation.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 13 2023, Greg Kroah-Hartman wrote:
> The module pointer in class_create() never actually did anything, and it
> shouldn't have been requred to be set as a parameter even if it did
> something.  So just remove it and fix up all callers of the function in
> the kernel tree at the same time.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/mips/kernel/mips-mt.c                       | 2 +-
>  arch/mips/sibyte/common/sb_tbprof.c              | 2 +-
>  arch/powerpc/platforms/book3s/vas-api.c          | 2 +-
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c        | 2 +-
>  arch/x86/kernel/cpuid.c                          | 2 +-
>  arch/x86/kernel/msr.c                            | 2 +-
>  block/bsg.c                                      | 2 +-
>  drivers/accel/drm_accel.c                        | 2 +-
>  drivers/accel/habanalabs/common/habanalabs_drv.c | 2 +-
>  drivers/base/power/wakeup_stats.c                | 2 +-
>  drivers/block/aoe/aoechr.c                       | 2 +-
>  drivers/block/rnbd/rnbd-clt-sysfs.c              | 2 +-
>  drivers/block/rnbd/rnbd-srv-sysfs.c              | 2 +-
>  drivers/block/ublk_drv.c                         | 2 +-
>  drivers/char/bsr.c                               | 2 +-
>  drivers/char/dsp56k.c                            | 2 +-
>  drivers/char/ipmi/ipmi_devintf.c                 | 2 +-
>  drivers/char/lp.c                                | 2 +-
>  drivers/char/mem.c                               | 2 +-
>  drivers/char/misc.c                              | 2 +-
>  drivers/char/pcmcia/cm4000_cs.c                  | 2 +-
>  drivers/char/pcmcia/cm4040_cs.c                  | 2 +-
>  drivers/char/pcmcia/scr24x_cs.c                  | 2 +-
>  drivers/char/ppdev.c                             | 2 +-
>  drivers/char/tpm/tpm-interface.c                 | 4 ++--
>  drivers/char/virtio_console.c                    | 2 +-
>  drivers/char/xilinx_hwicap/xilinx_hwicap.c       | 2 +-
>  drivers/char/xillybus/xillybus_class.c           | 2 +-
>  drivers/comedi/comedi_fops.c                     | 2 +-
>  drivers/comedi/drivers/comedi_test.c             | 2 +-
>  drivers/crypto/qat/qat_common/adf_ctl_drv.c      | 2 +-
>  drivers/dca/dca-sysfs.c                          | 2 +-
>  drivers/devfreq/devfreq-event.c                  | 2 +-
>  drivers/devfreq/devfreq.c                        | 2 +-
>  drivers/dma-buf/dma-heap.c                       | 2 +-
>  drivers/extcon/extcon.c                          | 2 +-
>  drivers/fpga/fpga-bridge.c                       | 2 +-
>  drivers/fpga/fpga-mgr.c                          | 2 +-
>  drivers/fpga/fpga-region.c                       | 2 +-
>  drivers/gnss/core.c                              | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 2 +-
>  drivers/gpu/drm/display/drm_dp_aux_dev.c         | 2 +-
>  drivers/gpu/drm/drm_sysfs.c                      | 2 +-
>  drivers/hid/hid-roccat-arvo.c                    | 2 +-
>  drivers/hid/hid-roccat-isku.c                    | 2 +-
>  drivers/hid/hid-roccat-kone.c                    | 2 +-
>  drivers/hid/hid-roccat-koneplus.c                | 2 +-
>  drivers/hid/hid-roccat-konepure.c                | 2 +-
>  drivers/hid/hid-roccat-kovaplus.c                | 2 +-
>  drivers/hid/hid-roccat-pyra.c                    | 2 +-
>  drivers/hid/hid-roccat-ryos.c                    | 2 +-
>  drivers/hid/hid-roccat-savu.c                    | 2 +-
>  drivers/hid/hidraw.c                             | 2 +-

For the HID part:

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

[...]

