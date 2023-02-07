Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02568CCAA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBGCln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBGCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:41:41 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312AE4ED1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:41:40 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vb59GOQ_1675737697;
Received: from 30.240.101.84(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Vb59GOQ_1675737697)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 10:41:37 +0800
Message-ID: <83391944-e0bf-288f-f50e-cc1a28b89a34@linux.alibaba.com>
Date:   Tue, 7 Feb 2023 10:41:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] lib/mpi: Fix poential NULL pointer dereference in
 mpi_fdiv_q
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com
References: <20230203084302.589017-1-zyytlz.wz@163.com>
Content-Language: en-US
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20230203084302.589017-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng Wang,

On 2/3/23 4:43 PM, Zheng Wang wrote:
> in lib/mpi, there is multiple function that not check the return
> value of mpi_alloc. One case is mpi_fdiv_q, if tmp == NULL,
> tmp->nlimbs in mpi_fdiv_qr will cause NULL pointer dereference.
> As the code is too much, here I only fix one of them. Other
> function like mpi_barrett_init mpi_copy mpi_alloc_like mpi_set
> mpi_set_ui mpi_alloc_set_ui has the same problem.
> 
> Please let me know if there is a better way to fix the
> problem.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger.

Thanks for your patch, lib/mpi is ported from libgcrypt, as an
application layer library, such error handling is no problem, but for
the kernel, these return values should be checked, even if these errors
are difficult to trigger.

As you said, there are many places where this check is ignored, and even
the error return value needs to be passed upwards, which should be
upgraded and fixed uniformly, even some callers need such a check, such
as the SM2 algorithm. These checks were initially ignored in the
interest of code brevity and rapid development, and it looks like it's
time to fix them.

> 
> Fixes: a8ea8bdd9df9 ("lib/mpi: Extend the MPI library")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>   lib/mpi/mpi-div.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/mpi/mpi-div.c b/lib/mpi/mpi-div.c
> index 45beab8b9e9e..e8642265d7d4 100644
> --- a/lib/mpi/mpi-div.c
> +++ b/lib/mpi/mpi-div.c
> @@ -43,7 +43,8 @@ void mpi_fdiv_r(MPI rem, MPI dividend, MPI divisor)
>   void mpi_fdiv_q(MPI quot, MPI dividend, MPI divisor)
>   {
>   	MPI tmp = mpi_alloc(mpi_get_nlimbs(quot));
> -	mpi_fdiv_qr(quot, tmp, dividend, divisor);
> +	if (tmp)
> +		mpi_fdiv_qr(quot, tmp, dividend, divisor);
>   	mpi_free(tmp);
>   }
>   

As far as this is concerned, the allocation failure should pass the
ENOMEM error upwards, not the void type.

Best regards,
Tianjia
