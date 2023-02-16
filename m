Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAA569945A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjBPMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjBPMaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:30:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29DD28D09
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:30:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53BC261FA9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 12:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1CCC433EF;
        Thu, 16 Feb 2023 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676550611;
        bh=/fQFLHBFP8/wIGlgaiTPaimScL2/GER3IjakdtyFA20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ri3L3bzLfZwmgkk4fKnfjjjJQ53xsiL5XN588kYH70ssaAXLuyo2I6xEjr/OsMXWm
         cXLEZ+HTDHhPB8UGOo9n+YJRNyP2XZqXbM1auMOnjTNyXorQrIcIdtA/l1UPPzOim1
         iQGkzguS8Zd/11sDrRSVjeMvNffeBKuPrnFjF/p4=
Date:   Thu, 16 Feb 2023 13:30:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, Arnd Bergmann <arnd@arndb.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>,
        Thang Nguyen <thang@os.amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>
Subject: Re: [PATCH 2/2] misc: smpro-errmon: Add dimm training failure
 syndrome
Message-ID: <Y+4h0V+LtaX8745A@kroah.com>
References: <20230214064509.3622044-1-quan@os.amperecomputing.com>
 <20230214064509.3622044-3-quan@os.amperecomputing.com>
 <866fe1b3-8044-6581-9711-452550f91198@molgen.mpg.de>
 <98b2a8d6-c5bf-a782-7fc1-8874f94edc25@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98b2a8d6-c5bf-a782-7fc1-8874f94edc25@os.amperecomputing.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:22:14AM +0700, Quan Nguyen wrote:
> 
> 
> On 15/02/2023 14:33, Paul Menzel wrote:
> > Dear Quan,
> > 
> > 
> > Thank you for your patch.
> > 
> 
> Thanks Paul for the review.
> 
> > Am 14.02.23 um 07:45 schrieb Quan Nguyen:
> > > Adds event_dimm[0-15]_syndrome sysfs to report the failure syndrome
> > > to BMC when DIMM training failed.
> > 
> > Where you able to verify that it works? Out of curiosity, how?
> > 
> 
> Yes, we verified it by injecting DIMM errors and confirm that errors was
> reported correctly via sysfs.
> For about how to do error injection, we may  need to refer to section 3.2
> Memory Error Group in Altra Family RAS Error Injection User Manual. It is
> shared in our Ampere Customer Connect [1]. The latest version is
> v1.00_20220329.
> 
> [1] https://connect.amperecomputing.com
> 
> > > Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> > > ---
> > >   .../sysfs-bus-platform-devices-ampere-smpro   | 10 +++
> > >   drivers/misc/smpro-errmon.c                   | 77 +++++++++++++++++++
> > >   2 files changed, 87 insertions(+)
> > > 
> > > diff --git
> > > a/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
> > > b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
> > > index d4e3f308c451..c35f1d45e656 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
> > > +++ b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
> > > @@ -265,6 +265,16 @@ Description:
> > >           For more details, see section `5.7 GPI Status Registers
> > > and 5.9 Memory Error Register Definitions,
> > >           Altra Family Soc BMC Interface Specification`.
> > > +What:
> > > /sys/bus/platform/devices/smpro-errmon.*/event_dimm[0-15]_syndrome
> > > +KernelVersion:    6.1
> > 
> > Should it be 6.2, as it probably won’t make it into 6.1?
> > 
> 
> Thanks for the catch. Will fix in next version.

Should be 6.3, it's missed the 6.2 merge window cycle, sorry.

thanks,

greg k-h
