Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DD561F3C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiKGMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiKGMzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:55:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C441BEAB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667825664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wKWUeAqFeaW9VBySVJp7mIdsLyeRMqN5qSA3MR8za8=;
        b=MvvDLNeFtX/eXn10RfKieM9dolEMMnbuZxuNMLkyh5X2x6jQMiR5zpur/KLahkX/VhGiCD
        odjkVD0XA6tZAl2t6aUY39zEs/Jd7BnsA6fesV8EXWCAPMLN3gqRvXGbjkxcLkhJNlkU9L
        LHAt+LeZJ8+d1j4xgZhgfN7Mt5e+Fuw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-AT10qC-xMsmaSWly18mTxw-1; Mon, 07 Nov 2022 07:54:23 -0500
X-MC-Unique: AT10qC-xMsmaSWly18mTxw-1
Received: by mail-ej1-f72.google.com with SMTP id qk31-20020a1709077f9f00b00791a3e02c80so6402346ejc.21
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:54:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wKWUeAqFeaW9VBySVJp7mIdsLyeRMqN5qSA3MR8za8=;
        b=Zd5k2wP36LTvI1RvgvF1WKxwMGQ4kMxpIWXhUAOW+khFPUnm8VrFr+NUiiYzcNf/Aa
         iW9y+GQFRi52iNnfyS3/Hgpz2Dg4RV9i7sRcBbLow8E1UqRCIi59jTvKpg+cq+5Powwl
         gFrGyZ6t4lkJJqROL5COrmXevmgi+YCYZ4qjQ35jSOOmjaqMOEJbI6NUJDHnXsqrWhWa
         GFPABKr3htfpYKk+usTB9MezRTH9cB4Kk6VOXlljEM/VgjiayJNe77HhHmM/8rSWhvNS
         ByH6nN+rHC90/crSo3bdFF+rV0Rteg97ZENcZ5LrWGZ3luNPPKFW2pmvi7ZNy6QAu6Pm
         Hh/g==
X-Gm-Message-State: ACrzQf04CEcDREFe42z2+llTjOP7oXBBJ+Y1vuPQ6OR9685WGo5dTQn1
        P36BJ1VGyoAMeQ0WVqU+/ymHFThoqzt//4EhbiISnrHwtrmf3qZHaeT1AAOVaob6pI8GQoBi21J
        +jw41HDiTWOw+9C5pTqAjoZqT
X-Received: by 2002:a17:907:6e29:b0:7ad:d7f7:c924 with SMTP id sd41-20020a1709076e2900b007add7f7c924mr38516034ejc.749.1667825661782;
        Mon, 07 Nov 2022 04:54:21 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5mKlEvBaZ85Rnl9dwinMI/6DhF0XuruvV2WZYvuQw/A6SxaXPy6A7VFNKfk2w/7uNlin88cA==
X-Received: by 2002:a17:907:6e29:b0:7ad:d7f7:c924 with SMTP id sd41-20020a1709076e2900b007add7f7c924mr38516009ejc.749.1667825661462;
        Mon, 07 Nov 2022 04:54:21 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b0077016f4c6d4sm3393958ejb.55.2022.11.07.04.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 04:54:20 -0800 (PST)
Message-ID: <971170ce-94af-26f7-a9aa-9c83a84bb3c3@redhat.com>
Date:   Mon, 7 Nov 2022 13:54:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] platform/mellanox: Add BlueField-3 support in the
 tmfifo driver
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Vadim Pasternak <vadimp@nvidia.com>
References: <33bfcba9d1ad5a52ae9a63e817167b9ee3f0123a.1666024788.git.limings@nvidia.com>
 <20221018133303.243920-1-limings@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221018133303.243920-1-limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/18/22 15:33, Liming Sun wrote:
> BlueField-3 uses the same control registers in tmfifo access but
> at different addresses. This commit replaces the offset reference
> with pointers, and set up these pointers in the probe functions
> accordingly.
> 
> Signed-off-by: Liming Sun <limings@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> v1->v2:
>   Resend with updated reviewer list
> v1: Initial version
> ---
>  drivers/platform/mellanox/mlxbf-tmfifo-regs.h | 10 +++
>  drivers/platform/mellanox/mlxbf-tmfifo.c      | 86 ++++++++++++++-----
>  2 files changed, 74 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo-regs.h b/drivers/platform/mellanox/mlxbf-tmfifo-regs.h
> index e4f0d2eda714..44fb8c5b1484 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo-regs.h
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo-regs.h
> @@ -60,4 +60,14 @@
>  #define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_RMASK		GENMASK_ULL(8, 0)
>  #define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_MASK		GENMASK_ULL(40, 32)
>  
> +/* BF3 register offsets within resource 0. */
> +#define MLXBF_TMFIFO_RX_DATA_BF3	0x0000
> +#define MLXBF_TMFIFO_TX_DATA_BF3	0x1000
> +
> +/* BF3 register offsets within resource 1. */
> +#define MLXBF_TMFIFO_RX_STS_BF3		0x0000
> +#define MLXBF_TMFIFO_RX_CTL_BF3		0x0008
> +#define MLXBF_TMFIFO_TX_STS_BF3		0x0100
> +#define MLXBF_TMFIFO_TX_CTL_BF3		0x0108
> +
>  #endif /* !defined(__MLXBF_TMFIFO_REGS_H__) */
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index 1ae3c56b66b0..91a077c35b8b 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -47,6 +47,9 @@
>  /* Message with data needs at least two words (for header & data). */
>  #define MLXBF_TMFIFO_DATA_MIN_WORDS		2
>  
> +/* ACPI UID for BlueField-3. */
> +#define TMFIFO_BF3_UID				1
> +
>  struct mlxbf_tmfifo;
>  
>  /**
> @@ -136,12 +139,26 @@ struct mlxbf_tmfifo_irq_info {
>  	int index;
>  };
>  
> +/**
> + * mlxbf_tmfifo_io - Structure of the TmFifo IO resource (for both rx & tx)
> + * @ctl: control register offset (TMFIFO_RX_CTL / TMFIFO_TX_CTL)
> + * @sts: status register offset (TMFIFO_RX_STS / TMFIFO_TX_STS)
> + * @data: data register offset (TMFIFO_RX_DATA / TMFIFO_TX_DATA)
> + */
> +struct mlxbf_tmfifo_io {
> +	void __iomem *ctl;
> +	void __iomem *sts;
> +	void __iomem *data;
> +};
> +
>  /**
>   * mlxbf_tmfifo - Structure of the TmFifo
>   * @vdev: array of the virtual devices running over the TmFifo
>   * @lock: lock to protect the TmFifo access
> - * @rx_base: mapped register base address for the Rx FIFO
> - * @tx_base: mapped register base address for the Tx FIFO
> + * @res0: mapped resource block 0
> + * @res1: mapped resource block 1
> + * @rx: rx io resource
> + * @tx: tx io resource
>   * @rx_fifo_size: number of entries of the Rx FIFO
>   * @tx_fifo_size: number of entries of the Tx FIFO
>   * @pend_events: pending bits for deferred events
> @@ -155,8 +172,10 @@ struct mlxbf_tmfifo_irq_info {
>  struct mlxbf_tmfifo {
>  	struct mlxbf_tmfifo_vdev *vdev[MLXBF_TMFIFO_VDEV_MAX];
>  	struct mutex lock;		/* TmFifo lock */
> -	void __iomem *rx_base;
> -	void __iomem *tx_base;
> +	void __iomem *res0;
> +	void __iomem *res1;
> +	struct mlxbf_tmfifo_io rx;
> +	struct mlxbf_tmfifo_io tx;
>  	int rx_fifo_size;
>  	int tx_fifo_size;
>  	unsigned long pend_events;
> @@ -472,7 +491,7 @@ static int mlxbf_tmfifo_get_rx_avail(struct mlxbf_tmfifo *fifo)
>  {
>  	u64 sts;
>  
> -	sts = readq(fifo->rx_base + MLXBF_TMFIFO_RX_STS);
> +	sts = readq(fifo->rx.sts);
>  	return FIELD_GET(MLXBF_TMFIFO_RX_STS__COUNT_MASK, sts);
>  }
>  
> @@ -489,7 +508,7 @@ static int mlxbf_tmfifo_get_tx_avail(struct mlxbf_tmfifo *fifo, int vdev_id)
>  	else
>  		tx_reserve = 1;
>  
> -	sts = readq(fifo->tx_base + MLXBF_TMFIFO_TX_STS);
> +	sts = readq(fifo->tx.sts);
>  	count = FIELD_GET(MLXBF_TMFIFO_TX_STS__COUNT_MASK, sts);
>  	return fifo->tx_fifo_size - tx_reserve - count;
>  }
> @@ -525,7 +544,7 @@ static void mlxbf_tmfifo_console_tx(struct mlxbf_tmfifo *fifo, int avail)
>  	/* Write header. */
>  	hdr.type = VIRTIO_ID_CONSOLE;
>  	hdr.len = htons(size);
> -	writeq(*(u64 *)&hdr, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
> +	writeq(*(u64 *)&hdr, fifo->tx.data);
>  
>  	/* Use spin-lock to protect the 'cons->tx_buf'. */
>  	spin_lock_irqsave(&fifo->spin_lock[0], flags);
> @@ -542,7 +561,7 @@ static void mlxbf_tmfifo_console_tx(struct mlxbf_tmfifo *fifo, int avail)
>  			memcpy((u8 *)&data + seg, cons->tx_buf.buf,
>  			       sizeof(u64) - seg);
>  		}
> -		writeq(data, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
> +		writeq(data, fifo->tx.data);
>  
>  		if (size >= sizeof(u64)) {
>  			cons->tx_buf.tail = (cons->tx_buf.tail + sizeof(u64)) %
> @@ -573,7 +592,7 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
>  
>  	/* Read a word from FIFO for Rx. */
>  	if (is_rx)
> -		data = readq(fifo->rx_base + MLXBF_TMFIFO_RX_DATA);
> +		data = readq(fifo->rx.data);
>  
>  	if (vring->cur_len + sizeof(u64) <= len) {
>  		/* The whole word. */
> @@ -595,7 +614,7 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
>  
>  	/* Write the word into FIFO for Tx. */
>  	if (!is_rx)
> -		writeq(data, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
> +		writeq(data, fifo->tx.data);
>  }
>  
>  /*
> @@ -617,7 +636,7 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
>  	/* Read/Write packet header. */
>  	if (is_rx) {
>  		/* Drain one word from the FIFO. */
> -		*(u64 *)&hdr = readq(fifo->rx_base + MLXBF_TMFIFO_RX_DATA);
> +		*(u64 *)&hdr = readq(fifo->rx.data);
>  
>  		/* Skip the length 0 packets (keepalive). */
>  		if (hdr.len == 0)
> @@ -661,7 +680,7 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
>  		hdr.type = (vring->vdev_id == VIRTIO_ID_NET) ?
>  			    VIRTIO_ID_NET : VIRTIO_ID_CONSOLE;
>  		hdr.len = htons(vring->pkt_len - hdr_len);
> -		writeq(*(u64 *)&hdr, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
> +		writeq(*(u64 *)&hdr, fifo->tx.data);
>  	}
>  
>  	vring->cur_len = hdr_len;
> @@ -1157,7 +1176,7 @@ static void mlxbf_tmfifo_set_threshold(struct mlxbf_tmfifo *fifo)
>  	u64 ctl;
>  
>  	/* Get Tx FIFO size and set the low/high watermark. */
> -	ctl = readq(fifo->tx_base + MLXBF_TMFIFO_TX_CTL);
> +	ctl = readq(fifo->tx.ctl);
>  	fifo->tx_fifo_size =
>  		FIELD_GET(MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_MASK, ctl);
>  	ctl = (ctl & ~MLXBF_TMFIFO_TX_CTL__LWM_MASK) |
> @@ -1166,17 +1185,17 @@ static void mlxbf_tmfifo_set_threshold(struct mlxbf_tmfifo *fifo)
>  	ctl = (ctl & ~MLXBF_TMFIFO_TX_CTL__HWM_MASK) |
>  		FIELD_PREP(MLXBF_TMFIFO_TX_CTL__HWM_MASK,
>  			   fifo->tx_fifo_size - 1);
> -	writeq(ctl, fifo->tx_base + MLXBF_TMFIFO_TX_CTL);
> +	writeq(ctl, fifo->tx.ctl);
>  
>  	/* Get Rx FIFO size and set the low/high watermark. */
> -	ctl = readq(fifo->rx_base + MLXBF_TMFIFO_RX_CTL);
> +	ctl = readq(fifo->rx.ctl);
>  	fifo->rx_fifo_size =
>  		FIELD_GET(MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_MASK, ctl);
>  	ctl = (ctl & ~MLXBF_TMFIFO_RX_CTL__LWM_MASK) |
>  		FIELD_PREP(MLXBF_TMFIFO_RX_CTL__LWM_MASK, 0);
>  	ctl = (ctl & ~MLXBF_TMFIFO_RX_CTL__HWM_MASK) |
>  		FIELD_PREP(MLXBF_TMFIFO_RX_CTL__HWM_MASK, 1);
> -	writeq(ctl, fifo->rx_base + MLXBF_TMFIFO_RX_CTL);
> +	writeq(ctl, fifo->rx.ctl);
>  }
>  
>  static void mlxbf_tmfifo_cleanup(struct mlxbf_tmfifo *fifo)
> @@ -1197,8 +1216,15 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
>  	struct virtio_net_config net_config;
>  	struct device *dev = &pdev->dev;
>  	struct mlxbf_tmfifo *fifo;
> +	u64 dev_id;
>  	int i, rc;
>  
> +	rc = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &dev_id);
> +	if (rc) {
> +		dev_err(dev, "Cannot retrieve UID\n");
> +		return rc;
> +	}
> +
>  	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
>  	if (!fifo)
>  		return -ENOMEM;
> @@ -1209,14 +1235,30 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
>  	mutex_init(&fifo->lock);
>  
>  	/* Get the resource of the Rx FIFO. */
> -	fifo->rx_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(fifo->rx_base))
> -		return PTR_ERR(fifo->rx_base);
> +	fifo->res0 = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(fifo->res0))
> +		return PTR_ERR(fifo->res0);
>  
>  	/* Get the resource of the Tx FIFO. */
> -	fifo->tx_base = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(fifo->tx_base))
> -		return PTR_ERR(fifo->tx_base);
> +	fifo->res1 = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(fifo->res1))
> +		return PTR_ERR(fifo->res1);
> +
> +	if (dev_id == TMFIFO_BF3_UID) {
> +		fifo->rx.ctl = fifo->res1 + MLXBF_TMFIFO_RX_CTL_BF3;
> +		fifo->rx.sts = fifo->res1 + MLXBF_TMFIFO_RX_STS_BF3;
> +		fifo->rx.data = fifo->res0 + MLXBF_TMFIFO_RX_DATA_BF3;
> +		fifo->tx.ctl = fifo->res1 + MLXBF_TMFIFO_TX_CTL_BF3;
> +		fifo->tx.sts = fifo->res1 + MLXBF_TMFIFO_TX_STS_BF3;
> +		fifo->tx.data = fifo->res0 + MLXBF_TMFIFO_TX_DATA_BF3;
> +	} else {
> +		fifo->rx.ctl = fifo->res0 + MLXBF_TMFIFO_RX_CTL;
> +		fifo->rx.sts = fifo->res0 + MLXBF_TMFIFO_RX_STS;
> +		fifo->rx.data = fifo->res0 + MLXBF_TMFIFO_RX_DATA;
> +		fifo->tx.ctl = fifo->res1 + MLXBF_TMFIFO_TX_CTL;
> +		fifo->tx.sts = fifo->res1 + MLXBF_TMFIFO_TX_STS;
> +		fifo->tx.data = fifo->res1 + MLXBF_TMFIFO_TX_DATA;
> +	}
>  
>  	platform_set_drvdata(pdev, fifo);
>  

