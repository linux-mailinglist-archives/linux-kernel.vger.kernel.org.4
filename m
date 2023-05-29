Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E27149E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjE2NId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjE2NI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:08:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04839B7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:08:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6077660c6so20907145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685365706; x=1687957706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aF9IRkrLPVcWloa4pJuck748Ln8OhhbNXky3Ir8k0q4=;
        b=oDdQjbmQpKR4roJ5hsrTJKqncwFAwFtXI1xz8SidikDtpNt0oFL/UATfvoZQ7f+2Yk
         nWD/dvCxaZDW0RaWBCwcyaX0hMXLa9JAtT+umv2h1xV0A+At9i+e8mGLPUvlluLjNoYg
         xEZlF01sZqXhcPbDDVY8WXdR8oxvTw5p/Gtw/3TWh0rNA2BvdTijgIy5bzRCX6fIopUV
         WM79VLuNieo03Wf0iqv5OQJygcse9NuF8zyyBMlOGFNAuHZ/5DFjc2U3n6erFUM44I9x
         /0QPw6jR9Uz1Wn3BcMp8N7/7ANAXfkV3nNzpBoKvfwy5a/R+pUtwMOqNduILi/8rOClc
         ByCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685365706; x=1687957706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF9IRkrLPVcWloa4pJuck748Ln8OhhbNXky3Ir8k0q4=;
        b=VBTs9GGJxLjnQIPC+JYgyePhTHzQZDa1xDR7NCcqZGk+I1aAZXikr/nIKkIub5Fk/U
         SD1y74b8cpwh8oSNdbd3sWOclmPu7x8dFDurWrlsZgI0azCjs5NO/eiJT3ggU2l8bw0D
         NkET0lYEacDlIEuGkjwapo3ssh1K559tE8d7V8jjm2TAewnEfuVLuSf9gT12i9vqHvfa
         tHFKJTgLzII66VhgQvwgRGCn3G4Vm6fzncGL/JNr9y3YPHk0/ExivI0p/N09knlzucLC
         UR2Mvp6yIeZpV3IAJ1ICdasQiHdj4q2tJ1tbMqRXBuvJBWwgxzMQBi9hCWte+uaKiIas
         y2TQ==
X-Gm-Message-State: AC+VfDwgCqNOowrAhSU0OPUodo+SUf/BcSmJUsAhR6GZj6zoZ5h04cHD
        Dd04Zhb8hlJppdc534CKCT6lEw==
X-Google-Smtp-Source: ACHHUZ49VvpE0rxW0tNNSGGKMg0HCyKSXjsUguIvGNkHncqKM5NlknUc6CoCheA0Yx8Y5aGbjJqOtg==
X-Received: by 2002:a1c:7711:0:b0:3f1:9b85:e305 with SMTP id t17-20020a1c7711000000b003f19b85e305mr10801478wmi.34.1685365706382;
        Mon, 29 May 2023 06:08:26 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id z26-20020a05600c221a00b003f60101074dsm17862149wml.33.2023.05.29.06.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:08:26 -0700 (PDT)
Date:   Mon, 29 May 2023 15:08:25 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor@kernel.org, suagrfillet@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Enable ARCH_SUSPEND_POSSIBLE for s2idle
Message-ID: <20230529-635a440721fd4e1305cbc9c9@orel>
References: <20230529101524.322076-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529101524.322076-1-songshuaishuai@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 06:15:24PM +0800, Song Shuai wrote:
> With this configuration opened, the basic platform-independent s2idle is
> provided by the sole "s2idle" string in `/sys/power/mem_sleep`.
> 
> At the end of s2idle, harts will hit the `wfi` instruction or enter the
> SUSPENDED state through the sbi_cpuidle driver. The interrupt of possible
> wakeup devices will be kept to wake the system up.
> 
> And platform-specific sleep states can be provided by future ACPI and
> SBI SUSP extension support.
> 
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/riscv/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 348c0fa1fc8c..4bb818035585 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -805,6 +805,9 @@ config ARCH_HIBERNATION_POSSIBLE
>  config ARCH_HIBERNATION_HEADER
>  	def_bool HIBERNATION
>  
> +config ARCH_SUSPEND_POSSIBLE
> +	def_bool y
> +
>  endmenu # "Power management options"
>  
>  menu "CPU Power Management"
> -- 
> 2.20.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
