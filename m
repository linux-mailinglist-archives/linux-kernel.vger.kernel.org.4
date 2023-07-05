Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A457491F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjGEXkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjGEXkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:40:40 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5E9198E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:40:39 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a28de15c8aso188908fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 16:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688600438; x=1691192438;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjJ1etH05I9YHXWQWBpJ6VH31mJ0fNultV7DPdyve3A=;
        b=ZPXNMMOCkXFYWq0NCdEakfNA1pdk3CcYZ+6f0WHempotJZB83+E/pwCM+2q8IKUq2H
         xdRZIDd51TiDL0p0XvTa0tt0N5VLJedaG+bnWx8ReTf79ecuS467LwMpxMqEOAgA/m/F
         eE0s1hX4puKbZ5vi5TGeKG1II3apVtjHvOv8rdxCf0tyhg6Y4Uf/o8gYUp3Hqm8+oH4R
         KBo0VOySqTceqIazooKeeN/zdE0sz0EHxIxewCJ6HiDK6g3JEpVJLYCkcuZNjcJvwnFQ
         wIV1svBag9hTIYBoNrpo5Tz19PCkfIE7rLC3pf4/Pxw3K6exVKCrJfzuXCwoocgMW8Q4
         r5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688600438; x=1691192438;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjJ1etH05I9YHXWQWBpJ6VH31mJ0fNultV7DPdyve3A=;
        b=fY2a5Vz4ZIzphUTyW73JCLFVBa9WjB+9NB7i7MrQjLcGtZsKzzN0FlpAyuQQN6Bsi9
         O/FHjAUEVQA/1MR6rTcy/wiXfXvkt4DOIN5c+O6Vcdoe5aybt2w/ZYQUai/OIbTWpG+p
         e3pvI/rwGEVr0u+sE/CThNqVjMWEGwHz9S4//6jibN7yq8AesiErytGVe5iBaR5O36Ck
         G9iFF5xPqcgGVi0r+0uwELw+W56lXxpNHwfsYEIAmYIs3zdplfuImJBPqRzkTTR8MVF8
         70yfBoOMA7FEyI7ez8r8/N0/lnaw65lf7kmgyHTDUbdVbTqlY3TMnmuqOaDbtTZ8ytC7
         Pyww==
X-Gm-Message-State: ABy/qLaspYNd2+fXHXmLXJQb5LbcbRe5ptv7sg/vjPdYM131U6z7RoVe
        1LmJo6KPh5swlroytBUYNTbHvA==
X-Google-Smtp-Source: APBJJlFSrRdK40t5yNfAd2Kq7jIZOavCQCb89hoatgZHX68xsPhoKBzQ0NfIO/eMq0SLzY8xZh16Yw==
X-Received: by 2002:a05:6870:9a1f:b0:1b0:15ca:479 with SMTP id fo31-20020a0568709a1f00b001b015ca0479mr733323oab.55.1688600438413;
        Wed, 05 Jul 2023 16:40:38 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090a49cc00b00262e0c91d27sm103433pjm.48.2023.07.05.16.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 16:40:37 -0700 (PDT)
In-Reply-To: <tencent_FBB94CE615C5CCE7701CD39C15CCE0EE9706@qq.com>
References: <tencent_FBB94CE615C5CCE7701CD39C15CCE0EE9706@qq.com>
Subject: Re: [PATCH v3] riscv: move memblock_allow_resize() after linear
 mapping is ready
Message-Id: <168860030756.22647.2239697649687317403.b4-ty@rivosinc.com>
Date:   Wed, 05 Jul 2023 16:38:27 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Woody Zhang <woodylab@foxmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Jun 2023 21:19:07 +0800, Woody Zhang wrote:
> The initial memblock metadata is accessed from kernel image mapping. The
> regions arrays need to "reallocated" from memblock and accessed through
> linear mapping to cover more memblock regions. So the resizing should
> not be allowed until linear mapping is ready. Note that there are
> memblock allocations when building linear mapping.
> 
> This patch is similar to 24cc61d8cb5a ("arm64: memblock: don't permit
> memblock resizing until linear mapping is up").
> 
> [...]

Applied, thanks!

[1/1] riscv: move memblock_allow_resize() after linear mapping is ready
      https://git.kernel.org/palmer/c/85fadc0d0411

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

