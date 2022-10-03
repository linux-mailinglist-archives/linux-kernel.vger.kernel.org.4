Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150EA5F2D0A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJCJU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJCJUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:20:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9B72A738;
        Mon,  3 Oct 2022 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664788851; x=1696324851;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z6K68YyUKzWqSpdXZWrLaYWcVLU8CiMzj6Mm5l9GEKs=;
  b=n6ZjGUEajGy72W2GZKZfiHapR+98uIfbWbIHf9EA7OHyjagfq3qJ0MIz
   zCMFRjn0U57/iDHa8e4stVQa1KVDd8hmpmBdo2I6DGtXF9sUsH0bNJoXY
   e4KRcxgfPXlSox9Ecrs0q75vHPskl+qNyzBWFov+ieT8+U9TB9WQnGxLU
   ivv2kp5rYnbp1JRv7HEI4m6R5gwXlTqm6GZJ6CR1bv9JwiLrbkMrfoYZ5
   Bsb3/9nCRsuZ4erZ4b3uhjba280AF+Ua+JRzBAVd09mVOkLfvme/CzoMB
   Zzc/d78wy+NYElkTyzE72s4LKkRd4X+c+izeY6lhEM40Z0pLT/5h5ia4N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="388877521"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="388877521"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 02:20:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="765844375"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="765844375"
Received: from rladysz-mobl2.ger.corp.intel.com ([10.252.38.50])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 02:20:46 -0700
Date:   Mon, 3 Oct 2022 12:20:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, andy.shevchenko@gmail.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver.
In-Reply-To: <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com>
Message-ID: <d184aa6d-23e-edf6-4cee-f5f4ad6bf90@linux.intel.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com> <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022, Kumaravel Thiagarajan wrote:

> pci1xxxx uart supports rs485 mode of operation in the hardware with
> auto-direction control with configurable delay for releasing RTS after
> the transmission. This patch adds support for the rs485 mode.
> 
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> Changes in v2:
> - move pci1xxxx_rs485_config to a separate patch with
>   pci1xxxx_rs485_supported.
> ---
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 57 +++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index 41a4b94f52b4..999e5a284266 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> +
> +		if (rs485->delay_rts_after_send) {
> +			baud_period_in_ns = ((clock_div >> 8) * 16);

Is this 16 perhaps UART_BIT_SAMPLE_CNT?


-- 
 i.

