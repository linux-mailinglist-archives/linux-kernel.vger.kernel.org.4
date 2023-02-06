Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9E68BC40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBFMEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjBFMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:04:48 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899FBB446
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:04:47 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so4588651wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 04:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hga6+jXWGD3JgwJgRFXeH2zeYgheW8Avd9g0cfccau4=;
        b=SocYrnMChbn1Wrrg0A4ZJNO8ixxNP+C7S4MwlhwE5d5xTpwIlUAkGv9ABfVYysfgP2
         4i5NWzTlvpC5BQ27M8A+pMpAReAT1Aaw7bSxWmdhG3crlYgOJNHTl3znnib1+Z73lxPn
         /lT95gJ9FRS0SjkKpdliROt+Uyly1sSYfWwWoGI/3QGhZLdY95KGTlhrekyIRigyzD2B
         uTwv+6DrbZohixJdZxUPFA4mJbaS8pHxAlrUIO8fI+uWpw14DQX/ncXU2kw0a7oznUo7
         kl9VGlvaEW9AIqJADvrJq4864e2lblyoLNmxvnj/YaAnFY0Zbh9CNTjFIJYWoQIcDfrj
         FEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hga6+jXWGD3JgwJgRFXeH2zeYgheW8Avd9g0cfccau4=;
        b=lm8OvEho8JoCKOtVxoZpOvIjpd4uaM6J8vf8BuzlnjhhPPOELbm/6MHGO9dZHH1qZ+
         AfceKMkwqIMIXO5bygGqDEg49bLi0zznatKUjYGv07f/S3jO4Tj8sle2cpBSi6oyIlXN
         XuNN1v4ZtLem72HB3pjZ+sVwTfZd1J/yytQDGUIt0UvX3Cbzm5KMKxe59HWbKQp/4pVk
         E1oPRv6iFTw6FiRaOhPiQTMJ/c2AzKcSyVK3gpG0VtnxdA48Eic1EyZ2AB8sMlp5gjRE
         Ljpz+dKCoNnKslCZ2ZYb/u/JWu7AF4mvqp8b+ZEhW7YqK7vG0uzxj4mgXLcg9q/xmSZ9
         pz8Q==
X-Gm-Message-State: AO0yUKV1GGdSAkV/VQLyaY2AjJ8NNweKsD7avF19iEtcK2+EnY7WtllS
        DGqM5GkQsuTvhalbIJCniL1Eag==
X-Google-Smtp-Source: AK7set/7yaQkxD40Vvi6D7UEvw2RxA5hFBCrhMU2JH60e5v603guyRgl3iQqmUqEY/9LgDZ82G8vAg==
X-Received: by 2002:a7b:cd17:0:b0:3db:14d0:65be with SMTP id f23-20020a7bcd17000000b003db14d065bemr18464580wmj.34.1675685086178;
        Mon, 06 Feb 2023 04:04:46 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d4907000000b002c3e306d3eesm4347131wrq.17.2023.02.06.04.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 04:04:45 -0800 (PST)
Date:   Mon, 6 Feb 2023 13:04:45 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 13/14] RISC-V: KVM: Support firmware events
Message-ID: <20230206120445.6tlsvy5fsawn475v@orel>
References: <20230205011515.1284674-1-atishp@rivosinc.com>
 <20230205011515.1284674-14-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205011515.1284674-14-atishp@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 05:15:14PM -0800, Atish Patra wrote:
> SBI PMU extension defines a set of firmware events which can provide
> useful information to guests about the number of SBI calls. As
> hypervisor implements the SBI PMU extension, these firmware events
> correspond to ecall invocations between VS->HS mode. All other firmware
> events will always report zero if monitored as KVM doesn't implement them.
> 
> This patch adds all the infrastructure required to support firmware
> events.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_pmu.h |  17 ++++
>  arch/riscv/kvm/vcpu_pmu.c             | 141 ++++++++++++++++++++------
>  2 files changed, 125 insertions(+), 33 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
