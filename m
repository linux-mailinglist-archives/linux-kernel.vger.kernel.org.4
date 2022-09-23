Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C355E789C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiIWKqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiIWKpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:45:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AC4115BD2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:45:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so5383159pjm.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=A2UDlAx5+SKGAglBHShYwynk/jxqHNOBih9lYYBchl4=;
        b=nQPpeJSVcOIdmLUK3tm9KDhx6mx0LEQX4X1zJqBj3+2M8SFsElYosjzr5dx0z45W0y
         bTPsnwNRKJhuuadx/2+kDEvonHZIGkUknB5U4a/iSngWn+ST4BMMavw1gxvUL4z4vHhz
         N0GSEbSdHc6M5EPAfslm6xe4PaCmvaK3QAU637Wivs7AFZlsrUm3ie1KmP5dTa2Yihir
         8xU/tfd655he1Dtrn25IXbuYRpRZuRu+QUW/1p8oO2aHG+rw9Yi3PpEW0wAQ58qKazIQ
         yttMYEtIm+Kx3ndWaSFhoxneCIGsdibftItsfv7b810brH04kbt+A/AMK8NiVcAxAhRY
         aTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=A2UDlAx5+SKGAglBHShYwynk/jxqHNOBih9lYYBchl4=;
        b=keLIh+qGF0bAT1Mu01QX2w6+2sY6X2aaPf0hmpcSKmlJfUwR1Ys6Z+D8+WR+cja1/i
         Wny8IiVKlLnawSYA+0bTU2kxIqizBegUiAmPqDj0p0VNyd3z1L8O1x7kvSrasG++mfnY
         pHDKyTkk8qtZbTFqubqDR/BhUfa6R7OYhCYtauKbTarvgZ8ORewpDTb4LCS6L26+a8Pe
         0CAFMpd0s59eQCnS3M1GNBA2cKlLLW51ghnbTGcUOAXrMBRxa7Y/WwJ0x8q3PPOsKc9R
         1xWctZUQx4DIjakIzG6ws4iiZJqtSr7Vzbk/VOrygQM4rn9jv29TyM0+pOvTPVnkyLJS
         eBfg==
X-Gm-Message-State: ACrzQf3LfR+KuSi7+9/BMkS85cpTvjUY2nTkgyC8jmfbne9hEilXylnl
        OXJIMs+/Btow8/SWbrD8eJ0F3A==
X-Google-Smtp-Source: AMsMyM4+uJ4wCipj1NfnnfwLCz8OqJgQ320hGpILdENSSZPqeEcBxZX5t5GeFvGQ4uy4YwzEKcN6Lw==
X-Received: by 2002:a17:902:bd02:b0:178:1a1c:889 with SMTP id p2-20020a170902bd0200b001781a1c0889mr7882012pls.107.1663929949846;
        Fri, 23 Sep 2022 03:45:49 -0700 (PDT)
Received: from localhost ([88.128.88.52])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090a7c4700b00200a85fa777sm1353386pjl.1.2022.09.23.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 03:45:49 -0700 (PDT)
Date:   Fri, 23 Sep 2022 03:45:49 -0700 (PDT)
X-Google-Original-Date: Fri, 23 Sep 2022 03:45:45 PDT (-0700)
Subject:     Re: [PATCH v2 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
In-Reply-To: <45de6e04-b19b-4ffe-878e-6ba8123f2aef@www.fastmail.com>
CC:     apatel@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        atishp@atishpatra.org, heiko@sntech.de, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        mchitale@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-9fd8dd19-53a3-426d-9d1e-3093ea6034fe@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 03:35:50 PDT (-0700), Arnd Bergmann wrote:
> On Thu, Sep 22, 2022, at 6:35 PM, Palmer Dabbelt wrote:
>> On Thu, 15 Sep 2022 19:24:55 PDT (-0700), apatel@ventanamicro.com wrote:
>>>
>>> On Tue, Aug 30, 2022 at 10:17 AM Anup Patel <apatel@ventanamicro.com> wrote:
>>>>
>>>> Currently, all flavors of ioremap_xyz() function maps to the generic
>>>> ioremap() which means any ioremap_xyz() call will always map the
>>>> target memory as IO using _PAGE_IOREMAP page attributes. This breaks
>>>> ioremap_cache() and ioremap_wc() on systems with Svpbmt because memory
>>>> remapped using ioremap_cache() and ioremap_wc() will use _PAGE_IOREMAP
>>>> page attributes.
>>>>
>>>> To address above (just like other architectures), we implement RISC-V
>>>> specific ioremap_cache() and ioremap_wc() which maps memory using page
>>>> attributes as defined by the Svpbmt specification.
>>>>
>>>> Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
>>>> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>>>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>>
>>> This is a crucial RC fix. Can you please take this ?
>>
>> Sorry I missed this, I thought it was just part of the rest of this
>> patch set.  That said, I'm not actually sure this is a critical fix:
>> sure it's a performance problem, and if some driver is expecting
>> ioremap_cache() to go fast then possibly a pretty big one, but the only
>> Svpmbt hardware that exists is the D1 and that was just supported this
>> release so it's not a regression.  Maybe that's a bit pedantic, but all
>> this travel has kind of made things a mess and I'm trying to make sure
>> nothing goes off the rails.
>
> I think generally speaking any use of ioremap_cache() in a driver
> is a mistake. The few users that exist are usually from historic
> x86 specific code and are hard to kill off.

Should we just add some sort of CONFIG_ARCH_HAS_IOREMAP_CACHE and then 
ban those drivers from everywhere else?
