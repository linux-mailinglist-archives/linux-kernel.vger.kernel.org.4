Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C9967F73A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjA1Knf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjA1Kn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:43:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432132E5E;
        Sat, 28 Jan 2023 02:43:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2241760B9C;
        Sat, 28 Jan 2023 10:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E726C433EF;
        Sat, 28 Jan 2023 10:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674902604;
        bh=r3AmLMHF37JfCMroLZR9ipVwtwLlfLaX5vP1fJKdhU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwjSoMDh8KEyBndqzEUUvkS7HB4UPv1pMDsqrFESp8FwzSwFLQSEYuvorblYsPEj+
         98TS4nLTbPYoRsDFM/NOGaM7VNUWqc1bxK3LPzPMJ+FUw9n7QUGRpVba0ICj0puGjo
         gF8VT86DTGzBYVag8K1cEx5V1Wa9YHoqd5PSvY7k=
Date:   Sat, 28 Jan 2023 11:43:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhong Jinghua <zhongjinghua@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de,
        bvanassche@acm.org, emilne@redhat.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH-next v2 1/2] driver core: introduce
 get_device_unless_zero()
Message-ID: <Y9T8SION2vDlmaSa@kroah.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
 <20230128094146.205858-2-zhongjinghua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128094146.205858-2-zhongjinghua@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 05:41:45PM +0800, Zhong Jinghua wrote:
> When the dev reference count is 0, calling get_device will go from 0 to 1,

You can NOT have a device reference count that is 0.  If you do, you are
doing something really really wrong, and there's a bug somewhere else.

> which will cause errors in some place of the kernel.

It's already an error in the kernel that tries to increment a reference
count of 0 as that device is already freed and you are working with
memory that is not present.

> So introduce a
> get_devcie_unless_zero method that returns NULL when the dev reference
> count is 0.

No, this is not ok, sorry, please never do this.  Fix the caller.

thanks,

greg k-h
