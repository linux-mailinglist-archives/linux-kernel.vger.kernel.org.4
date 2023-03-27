Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001F86C9FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjC0Jjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjC0Jjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:39:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F346BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:39:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r11so33353161edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679909982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4w0LfZxV5gGkIvt3krujIxED/ZFU4CmkEbwpWDDfN9M=;
        b=E1SkeH1Z1buglgC+NNtXnvpC93AjrvqcWBnjND14dCcXq6i/LOkkD/KCnOdHK9ffjQ
         +FDXfynnNTMv68vHz3XCzlikO0Cx7su96Kj2KdRdAuZMwgk+/KI91e96elRbM9GpyC/s
         tFjsgiPlPeDRx4PnFc8Zku5/4t/NawHFXjN0kxB5X4lZOs8SVVlFOlZZRmXJiLykpr5d
         cVxR/p1z7rPSrDn4SP+4N3xMoZWJRG/GMc6WVy5myNPSnZ8HIfR0h7uZSWIw2+iQHqat
         kAu6wSXdawVYEUTFtgoa10sFbTQLVLPBN3V3oFMfzQtQF/B8sKki1EQ2IqH8jNxyvWX/
         6yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679909982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w0LfZxV5gGkIvt3krujIxED/ZFU4CmkEbwpWDDfN9M=;
        b=yO4ESPPV4YNX9kxEEf/9X7vlnFB6EALPHiOHJ1C0GCNC4LWs55tRTGtEtrVV80PqE1
         mZZQW6jVrRSP5hCgl0psTOCRwNmA97aBmgUA0kRXeJBq0oJ7FdU8RHQC1hDVLqE2hi+q
         lOIhSazWv7lduiSH6I059eQ3z0DNnshWtvWGlxTSoQ9fSb1ibJpqafIydPrp7ChuBede
         9Fw2oU3jyJxTmKrTW6eRYukulNMOiKHmNZQoVeddNVy+yKKI6m3NipR08lZcO1ZpkfNs
         lYnqkT6ws4tMTc0cvEVnlN0ram5RLgKV9bN0M+EMyQK05iqcI52QnSmtP7n9j28qTu5p
         53Mg==
X-Gm-Message-State: AAQBX9eNucIl1PDLmudiCBQYHjtVCnWOFhtFE1JtC6winzjuTBlhhvua
        ixy3hSBXnZj1LVlsGedMSH6umg==
X-Google-Smtp-Source: AKy350Y8/SsxbaZDej/BKzJeejjyFYUsPO3oWonL2cImHpeJe6RjpY24fLH7mPEJt4nmazcjeFiM+g==
X-Received: by 2002:a17:906:380a:b0:93b:943f:6261 with SMTP id v10-20020a170906380a00b0093b943f6261mr11485304ejc.74.1679909982354;
        Mon, 27 Mar 2023 02:39:42 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v14-20020a1709063bce00b0093344ef3764sm12028358ejf.57.2023.03.27.02.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 02:39:41 -0700 (PDT)
Date:   Mon, 27 Mar 2023 11:39:40 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 2/3] riscv: Move the linear mapping creation in its
 own function
Message-ID: <20230327093940.7cxqh52mwiaibzeu@orel>
References: <20230324155421.271544-1-alexghiti@rivosinc.com>
 <20230324155421.271544-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324155421.271544-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 04:54:20PM +0100, Alexandre Ghiti wrote:
> No change intended, it just splits the linear mapping creation from
> setup_vm_final: this prepares for upcoming additions to the linear
> mapping creation.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
