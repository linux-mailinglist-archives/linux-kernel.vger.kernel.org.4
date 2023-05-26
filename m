Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5EA713066
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbjEZXcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjEZXcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD31B3;
        Fri, 26 May 2023 16:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81B7E6164E;
        Fri, 26 May 2023 23:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535EAC433EF;
        Fri, 26 May 2023 23:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685143935;
        bh=/0vymfkAdw1recl4sGqHGeYrshRrN6p3/WDK2YtCvCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJ+Th8bOxPgozXv+iTjvBkK6Db2uNreVnP7bfKVgxSj4o7/SEUk/tEdeWa3cqnFkz
         URd8F0BqiK9Myw9rRlK6Ry6wPxH1Jf+rsSBWFUIMTqepXw3vyk9IziNY5cLjW+4EQW
         ieNPtXCcoHljdlKYpkiYQVPjwQtbAlUiVcffUvziHUt3ckgqYJEz5AVJ1hS1K6N0BX
         jt8nYkzVkpYScxiSDkoCgz/7cN4fVKd98hVsMScgme4eXAdlJ6NiwtKqPLWUdmd9Om
         r5kYjdlAgPQ5T/AAMHhil0BgTBIdtpG4cH0h9eyW/BMWnm/s8Tu0KqmucxkRb+7bB4
         A7kdIPT5CZh/w==
Date:   Fri, 26 May 2023 16:36:04 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     andy.shevchenko@gmail.com
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 5/5] firmware: qcom_scm: Add multiple download mode
 support
Message-ID: <20230526233604.3eiqbfrkecir3ga5@ripper>
References: <1680076012-10785-1-git-send-email-quic_mojha@quicinc.com>
 <1680076012-10785-6-git-send-email-quic_mojha@quicinc.com>
 <ZHEvWpCqg_oyWyZW@surfacebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHEvWpCqg_oyWyZW@surfacebook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 01:14:50AM +0300, andy.shevchenko@gmail.com wrote:
> Wed, Mar 29, 2023 at 01:16:52PM +0530, Mukesh Ojha kirjoitti:
> > Currently, scm driver only supports full dump when download
> > mode is selected. Add support to enable minidump as well as
> > enable it along with fulldump.
> 
> ...
> 
> >  #define QCOM_DOWNLOAD_MODE_MASK 0x30
> >  #define QCOM_DOWNLOAD_FULLDUMP	0x1
> > +#define QCOM_DOWNLOAD_MINIDUMP  0x2
> > +#define QCOM_DOWNLOAD_BOTHDUMP	(QCOM_DOWNLOAD_FULLDUMP | QCOM_DOWNLOAD_MINIDUMP)
> 
> Now order is broken.
> 
> >  #define QCOM_DOWNLOAD_NODUMP	0x0
> 
> ...
> 
> > @@ -1420,13 +1422,16 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -
> 
> Stray change and ping-pong style at the same time.
> 
> ...
> 
> >  	if (download_mode == QCOM_DOWNLOAD_FULLDUMP)
> >  		len = sysfs_emit(buffer, "full\n");
> > +	else if (download_mode == QCOM_DOWNLOAD_MINIDUMP)
> > +		len = sysfs_emit(buffer, "mini\n");
> > +	else if (download_mode == QCOM_DOWNLOAD_BOTHDUMP)
> 
> > +		len = sysfs_emit(buffer, "full,mini\n");
> 
> Why not "both" ?
> 

"both" isn't very future proof (and I think we've had additional
variations in the past already), so I asked for this form.

Many thanks for your thorough review, Andy!

Regards,
Bjorn

> >  	else if (download_mode == QCOM_DOWNLOAD_NODUMP)
> >  		len = sysfs_emit(buffer, "off\n");
> 
> 
> With an array (for streq_match_string() call suggested earlier) this become as
> simple as
> 
> 	if (mode >= ARRAY_SIZE(...))
> 		return sysfs_emit("Oh heh!\n");
> 
> 	return sysfs_emit("%s\n", array[mode]);
> 
> ...
> 
> > -	if (sysfs_streq(val, "full")) {
> 
> Why changing this line?
> 
> > +	if (sysfs_streq(val, "full,mini") || sysfs_streq(val, "mini,full")) {
> > +		download_mode = QCOM_DOWNLOAD_BOTHDUMP;
> 
> It's way too hard, esp. taking into account that once user enters wrong order,
> user can't simply validate this by reading value back.
> 
> Use "both" and that's it.
> 
> > +	} else if (sysfs_streq(val, "full")) {
> >  		download_mode = QCOM_DOWNLOAD_FULLDUMP;
> > +	} else if (sysfs_streq(val, "mini")) {
> > +		download_mode = QCOM_DOWNLOAD_MINIDUMP;
> 
> ...
> 
> >  module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
> >  MODULE_PARM_DESC(download_mode,
> > -		 "Download mode: off/full or 0/1 for existing users");
> > +		"download mode: off/full/mini/full,mini or mini,full and 0/1 for existing users");
> 
> You really must be consistent with at least a couple of things:
> 1) capitalization;
> 2) indentation.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
