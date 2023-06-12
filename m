Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6876572D020
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjFLUGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbjFLUF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA33121
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686600309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nu157xz+O3RrfYdQYG6rQQumwKRQGhj7CP2oD+0VisM=;
        b=iPhHXqVUWw7ktcqgMGzdw5i7lRSWnxwXvXTPQpBNPN9HsiL4YCt+NjYlhw0Iq5Y9TqvGq3
        LWUeN0H/+5PB7HgHmksnt7/FE6C2iZht1UCim8Sif6hTKxitCNbcBv4ah7PB60rSmni1k1
        k8x4dtkzOseT8SCkIKMCHFHe+45J+nY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-sRVrM-iIOSyDQqi_PVyQjA-1; Mon, 12 Jun 2023 16:05:08 -0400
X-MC-Unique: sRVrM-iIOSyDQqi_PVyQjA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62de8fca200so3785546d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686600306; x=1689192306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nu157xz+O3RrfYdQYG6rQQumwKRQGhj7CP2oD+0VisM=;
        b=Ag/UbSr6yxEku25wDrN7xlYLvXTpi+/XU4gexmpsv68Lf2Eeula+urbYDAlaYhq6ro
         zU4KNUL1NoRrm06nL2xG9ELwSbpEuAk0Ld5RQntwVc5DmHKtQZJdXTAxWIYcukH97ceb
         uif6qk2AGnwzNO1665SYmaJLXyr8t3zuwQYlJkZAZ5d2ZWT1NUEfVu0OCW9hKt4TudQb
         losvHnJ9NcyOtf2Qh653yd8+HxuY+mTVPs5LjWkH+TlX18r8Q4Ly0AZ1ywbEmVelVD6L
         nObavFaJU8lgyiQlfBuT9hutF4F1b+XdBMY9QUA5IRUQYmIZ3y0c8TnT656ytyejz9uT
         EFxg==
X-Gm-Message-State: AC+VfDwDgcA3wTyMBttkMCne9v9qUAxV3j7RlK8fO7D0Q+vgipjtrH90
        k2wpldCnkpTD9Vijfb3RknLnwrOdrHSJgwcku3vub3/9rCqPOw6jQvuBENTgxMN2DxZUAEHJkmr
        KV3vJMpjsWrGFwsy/hd54NoUy
X-Received: by 2002:ad4:5baa:0:b0:5dd:b986:b44 with SMTP id 10-20020ad45baa000000b005ddb9860b44mr11463297qvq.6.1686600305789;
        Mon, 12 Jun 2023 13:05:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7H1q1DqRrvkCipMgEiYgZRTlES9wltJActf/Pf2oZyZoWtJF7Gh3R8ohVrTXCxblcZ5KibxQ==
X-Received: by 2002:ad4:5baa:0:b0:5dd:b986:b44 with SMTP id 10-20020ad45baa000000b005ddb9860b44mr11463264qvq.6.1686600305457;
        Mon, 12 Jun 2023 13:05:05 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id e1-20020a0cf341000000b0062dee768501sm719812qvm.99.2023.06.12.13.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:05:05 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:05:04 -0400
From:   Eric Chanudet <echanude@redhat.com>
To:     Lucas Karpinski <lkarpins@redhat.com>
Cc:     linux-kernel@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ahalaney@redhat.com,
        bmasney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH] Revert "arm64: dts: qcom: sa8540p-ride: enable pcie2a
 node"
Message-ID: <6m7xpqs73wrlin2ghhviwc4ijb5kyvk7ba2wpflqkgjivv6ol2@z5i5uli3h7f3>
References: <pmodcoakbs25z2a7mlo5gpuz63zluh35vbgb5itn6k5aqhjnny@jvphbpvahtse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pmodcoakbs25z2a7mlo5gpuz63zluh35vbgb5itn6k5aqhjnny@jvphbpvahtse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 03:33:21PM -0400, Lucas Karpinski wrote:
> This reverts commit 2eb4cdcd5aba2db83f2111de1242721eeb659f71.
> 
> The patch introduced a sporadic error where the Qdrive3 will fail to
> boot occasionally due to an rcu preempt stall.
> Qualcomm has disabled pcie2a downstream:
> https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/rh-patch/-/commit/447f2135909683d1385af36f95fae5e1d63a7e2f
> 
> rcu: INFO: rcu_preempt self-detected stall on CPU
> rcu:     0-....: (1 GPs behind) idle=77fc/1/0x4000000000000004 softirq=841/841 fqs=2476
> rcu:     (t=5253 jiffies g=-175 q=2552 ncpus=8)
> Call trace:
>  __do_softirq
>  ____do_softirq
>  call_on_irq_stack
>  do_softirq_own_stack
>  __irq_exit_rcu
>  irq_exit_rcu
> 
> The issue occurs normally once every 3-4 boot cycles.
> There is likely a race condition caused when setting up the two pcie
> domains concurrently (pcie2a and pcie3a).
> 
> The issue is not present when only pcie2a is enabled or when only pcie3a
> is enabled.
> A workaround was found that allowed the Qdrive3 to boot with both pcie2a
> and pcie3a enabled.
> Set the .probe_type to PROBE_FORCE_SYNCHRONOUS and add an msleep() to
> the probing function.
> This is not a solution, so this patch is disabling pcie2a as it seems
> Red Hat are the only ones working on the board,
> we're find with disabling the node until a root cause is found. If
> anyone has further suggestions for debugging, let me know.
> 
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> ---
>  During debugging:
>         - Added additional time for clock/regulator stabilization.
>         - Reduced the bandwidth across pcie2a and pcie3a.
>         - Replaced the interconnect setup from another driver.
>         - The 32-bit/64-bit/config-io space for both pcie2a and pcie3a look to be mapped correctly.
>         - Verified interconnects were started successfully.

I was looking at another issue downstream triggering a soft lock on
CPU0, but it turns out this could be the same thing except the symptoms
are less noticeable (the 3-4 boot cycles you mention).

Using next-20230609, if I add a return kprobe on dw_handle_msi_irq:

echo 'r:dwmsi_probe dw_handle_msi_irq $retval' > /sys/kernel/debug/tracing/kprobe_events
echo 1 > /sys/kernel/debug/tracing/events/kprobes/dwmsi_probe/enable 
cat /sys/kernel/debug/tracing/trace_pipe
<idle>-0       [000] d.h1.   690.417268: dwmsi_probe: (dw_chained_msi_isr+0x38/0xb8 <- dw_handle_msi_irq) arg1=0x0
<idle>-0       [000] d.h1.   690.417272: dwmsi_probe: (dw_chained_msi_isr+0x38/0xb8 <- dw_handle_msi_irq) arg1=0x0
<idle>-0       [000] d.h1.   690.417276: dwmsi_probe: (dw_chained_msi_isr+0x38/0xb8 <- dw_handle_msi_irq) arg1=0x0
<idle>-0       [000] d.h1.   690.417281: dwmsi_probe: (dw_chained_msi_isr+0x38/0xb8 <- dw_handle_msi_irq) arg1=0x0
<idle>-0       [000] d.h1.   690.417284: dwmsi_probe: (dw_chained_msi_isr+0x38/0xb8 <- dw_handle_msi_irq) arg1=0x0
<idle>-0       [000] d.h1.   690.417288: dwmsi_probe: (dw_chained_msi_isr+0x38/0xb8 <- dw_handle_msi_irq) arg1=0x0
[...]

dw_handle_msi_irq constantly fires and never returns IRQ_HANDLED. It
happens consistently for pcie2a or pcie3a, after I disable one or the
other. I presume having both might be enough to overwhelm the system and
trigger the stall?

Looking at the handler, the status is always 0 after:
status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
			   (i * MSI_REG_CTRL_BLOCK_SIZE));

Unfortunately I do not know why that is yet.

> 
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 44 -----------------------
>  1 file changed, 44 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index 24fa449d48a6..d492723ccf7c 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -186,27 +186,6 @@ &i2c18 {
>  	status = "okay";
>  };
>  
> -&pcie2a {
> -	ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
> -		 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>,
> -		 <0x03000000 0x5 0x00000000 0x5 0x00000000 0x1 0x00000000>;
> -
> -	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
> -	wake-gpios = <&tlmm 145 GPIO_ACTIVE_HIGH>;
> -
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2a_default>;
> -
> -	status = "okay";
> -};
> -
> -&pcie2a_phy {
> -	vdda-phy-supply = <&vreg_l11a>;
> -	vdda-pll-supply = <&vreg_l3a>;
> -
> -	status = "okay";
> -};
> -
>  &pcie3a {
>  	ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
>  		 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x20000000>,
> @@ -356,29 +335,6 @@ i2c18_default: i2c18-default-state {
>  		bias-pull-up;
>  	};
>  
> -	pcie2a_default: pcie2a-default-state {
> -		perst-pins {
> -			pins = "gpio143";
> -			function = "gpio";
> -			drive-strength = <2>;
> -			bias-pull-down;
> -		};
> -
> -		clkreq-pins {
> -			pins = "gpio142";
> -			function = "pcie2a_clkreq";
> -			drive-strength = <2>;
> -			bias-pull-up;
> -		};
> -
> -		wake-pins {
> -			pins = "gpio145";
> -			function = "gpio";
> -			drive-strength = <2>;
> -			bias-pull-up;
> -		};
> -	};
> -
>  	pcie3a_default: pcie3a-default-state {
>  		perst-pins {
>  			pins = "gpio151";
> -- 
> 2.40.1
> 

-- 
Eric Chanudet

