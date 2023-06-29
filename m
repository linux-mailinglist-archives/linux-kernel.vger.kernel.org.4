Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784A0742F55
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjF2VLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjF2VLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335F92D4E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688073029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MGOWLH5yYZOQguU6z0SZDCNOwqtS2A+CXlPEXU7v820=;
        b=LNr9mujZ6KvHRDJDlWu4hJleAuD/jeE3GSajpJgdJSBPsfxQSocy7kCVjiClvmZMVioST2
        jpMrAIQd6FozyMmkq1hvCbXAAXkGbO0U7uReZQZ+WZCEsRwSgYALcTGLkEGrx+Ruk7emTK
        5wU379XnSCPJ3qAmjtgKZxKPES9L4Ps=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-V-vpMZduOCeaL8TkCaPh_g-1; Thu, 29 Jun 2023 17:10:27 -0400
X-MC-Unique: V-vpMZduOCeaL8TkCaPh_g-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-56ff81be091so9880057b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688073026; x=1690665026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGOWLH5yYZOQguU6z0SZDCNOwqtS2A+CXlPEXU7v820=;
        b=ks/VXRh9dNvaJJ36gJxOBOi/a8ncHxGqpr9LVnBX77/AWVWYDKG8jWGoswosEgHv5q
         xPBUkNZbPgEtyXMRN7J4tjumE1lALrFaPd65tmWv2FSpmoog+aBojm+UfVdogky5pZx0
         Lx1IFiY+hf+6xZXppgovwu4vKJxUg0f2NXdbrkSOkIjKh1iPJHqELU3gdOg0o3UolD7C
         CtSafA6iWzyJzWsxlaN+0MIww/v9mwoUE8DZZrUBzYt+NBISaaJ9tHjsMgKEe3nj06Ax
         hheyaDpAvxx5vu0w2Jbha8x8Y+KxZptJvxtgPvo5DfamQ65JHGicMYKGvOwUVpLfaDVd
         wfLA==
X-Gm-Message-State: ABy/qLafO9sUYAkfBrdhPSXuGsB8tffM2a5ZsSceD0Xd4o7XpiIcd9Od
        eJ365SywMU7n8OoppCzk7ihLLZdLtkCv1OyPYheTR7lg3AA6/aRi8VwQ5YnVg2WmP3BpVSrhWSa
        svsBEcttyqnI+YV52+CDMF+NP
X-Received: by 2002:a05:690c:360d:b0:56d:a2d:d08c with SMTP id ft13-20020a05690c360d00b0056d0a2dd08cmr399998ywb.51.1688073026765;
        Thu, 29 Jun 2023 14:10:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFexhIe4+FSUhftLbXEZ7SljYaaxr3sHvF+qUjRjfjmLU8owbauYcWADujmTq/eC0LfyIjjVg==
X-Received: by 2002:a05:690c:360d:b0:56d:a2d:d08c with SMTP id ft13-20020a05690c360d00b0056d0a2dd08cmr399983ywb.51.1688073026548;
        Thu, 29 Jun 2023 14:10:26 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id a205-20020a8166d6000000b0057020aa41basm3041764ywc.65.2023.06.29.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:10:25 -0700 (PDT)
Date:   Thu, 29 Jun 2023 16:10:23 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        bartosz.golaszewski@linaro.org
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-qcom-ethqos: Log more errors in
 probe
Message-ID: <20230629211023.pznzgue6arn7fzfl@halaney-x13s>
References: <20230629191725.1434142-1-ahalaney@redhat.com>
 <20230629191725.1434142-3-ahalaney@redhat.com>
 <e9157117-bd7a-4b75-841e-090103f75d22@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9157117-bd7a-4b75-841e-090103f75d22@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 10:32:24PM +0200, Andrew Lunn wrote:
> On Thu, Jun 29, 2023 at 02:14:18PM -0500, Andrew Halaney wrote:
> > These are useful to see when debugging a probe failure.
> 
> Since this is used for debugging, maybe netdev_dbg(). Anybody actually
> doing debugging should be able to turn that on.
> 

In my opinion it is better to use dev_err_probe() as done here because:

1. If it's -EPROBE_DEFER it will be under debug level already
2. If it's anything else, its an error and the logs are useful

I've ran into both ends of this now (failure of a platform dependency to
load, be it a bug in the driver, or just failing to select said driver),
and I've seen issues where new integrators (say you're bringing up a new
board) leave something out, etc, and run into issues because of that.

Thanks,
Andrew

