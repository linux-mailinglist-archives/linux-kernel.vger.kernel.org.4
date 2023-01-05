Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAAA65E721
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjAEIzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjAEIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:55:44 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4954FD72;
        Thu,  5 Jan 2023 00:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672908943; x=1704444943;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Z/V5RVW/Y8ahxEXJka+crfdLG01UX04CAHc7MpEuTwA=;
  b=hK7GF541nODLg3fN4K91x95lP52Mj6BzDfvZC+JOhaAhtRd9sTE6s35S
   HhcC5gEm8P/WXZbIKCfVVWYy+JYBbpRhw5qEAgmNPmCP/mOIJ9GxdBKti
   mT3arYndnZTtNn/iLOY/fuk2gbYOhelN3qNRt/WilW6s/ncjUG9r1DcF/
   MGoh8dik2Os/bJExhAjZ7mCRwvVAwVJFvSgLHSSjzvs5aHVS2mZnxgNjU
   FK/XXQ5YZapxtmD4XxjPqpXju6hIewiNMTErHcY5chrUqiygXv/+86F+2
   SUnmXOJGbuj/lTRBrPYCv/bSj5hu98WLGwVRBlGLuBLaNHbj406S3YLb8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="384447652"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="384447652"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 00:55:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="633081604"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="633081604"
Received: from khaunx-mobl1.ger.corp.intel.com ([10.252.35.181])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 00:55:39 -0800
Date:   Thu, 5 Jan 2023 10:55:37 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 09/10] serial: Make uart_handle_cts_change() status param
 bool
In-Reply-To: <1a25b930-e003-6326-86ab-4d8cdc9b7da5@kernel.org>
Message-ID: <4ba39dd7-c873-3715-fa5f-be5afb7386dc@linux.intel.com>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com> <20230104151531.73994-10-ilpo.jarvinen@linux.intel.com> <1a25b930-e003-6326-86ab-4d8cdc9b7da5@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-534257738-1672908907=:1832"
Content-ID: <5e5b256d-de44-b881-e18f-4a54c75f4f26@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-534257738-1672908907=:1832
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <1da92190-2ffd-89e-a652-9fd06a96e4c9@linux.intel.com>

On Thu, 5 Jan 2023, Jiri Slaby wrote:

> On 04. 01. 23, 16:15, Ilpo Järvinen wrote:
> > Convert uart_handle_cts_change() to bool which is more appropriate
> > than unsigned int.
> > 
> > Cleanup callsites from operations that are not necessary with bool.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ...
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -3285,11 +3285,11 @@ EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
> >   /**
> >    * uart_handle_cts_change - handle a change of clear-to-send state
> >    * @uport: uart_port structure for the open port
> > - * @status: new clear to send status, nonzero if active
> > + * @status: new clear to send status, true if active
> 
> ANyone else having troubles to parse "new clear to send status"?

I could change that into new clear-to-send status while at it.

> >    *
> >    * Caller must hold uport->lock.
> >    */
> > -void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
> > +void uart_handle_cts_change(struct uart_port *uport, bool status)
> 
> This should be "bool active" then.

Yeah. I'll change in the previous patch too which also had "status".

-- 
 i.
--8323329-534257738-1672908907=:1832--
