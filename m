Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA795F7497
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJGHJh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Oct 2022 03:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJGHJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:09:32 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AE6C0983
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:09:31 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id E4E8E140E88;
        Fri,  7 Oct 2022 07:09:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id B10081A;
        Fri,  7 Oct 2022 07:09:18 +0000 (UTC)
Message-ID: <070d253e718c1a6d72fb52c1d2f02ec461d825a1.camel@perches.com>
Subject: Re: [PATCH v2 1/3] mtd: mtdoops: change printk() to counterpart pr_
 functions
From:   Joe Perches <joe@perches.com>
To:     Ray Zhang <sgzhang@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Oct 2022 00:09:26 -0700
In-Reply-To: <20221007065042.700761-2-sgzhang@google.com>
References: <20221007065042.700761-1-sgzhang@google.com>
         <20221007065042.700761-2-sgzhang@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: B10081A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: qkebrjbky9z3nipsjqqg8geia3skbunk
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+FNvk3gUfk70cxn43bf8wSIzJGdFCb53o=
X-HE-Tag: 1665126558-206398
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-07 at 06:50 +0000, Ray Zhang wrote:
> To comply with latest kernel code requirement, change printk() to
> counterpart pr_ functions in mtdoops driver:
> - change printk(INFO) to pr_info()
> - change printk(DEBUG) to pr_debug()

There is a different behavior with printk(KERN_DEBUG to pr_debug(
as pr_debug is a no-op unless dynamic debugging is enabled or
DEBUG is defined.

And even with dynamic_debug, the output is default disabled unless
DEBUG is defined.

As is, printk(KERN_DEBUG is emitted unless the console level is low.

> diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
[]
> @@ -120,8 +120,8 @@ static void mtdoops_inc_counter(struct mtdoops_context *cxt)
>  		return;
>  	}
>  
> -	printk(KERN_DEBUG "mtdoops: ready %d, %d (no erase)\n",
> -	       cxt->nextpage, cxt->nextcount);
> +	pr_debug("mtdoops: ready %d, %d (no erase)\n",
> +		 cxt->nextpage, cxt->nextcount);
>  }

etc...

