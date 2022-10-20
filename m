Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF656063C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJTPDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJTPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:03:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC9F1CA581
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A492AB826A0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1682DC433D6;
        Thu, 20 Oct 2022 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666278196;
        bh=hlfPKZEbTmed7NpShUig/8Be18OKbYMn0Oun2O92ALs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLrHTMrAy+82YppzhZasrvjycaCCO74azKjkt2cLLyQ9nAu5U17NAoJ/+qJ8Yl/rD
         VTbu4faNuai4Q13YmbgOHqMoQG7F/A2BwRyIJ3FBEgnpqrCpORukotbL4dM2Ikgv9M
         5HCi8BvH1eiiSn2RQZbMUo7R6h6eszAWYbcW45qw=
Date:   Thu, 20 Oct 2022 17:03:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: Re: [PATCH v4 1/2] staging: most: dim2: read done_buffers count
 locally from HDM channel
Message-ID: <Y1FjMrGHc2CdDCPQ@kroah.com>
References: <cover.1666208065.git.drv@mailo.com>
 <83fd237d2ac157d234e9c7cce1206904c2d8773d.1666208065.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83fd237d2ac157d234e9c7cce1206904c2d8773d.1666208065.git.drv@mailo.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:24:53AM +0530, Deepak R Varma wrote:
> The function dim_get_channel_state only serves to initialize the ready and
> done_buffers fields of the structure passed as its second argument. In
> service_done_flag, this structure is never used again and the only purpose
> of the call is to get the value that is put in the done_buffers field.
> But that value is just the done_sw_buffers_number field of the call's
> first argument.  So the whole call is useless, and we can just replace it
> with an access to this field.

Are you sure it is useless?

You have changed the logic here, you are now thinking that this value
can never change, while before you were ensured of getting the "correct"
value as it is under the lock when the function is called.

I can't take this type of change as a "cleanup" patch for outreachy
unless you have the hardware as it is NOT a basic "checkpatch" style
cleanup at all.

If you want to get this change accepted, please work with the maintainer
of the code and get them to agree that the change is correct.  And if it
is, odds are more things also would need to be cleaned up at the same
time, right?

thanks,

greg k-h
