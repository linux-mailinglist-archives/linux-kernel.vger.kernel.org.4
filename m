Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC06290D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiKODep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiKODen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590275FEF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668483224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U7m6ao4IK6/aZ743Uu/e3L1NAClXd0BGmK8TQZZjy5A=;
        b=URuJlBBG5Ku7tnzFd+xWVMOCArFnAd8GxOB9qcIa2nFA72Xx2jW7/kRMQ/DG5mKYi0shvm
        wtsKa/AYqz/XDXS4M8giKZl6qK+/GmPBgLebi5opRGg4tpJXZmF7nO07rDV6od15fFA0v8
        LK73cQN1i3ncp3RA0hieLWz6pbVuAX8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-2Y_H9KAGPoimFaW8u7gnQw-1; Mon, 14 Nov 2022 22:33:42 -0500
X-MC-Unique: 2Y_H9KAGPoimFaW8u7gnQw-1
Received: by mail-oi1-f198.google.com with SMTP id u18-20020a056808115200b0035a0dff88f9so4228309oiu.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7m6ao4IK6/aZ743Uu/e3L1NAClXd0BGmK8TQZZjy5A=;
        b=Y4Isc2A+0t12UEAuJQCGvnvXUk315UxpWuG6rCnmUuexUoHuPC5JVi9sllulIX1lj3
         glqItm1xaCt4CXgy0TmgKXscs3PxxHkbCkPepmPjI9SbnsqKwKSgSG8lFNKtCqxnYX3M
         o2a8fJAOWVj9d6ugVJYaoAflt8jS4ojMsD6jGXa78XR1LzI37diJAsJ7hG1/gDrJVx6p
         EBjmRru6Fpep+AyLZgNOY+LA6f6/9c8zX/xkdpL2tblI2XX9fzFuy6ahs8mcVFBtoWQr
         CR/Woppssf9ZqwaUufxtuYLO0Jj/YFMZ8evXPY4UcYh2r/qDccODxgmK9fR9lKVUIEsW
         YkSA==
X-Gm-Message-State: ANoB5pmRPJkHiteN95LYbPFaOQ6aQX1hUoAs3IC7z8QPsS+kl8eVDBUC
        kvNoesql6tYxbshZ2xy4hgln4+Z81PYL+uaslXqAkFt+mmRHYfObxc5l6iWcRXJ3+LqGQGl0WN/
        fgyUhQ+oovZZm5vqb+nmAt6GfUik4q58wn+So9WAN
X-Received: by 2002:a05:6870:638b:b0:132:7b3:29ac with SMTP id t11-20020a056870638b00b0013207b329acmr102855oap.35.1668483221829;
        Mon, 14 Nov 2022 19:33:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5r7QzYsTy5/acwIsDQm+bUQzdhSXFtHnPYtqFtvuSwLauIORNv8s4arrMyuMKjiPeGZ9un+n4fqU/na3lvlK0=
X-Received: by 2002:a05:6870:638b:b0:132:7b3:29ac with SMTP id
 t11-20020a056870638b00b0013207b329acmr102844oap.35.1668483221475; Mon, 14 Nov
 2022 19:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20221114131759.57883-1-elic@nvidia.com> <20221114131759.57883-9-elic@nvidia.com>
In-Reply-To: <20221114131759.57883-9-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 15 Nov 2022 11:33:30 +0800
Message-ID: <CACGkMEvedzOtzUX0q_XPb_9cURRzStBjWZGscJ6=rKu--QSrww@mail.gmail.com>
Subject: Re: [PATH v2 8/8] vdpa/mlx5: Add RX counters to debugfs
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        eperezma@redhat.com, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 9:18 PM Eli Cohen <elic@nvidia.com> wrote:
>
> For each interface, either VLAN tagged or untagged, add two hardware
> counters: one for unicast and another for multicast. The counters count
> RX packets and bytes and can be read through debugfs:
>
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/packets
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/bytes
>
> This feature is controlled via the config option
> MLX5_VDPA_STEERING_DEBUG. It is off by default as it may have some
> impact on performance.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/Kconfig              |  12 ++++
>  drivers/vdpa/mlx5/net/debug.c     |  86 ++++++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 116 +++++++++++++++++++++++-------
>  drivers/vdpa/mlx5/net/mlx5_vnet.h |  30 ++++++++
>  4 files changed, 217 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 50f45d037611..43b716ec2d18 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -71,6 +71,18 @@ config MLX5_VDPA_NET
>           be executed by the hardware. It also supports a variety of stateless
>           offloads depending on the actual device used and firmware version.
>
> +config MLX5_VDPA_STEERING_DEBUG
> +       bool "expose steering counters on debugfs"
> +       select MLX5_VDPA
> +       help
> +         Expose RX steering counters in debugfs to aid in debugging. For each VLAN
> +         or non VLAN interface, two hardware counters are added to the RX flow
> +         table: one for unicast and one for multicast.
> +         The counters counts the number of packets and bytes and exposes them in
> +         debugfs. Once can read the counters using, e.g.:
> +         cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/packets
> +         cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/bytes
> +
>  config VP_VDPA
>         tristate "Virtio PCI bridge vDPA driver"
>         select VIRTIO_PCI_LIB
> diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.c
> index 95e4801df211..60d6ac68cdc4 100644
> --- a/drivers/vdpa/mlx5/net/debug.c
> +++ b/drivers/vdpa/mlx5/net/debug.c
> @@ -49,6 +49,92 @@ void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev)
>                                                   ndev, &rx_flow_table_fops);
>  }
>
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +static int packets_show(struct seq_file *file, void *priv)
> +{
> +       struct mlx5_vdpa_counter *counter = file->private;
> +       u64 packets;
> +       u64 bytes;
> +       int err;
> +
> +       err = mlx5_fc_query(counter->mdev, counter->counter, &packets, &bytes);
> +       if (err)
> +               return err;
> +
> +       seq_printf(file, "0x%llx\n", packets);
> +       return 0;
> +}
> +
> +static int bytes_show(struct seq_file *file, void *priv)
> +{
> +       struct mlx5_vdpa_counter *counter = file->private;
> +       u64 packets;
> +       u64 bytes;
> +       int err;
> +
> +       err = mlx5_fc_query(counter->mdev, counter->counter, &packets, &bytes);
> +       if (err)
> +               return err;
> +
> +       seq_printf(file, "0x%llx\n", bytes);
> +       return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(packets);
> +DEFINE_SHOW_ATTRIBUTE(bytes);
> +
> +static void add_counter_node(struct mlx5_vdpa_counter *counter,
> +                            struct dentry *parent)
> +{
> +       debugfs_create_file("packets", 0444, parent, counter,
> +                           &packets_fops);
> +       debugfs_create_file("bytes", 0444, parent, counter,
> +                           &bytes_fops);
> +}
> +
> +void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
> +                              struct macvlan_node *node)
> +{
> +       static const char *ut = "untagged";
> +       char vidstr[9];
> +       u16 vid;
> +
> +       node->ucast_counter.mdev = ndev->mvdev.mdev;
> +       node->mcast_counter.mdev = ndev->mvdev.mdev;
> +       if (node->tagged) {
> +               vid = key2vid(node->macvlan);
> +               snprintf(vidstr, sizeof(vidstr), "0x%x", vid);
> +       } else {
> +               strcpy(vidstr, ut);
> +       }
> +
> +       node->dent = debugfs_create_dir(vidstr, ndev->rx_dent);
> +       if (IS_ERR(node->dent)) {
> +               node->dent = NULL;
> +               return;
> +       }
> +
> +       node->ucast_counter.dent = debugfs_create_dir("ucast", node->dent);
> +       if (IS_ERR(node->ucast_counter.dent))
> +               return;
> +
> +       add_counter_node(&node->ucast_counter, node->ucast_counter.dent);
> +
> +       node->mcast_counter.dent = debugfs_create_dir("mcast", node->dent);
> +       if (IS_ERR(node->mcast_counter.dent))
> +               return;
> +
> +       add_counter_node(&node->mcast_counter, node->mcast_counter.dent);
> +}
> +
> +void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
> +                                 struct macvlan_node *node)
> +{
> +       if (node->dent && ndev->debugfs)
> +               debugfs_remove_recursive(node->dent);
> +}
> +#endif
> +
>  void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
>  {
>         struct mlx5_core_dev *mdev;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 4b097e6ddba0..6632651b1e54 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1404,12 +1404,55 @@ static void destroy_tir(struct mlx5_vdpa_net *ndev)
>  #define MAX_STEERING_ENT 0x8000
>  #define MAX_STEERING_GROUPS 2
>
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       #define NUM_DESTS 2
> +#else
> +       #define NUM_DESTS 1
> +#endif
> +
> +static int add_steering_counters(struct mlx5_vdpa_net *ndev,
> +                                struct macvlan_node *node,
> +                                struct mlx5_flow_act *flow_act,
> +                                struct mlx5_flow_destination *dests)
> +{
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       int err;
> +
> +       node->ucast_counter.counter = mlx5_fc_create(ndev->mvdev.mdev, false);
> +       if (IS_ERR(node->ucast_counter.counter))
> +               return PTR_ERR(node->ucast_counter.counter);
> +
> +       node->mcast_counter.counter = mlx5_fc_create(ndev->mvdev.mdev, false);
> +       if (IS_ERR(node->mcast_counter.counter)) {
> +               err = PTR_ERR(node->mcast_counter.counter);
> +               goto err_mcast_counter;
> +       }
> +
> +       dests[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
> +       flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
> +       return 0;
> +
> +err_mcast_counter:
> +       mlx5_fc_destroy(ndev->mvdev.mdev, node->ucast_counter.counter);
> +       return err;
> +#else
> +       return 0;
> +#endif
> +}
> +
> +static void remove_steering_counters(struct mlx5_vdpa_net *ndev,
> +                                    struct macvlan_node *node)
> +{
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       mlx5_fc_destroy(ndev->mvdev.mdev, node->mcast_counter.counter);
> +       mlx5_fc_destroy(ndev->mvdev.mdev, node->ucast_counter.counter);
> +#endif
> +}
> +
>  static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
> -                                       u16 vid, bool tagged,
> -                                       struct mlx5_flow_handle **ucast,
> -                                       struct mlx5_flow_handle **mcast)
> +                                       struct macvlan_node *node)
>  {
> -       struct mlx5_flow_destination dest = {};
> +       struct mlx5_flow_destination dests[NUM_DESTS] = {};
>         struct mlx5_flow_act flow_act = {};
>         struct mlx5_flow_handle *rule;
>         struct mlx5_flow_spec *spec;
> @@ -1418,11 +1461,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>         u8 *dmac_c;
>         u8 *dmac_v;
>         int err;
> +       u16 vid;
>
>         spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
>         if (!spec)
>                 return -ENOMEM;
>
> +       vid = key2vid(node->macvlan);
>         spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
>         headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
>         headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
> @@ -1434,44 +1479,58 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>                 MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
>                 MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
>         }
> -       if (tagged) {
> +       if (node->tagged) {
>                 MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
>                 MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
>         }
>         flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> -       dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> -       dest.tir_num = ndev->res.tirn;
> -       rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> -       if (IS_ERR(rule))
> -               return PTR_ERR(rule);
> +       dests[0].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> +       dests[0].tir_num = ndev->res.tirn;
> +       err = add_steering_counters(ndev, node, &flow_act, dests);
> +       if (err)
> +               goto out_free;
> +
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       dests[1].counter_id = mlx5_fc_id(node->ucast_counter.counter);
> +#endif
> +       node->ucast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
> +       if (IS_ERR(rule)) {
> +               err = PTR_ERR(rule);
> +               goto err_ucast;
> +       }
>
> -       *ucast = rule;
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       dests[1].counter_id = mlx5_fc_id(node->mcast_counter.counter);
> +#endif
>
>         memset(dmac_c, 0, ETH_ALEN);
>         memset(dmac_v, 0, ETH_ALEN);
>         dmac_c[0] = 1;
>         dmac_v[0] = 1;
> -       rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> -       kvfree(spec);
> +       node->mcast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
>         if (IS_ERR(rule)) {
>                 err = PTR_ERR(rule);
>                 goto err_mcast;
>         }
> -
> -       *mcast = rule;
> +       kvfree(spec);
> +       mlx5_vdpa_add_rx_counters(ndev, node);
>         return 0;
>
>  err_mcast:
> -       mlx5_del_flow_rules(*ucast);
> +       mlx5_del_flow_rules(node->ucast_rule);
> +err_ucast:
> +       remove_steering_counters(ndev, node);
> +out_free:
> +       kvfree(spec);
>         return err;
>  }
>
>  static void mlx5_vdpa_del_mac_vlan_rules(struct mlx5_vdpa_net *ndev,
> -                                        struct mlx5_flow_handle *ucast,
> -                                        struct mlx5_flow_handle *mcast)
> +                                        struct macvlan_node *node)
>  {
> -       mlx5_del_flow_rules(ucast);
> -       mlx5_del_flow_rules(mcast);
> +       mlx5_vdpa_remove_rx_counters(ndev, node);
> +       mlx5_del_flow_rules(node->ucast_rule);
> +       mlx5_del_flow_rules(node->mcast_rule);
>  }
>
>  static u64 search_val(u8 *mac, u16 vlan, bool tagged)
> @@ -1505,14 +1564,14 @@ static struct macvlan_node *mac_vlan_lookup(struct mlx5_vdpa_net *ndev, u64 valu
>         return NULL;
>  }
>
> -static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagged) // vlan -> vid
> +static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vid, bool tagged)
>  {
>         struct macvlan_node *ptr;
>         u64 val;
>         u32 idx;
>         int err;
>
> -       val = search_val(mac, vlan, tagged);
> +       val = search_val(mac, vid, tagged);
>         if (mac_vlan_lookup(ndev, val))
>                 return -EEXIST;
>
> @@ -1520,12 +1579,13 @@ static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagg
>         if (!ptr)
>                 return -ENOMEM;
>
> -       err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev->config.mac, vlan, tagged,
> -                                          &ptr->ucast_rule, &ptr->mcast_rule);
> +       ptr->tagged = tagged;
> +       ptr->macvlan = val;
> +       ptr->ndev = ndev;
> +       err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev->config.mac, ptr);
>         if (err)
>                 goto err_add;
>
> -       ptr->macvlan = val;
>         idx = hash_64(val, 8);
>         hlist_add_head(&ptr->hlist, &ndev->macvlan_hash[idx]);
>         return 0;
> @@ -1544,7 +1604,8 @@ static void mac_vlan_del(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tag
>                 return;
>
>         hlist_del(&ptr->hlist);
> -       mlx5_vdpa_del_mac_vlan_rules(ndev, ptr->ucast_rule, ptr->mcast_rule);
> +       mlx5_vdpa_del_mac_vlan_rules(ndev, ptr);
> +       remove_steering_counters(ndev, ptr);
>         kfree(ptr);
>  }
>
> @@ -1557,7 +1618,8 @@ static void clear_mac_vlan_table(struct mlx5_vdpa_net *ndev)
>         for (i = 0; i < MLX5V_MACVLAN_SIZE; i++) {
>                 hlist_for_each_entry_safe(pos, n, &ndev->macvlan_hash[i], hlist) {
>                         hlist_del(&pos->hlist);
> -                       mlx5_vdpa_del_mac_vlan_rules(ndev, pos->ucast_rule, pos->mcast_rule);
> +                       mlx5_vdpa_del_mac_vlan_rules(ndev, pos);
> +                       remove_steering_counters(ndev, pos);
>                         kfree(pos);
>                 }
>         }
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> index f2cef3925e5b..c90a89e1de4d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -21,6 +21,11 @@ struct mlx5_vdpa_net_resources {
>
>  #define MLX5V_MACVLAN_SIZE 256
>
> +static inline u16 key2vid(u64 key)
> +{
> +       return (u16)(key >> 48) & 0xfff;
> +}
> +
>  struct mlx5_vdpa_net {
>         struct mlx5_vdpa_dev mvdev;
>         struct mlx5_vdpa_net_resources res;
> @@ -47,11 +52,24 @@ struct mlx5_vdpa_net {
>         struct dentry *debugfs;
>  };
>
> +struct mlx5_vdpa_counter {
> +       struct mlx5_fc *counter;
> +       struct dentry *dent;
> +       struct mlx5_core_dev *mdev;
> +};
> +
>  struct macvlan_node {
>         struct hlist_node hlist;
>         struct mlx5_flow_handle *ucast_rule;
>         struct mlx5_flow_handle *mcast_rule;
>         u64 macvlan;
> +       struct mlx5_vdpa_net *ndev;
> +       bool tagged;
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       struct dentry *dent;
> +       struct mlx5_vdpa_counter ucast_counter;
> +       struct mlx5_vdpa_counter mcast_counter;
> +#endif
>  };
>
>  void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
> @@ -60,5 +78,17 @@ void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
>  void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
>  void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
>  void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev);
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
> +                              struct macvlan_node *node);
> +void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
> +                                 struct macvlan_node *node);
> +#else
> +static inline void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
> +                                            struct macvlan_node *node) {}
> +static inline void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
> +                                               struct macvlan_node *node) {}
> +#endif
> +
>
>  #endif /* __MLX5_VNET_H__ */
> --
> 2.38.1
>

