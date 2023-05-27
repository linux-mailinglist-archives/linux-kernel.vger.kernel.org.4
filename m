Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31DC71340D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjE0KjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjE0KjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:39:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD78D8
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 03:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5B5560B67
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 10:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD647C433D2;
        Sat, 27 May 2023 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685183939;
        bh=3ENny4TLjAP6BGM/oHhGNzefJxUwL+iQcwwURQ1DS0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPqBWun2jt1uDOsPLMUyWY1ve5naJCAfB7AwNdGcZ30zRQ5zxCpPRUG1N0e2UwusN
         d1nms3MgE83xe42z+IhTSmHgdKmh6AG7MgZnne3AhmJtpfvaFOa3XpmZypEzVVVB/b
         1e7js1lGGCmUN/9dRMLzaTpHdaVsF1kLAFFnbfhbGRpaXVLA+n0Tf6Fhdsa4Lf427D
         16K4N+WYt3x6VIZK+HdRCs4A74WjMgwyAtXGY/xAdjhpVl5aGqqC60UcpweiN18kZq
         nTA7HZLDFw69frvGso96Jw/ACc6Orw4RtA0pFR0rK8CtN7UX9BzQDJ1ENj8MHf2T4U
         K7DZpuE2PQxLg==
Date:   Sat, 27 May 2023 16:08:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel: read AC timing control register before
 updating it
Message-ID: <ZHHdvx4cDFIiX27s@matsya>
References: <20230515081301.12921-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515081301.12921-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-05-23, 16:13, Bard Liao wrote:
> From: Chao Song <chao.song@linux.intel.com>
> 
> Start from ACE1.x, DOAISE is added to AC timing control
> register bit 5, it combines with DOAIS to get effective
> timing, and has the default value 1.
> 
> The current code fills DOAIS, DACTQE and DODS bits to a
> variable initialized to zero, and updates the variable
> to AC timing control register. With this operation, We
> change DOAISE to 0, and force a much more aggressive
> timing. The timing is even unable to form a working
> waveform on SDA pin on Meteorlake.
> 
> This patch uses read-modify-write operation for the AC
> timing control register access, thus makes sure those
> bits not supposed and intended to change are not touched.

Applied, thanks

-- 
~Vinod
