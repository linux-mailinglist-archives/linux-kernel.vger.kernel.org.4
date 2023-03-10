Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46236B35FB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 06:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCJFLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 00:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCJFK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 00:10:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92D91070FF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 21:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678424957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gooWS3hDuOnEfIrQXNJibPdBu4nf3TG1tpeCDx4EWgk=;
        b=E66u0iEmj8IA1mMIZaRP9AC2kh9ICm/0VY/gBc1ZWwe22/7entoHUNB0F8+Rkf1ZnMUics
        ehSNMeprlc4gkCYYXfjQFfZumsWVL/ARI/RB6kPeT9VFyl6ugsFkCACHvxsEgexxB76XfF
        RJQfq+OPEdhIrZHayK1f+tTygFE5UnA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-7UyufpWAOrubY4BUtYtgJw-1; Fri, 10 Mar 2023 00:09:13 -0500
X-MC-Unique: 7UyufpWAOrubY4BUtYtgJw-1
Received: by mail-ot1-f72.google.com with SMTP id m20-20020a05683026d400b006942d0ed1d1so1892622otu.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 21:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678424953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gooWS3hDuOnEfIrQXNJibPdBu4nf3TG1tpeCDx4EWgk=;
        b=jatKxsp0HifC7RdMy56ONf1mczHjMuQ7Pq1Ctc9cFoZw2ENc26dCjlHoNF+295HjxH
         pJu6S8IvaWYeQgsHS6SLnhwUCwfmGTSoYWeWFq+c1uw8111+39PhL0Pw0bqI5V4F8AB0
         VYLpctE7fRPhO37gsFi9yeA4crCrKPwLM6LpCMBSH9lZjrtg5kujVD2NFea5h99aOURh
         UEI1sluTpWaZPHzplL0HUaiGTRKbloLn1Xh0vNzKf/Gug4upKy6C6m/ToUTEW5gFcsZl
         FUwMxC1CWzkX9YqfNRIT0IGV14UXkyeY5uKJ6R9VRHimKPPNueXcH7iZ8KDoNXTa8Wky
         484Q==
X-Gm-Message-State: AO0yUKXEpghpSiRRgCBmUOFlTrfnIAEZP3dST71gx6OfPGFq17hoj1/W
        qtBYZVxeSuuheC1MwCndirEPvUFwsD7geKLx1vx40h0Odmas1Ht11Xv3IoLXIL4cQ7KtqUiHiED
        QTsdnuG/GRN05vImSuzS7BPLeJN1P9J5ZtZhiDq/b
X-Received: by 2002:aca:1708:0:b0:37f:9a01:f661 with SMTP id j8-20020aca1708000000b0037f9a01f661mr7186454oii.9.1678424953077;
        Thu, 09 Mar 2023 21:09:13 -0800 (PST)
X-Google-Smtp-Source: AK7set+QLR0bzVbr/SxEPiBKHjENzlaLwQ9WuXtHOZKZs1790dS8nexDfLdkP7erkZNnQJMfjpkoOWhFRu0+O1c9DLo=
X-Received: by 2002:aca:1708:0:b0:37f:9a01:f661 with SMTP id
 j8-20020aca1708000000b0037f9a01f661mr7186441oii.9.1678424952854; Thu, 09 Mar
 2023 21:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20230307113621.64153-1-gautam.dawar@amd.com>
In-Reply-To: <20230307113621.64153-1-gautam.dawar@amd.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 10 Mar 2023 13:09:01 +0800
Message-ID: <CACGkMEtDqQJDQ5wRbU0xObi1hiTbaQ3K2Tfq36ZYXCW8BcphYA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/14] sfc: add vDPA support for EF100 devices
To:     Gautam Dawar <gautam.dawar@amd.com>
Cc:     linux-net-drivers@amd.com, Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        eperezma@redhat.com, harpreet.anand@amd.com, tanuj.kamde@amd.com,
        koushik.dutta@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 7:36=E2=80=AFPM Gautam Dawar <gautam.dawar@amd.com> =
wrote:
>
> Hi All,
>
> This series adds the vdpa support for EF100 devices.

Would you mind posting some performance numbers for this device?

Thanks

> For now, only a network class of vdpa device is supported and
> they can be created only on a VF. Each EF100 VF can have one
> of the three function personalities (EF100, vDPA & None) at
> any time with EF100 being the default. A VF's function personality
> is changed to vDPA while creating the vdpa device using vdpa tool.
>
> A vDPA management device is created per VF to allow selection of
> the desired VF for vDPA device creation. The MAC address for the
> target net device must be set either by specifying at the vdpa
> device creation time via the `mac` parameter of the `vdpa dev add`
> command or should be specified as the hardware address of the virtual
> function using `devlink port function set hw_addr` command before
> creating the vdpa device with the former taking precedence.
>
> Changes since v1:
>
> - To ensure isolation between DMA initiated by userspace (guest OS)
>   and the host MCDI buffer, ummap VF's MCDI DMA buffer and use PF's
>   IOMMU domain instead for executing vDPA VF's MCDI commands.
> - As a result of above change, it is no more necessary to check for
>   MCDI buffer's IOVA range overlap with the guest buffers. Accordingly,
>   the DMA config operations and the rbtree/list implementation to store
>   IOVA mappings have been dropped.
> - Support vDPA only if running Firmware supports CLIENT_CMD_VF_PROXY
>   capability.
> - Added .suspend config operation and updated get_vq_state/set_vq_state
>   to support Live Migration. Also, features VIRTIO_F_ORDER_PLATFORM and
>   VIRTIO_F_IN_ORDER have been masked off in get_device_features() to
>   allow Live Migration as QEMU SVQ doesn't support them yet.
> - Removed the minimum version (v6.1.0) requirement of QEMU as
>   VIRTIO_F_IN_ORDER is not exposed
> - Fetch the vdpa device MAC address from the underlying VF hw_addr (if
>   set via `devlink port function set hw_addr` command)
> - Removed the mandatory requirement of specifying mac address while
>   creating vdpa device
> - Moved create_vring_ctx() and get_doorbell_offset() in dev_add()
> - Moved IRQ allocation at the time of vring creation
> - Merged vring_created member of struct ef100_vdpa_vring_info as one
>   of the flags in vring_state
> - Simplified .set_status() implementation
> - Removed un-necessary vdpa_state checks against
>   EF100_VDPA_STATE_INITIALIZED
> - Removed userspace triggerable warning in kick_vq()
> - Updated year 2023 in copyright banner of new files
>
> Gautam Dawar (14):
>   sfc: add function personality support for EF100 devices
>   sfc: implement MCDI interface for vDPA operations
>   sfc: update MCDI headers for CLIENT_CMD_VF_PROXY capability bit
>   sfc: evaluate vdpa support based on FW capability CLIENT_CMD_VF_PROXY
>   sfc: implement init and fini functions for vDPA personality
>   sfc: implement vDPA management device operations
>   sfc: implement vdpa device config operations
>   sfc: implement vdpa vring config operations
>   sfc: implement device status related vdpa config operations
>   sfc: implement filters for receiving traffic
>   sfc: use PF's IOMMU domain for running VF's MCDI commands
>   sfc: unmap VF's MCDI buffer when switching to vDPA mode
>   sfc: update vdpa device MAC address
>   sfc: register the vDPA device
>
>  drivers/net/ethernet/sfc/Kconfig          |    8 +
>  drivers/net/ethernet/sfc/Makefile         |    1 +
>  drivers/net/ethernet/sfc/ef10.c           |    2 +-
>  drivers/net/ethernet/sfc/ef100.c          |    7 +-
>  drivers/net/ethernet/sfc/ef100_netdev.c   |   26 +-
>  drivers/net/ethernet/sfc/ef100_nic.c      |  183 +-
>  drivers/net/ethernet/sfc/ef100_nic.h      |   26 +-
>  drivers/net/ethernet/sfc/ef100_vdpa.c     |  543 +++
>  drivers/net/ethernet/sfc/ef100_vdpa.h     |  224 ++
>  drivers/net/ethernet/sfc/ef100_vdpa_ops.c |  793 ++++
>  drivers/net/ethernet/sfc/mcdi.c           |  108 +-
>  drivers/net/ethernet/sfc/mcdi.h           |    9 +-
>  drivers/net/ethernet/sfc/mcdi_filters.c   |   51 +-
>  drivers/net/ethernet/sfc/mcdi_functions.c |    9 +-
>  drivers/net/ethernet/sfc/mcdi_functions.h |    3 +-
>  drivers/net/ethernet/sfc/mcdi_pcol.h      | 4390 ++++++++++++++++++++-
>  drivers/net/ethernet/sfc/mcdi_vdpa.c      |  259 ++
>  drivers/net/ethernet/sfc/mcdi_vdpa.h      |   83 +
>  drivers/net/ethernet/sfc/net_driver.h     |   21 +
>  drivers/net/ethernet/sfc/ptp.c            |    4 +-
>  20 files changed, 6574 insertions(+), 176 deletions(-)
>  create mode 100644 drivers/net/ethernet/sfc/ef100_vdpa.c
>  create mode 100644 drivers/net/ethernet/sfc/ef100_vdpa.h
>  create mode 100644 drivers/net/ethernet/sfc/ef100_vdpa_ops.c
>  create mode 100644 drivers/net/ethernet/sfc/mcdi_vdpa.c
>  create mode 100644 drivers/net/ethernet/sfc/mcdi_vdpa.h
>
> --
> 2.30.1
>

