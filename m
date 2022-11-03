Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7D0618638
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiKCRbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKCRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:31:33 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83BF5FF6;
        Thu,  3 Nov 2022 10:31:32 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-12c8312131fso2966008fac.4;
        Thu, 03 Nov 2022 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvZ5+E5qu4GOYga/FqvgfxEG1c0dU8d73zf2fP+htGs=;
        b=iPqtLSq3l2qHplG860uNDrfYq9b0lZFbxHP6kSO5WcDFeNj74LgawQ3XHbriQnJzId
         91YDCFJ926vJ7L1jeQcvLnKN5IicgY26QvhLOUAx6NfuqsczuDo2+p95tiUE3Y3d3p8R
         Wb3AVYnqzTL0X7haZY7BTZ+oilwvxbeF6lVkgFNf8aMcvJgkuEefwy01BOsLK5VvAvzw
         YLeXvyd9tsE28Dp154l4LlczkE6gYboihsErhJGgG+F9jOSH92X0IzDV0rfpYNgoQqIc
         gaqjq4mqtFEpLgO3pJNfAld17zV9i0u6xe8AK0ilXIHLGax8f5r/eP0/Q0saTHwnR/aB
         J0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvZ5+E5qu4GOYga/FqvgfxEG1c0dU8d73zf2fP+htGs=;
        b=2cKtd/CKZt6gL9rIAC1FRLVoogtvi9oWGn2U8dOKSDqZs5a88HIdFUYhygw1Xjt3ah
         KEzmKoua6HHaVi1MP6VmTLSPKj+nvBRSjHJzVcdaN2eaAPaBPwQXQ+/4l8wmw0fqrzLg
         lHiLpZ4+s4/S3jNAPdi6CD1YWGrVW2eiwp2cl2dxT/YOLkBCQq2VfG293JQRj1y0m4uv
         8IMyyBYBTzSRQWuKX7ecdDBnJLGbUPQAijrEuQsToekstgAbn9pCA1N1dtznc2tz1N8O
         oAKafZbXxWune2K+68cOA3PrKjnnMzcPxo0ltDMfHRFbT1Nm2jDhIZnXJhFgmpA/7BL1
         Cmmg==
X-Gm-Message-State: ACrzQf0bJK6RXHxiVWv92/jqUkgEz4MBqB3MdDgNFQl/ggkYzu2Gfx6D
        wVgDN6LnkM+4I1aG4K69ehA=
X-Google-Smtp-Source: AMsMyM6fJYEOKNxJ1D+xB246uqRaGV2DX2E0qNo3z76RYRYleK2EIFTcmwXSUrFyVWM6R7buKJ49fQ==
X-Received: by 2002:a05:6870:31c5:b0:13d:a04a:6ecf with SMTP id x5-20020a05687031c500b0013da04a6ecfmr1655565oac.101.1667496692226;
        Thu, 03 Nov 2022 10:31:32 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id r13-20020a4a964d000000b00425806a20f5sm430333ooi.3.2022.11.03.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:31:31 -0700 (PDT)
Date:   Thu, 3 Nov 2022 10:31:30 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y2P68sfCJMvhKmhj@yury-laptop>
References: <Y1v+Ed6mRN9gisJS@zn.tnic>
 <20221031080604.6xei6c4e3ckhsvmy@kamzik>
 <Y1+OUawGJDjh4DOJ@zn.tnic>
 <20221031100327.r7tswmpszvs5ot5n@kamzik>
 <Y2K6clNJBn0SbWU+@zn.tnic>
 <20221103125945.lrr5oxxmylwpam53@kamzik>
 <Y2PX9GfxWYh6+XGT@zn.tnic>
 <20221103153404.uh77nrdkowrxj6cr@kamzik>
 <Y2PsvvOWVs9ZLBsp@yury-laptop>
 <Y2PxAiJ1yNzcUSgs@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PxAiJ1yNzcUSgs@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 05:49:06PM +0100, Borislav Petkov wrote:
> On Thu, Nov 03, 2022 at 09:30:54AM -0700, yury.norov@gmail.com wrote:a
> > Callers should pass sane arguments into internal functions if they
> > expect sane output.
> 
> What internal function? It's in a global header.
> 
> > The API not exported to userspace shouldn't sanity-check all inputs
> > arguments.
> 
> That doesn't have anything to do with userspace at all.
> 
> APIs exported to the rest of the kernel should very well check their
> inputs. Otherwise they're not APIs - just some random functions which
> are visible to the compiler.

Let's take for example cpu_llc_shared_mask() added by you in
arch/x86/include/asm/smp.h recently:

  static inline struct cpumask *cpu_llc_shared_mask(int cpu)
  {
         return per_cpu(cpu_llc_shared_map, cpu);
  }

It's in a global header and available to the rest of the kernel, just as
well. How does it check its input? Maybe I lost something important in
per_cpu() internals, but at the first glance, there's no any protection
against -1, nr_cpu_ids, and other out-of-range arguments.
