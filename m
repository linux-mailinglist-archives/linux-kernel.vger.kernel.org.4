Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009F364C54E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiLNIwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbiLNIwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:52:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BE91901E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:52:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 296BAB810FA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74295C433D2;
        Wed, 14 Dec 2022 08:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671007934;
        bh=a44KHZV5ozazTqhTJY1VPwLhc0YsMskNoT1I+bEyLx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0drlkZO2dW/NQunugXLcGkykNhfwnToCPByJr8ieqBWd/49CA3ipjlx+DoCumkUuU
         UfpjxLijkaSKkFYKV2i/zmb1otKoGJ4PMZnNYnOQaqJRWpEmMfPAqx5s13403PlZJ9
         JJomjyPWrCq7GqbRSjKLQaqRYaxxK3gvOEPhG3cs=
Date:   Wed, 14 Dec 2022 09:52:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mawupeng <mawupeng1@huawei.com>
Cc:     naoya.horiguchi@nec.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Qestion] UCE on pud-sized hugepage lead to kernel panic on
 lts5.10
Message-ID: <Y5mOu7H7Adm2HytF@kroah.com>
References: <2b4d03bc-2b6e-45b0-655a-58b66672187e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4d03bc-2b6e-45b0-655a-58b66672187e@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 09:33:10AM +0800, mawupeng wrote:
> On current arm64 stable 5.10(v5.10.158). If a UCE happnes pud-sized
> hugepage, kernel will panic since current memory failure can not handle
> this kind of memory failure since commit 31286a8484a8 ("mm: hwpoison:
> disable memory error handling on 1GB hugepage")
> 
> The latest kernel(v6.0) can handle this UCE since commit 6f4614886baa ("mm,
> hwpoison: enable memory error handling on 1GB hugepage"). We are trying to
> backport this patchset to stable 5.10, however too many other patches
> should be backport since there are huge difference between 5.10 and 6.0.
> The full patch list will be shown at the end of this mail.
> 
> We do not think backport all of these patches is doable for stable 5.10. Is
> there any better way to fix this problem.

Please just upgrade to 6.0 (or 6.1 as 6.0 will be end-of-life in a week
or so).  That is the simplest and easiest way to resolve the issue,
right?

Or what about 5.15.y?

thanks,

greg k-h
