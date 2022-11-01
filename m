Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71286614C24
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiKAN5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiKAN44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:56:56 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CDD19293
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667311007; bh=JPykuD8T9RQ/X19Iy553YJXPe5shmR+PDc3N+UV36LM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=LsvL7w4sH6xdWYFWXXyoOslvKQ6yDfU6QLzOkeDjLSwrGe26I3dJflQT8s5GkVOxO
         e58Ltt0fUHBAAzOV83vV0uTX9hsFZoQRZcXjW5borNsl1mS4IeQVxD5qOayYteXPbU
         EuETj5+jUtzUkloL6vzRd7l6yglW++0GT27lqgxc=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Tue,  1 Nov 2022 14:56:47 +0100 (CET)
X-EA-Auth: 4QOZfuW4GsQ43Tu+jZwOt/civAdfEv1MQ4FFxftclqd4EwxLplnbk9yZxbE7MiajB8GRvec1vZR8ayTW+UHNqxdQ0YprlJCF
Date:   Tue, 1 Nov 2022 19:26:42 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Use flexible-array for one /
 zero-length arrays
Message-ID: <Y2Elmj2kvaWp5hw+@ubunlion>
References: <Y1vNNSSWK1EkcohT@ubunlion>
 <Y1vo+TjS/mWyT7Zc@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vo+TjS/mWyT7Zc@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 05:36:41PM +0300, Dan Carpenter wrote:
> On Fri, Oct 28, 2022 at 06:08:13PM +0530, Deepak R Varma wrote:
> > Flexible-array member should be used instead of one or zero member to
> > meet the need for having a dynamically sized trailing elements in a
> > structure. Refer to links [1] and [2] for detailed guidance on this
> > suggestion.
> >
> > [1] https://en.wikipedia.org/wiki/Flexible_array_member
> > [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> >
> > Issue identified using coccicheck.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >  drivers/staging/wlan-ng/p80211mgmt.h  | 8 ++++----
> >  drivers/staging/wlan-ng/p80211types.h | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
> > index 1ef30d3f3159..d6fe52de2c8f 100644
> > --- a/drivers/staging/wlan-ng/p80211mgmt.h
> > +++ b/drivers/staging/wlan-ng/p80211mgmt.h
> > @@ -229,14 +229,14 @@ struct wlan_ie {
> >  struct wlan_ie_ssid {
> >  	u8 eid;
> >  	u8 len;
> > -	u8 ssid[1];		/* may be zero, ptrs may overlap */
> > +	u8 ssid[];		/* may be zero, ptrs may overlap */
> >  } __packed;
>
> When you're writing this change look at where struct wlan_ie_ssid is
> used.  It's included in five different structs:
>
> 	struct wlan_ie_ssid *ssid;
>
> But none of those *ssid pointers are used.  So instead of doing this
> just delete the wlan_ie_ssid struct and delete every reference to it.
> Send that as a patch by itself and then repeat that process for the next
> struct.

Hello Dan and Pavel,
I have built a patch set based on your feedback on this (and the other similar
patch for r8188eu driver). I have only covered one driver for now and would wait
for feedback before I do the same thing for the other driver.

Thank you,
./drv

>
> regards,
> dan carpenter
>


