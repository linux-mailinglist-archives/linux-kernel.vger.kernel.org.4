Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C42730E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243160AbjFOFKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243096AbjFOFKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:10:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1272697;
        Wed, 14 Jun 2023 22:09:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7450167373; Thu, 15 Jun 2023 07:09:47 +0200 (CEST)
Date:   Thu, 15 Jun 2023 07:09:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hannes Reinecke <hare@suse.de>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: Fwd: Waking up from resume locks up on sr device
Message-ID: <20230615050947.GA5053@lst.de>
References: <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com> <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org> <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net> <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org> <37ed36f0-6f72-115c-85fb-62ef5ad72e76@suse.de> <b0fdf454-b2f7-c273-66f5-efe42fbc2807@kernel.org> <859f0eda-4984-4489-9851-c9f6ec454a88@rowland.harvard.edu> <41b069c7-8723-4507-3e5a-1d1878db9002@kernel.org> <20230615044015.GA4720@lst.de> <9633f1a6-2e33-4a40-3fdb-0c1c4e4cd720@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9633f1a6-2e33-4a40-3fdb-0c1c4e4cd720@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:57:37PM +0900, Damien Le Moal wrote:
> > No.  scsi_device_get just increments a reference count, and thus
> > prevents ->release from beeing called.  ->remove is not in any way
> > affected by the refcount.
> 
> What ->remove cb are you talking about ? The gendev one ?

The one for the device locked.

> I am trying to understand why the use of device_lock() helps in any way given
> that this is not used by any other functions in scsi. And given that

The device model locks the device before calling ->remove.

> scsi_rescan_device() should always be called with a ref on the scsi device (and
> so on the gendev as well) held, why would this function be racy with device remove ?

Because ->remove ould otherwise be called at the same time as ->rescan.

> Note that I did find a couple of places where scsi_rescan_device() seems to not
> be called with a reference to the scsi dev held, e.g.  store_rescan_field() and
> store_state_field().

You need both a valid reference and ensure ->remove is not called at the
same time.
