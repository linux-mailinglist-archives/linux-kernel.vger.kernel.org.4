Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF00653B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiLVEFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLVEFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:05:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DC322B32
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671681860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVqpTB9kSDtdBq16iyM8G8mQouGSH6ewMBa3rOuFLhw=;
        b=K6Rzaxqpnb0oCBt9taWbvJdCTiZfsy6M8MF/kbI2AoVNv8pGGa+sdWmV5BKUvb7CoSkBos
        AAPk6xPsFFI2cZJEgal7MW8GF+s/feb1XKiEUn5bhSCUd7BcEYFU6TgAwguOXLjrBZEtwk
        c4rS9CwbQJyshbBRMxY7p02NTSoix3I=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-335-jo49eKfsNcGHz5Xz_1OK4A-1; Wed, 21 Dec 2022 23:04:18 -0500
X-MC-Unique: jo49eKfsNcGHz5Xz_1OK4A-1
Received: by mail-pf1-f199.google.com with SMTP id a18-20020a62bd12000000b0056e7b61ec78so395453pff.17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVqpTB9kSDtdBq16iyM8G8mQouGSH6ewMBa3rOuFLhw=;
        b=xLhxpVml4M7qq5n6fW1pWe/sj1+4hPmta5660LcXORcHfIjVsViR1MPnSVQPQZzG4r
         BiD5MrVx5n4mlKeMECqEnCk+Wv51jfxmvKgOquSh2KbeLr5MCKHaCnCBEuTnB9NVbheu
         hEiCmGvjDquC1jm8Ba6RZnJSmbXwE4ihQQC3lhkefhuYvcJr6g6xy+PaBYVM9AMjZe7A
         ch9KmUtXGDezoXhrGagRdx5Hi5LfYAc12y/uULmWaq/KmdTsg51Wj7do85DhU4A2eObH
         ihwcJiyWWKqKxGkR0wE4RPjaarBPrmUM8zWLmBbAheQET/6qsQeDeVBU8eCj2xnxfRxn
         S4ag==
X-Gm-Message-State: AFqh2kq7sO/pYMTluLtKpbmpg5H/xHAx/yWnmmCScdq3NQ9E1LxBaZcY
        KFFXIT3L2aEyaJZjfpjLjLBhe6hIR4XBiHATiVp2s3WkJb9kEADgzNRs3106mFD8MjT1czKhP4s
        DOwmoVXBUjnnblCC4laK1Ugym
X-Received: by 2002:a17:903:292:b0:189:c6fb:c215 with SMTP id j18-20020a170903029200b00189c6fbc215mr4884182plr.62.1671681857626;
        Wed, 21 Dec 2022 20:04:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvtFmXfh2za0Cq13FxFeZHad5gCC+IwiYM8HpBp8jZumBqbmiAdSfV38KG3mH3iZ/I1GB4lzA==
X-Received: by 2002:a17:903:292:b0:189:c6fb:c215 with SMTP id j18-20020a170903029200b00189c6fbc215mr4884162plr.62.1671681857305;
        Wed, 21 Dec 2022 20:04:17 -0800 (PST)
Received: from [10.72.13.15] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 64-20020a630543000000b0047915d582ccsm10673219pgf.20.2022.12.21.20.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 20:04:16 -0800 (PST)
Message-ID: <9729769d-e080-8ade-1453-bf757aa84c88@redhat.com>
Date:   Thu, 22 Dec 2022 12:04:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH 4/4] vdpa_sim_net: vendor satistics
Content-Language: en-US
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20221221061652.15202-1-jasowang@redhat.com>
 <20221221061652.15202-5-jasowang@redhat.com>
 <CAJaqyWc=R5xrEhYJCh=BjovjPN2Ckexaci5kaXdmcV6bww4h8A@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWc=R5xrEhYJCh=BjovjPN2Ckexaci5kaXdmcV6bww4h8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/21 14:33, Eugenio Perez Martin 写道:
> On Wed, Dec 21, 2022 at 7:17 AM Jason Wang <jasowang@redhat.com> wrote:
>> This patch adds support for basic vendor stats that include counters
>> for tx, rx and cvq.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vdpa/vdpa_sim/vdpa_sim.c     |   2 +
>>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 215 ++++++++++++++++++++++++++-
>>   2 files changed, 211 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 02e892f819e7..595d9d5a372f 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -755,8 +755,10 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>>          .set_vq_cb              = vdpasim_set_vq_cb,
>>          .set_vq_ready           = vdpasim_set_vq_ready,
>>          .get_vq_ready           = vdpasim_get_vq_ready,
>> +       .get_vendor_vq_stats    = vdpasim_get_vq_stats,
>>          .set_vq_state           = vdpasim_set_vq_state,
>>          .get_vq_state           = vdpasim_get_vq_state,
>> +       .get_vendor_vq_stats    = vdpasim_get_vq_stats,
> The patch adds .get_vendor_vq_stats twice to vdpasim_batch_config_ops
> assignment.


Will fix.


>
>>          .get_vq_align           = vdpasim_get_vq_align,
>>          .get_vq_group           = vdpasim_get_vq_group,
>>          .get_device_features    = vdpasim_get_device_features,
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>> index 20cd5cdff919..3c05e932d90d 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/etherdevice.h>
>>   #include <linux/vringh.h>
>>   #include <linux/vdpa.h>
>> +#include <net/netlink.h>
>>   #include <uapi/linux/virtio_net.h>
>>   #include <uapi/linux/vdpa.h>
>>
>> @@ -36,6 +37,34 @@
>>   #define VDPASIM_NET_AS_NUM     2
>>   #define VDPASIM_NET_GROUP_NUM  2
>>
>> +struct vdpasim_dataq_stats {
>> +       struct u64_stats_sync syncp;
>> +       u64 pkts;
>> +       u64 bytes;
>> +       u64 drops;
>> +       u64 errors;
>> +       u64 overruns;
>> +};
>> +
>> +struct vdpasim_cq_stats {
>> +       struct u64_stats_sync syncp;
>> +       u64 requests;
>> +       u64 successes;
>> +       u64 errors;
>> +};
>> +
>> +struct vdpasim_net{
>> +       struct vdpasim vdpasim;
>> +       struct vdpasim_dataq_stats tx_stats;
>> +       struct vdpasim_dataq_stats rx_stats;
>> +       struct vdpasim_cq_stats cq_stats;
>> +};
>> +
>> +static struct vdpasim_net *sim_to_net(struct vdpasim *vdpasim)
>> +{
>> +       return container_of(vdpasim, struct vdpasim_net, vdpasim);
>> +}
>> +
>>   static void vdpasim_net_complete(struct vdpasim_virtqueue *vq, size_t len)
>>   {
>>          /* Make sure data is wrote before advancing index */
>> @@ -93,9 +122,11 @@ static virtio_net_ctrl_ack vdpasim_handle_ctrl_mac(struct vdpasim *vdpasim,
>>   static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
>>   {
>>          struct vdpasim_virtqueue *cvq = &vdpasim->vqs[2];
>> +       struct vdpasim_net *net = sim_to_net(vdpasim);
>>          virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
>>          struct virtio_net_ctrl_hdr ctrl;
>>          size_t read, write;
>> +       u64 requests = 0, errors = 0;
>>          int err;
>>
>>          if (!(vdpasim->features & (1ULL << VIRTIO_NET_F_CTRL_VQ)))
>> @@ -113,8 +144,12 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
>>
>>                  read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov, &ctrl,
>>                                               sizeof(ctrl));
>> -               if (read != sizeof(ctrl))
>> +               if (read != sizeof(ctrl)) {
>> +                       ++errors;
>>                          break;
>> +               }
>> +
>> +               ++requests;
>>
>>                  switch (ctrl.class) {
>>                  case VIRTIO_NET_CTRL_MAC:
>> @@ -141,6 +176,12 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
>>                          cvq->cb(cvq->private);
>>                  local_bh_enable();
>>          }
>> +
>> +       u64_stats_update_begin(&net->cq_stats.syncp);
>> +       net->cq_stats.requests += requests;
>> +       net->cq_stats.errors += errors;
>> +       net->cq_stats.successes += requests;
> I'd say we should maintain here requests == errors + requests.
>
> Intuitively, I'd rename local variable requests to successes, and I'd apply:
> net->cq_stats.requests += successes + errors;
> net->cq_stats.errors += errors;
> net->cq_stats.successes += successes;
>
> Or am I missing something?


Exactly, let me fix.

Thanks


>
> Thanks!
>
>> +       u64_stats_update_end(&net->cq_stats.syncp);
>>   }
>>
>>   static void vdpasim_net_work(struct work_struct *work)
>> @@ -148,8 +189,10 @@ static void vdpasim_net_work(struct work_struct *work)
>>          struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
>>          struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
>>          struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
>> +       struct vdpasim_net *net = sim_to_net(vdpasim);
>>          ssize_t read, write;
>> -       int pkts = 0;
>> +       u64 tx_pkts = 0, rx_pkts = 0, tx_bytes = 0, rx_bytes = 0;
>> +       u64 rx_drops = 0, rx_overruns = 0, rx_errors = 0, tx_errors = 0;
>>          int err;
>>
>>          spin_lock(&vdpasim->lock);
>> @@ -168,14 +211,21 @@ static void vdpasim_net_work(struct work_struct *work)
>>          while (true) {
>>                  err = vringh_getdesc_iotlb(&txq->vring, &txq->out_iov, NULL,
>>                                             &txq->head, GFP_ATOMIC);
>> -               if (err <= 0)
>> +               if (err <= 0) {
>> +                       if (err)
>> +                               ++tx_errors;
>>                          break;
>> +               }
>>
>> +               ++tx_pkts;
>>                  read = vringh_iov_pull_iotlb(&txq->vring, &txq->out_iov,
>>                                               vdpasim->buffer,
>>                                               PAGE_SIZE);
>>
>> +               tx_bytes += read;
>> +
>>                  if (!receive_filter(vdpasim, read)) {
>> +                       ++rx_drops;
>>                          vdpasim_net_complete(txq, 0);
>>                          continue;
>>                  }
>> @@ -183,19 +233,25 @@ static void vdpasim_net_work(struct work_struct *work)
>>                  err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->in_iov,
>>                                             &rxq->head, GFP_ATOMIC);
>>                  if (err <= 0) {
>> +                       ++rx_overruns;
>>                          vdpasim_net_complete(txq, 0);
>>                          break;
>>                  }
>>
>>                  write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
>>                                                vdpasim->buffer, read);
>> -               if (write <= 0)
>> +               if (write <= 0) {
>> +                       ++rx_errors;
>>                          break;
>> +               }
>> +
>> +               ++rx_pkts;
>> +               rx_bytes += write;
>>
>>                  vdpasim_net_complete(txq, 0);
>>                  vdpasim_net_complete(rxq, write);
>>
>> -               if (++pkts > 4) {
>> +               if (tx_pkts > 4) {
>>                          schedule_work(&vdpasim->work);
>>                          goto out;
>>                  }
>> @@ -203,6 +259,145 @@ static void vdpasim_net_work(struct work_struct *work)
>>
>>   out:
>>          spin_unlock(&vdpasim->lock);
>> +
>> +       u64_stats_update_begin(&net->tx_stats.syncp);
>> +       net->tx_stats.pkts += tx_pkts;
>> +       net->tx_stats.bytes += tx_bytes;
>> +       net->tx_stats.errors += tx_errors;
>> +       u64_stats_update_end(&net->tx_stats.syncp);
>> +
>> +       u64_stats_update_begin(&net->rx_stats.syncp);
>> +       net->rx_stats.pkts += rx_pkts;
>> +       net->rx_stats.bytes += rx_bytes;
>> +       net->rx_stats.drops += rx_drops;
>> +       net->rx_stats.errors += rx_errors;
>> +       net->rx_stats.overruns += rx_overruns;
>> +       u64_stats_update_end(&net->rx_stats.syncp);
>> +}
>> +
>> +static int vdpasim_net_get_stats(struct vdpasim *vdpasim, u16 idx,
>> +                                struct sk_buff *msg,
>> +                                struct netlink_ext_ack *extack)
>> +{
>> +       struct vdpasim_net *net = sim_to_net(vdpasim);
>> +       u64 rx_pkts, rx_bytes, rx_errors, rx_overruns, rx_drops;
>> +       u64 tx_pkts, tx_bytes, tx_errors, tx_drops;
>> +       u64 cq_requests, cq_successes, cq_errors;
>> +       unsigned int start;
>> +       int err = -EMSGSIZE;
>> +
>> +       switch(idx) {
>> +       case 0:
>> +               do {
>> +                       start = u64_stats_fetch_begin(&net->rx_stats.syncp);
>> +                       rx_pkts = net->rx_stats.pkts;
>> +                       rx_bytes = net->rx_stats.bytes;
>> +                       rx_errors = net->rx_stats.errors;
>> +                       rx_overruns = net->rx_stats.overruns;
>> +                       rx_drops = net->rx_stats.drops;
>> +               } while (u64_stats_fetch_retry(&net->rx_stats.syncp, start));
>> +
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                       "rx packets"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     rx_pkts, VDPA_ATTR_PAD))
>> +                       break;
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                 "rx bytes"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     rx_bytes, VDPA_ATTR_PAD))
>> +                       break;
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                 "rx errors"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     rx_errors, VDPA_ATTR_PAD))
>> +                       break;
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                 "rx overrunss"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     rx_overruns, VDPA_ATTR_PAD))
>> +                       break;
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                 "rx drops"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     rx_drops, VDPA_ATTR_PAD))
>> +                       break;
>> +               err = 0;
>> +               break;
>> +       case 1:
>> +               do {
>> +                       start = u64_stats_fetch_begin(&net->tx_stats.syncp);
>> +                       tx_pkts = net->tx_stats.pkts;
>> +                       tx_bytes = net->tx_stats.bytes;
>> +                       tx_errors = net->tx_stats.errors;
>> +                       tx_drops = net->tx_stats.drops;
>> +               } while (u64_stats_fetch_retry(&net->tx_stats.syncp, start));
>> +
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                 "tx packets"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     tx_pkts, VDPA_ATTR_PAD))
>> +                       break;
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                 "tx bytes"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     tx_bytes, VDPA_ATTR_PAD))
>> +                       break;
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                 "tx errors"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     tx_errors, VDPA_ATTR_PAD))
>> +                       break;
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                 "tx drops"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     tx_drops, VDPA_ATTR_PAD))
>> +                       break;
>> +               err = 0;
>> +               break;
>> +       case 2:
>> +               do {
>> +                       start = u64_stats_fetch_begin(&net->cq_stats.syncp);
>> +                       cq_requests = net->cq_stats.requests;
>> +                       cq_successes = net->cq_stats.successes;
>> +                       cq_errors = net->cq_stats.errors;
>> +               } while (u64_stats_fetch_retry(&net->cq_stats.syncp, start));
>> +
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                 "cvq requests"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     cq_requests, VDPA_ATTR_PAD))
>> +                       break;
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                 "cvq successes"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     cq_successes, VDPA_ATTR_PAD))
>> +                       break;
>> +               if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>> +                                 "cvq errors"))
>> +                       break;
>> +               if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>> +                                     cq_errors, VDPA_ATTR_PAD))
>> +                       break;
>> +               err = 0;
>> +               break;
>> +       default:
>> +               err = -EINVAL;
>> +               break;
>> +       }
>> +
>> +       return err;
>>   }
>>
>>   static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
>> @@ -239,6 +434,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>                                 const struct vdpa_dev_set_config *config)
>>   {
>>          struct vdpasim_dev_attr dev_attr = {};
>> +       struct vdpasim_net *net;
>>          struct vdpasim *simdev;
>>          int ret;
>>
>> @@ -249,10 +445,11 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>          dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
>>          dev_attr.ngroups = VDPASIM_NET_GROUP_NUM;
>>          dev_attr.nas = VDPASIM_NET_AS_NUM;
>> -       dev_attr.alloc_size = sizeof(struct vdpasim);
>> +       dev_attr.alloc_size = sizeof(struct vdpasim_net);
>>          dev_attr.config_size = sizeof(struct virtio_net_config);
>>          dev_attr.get_config = vdpasim_net_get_config;
>>          dev_attr.work_fn = vdpasim_net_work;
>> +       dev_attr.get_stats = vdpasim_net_get_stats;
>>          dev_attr.buffer_size = PAGE_SIZE;
>>
>>          simdev = vdpasim_create(&dev_attr, config);
>> @@ -265,6 +462,12 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>          if (ret)
>>                  goto reg_err;
>>
>> +       net = sim_to_net(simdev);
>> +
>> +       u64_stats_init(&net->tx_stats.syncp);
>> +       u64_stats_init(&net->rx_stats.syncp);
>> +       u64_stats_init(&net->cq_stats.syncp);
>> +
>>          return 0;
>>
>>   reg_err:
>> --
>> 2.25.1
>>

