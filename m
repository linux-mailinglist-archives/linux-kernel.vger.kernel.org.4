Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994FF6A1B21
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjBXLI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjBXLIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:08:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBAE1A951
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:07:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E78EB81B2C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89EDC433D2;
        Fri, 24 Feb 2023 11:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677236837;
        bh=O30kRj2lIqSfwoN/J+lEBzBy09k/lR5mBjeTS/LvA3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXY0P5O3zK6HP0OhOmFyxriiGZycUOPXeMOT+jBX3dDFDaxqMdMaMAFhFWnm+/kOl
         rYvoRxIpoOelb3jaEXoFFt8G6QHiwxPMpo+5p4VIXmlxG+zqEjMdhCjiq1/Nn0MB7b
         4lIYBnoIergpji/lYKEgY1jd3cKeP6v8luGIF1eU=
Date:   Fri, 24 Feb 2023 12:07:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rohit Chavan <roheetchavan@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme: remove unnecessary parentheses
Message-ID: <Y/iaYtKk4VSokAFz@kroah.com>
References: <20230224105048.758-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224105048.758-1-roheetchavan@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 04:20:48PM +0530, Rohit Chavan wrote:
> This patch removes unnecessary parentheses in order to fix a checkpatch issue.
> 
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
>  drivers/staging/vme_user/vme_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
> index 4e533c0bfe6d..5027d91d7038 100644
> --- a/drivers/staging/vme_user/vme_user.c
> +++ b/drivers/staging/vme_user/vme_user.c
> @@ -506,7 +506,7 @@ static int vme_user_match(struct vme_dev *vdev)
>  	int cur_slot = vme_slot_num(vdev);
>  
>  	for (i = 0; i < bus_num; i++)
> -		if ((cur_bus == bus[i]) && (cur_slot == vdev->num))
> +		if (cur_bus == bus[i] && cur_slot == vdev->num)

Then checkpatch is wrong, the original code is better as it is explicit
about what to do here.

Do you want to look up the order-of-operations every time to see if "&&"
is before or after "==" or the same?

sorry, but I will not take this, we write code for people first,
compilers second, and the original code is more obvious and explicit and
better in the long run.

thanks,

greg k-h
