Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADD6F8E1A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjEFCmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEFCmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:42:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F60D7AB4
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:42:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24eab83867dso2248799a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 19:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683340960; x=1685932960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXa2WM+Ux0ryWdk9v/juQWn6Ta5HKrRkFJpku8aKUgk=;
        b=Fo5KIb/ybvy6rjlKOBOEZWQrtygKZ6pR2WFuAgcmSwR3uXcZ8W9DY3wD2C+RZnRG+c
         HuNjUIYg7lEZfX3o+fPgIJXm97dKnc0fnFz8QCEVogqv1d8MEVm8DSpNS4IWCXwtL7JK
         l/aNzYgIqDRF0xmVBJcjCCj9AHSwM/VamsvPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683340960; x=1685932960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXa2WM+Ux0ryWdk9v/juQWn6Ta5HKrRkFJpku8aKUgk=;
        b=e+XN7o8m6bT8aOIFSQyIBzrNEkYtK1gfpj+eiuuTdo3O+HeVKjPblIn5G5qLcHEXk7
         ENBzZSR4LO2UaXyHXYSVKfZCCCeaEunkad8PWC+u53gOXo1f6lmZrW9zNFwvbCFEI2ll
         LpFQKw8oGCLjAzglK7ccBk4SMqNTpr8pMozCmi40YpK8AdknFGNHNt8mw6EGYL2dbfn/
         i4s3IpqGNxXF6PpJ5xTX3LRTnDQ7S5P/5UabIqU3o8Iyu4khW2qybdgYy+JbWxOO/JwY
         yUo+wjtsmoiHHQrL277eQtBB5RjXkhjigmxZh/EFm3fJalrhJfwU1Lm2X1j5QJwlQRRB
         1KhA==
X-Gm-Message-State: AC+VfDyMZaDTr43FLYcXxKNNVrd7CNBALd6Ld0bhat9nfk6K4pfTX5tP
        Ijte0detz7JQt7O72Ph3mnbziw==
X-Google-Smtp-Source: ACHHUZ5xJN8/SU9MRkAVlp117mlbDCf+WBPkOF66GWTYbp3rJ87qYpAVbZ4o5Zcxc0K585Bxj/h2Ng==
X-Received: by 2002:a17:90b:190f:b0:24e:16ae:61ca with SMTP id mp15-20020a17090b190f00b0024e16ae61camr3441776pjb.34.1683340960500;
        Fri, 05 May 2023 19:42:40 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090a7c0500b0024e4f169931sm5530319pjf.2.2023.05.05.19.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 19:42:39 -0700 (PDT)
Date:   Sat, 6 May 2023 11:42:35 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 18/36] mm: Update vma_iter_store() to use MAS_WARN_ON()
Message-ID: <20230506024235.GA3281499@google.com>
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
> MAS_WARN_ON() will provide more information on the maple state and can
> be more useful for debugging.  Use this version of WARN_ON() in the
> debugging code when storing to the tree.
> 
> Update the printk to a pr_warn(), but this will only be printed when
> maple tree debug is enabled anyways.
> 
> Making all print statements into one will keep them together on a busy
> terminal.
> 
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
