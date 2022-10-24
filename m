Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8410609D07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiJXIoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiJXIn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AD96053A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666601037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=37cunLzz/xjWAuAYxixh7mVEDXes8SvYGmLQAkvvjj8=;
        b=JCOto4lTuJ8CkFHSilVg2wFGmPXGI6QAb7QO4OZAG6pZLFgE3wYellPUklTSQfFjiHTGEK
        F7BUd4Po/1UdnKPW4RkaBblzT+8+OTAg6OI3vWIrZ5au9a6s93c3AUOw0dxp3hHBt/WXma
        t/tjvH12KUG4NsI0+drWC77zceyLswI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-294-SSj8EZxFN9q5a-6E6Fo7MA-1; Mon, 24 Oct 2022 04:43:55 -0400
X-MC-Unique: SSj8EZxFN9q5a-6E6Fo7MA-1
Received: by mail-ot1-f69.google.com with SMTP id c8-20020a9d6c88000000b00660efaeb7d6so5203884otr.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37cunLzz/xjWAuAYxixh7mVEDXes8SvYGmLQAkvvjj8=;
        b=T0Tqs1EEARKuTZiHnVj0juQ8GuJSHlyHIjGhmxUN53zYPHxbDGkg40pKe01ARq3vDS
         A808nm1B3/mUJgBDKu28G+cD7cxRI+sNc8c1KVKn/d9DLgXaPuYwm9FPmi6wet/gf4xn
         gQwIKpoUuKmFiKtYDxHuIWF96zNYO64Jo6Lkf0tY5SxlAzTalcJKY5hfzJdFH4/trNSO
         hogdyfsXX4oUnyTY+jvE6/CKq/kyWKGz2cU3arMJ+4BDHu0NoytSkznXvlt8qFyMgFHz
         dArcwoB4WNXccPEswQyrxoO5JMfLpylpx15goYzWl5eKZJFXOm8ggdlPeHRm5mx58ifo
         b00Q==
X-Gm-Message-State: ACrzQf2jEqDlibZkAm1IlVnyqBBe/6Z5PI9LpzHK8jIZ9zd6T4d+yjhf
        ycoXUopKEne+3jQVv2E3bAKbwtDRu/0fpNER0EE+kYfKB7pE5RWaK31QhjiCqEPV4nUOFsSfuDK
        IYUXsyke9WGFMRBhSsKzp6meAkQHae6zuj7JFwtpx
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id e3-20020a056808148300b00354a36e005bmr29381412oiw.35.1666601033714;
        Mon, 24 Oct 2022 01:43:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6QOmcnUd5hsVuCK9YTa0H35I4j6OIckxitomGIVwkIozvSpd6Oxb10S0EmlqXL99JCxWV7DfRYCqWBwZ+iStY=
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr29381408oiw.35.1666601033493; Mon, 24
 Oct 2022 01:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com> <1666392237-4042-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666392237-4042-2-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 24 Oct 2022 16:43:40 +0800
Message-ID: <CACGkMEt-TiJ6LQczo4fY_eY9jWdDGVt_ZNXM8Eq3qkbNvLJmUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] vdpa: save vdpa_dev_set_config in struct vdpa_device
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> In order to allow live migration orchestration software to export the
> initial set of vdpa attributes with which the device was created, it
> will be useful if the vdpa tool can report the config on demand with
> simple query. This will ease the orchestration software implementation
> so that it doesn't have to keep track of vdpa config change, or have
> to persist vdpa attributes across failure and recovery, in fear of
> being killed due to accidental software error.
>
> This commit attempts to make struct vdpa_device contain the struct
> vdpa_dev_set_config, where all config attributes upon vdpa creation
> are carried over. Which will be used in subsequent commits.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>  include/linux/vdpa.h | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4..9f519a3 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -58,6 +58,16 @@ struct vdpa_vq_state {
>         };
>  };
>
> +struct vdpa_dev_set_config {
> +       u64 device_features;
> +       struct {
> +               u8 mac[ETH_ALEN];
> +               u16 mtu;
> +               u16 max_vq_pairs;
> +       } net;
> +       u64 mask;
> +};
> +
>  struct vdpa_mgmt_dev;
>
>  /**
> @@ -77,6 +87,8 @@ struct vdpa_vq_state {
>   * @nvqs: maximum number of supported virtqueues
>   * @mdev: management device pointer; caller must setup when registering device as part
>   *       of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
> + * @init_cfg: initial device config on vdpa creation; useful when instantiating
> + *            device with identical config is needed, e.g. migration.
>   */
>  struct vdpa_device {
>         struct device dev;
> @@ -91,6 +103,7 @@ struct vdpa_device {
>         struct vdpa_mgmt_dev *mdev;
>         unsigned int ngroups;
>         unsigned int nas;
> +       struct vdpa_dev_set_config init_cfg;
>  };
>
>  /**
> @@ -103,16 +116,6 @@ struct vdpa_iova_range {
>         u64 last;
>  };
>
> -struct vdpa_dev_set_config {
> -       u64 device_features;
> -       struct {
> -               u8 mac[ETH_ALEN];
> -               u16 mtu;
> -               u16 max_vq_pairs;
> -       } net;
> -       u64 mask;
> -};
> -
>  /**
>   * Corresponding file area for device memory mapping
>   * @file: vma->vm_file for the mapping
> --
> 1.8.3.1
>

