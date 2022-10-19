Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D096360446A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiJSMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJSMDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:03:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBD62182B;
        Wed, 19 Oct 2022 04:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666179573; x=1697715573;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F4/v5xFdGeutzQlY/uK0xk51209qAd1LVCKjl8ZCvfY=;
  b=jIDiz0RF/ktVNTvvBBLdrzAOJ4D51jzob7uTrW4thUniVSTp8yerbyrD
   0RUrfXpAkjIn2q4wMUbYxNshACydiasZFd3jDY3k03DGkSqF+50d8kgVg
   ijJYHnsS+BTbvNZMfP10U3+LzuUfHu+KqlLTGbwxw5IqFHU36is5zPr4C
   J9fxHFAAi4rMQG79cn9JPXxdj0iX6/A6rDy8r0ONFH1wFbW+DQx421IvX
   pn64/1tNlUirdZqf4f2GL/kN/vmaVMt5r/9/JmyiYWHIG3RYUa5GX01Mx
   1P+c4hCMBVoMsMQTvClrSDH1fLAmUMywGzHfNFuRgIPGi9BTbCAvbTu6L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="308057632"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="308057632"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 03:31:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="804236884"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="804236884"
Received: from sponnura-mobl1.amr.corp.intel.com ([10.251.214.35])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 03:30:58 -0700
Date:   Wed, 19 Oct 2022 13:30:55 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tty: Convert tty_buffer flags to bool
In-Reply-To: <Y0/QhJBW1TapqrjC@kroah.com>
Message-ID: <7536939f-d46-a4fc-b987-53421849ce5a@linux.intel.com>
References: <20221019094241.10870-1-ilpo.jarvinen@linux.intel.com> <Y0/QhJBW1TapqrjC@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-861702288-1666175459=:1619"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-861702288-1666175459=:1619
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 19 Oct 2022, Greg KH wrote:

> On Wed, Oct 19, 2022 at 12:42:39PM +0300, Ilpo Järvinen wrote:
> > The struct tty_buffer has flags which is only used for storing TTYB_NORMAL.
> > There is also a few quite confusing operations for checking the presense
> > of TTYB_NORMAL. Simplify things by converting flags to bool.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/tty/tty_buffer.c   | 28 ++++++++++++++--------------
> >  include/linux/tty_buffer.h |  5 +----
> >  include/linux/tty_flip.h   |  4 ++--
> >  3 files changed, 17 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> > index 5e287dedce01..be3431575a19 100644
> > --- a/drivers/tty/tty_buffer.c
> > +++ b/drivers/tty/tty_buffer.c
> > @@ -107,7 +107,7 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
> >  	p->commit = 0;
> >  	p->lookahead = 0;
> >  	p->read = 0;
> > -	p->flags = 0;
> > +	p->flags = true;
> >  }
> >  
> >  /**
> > @@ -249,7 +249,7 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
> >   * __tty_buffer_request_room	-	grow tty buffer if needed
> >   * @port: tty port
> >   * @size: size desired
> > - * @flags: buffer flags if new buffer allocated (default = 0)
> > + * @flags: buffer flags if new buffer allocated
> 
> If all this does is store TTYB_NORMAL, why not name it "ttyb_normal"?
> Leaving it at "flags" and having that be a boolean is just confusing.

No, it's intentional.

"Flags" (as boolean) here refer to whether the buffer stores flag array 
along with the character data array. Previously it perhaps could be 
interpreted differently meaning that the member variable itself stored 
flags such as TTYB_NORMAL.

Flags is much better name than ttyb_normal, IMHO.

-- 
 i.

--8323329-861702288-1666175459=:1619--
