Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F887600EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJQMQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiJQMQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:16:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942C5F7C7;
        Mon, 17 Oct 2022 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666008972; x=1697544972;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=uFcYUnvzlxFjwIdcINvXB3Xlr7FvW5/0qcQpjBQOg6A=;
  b=BtWuh28OVuoqujWFtmN3Aaj1EBeNXGiniivlELGTxg+lmOL7GTzErRgI
   YEKDqE8qBYk+SHX6XGPoFVAoTQZbk1czajU6oRhUP3WdKXCClYZ15xdKN
   7ERlei4AjZhNtHsSd4uzy6uZIAbWTGDieB2IT/84tnX4fd751wZv9s3l1
   Sa2Y+ByVlMuJ/a6M68g2SsC1EnvETZQ3dAkNzJWgxe4qDtBSeRhB/3Wlm
   ZSpNdy0aQ1kWysh7E48elo9x3bQNaU6Az16YxMU22DRS2MzwVNB7dzvqp
   7No4gfaxN6qZYf8FCqsVQEyTYGfYAxL2wq5repMJQaJ9144EHztyaLycr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="304522109"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="304522109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 05:15:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="659329582"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="659329582"
Received: from ohoehne-mobl4.ger.corp.intel.com ([10.251.213.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 05:15:53 -0700
Date:   Mon, 17 Oct 2022 15:15:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_omap: remove wait loop from Errata i202
 workaround
In-Reply-To: <Y00bmec4hvWxtnB5@linutronix.de>
Message-ID: <c91216ec-c7e7-df7b-463-ec17c76b7bc2@linux.intel.com>
References: <20221013112339.2540767-1-matthias.schiffer@ew.tq-group.com> <ea90b0ba-61bf-e56e-5120-9771122838cf@linux.intel.com> <Y00bmec4hvWxtnB5@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2074611745-1665999067=:5493"
Content-ID: <b867c7f5-9697-77c8-5411-c17c257debe@linux.intel.com>
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

--8323329-2074611745-1665999067=:5493
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <53c25a32-29f2-3144-5a56-f83eba10af72@linux.intel.com>

On Mon, 17 Oct 2022, Sebastian Andrzej Siewior wrote:

> On 2022-10-17 11:12:41 [+0300], Ilpo Järvinen wrote:
> > On Thu, 13 Oct 2022, Matthias Schiffer wrote:
> > 
> > > We were occasionally seeing the "Errata i202: timedout" on an AM335x
> > > board when repeatedly opening and closing a UART connected to an active
> > > sender. As new input may arrive at any time, it is possible to miss the
> > > "RX FIFO empty" condition, forcing the loop to wait until it times out.
> > 
> > I can see this problem could occur and why your patch fixes it.
> > 
> > > Nothing in the i202 Advisory states that such a wait is even necessary;
> > > other FIFO clear functions like serial8250_clear_fifos() do not wait
> > > either. For this reason, it seems safe to remove the wait, fixing the
> > > mentioned issue.
> > 
> > Checking the commit that added this driver and the loop along with it, 
> > there was no information why it would be needed there either.
> 
> I don't remember all the details but I do remember that I never hit it.
> The idea back then was to document what appears the problem and then
> once there is a reproducer address it _or_ when there is another problem
> check if it aligns with the output here (so that _this_ problem's origin
> could be this). This was part of address all known chip erratas and
> copied from omap-serial at the time so that the 8250 does not miss
> anything.
> Looking closer, this is still part of the omap-serial driver and it was
> introduced in commit
>    0003450964357 ("omap2/3/4: serial: errata i202: fix for MDR1 access")

I found that one too but it doesn't give any explanation for it either.
In fact, the wait for empty is mysteriously missing from the itemized
description of the workaround in the commit message.

> If someone found a way to trigger this output which is unrelated to the
> expected cause then this is clearly not helping nor intended.
> 
> I would prefer to keep the loop and replace the disturbing output with a
> comment describing _why_ the FIFO might remain non-empty after a flush.
> 
> In worst cases that loop causes a delay of less than 0.5ms while setting
> a baud rate so I doubt that this is causing a real problem.
> 
> Either way I would like to see Tony's ACK before this is getting removed
> as suggested in this patch.

Thanks for chimming in.

I went to do some lore searching and came across this thread (it should 
be added with Link: tag the patch regardless of its final form):
  https://lore.kernel.org/linux-omap/4BBF61FE.3060807@ti.com/


-- 
 i.
--8323329-2074611745-1665999067=:5493--
