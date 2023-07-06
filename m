Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DCA74A0EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjGFP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjGFP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:26:42 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF251BFC;
        Thu,  6 Jul 2023 08:26:38 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5577900c06bso670969a12.2;
        Thu, 06 Jul 2023 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688657198; x=1691249198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3GaQL1YsgC4+exc/fyFOlTGrEqs6W+W7mT+Az9NMp4=;
        b=Txb0sitJkY/hth8WxQGOu70M4l/eHFIT07+ac7CKRzRDtjjf7LXodMNPrYgP9e2Frs
         UDsv/rGUxTSqymIeyw5Qy/S1aWnjSmbXuP1pIPuZ8t5yJztV6HrpfGxWTabdAoOgAict
         z1SvHBoRM+d9NktAaZNBehsq++F5doCeDnWtPzX568HhWggbn4hPokmhSj6oiQnr846T
         Co/80vQAY8HYlgAgXRzkjJLba13fsX92V4kIEIclnzj9qhOojv8VEBkofFZXewq1UKdS
         qzbrFRuRHW8HLPEwxI+g/1FwTK6Q2AxPpdFHetOjjtEieCGJF0zbCwCxh23DRTVChQFA
         yuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688657198; x=1691249198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3GaQL1YsgC4+exc/fyFOlTGrEqs6W+W7mT+Az9NMp4=;
        b=Vo/egdJBX0AcTzgaRbpB9vI79nCMoM5EyvVPdNBIjB8h9UvBLq02RQ7LXJ/vyZKugj
         8bI0wDmRbPlL6aBA+7CfUDs7EprkEzu6uFhHnhFwHr6dT4nes2W8wp4MtvDjLFvE0qw0
         inSGdsrFAx98HmACu8lh1R7yhm99MO6ZdpCUovjXvt7kja6pd7L/rI/AbSTzYvCvJld+
         xdU1T0eT7dpp12Lt5qdhNRpwa/wpihPvKI3KeAhePOavYwRWMKkUQP4fDecb1VAkFk4R
         ik/mXNl6BoSL/VVsDxpX5saDupo9EBORKZJ93lkvulKXWOjinRttTdNqYe7DXb/0JTJx
         edKg==
X-Gm-Message-State: ABy/qLaGI6GTJMfQrvmXEFmLrBtNvVouqLHln1tkWwrnE4tz+UrHfWV5
        clqv6DOhgD9+5PLU8oi+tHlG+iV5fXkNUdYwRX4=
X-Google-Smtp-Source: APBJJlGj0VZ/7XmCQecGUtaVbkl96xkZwp8rGPXoQJk4BL/vbSqCiLkf7C2z2Zq/pEGKLeY3I24+co3x2fUCZOlKDTg=
X-Received: by 2002:a05:6a20:610:b0:12d:c4fb:4884 with SMTP id
 16-20020a056a20061000b0012dc4fb4884mr1924490pzl.20.1688657197272; Thu, 06 Jul
 2023 08:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com> <20230705155551.1317583-7-aleksander.lobakin@intel.com>
In-Reply-To: <20230705155551.1317583-7-aleksander.lobakin@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 6 Jul 2023 08:26:00 -0700
Message-ID: <CAKgT0Ud4h32UFwiUhcpLxSrPRMhbKYSDncL2YiursWgS7Qg7Ug@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v4 6/9] iavf: switch to
 Page Pool
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-kernel@vger.kernel.org,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        David Christensen <drc@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 8:58=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Now that the IAVF driver simply uses dev_alloc_page() + free_page() with
> no custom recycling logics, it can easily be switched to using Page
> Pool / libie API instead.
> This allows to removing the whole dancing around headroom, HW buffer
> size, and page order. All DMA-for-device is now done in the PP core,
> for-CPU -- in the libie helper.
> Use skb_mark_for_recycle() to bring back the recycling and restore the
> performance. Speaking of performance: on par with the baseline and
> faster with the PP optimization series applied. But the memory usage for
> 1500b MTU is now almost 2x lower (x86_64) thanks to allocating a page
> every second descriptor.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

One thing I am noticing is that there seems to be a bunch of cleanup
changes in here as well. Things like moving around values within
structures which I am assuming are to fill holes. You may want to look
at breaking some of those out as it makes it a bit harder to review
this since they seem like unrelated changes.

> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  33 +--
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 247 +++++-------------
>  drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  91 +------
>  drivers/net/ethernet/intel/iavf/iavf_type.h   |   2 -
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  19 +-
>  5 files changed, 82 insertions(+), 310 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/et=
hernet/intel/iavf/iavf_main.c
> index db1ed13f11bb..39c6d83e80a1 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 2013 - 2018 Intel Corporation. */
>
> +#include <linux/net/intel/libie/rx.h>
> +
>  #include "iavf.h"
>  #include "iavf_prototype.h"
>  #include "iavf_client.h"
> @@ -698,32 +700,10 @@ static void iavf_configure_tx(struct iavf_adapter *=
adapter)
>   **/
>  static void iavf_configure_rx(struct iavf_adapter *adapter)
>  {
> -       unsigned int rx_buf_len =3D IAVF_RXBUFFER_2048;
>         struct iavf_hw *hw =3D &adapter->hw;
> -       int i;
> -
> -       if (PAGE_SIZE < 8192) {
> -               struct net_device *netdev =3D adapter->netdev;
>
> -               /* For jumbo frames on systems with 4K pages we have to u=
se
> -                * an order 1 page, so we might as well increase the size
> -                * of our Rx buffer to make better use of the available s=
pace
> -                */
> -               rx_buf_len =3D IAVF_RXBUFFER_3072;
> -
> -               /* We use a 1536 buffer size for configurations with
> -                * standard Ethernet mtu.  On x86 this gives us enough ro=
om
> -                * for shared info and 192 bytes of padding.
> -                */
> -               if (!IAVF_2K_TOO_SMALL_WITH_PADDING &&
> -                   (netdev->mtu <=3D ETH_DATA_LEN))
> -                       rx_buf_len =3D IAVF_RXBUFFER_1536 - NET_IP_ALIGN;
> -       }
> -
> -       for (i =3D 0; i < adapter->num_active_queues; i++) {
> +       for (u32 i =3D 0; i < adapter->num_active_queues; i++)
>                 adapter->rx_rings[i].tail =3D hw->hw_addr + IAVF_QRX_TAIL=
1(i);
> -               adapter->rx_rings[i].rx_buf_len =3D rx_buf_len;
> -       }
>  }
>
>  /**
> @@ -1590,7 +1570,6 @@ static int iavf_alloc_queues(struct iavf_adapter *a=
dapter)
>                 rx_ring =3D &adapter->rx_rings[i];
>                 rx_ring->queue_index =3D i;
>                 rx_ring->netdev =3D adapter->netdev;
> -               rx_ring->dev =3D &adapter->pdev->dev;
>                 rx_ring->count =3D adapter->rx_desc_count;
>                 rx_ring->itr_setting =3D IAVF_ITR_RX_DEF;
>         }
> @@ -2562,11 +2541,7 @@ static void iavf_init_config_adapter(struct iavf_a=
dapter *adapter)
>
>         netdev->netdev_ops =3D &iavf_netdev_ops;
>         iavf_set_ethtool_ops(netdev);
> -       netdev->watchdog_timeo =3D 5 * HZ;
> -

These removals should be pulled out into a seperate patch where we can
call out that they are not needed due to redundancies w/ other code on
the core network code.

> -       /* MTU range: 68 - 9710 */
> -       netdev->min_mtu =3D ETH_MIN_MTU;
> -       netdev->max_mtu =3D IAVF_MAX_RXBUFFER - IAVF_PACKET_HDR_PAD;
> +       netdev->max_mtu =3D LIBIE_MAX_MTU;

Same here for min_mtu.

>
>         if (!is_valid_ether_addr(adapter->hw.mac.addr)) {
>                 dev_info(&pdev->dev, "Invalid MAC address %pM, using rand=
om\n",
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/et=
hernet/intel/iavf/iavf_txrx.c
> index 789b10815d7f..d1491b481eac 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -689,9 +689,6 @@ int iavf_setup_tx_descriptors(struct iavf_ring *tx_ri=
ng)
>   **/
>  static void iavf_clean_rx_ring(struct iavf_ring *rx_ring)
>  {
> -       unsigned long bi_size;
> -       u16 i;
> -
>         /* ring already cleared, nothing to do */
>         if (!rx_ring->rx_bi)
>                 return;
> @@ -701,40 +698,16 @@ static void iavf_clean_rx_ring(struct iavf_ring *rx=
_ring)
>                 rx_ring->skb =3D NULL;
>         }
>
> -       /* Free all the Rx ring sk_buffs */
> -       for (i =3D 0; i < rx_ring->count; i++) {
> -               struct iavf_rx_buffer *rx_bi =3D &rx_ring->rx_bi[i];
> +       /* Free all the Rx ring buffers */
> +       for (u32 i =3D rx_ring->next_to_clean; i !=3D rx_ring->next_to_us=
e; ) {
> +               const struct libie_rx_buffer *rx_bi =3D &rx_ring->rx_bi[i=
];
>
> -               if (!rx_bi->page)
> -                       continue;
> +               page_pool_put_full_page(rx_ring->pp, rx_bi->page, false);
>
> -               /* Invalidate cache lines that may have been written to b=
y
> -                * device so that we avoid corrupting memory.
> -                */
> -               dma_sync_single_range_for_cpu(rx_ring->dev,
> -                                             rx_bi->dma,
> -                                             rx_bi->page_offset,
> -                                             rx_ring->rx_buf_len,
> -                                             DMA_FROM_DEVICE);
> -
> -               /* free resources associated with mapping */
> -               dma_unmap_page_attrs(rx_ring->dev, rx_bi->dma,
> -                                    iavf_rx_pg_size(rx_ring),
> -                                    DMA_FROM_DEVICE,
> -                                    IAVF_RX_DMA_ATTR);
> -
> -               __free_pages(rx_bi->page, iavf_rx_pg_order(rx_ring));
> -
> -               rx_bi->page =3D NULL;
> -               rx_bi->page_offset =3D 0;
> +               if (unlikely(++i =3D=3D rx_ring->count))
> +                       i =3D 0;
>         }
>
> -       bi_size =3D sizeof(struct iavf_rx_buffer) * rx_ring->count;
> -       memset(rx_ring->rx_bi, 0, bi_size);
> -
> -       /* Zero out the descriptor ring */
> -       memset(rx_ring->desc, 0, rx_ring->size);
> -

I have some misgivings about not clearing these. We may want to double
check to verify the code paths are resilient enough that it won't
cause any issues w/ repeated up/down testing on the interface. The
general idea is to keep things consistent w/ the state after
setup_rx_descriptors. If we don't need this when we don't need to be
calling the zalloc or calloc version of things in
setup_rx_descriptors.


>         rx_ring->next_to_clean =3D 0;
>         rx_ring->next_to_use =3D 0;
>  }
> @@ -752,10 +725,13 @@ void iavf_free_rx_resources(struct iavf_ring *rx_ri=
ng)
>         rx_ring->rx_bi =3D NULL;
>
>         if (rx_ring->desc) {
> -               dma_free_coherent(rx_ring->dev, rx_ring->size,
> +               dma_free_coherent(rx_ring->pp->p.dev, rx_ring->size,
>                                   rx_ring->desc, rx_ring->dma);
>                 rx_ring->desc =3D NULL;
>         }
> +
> +       page_pool_destroy(rx_ring->pp);
> +       rx_ring->pp =3D NULL;
>  }
>
>  /**
> @@ -766,13 +742,19 @@ void iavf_free_rx_resources(struct iavf_ring *rx_ri=
ng)
>   **/
>  int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
>  {
> -       struct device *dev =3D rx_ring->dev;
> -       int bi_size;
> +       struct page_pool *pool;
> +
> +       pool =3D libie_rx_page_pool_create(&rx_ring->q_vector->napi,
> +                                        rx_ring->count);
> +       if (IS_ERR(pool))
> +               return PTR_ERR(pool);
> +
> +       rx_ring->pp =3D pool;
>
>         /* warn if we are about to overwrite the pointer */
>         WARN_ON(rx_ring->rx_bi);
> -       bi_size =3D sizeof(struct iavf_rx_buffer) * rx_ring->count;
> -       rx_ring->rx_bi =3D kzalloc(bi_size, GFP_KERNEL);
> +       rx_ring->rx_bi =3D kcalloc(rx_ring->count, sizeof(*rx_ring->rx_bi=
),
> +                                GFP_KERNEL);
>         if (!rx_ring->rx_bi)
>                 goto err;
>
> @@ -781,22 +763,27 @@ int iavf_setup_rx_descriptors(struct iavf_ring *rx_=
ring)
>         /* Round up to nearest 4K */
>         rx_ring->size =3D rx_ring->count * sizeof(union iavf_32byte_rx_de=
sc);
>         rx_ring->size =3D ALIGN(rx_ring->size, 4096);
> -       rx_ring->desc =3D dma_alloc_coherent(dev, rx_ring->size,
> +       rx_ring->desc =3D dma_alloc_coherent(pool->p.dev, rx_ring->size,
>                                            &rx_ring->dma, GFP_KERNEL);
>
>         if (!rx_ring->desc) {
> -               dev_info(dev, "Unable to allocate memory for the Rx descr=
iptor ring, size=3D%d\n",
> +               dev_info(pool->p.dev, "Unable to allocate memory for the =
Rx descriptor ring, size=3D%d\n",
>                          rx_ring->size);
> -               goto err;
> +               goto err_free_buf;
>         }
>
>         rx_ring->next_to_clean =3D 0;
>         rx_ring->next_to_use =3D 0;
>
>         return 0;
> -err:
> +
> +err_free_buf:
>         kfree(rx_ring->rx_bi);
>         rx_ring->rx_bi =3D NULL;
> +
> +err:
> +       page_pool_destroy(rx_ring->pp);
> +
>         return -ENOMEM;
>  }
>
> @@ -818,49 +805,6 @@ static inline void iavf_release_rx_desc(struct iavf_=
ring *rx_ring, u32 val)
>         writel(val, rx_ring->tail);
>  }
>
> -/**
> - * iavf_alloc_mapped_page - recycle or make a new page
> - * @rx_ring: ring to use
> - * @bi: rx_buffer struct to modify
> - *
> - * Returns true if the page was successfully allocated or
> - * reused.
> - **/
> -static bool iavf_alloc_mapped_page(struct iavf_ring *rx_ring,
> -                                  struct iavf_rx_buffer *bi)
> -{
> -       struct page *page =3D bi->page;
> -       dma_addr_t dma;
> -
> -       /* alloc new page for storage */
> -       page =3D dev_alloc_pages(iavf_rx_pg_order(rx_ring));
> -       if (unlikely(!page)) {
> -               rx_ring->rx_stats.alloc_page_failed++;
> -               return false;
> -       }
> -
> -       /* map page for use */
> -       dma =3D dma_map_page_attrs(rx_ring->dev, page, 0,
> -                                iavf_rx_pg_size(rx_ring),
> -                                DMA_FROM_DEVICE,
> -                                IAVF_RX_DMA_ATTR);
> -
> -       /* if mapping failed free memory back to system since
> -        * there isn't much point in holding memory we can't use
> -        */
> -       if (dma_mapping_error(rx_ring->dev, dma)) {
> -               __free_pages(page, iavf_rx_pg_order(rx_ring));
> -               rx_ring->rx_stats.alloc_page_failed++;
> -               return false;
> -       }
> -
> -       bi->dma =3D dma;
> -       bi->page =3D page;
> -       bi->page_offset =3D IAVF_SKB_PAD;
> -
> -       return true;
> -}
> -
>  /**
>   * iavf_receive_skb - Send a completed packet up the stack
>   * @rx_ring:  rx ring in play
> @@ -893,36 +837,29 @@ bool iavf_alloc_rx_buffers(struct iavf_ring *rx_rin=
g, u16 cleaned_count)
>  {
>         u16 ntu =3D rx_ring->next_to_use;
>         union iavf_rx_desc *rx_desc;
> -       struct iavf_rx_buffer *bi;
>
>         /* do nothing if no valid netdev defined */
>         if (!rx_ring->netdev || !cleaned_count)
>                 return false;
>
>         rx_desc =3D IAVF_RX_DESC(rx_ring, ntu);
> -       bi =3D &rx_ring->rx_bi[ntu];
>
>         do {
> -               if (!iavf_alloc_mapped_page(rx_ring, bi))
> -                       goto no_buffers;
> +               dma_addr_t addr;
>
> -               /* sync the buffer for use by the device */
> -               dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
> -                                                bi->page_offset,
> -                                                rx_ring->rx_buf_len,
> -                                                DMA_FROM_DEVICE);
> +               addr =3D libie_rx_alloc(rx_ring->pp, &rx_ring->rx_bi[ntu]=
);
> +               if (unlikely(addr =3D=3D DMA_MAPPING_ERROR))
> +                       goto no_buffers;
>
>                 /* Refresh the desc even if buffer_addrs didn't change
>                  * because each write-back erases this info.
>                  */
> -               rx_desc->read.pkt_addr =3D cpu_to_le64(bi->dma + bi->page=
_offset);
> +               rx_desc->read.pkt_addr =3D cpu_to_le64(addr);
>
>                 rx_desc++;
> -               bi++;
>                 ntu++;
>                 if (unlikely(ntu =3D=3D rx_ring->count)) {
>                         rx_desc =3D IAVF_RX_DESC(rx_ring, 0);
> -                       bi =3D rx_ring->rx_bi;
>                         ntu =3D 0;
>                 }
>



> @@ -941,6 +878,8 @@ bool iavf_alloc_rx_buffers(struct iavf_ring *rx_ring,=
 u16 cleaned_count)
>         if (rx_ring->next_to_use !=3D ntu)
>                 iavf_release_rx_desc(rx_ring, ntu);
>
> +       rx_ring->rx_stats.alloc_page_failed++;
> +
>         /* make sure to come back via polling to try again after
>          * allocation failure
>          */
> @@ -1091,9 +1030,8 @@ static bool iavf_cleanup_headers(struct iavf_ring *=
rx_ring, struct sk_buff *skb)
>
>  /**
>   * iavf_add_rx_frag - Add contents of Rx buffer to sk_buff
> - * @rx_ring: rx descriptor ring to transact packets on
> - * @rx_buffer: buffer containing page to add
>   * @skb: sk_buff to place the data into
> + * @rx_buffer: buffer containing page to add
>   * @size: packet length from rx_desc
>   *
>   * This function will add the data contained in rx_buffer->page to the s=
kb.
> @@ -1101,111 +1039,52 @@ static bool iavf_cleanup_headers(struct iavf_rin=
g *rx_ring, struct sk_buff *skb)
>   *
>   * The function will then update the page offset.
>   **/
> -static void iavf_add_rx_frag(struct iavf_ring *rx_ring,
> -                            struct iavf_rx_buffer *rx_buffer,
> -                            struct sk_buff *skb,
> +static void iavf_add_rx_frag(struct sk_buff *skb,
> +                            const struct libie_rx_buffer *rx_buffer,
>                              unsigned int size)
>  {
> -#if (PAGE_SIZE < 8192)
> -       unsigned int truesize =3D iavf_rx_pg_size(rx_ring) / 2;
> -#else
> -       unsigned int truesize =3D SKB_DATA_ALIGN(size + IAVF_SKB_PAD);
> -#endif
> -
> -       if (!size)
> -               return;
> +       u32 hr =3D rx_buffer->page->pp->p.offset;
>
>         skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
> -                       rx_buffer->page_offset, size, truesize);
> -}
> -
> -/**
> - * iavf_get_rx_buffer - Fetch Rx buffer and synchronize data for use
> - * @rx_ring: rx descriptor ring to transact packets on
> - * @size: size of buffer to add to skb
> - *
> - * This function will pull an Rx buffer from the ring and synchronize it
> - * for use by the CPU.
> - */
> -static struct iavf_rx_buffer *iavf_get_rx_buffer(struct iavf_ring *rx_ri=
ng,
> -                                                const unsigned int size)
> -{
> -       struct iavf_rx_buffer *rx_buffer;
> -
> -       rx_buffer =3D &rx_ring->rx_bi[rx_ring->next_to_clean];
> -       prefetchw(rx_buffer->page);
> -       if (!size)
> -               return rx_buffer;
> -
> -       /* we are reusing so sync this buffer for CPU use */
> -       dma_sync_single_range_for_cpu(rx_ring->dev,
> -                                     rx_buffer->dma,
> -                                     rx_buffer->page_offset,
> -                                     size,
> -                                     DMA_FROM_DEVICE);
> -
> -       return rx_buffer;
> +                       rx_buffer->offset + hr, size, rx_buffer->truesize=
);
>  }
>
>  /**
>   * iavf_build_skb - Build skb around an existing buffer
> - * @rx_ring: Rx descriptor ring to transact packets on
>   * @rx_buffer: Rx buffer to pull data from
>   * @size: size of buffer to add to skb
>   *
>   * This function builds an skb around an existing Rx buffer, taking care
>   * to set up the skb correctly and avoid any memcpy overhead.
>   */
> -static struct sk_buff *iavf_build_skb(struct iavf_ring *rx_ring,
> -                                     struct iavf_rx_buffer *rx_buffer,
> +static struct sk_buff *iavf_build_skb(const struct libie_rx_buffer *rx_b=
uffer,
>                                       unsigned int size)
>  {
> -       void *va;
> -#if (PAGE_SIZE < 8192)
> -       unsigned int truesize =3D iavf_rx_pg_size(rx_ring) / 2;
> -#else
> -       unsigned int truesize =3D SKB_DATA_ALIGN(sizeof(struct skb_shared=
_info)) +
> -                               SKB_DATA_ALIGN(IAVF_SKB_PAD + size);
> -#endif
> +       struct page *page =3D rx_buffer->page;
> +       u32 hr =3D page->pp->p.offset;
>         struct sk_buff *skb;
> +       void *va;
>
> -       if (!rx_buffer || !size)
> -               return NULL;
>         /* prefetch first cache line of first page */
> -       va =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
> -       net_prefetch(va);
> +       va =3D page_address(page) + rx_buffer->offset;
> +       net_prefetch(va + hr);
>
>         /* build an skb around the page buffer */
> -       skb =3D napi_build_skb(va - IAVF_SKB_PAD, truesize);
> -       if (unlikely(!skb))
> +       skb =3D napi_build_skb(va, rx_buffer->truesize);
> +       if (unlikely(!skb)) {
> +               page_pool_put_page(page->pp, page, size, true);
>                 return NULL;
> +       }
> +
> +       skb_mark_for_recycle(skb);
>
>         /* update pointers within the skb to store the data */
> -       skb_reserve(skb, IAVF_SKB_PAD);
> +       skb_reserve(skb, hr);
>         __skb_put(skb, size);
>
>         return skb;
>  }
>
> -/**
> - * iavf_put_rx_buffer - Unmap used buffer
> - * @rx_ring: rx descriptor ring to transact packets on
> - * @rx_buffer: rx buffer to pull data from
> - *
> - * This function will unmap the buffer after it's written by HW.
> - */
> -static void iavf_put_rx_buffer(struct iavf_ring *rx_ring,
> -                              struct iavf_rx_buffer *rx_buffer)
> -{
> -       if (!rx_buffer)
> -               return;
> -
> -       /* we are not reusing the buffer so unmap it */
> -       dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
> -                            iavf_rx_pg_size(rx_ring),
> -                            DMA_FROM_DEVICE, IAVF_RX_DMA_ATTR);
> -}
> -
>  /**
>   * iavf_is_non_eop - process handling of non-EOP buffers
>   * @rx_ring: Rx ring being processed
> @@ -1259,7 +1138,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_r=
ing, int budget)
>         bool failure =3D false;
>
>         while (likely(total_rx_packets < (unsigned int)budget)) {
> -               struct iavf_rx_buffer *rx_buffer;
> +               struct libie_rx_buffer *rx_buffer;
>                 union iavf_rx_desc *rx_desc;
>                 unsigned int size;
>                 u16 vlan_tag =3D 0;
> @@ -1295,26 +1174,24 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx=
_ring, int budget)
>                        IAVF_RXD_QW1_LENGTH_PBUF_SHIFT;
>
>                 iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
> -               rx_buffer =3D iavf_get_rx_buffer(rx_ring, size);
> +
> +               rx_buffer =3D &rx_ring->rx_bi[rx_ring->next_to_clean];
> +               if (!libie_rx_sync_for_cpu(rx_buffer, size))
> +                       goto skip_data;
>
>                 /* retrieve a buffer from the ring */
>                 if (skb)
> -                       iavf_add_rx_frag(rx_ring, rx_buffer, skb, size);
> +                       iavf_add_rx_frag(skb, rx_buffer, size);
>                 else
> -                       skb =3D iavf_build_skb(rx_ring, rx_buffer, size);
> -
> -               iavf_put_rx_buffer(rx_ring, rx_buffer);
> +                       skb =3D iavf_build_skb(rx_buffer, size);
>
>                 /* exit if we failed to retrieve a buffer */
>                 if (!skb) {
>                         rx_ring->rx_stats.alloc_buff_failed++;
> -                       __free_pages(rx_buffer->page,
> -                                    iavf_rx_pg_order(rx_ring));
> -                       rx_buffer->page =3D NULL;
>                         break;
>                 }
>
> -               rx_buffer->page =3D NULL;
> +skip_data:
>                 cleaned_count++;
>
>                 if (iavf_is_non_eop(rx_ring, rx_desc, skb))
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/et=
hernet/intel/iavf/iavf_txrx.h
> index 2170a77f8c8d..b13d878c74c6 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
> @@ -81,70 +81,8 @@ enum iavf_dyn_idx_t {
>         BIT_ULL(IAVF_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) | \
>         BIT_ULL(IAVF_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP))
>
> -/* Supported Rx Buffer Sizes (a multiple of 128) */
> -#define IAVF_RXBUFFER_1536  1536  /* 128B aligned standard Ethernet fram=
e */
> -#define IAVF_RXBUFFER_2048  2048
> -#define IAVF_RXBUFFER_3072  3072  /* Used for large frames w/ padding */
> -#define IAVF_MAX_RXBUFFER   9728  /* largest size for single descriptor =
*/
> -
> -#define IAVF_PACKET_HDR_PAD (ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2))
>  #define iavf_rx_desc iavf_32byte_rx_desc
>
> -#define IAVF_RX_DMA_ATTR \
> -       (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
> -
> -/* Attempt to maximize the headroom available for incoming frames.  We
> - * use a 2K buffer for receives and need 1536/1534 to store the data for
> - * the frame.  This leaves us with 512 bytes of room.  From that we need
> - * to deduct the space needed for the shared info and the padding needed
> - * to IP align the frame.
> - *
> - * Note: For cache line sizes 256 or larger this value is going to end
> - *      up negative.  In these cases we should fall back to the legacy
> - *      receive path.
> - */
> -#if (PAGE_SIZE < 8192)
> -#define IAVF_2K_TOO_SMALL_WITH_PADDING \
> -((NET_SKB_PAD + IAVF_RXBUFFER_1536) > SKB_WITH_OVERHEAD(IAVF_RXBUFFER_20=
48))
> -
> -static inline int iavf_compute_pad(int rx_buf_len)
> -{
> -       int page_size, pad_size;
> -
> -       page_size =3D ALIGN(rx_buf_len, PAGE_SIZE / 2);
> -       pad_size =3D SKB_WITH_OVERHEAD(page_size) - rx_buf_len;
> -
> -       return pad_size;
> -}
> -
> -static inline int iavf_skb_pad(void)
> -{
> -       int rx_buf_len;
> -
> -       /* If a 2K buffer cannot handle a standard Ethernet frame then
> -        * optimize padding for a 3K buffer instead of a 1.5K buffer.
> -        *
> -        * For a 3K buffer we need to add enough padding to allow for
> -        * tailroom due to NET_IP_ALIGN possibly shifting us out of
> -        * cache-line alignment.
> -        */
> -       if (IAVF_2K_TOO_SMALL_WITH_PADDING)
> -               rx_buf_len =3D IAVF_RXBUFFER_3072 + SKB_DATA_ALIGN(NET_IP=
_ALIGN);
> -       else
> -               rx_buf_len =3D IAVF_RXBUFFER_1536;
> -
> -       /* if needed make room for NET_IP_ALIGN */
> -       rx_buf_len -=3D NET_IP_ALIGN;
> -
> -       return iavf_compute_pad(rx_buf_len);
> -}
> -
> -#define IAVF_SKB_PAD iavf_skb_pad()
> -#else
> -#define IAVF_2K_TOO_SMALL_WITH_PADDING false
> -#define IAVF_SKB_PAD (NET_SKB_PAD + NET_IP_ALIGN)
> -#endif
> -
>  /**
>   * iavf_test_staterr - tests bits in Rx descriptor status and error fiel=
ds
>   * @rx_desc: pointer to receive descriptor (in le64 format)
> @@ -263,12 +201,6 @@ struct iavf_tx_buffer {
>         u32 tx_flags;
>  };
>
> -struct iavf_rx_buffer {
> -       dma_addr_t dma;
> -       struct page *page;
> -       __u32 page_offset;
> -};
> -
>  struct iavf_queue_stats {
>         u64 packets;
>         u64 bytes;
> @@ -311,16 +243,19 @@ enum iavf_ring_state_t {
>  struct iavf_ring {
>         struct iavf_ring *next;         /* pointer to next ring in q_vect=
or */
>         void *desc;                     /* Descriptor ring memory */
> -       struct device *dev;             /* Used for DMA mapping */
> +       union {
> +               struct page_pool *pp;   /* Used on Rx for buffer manageme=
nt */
> +               struct device *dev;     /* Used on Tx for DMA mapping */
> +       };
>         struct net_device *netdev;      /* netdev ring maps to */
>         union {
> +               struct libie_rx_buffer *rx_bi;
>                 struct iavf_tx_buffer *tx_bi;
> -               struct iavf_rx_buffer *rx_bi;
>         };
>         DECLARE_BITMAP(state, __IAVF_RING_STATE_NBITS);
> +       u8 __iomem *tail;
>         u16 queue_index;                /* Queue number of ring */
>         u8 dcb_tc;                      /* Traffic class of ring */
> -       u8 __iomem *tail;
>
>         /* high bit set means dynamic, use accessors routines to read/wri=
te.
>          * hardware only supports 2us resolution for the ITR registers.

I'm assuming "tail" was moved here since it is a pointer and fills a hole?

> @@ -329,9 +264,8 @@ struct iavf_ring {
>          */
>         u16 itr_setting;
>
> -       u16 count;                      /* Number of descriptors */
>         u16 reg_idx;                    /* HW register index of the ring =
*/
> -       u16 rx_buf_len;
> +       u16 count;                      /* Number of descriptors */

Why move count down here? It is moving the constant value that is
read-mostly into an area that will be updated more often.

>         /* used in interrupt processing */
>         u16 next_to_use;
> @@ -398,17 +332,6 @@ struct iavf_ring_container {
>  #define iavf_for_each_ring(pos, head) \
>         for (pos =3D (head).ring; pos !=3D NULL; pos =3D pos->next)
>
> -static inline unsigned int iavf_rx_pg_order(struct iavf_ring *ring)
> -{
> -#if (PAGE_SIZE < 8192)
> -       if (ring->rx_buf_len > (PAGE_SIZE / 2))
> -               return 1;
> -#endif
> -       return 0;
> -}
> -
> -#define iavf_rx_pg_size(_ring) (PAGE_SIZE << iavf_rx_pg_order(_ring))
> -

All this code probably could have been removed in an earlier patch
since I don't think we need the higher order pages once we did away
with the recycling. Odds are we can probably move this into the
recycling code removal.

>  bool iavf_alloc_rx_buffers(struct iavf_ring *rxr, u16 cleaned_count);
>  netdev_tx_t iavf_xmit_frame(struct sk_buff *skb, struct net_device *netd=
ev);
>  int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring);
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/et=
hernet/intel/iavf/iavf_type.h
> index 3030ba330326..bb90d8f3ad7e 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_type.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
> @@ -10,8 +10,6 @@
>  #include "iavf_adminq.h"
>  #include "iavf_devids.h"
>
> -#define IAVF_RXQ_CTX_DBUFF_SHIFT 7
> -
>  /* IAVF_MASK is a macro used on 32 bit registers */
>  #define IAVF_MASK(mask, shift) ((u32)(mask) << (shift))
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/ne=
t/ethernet/intel/iavf/iavf_virtchnl.c
> index fdddc3588487..5341508b429f 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 2013 - 2018 Intel Corporation. */
>
> +#include <linux/net/intel/libie/rx.h>
> +
>  #include "iavf.h"
>  #include "iavf_prototype.h"
>  #include "iavf_client.h"
> @@ -269,14 +271,13 @@ int iavf_get_vf_vlan_v2_caps(struct iavf_adapter *a=
dapter)
>  void iavf_configure_queues(struct iavf_adapter *adapter)
>  {
>         struct virtchnl_vsi_queue_config_info *vqci;
> -       int i, max_frame =3D adapter->vf_res->max_mtu;
> +       u32 i, max_frame =3D adapter->vf_res->max_mtu;
> +       struct iavf_ring *rxq =3D adapter->rx_rings;
>         int pairs =3D adapter->num_active_queues;
>         struct virtchnl_queue_pair_info *vqpi;
> +       u32 hr, max_len;
>         size_t len;
>
> -       if (max_frame > IAVF_MAX_RXBUFFER || !max_frame)
> -               max_frame =3D IAVF_MAX_RXBUFFER;
> -
>         if (adapter->current_op !=3D VIRTCHNL_OP_UNKNOWN) {
>                 /* bail because we already have a command pending */
>                 dev_err(&adapter->pdev->dev, "Cannot configure queues, co=
mmand %d pending\n",
> @@ -289,9 +290,9 @@ void iavf_configure_queues(struct iavf_adapter *adapt=
er)
>         if (!vqci)
>                 return;
>
> -       /* Limit maximum frame size when jumbo frames is not enabled */
> -       if (adapter->netdev->mtu <=3D ETH_DATA_LEN)
> -               max_frame =3D IAVF_RXBUFFER_1536 - NET_IP_ALIGN;
> +       hr =3D rxq->pp->p.offset;
> +       max_len =3D rxq->pp->p.max_len;
> +       max_frame =3D min_not_zero(max_frame, LIBIE_MAX_RX_FRM_LEN(hr));
>         vqci->vsi_id =3D adapter->vsi_res->vsi_id;
>         vqci->num_queue_pairs =3D pairs;
> @@ -309,9 +310,7 @@ void iavf_configure_queues(struct iavf_adapter *adapt=
er)
>                 vqpi->rxq.ring_len =3D adapter->rx_rings[i].count;
>                 vqpi->rxq.dma_ring_addr =3D adapter->rx_rings[i].dma;
>                 vqpi->rxq.max_pkt_size =3D max_frame;
> -               vqpi->rxq.databuffer_size =3D
> -                       ALIGN(adapter->rx_rings[i].rx_buf_len,
> -                             BIT_ULL(IAVF_RXQ_CTX_DBUFF_SHIFT));

Is this rendered redundant by something? Seems like you should be
guaranteeing somewhere that you are still aligned to this.


> +               vqpi->rxq.databuffer_size =3D max_len;
>                 vqpi++;
>         }
>
> --
> 2.41.0
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
