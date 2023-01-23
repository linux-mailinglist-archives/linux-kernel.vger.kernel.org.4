Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE039678C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjAWXah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjAWXaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:30:35 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88EB17174
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 15:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674516634; x=1706052634;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3lBUQWNnwjuiaJATRUvrlUmP//VbNgiTH5V5gmyopKM=;
  b=Q1gfpzSLdmB5G+YwtUPZd/Vvbu17HtsvNxmnQD4prvS1Kl0f627ld/3H
   NbUZSb1VjB1uJiZ4qbm7sPjihjLBkYHvhwlFrZcNdlHPAxH1ZeJ6jFquW
   e6Ol4o88HYxJ8dI9x24JsQJa4u/Tzid01JYGxaIf2zmOSpUPZaOb3b6e1
   C6eYJzCY3D0M1zyoGi7P8LtlNLm/va31RT7jY30Tnxj08aTaU6HBbozTo
   NW82XRmK7j1OlUoX6GCCt1igwJyMggegvvwYt8fudoIrcKK7w4VXoJLDw
   2EHPQPqew8CGbhLw6xqMB/hdVc9dIPQ5xXjwwxGtAU5Ea/TrwpfZH2XsZ
   w==;
X-IronPort-AV: E=Sophos;i="5.97,240,1669046400"; 
   d="scan'208";a="221656609"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 07:30:32 +0800
IronPort-SDR: 3LQFxRub2mdYa9mPbgiPS/4AnZdhfCs2/93WhbPYQZFdxiFaDqotnT+8eD/rGwK1G4fOnKgpn7
 Z3z7Ha2PF04ZKJABPVAo0UKhFluqnp+XqLvCklfBvCSbLhHjm1yrawKXFDaqAVaiZ0ZHWZ2OT8
 89KxLuf8hUuTxm5GvarfS0Yu/C+Yepem7mek/LaWMdl0meOSyWLSD8XLKcTMGIcXQIlV2+KAiu
 iPrAlQm/X1gFclYW0nmkIw5R3CzmJSQVrpovkOCAmcLjWxVAhU8C6ZHpJbwUJv6ijQkvyW/3uG
 HVU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2023 14:42:21 -0800
IronPort-SDR: a1dkJQ4d/zpUA7fgJHws9szDK2GdpyyEkXiLKXwNJ8AHuYmFNTmjbeA5bBgqaTw2Pcu0b9hR+s
 XYl7hJKkhjN2RxyeZWg1vHVpGGtHxHwV39SsNXZobg00Bac2Q9yS1zn9i7iyspCkeLEc/Ggdjx
 cUBjdtijz5+B3T+hYkTUH/sdiz+JyH3+nHp3aGVVwS8Qmm3S99MWjV4/qUquAzX+zCSJ5YDx/4
 xkjKAQvPz+urSGXhg6oWYe0aooXstyjW21N21R7IU09YeTrZy8jXS74bYBtp3Oju5Bk+3gcHpd
 PVw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2023 15:30:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P15tw3W3Pz1Rwt8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 15:30:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674516631; x=1677108632; bh=3lBUQWNnwjuiaJATRUvrlUmP//VbNgiTH5V
        5gmyopKM=; b=VVOLmqsei+FhMOs3bMvMEY6jTbthYjyoMB81T+7vTWyoEjz7caQ
        J23eitrBN63MNPz129Wyk6k2r7VSXmSu/onUW1sTuVmehqV8fTL/3D2MHZJeyVwi
        VCcRc9ph0D0DOCIXMbq3CESnk7QhFjWS6rH/xxQs9BhAa03lyci7/UFB7Fj3OJrQ
        86lRwEeW5UeJXBTGMTZ6OWFVxGYwFybMRU/s/9mh62Qf43N/ox7YCDBb7WjoN9fE
        o9RmhQSJBFxjb3aiDmBaNw6hrDF+K5oGzl8+fHGnrnWVHtDyy+mCDcUmhAtkWDld
        tfI7jfE1Zerpx2NGCvrQbvlINZJkMK2t5YA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9OWvaFaFOIZ3 for <linux-kernel@vger.kernel.org>;
        Mon, 23 Jan 2023 15:30:31 -0800 (PST)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P15tt5cKgz1RvLy;
        Mon, 23 Jan 2023 15:30:30 -0800 (PST)
Message-ID: <87958074-baa4-b6c9-da0c-d654e4009611@opensource.wdc.com>
Date:   Tue, 24 Jan 2023 08:30:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: manual merge of the zonefs tree with the
 vfs-idmapping tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230124085951.59eb8da3@canb.auug.org.au>
 <1631b427-9efd-cd26-5dbc-0143097f859b@opensource.wdc.com>
 <20230124102535.1e21a533@canb.auug.org.au>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230124102535.1e21a533@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 08:25, Stephen Rothwell wrote:
> Hi Damien,
> 
> On Tue, 24 Jan 2023 07:31:18 +0900 Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
>>
>> Thanks for that. Do you want me to rebase my for-6.3/for-next branch on
>> these patches ? I need to retest everything anyway, so I might as well do
>> that.
> 
> You can only rebase on top of the vfs-idmapping tree if you get a
> guarantee that it is immutable.  In any case, it may be better to merge
> (an immutable subset) of the vfs-idmapping tree (and fix up the
> conflicts) rather than rebasing on top of it.

OK. I think I will merge the 3 patches that create the conflict and rebase
the patches. I need that for retesting at least. But given the size of the
conflict resolution, I may push that as an update to my for-6.3/for-next
branch. Let me see...

> Alternatively, just leave the fix up to Linus (but mention it to him
> when you send your pull requests).

Understood. Let me retest first :)

Thanks !

-- 
Damien Le Moal
Western Digital Research

