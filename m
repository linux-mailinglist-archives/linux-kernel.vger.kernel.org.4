Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF46BFB92
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCRQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCRQeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:34:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ABA35ED2;
        Sat, 18 Mar 2023 09:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A773B8010F;
        Sat, 18 Mar 2023 16:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6846FC433EF;
        Sat, 18 Mar 2023 16:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679157256;
        bh=P83LJcLdhyh1KSfLVhNDG8VtTGDadRLfj8sYgOvrXV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gvy55D3aIms95994EJPnIxuC5Z08gcrSdRUZKl6JZySBmeVjV/2hgSoSSClhVtWx3
         xeqyka2sWSKR5ukT36yDxQQK35wrGW/gEoCW4EC9kwKV3ojk5GnuYFJG+qrx0azseF
         CUTmXt/DVWflU3nbti6SD/ZPZ4lxFmouuIoR3MId25hIT2FWO1j5SvC3+KM82EUHED
         XiJ3w2aV9i7s51JMSCAZRspOzwL1IKAafmn3B+GAWwVCsna7d7aJXPR3n2VXMEO7+S
         mi5Lf7yyr5EogTSUNqaVrTf5gThPPDgbC8eK2YJawR+gDHPf0AGlRUs3MsvzHI2bCR
         NBX5IgL4H2Ggw==
Date:   Sat, 18 Mar 2023 16:49:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <20230318164909.06123384@jic23-huawei>
In-Reply-To: <9d63c161-0449-7e56-5873-2909587f17af@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
        <9895826669118a1aa1db3f85c2610fa759426c33.1677750859.git.mazziesaccount@gmail.com>
        <ZAC7L8NQYgBcBTCF@smile.fi.intel.com>
        <7e537200-37ab-f6e6-c4e0-c3997128c01b@fi.rohmeurope.com>
        <ZAXK9Hn2NuQPJ7eo@smile.fi.intel.com>
        <1dbfc336-7d09-cd44-dfa2-9c4bedf257e1@gmail.com>
        <ZA81rpWgwvP2bigt@smile.fi.intel.com>
        <9d63c161-0449-7e56-5873-2909587f17af@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 12:28:43 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 3/13/23 16:39, Andy Shevchenko wrote:
> > On Mon, Mar 13, 2023 at 01:31:42PM +0200, Matti Vaittinen wrote:  
> >> On 3/6/23 13:13, Andy Shevchenko wrote:  
> >>> On Fri, Mar 03, 2023 at 07:54:22AM +0000, Vaittinen, Matti wrote:  
> >>>> On 3/2/23 17:05, Andy Shevchenko wrote:  
> >>>>> On Thu, Mar 02, 2023 at 12:57:54PM +0200, Matti Vaittinen wrote:  
> > 
> > ...
> >   
> >>>>>> +		for (i = 0; !ret && i < gts->num_avail_all_scales; i++)  
> >>>>>
> >>>>> Much easier to read if you move this...
> >>>>>  
> >>>>>> +			ret = iio_gts_total_gain_to_scale(gts, all_gains[i],
> >>>>>> +					&gts->avail_all_scales_table[i * 2],
> >>>>>> +					&gts->avail_all_scales_table[i * 2 + 1]);  
> >>>>>
> >>>>> ...here as
> >>>>>
> >>>>> 		if (ret)
> >>>>> 			break;  
> >>>>
> >>>> I think the !ret in loop condition is obvious. Adding break and brackets
> >>>> would not improve this.  
> >>>
> >>> It moves it to the regular pattern. Yours is not so distributed in the kernel.  
> >>
> >> I believe we can find examples of both patterns in kernel. I don't think the
> >> "many people use different pattern" is a great reason to add break +
> >> brackets which (in my eyes) give no additional value to code I am planning
> >> to keep reading also in the future...  
> > 
> > The problem is that your pattern is not so standard (distributed) and hence
> > less maintainable.  
> 
> I am sorry but I can't really agree with you on this one. For me adding 
> the break and brackets would just complicate the flow and thus decrease 
> the maintainability.

I'm with the if (ret) break;
school of thought on this one.  Never like for loops with complex conditions,
I guess because I've trained my eyes to ignore them ;)


