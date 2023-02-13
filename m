Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE19C694B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjBMP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjBMP3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:29:21 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EC66EA2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:29:20 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id h4so6009129pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qbx6U9Foe7itForTQRSH0M7JhXvGqxUzThvPIJqkyvQ=;
        b=Rnl3Q3GV0vBzq01wIsrOiPoNkt2sS6amDjnqvSgMSp9EoYYFanD3kywD/bwcZgYhoQ
         iVEdy7M8w2cPp9GB74lylljDVWceNHNSwjlUvikxU/4IjY6msLBIfUWgE7GM+DnUE5q1
         lS0ID3bmvbUJk5Cjtw+psctgIuiIJfLunxFW/o8e0d9HBwM8cdMSU3vDRwXFi1L8M/I6
         H4xrCraBChDTOrKb51DHZBEO7Ghu6bKHtHiXNg/2i9KwXHLKkJk4Ze2qE2BQ7smSgvnd
         7qsLNU6V8jWQTwZ4z2gFtrWxvLPiX9Cd+rzHG9EprjgGLUcoiJqVszh/WSxJ7aCL8X34
         7t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbx6U9Foe7itForTQRSH0M7JhXvGqxUzThvPIJqkyvQ=;
        b=PhdrB8CjhXU/hXxBRGkg6/TClNeATS652mI4A/ksw6WftJNEo3PHVjaJwK7f6aPzxl
         CkLUpFo6bltCyUSewmmvW5eaxt3mgh3MrARu1Y4Ja4zT2As5+rxOQttiLNbcr5kTipEb
         gbZLPqzwNl5XxHEvtu2Cv0bXObpM0hBg+GyJud9Z0hvbxOvYWr+TRqFqFcnjWZl11/Kh
         7P2g2NF0svWRap1+K4BUjx1qLalnA6GhanvgzqCRGdCP4bBiOdQ+1n17CilIau8q/ev+
         3nXgWl4YY988PmUW1nHcUUXVh3eDd8fqYnWBGmpLeE0bYsUSHzFWgKyf3fZ4G6jOIrfs
         eazg==
X-Gm-Message-State: AO0yUKWP72ijg2jO30tAtt2d3VAYC9r4xs46uzew7b5hjWBUqzl+wdi4
        dY0qGPY5vMDBIR3W30bUwvFRIw==
X-Google-Smtp-Source: AK7set/mryfi/4lQw9+pQX73qq0JKVDVfPvKiwXT+/N3NEyBCwVEejzOlKDAEyuzTferOF+iIfbrvQ==
X-Received: by 2002:a17:90b:3ec1:b0:22b:f208:aeed with SMTP id rm1-20020a17090b3ec100b0022bf208aeedmr27624409pjb.30.1676302159895;
        Mon, 13 Feb 2023 07:29:19 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090aec1500b00230a3b016fcsm5157808pjy.10.2023.02.13.07.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:29:19 -0800 (PST)
Date:   Mon, 13 Feb 2023 20:59:11 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 24/24] Documentation/kernel-parameters.txt: Add RISC-V
 for ACPI parameter
Message-ID: <Y+pXR29U9divDWAo@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-25-sunilvl@ventanamicro.com>
 <Y+RUPcCgH48XdbBB@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+RUPcCgH48XdbBB@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 09:02:37AM +0700, Bagas Sanjaya wrote:
> On Mon, Jan 30, 2023 at 11:52:25PM +0530, Sunil V L wrote:
> >  			For ARM64, ONLY "acpi=off", "acpi=on" or "acpi=force"
> >  			are available
> > +			For RISC-V, ONLY "acpi=off", "acpi=on" or "acpi=force"
> > +			are available
> >  
> 
> Something repetitive here. What about "For ARM64 and RISC-V, the
> available options are only "acpi=off", "acpi=on", and "acpi=force""?
> 
> Thanks.
> 
Hi Sanjaya,
-Sunil


