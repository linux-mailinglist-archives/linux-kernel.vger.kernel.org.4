Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17AC6223A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 07:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKIGF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 01:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIGF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 01:05:27 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D61F2C4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 22:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667973918; bh=UpryTxk0IC1D/WMl2KTZAYMoVR3gBZrWsZdRJgHrtjs=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Vjez+ZUQz+YVS2zskN33qFt+2hTguqOjUIzliYtsRiQjMa+X4ZLdwzpY4edNaHv2R
         zTbw7yVxlnyROdgByvz31jkvqYb29MODVcSYw37myKcs9w0kOb44WoDjeDNjogDAzs
         qCa0jxxjHE4sVOdlVL0SwTiHOZFCI07ormEsbmhg=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed,  9 Nov 2022 07:05:18 +0100 (CET)
X-EA-Auth: 9O9s//cR3T3uVW5c+r20zFbSlAD3wPMpc1d79hUcLPbruqOtS1v938YK+F3h6BzfmWPLTG2mmS3HaBy4uoXaGvOcK6RzFNYu
Date:   Wed, 9 Nov 2022 11:35:12 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fieldbus: convert snprintf to scnprintf
Message-ID: <Y2tDGEorM8dkmdB2@qemulion>
References: <Y2K2MD7+WBu4QouU@qemulion>
 <Y2pyCA/tRunNVRQt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2pyCA/tRunNVRQt@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:13:12PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 02, 2022 at 11:55:52PM +0530, Deepak R Varma wrote:
> > It is recommended to use scnprintf instead of snprintf to accurately
> > return the size of the encoded data. Following article [1] has details
> > on the reason for this kernel level migration. This issue was identified
> > using coccicheck.
> >
> > [1] https://lwn.net/Articles/69419/
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >  drivers/staging/fieldbus/dev_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
> > index 5aab734606ea..d51f2b02d5e6 100644
> > --- a/drivers/staging/fieldbus/dev_core.c
> > +++ b/drivers/staging/fieldbus/dev_core.c
> > @@ -70,7 +70,7 @@ static ssize_t card_name_show(struct device *dev, struct device_attribute *attr,
> >  	 * card_name was provided by child driver, could potentially be long.
> >  	 * protect against buffer overrun.
> >  	 */
> > -	return snprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
> > +	return scnprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
>
> No, neither of these are correct.
>
> Please use sysfs_emit() for sysfs show callbacks.

Hello Greg,
Thank you. I corrected and resubmitted the patch as suggested.

Hi Julia,
The device_attr_show.cocci file should have made the recommendation to use
the sysfs_emit(), however, in this case it instead suggested to use scnprintf.
Is it because the method name was not "show" but "xxx_show"?

Thank you,
./drv

>
> thanks,
>
> greg k-h


