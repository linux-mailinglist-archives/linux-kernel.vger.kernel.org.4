Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6AD73D8E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjFZHxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFZHxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:53:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5F6196;
        Mon, 26 Jun 2023 00:53:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 72B8C67373; Mon, 26 Jun 2023 09:53:25 +0200 (CEST)
Date:   Mon, 26 Jun 2023 09:53:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 08/24] init: pass root_device_name explicitly
Message-ID: <20230626075325.GA26851@lst.de>
References: <20230531125535.676098-1-hch@lst.de> <20230531125535.676098-9-hch@lst.de> <c1391658-d785-4b2f-ba7e-01e4668685d7@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1391658-d785-4b2f-ba7e-01e4668685d7@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 05:08:59PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Wed, May 31, 2023 at 02:55:19PM +0200, Christoph Hellwig wrote:
> > Instead of declaring root_device_name as a global variable pass it as an
> > argument to the functions using it.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> This patch results in the following build error when trying to build
> xtensa:tinyconfig.
> 
> WARNING: modpost: vmlinux: section mismatch in reference: strcpy.isra.0+0x14 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
> ERROR: modpost: Section mismatches detected.

I can reproduce these with gcc 13.1 on xtensa, but the report makes
no sense to me.  If I disable CONFIG_CC_OPTIMIZE_FOR_SIZE it now reports
a similar warning for put_page intead of strcpy which seems just as
arcance. 

