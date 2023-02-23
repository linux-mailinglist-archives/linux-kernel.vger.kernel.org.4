Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CA56A0F72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBWSaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBWS37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:29:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FC74DE0E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:29:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 632296170B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD50FC433EF;
        Thu, 23 Feb 2023 18:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677176997;
        bh=FDtSn6RCdhK29pIP/7am1BjCvIl0avHM6OD1PRsuEaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E1Vs560faX2Rwvsoa/KWKQjxFyh/MR7/JgHP73Iu2kiW6lgV/x3diRoIFEEP5DBuV
         OWy6Qgt7UTJuNTevYMjETeogFTbw6tiCCo3YhnUwmmqqTvnGB5+or+HFQp+k1I1LU3
         +oOVG9bPs0UK8xzae2LTQqHEhtiJg//LIeAPnida//rcqW/rCuppLvad6pbfhNMfCE
         XdAgxvQ5MGRfEfPJirnvdcY3Q1rF/c21AYOe7vQyIS6HWdsX+fGK3Hj7nUm6jw4hYW
         IogWCTeKjzf96djhht+bjzzxx9yPkzeNUGHoX+96vGaQvpY4eg5aizuHHfGnHN607g
         HnA7oxsGW9hRA==
Date:   Thu, 23 Feb 2023 18:29:56 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>, kernel-team@android.com,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an
 option
Message-ID: <Y/ewpGQkpWvOf7qh@gmail.com>
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 08, 2023 at 05:33:22PM +0800, Gao Xiang wrote:
> From: Sandeep Dhavale <dhavale@google.com>
> 
> Using per-cpu thread pool we can reduce the scheduling latency compared
> to workqueue implementation. With this patch scheduling latency and
> variation is reduced as per-cpu threads are high priority kthread_workers.
> 
> The results were evaluated on arm64 Android devices running 5.10 kernel.

I see that this patch was upstreamed.  Meanwhile, commit c25da5b7baf1d
("dm verity: stop using WQ_UNBOUND for verify_wq") was also upstreamed.

Why is this more complex solution better than simply removing WQ_UNBOUND?

- Eric
