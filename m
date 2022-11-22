Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EBC633E56
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiKVOFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiKVOFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:05:05 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1A360365
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:03:34 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id jr19so9287314qtb.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dPo1VJDCFCdypvY/4Rr9xvuWEvz7BM121VJBRjgU86o=;
        b=iizsXhnKIIQ6of95eoBCkw5wSk6O2ftuDXtXJKqH2nkg4kMwL6naDeVJv8jtQXJx9H
         80ZQEvMptfeFwueDySvCbN6IJAi0TEGv9eQcs68a4GfZGQwOY3DbX8GVBlppRbk6MnWj
         /jNW7GetrgS5vYEGxRr/4egvF4XVmSsZdRUZ5/e1h/kd//YNsclkRqaOvqborCe9oE95
         yvoOhhLqPetq6LoP3RxPPIjXLqZnpmpKgKLtYKWqmQdGn0MbP3/VakvQJWSHnbZ27uSe
         9tnwAxvfEz+LVdOM1ThrKiXSEuNBMEdrvLITeUiNg7ipbuXXzykB/3dzkDgSJSfRCz8e
         aWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPo1VJDCFCdypvY/4Rr9xvuWEvz7BM121VJBRjgU86o=;
        b=czUpNapZkYNPm/BQ6wWajLYT7WQILkO2NSS94Ai0igsV3xCgDxn3gAM1SHRzkADcUk
         c6g2u+iZrlQA8TbfTeV6D2AqYFPuRyuZ/rZSD9knZhH1RXX2oT8El7pbPoIFiJ84lmzJ
         zskvinH1WCWCPyMrUlr6PUBHbwa9uicLa3glWdQn/0QDqvEh0hPrDRp0c/xXjiKB6kKJ
         8BG+3asHRpjZMU8yOJL5FE0eSM01yt9OoXUbYtZyM1ogqa2qdwfEdBXt0d5wNvGnmuT7
         KhG1qlGXH2EivENXtC4Qa/o9SOC2d4m0sWtCAflL1JiJvQg4I8z3wreTQzuubWe1DFZt
         Rc9g==
X-Gm-Message-State: ANoB5pmLqt/UJyIEmz79za8M9oUmfngSVA2dY4y1uvhry0rUb1Mfp/yV
        APrB4oGyLwnVbmRQ9bfdCbVNQQ==
X-Google-Smtp-Source: AA0mqf79mbqp/6RdyjDQA49XKwtdlQKw/ojQCaMF8zu8rpCbJ4qZ2RqG+xeldZ68B7PzlT1pTZIvwA==
X-Received: by 2002:ac8:60d3:0:b0:3a5:4678:5b24 with SMTP id i19-20020ac860d3000000b003a546785b24mr21815284qtm.411.1669125813304;
        Tue, 22 Nov 2022 06:03:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id bi41-20020a05620a31a900b006f956766f76sm10344180qkb.1.2022.11.22.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:03:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oxTs3-009j8v-S2;
        Tue, 22 Nov 2022 10:03:31 -0400
Date:   Tue, 22 Nov 2022 10:03:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     leon@kernel.org, markzhang@nvidia.com, haakon.bugge@oracle.com,
        mbloch@nvidia.com, sean.hefty@intel.com, rolandd@cisco.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: cma: fix the dev refcnt leak
Message-ID: <Y3zWs1m7m5D3+BJW@ziepe.ca>
References: <1669099673-12213-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1669099673-12213-1-git-send-email-wangyufen@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:47:53PM +0800, Wang Yufen wrote:
> Syzbot report the following issue:
>   infiniband syj1: RDMA CMA: cma_listen_on_dev, error -98
>   unregister_netdevice: waiting for vlan0 to become free. Usage count = 2
> 
> The causes are as follows:
> 
> rdma_listen()
>   rdma_bind_addr()
>     cma_acquire_dev_by_src_ip()
>       cma_attach_to_dev()
>         _cma_attach_to_dev()
>           cma_dev_get()
> 
>   cma_check_port()
>   <--The return value is -98， goto err
> 
> err:
> <-- The error handling here is missing the operation of cma_release_dev.
> 
> To fix, add cma_release_dev to error handing.
> 
> Fixes: e51060f08a61 ("IB: IP address based RDMA connection manager")
> Reported-by: syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>  drivers/infiniband/core/cma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 26d1772..3a50a8e 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -4049,6 +4049,9 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
>  	return 0;
>  err:
>  	id_priv->backlog = 0;
> +	if (id_priv->cma_dev)
> +		cma_release_dev(id_priv);
> +

I'm not sure about this, the dev is released during _destroy_id()

Is something leaking an entire CM id or is there something wrong with
_destroy_id() ?

Jason
