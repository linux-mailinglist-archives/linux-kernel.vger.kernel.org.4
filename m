Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F912609807
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJXCBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJXCBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:01:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEFE6F25C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 19:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666576893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d6wdvQ6duZTbfBMv6HUfxf5GdSznVSWkhVMKCWk6H8Q=;
        b=QfLyljs1pnpU5y551hEERJP8uMQXO/Zg3dQxe+qq7T3Y46usQ03zILTz2JPWdTaySmdtVd
        5MLrFoBwC+1PHWiYcgCCgVzPwJfe7TtthnNFQe72VLnciP/5EywRrkm6NnpPbG17AfTezi
        IQW50KOpRPIMeaBjABNrT1Toh/TWGCg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-Z3VHpLPmM9yhcgXkSV1ObA-1; Sun, 23 Oct 2022 22:01:32 -0400
X-MC-Unique: Z3VHpLPmM9yhcgXkSV1ObA-1
Received: by mail-oi1-f200.google.com with SMTP id t39-20020a05680815a700b003554487412aso1816167oiw.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 19:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6wdvQ6duZTbfBMv6HUfxf5GdSznVSWkhVMKCWk6H8Q=;
        b=qW2FFHF8baPkFg/T0hc3hfs6fY9mOyEFYyOufi3FHZyVqdipWQxihff1OSMTRXCTG7
         O7Q77bcgqILbfWWWeElQWkiy54ZvJjcreFfP1JP7QzOADqKGPkCYKrjr5zue+6EbdMuW
         6urkmEe3k3abqMyFHpXtCcf3wC+/txH5XhH8UbZeM84g1dLMGTM4HAk/wTgVAcOVKZy+
         w/NyS94IticRMjJAmgrLfk7jtrLH2AeGjErp/cdNpk5OJn2zMTh/kfezDgYh7mMoA3QX
         pTCIPQkfH5QSAy5moUIvE6ORODEZ/JSJJTvkGAUqeeG9Q25rMwM0c9GVv3xJ1lVPmx8g
         tG/Q==
X-Gm-Message-State: ACrzQf2EvBf75Q82d3DuApu+DR9gwvgbs7YW3exu207RHTjRk9dgrFUn
        F8lwvBAOu4QxwEpyrR5T3BOg+nf7FcRymo3nQ+Q1uxoR+SUU2we+DDvGUfSwBH3Cf5EZMDZJDJs
        ZT2tBpYE/0DRWTpxJHVtvvtrmu0Rg0cTuzkDrPIo5
X-Received: by 2002:a4a:c590:0:b0:480:5ecf:85f4 with SMTP id x16-20020a4ac590000000b004805ecf85f4mr13646648oop.93.1666576890658;
        Sun, 23 Oct 2022 19:01:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM68bvPmwcdaERMmLzDCe+QfAbwSfmdTvC7MR0CFQeGmzO3Qmm8e834LLnoo15fuG7dJcRzbqBgalK11K7R+Lgo=
X-Received: by 2002:a4a:c590:0:b0:480:5ecf:85f4 with SMTP id
 x16-20020a4ac590000000b004805ecf85f4mr13646642oop.93.1666576890463; Sun, 23
 Oct 2022 19:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221024015510.1917-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20221024015510.1917-1-angus.chen@jaguarmicro.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 24 Oct 2022 10:01:18 +0800
Message-ID: <CACGkMEsag0xGcGxPnaou3wiO8iJBL4Pxecj6Vd-KEN7otQX5aQ@mail.gmail.com>
Subject: Re: [PATCH v2] vDPA: rename get_vq_num_max to get_vq_size_max
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lingshan.zhu@intel.com
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

On Mon, Oct 24, 2022 at 9:56 AM Angus Chen <angus.chen@jaguarmicro.com> wrote:
>
> The get_vq_num_max of vdpa_config_ops is mean get the max size of vq,not
> the max number of vq,it is kind of confused,rename it.
> And get_vq_num_min rename to get_vq_size_min,
> set_vq_num rename to set_vq_size,
> rename implement of this ops also.
>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---

Not a native sparker. But num_max came from virtqueue structure:

/*
 ...
 * @num_max: the maximum number of elements supported by the device.
 ...
 */

struct virtqueue {
        ...
        unsigned int num_max;
        ...
};

Thanks

