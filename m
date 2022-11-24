Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18456374F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiKXJTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiKXJTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:19:23 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C4A10FED4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:19:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so792953wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21RtI83U3AWt3cyeCJ2XmHc2ruDDyw09Go561vbFieg=;
        b=7q/OaKPtQ4IeYxQHQaC4aOn7zrvJ3Yr8RQyWvwQwcRu0jouQ1mzKgLwVH1+4CtBlT0
         WqqJ97pJd1e6ipFHKwm0vRnNnfYpGlLhc2UVYB6Y3U09PlrX4FMMxevbcWyLBOcWWvdL
         YPv7ecnuSiy00N+7f+ChYRhSk6+HTph4f7mDMJbWkd6ugWorOzKjS6YqG0JAZHmStWk9
         LcfhTIxE312OlgUaD+s8Rvw/FR0tfahl+821ZbxKeb7qg4IZqU93u76IUVMvn9sRUgy/
         C7aBU3zL62yibHNI9wYEf0E3JQhpAIlj8kMyT9+IlFD31olty3dqCnVlvD1G4WzsbGzJ
         Ccgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21RtI83U3AWt3cyeCJ2XmHc2ruDDyw09Go561vbFieg=;
        b=7lPwZ1BzKu3vkZ6blhDaY1nfXUBjdnJ8ysYUYsM1P8QjIy4shYZe2viQaT1KczRtuf
         Vhi232fJQ1o60pD5+qGCbEY2bxMjlvVnC6f9vd2sY9+Wbd5+frLQUX15Cx+63z6oA56y
         QeIqkISzxeyMlTzCmUkANmIVw3hYOuOuR82f+IlL077Y8fAsLTTKsSO7Kp6ketsp7ZXJ
         LOIUEoev3eRoAhWg2LYSca9RRKq2wrQVZs7ob3KEtfklhDbDbHG3cUszZ1P0Jq//Ff9P
         moRIJ7RppVa3oWJ0IX6N5Y9bqbzUObYVbr+jjECLyC5t+kgECKNczP0cZktw8SbJhm0d
         dgqQ==
X-Gm-Message-State: ANoB5pn7T5lBKhgAfGqBdLzv8j4y4dUQKuGe3+cuRr2GXkIrGG/WDNBk
        94koGiQq5EEGpHbtFQ8FJkQTlA==
X-Google-Smtp-Source: AA0mqf44COThVTh8STo2F/PdfE1hAhOPrq1SYQrMQOFcuboOXsdNStHJxfmCn7TEZsRRJCXahEuHCw==
X-Received: by 2002:a05:600c:3b04:b0:3cf:6fd8:95a4 with SMTP id m4-20020a05600c3b0400b003cf6fd895a4mr22693692wms.73.1669281560664;
        Thu, 24 Nov 2022 01:19:20 -0800 (PST)
Received: from vermeer ([145.224.92.100])
        by smtp.gmail.com with ESMTPSA id b10-20020adfde0a000000b0022e57e66824sm898859wrm.99.2022.11.24.01.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 01:19:20 -0800 (PST)
Date:   Thu, 24 Nov 2022 10:19:16 +0100
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     "Hongren (Zenithal) Zheng" <i@zenithal.me>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>, Conor.Dooley@microchip.com
Subject: Re: [PATCH v3 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <Y383FE6/w2sLd4I5@vermeer>
References: <YqYz+xDsXr/tNaNu@Sun>
 <YqY0aSngjI0Hc5d4@Sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqY0aSngjI0Hc5d4@Sun>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 13, 2022 at 02:46:01AM +0800, Hongren (Zenithal) Zheng wrote:
> This patch parses Zb/Zk related string from DT and
> output them in cpuinfo
> 
> One thing worth noting is that if DT provides zk,
> all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
> 
> Note that zk is a valid extension name and the current
> DT binding spec allows this.
> 
> This patch also changes the logical id of
> existing multi-letter extensions and adds a statement
> that instead of logical id compatibility, the order
> is needed.
> 
> There currently lacks a mechanism to merge them when
> producing cpuinfo. Namely if you provide a riscv,isa
> "rv64imafdc_zk_zks", the cpuinfo output would be
> "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
> _zksh_zkt"
> 
> Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
FWIW, after some rebasing:

Tested-by: Samuel Ortiz <sameo@rivosinc.com>

Cheers,
Samuel.
