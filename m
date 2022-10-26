Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE860EAD3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiJZV33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJZV31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:29:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301F0138B8E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:29:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a67so43775157edf.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Idd0Hb78ztmsONfbOU5aIzBiJwVe7VkMWxVXkQJGGR0=;
        b=DinbMQBIydVstQWlIMsTMkASzRhi6Bgsazw851vqWYHRId1tuK0lsLzNSArjgEqwvY
         CfJwqxIK6JyqkH6Tcus2Gils+S+vzbqCkdOaeM6bJERtjQNsAuWQImrR8L4VpBYuMGoE
         CIgSmKIqLEhmop7RoF+9wNri5oDiQAl5VFZkkOU9zrJnvz3UiXXaOWaVOu6FycxEcFPk
         ePm0XIT6cCOufWh5GTYrZkjSuRf34KFfVAswUwrtsj/V/4ZIa6R7ES72DEcwE300g0Ox
         VGR6WVxQuexAlcYhyr8Wa2DiK31AJ2S22HIcIV1D/dTE8ufsd2qQ0PLJDtjneK5tD1dy
         MIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Idd0Hb78ztmsONfbOU5aIzBiJwVe7VkMWxVXkQJGGR0=;
        b=oKdfUQnzzehrdc0SseEKzgRnoGXAJE/cvIAptk4Q77MrhnlAjk5Oqn0JXgBU9urF4N
         qmSc8krJq3KjStakphVIlKApORx6MWORncUIqRShYbAvDs/+CXf4X7RqitxIDUq6f/XE
         ySWgiO4L+Vg878SZCJnVX+naYDwC7srlcpDDtWdhN5MMbLH6zNv/1X1rMvqFjKuEuQsk
         OSpQMzzp9Wxt2QHmJJdr0qNiZg295DhRu0M7MwUSaEUv6xZgz6OFNaWd6V9FxRv5Hv6r
         ZrK+G85jbZCyghZOZKRMUR0cgGziE51RoKZmxyOD6OFjtwbi9TX5gUMjKhTlmZ63bP4e
         7SLQ==
X-Gm-Message-State: ACrzQf2adlrKx4eKJlYwqq2V3Dfz6fln9xemZH+Tm+07Favj+izg4sfR
        iqwIw7Vpj1ymsL8px/AlRs5J9w8MERVKjxIS7PDyoA==
X-Google-Smtp-Source: AMsMyM6kRwjV9/szTrjs7h3XAUyi7r15t/ukN7NiqEbr92FgP1GxYSk5dYdN8UduhH7sy0nqw6V6GUgs1GIW3wehPw4=
X-Received: by 2002:a05:6402:26ca:b0:462:7f27:a0dd with SMTP id
 x10-20020a05640226ca00b004627f27a0ddmr2075991edd.132.1666819762711; Wed, 26
 Oct 2022 14:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221017171118.1588820-1-sammler@google.com>
In-Reply-To: <20221017171118.1588820-1-sammler@google.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 26 Oct 2022 17:28:45 -0400
Message-ID: <CA+CK2bCNYe6V9TJDKD5s5cseQ8vzBP9BTykpQfRUtwcaecBkFQ@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_pmem: populate numa information
To:     Michael Sammler <sammler@google.com>
Cc:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 1:11 PM Michael Sammler <sammler@google.com> wrote:
>
> Compute the numa information for a virtio_pmem device from the memory
> range of the device. Previously, the target_node was always 0 since
> the ndr_desc.target_node field was never explicitly set. The code for
> computing the numa node is taken from cxl_pmem_region_probe in
> drivers/cxl/pmem.c.
>
> Signed-off-by: Michael Sammler <sammler@google.com>

Enables the hot-plugging of virtio-pmem memory into correct memory
nodes. Does not look like it effect the FS_DAX.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha

> ---
>  drivers/nvdimm/virtio_pmem.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 20da455d2ef6..a92eb172f0e7 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -32,7 +32,6 @@ static int init_vq(struct virtio_pmem *vpmem)
>  static int virtio_pmem_probe(struct virtio_device *vdev)
>  {
>         struct nd_region_desc ndr_desc = {};
> -       int nid = dev_to_node(&vdev->dev);
>         struct nd_region *nd_region;
>         struct virtio_pmem *vpmem;
>         struct resource res;
> @@ -79,7 +78,15 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>         dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
>
>         ndr_desc.res = &res;
> -       ndr_desc.numa_node = nid;
> +
> +       ndr_desc.numa_node = memory_add_physaddr_to_nid(res.start);
> +       ndr_desc.target_node = phys_to_target_node(res.start);
> +       if (ndr_desc.target_node == NUMA_NO_NODE) {
> +               ndr_desc.target_node = ndr_desc.numa_node;
> +               dev_dbg(&vdev->dev, "changing target node from %d to %d",
> +                       NUMA_NO_NODE, ndr_desc.target_node);
> +       }
> +
>         ndr_desc.flush = async_pmem_flush;
>         ndr_desc.provider_data = vdev;
>         set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> --
> 2.38.0.413.g74048e4d9e-goog
