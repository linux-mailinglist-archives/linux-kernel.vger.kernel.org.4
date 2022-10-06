Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AFE5F677C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiJFNPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJFNPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:15:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FD79E0C4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:15:09 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1ogQiM-00016t-Jp; Thu, 06 Oct 2022 15:15:02 +0200
Message-ID: <ba6223f9fcae7d27de439e75f93b3a1352a30890.camel@pengutronix.de>
Subject: Re: PROBLEM: Segfault in kconfig
From:   Johannes Zink <j.zink@pengutronix.de>
To:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
Date:   Thu, 06 Oct 2022 15:15:00 +0200
In-Reply-To: <33059074b78110d4717efe09b887dd28ac77fe7f.camel@pengutronix.de>
References: <33059074b78110d4717efe09b887dd28ac77fe7f.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone, 

On Thu, 2022-09-22 at 18:01 +0200, Johannes Zink wrote:
> Hi everyone, 
> 
> [1.] One line summary of the problem: 
>      kconfig crashes with segfault under rare circumstances
> [2.] Full description of the problem/report:
>      Under certain circumstances jump keys are displayed on the
> search 
>      results even if a symbol is deactivated by one of its 
>      dependencies. Using the jump keys then triggers a segmentation 
>      fault due to a NULL dereference. Perform the following steps to 
>      trigger the issue
>      
>      1.: ARCH=arm64 make defconfig
>      2.: ARCH=arm64 make menuconfig
> 
>      3.: press '/' key to search for the string "EFI". Use jump key 
>          (1) to jump to search result. Press 'n' key to deactivate
> the 
>          entry. 
>      4.: press '/' to seach for the string "ACPI". Use the jump key 
>          (1) to jump to the search result. 
> 
>      Menuconfig then crashes with a segfault.
>     
> [3.] Keywords (i.e., modules, networking, kernel):
>      kconfig, mconf
> [4.] Kernel information
> [4.1.] Kernel version (from /proc/version):
>        v6.0.0-rc6
> [4.2.] Kernel .config file: 
>        arm64 default defconfig
> [5.] Most recent kernel version which did not have the bug: 
>      v5.15
> [6.] Output of Oops.. message (if applicable) with symbolic
> information
>      resolved (see Documentation/admin-guide/bug-hunting.rst): 
>      not applicable
> [7.] A small shell script or example program which triggers the
>      problem (if possible):
>      not applicable, please see description in [2.]
> [8.] Environment
> [8.1.] Software (add the output of the ver_linux script here): 
>        not applicable
> [8.2.] Processor information (from /proc/cpuinfo):
>        not applicable
> [8.3.] Module information (from /proc/modules):
>        not applicable
> [8.4.] Loaded driver and hardware information (/proc/ioports,
> /proc/iomem):
>        not applicable
> [8.5.] PCI information ('lspci -vvv' as root):
>        not applicable
> [8.6.] SCSI information (from /proc/scsi/scsi):
>        not applicable
> [8.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
>        not applicable
> [X.] Other notes, patches, fixes, workarounds:
>     
>      I found that the attached patch is a very hacky workaround to 
>      keep menuconfig from crashing, but I am pretty sure the jump 
>      keys should not have be activated for unaccessable entries in
> the
>      first place. I found it quite hard to find the corresponding
> part
>      in mconf, which is why I decided to send this bugreport instead 
>      of sending a patch. Maybe someone on this list either knows
> mconf 
>      really well and can just fix it, or guide me to where I can dig 
>      around (though in that case I could really use some help on how 
>      to debug menuconfig, since I found it challenging to get it 
>      working with gdb)
>      
> Best regards
> Johannes
> 
> ---
> scripts/kconfig/mconf.c | 3 ++-                                      
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c       
> index 9d3cf510562f..60a82f701bd3 100644                              
> --- a/scripts/kconfig/mconf.c                                        
> +++ b/scripts/kconfig/mconf.c                                        
> @@ -447,7 +447,8 @@ static void search_conf(void)                    
>                 again = false;
>                 for (i = 0; i < JUMP_NB && keys[i]; i++)
>                         if (dres == keys[i]) {
> -                               conf(targets[i]->parent, targets[i]);
> +                               if (targets[i]->parent)              
> +                                       conf(targets[i]->parent,
> targets[i]);
>                                 again = true;
>                         }
>                 str_free(&res);
> 

Just a gentle ping and TL;DR on this issue: 

Menuconfig crashes with a segfault if performing the steps 

1.: ARCH=arm64 make defconfig
2.: ARCH=arm64 make menuconfig
3.: press '/' key to search for the string "EFI". Use jump key 
    (1) to jump to search result. Press 'n' key to deactivate
    the entry. 
4.: press '/' to seach for the string "ACPI". Use the jump key 
    (1) to jump to the search result. 

For more details please see the detailed report in the original
message.

Has anyone any input on this?

Best regards

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

