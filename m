Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE6472EEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjFMWBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFMWBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:01:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81C1BC7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:01:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F298618B4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B10C433C8;
        Tue, 13 Jun 2023 22:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686693661;
        bh=0I7334PO3KlCPVruC02Cf0E2A+sX+5P5HJ++VK5onO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDJ/b0RRB7OAvOYGZBtBVWVaKUZj0m5+j97KXL+PHWearsMKE++Mdl6Fn+VHXQT8f
         CPByRL1GZdFelCevRm0KzvPwkhW09KWZSmbOmkPc2NHAngGDXqpOCGpnwaZ4MzC9tu
         dFswHr7Dfpmf+18pKNCotJa7VXW/kr0kh13DtmxUEsjz4mmASpTt6Qscd0iHQaDqgp
         78boo8UipZXnvql7gLp44kxFsUGWK8QRM08ezJESS1GW2jDXuILdASkMM7DjXbYSLr
         tEn894faFXSP7yR4Z+CTgedMeeo3F4Y/LSgRuCXYvF/FrP3t87R2LkVMS8X1s5y1Nj
         A1zhPeMsy+zHg==
Date:   Tue, 13 Jun 2023 16:00:58 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, leit@fb.com,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Print capabilities changes just once
Message-ID: <ZIjnGiMbih0sjn3g@kbusch-mbp.dhcp.thefacebook.com>
References: <20230613175538.331639-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613175538.331639-1-leitao@debian.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:55:37AM -0700, Breno Leitao wrote:
> This current dev_info() could be very verbose and being printed very
> frequently depending on some userspace application sending some specific
> commands.
> 
> Let's turn it into a dev_info_once(), since it is not useful to know
> about it all the time.

This looks good to me. Vendors sometimes put unnecessary effects in the
log, and spamming the same recommendation to repeated operations isn't
going to be helpful. I expect anyone who knows what they're doing can
consult the effects log directly and take appropriate action on their
own.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3ec38e2b9173..459e5a84e596 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1134,7 +1134,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
>  		mutex_unlock(&ctrl->scan_lock);
>  	}
>  	if (effects & NVME_CMD_EFFECTS_CCC) {
> -		dev_info(ctrl->device,
> +		dev_info_once(ctrl->device,
>  "controller capabilities changed, reset may be required to take effect.\n");
>  	}
>  	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
> -- 
> 2.34.1
> 
