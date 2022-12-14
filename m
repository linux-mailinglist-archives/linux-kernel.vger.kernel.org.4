Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4317564CF0E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbiLNSBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiLNSBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:01:36 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0013812AD6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:01:34 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id v70so3282336oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=in0+4T7zsT1szAcuDpgB7UD6oKEoJr8ruNZ5Dg7YtpA=;
        b=NX5Fj1ezfKxiLPTzV0af2fewGQYUkwGctpfcN9Pi2mGgyBt01CD1BBSVTY/sivXdF3
         7kyzkC1cFP0Z0AI21bt1bJXSFE+tFvY1zBuKuOifzVtQSZSGmeKciSjqqtlI7i1tlFBp
         4a4HJafAE3yvStOb6KSBezQvMUaRzDoFMs7/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=in0+4T7zsT1szAcuDpgB7UD6oKEoJr8ruNZ5Dg7YtpA=;
        b=BaaRDVHJDtHvkZrvVprZ49TZkA/gG+ceLv+Ie0ZnaQ7Vf3XbFZA+YmxyAacxBR18fQ
         8xAgCW3ez5cOWkLNpC/PjGNQxHB+FAzN8YNuLGz3/SnEyrxK0j+vBs0tr7wXwXsfGb9K
         SAkbPd5t0Mb0mB30P9vAcRBor9yJPvfAeqF+qXUrU8uAjHyXVsTwQ2wRf+TsQMnSNj0g
         7Iv/tgRBW5WRjE5UYD05mmtqKPHfMfkfhcowDVKcfnVwHygG9VgnGpBb75QgPfvGFdDR
         YGrwbQaSwiaC33XIyPMsAxu+B7QkS0nPo7Ef7yPQ1FLihSU4OGPIMc5nc5JJ/FclrPMq
         Y0Ag==
X-Gm-Message-State: ANoB5plTJKhm3+AIOOvxQzVlEu36xOmk+2BXANTwcz4JhGZbINbsLGUZ
        vHPptITL1qucuqk7WCvJq9aur5ba5XzvPC25
X-Google-Smtp-Source: AA0mqf6OcmpDC3XwbNGQPcuQkLfG+oygUP8JuXgIizWuQh7XGk88QSOngdSLFC0JE7K5Gx4CGMJIJg==
X-Received: by 2002:aca:1110:0:b0:35e:d1c4:b149 with SMTP id 16-20020aca1110000000b0035ed1c4b149mr529429oir.57.1671040893989;
        Wed, 14 Dec 2022 10:01:33 -0800 (PST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a249300b006fc9fe67e34sm6107487qkn.81.2022.12.14.10.01.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 10:01:32 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id p18so1610742qkg.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:01:32 -0800 (PST)
X-Received: by 2002:a05:620a:8420:b0:6ff:812e:a82f with SMTP id
 pc32-20020a05620a842000b006ff812ea82fmr638686qkn.336.1671040892215; Wed, 14
 Dec 2022 10:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20221213233050.GA218218@bhelgaas>
In-Reply-To: <20221213233050.GA218218@bhelgaas>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Dec 2022 10:01:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=whC3-Q_-gt3NU8cfY4ivs2CsaON8Ci0aiD6qvT1xzVL=g@mail.gmail.com>
Message-ID: <CAHk-=whC3-Q_-gt3NU8cfY4ivs2CsaON8Ci0aiD6qvT1xzVL=g@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v6.2
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 3:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> You will see a merge conflict in
> Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml between these:
>
>   5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support")
>   4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names common properties")
>
> 5c3741492d2e is already in your tree via arm-soc, and 4cc13eedb892 is in
> this pull request.  The resolution I suggest is to use 4cc13eedb892, which
> means we'll lose the addition of "ecam" from 5c3741492d2e.

Heh. I only read this part once I had already resolved that thing differently.

I dunno, I used my own - possibly bad - judgment to add a case for
that 'ecam' thing under the vendor-specific list.

That was very much a "monkey see, monkey do" resolution, so some DT
person should check it out and possibly make fun of me and my dubious
ancestry. Rob? Thierry?

                  Linus
