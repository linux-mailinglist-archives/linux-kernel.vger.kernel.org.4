Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294736DF1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDLKHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjDLKHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:07:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3AB83DC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2945A63127
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8FCC433EF;
        Wed, 12 Apr 2023 10:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681294027;
        bh=yF/uFRHThBaezM0NTlXWHeSUyorZ+xUTqEgdHeW/6RM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5VqUxzCLLBle3AnLLDpUACQQp0zfOI4ujjCkpUTUmw+c/x/Gq2uPB1jdaUd1/Si+
         huX4/Iz1vjqPuSpx5iSSKPK5NKxyjg9rMregRYdBC32g9Ewo+lyhON1kyvU4b2Ur0U
         XlT1BQHMgiPUE1l2Nj0UACdeXxVKRJYUyGwgEiC5qz1NM7kVaHzmxzpvJzM64K62Hh
         FQpqanHBtWSEsHGmxg9eGfOMhk6UR8NJ5Wea11B/E/c7VvV1YdyhXgy27jGGP5FmkE
         LLgdeI+Jzwy/MbBrSLkILO0GNdmIxu86R4FKdvZS+AUc0E9BO0ZBoB6aO8w81h0Yed
         9I4i3H3Ty87Eg==
Date:   Wed, 12 Apr 2023 15:37:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel_auxdevice: improve pm_prepare step
Message-ID: <ZDaCyFdzlPmoi6qK@matsya>
References: <20230323025228.1537107-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323025228.1537107-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-23, 10:52, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> In the case where multiple peripherals are attached on the same link,
> it's possible that they are in different pm_runtime states.
> 
> The device_for_each_child() loop to resume all devices before a system
> suspend would not work if one peripheral was active and others
> suspended. pm_runtime_resume() returns 1 in the former case, which is
> taken as a error. As a result, a pm_runtime suspended device might be
> skipped if the first device was active.
> 
> This patch changes the behavior of the helper function to only return
> zero or a negative error. A Fixes tag is not provided since there are
> no existing configurations on Intel platforms with different types of
> devices on the same link. Amplifiers may be used on the same link, but
> they are used by the same dailink so their pm_runtime state is always
> matching. This assumption may not be true in the future, so we should
> improve the behavior and align with AMD.

Applied, thanks

-- 
~Vinod
