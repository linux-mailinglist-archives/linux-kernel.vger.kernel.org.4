Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC864E64F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLPDTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 22:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLPDTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:19:19 -0500
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Dec 2022 19:19:18 PST
Received: from out-92.mta0.migadu.com (out-92.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C956E3D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:19:18 -0800 (PST)
Message-ID: <bc1603aa-cdf5-e8d3-d8f4-9e9c4f4d5563@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671160307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKoswwgot9/dVp0xHFMFvQzO9Poij7sBhLRfbUb1TDw=;
        b=uLyI9B3lOZxCdxNU5jyc+noRNaWSZdELWPBx/sqI4mH561vquaTmem+KTz3IRivFThSYb7
        aJqdKs7MewogCsCS9+vQFlvkuyWBi3M3zkVTf5+WACUbicf1byakhG1I0xcSZcUI0ET5tZ
        HUzbQX8ucUtlhtur54A1Dzbj4RWH5F4=
Date:   Fri, 16 Dec 2022 11:11:39 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Avoid unused variable warnings on 32-bit
 targets
To:     Palmer Dabbelt <palmer@rivosinc.com>, jgg@nvidia.com
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
References: <20221215232837.30211-1-palmer@rivosinc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20221215232837.30211-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/12/16 7:28, Palmer Dabbelt 写道:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 

In 
https://patchwork.kernel.org/project/linux-rdma/patch/1669905568-62-2-git-send-email-yangx.jy@fujitsu.com/

In this link, it seems that a similar commit for this problem.
Please check it.

Thanks
Zhu Yanjun

> These variables are not used on 32-bit targets as there's a big ifdef
> around their use.  This results on a handful of warnings for 32-bit
> RISC-V allyesconfig:
> 
>    CC      drivers/infiniband/sw/rxe/rxe_resp.o
> linux/drivers/infiniband/sw/rxe/rxe_resp.c: In function 'atomic_write_reply':
> linux/drivers/infiniband/sw/rxe/rxe_resp.c:794:13: error: unused variable 'payload' [-Werror=unused-variable]
>    794 |         int payload = payload_size(pkt);
>        |             ^~~~~~~
> linux/drivers/infiniband/sw/rxe/rxe_resp.c:793:24: error: unused variable 'mr' [-Werror=unused-variable]
>    793 |         struct rxe_mr *mr = qp->resp.mr;
>        |                        ^~
> linux/drivers/infiniband/sw/rxe/rxe_resp.c:791:19: error: unused variable 'dst' [-Werror=unused-variable]
>    791 |         u64 src, *dst;
>        |                   ^~~
> linux/drivers/infiniband/sw/rxe/rxe_resp.c:791:13: error: unused variable 'src' [-Werror=unused-variable]
>    791 |         u64 src, *dst;
>        |             ^~~
> cc1: all warnings being treated as errors
> 
> Fixes: 034e285f8b99 ("RDMA/rxe: Make responder support atomic write on RC service")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 7a60c7709da0..18977d5a3316 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -788,10 +788,10 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
>   static enum resp_states atomic_write_reply(struct rxe_qp *qp,
>   						struct rxe_pkt_info *pkt)
>   {
> -	u64 src, *dst;
> -	struct resp_res *res = qp->resp.res;
> -	struct rxe_mr *mr = qp->resp.mr;
> -	int payload = payload_size(pkt);
> +	__maybe_unused u64 src, *dst;
> +	__maybe_unused struct resp_res *res = qp->resp.res;
> +	__maybe_unused struct rxe_mr *mr = qp->resp.mr;
> +	__maybe_unused int payload = payload_size(pkt);
>   
>   	if (!res) {
>   		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);

