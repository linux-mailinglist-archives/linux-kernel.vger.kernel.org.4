Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E294663D05A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiK3IXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbiK3IXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:23:13 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96678282
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:23:12 -0800 (PST)
X-UUID: e15af86f09524a93b1bb2e33569ce7fc-20221130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1ih/5AZ7VH4p7skGfYkFy1TDMephGSqfFTBm8ZbhGsk=;
        b=FcII+bSoo/NSaB5tOGDmAEsu7MGK95o6KlK8dPvz3utWjM39luFj66v5AwcXxcYbBXDUzJ4or5BA7khTg4kYXgfTcSdSCD8hq3Wu1ZNo/KtbHQ4kdUl14790zpL6nAd9B/GeZQuGKjInwYHTiLY2xQX88A5m1+BeWJ3c2POv8Yk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:986dd338-f3c8-46fc-a91d-0f4026fa5e46,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.14,REQID:986dd338-f3c8-46fc-a91d-0f4026fa5e46,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:dcaaed0,CLOUDID:f52c216c-41fe-47b6-8eb4-ec192dedaf7d,B
        ulkID:221130162307VUMOZIKQ,BulkQuantity:0,Recheck:0,SF:28|17|19|48|102,TC:
        nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e15af86f09524a93b1bb2e33569ce7fc-20221130
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <andrew.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1755579773; Wed, 30 Nov 2022 16:23:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 30 Nov 2022 16:23:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 30 Nov 2022 16:23:06 +0800
From:   Andrew Yang <andrew.yang@mediatek.com>
To:     <rostedt@goodmis.org>
CC:     <andrew.yang@mediatek.com>, <casper.li@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mhiramat@kernel.org>
Subject: Re: [PATCH v2] mm/writeback: fix dereferencing NULL mapping->host
Date:   Wed, 30 Nov 2022 16:23:03 +0800
Message-ID: <20221130082303.30859-2-andrew.yang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221130082303.30859-1-andrew.yang@mediatek.com>
References: <20221129095620.4c1a8056@gandalf.local.home>
 <20221130082303.30859-1-andrew.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-29 at 09:56 -0500, Steven Rostedt wrote:
> On Tue, 29 Nov 2022 11:32:59 +0800
> Andrew Yang <andrew.yang@mediatek.com> wrote:
> 
> > From: "andrew.yang" <andrew.yang@mediatek.com>
> > 
> > Check before dereferencing mapping->host
> > 
> > Signed-off-by: andrew.yang <andrew.yang@mediatek.com>
> > ---
> >  include/trace/events/writeback.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/writeback.h
> > b/include/trace/events/writeback.h
> > index 86b2a82da546..56f6e114d3ed 100644
> > --- a/include/trace/events/writeback.h
> > +++ b/include/trace/events/writeback.h
> > @@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(writeback_folio_template,
> >  		strscpy_pad(__entry->name,
> >  			    bdi_dev_name(mapping ?
> > inode_to_bdi(mapping->host) :
> >  					 NULL), 32);
> > -		__entry->ino = mapping ? mapping->host->i_ino : 0;
> > +		__entry->ino = mapping && mapping->host ? mapping-
> > >host->i_ino : 0;
> 
> I hate remembering precedence. Can we add parenthesis around this to
> be
> clear?
> 
> 		__entry->ino = (mapping && mapping->host) ? mapping-
> >host->i_ino : 0;
> 
> Thanks,
> 
> -- Steve
> 
> 
> >  		__entry->index = folio->index;
> >  	),
> >  
> 
> 
Sure, that's a good suggestion
