Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB8072DD84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbjFMJS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241920AbjFMJSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD65AE73
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5205F62926
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61408C433D2;
        Tue, 13 Jun 2023 09:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686647886;
        bh=gp+4Z1m750oiZIRymOwmqEvUZvz41fNPY9krBfP1984=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVGh3QOpVrxSHP9UZtItr+ntdS6qUPKsngq/pP32GnjqCUmJVvftIcD55a/PdaRWr
         qrss9Pxw5CMb3Vh8yF09ougsSYqgBQOkc/4gRjjhVqhecQxMn2qHeGhmTEX4PSoGY/
         qVGd70/5mhXvXVBRwld68AXTpT+ThEFuuPHz19z8=
Date:   Tue, 13 Jun 2023 11:18:04 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Wei-chin Tsai =?utf-8?B?KOiUoee2reaZiSk=?= 
        <Wei-chin.Tsai@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Lee =?utf-8?B?KOadjuWlh+mMmik=?= <Mel.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Ivan Tseng =?utf-8?B?KOabvuW/l+i7kik=?= 
        <ivan.tseng@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/1] process: export symbols for fork/exit tracing
 functions
Message-ID: <2023061331-stipulate-crumpled-97cb@gregkh>
References: <20230612151545.17810-1-Wei-chin.Tsai@mediatek.com>
 <2023061226-repugnant-upstate-a2b4@gregkh>
 <8fa623a77edd2d8b6ade77903d40b4c4c5992965.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fa623a77edd2d8b6ade77903d40b4c4c5992965.camel@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 09:12:38AM +0000, Wei-chin Tsai (蔡維晉) wrote:
> On Mon, 2023-06-12 at 18:37 +0200, Greg Kroah-Hartman wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Mon, Jun 12, 2023 at 11:15:41PM +0800, jim.tsai wrote:
> > > +static void class_create_release(struct class *cls)
> > > +{
> > > +/*do nothing because the mbraink class is not from malloc*/
> > > +}
> > 
> > Then the code is totally broken and wrong :(
> > 
> > Please just use the misc device api instead, it is much simpler and
> > doesn't have these types of errors.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Sorry, I did not really get the point from above comments because It
> works well for me for the mbraink_main.c and no compiler errors or
> runtime errors?

Think about why the kernel is trying to check if you have a release
function or not.  Would an "empty" function be the same thing?

That check was added to tell you that your design is wrong and needs to
be fixed, do NOT just try to paper over warnings from the kernel as
someone spent the time to try to be nice and tell you that the code is
incorrect :)

Anyway, almost all of these (if not all), can just go away if you move
to  use the miscdevice api instead.

Also, please don't send HTML email, the mailing lists reject it :(

thanks,

greg k-h
