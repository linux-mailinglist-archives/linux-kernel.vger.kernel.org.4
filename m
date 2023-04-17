Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557206E4F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjDQRnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjDQRnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8475BBA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CEF625A1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A47C433EF;
        Mon, 17 Apr 2023 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681753417;
        bh=bqXpMLlD0td0ig89u8H6WzZBOrc1ov9qI+aDKXYS8pM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EsX7K1QJ0qj65NWc6vW4dybtIX5fnxmEzI0MQge4jmUA4CS1d2Buo2GHaSHiPfjyw
         ITusv4n6swtIQMFnsKQ9CmmdyK/lREYc92BAf+b2K+zWQCG0n2LE5w83CRvct1B7OA
         Q58szXhKAxPPdpD2C30Hm4lj1lAxU1XKEcdkWcQo=
Date:   Mon, 17 Apr 2023 19:43:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     matt.hsiao@hpe.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Subject: Re: [PATCH] misc: hpilo: Fix use after free bug in ilo_remove due to
 race condition with ilo_open
Message-ID: <2023041756-scoop-splendor-0e01@gregkh>
References: <20230417165246.467723-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417165246.467723-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 12:52:46AM +0800, Zheng Wang wrote:
> --- a/drivers/misc/hpilo.h
> +++ b/drivers/misc/hpilo.h
> @@ -62,6 +62,7 @@ struct ilo_hwinfo {
>  	spinlock_t fifo_lock;
>  
>  	struct cdev cdev;
> +	struct kref refcnt;

You now have 2 different structures doing reference counting logic on
the same structure.  That's just not ok at all, and is totally broken.

greg k-h
