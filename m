Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A318F6253CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiKKGbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiKKGad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:30:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376B079D11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:26:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B32A6B822ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974CCC433C1;
        Fri, 11 Nov 2022 06:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668147984;
        bh=VdXGwJ1MitCF6bo1N2NcBnI+xaeLtAPTr4j2mqTNPZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBTza4lX/4Dt1TZ//ZHSiwlY4+UiTiQEssI8QnyNnyoofhKo7/PCm0q+zjyHfvk3c
         E5VMr54D3Oh1LtkYzMJ5Ur852y+y3e+1BB6IS6+GLxHxY6koKyPA3ouqWvjEgHbX0a
         IjT/BWyWjgnfNN4qZEfD93FjbB4EpYh10vkRN4DA=
Date:   Fri, 11 Nov 2022 07:26:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: hide illegible sysfs warning of kobject_del()
Message-ID: <Y23rC0N1cL2LQpyF@kroah.com>
References: <20221111065807.3278713-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111065807.3278713-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:07PM +0800, Liu Shixin wrote:
> Some consumers do not care whether kobject_add() succeed or failed such as
> irqdesc. They call kobject_del() all the time even if kobject_add() failed.
> Then kernel will report some illegible sysfs warning like this:
> 
>  kernfs: can not remove 'actions', no directory
>  WARNING: CPU: 0 PID: 277 at fs/kernfs/dir.c:1615 kernfs_remove_by_name_ns+0xd5/0xe0

Why not fix the caller here?  Is that somehow not possible?

thanks,

greg k-h
