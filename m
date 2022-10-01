Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3695F1D8D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJAQVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJAQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:21:15 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE79C7D4
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:21:11 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1318106fe2cso8711857fac.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BjGEI2Q3qIywabIEfO5bHYshDCg/ZVvlmZqpK+c+QVo=;
        b=A5GmFfEbuKHn7m9GIX8PanctkMfBF4uXYMXela4t1/JWbGru3e8kIugb0MdASV1Ysr
         u1uXDS4OZTz2ve6/UKxrdNycGkz2Z3h78eFRbqJDFlTYsSjBLzT5VrCVm62301sG/hlK
         dA3gSkjdV80lkaxEjhtgSWbFFvhmwsgxRsQ/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BjGEI2Q3qIywabIEfO5bHYshDCg/ZVvlmZqpK+c+QVo=;
        b=bg9v8FUWMGKaHEYh+RURuS8KwX+rfDvybRYaaOhu97u35Z5thCvzmGBP+U1K8quctZ
         6A8e+fd5/Jy3rb5SpsZwhG3dr0T3iQoRBZ2zYjbSj53VWRvNuMa+OJ9xOIMz0jDpgvRW
         93wrma0qRxuRn4BeRTiP3ozX6anQ2/UrsibsHLSVV3a0FuvQMbZSeZbkXzQWNRVCi0uR
         lJsuMaYuH/QL5KSdjoYcI4ilzHdTcNq4U2W7DLJKEAgzuAWjZhyzQCDupoeRLoM7grgk
         osp4sFvM+Rium7sfGNRI7dgl2z9UbR5XsDKIaqpHHBzcr8jfqGqVmPoC9woG9gr8wWdw
         VjRQ==
X-Gm-Message-State: ACrzQf0uWzFlaSibIIeRR8ogUcJFJHDvX15tW7m/vj4n2DVMoYLOFyK+
        LpdrZhqzoiAmftos0CPFym6/Cfpjc8WnjA==
X-Google-Smtp-Source: AMsMyM4Na/S5UrZf7pt0kG4XAO2lxxQp9/PRwAnmWE1vemkkPiB1NbMSv66ErnVy4c+/v9w6HNQ4Hg==
X-Received: by 2002:a05:6870:f692:b0:131:e7b1:b699 with SMTP id el18-20020a056870f69200b00131e7b1b699mr1655186oab.133.1664641270689;
        Sat, 01 Oct 2022 09:21:10 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id t188-20020aca5fc5000000b0034fbbce2932sm1249065oib.42.2022.10.01.09.21.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 09:21:09 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-131fd187e35so5032541fac.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:21:09 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr1731928oab.229.1664641269015; Sat, 01
 Oct 2022 09:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <YzeclACdH9JmaRza@yury-laptop>
In-Reply-To: <YzeclACdH9JmaRza@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Oct 2022 09:20:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiK5wyj58x3uvt+otsO9=79N13OO6Nf57DFVYO=QX==ig@mail.gmail.com>
Message-ID: <CAHk-=wiK5wyj58x3uvt+otsO9=79N13OO6Nf57DFVYO=QX==ig@mail.gmail.com>
Subject: Re: [oliver.sang@intel.com: [cpumask] b9a7ecc71f: WARNING:at_include/linux/cpumask.h:#__is_kernel_percpu_address]
To:     Yury Norov <yury.norov@gmail.com>
Cc:     lkp@lists.01.org, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
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

On Fri, Sep 30, 2022 at 6:51 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> The commit  b9a7ecc71fe582e ("cpumask: fix checking valid cpu range")
> fixes broken cpumask_check(), which for now doesn't warn user when it
> should. After the fix, I observed many false-positive warnings which
> were addressed in the following patches.

Are all the false positives fixed?

I suspect that to avoid any automation noise, you should just rebase
so that the fixes come first. Otherwise we'll end up wasting a lot of
time on the noise.

This is not that different from introducing new buil;d-time warnings:
the things they point out need to be fixed before the warning can be
integrated, or it causes bisection problems.

                  Linus
