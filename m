Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065BE5BD321
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiISRE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiISREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99AD40BE5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F67C61E1E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E557C433D6;
        Mon, 19 Sep 2022 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663606987;
        bh=NUfm1ogzfA53a+kYpQi40Xi8gg99UIL8Bf979QIs08Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RLGM3xcHH6VeNaVsiHjRsajiqehzhbCFNE4XE8Cm9Pp1WA+OroPcxpRm5Rok7flF1
         6qA/MRW/NQwdDF8QFg6mzVjsk11tw3XtWoR+nwMKbX1Cs+fVBOT0rOdAHgj70mxML4
         wPBlbyIDfuziNhh4jaha9LXQei3QGQRAM+cz39IDHzdmz16oUjoQg7veraJfk6G5oG
         Rkb9Rgaeh3DSgvKdLa4NPwV0TMYCd5bzAfc8iafWW8o64P3IXbLZ2DHLQrOTRgNZ7f
         GenpOKPA8mak+9H0ywUEy3Txra4O+eKK0sSj/GEvTP9Xwvm2dBVTpNgC4RviPbnyZu
         +RCSTpvkKTwEQ==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/damon/sysfs: remove unnecessary variables
Date:   Mon, 19 Sep 2022 17:03:05 +0000
Message-Id: <20220919170305.61335-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919151201.66696-1-xhao@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 23:12:00 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Just do a little change here, the 'err' variable really no need to stay
> here.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/sysfs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 0cca1909bf67..b852a75b9f39 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1109,9 +1109,8 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
>  {
>  	struct damon_sysfs_region *region = container_of(kobj,
>  			struct damon_sysfs_region, kobj);
> -	int err = kstrtoul(buf, 0, &region->start);
> 
> -	if (err)
> +	if (kstrtoul(buf, 0, &region->start))
>  		return -EINVAL;

Good finding.  But, I'd like to let the user know why it really fails by giving
them the error code that returned by 'kstrtoul()' here.  Let's keep the 'err'
but return 'err' here.

>  	return count;
>  }
> @@ -1130,9 +1129,8 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
>  {
>  	struct damon_sysfs_region *region = container_of(kobj,
>  			struct damon_sysfs_region, kobj);
> -	int err = kstrtoul(buf, 0, &region->end);
> 
> -	if (err)
> +	if (kstrtoul(buf, 0, &region->end))
>  		return -EINVAL;

ditto.

>  	return count;
>  }
> --
> 2.31.0


Thanks,
SJ
