Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDAA695777
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjBND3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBND3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:29:15 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D467617CC5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676345354; x=1707881354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BuoAC+qEMmR3CjmH12htgWfOLvyg89Oblgx670snAuY=;
  b=UsM7+PIxBcbWF93CuCbcriciUOnrv9+8rJ9QJBvTHdxgFeI3rEAYWcum
   zj/xv0n0Yx/fm1bnKRLT0Q5nuBxe+xo9uy0BrjxPEGznp8xgvGDV9krCx
   1Avris3jSETsEB3JJjqfMY0w6YrC/ZbcDWur5rjZPlTM4tPPyuCU5tffS
   g/QI0Im+NRm7W/VTP0vwkhD5rt4VznYqoDiOL/91HbK24/Q7cm3IUYcmp
   om7wYssRNIGxCMAIPTchQjd7iqQ1ZzknOsOd3fR4VG9vu6WwV8jKNkJUG
   SOdcYjcAMNv2Bq1VpjydKPQbNt0wqCN5/jabmubmOJ1SUqIIICzgpZg6k
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="335201561"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 11:29:14 +0800
IronPort-SDR: xVYVylDQ/Sl4cb50EMN2vBKWkx6WG+olI3JVYiqf9+afB/n8fbRFwS86i5XedLncMBfCWUSwX0
 482IonnuDGUoVubmOVZlEGNBVnhGXwehsp/crCYtNxfYR70mtkdvzANpeRKTNta1ITplsUpS7E
 Uub/TghzDlgPrkW84YaHjTCy1kiQVU2TXGbk6D8Q236CeHxCbu4l2kKu55JRO4O1VSGhgOUfB/
 uVobsNyM27vRsOFRRhibrZv4UGhyPA+2H844whUddAFrlWzbfz0i/Cnsd4OkxbahVFjCjZ3Nr9
 lyU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 18:46:22 -0800
IronPort-SDR: KkhjXNoJ8dbhXO+rDCplADgnZhmMe+Q22LbNGlb9lL7Sitq9fjpUIsmJYfJKrLYJKkp8vB/S3H
 8UoeSnQZY+GwQfrkkyY6BRkGckjaI3zNw+IidAKVjlP9H7VYFAMpGKYCwuCPrbIax7PaJXgBSI
 YuJU7KgHFIwx4cmPr0dkvW9nrwMrmRXxTVkQExdArx6sLE24BN6sLbJ8N8S39o1Ar7K4TeTKfD
 YgygsiUUCjUBxOrRvO3oEHDVCjPkggpzOPu1S5NKToXh5pqenBsZAC3BZjf5RBhlXXBI29755L
 YVA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 19:29:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PG6Bf0Gw6z1RvTp
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:29:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676345353; x=1678937354; bh=BuoAC+qEMmR3CjmH12htgWfOLvyg89Oblgx
        670snAuY=; b=uWWsdQ4wpDa7GFWu9TnZ82/w3oxW3oLX9CQRi+yF3TSHq/07XzW
        M0G0Rv0Y9PqbN/D899p7wN5G2vAJe6JBKLsWGzDiKtTBDwE3s0i7mFBR1i7wZYGJ
        Lwy3ZL1PoCfhkosehSwOiatYMogcebYIMt5qxqOmsdnrrxDuUa8m1AQ0+rnLExW4
        sY6/6Eze8NP5iXFV0yici9iUQJoKIbFcojItI0Bee7fQoi3Zp69mmkfIDK0vNAC1
        wHK7vnJPNoI69bgaLv4AJtMKr7X5f8qYxU8MT+G+XmG35x2L4PYA2jCPynm6pPBj
        5zoJVZnZqfE6q7Xk7WtASz/+pqqqbVNmf+Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1hLa519_tFOL for <linux-kernel@vger.kernel.org>;
        Mon, 13 Feb 2023 19:29:13 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PG6Bc4XSkz1RvLy;
        Mon, 13 Feb 2023 19:29:12 -0800 (PST)
Message-ID: <86c6d901-2dc6-7b3c-c72d-effb7f08b12b@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 12:29:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ata: pata_octeon_cf: drop kernel-doc notation
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230213212549.29914-1-rdunlap@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230213212549.29914-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 06:25, Randy Dunlap wrote:
> Fix a slew of kernel-doc warnings in pata_octeon_cf.c by changing
> all "/**" comments to "/*" since they are not in kernel-doc format.
> 
> Fixes: 3c929c6f5aa7 ("libata: New driver for OCTEON SOC Compact Flash interface (v7).")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202302101722.5O56RClE-lkp@intel.com/
> Cc: David Daney <ddaney@caviumnetworks.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-ide@vger.kernel.org

Applied to for-6.2-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

