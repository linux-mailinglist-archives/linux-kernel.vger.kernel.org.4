Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF0174E7F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGKH0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjGKH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B01F4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71C1761346
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5956EC433C8;
        Tue, 11 Jul 2023 07:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689060367;
        bh=7gagTghnHbdnS89ft0SRPtMAku+GMOo4ENlpz1jSnaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5D8O/k6Bv2j9KFP/x+I+2+38XTL83NpDNhCVx0vQIE3mGkCesQJn7itmiRafmHGf
         kLdZBa0YUc5ct+Yras8ghAFIRFYwg3LGi+FUM5gWESTbBha0QeaRK01y7OPxoqxSfK
         WOGMbDGr5hIjSIhA163abe6dBNc8nmeKXoDEE0EEAcXokMZTPBHyiIqKBXS7yghK6T
         LSS77lIMXAbF7j0nKV7fzLjJS/Jey+NC8542G4E/IV0eabznx0eVKw4uivUHUKT5wn
         ui39sNIxswdxahuME4wLO8DKg++S7VG9Qe++P6vib6MEsoF0Z/pvBljiFm2bjHdNq3
         h+BiIXwlIavxg==
Date:   Tue, 11 Jul 2023 10:26:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ena: fix shift-out-of-bounds in exponential
 backoff
Message-ID: <20230711072603.GI41919@unreal>
References: <20230711013621.GE1926@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711013621.GE1926@templeofstupid.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 06:36:21PM -0700, Krister Johansen wrote:
> The ENA adapters on our instances occasionally reset.  Once recently
> logged a UBSAN failure to console in the process:
> 
>   UBSAN: shift-out-of-bounds in build/linux/drivers/net/ethernet/amazon/ena/ena_com.c:540:13
>   shift exponent 32 is too large for 32-bit type 'unsigned int'
>   CPU: 28 PID: 70012 Comm: kworker/u72:2 Kdump: loaded not tainted 5.15.117
>   Hardware name: Amazon EC2 c5d.9xlarge/, BIOS 1.0 10/16/2017
>   Workqueue: ena ena_fw_reset_device [ena]
>   Call Trace:
>   <TASK>
>   dump_stack_lvl+0x4a/0x63
>   dump_stack+0x10/0x16
>   ubsan_epilogue+0x9/0x36
>   __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
>   ? __const_udelay+0x43/0x50
>   ena_delay_exponential_backoff_us.cold+0x16/0x1e [ena]
>   wait_for_reset_state+0x54/0xa0 [ena]
>   ena_com_dev_reset+0xc8/0x110 [ena]
>   ena_down+0x3fe/0x480 [ena]
>   ena_destroy_device+0xeb/0xf0 [ena]
>   ena_fw_reset_device+0x30/0x50 [ena]
>   process_one_work+0x22b/0x3d0
>   worker_thread+0x4d/0x3f0
>   ? process_one_work+0x3d0/0x3d0
>   kthread+0x12a/0x150
>   ? set_kthread_struct+0x50/0x50
>   ret_from_fork+0x22/0x30
>   </TASK>
> 
> Apparently, the reset delays are getting so large they can trigger a
> UBSAN panic.
> 
> Looking at the code, the current timeout is capped at 5000us.  Using a
> base value of 100us, the current code will overflow after (1<<29).  Even
> at values before 32, this function wraps around, perhaps
> unintentionally.
> 
> Cap the value of the exponent used for this backoff at (1<<16) which is
> larger than currently necessary, but large enough to support bigger
> values in the future.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4bb7f4cf60e3 ("net: ena: reduce driver load time")
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_com.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> index 451c3a1b6255..633b321d7fdd 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> @@ -35,6 +35,8 @@
>  
>  #define ENA_REGS_ADMIN_INTR_MASK 1
>  
> +#define ENA_MAX_BACKOFF_DELAY_EXP 16U
> +
>  #define ENA_MIN_ADMIN_POLL_US 100
>  
>  #define ENA_MAX_ADMIN_POLL_US 5000
> @@ -536,6 +538,7 @@ static int ena_com_comp_status_to_errno(struct ena_com_admin_queue *admin_queue,
>  
>  static void ena_delay_exponential_backoff_us(u32 exp, u32 delay_us)
>  {
> +	exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
