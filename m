Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B396F7B9F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjEEDrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEEDrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AED11638
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 20:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683258382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XXSt/ToeG7abONjanxyM5GaulTCPV5FswADO1Tk+VdA=;
        b=InOQk1n3a2DU9s4qjCM8oJcjtg4i/JZ/0a9yDQMIeClNI17sqe75KvkYvRarcFFp2DIJX+
        bUUadZaTknQRRW9/uTpiO0e2srDoz3poPcbj1s93V6UaLT88m07x32kUxQRD6c2zyTfrb7
        ItFSrzs5MLsswLQpA9M//Ng6l0Xz2+M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-5FfM9Hn_OiW9PNya3wwI3A-1; Thu, 04 May 2023 23:46:18 -0400
X-MC-Unique: 5FfM9Hn_OiW9PNya3wwI3A-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-24df4ef0603so623089a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 20:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683258377; x=1685850377;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXSt/ToeG7abONjanxyM5GaulTCPV5FswADO1Tk+VdA=;
        b=B4gDl1mKPIpwDn2w2C8kr8snljkc0X2SZkj4NMj5fGfZdlbtnGzUiG7FqGftTIHj9Y
         SEa6JeuxMlGvGvv61FSHT9yY9tf+j+r54U+O2BVpBjKzp8DKUHiZL211x6CACInu0Z9k
         a1pQ5HOFbPkQ3C/aJ9uSoVXXgTvcnWEyYFVTAXheEHHCBJ1hccC3OXNfEewWrnHVw1LH
         Trd+n6OBIGJB48jfns1E8tzhTbb8evmFwaSs6CzfAkPlwvuFAD3SBDSjmi80GqEXm6PT
         La+PmOKpEGXSsR7Yip/Wknn43YYVYXtOrPh8IRHslBnAKhQ3FFB+RgBy4FaCgnjAC2vd
         jWVA==
X-Gm-Message-State: AC+VfDwx+esAAmFMaLIzB3NWzIOuGASkdWneaGGghy6mFYSd/Mc5guGt
        zObC6vN+5SpsU6JNG8P6+ATOcCpVyFlY9zB55dvG2GPOTZOcVUqTIf2hEdXhxVEDzPDcE+ajGsd
        axPmOw3f6VxdUw9H2VSVNTHYq
X-Received: by 2002:a05:6a20:9187:b0:dd:e6f5:a798 with SMTP id v7-20020a056a20918700b000dde6f5a798mr191111pzd.6.1683258377659;
        Thu, 04 May 2023 20:46:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uzNVYqwoZ12N32XRVcLzHKoDUnytveRa6DJklrnk9647kWN+h+tLL4mZawoF7IdFY90EKZQ==
X-Received: by 2002:a05:6a20:9187:b0:dd:e6f5:a798 with SMTP id v7-20020a056a20918700b000dde6f5a798mr191087pzd.6.1683258377273;
        Thu, 04 May 2023 20:46:17 -0700 (PDT)
Received: from [10.72.12.124] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 205-20020a6304d6000000b00502e7115cbdsm510929pge.51.2023.05.04.20.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 20:46:16 -0700 (PDT)
Message-ID: <3f602115-4889-ead0-eb5a-a0db76b6e312@redhat.com>
Date:   Fri, 5 May 2023 11:46:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
Content-Language: en-US
From:   Jason Wang <jasowang@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, david.marchand@redhat.com,
        netdev <netdev@vger.kernel.org>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
In-Reply-To: <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/17 11:40, Jason Wang 写道:
> On Fri, Apr 14, 2023 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Fri, Apr 14, 2023 at 01:04:15PM +0800, Jason Wang wrote:
>>> Forget to cc netdev, adding.
>>>
>>> On Fri, Apr 14, 2023 at 12:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>> On Thu, Apr 13, 2023 at 02:40:26PM +0800, Jason Wang wrote:
>>>>> This patch convert rx mode setting to be done in a workqueue, this is
>>>>> a must for allow to sleep when waiting for the cvq command to
>>>>> response since current code is executed under addr spin lock.
>>>>>
>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> I don't like this frankly. This means that setting RX mode which would
>>>> previously be reliable, now becomes unreliable.
>>> It is "unreliable" by design:
>>>
>>>        void                    (*ndo_set_rx_mode)(struct net_device *dev);
>>>
>>>> - first of all configuration is no longer immediate
>>> Is immediate a hard requirement? I can see a workqueue is used at least:
>>>
>>> mlx5e, ipoib, efx, ...
>>>
>>>>    and there is no way for driver to find out when
>>>>    it actually took effect
>>> But we know rx mode is best effort e.g it doesn't support vhost and we
>>> survive from this for years.
>>>
>>>> - second, if device fails command, this is also not
>>>>    propagated to driver, again no way for driver to find out
>>>>
>>>> VDUSE needs to be fixed to do tricks to fix this
>>>> without breaking normal drivers.
>>> It's not specific to VDUSE. For example, when using virtio-net in the
>>> UP environment with any software cvq (like mlx5 via vDPA or cma
>>> transport).
>>>
>>> Thanks
>> Hmm. Can we differentiate between these use-cases?
> It doesn't look easy since we are drivers for virtio bus. Underlayer
> details were hidden from virtio-net.
>
> Or do you have any ideas on this?


Michael, any thought on this?

Thanks


>
> Thanks
>
>>>>
>>>>> ---
>>>>> Changes since V1:
>>>>> - use RTNL to synchronize rx mode worker
>>>>> ---
>>>>>   drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++++---
>>>>>   1 file changed, 52 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>> index e2560b6f7980..2e56bbf86894 100644
>>>>> --- a/drivers/net/virtio_net.c
>>>>> +++ b/drivers/net/virtio_net.c
>>>>> @@ -265,6 +265,12 @@ struct virtnet_info {
>>>>>        /* Work struct for config space updates */
>>>>>        struct work_struct config_work;
>>>>>
>>>>> +     /* Work struct for config rx mode */
>>>>> +     struct work_struct rx_mode_work;
>>>>> +
>>>>> +     /* Is rx mode work enabled? */
>>>>> +     bool rx_mode_work_enabled;
>>>>> +
>>>>>        /* Does the affinity hint is set for virtqueues? */
>>>>>        bool affinity_hint_set;
>>>>>
>>>>> @@ -388,6 +394,20 @@ static void disable_delayed_refill(struct virtnet_info *vi)
>>>>>        spin_unlock_bh(&vi->refill_lock);
>>>>>   }
>>>>>
>>>>> +static void enable_rx_mode_work(struct virtnet_info *vi)
>>>>> +{
>>>>> +     rtnl_lock();
>>>>> +     vi->rx_mode_work_enabled = true;
>>>>> +     rtnl_unlock();
>>>>> +}
>>>>> +
>>>>> +static void disable_rx_mode_work(struct virtnet_info *vi)
>>>>> +{
>>>>> +     rtnl_lock();
>>>>> +     vi->rx_mode_work_enabled = false;
>>>>> +     rtnl_unlock();
>>>>> +}
>>>>> +
>>>>>   static void virtqueue_napi_schedule(struct napi_struct *napi,
>>>>>                                    struct virtqueue *vq)
>>>>>   {
>>>>> @@ -2310,9 +2330,11 @@ static int virtnet_close(struct net_device *dev)
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static void virtnet_set_rx_mode(struct net_device *dev)
>>>>> +static void virtnet_rx_mode_work(struct work_struct *work)
>>>>>   {
>>>>> -     struct virtnet_info *vi = netdev_priv(dev);
>>>>> +     struct virtnet_info *vi =
>>>>> +             container_of(work, struct virtnet_info, rx_mode_work);
>>>>> +     struct net_device *dev = vi->dev;
>>>>>        struct scatterlist sg[2];
>>>>>        struct virtio_net_ctrl_mac *mac_data;
>>>>>        struct netdev_hw_addr *ha;
>>>>> @@ -2325,6 +2347,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>>>>>        if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>>>>>                return;
>>>>>
>>>>> +     rtnl_lock();
>>>>> +
>>>>>        vi->ctrl->promisc = ((dev->flags & IFF_PROMISC) != 0);
>>>>>        vi->ctrl->allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
>>>>>
>>>>> @@ -2342,14 +2366,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>>>>>                dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
>>>>>                         vi->ctrl->allmulti ? "en" : "dis");
>>>>>
>>>>> +     netif_addr_lock_bh(dev);
>>>>> +
>>>>>        uc_count = netdev_uc_count(dev);
>>>>>        mc_count = netdev_mc_count(dev);
>>>>>        /* MAC filter - use one buffer for both lists */
>>>>>        buf = kzalloc(((uc_count + mc_count) * ETH_ALEN) +
>>>>>                      (2 * sizeof(mac_data->entries)), GFP_ATOMIC);
>>>>>        mac_data = buf;
>>>>> -     if (!buf)
>>>>> +     if (!buf) {
>>>>> +             netif_addr_unlock_bh(dev);
>>>>> +             rtnl_unlock();
>>>>>                return;
>>>>> +     }
>>>>>
>>>>>        sg_init_table(sg, 2);
>>>>>
>>>>> @@ -2370,6 +2399,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>>>>>        netdev_for_each_mc_addr(ha, dev)
>>>>>                memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
>>>>>
>>>>> +     netif_addr_unlock_bh(dev);
>>>>> +
>>>>>        sg_set_buf(&sg[1], mac_data,
>>>>>                   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
>>>>>
>>>>> @@ -2377,9 +2408,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>>>>>                                  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
>>>>>                dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
>>>>>
>>>>> +     rtnl_unlock();
>>>>> +
>>>>>        kfree(buf);
>>>>>   }
>>>>>
>>>>> +static void virtnet_set_rx_mode(struct net_device *dev)
>>>>> +{
>>>>> +     struct virtnet_info *vi = netdev_priv(dev);
>>>>> +
>>>>> +     if (vi->rx_mode_work_enabled)
>>>>> +             schedule_work(&vi->rx_mode_work);
>>>>> +}
>>>>> +
>>>>>   static int virtnet_vlan_rx_add_vid(struct net_device *dev,
>>>>>                                   __be16 proto, u16 vid)
>>>>>   {
>>>>> @@ -3150,6 +3191,8 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>>>>>
>>>>>        /* Make sure no work handler is accessing the device */
>>>>>        flush_work(&vi->config_work);
>>>>> +     disable_rx_mode_work(vi);
>>>>> +     flush_work(&vi->rx_mode_work);
>>>>>
>>>>>        netif_tx_lock_bh(vi->dev);
>>>>>        netif_device_detach(vi->dev);
>>>> So now configuration is not propagated to device.
>>>> Won't device later wake up in wrong state?
>>>>
>>>>
>>>>> @@ -3172,6 +3215,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>>>>>        virtio_device_ready(vdev);
>>>>>
>>>>>        enable_delayed_refill(vi);
>>>>> +     enable_rx_mode_work(vi);
>>>>>
>>>>>        if (netif_running(vi->dev)) {
>>>>>                err = virtnet_open(vi->dev);
>>>>> @@ -3969,6 +4013,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>>        vdev->priv = vi;
>>>>>
>>>>>        INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>>>>> +     INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>>>>>        spin_lock_init(&vi->refill_lock);
>>>>>
>>>>>        if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
>>>>> @@ -4077,6 +4122,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>>        if (vi->has_rss || vi->has_rss_hash_report)
>>>>>                virtnet_init_default_rss(vi);
>>>>>
>>>>> +     enable_rx_mode_work(vi);
>>>>> +
>>>>>        /* serialize netdev register + virtio_device_ready() with ndo_open() */
>>>>>        rtnl_lock();
>>>>>
>>>>> @@ -4174,6 +4221,8 @@ static void virtnet_remove(struct virtio_device *vdev)
>>>>>
>>>>>        /* Make sure no work handler is accessing the device. */
>>>>>        flush_work(&vi->config_work);
>>>>> +     disable_rx_mode_work(vi);
>>>>> +     flush_work(&vi->rx_mode_work);
>>>>>
>>>>>        unregister_netdev(vi->dev);
>>>>>
>>>>> --
>>>>> 2.25.1

