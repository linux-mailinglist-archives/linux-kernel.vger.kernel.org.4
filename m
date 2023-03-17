Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3926BE1C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCQHNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCQHNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:13:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA7351FA4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16A69621AF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27925C433D2;
        Fri, 17 Mar 2023 07:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679037220;
        bh=EMox3uAJdc454qzosMEHyqhK1IpB/SyLPpxJcdBDMJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RoDHeXffgYoGLwNwon+Lc6Bnl+yTo4PTXHv8ZHsZbCIsWF1u/Y82MILsxpobukDD6
         UXMmrExB81yHrf1nQwwxasJ4V/T0+depmydn2uOH97S1M8aGHgy64gbGtQsfR+BHTM
         IHrTvLePspIq/y8SsTQ0QBDU4BZmAuXuIrVIEH+w=
Date:   Fri, 17 Mar 2023 08:13:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] staging: axis-fifo: initialize timeouts in init only
Message-ID: <ZBQTIVk0zsgv1hMH@kroah.com>
References: <ZBN3XAsItCiTk7CV@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBN3XAsItCiTk7CV@khadija-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 01:09:00AM +0500, Khadija Kamran wrote:
> Initialize the module parameters, read_timeout and write_timeout once in
> init().
> 
> Module parameters can only be set once and cannot be modified later, so we
> don't need to evaluate them again when passing the parameters to
> wait_event_interruptible_timeout().

I feel like we are being too picky here, but this isn't the correct
wording.  It is possible for module parameters to be modified "later",
if the permissions on the parameter are set to allow this.  But that's
not what this driver does here, so this might be better phrased as:

  The module parameters in this driver can not be modified after
  loading, so they can be evaluated once at module load and set to
  default values if needed at that time.

> Convert datatype of {read,write}_timeout from 'int' to 'long int' because
> implicit conversion of 'long int' to 'int' in statement
> '{read,write}_timeout = MAX_SCHEDULE_TIMEOUT' results in an overflow.
> 
> Change format specifier for {read,write}_timeout from %i to %li.

You are listing all of _what_ you do here, not really _why_ you are
doing any of this.

Anyway, if I were writing this, here's what I would say as a changelog
text:

  The module parameters, read_timeout and write_timeout, are only ever
  evaluated at module load time, so set the default values then if
  needed so as to not recompute the timeout values every time the driver
  reads or writes data.


And that's it, short, concise, and it explains why you are doing this.

Writing changelog comments are almost always harder than actually
writing the patch (at least for me.)  So don't feel bad, it take a lot
of experience doing it.

All that being said, I think we are just polishing something that
doesn't need to really be polished anymore, so let me go just apply this
patch as-is to the tree now so you can move on to a different change.
You've put in the effort here, and I don't want you to get bogged down
in specifics that really do not matter at all overall (like the memory
size of your vm...)

thanks,

greg k-h
