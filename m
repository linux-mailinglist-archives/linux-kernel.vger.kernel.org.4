Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177AF69DCA6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjBUJOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjBUJOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:14:34 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E90E38E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676970872; x=1708506872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k9SZeacDb9eLNQtlyjp/+pCtwgcI4xgvzkphSJgUW10=;
  b=rD7tgQAn1fSAEIOJd4363qFzG4ivGIOQKQJ3JmUTb4jPIJzjEN5Ab+B0
   pEBTxrMLuVn+Xgybl36x1amGgKocFT+Z/XNJ2T1atIICCtYowxG/0LAD4
   jysc8kDdlrgM+zmkCtJ4WzwvwKNb4aRctigRdlQMR7y9xppH+sfR2Kms6
   G0+GA3Aj5ZEMzUVrNy0lke6WSWUmanCclHQm9jfKFocpW4r21gwBKjvp5
   dohN0z0LWtUsufUKsfCfv4/FnECI2Afom79p/cvx7Bq0wEp965SMLA+Qo
   V8KT8FVxtavOCmknl16yRhcHNSqErV3zif/BVjt9Kqec5KTA99MoDqw3j
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="223586683"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2023 17:14:17 +0800
IronPort-SDR: oelhSy0xgW0ICEdKTMYFA1aQ/jct96DPGwPG4e3q+aTWhap7eL2AyGES64qu249VMg4JOYWP8m
 +hQWHPayNUJ5ijBkppzjv5/tqrC61B8yMbAXp8H8TpQ1De5dMQXJQv1aR9LoVa0S79YdLH5U2O
 AxvSD6YzO6/rw1jxJU+XSUc2w9OYhLJIuz9PCYvMZSm51tTihySn0+fLAd2Ygs24kJMoymq3Ns
 0ihmpUJL58dLbG064558g/iXOu5oOIRq1hZdgaKRyOHkxO4rQc5GTG0OmF/Ky+JH4mXrcZfsxx
 hIs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 00:31:17 -0800
IronPort-SDR: Spp1B850aX7guw1FNXP0CeM6PjVEOE7d/aApKEredK3NzWTpNEXwPPJiuQaW82j9BztP0WwgBh
 hlyiroLSz1iBbljZbB4wdXGcWVy/50Ki2unjtceTt5JBGu1fbHEdQY91Xxms+r7eTVfwoy9MNl
 CMCuR/DtEi8hAqqtv1ReXoeeG3F7Keb62QPUI7nPs50Gq5iHY4E2qAOClRi8aqUKfRRMXBX9+8
 34iWmOO+NEAmnnIbXIPWAa0Gh2aKZzW4Dg8mZt7rSBvnhj5dXIkyGKzuqb1Ll1SGMzzKm/Rf+n
 6ko=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 01:14:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PLYWY15Ftz1RwqL
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:14:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676970856; x=1679562857; bh=k9SZeacDb9eLNQtlyjp/+pCtwgcI4xgvzkp
        hSJgUW10=; b=JhbgQ9zXWY9tYKN8PkATIpy0RHGxkF+ar2L2TUqe9mTezP8EJ8C
        +KagVt5hpC1LzaUt9bNY5PsV+JpZ1XjJ7Rcqiv7RT+1gQTbkWRECEqL0hJTVGYUD
        7UJxTked0An24GFaKUI9wyhurblEnw0WP+UkYvo8IKFc+nRBBdZkJOiNqVkUW6r3
        AWf9ydGe2seLyIgDVvRqvx50Wiet0eKv0iRPj3/1kaXyQjfWQ1MrPDS3ielIyuLz
        Qv05xlc8lRly0isLB5zf7OsBQsnBbCl9ADQodAigf30BTdmG6/xHerRrMJ2RyCcv
        n2O5GWpNE4gDhP38r0R/z+uUn9VQ6c3WMtg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H4m-991pp019 for <linux-kernel@vger.kernel.org>;
        Tue, 21 Feb 2023 01:14:16 -0800 (PST)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PLYWW1N5Tz1RvLy;
        Tue, 21 Feb 2023 01:14:15 -0800 (PST)
Message-ID: <78830e38-e7a4-24e5-277e-f8e5022c59ef@opensource.wdc.com>
Date:   Tue, 21 Feb 2023 18:14:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] block, bfq: free 'sync_bfqq' after bic_set_bfqq() in
 bfq_sync_bfqq_move()
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, axboe@kernel.dk,
        paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <e2071a24-cd25-e5bd-9166-a3b575b7bf4a@huaweicloud.com>
 <20230221082905.3389012-1-yukuai1@huaweicloud.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230221082905.3389012-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 17:29, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> As explained in commit b600de2d7d3a ("block, bfq: fix uaf for bfqq in
> bic_set_bfqq()"), bfqq should not be freed before bic_set_bfqq().
> However, this is broken while merging commit 9778369a2d6c ("block, bfq:
> split sync bfq_queues on a per-actuator basis") from branch
> for-6.3/block.

The patch looks OK to me, but the commit message is not super clear. What is
broken exactly ?

> 
> Fixes: 9778369a2d6c ("block, bfq: split sync bfq_queues on a per-actuator basis")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index ea3638e06e04..89ffb3aa992c 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -746,8 +746,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
>  		 * old cgroup.
>  		 */
>  		bfq_put_cooperator(sync_bfqq);
> -		bfq_release_process_ref(bfqd, sync_bfqq);
>  		bic_set_bfqq(bic, NULL, true, act_idx);
> +		bfq_release_process_ref(bfqd, sync_bfqq);
>  	}
>  }
>  

-- 
Damien Le Moal
Western Digital Research

