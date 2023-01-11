Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7379C665AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbjAKMAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbjAKL73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81499585
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673438144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=or7HIbi0FLzkErlpkRfiCb5sXTJTlfJeiqaPEzHEIp4=;
        b=GQFlLb5xXp2WG+m/jT/cDaCO4t2fjHFWBgF4LUDPNZfl6O/sd1ZDMkcxvy6DE3xfRkYnKZ
        9pVLQZjWzR9rSnC5xhr0zhuH47yYadWVKlLP/qWh12bHchreDMc+ieg4UERXgt0hvoepHb
        5X4RoZV07GzQntwFdepHlgq+igkiSjk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-LvFLT83WODm-Hf7FWWyr-w-1; Wed, 11 Jan 2023 06:55:43 -0500
X-MC-Unique: LvFLT83WODm-Hf7FWWyr-w-1
Received: by mail-ej1-f69.google.com with SMTP id dn11-20020a17090794cb00b007c14ea70afcso9914885ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or7HIbi0FLzkErlpkRfiCb5sXTJTlfJeiqaPEzHEIp4=;
        b=vCgBlSDC7Kp1RaGQrktt/1m8CUmlzVvEMXGWqLsVglQZqnJ27Xn/rRQGbJkcBDnRSe
         5uqnXwwtpVmqp758aV1RM2qLcf+4gaqevuFMOJkUiLFe1QQsZjrtxtqIbmSBCBsRe2Z6
         ceQg+3gXKWnb3l9HSyiP/mZMy3cVxKScZDqlMCTI+eRyeQcyUFTdTnjEsbeF22KFSvgy
         csydm/55LnIk+WDbuitvr5shKICwbUDBq8ToqVHjiJju4WKH76e8wZK1ZWx0FaQJlSiY
         9aLzt7XmCrvXBVTBzn9nCtXkZIqX4Ve8mFQIWbmYVLDvCwXng1JIQK5/QFLuX4sSSK8p
         ExCQ==
X-Gm-Message-State: AFqh2ko83U7jxq28phvA5Yi90j/42GGH+Z+kd332xnr8B6PGMstptcg7
        TMfFZzJDpz98YzQai4EiylgkIvWMG7KHJQ3wWNrJVDPu1EHSe5HvPixHt0Gf8QkgA6z8YC2bymG
        2hcn1ww2zSXdZunw3uSIf+inJ
X-Received: by 2002:a17:906:c18d:b0:843:770e:777d with SMTP id g13-20020a170906c18d00b00843770e777dmr60211503ejz.11.1673438141793;
        Wed, 11 Jan 2023 03:55:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvYx6E2jrolUaCUPFMbeBoudRbl6bsy9oi3qHjWGD9njn+9ab5XsqD6vFkT7Cnc3VVlCXDK6g==
X-Received: by 2002:a17:906:c18d:b0:843:770e:777d with SMTP id g13-20020a170906c18d00b00843770e777dmr60211488ejz.11.1673438141496;
        Wed, 11 Jan 2023 03:55:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id tb18-20020a1709078b9200b007c09d37eac7sm6063274ejc.216.2023.01.11.03.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 03:55:40 -0800 (PST)
Message-ID: <1d0dff6f-97c7-c800-2a6b-551613cae733@redhat.com>
Date:   Wed, 11 Jan 2023 12:55:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 00/16] driver core: make more things const!
Content-Language: en-US, nl
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/11/23 12:30, Greg Kroah-Hartman wrote:
> Here's an updated version of this original series:
> 	https://lore.kernel.org/all/20221123122523.1332370-1-gregkh@linuxfoundation.org/
> that has the goal of making more functions in the driver core take const
> pointers as they do not actually modify anything.  This work is an
> outgrowth of some conversations I had with the Linux Rust developers
> talking about the mutability of many of the driver model pointers.
> 
> A small subset of the original submission is now in 6.2-rc1 and this
> series is an outgrown of the original submission in that many things are
> now changed and a bit more explicit than before.
> 
> I can take all of these through the driver-core git tree as they depend
> on each other.  0-day has been passing on this series for quite a while,
> so all should be good unless some subsystem trees have added new busses
> without me noticing.
> 
> Bonus for all of this work, the overall code size of the kernel actually
> decreased a tiny bit:
>  126 files changed, 283 insertions(+), 309 deletions(-)
> while adding a lot more type-safeness to the system.

Other then a small remark on "[PATCH v2 03/16] platform/surface: aggregator:
move to_ssam_device() to use container_of_const()" the platform/surface
and platform/x86/wmi.c changes look good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
> Changes from v1:
>   - rebased on 6.2-rc1 and dropped accepted patches already in there.
>   - container_of_const() is now in 6.2-rc1 so use that in many
>     individual subsystems to make the follow-on changes in the driver
>     core more obvious.
>   - collected some Reviewed-by
>   - of_device_uevent_modalias was being "abused" by many different
>     subsystems in using it instead of a local bus function which played
>     havoc when enabling stricter type-checking.  Move that out into a
>     new function for the busses that were doing this to make it more
>     obvious what they need here.
> 
> Greg Kroah-Hartman (16):
>   of: device: make of_device_uevent_modalias() take a const device *
>   i3c: move dev_to_i3cdev() to use container_of_const()
>   platform/surface: aggregator: move to_ssam_device() to use
>     container_of_const()
>   firewire: move fw_device() and fw_unit() to use container_of_const()
>   driver core: make struct device_type.uevent() take a const *
>   driver core: make struct device_type.devnode() take a const *
>   driver core: device_get_devnode() should take a const *
>   vio: move to_vio_dev() to use container_of_const()
>   platform/x86: wmi: move dev_to_wblock() and dev_to_wdev to use
>     container_of_const()
>   drivers: hv: move device_to_hv_device to use container_of_const()
>   virtio: move dev_to_virtio() to use container_of_const()
>   drm/mipi-dsi: move to_mipi_dsi_device() to use container_of_const()
>   mcb: move to_mcb_device() to use container_of_const()
>   xen/xenbus: move to_xenbus_device() to use container_of_const()
>   driver core: make struct bus_type.uevent() take a const *
>   kobject: kset_uevent_ops: make uevent() callback take a const *
> 
>  arch/mips/sgi-ip22/ip22-gio.c              |  4 ++--
>  arch/parisc/kernel/drivers.c               |  4 ++--
>  arch/powerpc/include/asm/vio.h             |  5 +----
>  arch/powerpc/platforms/pseries/ibmebus.c   |  7 ++++++-
>  arch/powerpc/platforms/pseries/vio.c       |  4 ++--
>  arch/sparc/include/asm/vio.h               |  5 +----
>  arch/sparc/kernel/vio.c                    |  2 +-
>  block/genhd.c                              |  2 +-
>  block/partitions/core.c                    |  4 ++--
>  drivers/acpi/bus.c                         |  2 +-
>  drivers/acpi/device_sysfs.c                |  8 ++++----
>  drivers/acpi/internal.h                    |  2 +-
>  drivers/amba/bus.c                         |  4 ++--
>  drivers/base/auxiliary.c                   |  2 +-
>  drivers/base/base.h                        |  2 ++
>  drivers/base/core.c                        |  6 +++---
>  drivers/base/cpu.c                         |  2 +-
>  drivers/base/platform.c                    |  4 ++--
>  drivers/bcma/main.c                        |  6 +++---
>  drivers/bus/fsl-mc/fsl-mc-bus.c            |  4 ++--
>  drivers/bus/mhi/ep/main.c                  |  4 ++--
>  drivers/bus/mhi/host/init.c                |  4 ++--
>  drivers/bus/mips_cdmm.c                    |  4 ++--
>  drivers/bus/sunxi-rsb.c                    |  7 ++++++-
>  drivers/cxl/core/memdev.c                  |  4 ++--
>  drivers/cxl/core/port.c                    |  8 ++++----
>  drivers/cxl/cxl.h                          |  4 ++--
>  drivers/cxl/cxlmem.h                       |  2 +-
>  drivers/dax/bus.c                          |  2 +-
>  drivers/eisa/eisa-bus.c                    |  4 ++--
>  drivers/firewire/core-device.c             |  8 ++++----
>  drivers/firmware/arm_ffa/bus.c             |  4 ++--
>  drivers/fpga/dfl.c                         |  4 ++--
>  drivers/fsi/fsi-core.c                     |  6 +++---
>  drivers/gpu/drm/display/drm_dp_aux_bus.c   |  7 ++++++-
>  drivers/gpu/drm/drm_mipi_dsi.c             |  4 ++--
>  drivers/gpu/host1x/bus.c                   |  2 +-
>  drivers/greybus/core.c                     | 14 +++++++-------
>  drivers/hid/hid-core.c                     |  4 ++--
>  drivers/hid/intel-ish-hid/ishtp/bus.c      |  2 +-
>  drivers/hsi/hsi_core.c                     |  2 +-
>  drivers/hv/vmbus_drv.c                     |  4 ++--
>  drivers/hwtracing/intel_th/core.c          |  6 +++---
>  drivers/hwtracing/intel_th/intel_th.h      |  4 ++--
>  drivers/i2c/i2c-core-base.c                |  4 ++--
>  drivers/i3c/device.c                       | 14 +-------------
>  drivers/i3c/master.c                       |  4 ++--
>  drivers/input/input.c                      | 16 ++++++++--------
>  drivers/input/serio/serio.c                |  4 ++--
>  drivers/ipack/ipack.c                      |  4 ++--
>  drivers/macintosh/macio_asic.c             |  7 ++++++-
>  drivers/mcb/mcb-core.c                     |  4 ++--
>  drivers/media/rc/rc-main.c                 |  2 +-
>  drivers/memstick/core/memstick.c           |  6 +++---
>  drivers/misc/mei/bus.c                     |  4 ++--
>  drivers/misc/tifm_core.c                   |  4 ++--
>  drivers/mmc/core/bus.c                     |  4 ++--
>  drivers/mmc/core/sdio_bus.c                |  4 ++--
>  drivers/net/phy/mdio_bus.c                 |  2 +-
>  drivers/net/xen-netback/xenbus.c           |  2 +-
>  drivers/nvdimm/bus.c                       |  4 ++--
>  drivers/nvdimm/dax_devs.c                  |  2 +-
>  drivers/nvdimm/dimm_devs.c                 |  2 +-
>  drivers/nvdimm/nd-core.h                   | 10 +++++-----
>  drivers/nvdimm/nd.h                        |  4 ++--
>  drivers/nvdimm/region_devs.c               |  4 ++--
>  drivers/of/device.c                        |  4 ++--
>  drivers/pci/pci-driver.c                   |  4 ++--
>  drivers/pcmcia/ds.c                        |  4 ++--
>  drivers/platform/surface/aggregator/bus.c  |  4 ++--
>  drivers/platform/x86/wmi.c                 | 15 ++++-----------
>  drivers/rapidio/rio-driver.c               |  4 ++--
>  drivers/rpmsg/rpmsg_core.c                 |  4 ++--
>  drivers/s390/cio/css.c                     |  4 ++--
>  drivers/s390/cio/device.c                  |  8 ++++----
>  drivers/s390/cio/scm.c                     |  2 +-
>  drivers/s390/crypto/ap_bus.c               |  4 ++--
>  drivers/scsi/scsi_sysfs.c                  |  4 ++--
>  drivers/slimbus/core.c                     |  4 ++--
>  drivers/soc/qcom/apr.c                     |  4 ++--
>  drivers/soundwire/bus_type.c               |  4 ++--
>  drivers/spi/spi.c                          |  2 +-
>  drivers/spmi/spmi.c                        |  2 +-
>  drivers/ssb/main.c                         |  4 ++--
>  drivers/staging/greybus/gbphy.c            | 14 +++++++-------
>  drivers/tee/tee_core.c                     |  2 +-
>  drivers/thunderbolt/switch.c               |  4 ++--
>  drivers/thunderbolt/tb.h                   |  2 +-
>  drivers/thunderbolt/xdomain.c              |  6 +++---
>  drivers/tty/serdev/core.c                  |  2 +-
>  drivers/usb/common/ulpi.c                  |  4 ++--
>  drivers/usb/core/driver.c                  |  6 +++---
>  drivers/usb/core/message.c                 |  8 ++++----
>  drivers/usb/core/usb.c                     |  8 ++++----
>  drivers/usb/phy/phy.c                      |  6 +++---
>  drivers/usb/roles/class.c                  |  3 +--
>  drivers/usb/typec/bus.c                    |  4 ++--
>  drivers/usb/typec/class.c                  |  2 +-
>  drivers/virtio/virtio.c                    |  4 ++--
>  drivers/w1/w1.c                            | 10 +++++-----
>  drivers/xen/pvcalls-back.c                 |  2 +-
>  drivers/xen/xenbus/xenbus_probe_backend.c  |  8 ++++----
>  drivers/xen/xenbus/xenbus_probe_frontend.c |  4 ++--
>  drivers/zorro/zorro-driver.c               |  4 ++--
>  fs/dlm/lockspace.c                         |  4 ++--
>  fs/gfs2/sys.c                              |  6 +++---
>  include/drm/drm_mipi_dsi.h                 |  5 +----
>  include/linux/acpi.h                       |  4 ++--
>  include/linux/device.h                     |  6 ++----
>  include/linux/device/bus.h                 |  2 +-
>  include/linux/firewire.h                   | 15 +++------------
>  include/linux/hyperv.h                     |  5 +----
>  include/linux/i3c/device.h                 | 11 +++++++++--
>  include/linux/kobject.h                    |  2 +-
>  include/linux/mcb.h                        |  5 +----
>  include/linux/of_device.h                  |  4 ++--
>  include/linux/soundwire/sdw_type.h         |  2 +-
>  include/linux/spi/spi.h                    |  2 +-
>  include/linux/ssb/ssb.h                    |  2 +-
>  include/linux/surface_aggregator/device.h  |  5 +----
>  include/linux/virtio.h                     |  5 +----
>  include/sound/hdaudio.h                    |  2 +-
>  include/xen/xenbus.h                       |  7 ++-----
>  sound/aoa/soundbus/core.c                  |  6 +++---
>  sound/hda/hda_bus_type.c                   |  2 +-
>  sound/hda/hdac_device.c                    |  2 +-
>  126 files changed, 283 insertions(+), 309 deletions(-)
> 

