Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FC1665F13
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjAKP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjAKP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:28:27 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC0A2DE7;
        Wed, 11 Jan 2023 07:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=l91yn5XMBlf8IaSq4NhkMOOy2mQCGvI9lWUFKT2jjXQ=; b=nPVJt
        QatnKO+VXI55OnkOzNniPKp8gCUDmjozgtlTc4xcc9I13TENiQz+zubbQJIo10MPxbVTIlgQ9IhBC
        eSFtWLL9WmfzsYMYR4WnRMMzITwgmxtlNLLu/9jlsb4H9/7V+lIhV79TpdUMQ/MfhCvry0l7piI2v
        m5fU02IY47XpYZQxXQ9/DDzfiWaqL9Zyn0bLeJt2MQi7Qp8iCv3oMEIzLZZ0kJAh1v5lokrzb4fL7
        BWA7KhXdQW1nbLgc7k+DIGe/Jh6ZBOgH3I7uyHVE66EfwosiWWLbJWahbxBFr6DwzASETpQ+u2WcX
        duuoiFYzQQmWbXBvZeVlL5T6mqaFQ==;
Received: from dougal.metanate.com ([192.168.88.1] helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pFd1O-0000kh-Ct;
        Wed, 11 Jan 2023 15:28:10 +0000
Date:   Wed, 11 Jan 2023 15:28:09 +0000
From:   John Keeping <john@metanate.com>
To:     bhuvanesh_surachari@mentor.com
Cc:     gregkh@linuxfoundation.org, Linyu Yuan <quic_linyyuan@quicinc.com>,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dan Carpenter <error27@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: f_fs: Make sure to unregister gadget item in unbind
Message-ID: <Y77ViYYXj561yxd3@donbot>
References: <20230111121719.5258-1-bhuvanesh_surachari@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111121719.5258-1-bhuvanesh_surachari@mentor.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 05:47:17PM +0530, bhuvanesh_surachari@mentor.com wrote:
> From: Bhuvanesh Surachari <bhuvanesh_surachari@mentor.com>
> 
> In functionfs_unbind() the FFS_FL_BOUND flag was cleared before
> calling ffs_data_put() which was preventing the execution of function
> unregister_gadget_item().
> This was leading to Kernel panic due to NULL pointer dereference as
> below:
> Unable to handle kernel NULL pointer dereference at virtual address 00000020
> Mem abort info:
>   Exception class = DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000006
>   CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgd = ffff80062cb6a000
> [0000000000000020] *pgd=000000066c966003, *pud=000000067a170003, *pmd=0000000000000000
> Internal error: Oops: 96000006 [#1] PREEMPT SMP
> tftp nf_nat nf_conntrack_tftp nf_conntrack adv7180 optee tee quota_v2 quota_tree max20010_regulator aesi adc_inc input_inc cpufreq_dt thermal_sys ravb snd_soc_rcar snd_aloop snd_soc_skeleton ravb_mdio snd_soc_generic_card
> tp pps_core sbrrc spidev spi_sh_msiof evdev boottime gpio_inc i2c_dev usb8251x_firmware ipv6 autofs4 [last unloaded: atmel_mxt_ts]
> Process swapper/1 (pid: 0, stack limit = 0xffff000008e30000)
> CPU: 1 PID: 0 Comm: swapper/1 Tainted: G         C      4.14.295-ltsi-08448-g8e327c2d87fb #1
> Hardware name: RBCM A-IVI2 CCS1.1 B board based on r8a7796 (DT)
> pc : usb_ep_queue+0xe0/0x110 [udc_core]
> lr : eth_start_xmit+0x280/0x30c [u_ether]
> sp : ffff00000800bde0 pstate : 80000145
> x29: ffff00000800bde0 x28: 0000000000000006
> x27: 0000000000000140 x26: ffff8005fbb7a518
> x25: ffff80063b2c98a8 x24: ffff80063a6f73b8
> x23: ffff80063b2c98a0 x22: ffff8005fbb7a518
> x21: ffff80063b2c9000 x20: ffff80063a6f73b8
> x19: ffff8005fbb7a558 x18: 000000000049a1dc
> x17: 000000365edd6f88 x16: ffff000008204254
> x15: 0000000000000000 x14: 0000000000000400
> x13: 0000000000000400 x12: 0000000000000000
> x11: 0101010101010101 x10: 0000000000000000
> x9 : 0000000000000484 x8 : ffff8005d9a44214
> x7 : 0000000000000000 x6 : ffff8005d9a44210
> x5 : ffff8005d9a44210 x4 : 0000000000000214
> x3 : 0000000000000001 x2 : 0000000001080020
> x1 : ffff8005fbb7a518 x0 : 0000000000000000
> Call trace:
>  usb_ep_queue+0xe0/0x110 [udc_core]
>  eth_start_xmit+0x280/0x30c [u_ether]
>  ncm_tx_tasklet+0x3c/0x50 [usb_f_ncm]
>  tasklet_action+0xa0/0x104
>  __do_softirq+0x260/0x3b8
>  irq_exit+0x7c/0xd8
>  __handle_domain_irq+0x78/0xac
>  gic_handle_irq+0x68/0xa8
>  el1_irq+0xb4/0x12c
>  cpuidle_enter_state+0x1b4/0x2d4
>  cpuidle_enter+0x18/0x20
>  call_cpuidle+0x34/0x38
>  do_idle+0x158/0x1a8
>  cpu_startup_entry+0x20/0x30
>  secondary_start_kernel+0x10c/0x118
> Code: 95e9c147 17ffffe3 f9400a80 aa1603e1 (f9401003)
> ---[ end trace ffcd984d149a0f4e ]---
> Kernel panic - not syncing: Fatal exception in interrupt
> SMP: stopping secondary CPUs
> Kernel Offset: disabled
> CPU features: 0x21002004
> Memory Limit: 3968 MB
> Rebooting in 3 seconds..

I don't understand this - that looks like a networking gadget which is
not FFS.  How does an issue in the FFS function affect the underlying
UDC for a totally different gadget function?

> Hence clear the FFS_FL_BOUND flag after checking using
> test_and_clear_bit() in function ffs_closed() which ensures calling
> of unregister_gadget_item().
> 
> Signed-off-by: Bhuvanesh Surachari <bhuvanesh_surachari@mentor.com>
> ---
>  drivers/usb/gadget/function/f_fs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 73dc10a77cde..8bed3c800dff 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1895,7 +1895,6 @@ static void functionfs_unbind(struct ffs_data *ffs)
>  		usb_ep_free_request(ffs->gadget->ep0, ffs->ep0req);
>  		ffs->ep0req = NULL;
>  		ffs->gadget = NULL;
> -		clear_bit(FFS_FL_BOUND, &ffs->flags);
>  		ffs_data_put(ffs);
>  	}
>  }
> @@ -3847,7 +3846,7 @@ static void ffs_closed(struct ffs_data *ffs)
>  	ci = opts->func_inst.group.cg_item.ci_parent->ci_parent;
>  	ffs_dev_unlock();
>  
> -	if (test_bit(FFS_FL_BOUND, &ffs->flags))
> +	if (test_and_clear_bit(FFS_FL_BOUND, &ffs->flags))

If you're clearing the FFS_FL_BOUND flag here, then doesn't the name of
the flag need to change as it's no longer tracking what it claims to
(and indeed this is effectively unconditional if the flag can't be
cleared anywhere else).

>  		unregister_gadget_item(ci);
>  	return;
>  done:
> -- 
> 2.17.1
> 
