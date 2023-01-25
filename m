Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9321667AFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjAYK3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjAYK3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:29:15 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23EE4C32;
        Wed, 25 Jan 2023 02:29:13 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P20Mj69d9z688jJ;
        Wed, 25 Jan 2023 18:25:05 +0800 (CST)
Received: from localhost (10.81.208.142) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 10:29:10 +0000
Date:   Wed, 25 Jan 2023 10:29:09 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/mbox: Add debug messages for enabled mailbox
 commands
Message-ID: <20230125102909.00002403@Huawei.com>
In-Reply-To: <20230125085728.234697-1-rrichter@amd.com>
References: <20230125085728.234697-1-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.208.142]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023 09:57:28 +0100
Robert Richter <rrichter@amd.com> wrote:

> Only unsupported mailbox commands are reported in debug messages. A
> list of enabled commands is useful too. Change debug messages to also
> report the opcodes of enabled commands. Esp. if card initialization
> fails there is no way to get this information from userland.
> 
> On that occasion also add missing trailing newlines.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Fine with change in message
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2:
>  * Changed message to "Opcode 0x%04x enabled\n". Updated patch
>    description accordingly.
> 
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a48ade466d6a..202d49dd9911 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -629,11 +629,12 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
>  
>  		if (!cmd) {
>  			dev_dbg(cxlds->dev,
> -				"Opcode 0x%04x unsupported by driver", opcode);
> +				"Opcode 0x%04x unsupported by driver\n", opcode);
>  			continue;
>  		}
>  
>  		set_bit(cmd->info.id, cxlds->enabled_cmds);
> +		dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);
>  	}
>  }
>  
> 
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2

