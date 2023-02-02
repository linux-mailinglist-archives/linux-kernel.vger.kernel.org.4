Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF77A6882D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjBBPjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjBBPjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:39:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A321B45BD5;
        Thu,  2 Feb 2023 07:38:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 716B061BD9;
        Thu,  2 Feb 2023 15:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5E9C433EF;
        Thu,  2 Feb 2023 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675352264;
        bh=NhNoz4F0Mq3AxrEXQeDohhtiinxBD8XPSHCz/C12SU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFNNfojnOBlcgS6+iDfer1/78BpRXNct2mO//AaNoehiCFGp1q2R0jJxDaEK1Zavn
         gHO+tQXvDfVb+t7Se0Vc5uBp7LMR1DZH9OZ5+83rhozG+4fF7bmU5DZIiYdF5EwsWp
         gjsm17iBcTIvDv4+gsfl6BFu55ikFNBN8/q066WE=
Date:   Thu, 2 Feb 2023 16:37:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tty: n_gsm: add keep alive support
Message-ID: <Y9vYxgGd6kC+ZIgR@kroah.com>
References: <20230202145934.22641-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202145934.22641-1-daniel.starke@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:59:32PM +0100, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
> the newer 27.010 here. Chapters 5.4.6.3.4 and 5.1.8.1.3 describe the test
> command which can be used to test the mux connection between both sides.
> 
> Currently, no algorithm is implemented to make use of this command. This
> requires that each multiplexed upper layer protocol supervises the
> underlying muxer connection to handle possible connection losses.
> 
> Introduce an ioctl commands and functions to optionally enable keep alive
> handling via the test command as described in chapter 5.4.6.3.4. A single
> incrementing octet is being used to distinguish between multiple retries.
> Retry count and interval are taken from the general parameters N2 and T2.
> 
> Note that support for the test command is mandatory and already present in
> the muxer implementation since the very first version.
> Also note that the previous ioctl structure gsm_config cannot be extended
> due to missing checks against zero of the field "unused".
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c         | 106 +++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/gsmmux.h |  17 ++++--
>  2 files changed, 117 insertions(+), 6 deletions(-)
> 
> v1 -> v2:
> The "unused" fields of "gsm_config" and "gsm_netconfig" have been marked as
> unusable due to missing checks against zero. See review comments.

Please just make the first patch marking these as "unable to be used"
and document why this is so, as it's independant of this new feature you
are adding.

Remember, only do one logical thing per patch.

thanks,

greg k-h
