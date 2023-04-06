Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD346DA27A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbjDFUR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbjDFUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:17:26 -0400
Received: from cynthia.allandria.com (cynthia.allandria.com [50.242.82.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FE04493;
        Thu,  6 Apr 2023 13:17:25 -0700 (PDT)
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1pkW2s-0007P4-RX; Thu, 06 Apr 2023 13:17:22 -0700
Date:   Thu, 6 Apr 2023 13:17:22 -0700
From:   Brad Boyer <flar@allandria.com>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nubus: Don't list slot resources by default
Message-ID: <20230406201722.GA28362@allandria.com>
References: <1296c4d691bba057291246f067c191ef8a88531c.1680667933.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1296c4d691bba057291246f067c191ef8a88531c.1680667933.git.fthain@linux-m68k.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 02:12:13PM +1000, Finn Thain wrote:
> Some Nubus card ROMs contain many slot resources. A single Radius video
> card produced well over a thousand entries under /proc/bus/nubus/.
> Populating /proc/bus/nubus/ on a slow machine with several such cards
> installed takes long enough that the user may think that the system is
> wedged. All those procfs entries also consume significant RAM though
> they are not normally needed (except by developers).
> Omit these resources from /proc/bus/nubus/ by default and add a kernel
> parameter to enable them when needed.
> On the test machine, this saved 300 kB and 10 seconds.
> 
> Cc: Brad Boyer <flar@allandria.com>

Reviewed-by: Brad Boyer <flar@allandria.com>

> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> Changed since v3:
>  - Better commentary.
> Changed since v2:
>  - Added commentary.
>  - Moved declaration to nubus.h.
> Changed since v1:
>  - Expanded to cover all slot resources in procfs.
> ---
>  drivers/nubus/nubus.c | 13 ++++++++++---
>  drivers/nubus/proc.c  |  8 ++++----
>  include/linux/nubus.h |  1 +
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
> index f70ba58dbc55..f0c24d39f837 100644
> --- a/drivers/nubus/nubus.c
> +++ b/drivers/nubus/nubus.c
> @@ -32,6 +32,13 @@
>  
>  /* Globals */
>  
> +/* The "nubus.populate_procfs" parameter makes slot resources available in
> + * procfs. It's deprecated and disabled by default because procfs is no longer
> + * thought to be suitable for that and some board ROMs make it too expensive.
> + */
> +bool populate_procfs;
> +module_param(populate_procfs, bool, 0);
> +
>  LIST_HEAD(nubus_func_rsrcs);
>  
>  /* Meaning of "bytelanes":
> @@ -572,9 +579,9 @@ nubus_get_functional_resource(struct nubus_board *board, int slot,
>  			nubus_proc_add_rsrc(dir.procdir, &ent);
>  			break;
>  		default:
> -			/* Local/Private resources have their own
> -			   function */
> -			nubus_get_private_resource(fres, dir.procdir, &ent);
> +			if (populate_procfs)
> +				nubus_get_private_resource(fres, dir.procdir,
> +							   &ent);
>  		}
>  	}
>  
> diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
> index 2c320a84fd72..1808accb8214 100644
> --- a/drivers/nubus/proc.c
> +++ b/drivers/nubus/proc.c
> @@ -55,7 +55,7 @@ struct proc_dir_entry *nubus_proc_add_board(struct nubus_board *board)
>  {
>  	char name[2];
>  
> -	if (!proc_bus_nubus_dir)
> +	if (!proc_bus_nubus_dir || !populate_procfs)
>  		return NULL;
>  	snprintf(name, sizeof(name), "%x", board->slot);
>  	return proc_mkdir(name, proc_bus_nubus_dir);
> @@ -72,7 +72,7 @@ struct proc_dir_entry *nubus_proc_add_rsrc_dir(struct proc_dir_entry *procdir,
>  	char name[9];
>  	int lanes = board->lanes;
>  
> -	if (!procdir)
> +	if (!procdir || !populate_procfs)
>  		return NULL;
>  	snprintf(name, sizeof(name), "%x", ent->type);
>  	remove_proc_subtree(name, procdir);
> @@ -157,7 +157,7 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
>  	char name[9];
>  	struct nubus_proc_pde_data *pded;
>  
> -	if (!procdir)
> +	if (!procdir || !populate_procfs)
>  		return;
>  
>  	snprintf(name, sizeof(name), "%x", ent->type);
> @@ -176,7 +176,7 @@ void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
>  	char name[9];
>  	unsigned char *data = (unsigned char *)ent->data;
>  
> -	if (!procdir)
> +	if (!procdir || !populate_procfs)
>  		return;
>  
>  	snprintf(name, sizeof(name), "%x", ent->type);
> diff --git a/include/linux/nubus.h b/include/linux/nubus.h
> index 392fc6c53e96..50c9145808d1 100644
> --- a/include/linux/nubus.h
> +++ b/include/linux/nubus.h
> @@ -93,6 +93,7 @@ extern struct bus_type nubus_bus_type;
>  
>  /* Generic NuBus interface functions, modelled after the PCI interface */
>  #ifdef CONFIG_PROC_FS
> +extern bool populate_procfs;
>  void nubus_proc_init(void);
>  struct proc_dir_entry *nubus_proc_add_board(struct nubus_board *board);
>  struct proc_dir_entry *nubus_proc_add_rsrc_dir(struct proc_dir_entry *procdir,
> -- 
> 2.37.5
> 
