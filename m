Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EDD63A2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiK1IWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiK1IWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:22:22 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45DD167FF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1669623723; bh=HoI7IPlyKWHD9Kn5X10ZHl3UFFv8o6ZZDjqQm365fyQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=cY6XYfSBgOawZ8YaNqeXmP6jyxqpCZFYLNI28OoXMK4A3C+p/hdakSydDk/j2WtkM
         LAjmXY72W2MxJlE/Yk8FNSzAikJWRnwPoKgf77JKw62a6eJWCYK/85VLDkbgwg+ddD
         XEgUh2eWj5nAWTbQc9o0ahVB52aumbNZhohYlvBw=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 28 Nov 2022 09:22:03 +0100 (CET)
X-EA-Auth: Z5uIHs5CpSgjU332Ikz4u8b+XZa03kuBLMdLqLTeFqTcZc5po3StYuaZUVJMKCr04rF8s2HCvhTHZ/3OSytxENj19ruxRHel
Date:   Mon, 28 Nov 2022 13:51:58 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Y4RvpvpmFL8zNvfB@qemulion>
References: <Y3YKhee8L+kAfHM4@qemulion>
 <Y3YvGdkyGm7azGg4@kroah.com>
 <Y3Y1N6AwWEXLpSrx@qemulion>
 <Y3Z3aatcaISvqURJ@kroah.com>
 <Y3jqUpNOygJ4+2jy@qemulion>
 <Y4RnJyiCDYavLAJq@qemulion>
 <Y4RoOxgo76Hc5RRP@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4RoOxgo76Hc5RRP@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:50:19AM +0300, Dan Carpenter wrote:
> On Mon, Nov 28, 2022 at 01:15:43PM +0530, Deepak R Varma wrote:
> > On Sat, Nov 19, 2022 at 08:08:15PM +0530, Deepak R Varma wrote:
> > > On Thu, Nov 17, 2022 at 07:03:21PM +0100, Greg Kroah-Hartman wrote:
> > > > On Thu, Nov 17, 2022 at 06:50:55PM +0530, Deepak R Varma wrote:
> > > > > On Thu, Nov 17, 2022 at 01:54:49PM +0100, Greg Kroah-Hartman wrote:
> > > > > > On Thu, Nov 17, 2022 at 03:48:45PM +0530, Deepak R Varma wrote:
> > > > > > >
> > > > > > >  struct hfa384x_pdr_refdac_measurements {
> > > > > > > -	u16 value[0];
> > > > > > > +	DECLARE_FLEX_ARRAY(u16, value);
> > > > > > >  } __packed;
> > > > > >
> > > > > > Why?  This structure is never used anywhere, right?  So why is this
> > > > > > needed to be changed and not just removed entirely?  Same for the other
> > > > > > structures in this patch.
> > > > >
> > > > > Hello Greg,
> > > > > I am unable to confirm that these structures are truly not needed in the absence
> > > > > if a real device based testing. I could only validate that using the compile
> > > > > build and driver loading.
> > > >
> > > > Think this through, if no one is actually using this structure, and it
> > > > is of 0 size, then do you think it is being used?
> > >
> > > Hello Greg,
> > > I did not find any memory allocation for these zero length array structures.
> > > Also, the union or its enclosing structure do not appear to access the members.
> > > Hence I am leaning towards concluding that these zero length array structures do
> > > not appear to be necessary.
> > >
> > > There are a few other structures that are part of the same union, however, they
> > > too do not appear to be used for accessing the memory assigned to the union [or
> > > its enclosing structure]. I think most of the members of these unions can be
> > > replaced by one max size structure of this union [e.g. struct
> > > hfa384x_pdr_mkk_measurements].
> > >
> > > Could you please comment if I am reading the code right?
> > >
> > > For your quick reference, the zero length structure declaration are online 963
> > > whereas the union is on line number 1080 of the file drivers/staging/wlan-ng/hfa384x.h
> >
> > Hello Greg,
> > can you please suggest how should I approach this clean-up/correction?
> >
>
> Like this:

Thank you Dan. This takes me back to the very first version of this patch. I
will send in the clean up.

./drv

>
> diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
> index 0611e37df6ac..6a3df58c9e9c 100644
> --- a/drivers/staging/wlan-ng/hfa384x.h
> +++ b/drivers/staging/wlan-ng/hfa384x.h
> @@ -959,10 +959,6 @@ struct hfa384x_pdr_nicid {
>  	u16 minor;
>  } __packed;
>
> -struct hfa384x_pdr_refdac_measurements {
> -	u16 value[0];
> -} __packed;
> -
>  struct hfa384x_pdr_vgdac_measurements {
>  	u16 value[0];
>  } __packed;
> @@ -1077,7 +1073,6 @@ struct hfa384x_pdrec {
>  		struct hfa384x_pdr_mfisuprange mfisuprange;
>  		struct hfa384x_pdr_cfisuprange cfisuprange;
>  		struct hfa384x_pdr_nicid nicid;
> -		struct hfa384x_pdr_refdac_measurements refdac_measurements;
>  		struct hfa384x_pdr_vgdac_measurements vgdac_measurements;
>  		struct hfa384x_pdr_level_comp_measurements level_compc_measurements;
>  		struct hfa384x_pdr_mac_address mac_address;
>


