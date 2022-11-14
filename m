Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6185F628522
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbiKNQZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiKNQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:25:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD7B1BE86;
        Mon, 14 Nov 2022 08:25:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DF8F60F9C;
        Mon, 14 Nov 2022 16:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66887C433D6;
        Mon, 14 Nov 2022 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668443113;
        bh=dC2jmojqZ+9XqucLDTOjHuVL4KAkGFW+WaX2tSj9KXM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=eYA7qossWziAHsuSLYqWGYkW26DQCgdR5xyw1GRbHr/LEOrG7/PMksQmvUpPm4Mlw
         XDYed92GSLlgbZOxXdxFQcatxt8tXva6+ASCbwMbq28mSvzCv4lTuAIyMXxuxmUARE
         V20VD9dbPRO6kAgmnIydoS0sBSmdXXIxNK9Oet32LrWGhg+sBTjS0LoGVMOqS4Iwpo
         1a8fQZ93NmkDB38ews83S31byJogKZqoeUzgRHz5LythlLpZHRqS4sf/xUa8LgQc3x
         Nla62uP3Zs8kii1u4zxJzrX18RG5BOeaShkOWHkR+eAmhIZCqgzapApbCAXgI288Kn
         2hPiHewGhJgJA==
Date:   Mon, 14 Nov 2022 17:25:10 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] hid: intel-ish-hid: ishtp: remove variable
 rb_count
In-Reply-To: <20221020210219.45131-1-colin.i.king@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211141725050.6045@cbobk.fhfr.pm>
References: <20221020210219.45131-1-colin.i.king@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022, Colin Ian King wrote:

> The variable rb_count is being incremented but it
> is never referenced, it is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> V2: Fix commit message.
> ---
>  drivers/hid/intel-ish-hid/ishtp/client.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
> index df0a825694f5..2d92fc129ce4 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/client.c
> @@ -841,7 +841,6 @@ void recv_ishtp_cl_msg(struct ishtp_device *dev,
>  	unsigned char *buffer = NULL;
>  	struct ishtp_cl_rb *complete_rb = NULL;
>  	unsigned long	flags;
> -	int	rb_count;
>  
>  	if (ishtp_hdr->reserved) {
>  		dev_err(dev->devc, "corrupted message header.\n");
> @@ -855,9 +854,7 @@ void recv_ishtp_cl_msg(struct ishtp_device *dev,
>  	}
>  
>  	spin_lock_irqsave(&dev->read_list_spinlock, flags);
> -	rb_count = -1;
>  	list_for_each_entry(rb, &dev->read_list.list, list) {
> -		++rb_count;
>  		cl = rb->cl;
>  		if (!cl || !(cl->host_client_id == ishtp_hdr->host_addr &&
>  				cl->fw_client_id == ishtp_hdr->fw_addr) ||

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

