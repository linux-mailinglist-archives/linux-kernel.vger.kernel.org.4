Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ADB65E7B5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjAEJYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjAEJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:24:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5E752754;
        Thu,  5 Jan 2023 01:24:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 777876192B;
        Thu,  5 Jan 2023 09:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E9DC433EF;
        Thu,  5 Jan 2023 09:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672910678;
        bh=03ktq11msv1fl4+Xm6amAN3K5P1DMn42R8tV0I59SQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBai+HNuSyHDjpq4DnSeWq9scKDA9t6gNgQ/GO31nzYPwqCQnnV1p2c+UEQudL0V6
         wCji4fPgytplhij6Nd1zJOJZwoAGPqWQoZ6K1ynHEeI8aq7gzBVvJJOLLB+1ncMt4N
         d1ugzbxtfci6PbVEDvs8FS9ge9K4Rkah7IDqNn74MmoTf1vN3yw+buFMPCVOtd6kv3
         eZJ5ZGPBLTRSwFrEE3pkfi9h/b4ZjhY6g5jRnQFkvTFY8qkDOLhFlfHXwRoY5xTIqO
         eUDv6bKIDsSUFEi7jPJqK2lsqN1RwXmiOxBmWPfol50hbfplEaiIVlS57rsKRRekvb
         yDows7/hNFULg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pDMUh-00052Z-MP; Thu, 05 Jan 2023 10:25:03 +0100
Date:   Thu, 5 Jan 2023 10:25:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] serial: Make uart_handle_cts_change() status param
 bool
Message-ID: <Y7aXb0ywmGsV2+tZ@hovoldconsulting.com>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-10-ilpo.jarvinen@linux.intel.com>
 <1a25b930-e003-6326-86ab-4d8cdc9b7da5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a25b930-e003-6326-86ab-4d8cdc9b7da5@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 07:23:49AM +0100, Jiri Slaby wrote:
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

Yeah, adding the missing hyphens should improve things:

	new clear-to-send status, true if active

Johan
