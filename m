Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6505973D87C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjFZH31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFZH3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B7DE0;
        Mon, 26 Jun 2023 00:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70E8A60C83;
        Mon, 26 Jun 2023 07:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C75C433C8;
        Mon, 26 Jun 2023 07:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687764561;
        bh=e+Czl/K0nNYHI+DZA0lDv4r0QtyVg56HwJGOzqiGq9A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=emgtZoialCtiY+Fq8eb3V1+WK5KDlcok5/joj9nRloTggSZ+vNcJjy15V7augL2xp
         RESjPEbb3ut+3csY/3eybndA05OavO2mxWcTuN7pAw8MtdU2nslgwK3hMmksEujamk
         Z68r/oqHWU+Z9Yns7L5EaRSODzIAfUtg4Qxld+eXy362FUhpAGOyPd3vzSpg76lxd3
         SXKRc4OdyZmpXkz5/Nw5UMO6YK8oFo2lOfoxbn+Dt/XPJwGnqQkp6PU2a/CV+cjlWu
         VmmsJ+eUvR97J1bFxqZM92l62M4+JZm2L3SHY/FxXkefTMJw6xBcrQki/L+y9iXrEz
         0dL3irmM7JVRg==
Message-ID: <1b44168a-195d-79bd-50cc-bc8baa0d8f16@kernel.org>
Date:   Mon, 26 Jun 2023 16:29:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ata: libata-scsi: fix bogus SCSI sense after abort
Content-Language: en-US
To:     Lorenz Brun <lorenz@brun.one>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230623181908.2032764-1-lorenz@brun.one>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230623181908.2032764-1-lorenz@brun.one>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 03:19, Lorenz Brun wrote:
> Since commit 058e55e120ca which fixed that commands without valid
> error/status codes did not result in any sense error, the returned sense
> errors were completely bogus as ata_to_sense_error did not have valid
> inputs in the first place.
> 
> For example the following ATA error
> 
> exception Emask 0x10 SAct 0x20c000 SErr 0x280100 action 0x6 frozen
> irq_stat 0x08000000, interface fatal error
> SError: { UnrecovData 10B8B BadCRC }
> failed command: READ FPDMA QUEUED
> cmd 60/e0:70:20:0a:00/00:00:00:00:00/40 tag 14 ncq dma 114688 in
> res 40/00:ac:20:5e:50/00:00:5d:01:00/40 Emask 0x10 (ATA bus error)
> status: { DRDY }
> 
> got turned into the following nonsensical SCSI error
> 
> FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> Sense Key : Illegal Request [current]
> Add. Sense: Unaligned write command
> CDB: Read(16) 88 00 00 00 00 00 00 00 0a 20 00 00 00 e0 00 00
> 
> This has nothing to do with an unaligned write command, but is due to an
> ATA EH-triggered abort. But ata_to_sense_error only knows about
> status and error, both of which aren't even valid here as the command
> has been aborted.
> 
> Add an additional section to ata_gen_ata_sense which handles
> errors not coming from the device first, before calling into
> ata_to_sense_error.
> 
> According to the SAT-5 spec a reset should cause a Unit Attention event,
> which the SCSI subsystem should handle to retry its commands but I
> am not sure how much of that infra is present in Linux's SCSI layer, so
> this is a simpler solution.
> 
> Signed-off-by: Lorenz Brun <lorenz@brun.one>
> ---
>  drivers/ata/libata-scsi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 551077cea4e4..61c6a4e8123a 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -13,6 +13,7 @@
>   *  - http://www.t13.org/
>   */
>  
> +#include "scsi/scsi_proto.h"
>  #include <linux/compat.h>
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
> @@ -1013,6 +1014,21 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>  		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
>  		return;
>  	}
> +	if (qc->err_mask & (AC_ERR_HSM | AC_ERR_ATA_BUS | AC_ERR_HOST_BUS |
> +		AC_ERR_SYSTEM | AC_ERR_OTHER)) {

Did you check SATA IO specs and/or AHCI to see if that says anything about these
? And I wonder if we should check if we have something in tf->status and
tf->error...

> +		/* Command aborted because of some issue with the ATA subsystem
> +		 * Should technically cause unit attention, but this is better
> +		 * than nothing, which results in nonsensical errors.
> +		 * POWER ON, RESET, OR BUS DEVICE RESET OCCURRED
> +		 */

Multi-line comment style: start with a "/*" line please. The phrasing of the
comment is not very clear. Maybe something like:

		/*
		 * If the command aborted because of some issue with the
		 * adapter or link, report a POWER ON, RESET, OR BUS DEVICE
		 * RESET OCCURRED error.
		 */

Did you check that all of the above error flags lead to a drive reset ? The
issue I have with this is that the drive reset is triggered by libata EH after
it got these bad errors but the sense data you use here normally indicate that
the reset was initiated by the adapter or the drive. Not sure this is ideal.

> +		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0x29, 0x00);
> +		return;
> +	}
> +	if (qc->err_mask & AC_ERR_TIMEOUT) {
> +		/* COMMAND TIMEOUT DURING PROCESSING */
> +		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0x2e, 0x02);
> +		return;
> +	}
>  	/* Use ata_to_sense_error() to map status register bits
>  	 * onto sense key, asc & ascq.
>  	 */

-- 
Damien Le Moal
Western Digital Research

