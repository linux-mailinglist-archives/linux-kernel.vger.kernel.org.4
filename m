Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B071968F299
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjBHPy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjBHPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:54:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FC747ED8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:54:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 687B9B81E96
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 15:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913AFC433D2;
        Wed,  8 Feb 2023 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675871665;
        bh=djqq+bhRYhiOz/s1OAO+4lN6tcxxoESNjtRKsHsAnBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1zIZ74iNLmmeoyf/v29bsO7D3YCZfiDFUuDbOB0AWFpWZ3/GvEFvV6kwy2lXKUf+E
         WShW2h8i2V9pYQMWwum/y/L9YaFNmqfI9M3O/lB4SetSuDS3NmVC4Oy5GMAOQ9OZwz
         NIEq48hJMFsY3fmBscD3gK6n45QUL4XQipsAPSNs=
Date:   Wed, 8 Feb 2023 16:54:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3] mtd: spi-nor: fix memory leak when using
 debugfs_lookup()
Message-ID: <Y+PFreHoRVB+5J+1@kroah.com>
References: <20230208145301.2169646-1-gregkh@linuxfoundation.org>
 <68d10a9b27a0a3894a290b28c1a22085@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d10a9b27a0a3894a290b28c1a22085@walle.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:28:45PM +0100, Michael Walle wrote:
> > +static void __exit spi_nor_module_exit(void)
> > +{
> > +	spi_nor_debugfs_shutdown();
> > +	spi_mem_driver_unregister(&spi_nor_driver);
> 
> Hm, does the order matter here? I didn't test it, but this will
> lead to:
> 
> rootdir = debugfs_create_dir("spi-nor", NULL);
> nor->debugfs_root = debugfs_create_dir("spi0", rootdir);
> debugfs_remove(rootdir);
> debugfs_remove(nor->debugfs_root);
> 
> If that's ok, then this looks good.

It's ok as the last call to debugfs_remove() will just fail as that
dentry is long gone.  Not the nicest, so I'll reverse them and send out
a v4 now.

thanks,

greg k-h
