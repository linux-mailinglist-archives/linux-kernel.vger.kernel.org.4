Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A66531DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiLUNfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLUNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:35:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA66CE9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671629659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWvv0yVxWiEaUy/PxGdRu5ElcF4XOZHCSmq8VghIbjU=;
        b=MxuPqooZrJ+X+ulXXQPwktNKyqMK8NOjvBt18RiWnwazPjWTJZN+M1l9o7hmoX/4KfBo9w
        0wF+OSwpJT2rJzYx2moD5axlGVfIk8KCHnisdaXc2QkBSHdKVSrKthpYcv/FcUOpNAC4e+
        g1LblDJnRQnSqG14XAUFMLGvoqMiKbI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-186-ofb_y5lsNWK1E4oPCu4jSQ-1; Wed, 21 Dec 2022 08:34:18 -0500
X-MC-Unique: ofb_y5lsNWK1E4oPCu4jSQ-1
Received: by mail-wm1-f72.google.com with SMTP id f20-20020a7bc8d4000000b003d1cda5bd6fso682478wml.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWvv0yVxWiEaUy/PxGdRu5ElcF4XOZHCSmq8VghIbjU=;
        b=jh/FrCIWDexzm0JMLQ4YsmhBXLUWmGuCZ1hO1dIelOnenPQxgFclHgCuZrzSK6tiFy
         Ys5+3w6HRkeiW6I4BmEPDXo3OEo4fv+K+ZMh2l9JqmpqfRKDdjGPhQo3XXkd23sOFdBf
         uLjobDqumPG7f6nRKyPrK5KCcir/RlYMYdgcFxQb6vxD2SNZrx9QwPEYhGJEwLL71bDT
         jnNRBXHkhBI0b047tje+2x33SLnTMqF8NPQrHuTEzn/BKiayklM6DyWTjjKe3enRxVfj
         4G2OEyYtDlVMm3vIZ3QwwHOLhzIcmhshbph6TC6zQsrI3p9DCLHJusF4FqOKDDCbaBmT
         axZg==
X-Gm-Message-State: AFqh2kqQT7H8fH433/qnr5ftXcgpWJqEajh8bVOl3aRrd6D+Zyzu9P7j
        lbBTEQX9UN5yFV161ieAL5rRX3Ta28lzYi2mV0R/ivhKFmi1KSpAE1SzRPfIfmyCKM4ep90lhN3
        4P3zsICh7HYwvNEZzm8QccrsF
X-Received: by 2002:adf:d4ca:0:b0:242:1dd6:faa3 with SMTP id w10-20020adfd4ca000000b002421dd6faa3mr3206801wrk.23.1671629657455;
        Wed, 21 Dec 2022 05:34:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt32Wy1vsAsafJ8i+LX0v6mcat5HXfjOVBXGktQWG4rLGZHf1HuDcVnsImxNdMtavFxHzzoxQ==
X-Received: by 2002:adf:d4ca:0:b0:242:1dd6:faa3 with SMTP id w10-20020adfd4ca000000b002421dd6faa3mr3206794wrk.23.1671629657255;
        Wed, 21 Dec 2022 05:34:17 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600016c900b002425dc49024sm15366015wrf.43.2022.12.21.05.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:34:16 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:34:14 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] vdpa_sim: support vendor satistics
Message-ID: <20221221133414.teizf56exrf5tqvj@sgarzare-redhat>
References: <20221221061652.15202-1-jasowang@redhat.com>
 <20221221061652.15202-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221221061652.15202-4-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:16:51PM +0800, Jason Wang wrote:

Little typo in the title s/satistics/statistics

>This patch adds a new config ops callback to allow individual
>simulator to implement the vendor stats callback.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
> drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 +++
> 2 files changed, 16 insertions(+)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 55aaa023a6e2..02e892f819e7 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -426,6 +426,18 @@ static int vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> 	return 0;
> }
>
>+static int vdpasim_get_vq_stats(struct vdpa_device *vdpa, u16 idx,
>+				struct sk_buff *msg,
>+				struct netlink_ext_ack *extack)
>+{
>+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>+
>+	if (vdpasim->dev_attr.get_stats)
>+		return vdpasim->dev_attr.get_stats(vdpasim, idx,
>+						   msg, extack);
>+	return -EINVAL;

Maybe -EOPNOTSUPP is better when the device doesn't support it.
Like we do in vendor_stats_fill() in drivers/vdpa/vdpa.c

>+}
>+
> static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
> {
> 	return VDPASIM_QUEUE_ALIGN;
>@@ -710,6 +722,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> 	.set_vq_ready           = vdpasim_set_vq_ready,
> 	.get_vq_ready           = vdpasim_get_vq_ready,
> 	.set_vq_state           = vdpasim_set_vq_state,
>+	.get_vendor_vq_stats    = vdpasim_get_vq_stats,

Should we add this callback also in vdpasim_batch_config_ops?

Thanks,
Stefano

> 	.get_vq_state           = vdpasim_get_vq_state,
> 	.get_vq_align           = vdpasim_get_vq_align,
> 	.get_vq_group           = vdpasim_get_vq_group,
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>index 51c070a543f1..d2a08c0abad7 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -48,6 +48,9 @@ struct vdpasim_dev_attr {
> 	work_func_t work_fn;
> 	void (*get_config)(struct vdpasim *vdpasim, void *config);
> 	void (*set_config)(struct vdpasim *vdpasim, const void *config);
>+	int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
>+			 struct sk_buff *msg,
>+			 struct netlink_ext_ack *extack);
> };
>
> /* State of each vdpasim device */
>-- 
>2.25.1
>

