Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5606C6C9231
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 05:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCZDRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 23:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCZDRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 23:17:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC59AF38
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 20:17:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id kq3so5467411plb.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 20:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679800649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJXwUATP+VDr4imGtf+OtzrCNdoqnl+qk6pd1rJAqno=;
        b=cNEjgFA7QXYvPrGtk62VaYUAPZRIvm45tGOhXJzFkYCmXlyP1JRo56u2Kj3pJwizZx
         t26m/Cq/4wp2CZPRHl9mCcpOu7ppiSj51l/2TTMztgZ+e9pvJvEDp8+duoXGbuJDWk4I
         10PzKf65I3irFTHS0GlSdGasnugnFmWnQJPyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679800649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJXwUATP+VDr4imGtf+OtzrCNdoqnl+qk6pd1rJAqno=;
        b=mRz+UULOs41ANKwyF2NfbJ4N4hPUy37PYbhkG1a+iYGk2IWCP/PD+ZAE1vgu38Cqhk
         MRJQBlfaDx5b1ZJYrzWZ9w1AGQLnCT0fHVtSOJDWVDvQIHHQjLC0J5PCCoH5ppNHIUr8
         b4noVFyjPyRlnIVL7I2K712qd7+wgd5Iot5derTEs9E+PMmI3sX5xQEo7NjpXmfpGCUo
         QB6Ci7ZC6hvuSvnbbxEF4DaDX8NAvHtu/N3hEVRJyQ9/UK7+LlXSIrwWclyPaMbw1X3B
         n38mtnKlXnnO5vT73aLDKL1pGKFjztsbQq3GxBPN7WyWsGXgxXcnN8SSbLZMSGxuNwn1
         EnZQ==
X-Gm-Message-State: AAQBX9eduY7d6x+7g5PCKUPArR1ZoCR/2uzTyphp/5PvCspAThtL0XgF
        FMeRUnbHOFbZ2r9iD38LJKDMLA==
X-Google-Smtp-Source: AKy350ZH7rtLvVaOc1HldQaaxF16mP+v3mrXojdRrXmTmAJlKAg6UoD0ZNERjK0clBstXNNVpRYpuA==
X-Received: by 2002:a17:90b:1b48:b0:23f:7770:9e75 with SMTP id nv8-20020a17090b1b4800b0023f77709e75mr8409217pjb.47.1679800649460;
        Sat, 25 Mar 2023 20:17:29 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902728300b0019c32968271sm16548162pll.11.2023.03.25.20.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 20:17:28 -0700 (PDT)
Date:   Sun, 26 Mar 2023 12:17:23 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next v7 2/4] mm/zswap: skip invalid or unchanged
 parameter
Message-ID: <20230326031723.GD3269998@google.com>
References: <20230325071420.2246461-1-liushixin2@huawei.com>
 <20230325071420.2246461-3-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325071420.2246461-3-liushixin2@huawei.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/25 15:14), Liu Shixin wrote:
>  static int zswap_enabled_param_set(const char *val,
>  				   const struct kernel_param *kp)
>  {
> +	bool res;
> +
> +	if (kstrtobool(val, &res))
> +		return -EINVAL;
> +
> +	/* no change required */
> +	if (res == *(bool *)kp->arg)
> +		return 0;

Bool kernel param can be any of these letters 'YyTt1NnFf0'. Doing things
to kp->arg outside of kernel/params.c is not going to be easy, let's not
even try.
