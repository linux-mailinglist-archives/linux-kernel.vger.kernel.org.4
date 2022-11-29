Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2374563C33A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiK2O4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbiK2O41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:56:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF4F5F8F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE7F96179C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55648C433C1;
        Tue, 29 Nov 2022 14:56:24 +0000 (UTC)
Date:   Tue, 29 Nov 2022 09:56:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrew Yang <andrew.yang@mediatek.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Casper Li <casper.li@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mm/writeback: fix dereferencing NULL mapping->host
Message-ID: <20221129095620.4c1a8056@gandalf.local.home>
In-Reply-To: <20221129033304.4465-1-andrew.yang@mediatek.com>
References: <20221129033304.4465-1-andrew.yang@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 11:32:59 +0800
Andrew Yang <andrew.yang@mediatek.com> wrote:

> From: "andrew.yang" <andrew.yang@mediatek.com>
> 
> Check before dereferencing mapping->host
> 
> Signed-off-by: andrew.yang <andrew.yang@mediatek.com>
> ---
>  include/trace/events/writeback.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 86b2a82da546..56f6e114d3ed 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(writeback_folio_template,
>  		strscpy_pad(__entry->name,
>  			    bdi_dev_name(mapping ? inode_to_bdi(mapping->host) :
>  					 NULL), 32);
> -		__entry->ino = mapping ? mapping->host->i_ino : 0;
> +		__entry->ino = mapping && mapping->host ? mapping->host->i_ino : 0;

I hate remembering precedence. Can we add parenthesis around this to be
clear?

		__entry->ino = (mapping && mapping->host) ? mapping->host->i_ino : 0;

Thanks,

-- Steve


>  		__entry->index = folio->index;
>  	),
>  

