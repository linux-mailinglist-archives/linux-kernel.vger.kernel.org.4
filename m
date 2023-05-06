Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C956F8E1D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjEFCrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEFCrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:47:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3367D421D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:47:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaf2ede38fso24050435ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 19:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683341238; x=1685933238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhRc7hxJK3NflZ5uLGJt/010eV74i1aoQ3Uj4u0l88w=;
        b=eyXNX2kQL11K66q87Ej5uZ7syf6xfwhRO+NdWSA/RSRGtqxYTZV9sAsfmHEp8Cgin9
         1OjAfa0OFgoFgNVkgrATzij4T/zNAPj5LXI9WgUgpDnhgrIwn+d9E64L47HQMul/xpfp
         9SdBXScQ8LoEd+91R1Mcpvd/V/oIS8LHFgTBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683341238; x=1685933238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhRc7hxJK3NflZ5uLGJt/010eV74i1aoQ3Uj4u0l88w=;
        b=kHAz5byHzpCNJNSopJjr3LBE75oNs6SXNZwVx5h1s7/t8UCv+L/UnscI8moK8req4s
         u1/gO3Ync4rLS+BWD9e0yWYA76gbj+d0fl7ul3aKIGP9kbYVBAXN1oTih99JpO7rDaNS
         jvq5RvSF1KKCVvdhxSDaCvjCCRNIas11IsHOpYx80rq60F3SKekrQS4y7K91Q4kSk3FH
         /WQ66hhBssapsnkrqG4Zmcblm75VfIjFq37dOuOsqWPDa89e1G7IoJWGKste3q4VU7W0
         PMJ2BWKV7voj+dBpbs9XU/rZjHrTqBhtGq2tt9ttCMDQ1iWoDGpPxk38v2ZFMZVTkMIZ
         G67w==
X-Gm-Message-State: AC+VfDzZi5lCieABq2LBj9M6XV7HOPHcEY4cE8OAVmiW4/tCX9orDrRd
        OH4txOQKUPMu88BiyxT1WZfFwg==
X-Google-Smtp-Source: ACHHUZ64bANpxYNZ66wYuGU8H8p6zZwlPlSUxo0POK60VJ+/C3NB6KwGAgsEhXrbS8QP9Js4Yo3M4w==
X-Received: by 2002:a17:903:244c:b0:1a1:bf22:2b6e with SMTP id l12-20020a170903244c00b001a1bf222b6emr4446652pls.43.1683341238689;
        Fri, 05 May 2023 19:47:18 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709029b8e00b001a687c505e6sm2420783plp.232.2023.05.05.19.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 19:47:18 -0700 (PDT)
Date:   Sat, 6 May 2023 11:47:13 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 18/36] mm: Update vma_iter_store() to use MAS_WARN_ON()
Message-ID: <20230506024713.GB3281499@google.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
 <20230505174204.2665599-19-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505174204.2665599-19-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/05/05 13:41), Liam R. Howlett wrote:
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
> -	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.index > vma->vm_start)) {
> -		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
> -		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
> -		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
> -		vma_iter_dump_tree(vmi);
> +	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
> +			vmi->mas.index > vma->vm_start)) {
> +		pr_warn("%lx > %lx\n"
> +		       "store of vma %lx-%lx\n"
> +		       "into slot    %lx-%lx\n",

A minor side note: we usually prefer to avoid breaking printk() format
strings because it makes grep-ing difficult. But in this particular case
it's fine, since all the format sub-strings end with a new line character.
