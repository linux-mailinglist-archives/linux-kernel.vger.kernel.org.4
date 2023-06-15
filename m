Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81943730E01
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbjFOEUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjFOET7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:19:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D399DB5;
        Wed, 14 Jun 2023 21:19:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F09962833;
        Thu, 15 Jun 2023 04:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24716C433C0;
        Thu, 15 Jun 2023 04:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686802797;
        bh=6w3Ac2sW/D9uKqEUzYR74GAo6gQ6Xqm5ESXkJ7H1Rw8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SSI8agk+QOqUjSdy0743aVJWbQfv1aUghucJI4fNC76I7I0DvCwy/AIP3qjl8TFxl
         ssvEzRmcXAweUNWue23gi3y58551MpSxq6X0VWchUeq8CI9lBiMeV/Y/uKbhWSWpj+
         k4KmWmuSiflVy6XjWuRp0zQGdw/sNqExWelysR5G9zp5xflpSET5ioUE77e8oFxmL4
         zsP7iRjev2dYIHl7lzTNOKMBC44Ne+TLbaDeD0ZVR3MfWkAHe+JJAKmWuNiD+9qAPd
         ZAHBQzQz6RHSUgw8NVJl/HTh61OT77XU37NFr4dtNaClss+kPCIfdVBjfwjJF7ghaU
         LUQOBmfQaG5Bw==
Message-ID: <4aa13708-9318-fd2b-cc28-166f13c31dd1@kernel.org>
Date:   Thu, 15 Jun 2023 13:19:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230615134334.1d81c413@canb.auug.org.au>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230615134334.1d81c413@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 12:43, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the scsi-mkp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from <command-line>:
> ./usr/include/linux/ioprio.h:107:8: error: unknown type name '__always_inline'
>   107 | static __always_inline __u16 ioprio_value(int class, int level, int hint)
>       |        ^~~~~~~~~~~~~~~
> ./usr/include/linux/ioprio.h:107:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'ioprio_value'
>   107 | static __always_inline __u16 ioprio_value(int class, int level, int hint)
>       |                              ^~~~~~~~~~~~
> 
> Caused by commit
> 
>   bfaaaa3d9d09 ("scsi: block: Improve ioprio value validity checks")
> 
> I have used the scsi-mkp tree from next-20230614 for today.

Not sure how this is triggered as I have no error compiling (using gcc)...

Martin,

I believe this should fix the issue:

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index 7310449c0178..92a769b9786d 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -2,6 +2,9 @@
 #ifndef _UAPI_LINUX_IOPRIO_H
 #define _UAPI_LINUX_IOPRIO_H

+#include <linux/stddef.h>
+#include <linux/types.h>
+
 /*
  * Gives us 8 prio classes with 13-bits of data for each class
  */

Could you squash this fix in the ioprio patch you just queued ? Or I can send a fix.

Thanks !

-- 
Damien Le Moal
Western Digital Research

