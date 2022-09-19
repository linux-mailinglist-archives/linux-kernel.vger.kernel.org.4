Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B955BCFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiISOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:51:08 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D576132EFB;
        Mon, 19 Sep 2022 07:51:03 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oaI6u-0005ft-03; Mon, 19 Sep 2022 16:51:00 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 41D40C12F2; Mon, 19 Sep 2022 16:48:31 +0200 (CEST)
Date:   Mon, 19 Sep 2022 16:48:31 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lin Yujun <linyujun809@huawei.com>
Cc:     christophe.jaillet@wanadoo.fr, paulburton@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] MIPS: SGI-IP27: Fix platform-device leak in
 bridge_platform_create()
Message-ID: <20220919144831.GC7674@alpha.franken.de>
References: <20220914032917.97203-1-linyujun809@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914032917.97203-1-linyujun809@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 11:29:17AM +0800, Lin Yujun wrote:
> In error case in bridge_platform_create after calling
> platform_device_add()/platform_device_add_data()/
> platform_device_add_resources(), release the failed
> 'pdev' or it will be leak, call platform_device_put()
> to fix this problem.
> 
> Besides, 'pdev' is divided into 'pdev_wd' and 'pdev_bd',
> use platform_device_unregister() to release sgi_w1
> resources when xtalk-bridge registration fails.
> 
> Fixes: 5dc76a96e95a ("MIPS: PCI: use information from 1-wire PROM for IOC3 detection")
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> ---
>  arch/mips/sgi-ip27/ip27-xtalk.c | 70 +++++++++++++++++++++++----------
>  1 file changed, 50 insertions(+), 20 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
