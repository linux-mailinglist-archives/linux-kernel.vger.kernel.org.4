Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70EB66D1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjAPWok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjAPWoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:44:38 -0500
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C4223C4F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:44:36 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 68AA3200E8;
        Mon, 16 Jan 2023 23:44:35 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DRqu8HdldLja; Mon, 16 Jan 2023 23:44:35 +0100 (CET)
Received: from begin (adijon-658-1-86-31.w86-204.abo.wanadoo.fr [86.204.233.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 31A8F200E2;
        Mon, 16 Jan 2023 23:44:35 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1pHYDS-0010kh-2N;
        Mon, 16 Jan 2023 23:44:34 +0100
Date:   Mon, 16 Jan 2023 23:44:34 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Linux console tools development discussion 
        <kbd@lists.altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [kbd] [patch] font: Leverage KD_FONT_OP_GET/SET_TALL font
 operations
Message-ID: <20230116224434.sjo2ez4j6l4av4bc@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Alexey Gladkov <legion@kernel.org>,
        Linux console tools development discussion <kbd@lists.altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
References: <20221218003209.503539532@ens-lyon.org>
 <20221218003339.263695493@ens-lyon.org>
 <Y78VRTF6cxHhio+s@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y78VRTF6cxHhio+s@example.org>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov, le mer. 11 janv. 2023 21:00:05 +0100, a ecrit:
> > @@ -54,13 +55,13 @@ do_loadfont(struct kfont_context *ctx, i
> >  	int bad_video_erase_char = 0;
> >  	int ret;
> >  
> > -	if (height < 1 || height > 32) {
> > -		KFONT_ERR(ctx, _("Bad character height %d"), height);
> > +	if (height < 1 || height > 64) {
> > +		KFONT_ERR(ctx, _("Bad character height %d (limit is 64)"), height);
> 
> Hm. But max_font_height is 128. Shouldn't it be height > 128 ?
> 
> >  		return -EX_DATAERR;
> >  	}
> >  
> > -	if (width < 1 || width > 32) {
> > -		KFONT_ERR(ctx, _("Bad character width %d"), width);
> > +	if (width < 1 || width > 128) {
> > +		KFONT_ERR(ctx, _("Bad character width %d (limit is 128)"), width);
> 
> Same here. max_font_width is 64.

Oops, sure, fixed it, will send an updated kbd patch for that.

Samuel
