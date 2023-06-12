Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4356572BEE7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjFLK1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjFLK1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:27:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E0B36E3B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:06:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b1806264e9so24154245ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686564308; x=1689156308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBOb/U0RqfC5AxKUFvKlMDVQJb0zRdeSC6F/8xGEJFw=;
        b=LBQ3BljnQGxIzf87eWYR5E5Qak8frDZ78Lod4++Bh8iZ4VII5iXjAoj4BhKBnrAk3J
         veJthmMisy1tJoT50qACfrqjypIPLD+ncUDbLjtIo20RJlhRXrzggnO3OEOyJrVKrQ4K
         Az1yBCopvMuCCnRUlcXpb1eK3v2QNQ+FzU5yocBH9KhR3La53av/CM5HSHJQULbHIi1q
         dm+pkp9bjgLGDeNDTFXDXC6IQKsgr7g/8zy3lgqZeBPh166HySqNtzgFBLdAVTvlytJI
         f1RUtjZwqTlwXSgSoiPZLY4dQsiS19fLQYwckxmdM1EpWf30zOf/bm9JbCuSD0soEsXK
         uXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564308; x=1689156308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBOb/U0RqfC5AxKUFvKlMDVQJb0zRdeSC6F/8xGEJFw=;
        b=MUoEeGtIq3V/hTr/OTw6F2l1JCDKqZQ130dPmI0wZs4/RtwzAKk/GgF9gO5oZPBBbN
         +ZQTWQWmkkCzoRlMuarftfrsUG9W9R5c2QS86A+aVYZRyQSAmpfoJQbz5vxV1wgB+6Qv
         m74/fYKthEH6VyN/A+0KyeS4whXF2yAPFHA6BhG9TVg376qAxC5GzxFCqSznWUBHFt77
         5fdIJUBYNFMrMrw/A1auwvZ4LdRmPqZjswoU7ZK4RBiVQ0t8yj8rxsJ1fIzUFEF73WJW
         viQOJVL4bxfq7EjNdJHNnKeR8GTndESwasR5T+n4r4rnRJZdvQIeFcdE6MR4/Q8gQoQP
         +C9g==
X-Gm-Message-State: AC+VfDzyqJnVP2j468t5NzpWOshjLaSdfXC97XLAEihidDqxUfMA7eRO
        njz4LBxLw5F7znQMJME9OQARfQ==
X-Google-Smtp-Source: ACHHUZ4KCzP/G4lYu52oALkIYWunkw8ZVaCyIXstDCU3a451MIoJ4eGWvKOqUJaHFn+xmbS8zXrglA==
X-Received: by 2002:a17:902:daca:b0:1ae:5b7:e437 with SMTP id q10-20020a170902daca00b001ae05b7e437mr7314292plx.4.1686564307842;
        Mon, 12 Jun 2023 03:05:07 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-201.hinet-ip.hinet.net. [211.75.219.201])
        by smtp.gmail.com with ESMTPSA id u24-20020a170902a61800b001ae5d21f760sm7832848plq.146.2023.06.12.03.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:05:07 -0700 (PDT)
Date:   Mon, 12 Jun 2023 18:05:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 1/2] perf/core: Bail out early if the request AUX area is
 out of bound
Message-ID: <20230612100502.GE217089@leoy-huanghe.lan>
References: <20230612052452.53425-1-xueshuai@linux.alibaba.com>
 <20230612052452.53425-2-xueshuai@linux.alibaba.com>
 <20230612073821.GB217089@leoy-huanghe.lan>
 <5fe7c14e-4dd4-3e7f-ece4-75da36c3b6c3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fe7c14e-4dd4-3e7f-ece4-75da36c3b6c3@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:35:07PM +0800, Shuai Xue wrote:

[...]

> > Furthermore, I believe the AUX trace pages are only mapped for VMA
> > (continuous virtual address), the kernel will defer to map to physical
> > pages (which means it's not necessarily continuous physical pages)
> > when handling data abort caused by accessing the pages.
> 
> I don't know why the rb->aux_pages is limit to allocated with continuous physical pages.
> so I just add a check to avoid oops and report a proper error code -EINVAL to
> user.
> 
> I would like to use vmalloc() family to replace kmalloc() so that we could support
> allocate a more large AUX area if it is not necessarily continuous physical pages.
> Should we remove the restriction?

As you said, we are now able to support a maximum AUX trace buffer
size of up to 2GiB, and AUX trace buffer is per CPU wise.

Seems to me, 2GiB AUX buffer per CPU is big enough for most tracing
scenarios, right?  Except you can provide profiling scenario which
must use bigger buffer size.

Another factor is the allocation of buffers from kmalloc() offers better
performance compared to allocation from vmalloc(), this is also
important for perf core layer.

Thanks,
Leo
