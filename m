Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C342A611509
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiJ1Oqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiJ1OqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:46:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD91EF079;
        Fri, 28 Oct 2022 07:46:10 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i10so3385876qkl.12;
        Fri, 28 Oct 2022 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Eap9vgCOo567XBoaqrJtjJTPOneofbaWXwjzfOt/ko=;
        b=U9faWpM7anfFBwf3lzGgjWdNMgzIZ5MaBAebT8n2v2OUJY1IMy0pME/pjQqGG+QCfK
         7bZUQVJbFh+CxKQQwQ9R5DDx2LWJYCh9bHvuVmZHPmCZPkMxsq4v3oJXCIxrEtU2wyRC
         xULShKwG4KVA/V/y2mm6RzTgzuuWv442t/NvFxc8iUofWRjpiTJmB9Up3DOffi9xJubj
         RR/im5wg2HXy+AthCzdp6tuonbTc2TjHap3B8Gg0F07kxqFgPa43HIxP9DkvUH0elOgY
         5p7rsu2JPPbc+4Yasp+tik93X6+d2C8f2E2ZaK63ox8JmrIPJbDeHqmIGgxLkGGsIsze
         bCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Eap9vgCOo567XBoaqrJtjJTPOneofbaWXwjzfOt/ko=;
        b=Cq43TlEWe94yEgUIxUG65orvDbuQomSNfTN011ANk5mzS6Dlx+YxBL0pcE5r23RfHV
         j9pBdn5ibH0W57vSPqTgk+Y/c1+N2SrUaN7dWhBD6rsSESAhSQVF+lZZSdYxmvqoFgvz
         3rImFseLi2zN5kfHHZj8YBGFExHPUf/pC5P1KK+3XWV4W8bZHPRpaQFQev5v705ZEJQy
         aNod2/KLMmilJk9fse0tCIMcL202eSPcZfNP3AOJFKRELz40kMxXKGbBvvdQFTVRulzP
         +ntMRgmEEmoAp/NSTmgBjjSBpa4Xzj66hdof1yIVP7OInfYL/bYxNI+E0HsAILPz4XN6
         Jhcw==
X-Gm-Message-State: ACrzQf23hYH62+QSgHA0n+u0SxT41vmC81UCw84HYLKq4nJMhwoRsJgI
        GTwSMXwcPFac+I7dR0tI4QY=
X-Google-Smtp-Source: AMsMyM57AgHD6SgkTqjWVZle9kdelFZLgih4OaFJ7oUhyOHHF+SxLTt1A5EyJr2xvmD6EBJZRyNRIw==
X-Received: by 2002:ae9:ebce:0:b0:6f9:ff07:7295 with SMTP id b197-20020ae9ebce000000b006f9ff077295mr5459491qkg.655.1666968369100;
        Fri, 28 Oct 2022 07:46:09 -0700 (PDT)
Received: from localhost ([2601:589:4102:5fd2:5b94:d8b:99bf:707a])
        by smtp.gmail.com with ESMTPSA id x3-20020a05620a448300b006bbc09af9f5sm3032932qkp.101.2022.10.28.07.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 07:46:08 -0700 (PDT)
Date:   Fri, 28 Oct 2022 07:46:08 -0700
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
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y1vrMMtRwb0Lekl0@yury-laptop>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
 <20221028074828.b66uuqqfbrnjdtab@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028074828.b66uuqqfbrnjdtab@kamzik>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:48:28AM +0200, Andrew Jones wrote:
> Hi x86 maintainers,
> 
> I realize 78e5a3399421 has now been reverted, so this fix is no longer
> urgent. I don't believe it's wrong, though, so if it's still of interest,
> then please consider this a friendly ping.
> 
> Thanks,
> drew

Hi Andrew,

I'll take it in bitmap-for-next this weekend.

Thanks,
Yury
