Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5EE632EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiKUVfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKUVfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:35:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05461120;
        Mon, 21 Nov 2022 13:35:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7E02B8162A;
        Mon, 21 Nov 2022 21:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB45C433D6;
        Mon, 21 Nov 2022 21:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669066519;
        bh=YEQ8ohadopjckWt8+QV41eVRdbP4ife13YuNAz6zfJM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YzdZ1cEBTWDQXEfKo3RhTsjn50b+dqxPrsx+H0+y95Zq5tCDAoxNQSBV8b8qzHXah
         cMInPdY+5ThjNBw9tDtPqMyokPHdW2ov9vFqQdMmXO1Ejyh54Bx0rZJ566K2hrBeLm
         nxQd0+wQaYtr4MES89G4WrhCxFmpvXcnoc2Rig9nN8KBom1nWQpTamWauU68c3D/Ot
         5giHaPbkLV2EghblJtdLB3Rhx1c48kLOVCYpfRlmDw6HbgveTucozUyKdcIMO19+Hb
         vjk6H7hVzKOCqdlsUt9JJgb63jfFsqHeimC1f0CutmUIdOuhGju3Zm8MltjLWlfUJf
         D7jc1q3mI5/og==
Date:   Mon, 21 Nov 2022 22:35:18 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andreas Bergmeier <abergmeier@gmx.net>
cc:     lains@riseup.net, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: Send SwID in GetProtocolVersion
In-Reply-To: <20221111194526.1375601-1-abergmeier@gmx.net>
Message-ID: <nycvar.YFH.7.76.2211212235120.6045@cbobk.fhfr.pm>
References: <20221111194526.1375601-1-abergmeier@gmx.net>
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

On Fri, 11 Nov 2022, Andreas Bergmeier wrote:

> According to docs a SwID should be sent for GetProtocolVersion.
> > 0x10.DeviceIndex.0x00.0x1n
> where n is SwID
> 
> Signed-off-by: Andreas Bergmeier <abergmeier@gmx.net>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index a0c148a8df6c..964a523c3de7 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -896,7 +896,7 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
> 
>  	ret = hidpp_send_rap_command_sync(hidpp,
>  			HIDPP_PAGE_ROOT_IDX,
> -			CMD_ROOT_GET_PROTOCOL_VERSION,
> +			CMD_ROOT_GET_PROTOCOL_VERSION | LINUX_KERNEL_SW_ID,
>  			ping_data, sizeof(ping_data), &response);
> 
>  	if (ret == HIDPP_ERROR_INVALID_SUBID) {

Applied, thanks Andreas.

-- 
Jiri Kosina
SUSE Labs

