Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942BE743F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjF3Pyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjF3Pyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:54:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1AA3C06;
        Fri, 30 Jun 2023 08:54:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60BD16178A;
        Fri, 30 Jun 2023 15:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E29C433C0;
        Fri, 30 Jun 2023 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688140469;
        bh=3UxnCn0uKRWtw0gFGbXkslK1m3C/e7mRctYkrXYRER8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEOT2RDrMyVotMws4YABB+hxaLTELOoPVGVFqSiq41H6IesDtPs9UZC4zDuYg0Up2
         Zg8PXkbR9PFVqlQFtCJfssEp4HZn+zk7axTiOO9n3ygma+ddLKYrTgl/25YkAiE5/f
         0h/0KkksDmvOVZnVhbwvXuJMA5L9GwEppi025BMB5dDcsEgFeQc/OMgw3ZuKgtFwPm
         udXrOkNqKPkjxumsMI0uKSXPPULvFjUQjqT16FeMgxCpqV9b0OV9OldFpZP2ghh6NC
         cwK6+LM3KIomgurPZMzIBYcJTYao2gw57JCI6PJB4LAmyLFvzVlsbi/8PXlmZBU1xC
         z473u/Jpk3YXQ==
Date:   Fri, 30 Jun 2023 08:54:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Zhou jie <zhoujie@nfschina.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] media: wl128x: fix a clang warning
Message-ID: <20230630155427.GA2889176@dev-arch.thelio-3990X>
References: <6badd27ebfa718d5737f517f18b29a3e0f6e43f8.1687981726.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6badd27ebfa718d5737f517f18b29a3e0f6e43f8.1687981726.git.mchehab@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:48:53PM +0200, Mauro Carvalho Chehab wrote:
> Clang-16 produces this warning, which is fatal with CONFIG_WERROR:
> 
> 	../drivers/media/radio/wl128x/fmdrv_common.c:1237:19: error: variable 'cmd_cnt' set but not used [-Werror,-Wunused-but-set-variable]
> 	        int ret, fw_len, cmd_cnt;
> 	                         ^
> 	1 error generated.
> 
> What happens is that cmd_cnt tracks the amount of firmware data packets
> were transfered, which is printed only when debug is used.

Alternatively, fmdbg() could be defined with no_printk(), so that the
variable appears used in all configurations, but this does not seem
unreasonable either.

> Switch to use the firmware count, as the message is all about reporting
> a partial firmware transfer.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  drivers/media/radio/wl128x/fmdrv_common.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
> index cbd49dff6d74..b31b7ed60bbe 100644
> --- a/drivers/media/radio/wl128x/fmdrv_common.c
> +++ b/drivers/media/radio/wl128x/fmdrv_common.c
> @@ -1234,9 +1234,8 @@ static int fm_download_firmware(struct fmdev *fmdev, const u8 *fw_name)
>  	struct bts_action *action;
>  	struct bts_action_delay *delay;
>  	u8 *fw_data;
> -	int ret, fw_len, cmd_cnt;
> +	int ret, fw_len;
>  
> -	cmd_cnt = 0;
>  	set_bit(FM_FW_DW_INPROGRESS, &fmdev->flag);
>  
>  	ret = request_firmware(&fw_entry, fw_name,
> @@ -1272,7 +1271,6 @@ static int fm_download_firmware(struct fmdev *fmdev, const u8 *fw_name)
>  			if (ret)
>  				goto rel_fw;
>  
> -			cmd_cnt++;
>  			break;
>  
>  		case ACTION_DELAY:	/* Delay */
> @@ -1284,7 +1282,7 @@ static int fm_download_firmware(struct fmdev *fmdev, const u8 *fw_name)
>  		fw_data += (sizeof(struct bts_action) + (action->size));
>  		fw_len -= (sizeof(struct bts_action) + (action->size));
>  	}
> -	fmdbg("Firmware commands(%d) loaded to chip\n", cmd_cnt);
> +	fmdbg("Transfered only %d of %d bytes of the firmware to chip\n", fw_entry->size - fw_len, fw_entry->size);
>  rel_fw:
>  	release_firmware(fw_entry);
>  	clear_bit(FM_FW_DW_INPROGRESS, &fmdev->flag);
> -- 
> 2.41.0
> 
