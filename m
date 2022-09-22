Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649A25E6215
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiIVMP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIVMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:15:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681B6B6038
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:15:23 -0700 (PDT)
Date:   Thu, 22 Sep 2022 14:15:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663848921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqMQeAG3qnEpASlej2J8TmOifczthv2gPHe9GbktIwE=;
        b=be0zNAMxL7IQB5k2+jhnjuC/bPOMiwKUVKy6pZP7ZmEoLH9dI1JcWvoBfwnvRnMYNdNM6Q
        A83tNTstGoXcnueRvyrpv//OYrspRUvgmhTz94nRl3x4Kckz1/UiYuUxWpghnJDj61I8h0
        YNSGSFWuO3dMAe43Vh1F31HXMxYnagLTI8uzrtk0EIO15ylp3GeH/QvI2I5UZx/CylSY0o
        1ciXxXaLHZVBlYCIu4RHwlCzJ9XfDAD7ccw8m2sJ/lhqIov1/XyqNvB0S359bU2fdE64Ep
        5EFoWATVHD+x8Ud/ZcMNxGrqLAcN/yQ0PZ4txUg551GCH9ZgAIv9VG4Z30khxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663848921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqMQeAG3qnEpASlej2J8TmOifczthv2gPHe9GbktIwE=;
        b=msx7L8TxbpNuYM6N3IGmzszXy5Jzbs+0esldSMZhWdTYHSrU25wr+kV6kjRhaUphTag3al
        UBo6PgEr61LvYmCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        liu3101@purdue.edu, nogikh@google.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com, dvyukov@google.com
Subject: Re: [PATCH -next] kcov: Switch to use list_for_each_entry() helper
Message-ID: <YyxR2ErlHj6wrR6m@linutronix.de>
References: <20220922105025.119941-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922105025.119941-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-22 18:50:25 [+0800], Chen Zhongjin wrote:
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -133,10 +133,8 @@ static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
>  static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
>  {
>  	struct kcov_remote_area *area;
> -	struct list_head *pos;
>  
> -	list_for_each(pos, &kcov_remote_areas) {
> -		area = list_entry(pos, struct kcov_remote_area, list);
> +	list_for_each_entry(pos, &kcov_remote_areas, list) {

so how does this work if you remove pos?

>  		if (area->size == size) {
>  			list_del(&area->list);
>  			return area;

Sebastian
