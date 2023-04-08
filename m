Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30276DB9A6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjDHIXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjDHIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:22:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925AEFF00
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 01:22:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id la3so531980plb.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 01:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680942169; x=1683534169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GltkJScZYSX+gCVv8fDFnm+4Lcp2TEGrI4CsgsLokKY=;
        b=hBybsKOi8iTMHwZ9Ikc0Cmt6Xe3w4OGcCWqYQIE2fC+MbNbxTarOitAGi2P0ZWwSeh
         iKPtVkSsN3nS0z43OhQRzLzc3JbxJdoNpZOSnkAe3eIiszDGzlx6bdrj8uK5D/3K86IA
         C43fnJLHf24T36c7gg8tfpMjvXDJMaohzqUhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680942169; x=1683534169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GltkJScZYSX+gCVv8fDFnm+4Lcp2TEGrI4CsgsLokKY=;
        b=AtZaDC7WahHWw+TuzqDvfenQBMqWXpP8Fa7pKLdFJxTBpfWJXNWuBspBvE2DXAO0/m
         SzXONLmOO0s60TNz6rILzd5uA8HkoXejIdMh5oY3/ad7NGN5MygpCCupT7MhMXru/aXI
         XhQNRVm/g5zC4EWQ/+WqH4uO82nK7hgQ8O8H1Evukhp1LTYyRpfb7sdN0f+Ri4hUKsxP
         IW7nSReC3uJn6AYSfR8fx6flj0SMKZZohg7zB9FnCGTYS/AH4czXJ2viGadZFRQ/J5Hw
         1t/4oL1mZzVFDRVQQe+Zy79wg10pcovBVBKH7UhNK5gaYp6UR8YOPPpoe4KrPrglkIsj
         /M+g==
X-Gm-Message-State: AAQBX9dAo6yC4WOu5VsrId6pKs5ojYCyn+fsazH+L+cLg2w3NZSYM8oe
        b7gq4MWvr8IPGBFzS3qN0rlJTg==
X-Google-Smtp-Source: AKy350YUW70L/4lbimyDIKZoumBSIx5N8MLRIqbM+/F7jMO+dCl4QxdIyqtRfp3NsLC5KYpYQe4X4w==
X-Received: by 2002:a17:90a:4f01:b0:23d:1a5c:ff3d with SMTP id p1-20020a17090a4f0100b0023d1a5cff3dmr5920279pjh.37.1680942168989;
        Sat, 08 Apr 2023 01:22:48 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001a0667822c8sm4041197plo.94.2023.04.08.01.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 01:22:48 -0700 (PDT)
Date:   Sat, 8 Apr 2023 17:22:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 1/2] Change DEFINE_SEMAPHORE() to take a number
 argument
Message-ID: <20230408082241.GA12866@google.com>
References: <20230405203505.1343562-1-mcgrof@kernel.org>
 <20230405203505.1343562-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405203505.1343562-2-mcgrof@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/05 13:35), Luis Chamberlain wrote:
> +++ b/kernel/printk/printk.c
> @@ -89,7 +89,7 @@ static DEFINE_MUTEX(console_mutex);
>   * console_sem protects updates to console->seq and console_suspended,
>   * and also provides serialization for console printing.
>   */
> -static DEFINE_SEMAPHORE(console_sem);
> +static DEFINE_SEMAPHORE(console_sem, 1);

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org> # printk
