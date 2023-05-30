Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E9715CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjE3LV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjE3LV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:21:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781E3EA;
        Tue, 30 May 2023 04:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA52862E03;
        Tue, 30 May 2023 11:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A00C433D2;
        Tue, 30 May 2023 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685445691;
        bh=f3Vo1zv+iMg2pVXhb/ZRdSeALjrkU4HIvF8F99LHNsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aehJ0hVSe4LGUzPq468qJNlU0wV1smQu+O6gMxVAmpc5o03BW5LV5VzOze4EZayB0
         zc2sNzZTZRBaKKGmx6w/pDHwpoeUQ/B4M7l4yoegjNs4vLeOhfx3qKACfezxWt4Xbc
         TO+8qntN5whyi4n/4VhDmVwdePzlbhQBoYvJvzXM=
Date:   Tue, 30 May 2023 12:21:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, felix-haase@siemens.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] tty: n_gsm: add restart flag to DLC specific
 ioctl config
Message-ID: <2023053056-follicle-unshaved-41c2@gregkh>
References: <20230517155704.5701-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517155704.5701-1-daniel.starke@siemens.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 05:56:55PM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Currently, changing the parameters of a DLCI gives no direct control to the
> user whether this should trigger a channel reset or not. The decision is
> solely made by the driver based on the assumption which parameter changes
> are compatible or not. Therefore, the user has no means to perform an
> automatic channel reset after parameter configuration for non-conflicting
> changes.
> 
> Add the parameter 'flags' to 'gsm_dlci_config' to force a channel reset
> after ioctl setting regardless of whether the changes made require this or
> not by setting this to 'GSM_FL_RESTART'.
> 
> Note that 'GSM_FL_RESTART' is currently the only allow flag to allow
> additions here.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c         |  4 ++++
>  include/uapi/linux/gsmmux.h | 15 ++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> v4 -> v5:
> Changed GSM_FL_RESTART comment to be more specific about its use as
> suggested in the review comment.
> 
> Please note that I cannot response to emails until August 7th. Felix Haase
> will take over from our side for questions regarding this patch series or
> the n_gsm.
> 
> Link: https://lore.kernel.org/all/DB9PR10MB5881B63FBBA7912DF5A7A6A8E0789@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM/

Ok, I'll wait for a resend by Felix to consider these as having someone
be responsible for them if they cause problems is key :)

thanks,

greg k-h
