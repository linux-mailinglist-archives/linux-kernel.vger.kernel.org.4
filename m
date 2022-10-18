Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF8C602863
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJRJdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJRJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:32:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2281AAE22A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD799B81BFB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85C9C433D7;
        Tue, 18 Oct 2022 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666085567;
        bh=fWwnKw7+HpVYjfMhWcSJ0NOMeXvzscZeINac+5n01PQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPE3ubQYJhdkk0bV4oKxJwPClYo8Hi8F7IX2U/AGWblnJsqybH8fhu5TJYT5zoHry
         WNOcSv7fQBFk1YKc2V+WSoU12N433sXqNYmdzmlL6yK/N+W+AKa9yp9oLg9+ZVkkkT
         Z6IvCc9Rk4vnvP4e2CBUnvM+2luyp6TQz1EbttjzsZkYk8SnKn1bjAMr3HL84mi0Gv
         YLKUh1/U8bLhWLoRG2QI0WcrrMKe52S/CNUNWTqHK03LJNJv3QeK/t//vWL4pabMgh
         SJRg50m9LR5dEWvozXMuVsnritMP37DhnmXQFFXM+JtoDseXaHEEUiuYWICO3g4RPV
         z05rcLBQki8GA==
Date:   Tue, 18 Oct 2022 10:32:43 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Urban <surban@surban.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: take OF node reference for MFD cell platform device
Message-ID: <Y05yu3o+SBL6s51H@google.com>
References: <20220917094132.458194-1-surban@surban.net>
 <YymHG4OmMktrRqof@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YymHG4OmMktrRqof@google.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022, Lee Jones wrote:

> On Sat, 17 Sep 2022, Sebastian Urban wrote:
> 
> > Properly increase OF node reference count when assigning it to a
> > platform device created for an MFD cell.
> > 
> > Signed-off-by: Sebastian Urban <surban@surban.net>
> > ---
> >  drivers/mfd/mfd-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index 16d1861e9682..8e57f67719cf 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -161,7 +161,7 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
> >  	of_entry->np = np;
> >  	list_add_tail(&of_entry->list, &mfd_of_node_list);
> >  
> > -	pdev->dev.of_node = np;
> > +	pdev->dev.of_node = of_node_get(np);
> 
> Doesn't this cause an imbalance?
> 
> Or is there already a put somewhere?

I can't accept this until you've answered my queries.

-- 
Lee Jones [李琼斯]
