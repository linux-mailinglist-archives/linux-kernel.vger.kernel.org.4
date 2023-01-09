Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C92662F31
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbjAISe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbjAISdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:33:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3317425
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:30:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9CCA61311
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 18:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8720BC433EF;
        Mon,  9 Jan 2023 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673289029;
        bh=HQCfjExHsVNbVU5V07LRXzsNiZRcHQX4rgcNmgWNn+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ekvh4iIsqIQ6GVoHVm4thN3+73pRDwghhkwnJMdooRgauK2v8ypGCA8euo1Hdwuy+
         odwUC+onI9Vz3U5pqKaxD7TfvgPVoStViH1Aj8MXlJAjPvHyAaMbCegJ/neqtzAkQX
         DC2nPYGcYA4MZG6QNROSn+xKL+5wn3d12jFlsNOZM9TKviXEiyDt9qj3/jAVYciPH9
         rFu+UUDJMewoERsuNkRS9z7TcDyHXfCBrwI4XLHtz/8SnZk9u+JkSaEXUJWJqcRCtU
         tE/zEAmdovsr4vYJLvseGqVf1JKFK92T6sHu79sj3d9nIeSV2UZVKG2KkDFVfC5P1F
         Ft9kUMud2Qvdg==
From:   SeongJae Park <sj@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] mm/damon/sysfs-schemes: use strscpy() to instead of strncpy()
Date:   Mon,  9 Jan 2023 18:30:26 +0000
Message-Id: <20230109183026.157393-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202301091946553770006@zte.com.cn>
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

Hello Xu,


Thank you for this patch.

On Mon, 9 Jan 2023 19:46:55 +0800 (CST) <yang.yang29@zte.com.cn> wrote:

> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks,
SJ

> ---
>  mm/damon/sysfs-schemes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index f0dabe3e2dc0..86edca66aab1 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -353,8 +353,7 @@ static ssize_t memcg_path_store(struct kobject *kobj,
>  	if (!path)
>  		return -ENOMEM;
> 
> -	strncpy(path, buf, count);
> -	path[count] = '\0';
> +	strscpy(path, buf, count + 1);
>  	filter->memcg_path = path;
>  	return count;
>  }
> -- 
> 2.15.2
