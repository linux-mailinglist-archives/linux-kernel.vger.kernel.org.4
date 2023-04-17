Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A646E4F72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjDQRm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQRm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:42:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC725BBA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FD07623B4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72040C433D2;
        Mon, 17 Apr 2023 17:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681753343;
        bh=w2BWWAchNfElToV1aaP+MpeRVXTcpVmibFa7E+Pi9Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6ccUZwaeutv/D1T8ns4r9zC0dbjAmmoAzEhLfPfAB/U6Rx3kpCXB5S2azevX3yh1
         tsB6LC0jgP7AHrc1oloJlfVsDkjnydLNJvZOZwVYWBlmiGxKhxp/MjEsM/s0HaYz7k
         ql55PhIxvgCrRUWuR2y9jQTmjRKfq1ggdwrB7EuM=
Date:   Mon, 17 Apr 2023 19:42:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Denis Efremov (Oracle)" <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Wade Mealing <wmealing@redhat.com>
Subject: Re: [PATCH] driver core: class: mark the struct class for sysfs
 callbacks as constant
Message-ID: <2023041746-control-lunchtime-48b1@gregkh>
References: <20230325084537.3622280-1-gregkh@linuxfoundation.org>
 <6f6e01f2-b485-40c2-30fe-7b7ebbdb4010@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f6e01f2-b485-40c2-30fe-7b7ebbdb4010@linux.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 05:53:17PM +0400, Denis Efremov (Oracle) wrote:
> Hello,
> 
> On 3/25/23 12:45, Greg Kroah-Hartman wrote:
> > struct class should never be modified in a sysfs callback as there is
> > nothing in the structure to modify, and frankly, the structure is almost
> > never used in a sysfs callback, so mark it as constant to allow struct
> > class to be moved to read-only memory.
> > 
> > While we are touching all class sysfs callbacks also mark the attribute
> > as constant as it can not be modified.  The bonding code still uses this
> > structure so it can not be removed from the function callbacks.
> >
> 
> ...
> 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index b7bb52f8dfbd..3feadfb96114 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -2424,8 +2424,8 @@ static int zram_remove(struct zram *zram)
> >   * creates a new un-initialized zram device and returns back this device's
> >   * device_id (or an error code if it fails to create a new device).
> >   */
> > -static ssize_t hot_add_show(struct class *class,
> > -			struct class_attribute *attr,
> > +static ssize_t hot_add_show(const struct class *class,
> > +			const struct class_attribute *attr,
> >  			char *buf)
> >  {
> >  	int ret;
> > @@ -2438,11 +2438,10 @@ static ssize_t hot_add_show(struct class *class,
> >  		return ret;
> >  	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
> >  }
> > -static struct class_attribute class_attr_hot_add =
> > -	__ATTR(hot_add, 0400, hot_add_show, NULL);
> > +static CLASS_ATTR_RO(hot_add);
> >  
> > -static ssize_t hot_remove_store(struct class *class,
> > -			struct class_attribute *attr,
> > +static ssize_t hot_remove_store(const struct class *class,
> > +			const struct class_attribute *attr,
> >  			const char *buf,
> >  			size_t count)
> >  {
> 
> This looks like a security regression (CVE-2020-10781).
> Previous fix 853eab68afc80f59f36bbdeb715e5c88c501e680.

{sigh}  You would have thought I would have insisted on a big comment
here about this.  I'll do so this time, thanks for letting me know.

greg k-h
