Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5BD66940A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbjAMKY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbjAMKXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:23:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43202564ED
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673605371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hap3aPSzXwOS05ixnlg4S7KjMs2H1FXCtTmNj33aaoo=;
        b=AY83yzOWUxeXxcXpM+kVe1OJOyZr4KdB7QkSng0ter4n6cjh3WNjjOyjBiHkLjN4/9shCB
        ELhjm8IYN7nda5PYQG3Q07Zp7JrQ1y4GFZDYDghpNPUKq/FIBOTWQ0wtF4XlKTXfGl/sIR
        TUsyUdKOEZWotf0dT5B1qdBbZUPys7c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-cwQKBRCOPtu9yHpKX9yrmw-1; Fri, 13 Jan 2023 05:22:49 -0500
X-MC-Unique: cwQKBRCOPtu9yHpKX9yrmw-1
Received: by mail-qv1-f72.google.com with SMTP id lp10-20020a056214590a00b0053180ee70f1so11300834qvb.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hap3aPSzXwOS05ixnlg4S7KjMs2H1FXCtTmNj33aaoo=;
        b=NrJ/Xdp7dysugTonYyx22EcbiFFoIKDeaOKetVqC40VpXD9cdWt015mU7WI3Yxm83k
         dJtmxHJ8m2Ea7Pes8NxfL2prpE86aC01cXZZD5Yg3p187cLyhg688nP7SEYPXB/fz9i/
         hoYku2L/I6neDdQekSaKBF0ylegHgpoLfKUCu9G5lj29KvQkzkddJMN6hLdF6sbFw9Tm
         RH54NE5r4ulU/Hs8ptYFPHeiCEjwAd+0LdVau/Qnt5b6mksbUVZv3lEVSzBD+kpgdN/q
         o9wXVOwsttAo6zkKqGpOpfp30mtTci5gDmGirC8/AnDKNAkBvmsAvJ22QISTTDCiHmh7
         E1mA==
X-Gm-Message-State: AFqh2kpcIM9fChzgrSxMigGpLTCr2jKbK7iu9gmQrUKawEpM9mgi0kt4
        PCnoUxfywmV53yXnhtK51mzgkxzuQlLu6sZ4KGfhez9Z7i2RhPkwqgUcczM8h4adUCDKIFHz+g3
        /8mtTiQu3b9bn/zoCveEEZanh
X-Received: by 2002:a05:6214:440d:b0:534:2daa:fba4 with SMTP id oj13-20020a056214440d00b005342daafba4mr9630279qvb.19.1673605369291;
        Fri, 13 Jan 2023 02:22:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuwoBF5Z2CpSss2nE/Pg/feZyMgHWTbTY2Sis1r77mrss92oe1sx+Ed1/nJ0A3bZpMtoVdG3w==
X-Received: by 2002:a05:6214:440d:b0:534:2daa:fba4 with SMTP id oj13-20020a056214440d00b005342daafba4mr9630256qvb.19.1673605368983;
        Fri, 13 Jan 2023 02:22:48 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-244.retail.telecomitalia.it. [79.46.200.244])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a255200b006eeb3165565sm12472057qko.80.2023.01.13.02.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:22:48 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:22:44 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     sebastien.boeuf@intel.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        jasowang@redhat.com, eperezma@redhat.com
Subject: Re: [PATCH v6 4/4] vdpa_sim: Implement resume vdpa op
Message-ID: <20230113102244.ugaugqxpwam7tugv@sgarzare-redhat>
References: <cover.1672742878.git.sebastien.boeuf@intel.com>
 <15a4566826033c5dd9a2167e5cfb0ef4d90cea49.1672742878.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <15a4566826033c5dd9a2167e5cfb0ef4d90cea49.1672742878.git.sebastien.boeuf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:51:08AM +0100, sebastien.boeuf@intel.com wrote:
>From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
>Implement resume operation for vdpa_sim devices, so vhost-vdpa will
>offer that backend feature and userspace can effectively resume the
>device.
>
>Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 29 +++++++++++++++++++++++++++++
> drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
> 2 files changed, 30 insertions(+)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index b071f0d842fb..756a5db0109c 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -357,6 +357,12 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
>+	if (!vdpasim->running &&
>+	    (vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>+		vdpasim->pending_kick = true;
>+		return;
>+	}
>+
> 	if (vq->ready)
> 		schedule_work(&vdpasim->work);
> }
>@@ -527,6 +533,27 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
> 	return 0;
> }
>
>+static int vdpasim_resume(struct vdpa_device *vdpa)
>+{
>+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>+	int i;
>+
>+	spin_lock(&vdpasim->lock);
>+	vdpasim->running = true;
>+
>+	if (vdpasim->pending_kick) {

IIUC if one of the vq receive a kick while the device is suspended, we 
will kick all the vq.

At this point perhaps we should either send the kick only to the vqs we 
should notify, or send it to all of them indiscriminately (I don't know 
if it is correct to send a spurious kick).

Thanks,
Stefano

>+		/* Process pending descriptors */
>+		for (i = 0; i < vdpasim->dev_attr.nvqs; ++i)
>+			vdpasim_kick_vq(vdpa, i);
>+
>+		vdpasim->pending_kick = false;
>+	}
>+
>+	spin_unlock(&vdpasim->lock);
>+
>+	return 0;
>+}
>+
> static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
> {
> 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>@@ -717,6 +744,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> 	.set_status             = vdpasim_set_status,
> 	.reset			= vdpasim_reset,
> 	.suspend		= vdpasim_suspend,
>+	.resume			= vdpasim_resume,
> 	.get_config_size        = vdpasim_get_config_size,
> 	.get_config             = vdpasim_get_config,
> 	.set_config             = vdpasim_set_config,
>@@ -750,6 +778,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
> 	.set_status             = vdpasim_set_status,
> 	.reset			= vdpasim_reset,
> 	.suspend		= vdpasim_suspend,
>+	.resume			= vdpasim_resume,
> 	.get_config_size        = vdpasim_get_config_size,
> 	.get_config             = vdpasim_get_config,
> 	.set_config             = vdpasim_set_config,
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>index 0e78737dcc16..a745605589e2 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -67,6 +67,7 @@ struct vdpasim {
> 	u64 features;
> 	u32 groups;
> 	bool running;
>+	bool pending_kick;
> 	/* spinlock to synchronize iommu table */
> 	spinlock_t iommu_lock;
> };
>-- 
>2.37.2
>
>---------------------------------------------------------------------
>Intel Corporation SAS (French simplified joint stock company)
>Registered headquarters: "Les Montalets"- 2, rue de Paris,
>92196 Meudon Cedex, France
>Registration Number:  302 456 199 R.C.S. NANTERRE
>Capital: 5 208 026.16 Euros
>
>This e-mail and any attachments may contain confidential material for
>the sole use of the intended recipient(s). Any review or distribution
>by others is strictly prohibited. If you are not the intended
>recipient, please contact the sender and delete all copies.
>

