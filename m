Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471916ED2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjDXQlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjDXQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:41:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532EC55B3;
        Mon, 24 Apr 2023 09:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E142F60F6F;
        Mon, 24 Apr 2023 16:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC84BC433EF;
        Mon, 24 Apr 2023 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682354463;
        bh=uyHcrWYj6DFzE+0LxApki9WRLl5S01nZPsV5WC15KpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhYxaezPtvWW13PKhdHdvdL00fE/tfUpdQ9siJEuYjK6wHRqz8fAhQyUMmsNb15PM
         DzYBfBF+REW7gsS2RFYZS4IYbLkBYhv13tbBAX9eh1zKILJgvmgcdd/poWm6nq/Y9k
         80oTWmyBcIxKUsYUNXbgXN0+wxPp8i78li59DfrY=
Date:   Mon, 24 Apr 2023 18:41:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Starke, Daniel" <daniel.starke@siemens.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] tty: n_gsm: add restart parameter to DLC specific
 ioctl config
Message-ID: <2023042453-dubbed-botany-2ed9@gregkh>
References: <20230424075251.5216-1-daniel.starke@siemens.com>
 <2023042438-whole-cannot-1945@gregkh>
 <DB9PR10MB588138A96EE5E7CE96E28221E0679@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
 <2023042459-humbly-confusing-9721@gregkh>
 <bdb4347-d0e9-96c5-031-ecc549a7d1cd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdb4347-d0e9-96c5-031-ecc549a7d1cd@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 04:20:00PM +0300, Ilpo Järvinen wrote:
> On Mon, 24 Apr 2023, Greg KH wrote:
> 
> > On Mon, Apr 24, 2023 at 11:03:26AM +0000, Starke, Daniel wrote:
> > > > > --- a/include/uapi/linux/gsmmux.h
> > > > > +++ b/include/uapi/linux/gsmmux.h
> > > > > @@ -58,7 +58,8 @@ struct gsm_dlci_config {
> > > > >  	__u32 priority;		/* Priority (0 for default value) */
> > > > >  	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
> > > > >  	__u32 k;		/* Window size (0 for default value) */
> > > > > -	__u32 reserved[8];	/* For future use, must be initialized to zero */
> > > > > +	__u32 restart;		/* Force DLCI channel reset? */
> > > > 
> > > > Why are you using a full 32 bits for just 1 bit of data here?  Why not
> > > > use a bitfield?
> > > 
> > > The ioctrl guide states:
> > >   Bitfields and enums generally work as one would expect them to,
> > >   but some properties of them are implementation-defined, so it is better
> > >   to avoid them completely in ioctl interfaces.
> > > 
> > > Therefore, I tried to avoid them here.
> > 
> > Then use a u8?
> 
> To add further, I think that the ioctl guidance tries to say that C 
> bitfields using :number postfix are not a good idea, not that much to 
> disallow flag like content within an integer type.

Agreed.
