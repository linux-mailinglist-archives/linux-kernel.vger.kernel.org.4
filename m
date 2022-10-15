Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695875FFB9C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 20:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJOSIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 14:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJOSIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 14:08:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285EE4B0DF;
        Sat, 15 Oct 2022 11:08:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a18so4480317qko.0;
        Sat, 15 Oct 2022 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wAaC7lbGaB3AX/Lsftuvb2OO1sJpQJ6Ykn9DFNJXY0=;
        b=FyRwiQ1Kkh2U3R7rwv/cUWgWbhnhVuRAkvLikv3swWoWi+Qni43MwmjlvAl7Qd5YWU
         e3eQ8r4coovbGUfjgmrmah9muM3lMIJqLMPtobpzhigxXHyNURqImNwciQiRzGsAHdHO
         qXOEVFqd/G+S/R1kNsVrId98EksJPTRvXw6S31DLxWwCE/s50meM1rY5rsjT96D1ObDy
         lCH7/wDPhN4Zl3js/rayUXV95GaO+0Ed0I7Aor4TcANC3GM2Q2PJASLmjnpLgyV/gbKH
         KXTHOpPBMJ9ORopJ3VS/8U3M5d4tTN/mU0ZQfTgvUx8AXj2lFRY2L268IjoNTL418YNj
         eMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wAaC7lbGaB3AX/Lsftuvb2OO1sJpQJ6Ykn9DFNJXY0=;
        b=In/ZhKN+YrAA9jxH6S0pMSwyt8+fSRlL+xUPmYYSFId+qeVd2MtQf8cVR5D9dBlSEX
         f367jri8TMqnqNVE+XA/ky5kepNodJGCVkdDOYqX88oXy+mK438Q+UOo3uDwlK5hVHvQ
         DtAfaTX/FEb9jGQu+DKmOWUrFUidI0zMIOmTxJ0m5emBgW+tIZdZXVpnXSyDTt2ORRCC
         O6Jo3o/d8qnZc8FyaOoGX+nrkgwEvI4TFqN3S62TlsDrOvx7DfmtPy49hWOEhtx4e6YN
         TujxPHFTjsCuJsSDljgNs/2Fc6YD/oymZTzVofwgGGGxYoa9I2A7y2IBNDDFap4eH++j
         TxqQ==
X-Gm-Message-State: ACrzQf2zVduqQonrJkeUiWgp2uluPdJj1nopCEc/yql8C+54xiG5RTrG
        nnPIlOW6N9NHgxsoV6sAHF0=
X-Google-Smtp-Source: AMsMyM6RKmR37GztXAcqofHNQn3klZzUQq+GK3VRFWmYfAI4qhzKm9L4cuQOR6HCO3RXlQARuABfrA==
X-Received: by 2002:a37:6303:0:b0:6ec:554b:131d with SMTP id x3-20020a376303000000b006ec554b131dmr2532393qkb.166.1665857330103;
        Sat, 15 Oct 2022 11:08:50 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:2b6d:8b98:c35a:4b7])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a400600b006b949afa980sm5294690qko.56.2022.10.15.11.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 11:08:49 -0700 (PDT)
Date:   Sat, 15 Oct 2022 11:08:51 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Fix /proc/cpuinfo cpumask warning
Message-ID: <Y0r3M+WCMqugVoXf@yury-laptop>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014155845.1986223-1-ajones@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 05:58:43PM +0200, Andrew Jones wrote:
> Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> start and next seq operations implement a pattern like
> 
>   n = cpumask_next(n - 1, mask);
>   show(n);
>   while (1) {
>       ++n;
>       n = cpumask_next(n - 1, mask);
>       if (n >= nr_cpu_ids)
>           break;
>       show(n);
>   }
>     
> which will issue the warning when reading /proc/cpuinfo.
> 
> [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> 
> This series address the issue for x86 and riscv, but from a quick
> grep of cpuinfo seq operations, I think at least openrisc, powerpc,
> and s390 also need an equivalent patch. While the test is simple (see
> next paragraph) I'm not equipped to test on each architecture.
> 
> To test, just build a kernel with DEBUG_PER_CPU_MAPS enabled, boot to
> a shell, do 'cat /proc/cpuinfo', and look for a kernel warning.
> 
> While the patches are being posted together in a series since they're
> for two different architectures they don't necessarily need to go
> through the same tree.

Acked-by: Yury Norov <yury.norov@gmail.com
