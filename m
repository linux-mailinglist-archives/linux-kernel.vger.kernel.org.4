Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D336EFEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 03:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242686AbjD0BHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 21:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbjD0BHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:07:15 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A33FC0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 18:07:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115eef620so1328657b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 18:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682557632; x=1685149632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWxN0HdpqE3nEcb94tpVaWre2EJjXxzqj1V4BeiGr4k=;
        b=BrybM128LAejQm/ZuKmsObyOmzrekJywBAYczMNylmOnjlsv2GAVaZnzT7mtEehlbs
         edNstU+IQ8nuuM/bsPh5eDUexDY5FDVJYEktDHcOJ/2R7qmryTU4RvyKMs4FwdGWW64y
         yxgZC7mizG9nQokYNIColNjB55kxHhnxOZIXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682557632; x=1685149632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWxN0HdpqE3nEcb94tpVaWre2EJjXxzqj1V4BeiGr4k=;
        b=iWW7lDlnxKTjRoKMlKPN8puiLDr7UgPnZEVi5vtrS670rtcJPdBInfV5bFBEES/mHs
         h7pN49nfqZUAVtO47RVVJ/X4WpUQuff6oHEoqANIH8fy41TTA57/jKhQSu0lhJVnOI92
         hsghuQQaE0ocK5XbFV33skSwihO7yt5Pyh3o5wxnvQWT2KIB9SmWDdWmSCtEUJIQag5l
         dOKxTUWc6gMVV7RAOOdr8KmLqxEWdUxKm1Ct7J1IXlpKy89secSCbw31VWmChFLXfUkR
         sQvu2nV+t+Sfk67r5m9tbPTWm2oo84T+a7uaYZben/rMazk99qg+ymss0CVHh1wLALYR
         SSnw==
X-Gm-Message-State: AC+VfDzjmOMXMldN2MDUidYCP+NfhGvnCqGfphxoyqzHcK7bpdyzblqa
        o5H4k/KzNEy7ufEQj4wHw7Ij/A==
X-Google-Smtp-Source: ACHHUZ5IIgPQ9KvrurE6szSH0jhOKyONrDVq5eP9wwpRhBRRcdZRXDlJ8e3/Jpzh0f9dZTFLmYcWVg==
X-Received: by 2002:a17:902:e74e:b0:1a6:7ea8:9f4f with SMTP id p14-20020a170902e74e00b001a67ea89f4fmr153135plf.26.1682557631694;
        Wed, 26 Apr 2023 18:07:11 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001a5000ba26esm10448485pls.264.2023.04.26.18.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 18:07:11 -0700 (PDT)
Date:   Thu, 27 Apr 2023 10:07:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 18/34] mm: Update vma_iter_store() to use MAS_WARN_ON()
Message-ID: <20230427010707.GG1496740@google.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-19-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425140955.3834476-19-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing Petr

On (23/04/25 10:09), Liam R. Howlett wrote:
> +	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
> +			vmi->mas.index > vma->vm_start)) {
> +		printk("%lx > %lx\n", vmi->mas.index, vma->vm_start);
> +		printk("store of vma %lx-%lx", vma->vm_start, vma->vm_end);
> +		printk("into slot    %lx-%lx", vmi->mas.index, vmi->mas.last);
>  	}

[..]

> +	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
> +			vmi->mas.last <  vma->vm_start)) {
> +		printk("%lx < %lx\n", vmi->mas.last, vma->vm_start);
> +		printk("store of vma %lx-%lx", vma->vm_start, vma->vm_end);
> +		printk("into slot    %lx-%lx", vmi->mas.index, vmi->mas.last);
>  	}

Any reason for "store of vma" and "into slot" to be two separate
printk()-s? It's not guaranteed that these will be printed as a
continuous line. A single printk should work fine:

	pr_foo("store of vma %lx-%lx into slot    %lx-%lx", ...);

The line probably needs to be terminated with \n unless you expect
more pr_cont() printks after this, which doesn't look like a case.
Additionally, do you want to pass a specific loglevel? E.g. pr_debug()?
