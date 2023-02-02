Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788C9687792
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBBIel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjBBIek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:34:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB0987175
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:33:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD8DCB824B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111CFC433D2;
        Thu,  2 Feb 2023 08:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675326798;
        bh=iNdEaxnqD23k6qNLHXaHi5s0318IhEARNylug+0Oyqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d93vFRYyleP5E7JBdsfugWlnL9VwJT14B/lU7IobjfW78yFCuFvi7ZwksszOirK7s
         8seIw1+0zq2vo+7B7oI+c+2kb51c/6uf0gU7jBCcdTh4aDMGbIa4OXptBR5urixDRt
         4YWaepVLRswCUI9l4uqoWwtGv6fnKbBNkZ/vERyI=
Date:   Thu, 2 Feb 2023 09:33:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longlong Xia <xialonglong1@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        chenwandun@huawei.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH -next 3/3] devtmpfs: remove return value of
 devtmpfs_*_node() & devtmpfs_submit_req()
Message-ID: <Y9t1S1Q+DHdfps/t@kroah.com>
References: <20230202033203.1239239-1-xialonglong1@huawei.com>
 <20230202033203.1239239-4-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202033203.1239239-4-xialonglong1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:32:03AM +0000, Longlong Xia wrote:
> Because the return value of devtmpfs_*_node() and devtmpfs_submit_req()
> are not used by their callers, change them into void functions.

Why not just fix this up properly and have the callers handle the errors
if they happen?  Failures at this level should cause the device to not
be registered, as you have found out.

But only do this for devtmpfs_create_node(), there's no reason that
devtmpfs_delete_node() needs to return a value as there's nothing we can
do when cleaning things up on a remove path.  So if you split this patch
into half, I'll be glad to take that now while you work on fixing up the
return path of devtmpfs_create_node().

thanks,

greg k-h
