Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8260D6BAFB0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCOLxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjCOLw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:52:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215B206BE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:52:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x17so7803990lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678881147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkKRqQJwumYm0uKYiB07i8gBB7V6i/xJLdU3XpUM7xI=;
        b=JSClIdKnzMoXimLb4iru5f9DvAH2c0M1+WVGeWB4QRTrBZrwV/ovzdIKSU2v0HbcCR
         LSQMKBx8Ir4cgk0Y9hJEB2pyLjmVrfZVVwXreljB5mJxZ8gE34fj/6wOaVs6+PhRwJ5M
         sgW92JrrqUUV7kvm9ij+6RuJEuQ0l7m/XaWG/OTioaycmX2URD1PiVlY18x/QcZbyZ8W
         Mdm6zg+cjU5vQTqjMk0xqFwh5sebqVP8f3YETN60eHBu4gCuK2UD+QHMJjvyKni4OH36
         ioqgPlfC/3C6L/cvesLzgFGSFtHbtL3VvwKoORWNYHBVDedIjFHRMWQoUCXW8lp6HtuY
         EnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678881147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkKRqQJwumYm0uKYiB07i8gBB7V6i/xJLdU3XpUM7xI=;
        b=puCJssVbjvQ4U9/DDpb6vfW6TFfQ/D8GmLMbNyQdJ5XLuSo5BdjQw+wlRT5e27LnAk
         dxho8eC07iJIviW6wxT3jq12LOetD0UPqRwuqPYtMl1Y/U9K32Ix7KCArIlAjgZVIntY
         SaHK2GT6blJ2uwL/vV8ueeetKnCK2J1dkh4SZ9EY0g4VXB3qQK6bWrnIrGm27pHx489f
         2tmipCb57mKnRYcdewoQt4DWcvxNX55M9Md1xURVYDxPKuAypyLTknxV2xt6IoL2ZfUH
         9YL1e6VGb8ibbbE8Y6DFVQ1In9t1r5bZBP2ycayYVuOb/5WELT2EqqoVW7llDwRjb+44
         HmsA==
X-Gm-Message-State: AO0yUKXc70Rge0J06khiQBdqhVO8MgRYQ4RqjB87R0Y4jmTnwxHbYhtu
        J04foyN/7sYXCivUYgBD0yHYcBcQmRrx9NvSpiQ=
X-Google-Smtp-Source: AK7set+M0wmEHiCPMasvYM04E9Kg817dk+diyRuK2KviMr85gfDP9RR5UGMY2JfN49ZttFDF/494UrTHHVgVpd9Kixg=
X-Received: by 2002:ac2:5453:0:b0:4db:1ae1:318b with SMTP id
 d19-20020ac25453000000b004db1ae1318bmr1872252lfn.5.1678881146981; Wed, 15 Mar
 2023 04:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org> <20230313182918.1312597-23-gregkh@linuxfoundation.org>
In-Reply-To: <20230313182918.1312597-23-gregkh@linuxfoundation.org>
From:   Alex Shi <seakeel@gmail.com>
Date:   Wed, 15 Mar 2023 19:51:50 +0800
Message-ID: <CAJy-Amm040GLUT9gQ9PsynKriGh+WN6iuTFfXydAbGS5uMZhNg@mail.gmail.com>
Subject: Re: [PATCH 23/36] driver core: bus: mark the struct bus_type for
 sysfs callbacks as constant
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alex Shi <alexs@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Eric Dumazet <edumazet@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Hannes Reinecke <hare@suse.de>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hu Haowen <src.res@email.cn>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paolo Abeni <pabeni@redhat.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 2:30=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> struct bus_type should never be modified in a sysfs callback as there is
> nothing in the structure to modify, and frankly, the structure is almost
> never used in a sysfs callback, so mark it as constant to allow struct
> bus_type to be moved to read-only memory.
>

LGTM.

Reviewed-by: Alex Shi <alexs@kernel.org>

> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Alexandre Bounine <alex.bou9@gmail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Hu Haowen <src.res@email.cn>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Iwona Winiarska <iwona.winiarska@intel.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Stuart Yoder <stuyoder@gmail.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.
>
>  Documentation/driver-api/driver-model/bus.rst |  4 +-
>  Documentation/filesystems/sysfs.rst           |  4 +-
>  .../translations/zh_CN/filesystems/sysfs.txt  |  4 +-
>  .../translations/zh_TW/filesystems/sysfs.txt  |  4 +-
>  arch/powerpc/platforms/pseries/ibmebus.c      |  4 +-
>  arch/powerpc/platforms/pseries/vio.c          |  8 ++--
>  drivers/ata/pata_parport/pata_parport.c       |  6 +--
>  drivers/base/bus.c                            |  8 ++--
>  drivers/block/rbd.c                           | 34 +++++++--------
>  drivers/bus/fsl-mc/fsl-mc-bus.c               |  6 +--
>  drivers/cxl/core/port.c                       |  2 +-
>  drivers/hv/vmbus_drv.c                        |  2 +-
>  drivers/net/netdevsim/bus.c                   |  4 +-
>  drivers/pci/pci-sysfs.c                       |  2 +-
>  drivers/pci/pci.c                             |  4 +-
>  drivers/peci/sysfs.c                          |  2 +-
>  drivers/rapidio/rio-sysfs.c                   |  2 +-
>  drivers/s390/crypto/ap_bus.c                  | 42 +++++++++----------
>  drivers/scsi/fcoe/fcoe_sysfs.c                |  8 ++--
>  drivers/scsi/fcoe/fcoe_transport.c            |  6 +--
>  include/linux/device/bus.h                    |  4 +-
>  include/scsi/libfcoe.h                        |  6 +--
>  22 files changed, 78 insertions(+), 88 deletions(-)
>
> diff --git a/Documentation/driver-api/driver-model/bus.rst b/Documentatio=
n/driver-api/driver-model/bus.rst
> index 016b15a6e8ea..9709ab62a468 100644
> --- a/Documentation/driver-api/driver-model/bus.rst
> +++ b/Documentation/driver-api/driver-model/bus.rst
> @@ -125,8 +125,8 @@ Exporting Attributes
>
>    struct bus_attribute {
>         struct attribute        attr;
> -       ssize_t (*show)(struct bus_type *, char * buf);
> -       ssize_t (*store)(struct bus_type *, const char * buf, size_t coun=
t);
> +       ssize_t (*show)(const struct bus_type *, char * buf);
> +       ssize_t (*store)(const struct bus_type *, const char * buf, size_=
t count);
>    };
>
>  Bus drivers can export attributes using the BUS_ATTR_RW macro that works
> diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesyst=
ems/sysfs.rst
> index f8187d466b97..c32993bc83c7 100644
> --- a/Documentation/filesystems/sysfs.rst
> +++ b/Documentation/filesystems/sysfs.rst
> @@ -373,8 +373,8 @@ Structure::
>
>      struct bus_attribute {
>             struct attribute        attr;
> -           ssize_t (*show)(struct bus_type *, char * buf);
> -           ssize_t (*store)(struct bus_type *, const char * buf, size_t =
count);
> +           ssize_t (*show)(const struct bus_type *, char * buf);
> +           ssize_t (*store)(const struct bus_type *, const char * buf, s=
ize_t count);
>      };
>
>  Declaring::
> diff --git a/Documentation/translations/zh_CN/filesystems/sysfs.txt b/Doc=
umentation/translations/zh_CN/filesystems/sysfs.txt
> index 046cc1d52058..547062759e60 100644
> --- a/Documentation/translations/zh_CN/filesystems/sysfs.txt
> +++ b/Documentation/translations/zh_CN/filesystems/sysfs.txt
> @@ -329,8 +329,8 @@ void device_remove_file(struct device *dev, const str=
uct device_attribute * attr
>
>  struct bus_attribute {
>          struct attribute        attr;
> -        ssize_t (*show)(struct bus_type *, char * buf);
> -        ssize_t (*store)(struct bus_type *, const char * buf, size_t cou=
nt);
> +        ssize_t (*show)(const struct bus_type *, char * buf);
> +        ssize_t (*store)(const struct bus_type *, const char * buf, size=
_t count);
>  };
>
>  =E5=A3=B0=E6=98=8E:
> diff --git a/Documentation/translations/zh_TW/filesystems/sysfs.txt b/Doc=
umentation/translations/zh_TW/filesystems/sysfs.txt
> index acd677f19d4f..280824cc7e5d 100644
> --- a/Documentation/translations/zh_TW/filesystems/sysfs.txt
> +++ b/Documentation/translations/zh_TW/filesystems/sysfs.txt
> @@ -332,8 +332,8 @@ void device_remove_file(struct device *dev, const str=
uct device_attribute * attr
>
>  struct bus_attribute {
>          struct attribute        attr;
> -        ssize_t (*show)(struct bus_type *, char * buf);
> -        ssize_t (*store)(struct bus_type *, const char * buf, size_t cou=
nt);
> +        ssize_t (*show)(const struct bus_type *, char * buf);
> +        ssize_t (*store)(const struct bus_type *, const char * buf, size=
_t count);
>  };
>
>  =E8=81=B2=E6=98=8E:
> diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/plat=
forms/pseries/ibmebus.c
> index bb9c18682783..44703f13985b 100644
> --- a/arch/powerpc/platforms/pseries/ibmebus.c
> +++ b/arch/powerpc/platforms/pseries/ibmebus.c
> @@ -267,7 +267,7 @@ static char *ibmebus_chomp(const char *in, size_t cou=
nt)
>         return out;
>  }
>
> -static ssize_t probe_store(struct bus_type *bus, const char *buf, size_t=
 count)
> +static ssize_t probe_store(const struct bus_type *bus, const char *buf, =
size_t count)
>  {
>         struct device_node *dn =3D NULL;
>         struct device *dev;
> @@ -305,7 +305,7 @@ static ssize_t probe_store(struct bus_type *bus, cons=
t char *buf, size_t count)
>  }
>  static BUS_ATTR_WO(probe);
>
> -static ssize_t remove_store(struct bus_type *bus, const char *buf, size_=
t count)
> +static ssize_t remove_store(const struct bus_type *bus, const char *buf,=
 size_t count)
>  {
>         struct device *dev;
>         char *path;
> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platform=
s/pseries/vio.c
> index 770df9351aaa..bf7aff6390be 100644
> --- a/arch/powerpc/platforms/pseries/vio.c
> +++ b/arch/powerpc/platforms/pseries/vio.c
> @@ -1006,7 +1006,7 @@ ATTRIBUTE_GROUPS(vio_cmo_dev);
>  /* sysfs bus functions and data structures for CMO */
>
>  #define viobus_cmo_rd_attr(name)                                        =
\
> -static ssize_t cmo_bus_##name##_show(struct bus_type *bt, char *buf)    =
\
> +static ssize_t cmo_bus_##name##_show(const struct bus_type *bt, char *bu=
f)    \
>  {                                                                       =
\
>         return sprintf(buf, "%lu\n", vio_cmo.name);                     \
>  }                                                                       =
\
> @@ -1015,7 +1015,7 @@ static struct bus_attribute bus_attr_cmo_bus_##name=
 =3D                     \
>
>  #define viobus_cmo_pool_rd_attr(name, var)                              =
\
>  static ssize_t                                                          =
\
> -cmo_##name##_##var##_show(struct bus_type *bt, char *buf)               =
\
> +cmo_##name##_##var##_show(const struct bus_type *bt, char *buf)         =
\
>  {                                                                       =
\
>         return sprintf(buf, "%lu\n", vio_cmo.name.var);                 \
>  }                                                                       =
\
> @@ -1030,12 +1030,12 @@ viobus_cmo_pool_rd_attr(reserve, size);
>  viobus_cmo_pool_rd_attr(excess, size);
>  viobus_cmo_pool_rd_attr(excess, free);
>
> -static ssize_t cmo_high_show(struct bus_type *bt, char *buf)
> +static ssize_t cmo_high_show(const struct bus_type *bt, char *buf)
>  {
>         return sprintf(buf, "%lu\n", vio_cmo.high);
>  }
>
> -static ssize_t cmo_high_store(struct bus_type *bt, const char *buf,
> +static ssize_t cmo_high_store(const struct bus_type *bt, const char *buf=
,
>                               size_t count)
>  {
>         unsigned long flags;
> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_p=
arport/pata_parport.c
> index 294a266a0dda..64d1bde26940 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c
> @@ -554,8 +554,7 @@ void pata_parport_unregister_driver(struct pi_protoco=
l *pr)
>  }
>  EXPORT_SYMBOL_GPL(pata_parport_unregister_driver);
>
> -static ssize_t new_device_store(struct bus_type *bus, const char *buf,
> -                               size_t count)
> +static ssize_t new_device_store(const struct bus_type *bus, const char *=
buf, size_t count)
>  {
>         char port[12] =3D "auto";
>         char protocol[8] =3D "auto";
> @@ -630,8 +629,7 @@ static void pi_remove_one(struct device *dev)
>         /* pata_parport_dev_release will do kfree(pi) */
>  }
>
> -static ssize_t delete_device_store(struct bus_type *bus, const char *buf=
,
> -                                  size_t count)
> +static ssize_t delete_device_store(const struct bus_type *bus, const cha=
r *buf, size_t count)
>  {
>         struct device *dev;
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 91a6b6b1fc49..819ab745fa9f 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -274,7 +274,7 @@ static ssize_t bind_store(struct device_driver *drv, =
const char *buf,
>  }
>  static DRIVER_ATTR_IGNORE_LOCKDEP(bind, 0200, NULL, bind_store);
>
> -static ssize_t drivers_autoprobe_show(struct bus_type *bus, char *buf)
> +static ssize_t drivers_autoprobe_show(const struct bus_type *bus, char *=
buf)
>  {
>         struct subsys_private *sp =3D bus_to_subsys(bus);
>         int ret;
> @@ -287,7 +287,7 @@ static ssize_t drivers_autoprobe_show(struct bus_type=
 *bus, char *buf)
>         return ret;
>  }
>
> -static ssize_t drivers_autoprobe_store(struct bus_type *bus,
> +static ssize_t drivers_autoprobe_store(const struct bus_type *bus,
>                                        const char *buf, size_t count)
>  {
>         struct subsys_private *sp =3D bus_to_subsys(bus);
> @@ -304,7 +304,7 @@ static ssize_t drivers_autoprobe_store(struct bus_typ=
e *bus,
>         return count;
>  }
>
> -static ssize_t drivers_probe_store(struct bus_type *bus,
> +static ssize_t drivers_probe_store(const struct bus_type *bus,
>                                    const char *buf, size_t count)
>  {
>         struct device *dev;
> @@ -808,7 +808,7 @@ static void klist_devices_put(struct klist_node *n)
>         put_device(dev);
>  }
>
> -static ssize_t bus_uevent_store(struct bus_type *bus,
> +static ssize_t bus_uevent_store(const struct bus_type *bus,
>                                 const char *buf, size_t count)
>  {
>         struct subsys_private *sp =3D bus_to_subsys(bus);
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 5cb008b9700a..84ad3b17956f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -491,12 +491,12 @@ static bool single_major =3D true;
>  module_param(single_major, bool, 0444);
>  MODULE_PARM_DESC(single_major, "Use a single major number for all rbd de=
vices (default: true)");
>
> -static ssize_t add_store(struct bus_type *bus, const char *buf, size_t c=
ount);
> -static ssize_t remove_store(struct bus_type *bus, const char *buf,
> +static ssize_t add_store(const struct bus_type *bus, const char *buf, si=
ze_t count);
> +static ssize_t remove_store(const struct bus_type *bus, const char *buf,
>                             size_t count);
> -static ssize_t add_single_major_store(struct bus_type *bus, const char *=
buf,
> +static ssize_t add_single_major_store(const struct bus_type *bus, const =
char *buf,
>                                       size_t count);
> -static ssize_t remove_single_major_store(struct bus_type *bus, const cha=
r *buf,
> +static ssize_t remove_single_major_store(const struct bus_type *bus, con=
st char *buf,
>                                          size_t count);
>  static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth);
>
> @@ -538,7 +538,7 @@ static bool rbd_is_lock_owner(struct rbd_device *rbd_=
dev)
>         return is_lock_owner;
>  }
>
> -static ssize_t supported_features_show(struct bus_type *bus, char *buf)
> +static ssize_t supported_features_show(const struct bus_type *bus, char =
*buf)
>  {
>         return sprintf(buf, "0x%llx\n", RBD_FEATURES_SUPPORTED);
>  }
> @@ -6967,9 +6967,7 @@ static int rbd_dev_image_probe(struct rbd_device *r=
bd_dev, int depth)
>         return ret;
>  }
>
> -static ssize_t do_rbd_add(struct bus_type *bus,
> -                         const char *buf,
> -                         size_t count)
> +static ssize_t do_rbd_add(const char *buf, size_t count)
>  {
>         struct rbd_device *rbd_dev =3D NULL;
>         struct ceph_options *ceph_opts =3D NULL;
> @@ -7081,18 +7079,18 @@ static ssize_t do_rbd_add(struct bus_type *bus,
>         goto out;
>  }
>
> -static ssize_t add_store(struct bus_type *bus, const char *buf, size_t c=
ount)
> +static ssize_t add_store(const struct bus_type *bus, const char *buf, si=
ze_t count)
>  {
>         if (single_major)
>                 return -EINVAL;
>
> -       return do_rbd_add(bus, buf, count);
> +       return do_rbd_add(buf, count);
>  }
>
> -static ssize_t add_single_major_store(struct bus_type *bus, const char *=
buf,
> +static ssize_t add_single_major_store(const struct bus_type *bus, const =
char *buf,
>                                       size_t count)
>  {
> -       return do_rbd_add(bus, buf, count);
> +       return do_rbd_add(buf, count);
>  }
>
>  static void rbd_dev_remove_parent(struct rbd_device *rbd_dev)
> @@ -7122,9 +7120,7 @@ static void rbd_dev_remove_parent(struct rbd_device=
 *rbd_dev)
>         }
>  }
>
> -static ssize_t do_rbd_remove(struct bus_type *bus,
> -                            const char *buf,
> -                            size_t count)
> +static ssize_t do_rbd_remove(const char *buf, size_t count)
>  {
>         struct rbd_device *rbd_dev =3D NULL;
>         struct list_head *tmp;
> @@ -7196,18 +7192,18 @@ static ssize_t do_rbd_remove(struct bus_type *bus=
,
>         return count;
>  }
>
> -static ssize_t remove_store(struct bus_type *bus, const char *buf, size_=
t count)
> +static ssize_t remove_store(const struct bus_type *bus, const char *buf,=
 size_t count)
>  {
>         if (single_major)
>                 return -EINVAL;
>
> -       return do_rbd_remove(bus, buf, count);
> +       return do_rbd_remove(buf, count);
>  }
>
> -static ssize_t remove_single_major_store(struct bus_type *bus, const cha=
r *buf,
> +static ssize_t remove_single_major_store(const struct bus_type *bus, con=
st char *buf,
>                                          size_t count)
>  {
> -       return do_rbd_remove(bus, buf, count);
> +       return do_rbd_remove(buf, count);
>  }
>
>  /*
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-=
bus.c
> index 36cb091a33b4..653e2d4c116f 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -231,7 +231,7 @@ static int scan_fsl_mc_bus(struct device *dev, void *=
data)
>         return 0;
>  }
>
> -static ssize_t rescan_store(struct bus_type *bus,
> +static ssize_t rescan_store(const struct bus_type *bus,
>                             const char *buf, size_t count)
>  {
>         unsigned long val;
> @@ -284,7 +284,7 @@ static int fsl_mc_bus_get_autorescan(struct device *d=
ev, void *data)
>         return 0;
>  }
>
> -static ssize_t autorescan_store(struct bus_type *bus,
> +static ssize_t autorescan_store(const struct bus_type *bus,
>                                 const char *buf, size_t count)
>  {
>         bus_for_each_dev(bus, NULL, (void *)buf, fsl_mc_bus_set_autoresca=
n);
> @@ -292,7 +292,7 @@ static ssize_t autorescan_store(struct bus_type *bus,
>         return count;
>  }
>
> -static ssize_t autorescan_show(struct bus_type *bus, char *buf)
> +static ssize_t autorescan_show(const struct bus_type *bus, char *buf)
>  {
>         bus_for_each_dev(bus, NULL, (void *)buf, fsl_mc_bus_get_autoresca=
n);
>         return strlen(buf);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8ee6b6e2e2a4..66333cd6248e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1927,7 +1927,7 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *=
cxlmd)
>  EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
>
>  /* for user tooling to ensure port disable work has completed */
> -static ssize_t flush_store(struct bus_type *bus, const char *buf, size_t=
 count)
> +static ssize_t flush_store(const struct bus_type *bus, const char *buf, =
size_t count)
>  {
>         if (sysfs_streq(buf, "1")) {
>                 flush_workqueue(cxl_bus_wq);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index d24dd65b33d4..513adba09f56 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -684,7 +684,7 @@ static const struct attribute_group vmbus_dev_group =
=3D {
>  __ATTRIBUTE_GROUPS(vmbus_dev);
>
>  /* Set up the attribute for /sys/bus/vmbus/hibernation */
> -static ssize_t hibernation_show(struct bus_type *bus, char *buf)
> +static ssize_t hibernation_show(const struct bus_type *bus, char *buf)
>  {
>         return sprintf(buf, "%d\n", !!hv_is_hibernation_supported());
>  }
> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> index 0052968e881e..0787ad252dd9 100644
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -132,7 +132,7 @@ static struct nsim_bus_dev *
>  nsim_bus_dev_new(unsigned int id, unsigned int port_count, unsigned int =
num_queues);
>
>  static ssize_t
> -new_device_store(struct bus_type *bus, const char *buf, size_t count)
> +new_device_store(const struct bus_type *bus, const char *buf, size_t cou=
nt)
>  {
>         unsigned int id, port_count, num_queues;
>         struct nsim_bus_dev *nsim_bus_dev;
> @@ -186,7 +186,7 @@ static BUS_ATTR_WO(new_device);
>  static void nsim_bus_dev_del(struct nsim_bus_dev *nsim_bus_dev);
>
>  static ssize_t
> -del_device_store(struct bus_type *bus, const char *buf, size_t count)
> +del_device_store(const struct bus_type *bus, const char *buf, size_t cou=
nt)
>  {
>         struct nsim_bus_dev *nsim_bus_dev, *tmp;
>         unsigned int id;
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index dd0d9d9bc509..ab32a91f287b 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -428,7 +428,7 @@ static ssize_t msi_bus_store(struct device *dev, stru=
ct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(msi_bus);
>
> -static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_=
t count)
> +static ssize_t rescan_store(const struct bus_type *bus, const char *buf,=
 size_t count)
>  {
>         unsigned long val;
>         struct pci_bus *b =3D NULL;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7a67611dc5f4..45c3bb039f21 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6679,7 +6679,7 @@ void pci_reassigndev_resource_alignment(struct pci_=
dev *dev)
>         }
>  }
>
> -static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
> +static ssize_t resource_alignment_show(const struct bus_type *bus, char =
*buf)
>  {
>         size_t count =3D 0;
>
> @@ -6691,7 +6691,7 @@ static ssize_t resource_alignment_show(struct bus_t=
ype *bus, char *buf)
>         return count;
>  }
>
> -static ssize_t resource_alignment_store(struct bus_type *bus,
> +static ssize_t resource_alignment_store(const struct bus_type *bus,
>                                         const char *buf, size_t count)
>  {
>         char *param, *old, *end;
> diff --git a/drivers/peci/sysfs.c b/drivers/peci/sysfs.c
> index db9ef05776e3..c04244075794 100644
> --- a/drivers/peci/sysfs.c
> +++ b/drivers/peci/sysfs.c
> @@ -15,7 +15,7 @@ static int rescan_controller(struct device *dev, void *=
data)
>         return peci_controller_scan_devices(to_peci_controller(dev));
>  }
>
> -static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_=
t count)
> +static ssize_t rescan_store(const struct bus_type *bus, const char *buf,=
 size_t count)
>  {
>         bool res;
>         int ret;
> diff --git a/drivers/rapidio/rio-sysfs.c b/drivers/rapidio/rio-sysfs.c
> index f7679602498e..90d391210533 100644
> --- a/drivers/rapidio/rio-sysfs.c
> +++ b/drivers/rapidio/rio-sysfs.c
> @@ -286,7 +286,7 @@ const struct attribute_group *rio_dev_groups[] =3D {
>         NULL,
>  };
>
> -static ssize_t scan_store(struct bus_type *bus, const char *buf, size_t =
count)
> +static ssize_t scan_store(const struct bus_type *bus, const char *buf, s=
ize_t count)
>  {
>         long val;
>         int rc;
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index f4cc1720156f..5a99e0b18289 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -1166,12 +1166,12 @@ EXPORT_SYMBOL(ap_parse_mask_str);
>   * AP bus attributes.
>   */
>
> -static ssize_t ap_domain_show(struct bus_type *bus, char *buf)
> +static ssize_t ap_domain_show(const struct bus_type *bus, char *buf)
>  {
>         return scnprintf(buf, PAGE_SIZE, "%d\n", ap_domain_index);
>  }
>
> -static ssize_t ap_domain_store(struct bus_type *bus,
> +static ssize_t ap_domain_store(const struct bus_type *bus,
>                                const char *buf, size_t count)
>  {
>         int domain;
> @@ -1193,7 +1193,7 @@ static ssize_t ap_domain_store(struct bus_type *bus=
,
>
>  static BUS_ATTR_RW(ap_domain);
>
> -static ssize_t ap_control_domain_mask_show(struct bus_type *bus, char *b=
uf)
> +static ssize_t ap_control_domain_mask_show(const struct bus_type *bus, c=
har *buf)
>  {
>         if (!ap_qci_info)       /* QCI not supported */
>                 return scnprintf(buf, PAGE_SIZE, "not supported\n");
> @@ -1208,7 +1208,7 @@ static ssize_t ap_control_domain_mask_show(struct b=
us_type *bus, char *buf)
>
>  static BUS_ATTR_RO(ap_control_domain_mask);
>
> -static ssize_t ap_usage_domain_mask_show(struct bus_type *bus, char *buf=
)
> +static ssize_t ap_usage_domain_mask_show(const struct bus_type *bus, cha=
r *buf)
>  {
>         if (!ap_qci_info)       /* QCI not supported */
>                 return scnprintf(buf, PAGE_SIZE, "not supported\n");
> @@ -1223,7 +1223,7 @@ static ssize_t ap_usage_domain_mask_show(struct bus=
_type *bus, char *buf)
>
>  static BUS_ATTR_RO(ap_usage_domain_mask);
>
> -static ssize_t ap_adapter_mask_show(struct bus_type *bus, char *buf)
> +static ssize_t ap_adapter_mask_show(const struct bus_type *bus, char *bu=
f)
>  {
>         if (!ap_qci_info)       /* QCI not supported */
>                 return scnprintf(buf, PAGE_SIZE, "not supported\n");
> @@ -1238,7 +1238,7 @@ static ssize_t ap_adapter_mask_show(struct bus_type=
 *bus, char *buf)
>
>  static BUS_ATTR_RO(ap_adapter_mask);
>
> -static ssize_t ap_interrupts_show(struct bus_type *bus, char *buf)
> +static ssize_t ap_interrupts_show(const struct bus_type *bus, char *buf)
>  {
>         return scnprintf(buf, PAGE_SIZE, "%d\n",
>                          ap_irq_flag ? 1 : 0);
> @@ -1246,12 +1246,12 @@ static ssize_t ap_interrupts_show(struct bus_type=
 *bus, char *buf)
>
>  static BUS_ATTR_RO(ap_interrupts);
>
> -static ssize_t config_time_show(struct bus_type *bus, char *buf)
> +static ssize_t config_time_show(const struct bus_type *bus, char *buf)
>  {
>         return scnprintf(buf, PAGE_SIZE, "%d\n", ap_config_time);
>  }
>
> -static ssize_t config_time_store(struct bus_type *bus,
> +static ssize_t config_time_store(const struct bus_type *bus,
>                                  const char *buf, size_t count)
>  {
>         int time;
> @@ -1265,12 +1265,12 @@ static ssize_t config_time_store(struct bus_type =
*bus,
>
>  static BUS_ATTR_RW(config_time);
>
> -static ssize_t poll_thread_show(struct bus_type *bus, char *buf)
> +static ssize_t poll_thread_show(const struct bus_type *bus, char *buf)
>  {
>         return scnprintf(buf, PAGE_SIZE, "%d\n", ap_poll_kthread ? 1 : 0)=
;
>  }
>
> -static ssize_t poll_thread_store(struct bus_type *bus,
> +static ssize_t poll_thread_store(const struct bus_type *bus,
>                                  const char *buf, size_t count)
>  {
>         int flag, rc;
> @@ -1289,12 +1289,12 @@ static ssize_t poll_thread_store(struct bus_type =
*bus,
>
>  static BUS_ATTR_RW(poll_thread);
>
> -static ssize_t poll_timeout_show(struct bus_type *bus, char *buf)
> +static ssize_t poll_timeout_show(const struct bus_type *bus, char *buf)
>  {
>         return scnprintf(buf, PAGE_SIZE, "%llu\n", poll_timeout);
>  }
>
> -static ssize_t poll_timeout_store(struct bus_type *bus, const char *buf,
> +static ssize_t poll_timeout_store(const struct bus_type *bus, const char=
 *buf,
>                                   size_t count)
>  {
>         unsigned long long time;
> @@ -1318,21 +1318,21 @@ static ssize_t poll_timeout_store(struct bus_type=
 *bus, const char *buf,
>
>  static BUS_ATTR_RW(poll_timeout);
>
> -static ssize_t ap_max_domain_id_show(struct bus_type *bus, char *buf)
> +static ssize_t ap_max_domain_id_show(const struct bus_type *bus, char *b=
uf)
>  {
>         return scnprintf(buf, PAGE_SIZE, "%d\n", ap_max_domain_id);
>  }
>
>  static BUS_ATTR_RO(ap_max_domain_id);
>
> -static ssize_t ap_max_adapter_id_show(struct bus_type *bus, char *buf)
> +static ssize_t ap_max_adapter_id_show(const struct bus_type *bus, char *=
buf)
>  {
>         return scnprintf(buf, PAGE_SIZE, "%d\n", ap_max_adapter_id);
>  }
>
>  static BUS_ATTR_RO(ap_max_adapter_id);
>
> -static ssize_t apmask_show(struct bus_type *bus, char *buf)
> +static ssize_t apmask_show(const struct bus_type *bus, char *buf)
>  {
>         int rc;
>
> @@ -1393,7 +1393,7 @@ static int apmask_commit(unsigned long *newapm)
>         return 0;
>  }
>
> -static ssize_t apmask_store(struct bus_type *bus, const char *buf,
> +static ssize_t apmask_store(const struct bus_type *bus, const char *buf,
>                             size_t count)
>  {
>         int rc, changes =3D 0;
> @@ -1425,7 +1425,7 @@ static ssize_t apmask_store(struct bus_type *bus, c=
onst char *buf,
>
>  static BUS_ATTR_RW(apmask);
>
> -static ssize_t aqmask_show(struct bus_type *bus, char *buf)
> +static ssize_t aqmask_show(const struct bus_type *bus, char *buf)
>  {
>         int rc;
>
> @@ -1486,7 +1486,7 @@ static int aqmask_commit(unsigned long *newaqm)
>         return 0;
>  }
>
> -static ssize_t aqmask_store(struct bus_type *bus, const char *buf,
> +static ssize_t aqmask_store(const struct bus_type *bus, const char *buf,
>                             size_t count)
>  {
>         int rc, changes =3D 0;
> @@ -1518,13 +1518,13 @@ static ssize_t aqmask_store(struct bus_type *bus,=
 const char *buf,
>
>  static BUS_ATTR_RW(aqmask);
>
> -static ssize_t scans_show(struct bus_type *bus, char *buf)
> +static ssize_t scans_show(const struct bus_type *bus, char *buf)
>  {
>         return scnprintf(buf, PAGE_SIZE, "%llu\n",
>                          atomic64_read(&ap_scan_bus_count));
>  }
>
> -static ssize_t scans_store(struct bus_type *bus, const char *buf,
> +static ssize_t scans_store(const struct bus_type *bus, const char *buf,
>                            size_t count)
>  {
>         AP_DBF_INFO("%s force AP bus rescan\n", __func__);
> @@ -1536,7 +1536,7 @@ static ssize_t scans_store(struct bus_type *bus, co=
nst char *buf,
>
>  static BUS_ATTR_RW(scans);
>
> -static ssize_t bindings_show(struct bus_type *bus, char *buf)
> +static ssize_t bindings_show(const struct bus_type *bus, char *buf)
>  {
>         int rc;
>         unsigned int apqns, n;
> diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysf=
s.c
> index 6260aa5ea6af..e17957f8085c 100644
> --- a/drivers/scsi/fcoe/fcoe_sysfs.c
> +++ b/drivers/scsi/fcoe/fcoe_sysfs.c
> @@ -659,17 +659,17 @@ static const struct device_type fcoe_fcf_device_typ=
e =3D {
>         .release =3D fcoe_fcf_device_release,
>  };
>
> -static ssize_t ctlr_create_store(struct bus_type *bus, const char *buf,
> +static ssize_t ctlr_create_store(const struct bus_type *bus, const char =
*buf,
>                                  size_t count)
>  {
> -       return fcoe_ctlr_create_store(bus, buf, count);
> +       return fcoe_ctlr_create_store(buf, count);
>  }
>  static BUS_ATTR_WO(ctlr_create);
>
> -static ssize_t ctlr_destroy_store(struct bus_type *bus, const char *buf,
> +static ssize_t ctlr_destroy_store(const struct bus_type *bus, const char=
 *buf,
>                                   size_t count)
>  {
> -       return fcoe_ctlr_destroy_store(bus, buf, count);
> +       return fcoe_ctlr_destroy_store(buf, count);
>  }
>  static BUS_ATTR_WO(ctlr_destroy);
>
> diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_=
transport.c
> index 62341c6353a7..46b0bf237be1 100644
> --- a/drivers/scsi/fcoe/fcoe_transport.c
> +++ b/drivers/scsi/fcoe/fcoe_transport.c
> @@ -745,8 +745,7 @@ static int libfcoe_device_notification(struct notifie=
r_block *notifier,
>         return NOTIFY_OK;
>  }
>
> -ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
> -                              const char *buf, size_t count)
> +ssize_t fcoe_ctlr_create_store(const char *buf, size_t count)
>  {
>         struct net_device *netdev =3D NULL;
>         struct fcoe_transport *ft =3D NULL;
> @@ -808,8 +807,7 @@ ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
>         return count;
>  }
>
> -ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
> -                               const char *buf, size_t count)
> +ssize_t fcoe_ctlr_destroy_store(const char *buf, size_t count)
>  {
>         int rc =3D -ENODEV;
>         struct net_device *netdev =3D NULL;
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index c258e8770285..78c875386c06 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -118,8 +118,8 @@ extern int __must_check bus_rescan_devices(struct bus=
_type *bus);
>
>  struct bus_attribute {
>         struct attribute        attr;
> -       ssize_t (*show)(struct bus_type *bus, char *buf);
> -       ssize_t (*store)(struct bus_type *bus, const char *buf, size_t co=
unt);
> +       ssize_t (*show)(const struct bus_type *bus, char *buf);
> +       ssize_t (*store)(const struct bus_type *bus, const char *buf, siz=
e_t count);
>  };
>
>  #define BUS_ATTR_RW(_name) \
> diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
> index 279782156373..8300ef1a982e 100644
> --- a/include/scsi/libfcoe.h
> +++ b/include/scsi/libfcoe.h
> @@ -397,10 +397,8 @@ int fcoe_transport_attach(struct fcoe_transport *ft)=
;
>  int fcoe_transport_detach(struct fcoe_transport *ft);
>
>  /* sysfs store handler for ctrl_control interface */
> -ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
> -                              const char *buf, size_t count);
> -ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
> -                               const char *buf, size_t count);
> +ssize_t fcoe_ctlr_create_store(const char *buf, size_t count);
> +ssize_t fcoe_ctlr_destroy_store(const char *buf, size_t count);
>
>  #endif /* _LIBFCOE_H */
>
> --
> 2.39.2
>
