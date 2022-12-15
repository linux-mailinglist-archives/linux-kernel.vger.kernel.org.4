Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8A64D673
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLOG2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLOG2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:28:51 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923A240460;
        Wed, 14 Dec 2022 22:28:47 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6D84C201651;
        Thu, 15 Dec 2022 06:28:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a287.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A8E0B2016CD;
        Thu, 15 Dec 2022 06:28:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1671085720; a=rsa-sha256;
        cv=none;
        b=nGj6FT9KVCXxA2zur75cDXE9fb9MVRxceO+jmve6QMPO8SLrYP2qpSmIKifep8RU8lUJg9
        UplQJ7eqlP0iRK5fCwY55UXjWMqaK9f+Hxht+B5KSS12oOwXmwkAslTTnQXotHDVRNYQSx
        7UAJ4sZ1gfGnuW3V2dQqjPyjt4r523rfgyoHtm+8yAET4KjM5BqtvYaGHMGmIIc3M/Zy7+
        YHd6CqpUUMj8MgOejU3L+67Gu+ewgpxUcGjdl/zu9uI0HMiQ+7q8hkEy18flzHFDt8lXuO
        I4BdIgk7T/RFsCTgtdWg61OVjD4L8LocGcZVXRAEdfr873FMV3Zt8bf6I0yJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1671085720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=rTg/hrEgFnTmjf3jWgL2o0w4H6DYsDRlWCqZWD+vU08=;
        b=wFfvpSoh7aJxCWRehUhLD8a0CwZzGuI0bi8+xkCiYDUN4gVlEhs24sl3uWL4WmV0WGpCJ7
        GRsGmbzAd+FfatAHoJreTvP0gcTe18AZ4vldZYbEf5O/6FgXOLU0ftXqI3Cg3WnGuuh17t
        2vVPU4hzYBaH5PU1ZlkW3brJg8lnt2dZxlQ+X+f6Hkm8kuRAKUHZuNL64x5tL6c2EJ4A8u
        0UJTbwU0g7JSjPrh/AjUa/DwaQKVLNGjGz3IGfawtDNcvfbLYlt6w9S6UObSPvdejU/xJM
        IIX7oyc4FvpyrASuAWHydfKFWSn72pilH3zv/AtNcz17GA/JAVjtxwwfaPvcxw==
ARC-Authentication-Results: i=1;
        rspamd-747d4f8b9f-86xsz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Tank: 297de34a4db54a2a_1671085722687_1858771830
X-MC-Loop-Signature: 1671085722687:1469500728
X-MC-Ingress-Time: 1671085722687
Received: from pdx1-sub0-mail-a287.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.82 (trex/6.7.1);
        Thu, 15 Dec 2022 06:28:42 +0000
Received: from offworld (unknown [104.36.25.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a287.dreamhost.com (Postfix) with ESMTPSA id 4NXj3q6TY4z6m;
        Wed, 14 Dec 2022 22:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1671085720;
        bh=rTg/hrEgFnTmjf3jWgL2o0w4H6DYsDRlWCqZWD+vU08=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Cxw4MW8q6z72K+MdjUQdUo6gh/5iRtIMhwEQuthgHvtKpX+I/qVDkzLDpGx1XBqH4
         zVFJ+Xg+IQ44cULLWjmMgMThs/H3w6zKaLhBYkCE3Y0xj+4+euj7i2u5Vc36Yo7ip+
         ho6oLZAHBZY+qzrYO6zwEOsKx2bDQGobUDk6JOGBobIOYDQBKD3Xwk8LO6j0bciTEE
         hTjWg4gTP0ddh7reyblAm6awrY/aJBWj1XuUDBLgDDczVMDEaBoIKFGbw6Zyragt/R
         i81frbhCM/kH5fwMl472EognxiiMh2TXjIup7R1vTa2ExkSpEaXd7PHh7jrxb2o+3y
         Z2wmgn6LWfw7Q==
Date:   Wed, 14 Dec 2022 22:04:10 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: fix null dereference on probe for missing
 ACPI_COMPANION()
Message-ID: <20221215060410.2p653tgqw35q6wbz@offworld>
References: <20221209062919.1096779-1-mcgrof@kernel.org>
 <63937afd72956_579c1294eb@dwillia2-xfh.jf.intel.com.notmuch>
 <6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5kAt3WRgncTj26x@bombadil.infradead.org>
 <63991ec886e85_b05d1294a6@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5pU4XTchSKVqkjx@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y5pU4XTchSKVqkjx@bombadil.infradead.org>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022, Luis Chamberlain wrote:

>Groovy thanks. Progress, but still fails now on the cxl-xor-region.sh line 29
>
>https://gist.github.com/mcgrof/aeac639365a651bd77f143cf38eb7493

Unrelated, but looking at this log I noticed that we should limit the amount
of noise "Bypassing cpu_cache_invalidate_memregion() for testing" emits.

Thanks,
Davidlohr

-----8<-------------------------------------
[PATCH] cxl/region: Only warn about cpu_cache_invalidate_memregion() once

No need for more than once per region.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
  drivers/cxl/core/region.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b1281f528d7f..f367d1c10357 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2006,8 +2006,7 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
  
  	if (!cpu_cache_has_invalidate_memregion()) {
  		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
-			dev_warn(
-				&cxlr->dev,
+			dev_WARN_ONCE(&cxlr->dev, 1,
  				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
  			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
  			return 0;
-- 
2.38.1


