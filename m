Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C904770F1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbjEXJQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjEXJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233CA90
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684919712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hkGvluokZd4WakcwJ7QYs3rVKN2R+Qvo5TsPCzHhJ8=;
        b=RnyNLteD0+IZfWemVukKwvJ00X6Rb5uE7rtCvJTTUxqJj8g0fGyGIa2eaVhmnEn9vfdFe2
        ioyS3AB5AhqyfENu4Hrsw896yxsoD9EahXb2MDXijtRgLWr68/x4WHPCRt/DnsQMxNLB89
        J4RAAgOnTcgaSk/em55ai6irHtYj/l0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-ksULk4e6M220jU3imp-T-w-1; Wed, 24 May 2023 05:15:08 -0400
X-MC-Unique: ksULk4e6M220jU3imp-T-w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3093cb05431so366802f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684919708; x=1687511708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hkGvluokZd4WakcwJ7QYs3rVKN2R+Qvo5TsPCzHhJ8=;
        b=C47xqU0+LgkehQMmhXhhe9M//gOE21GYhijA4ONVYjdpl9uik51tSY8FWDuRvr5aSj
         +BEqjijjuePgnxPq+pDjnYkdwC/j8q4Xr1n/VGBCdWugtboK1hbCu2tYS4uS/63hnw5j
         S0kN6T/xKc5HjuUTadslcdWC6kV1JRC+x36jAoFgEHNuCBkxOUhbdQS+5RPtsvsyUIbA
         X6q3eu0QD3QlylgeKzba66qCxWu6nrlPJI5FW5t/klXBCXajozBg6pN7+1PxEznqFJ5j
         QS5QQ/+EiuHprcOCQHeKNThk7Tcm5zrIEENNSLRuL4BT9jgn+UAF/IkCViG69E8kretW
         3/tA==
X-Gm-Message-State: AC+VfDzIQlnHrF5UcNfoiFE8lQqFbh04EHB2NtcDo0Bg55DmzEYCALZq
        oi+BalrNhrKK2xlhJMYaknmN4j0Q13xzL4na+mrnqN0K72U1X3dlyIT5jHnE9q8S6QUduyNIfbE
        dCpvhb+ziK30xSycOIuSQc8TB
X-Received: by 2002:a5d:6145:0:b0:309:4df9:fa19 with SMTP id y5-20020a5d6145000000b003094df9fa19mr11480025wrt.23.1684919707860;
        Wed, 24 May 2023 02:15:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72mwklu7Hok3zzBwPfcLf9xSxlN8mmEOsWMqCqoghOrOhOz5L7HNzKD5hCSRcShSWlZBWcxQ==
X-Received: by 2002:a5d:6145:0:b0:309:4df9:fa19 with SMTP id y5-20020a5d6145000000b003094df9fa19mr11480005wrt.23.1684919707505;
        Wed, 24 May 2023 02:15:07 -0700 (PDT)
Received: from redhat.com ([2.52.29.218])
        by smtp.gmail.com with ESMTPSA id q3-20020adff783000000b002e61e002943sm13685876wrp.116.2023.05.24.02.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:15:06 -0700 (PDT)
Date:   Wed, 24 May 2023 05:15:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     xuanzhuo@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230524050604-mutt-send-email-mst@kernel.org>
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524081842.3060-2-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 04:18:41PM +0800, Jason Wang wrote:
> This patch convert rx mode setting to be done in a workqueue, this is
> a must for allow to sleep when waiting for the cvq command to
> response since current code is executed under addr spin lock.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - use RTNL to synchronize rx mode worker
> ---
>  drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 56ca1d270304..5d2f1da4eaa0 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -265,6 +265,12 @@ struct virtnet_info {
>  	/* Work struct for config space updates */
>  	struct work_struct config_work;
>  
> +	/* Work struct for config rx mode */

With a bit less abbreviation maybe? setting rx mode?

> +	struct work_struct rx_mode_work;
> +
> +	/* Is rx mode work enabled? */

Ugh not a great comment.

> +	bool rx_mode_work_enabled;
> +



>  	/* Does the affinity hint is set for virtqueues? */
>  	bool affinity_hint_set;
>  
> @@ -388,6 +394,20 @@ static void disable_delayed_refill(struct virtnet_info *vi)
>  	spin_unlock_bh(&vi->refill_lock);
>  }
>  
> +static void enable_rx_mode_work(struct virtnet_info *vi)
> +{
> +	rtnl_lock();
> +	vi->rx_mode_work_enabled = true;
> +	rtnl_unlock();
> +}
> +
> +static void disable_rx_mode_work(struct virtnet_info *vi)
> +{
> +	rtnl_lock();
> +	vi->rx_mode_work_enabled = false;
> +	rtnl_unlock();
> +}
> +
>  static void virtqueue_napi_schedule(struct napi_struct *napi,
>  				    struct virtqueue *vq)
>  {
> @@ -2341,9 +2361,11 @@ static int virtnet_close(struct net_device *dev)
>  	return 0;
>  }
>  
> -static void virtnet_set_rx_mode(struct net_device *dev)
> +static void virtnet_rx_mode_work(struct work_struct *work)
>  {
> -	struct virtnet_info *vi = netdev_priv(dev);
> +	struct virtnet_info *vi =
> +		container_of(work, struct virtnet_info, rx_mode_work);
> +	struct net_device *dev = vi->dev;
>  	struct scatterlist sg[2];
>  	struct virtio_net_ctrl_mac *mac_data;
>  	struct netdev_hw_addr *ha;
> @@ -2356,6 +2378,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>  		return;
>  
> +	rtnl_lock();
> +
>  	vi->ctrl->promisc = ((dev->flags & IFF_PROMISC) != 0);
>  	vi->ctrl->allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
>  
> @@ -2373,14 +2397,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
>  			 vi->ctrl->allmulti ? "en" : "dis");
>  
> +	netif_addr_lock_bh(dev);
> +
>  	uc_count = netdev_uc_count(dev);
>  	mc_count = netdev_mc_count(dev);
>  	/* MAC filter - use one buffer for both lists */
>  	buf = kzalloc(((uc_count + mc_count) * ETH_ALEN) +
>  		      (2 * sizeof(mac_data->entries)), GFP_ATOMIC);
>  	mac_data = buf;
> -	if (!buf)
> +	if (!buf) {
> +		netif_addr_unlock_bh(dev);
> +		rtnl_unlock();
>  		return;
> +	}
>  
>  	sg_init_table(sg, 2);
>  
> @@ -2401,6 +2430,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  	netdev_for_each_mc_addr(ha, dev)
>  		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
>  
> +	netif_addr_unlock_bh(dev);
> +
>  	sg_set_buf(&sg[1], mac_data,
>  		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
>  
> @@ -2408,9 +2439,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
>  		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
>  
> +	rtnl_unlock();
> +
>  	kfree(buf);
>  }
>  
> +static void virtnet_set_rx_mode(struct net_device *dev)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +
> +	if (vi->rx_mode_work_enabled)
> +		schedule_work(&vi->rx_mode_work);
> +}
> +

>  static int virtnet_vlan_rx_add_vid(struct net_device *dev,
>  				   __be16 proto, u16 vid)
>  {
> @@ -3181,6 +3222,8 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  
>  	/* Make sure no work handler is accessing the device */
>  	flush_work(&vi->config_work);
> +	disable_rx_mode_work(vi);
> +	flush_work(&vi->rx_mode_work);
>  
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_detach(vi->dev);

Hmm so queued rx mode work will just get skipped
and on restore we get a wrong rx mode.
Any way to make this more robust?


> @@ -3203,6 +3246,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  	virtio_device_ready(vdev);
>  
>  	enable_delayed_refill(vi);
> +	enable_rx_mode_work(vi);
>  
>  	if (netif_running(vi->dev)) {
>  		err = virtnet_open(vi->dev);
> @@ -4002,6 +4046,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	vdev->priv = vi;
>  
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> +	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>  	spin_lock_init(&vi->refill_lock);
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
> @@ -4110,6 +4155,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> +	enable_rx_mode_work(vi);
> +
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
>  	rtnl_lock();
>  
> @@ -4207,6 +4254,8 @@ static void virtnet_remove(struct virtio_device *vdev)
>  
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vi->config_work);
> +	disable_rx_mode_work(vi);
> +	flush_work(&vi->rx_mode_work);
>  
>  	unregister_netdev(vi->dev);
>  
> -- 
> 2.25.1

