Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472FC6D4CEA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjDCP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjDCP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:59:19 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCD5E1988;
        Mon,  3 Apr 2023 08:58:59 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pjMZx-00029z-00; Mon, 03 Apr 2023 17:58:45 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 37208C20E4; Mon,  3 Apr 2023 17:58:04 +0200 (CEST)
Date:   Mon, 3 Apr 2023 17:58:04 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        John Crispin <blogic@openwrt.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] MIPS: vpe-cmp: remove module owner pointer from struct
 class usage.
Message-ID: <20230403155804.GA12122@alpha.franken.de>
References: <2023040242-pursuable-frown-48d8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023040242-pursuable-frown-48d8@gregkh>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 11:05:45AM +0200, Greg Kroah-Hartman wrote:
> In commit 6e30a66433af ("driver core: class: remove struct module owner
> out of struct class"), the module owner pointer was removed from struct
> class, but this was missed for the mips vpe-cmp code due to lack of
> build testing (and it being burried under a very unused config
> settings.)  Fix this up by removing the module pointer to resolve the
> build error.
> 
> Note, there are other problems with the driver model usage in this file
> (static struct device usage, empty device release function, etc.), so it
> probably could use some good cleaning up, but odds are this driver
> really isn't used so hopefully it will just be removed entirely someday
> soon as part of the general "remove unused arches" cleanup that is
> slowly happening.
> 
> Cc: Dengcheng Zhu <dzhu@wavecomp.com>
> Cc: John Crispin <blogic@openwrt.org>
> Cc: Qais Yousef <Qais.Yousef@imgtec.com>
> Cc: Steven J. Hill <Steven.Hill@imgtec.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: linux-mips@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304020802.xbRTJKjW-lkp@intel.com/
> Fixes: 6e30a66433af ("driver core: class: remove struct module owner out of struct class")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/mips/kernel/vpe-cmp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
> index 92140edb3ce3..4ef7f49a4c6d 100644
> --- a/arch/mips/kernel/vpe-cmp.c
> +++ b/arch/mips/kernel/vpe-cmp.c
> @@ -79,7 +79,6 @@ static void vpe_device_release(struct device *cd)
>  
>  static struct class vpe_class = {
>  	.name = "vpe",
> -	.owner = THIS_MODULE,
>  	.dev_release = vpe_device_release,
>  	.dev_groups = vpe_groups,
>  };
> -- 
> 2.40.0

I guess this should go the same way as commit 6e30a66433af, therefore

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
