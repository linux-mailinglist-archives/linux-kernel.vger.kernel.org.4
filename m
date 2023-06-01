Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E420C719651
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjFAJEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjFAJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:03:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370F91B4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82C9A6123E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D17C433EF;
        Thu,  1 Jun 2023 09:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685610183;
        bh=ZhvPtf8o1gHFuycl5q0Cto3Q3OwC5tnXu9g31KhGie4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HhYgxLjtOnnlxdqUCJI5kDDNfOW2+lA29ho3n1RwGg5JrtMbKCbE5sEat2pYg+1M
         N55abpXChDCnmvp7byYKYVg+OSsFDd8q3UwhXe9aerlzLm2P2H7vPHMW0EA8K5mPTk
         XRUnwP8dh1hoendnoBiT4JCLt438cVgCDo0iEquc=
Date:   Thu, 1 Jun 2023 10:03:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <2023060142-thyself-flatware-26f7@gregkh>
References: <20230530100929.285235-1-miquel.raynal@bootlin.com>
 <20230530100929.285235-3-miquel.raynal@bootlin.com>
 <2023053132-divorcee-aqueduct-70fa@gregkh>
 <20230601105114.58749075@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601105114.58749075@xps-13>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 10:51:14AM +0200, Miquel Raynal wrote:
> > > +	/* Without exposed cells, successfully exit after
> > > assigning an empty attributes array */
> > > +	if (!ncells)
> > > +		goto unlock_mutex;  
> > 
> > Shouldn't this check be higher up _before_ you allocate any memory?
> > If the attribute group list is empty, nothing should be created,
> > right?  Or will the driver core crash?
> 
> As you rightfully guessed it, the core will crash if no list is
> provided at all. I need to provide an empty list with just an empty
> member and everything goes smoothly. 

Let's fix the core, it shouldn't crash like that :)

thanks,

greg k-h
