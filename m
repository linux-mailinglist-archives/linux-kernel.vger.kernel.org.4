Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3DB71913B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjFADRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFADRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:17:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFF8136
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6633640CD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C63C433D2;
        Thu,  1 Jun 2023 03:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685589421;
        bh=XvJPQ0XHSvZ7dSl5mVdAuoo5pLb3aJ1TYEwAlwW3WKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BzmOiuM4sreAVnlRxGo5JdeBu5cNJ0fH4DwQquEL3P5EwrPyuc4sKspHzWZsVlMNz
         20HDBLLr8iGVVxAwICCmrS0FpgIfq2mgLzAWErForkcDEFf7cW1udSlHDglRAoOKBS
         BeRlpU3bL+gYwgRMBZex9aPrkdWzvJkbAy3DPXTOYITesDlyXaGtiZX9ap5ZqsI+OZ
         XJQR0ptuiOH50QaobLo096PO5FHvQCMgnSbQcHk1ALytx5hucKUSPCwTTEcTGt7jKe
         QvWz5uom4ozXauycokNXLP2rq+8T5K0ABNH1QbjRbMzT9CSvn4Fp/lOyK6oafSjCg0
         b6Zy78SwHVQgA==
Date:   Wed, 31 May 2023 20:16:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sheng Yong <shengyong@oppo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: add f2fs_ioc_[get|set]_extra_attr
Message-ID: <20230601031658.GA728@quark.localdomain>
References: <20230529013502.2230810-1-shengyong@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529013502.2230810-1-shengyong@oppo.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 09:35:00AM +0800, Sheng Yong via Linux-f2fs-devel wrote:
> This patch introduces two ioctls:
>   * f2fs_ioc_get_extra_attr
>   * f2fs_ioc_set_extra_attr
> to get or modify values in extra attribute area.
> 
> The argument of these two ioctls is `struct f2fs_extra_attr', which has
> three members:
>   * field: indicates which field in extra attribute area is handled
>   * attr: value or userspace pointer
>   * attr_size: size of `attr'
> 
> The `field' member could help extend functionality of these two ioctls
> without modify or add new interfaces, if more fields are added into
> extra attributes ares in the feture.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Aren't there enough things called extra or extended attributes already?  Besides
the standard "extended attributes" retrievable with the getxattr() system call,
there is already the FS_IOC_FSGETXATTR ioctl too.

- Eric
