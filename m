Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06246F5BFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjECQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECQ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78114EEB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5671962576
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 16:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31775C433EF;
        Wed,  3 May 2023 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683131335;
        bh=kjYfa7nPE5izLp7hgJ7YJ7ScK5f2ocld8Pe+x1/yV2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KD/xvm2IaJfUw+q733dqRKA6l0lUNP2e548p36UPmy9cbsd0Kq/M0O6eXysWnFp4z
         WEVCli67veYPvPscSEb9t4qubPPo1BBzwv7DQ4IvkDV9VNsu+Mqw32vZbIKRyZXQW9
         dqvPb5oixYCRFmXnjmMNC5E2wpNjUBU5t6he3ZXH64yGz6NSKIYs3DiojGINjkYm+V
         h9ZqLxPAGcQAwIlO5yYIGRmx0m6F7upnhFKsBEBlXWPaT/lPxhR7i3JPTNwHBfoigI
         HgVjVDFHCNpQbnsE1NvaqiNWpFQsJxBVl9r3pZSBn5runtEUS3JuMB5oUS0GrmkvDu
         APmpR1sNVOxEg==
Date:   Wed, 3 May 2023 10:28:53 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     jiweisun126@126.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me, ahuang12@lenovo.com,
        sunjw10@lenovo.com
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Message-ID: <ZFKLxfet7qUIwScd@kbusch-mbp.dhcp.thefacebook.com>
References: <20230502125412.65633-1-jiweisun126@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502125412.65633-1-jiweisun126@126.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 08:54:12PM +0800, jiweisun126@126.com wrote:
> According to the above two logs, we can know the nvme_irq() cost too much
> time, in the above case, about 4.8 second. And we can also know that the
> main bottlenecks is in the competition for the spin lock pool->lock.

I have a fix that makes pool->lock critical section much shorter and constant
time. It was staged in mm tree for months, but mysteriously it's missing...
