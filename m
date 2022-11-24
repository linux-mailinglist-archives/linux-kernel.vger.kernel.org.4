Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD55637537
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKXJcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKXJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:32:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEDB122940
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:32:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 196EFB82738
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5E1C433D6;
        Thu, 24 Nov 2022 09:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669282325;
        bh=J0NwZnjrS0O8MoDomCIMQw6ef/tSlF82d6RB1VnCFX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKn+ulHbsn84kkDCubdAUf8zD6eWCGO/Gsi60LsOFC1MobLEzGvp9tgjT4aNv9Ffq
         FZUxh/RFl/FbwABMtOTtWB7O/TrspsBd1xdNiu7lmQ8YZwQ13QWImQvVWxcJpkxXfY
         f0MUwP+1amUKzDkSHZG0clEsZhTBYVPTJk8TrYru/Av5F9IylMMtQPZYIfMWuC4xfZ
         XwmSbH/vFzjKr9BxLRHZjIkvNnZbk4Yp5jW57B5EP2It27fzh8jTneILp0/dtiVnAu
         YKToq5UGLrtUgXURLMU6BnqLyN1P8JgGJfvzZniQm9aKmtZP4K8tVL9PNdSuzaMrxW
         bhVN/JjDHcBUA==
Date:   Thu, 24 Nov 2022 15:02:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3 2/4] soundwire: Provide build stubs for common
 functions
Message-ID: <Y386ERSr1EmkTYwk@matsya>
References: <20221121141406.3840561-1-ckeepax@opensource.cirrus.com>
 <20221121141406.3840561-3-ckeepax@opensource.cirrus.com>
 <Y374VPAQcX6MkG22@matsya>
 <20221124092231.GD105268@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124092231.GD105268@ediswmail.ad.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-11-22, 09:22, Charles Keepax wrote:
> On Thu, Nov 24, 2022 at 10:21:32AM +0530, Vinod Koul wrote:
> > On 21-11-22, 14:14, Charles Keepax wrote:
> > > Provide stub functions when CONFIG_SOUNDWIRE is not set for functions
> > > that are quite likely to be used from common code on devices supporting
> > > multiple control buses.
> > > 
> > > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > > +static inline int sdw_stream_add_slave(struct sdw_slave *slave,
> > > +				       struct sdw_stream_config *stream_config,
> > > +				       struct sdw_port_config *port_config,
> > > +				       unsigned int num_ports,
> > > +				       struct sdw_stream_runtime *stream)
> > > +{
> > > +	return 0;
> > 
> > Should this and other here not return error...? Indicating sdw is not
> > available..? Silently ignoring may not be very helpful in debugging
> > 
> 
> Yeah I was a little unsure which way to go on that, in the end I
> opted for returning zero as it was more likely code would get
> optimised out. But I am happy to switch to returning an error, it
> would as you say making debugging misconfigurations easier.
> -ENOSYS seems kinda reasonable I think.

Right, -ENOSYS seems to be apt here

-- 
~Vinod
