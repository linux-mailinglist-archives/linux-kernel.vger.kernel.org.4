Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A9637923
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKXMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKXMmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:42:35 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB98815818
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:42:32 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id AECD3230D;
        Thu, 24 Nov 2022 13:42:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669293750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZKIn1cANNx+S4Yd+waIX76jsdNjbQtyrqMrAFlCrOw=;
        b=k+FOs5psBNiw8LVp3JHliZBh0Q/Id/T74+a4pqlWLf/8bdxQZWjW+VH5tLHLpKfammqHqc
        e0/9gu3bDuhRVFBHtFE3PXK3w95kH2u4Qen6ZLr9x4YTEy0H/ePs2NWEtZaZgUVR6Dfw+n
        2Ug7k8WCrwmMkb1binZhbOHMkKuoyp1bKNcpg+/wrpSvy4LUmkrwhYsRU7B9ItHMciufnk
        xK12tmh2BU1VIN6XpIgznFvMljGJCWd03wKM5N1zVwJn87kW0QYyKN6y17jsgrB57z87Nh
        fnIJV+Bi9GpRW6iTieU0lbulrzZVel7/rpcv88v7ST4zW5BozcnBun3ZwYlMSg==
MIME-Version: 1.0
Date:   Thu, 24 Nov 2022 13:42:30 +0100
From:   Michael Walle <michael@walle.cc>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        pratyush@kernel.org, richard@nod.at, tudor.ambarus@microchip.com,
        vigneshr@ti.com
Subject: Re: [PATCH 0/2] These are the required patches I found while adding
In-Reply-To: <20221124114713.132514-1-nathan.morrison@timesys.com>
References: <bb6c006a27184ffa0e4ab9303cffcc72@walle.cc>
 <20221124114713.132514-1-nathan.morrison@timesys.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d812e89c0c8d00f0043463dda241ece5@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-11-24 12:47, schrieb Nathan Barrett-Morrison:
> Ah yes, I just realized we're effectively using the device in 1S-1S-8S
> extended SPI mode, so the 0xC7 setting is probably not required.  We
> were never able to get DTR mode working on the IS25LX256. I can fix
> this patch up so it's more explicit about what's going on here.
> 
> The 8S-8S-8S support in core.c is still going to be used for another
> OSPI device I'm porting over from an older kernel.

Can you link a datasheet? The problem with 8s8s8s is that it needs
mode switching which can be footgun. And IMHO it doesn't provide
significant performance improvements over 1s8s8s.

> Would you like me to separate these patches, fix up the ISSI once, and 
> resubmit?

Yes please. Also, I've seen that you use flags in the flash_info table.
Please have a look if that information can be deduced from the SFDP. 
E.g.
does a flash describe if it supports 1s1s8s.

-michael
