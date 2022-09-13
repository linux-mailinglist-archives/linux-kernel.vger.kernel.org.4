Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B535B78CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiIMRtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiIMRs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:48:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67656785BB;
        Tue, 13 Sep 2022 09:46:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ge9so383250pjb.1;
        Tue, 13 Sep 2022 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1i7O2Iok1YRMIALmDKILSSa+PDHh/TMXb1061x3zYsE=;
        b=CnBAUl1bzznqlLH+uIrXNiplMZxlYvpJAvAQjQKLJnvplkOZ2ynXM+0h7XW+HluZ2w
         qy76aDA63qVxDizV+hCBWv04bup9GqEVooYu/yevF4+tJwFeq8Zpiv1AXRTMlDCerIve
         SZs1dNNwRC8Ux7M9IKhF42mUNRdOkiRt3iSpQLYspStIdifZuYs4tq53kILQhnA+MCOg
         Az9PX0hUE+Ge2HyXVHDa0ixVyi/G2nDNUb2nEtVc6P4igWrlLrNSgEgZn7kvDlcBRjFE
         QI3dm2LL9W6aacDBHgLhi8GoFbpjTVfurem7XBNjxde8VNzzf2wYhznDTLfqXvZjb+UG
         a7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1i7O2Iok1YRMIALmDKILSSa+PDHh/TMXb1061x3zYsE=;
        b=MAPBC3+YwVslnWfWLCB9wgjhx5h/Oecqbz+KYcTOTYn/CtrgfsfOaBCXTgl3I70L9Z
         j05tkm2gkhZSJVFupxgdSl2TlEpbmfWyFgo82UGvEQK74VpEZIlltKh+FAcAiSirMtrN
         7JsRzAlp5egh1Tw8Asv59bT5UHNEFYBltRH2W3SOyQrTI2PX4k3L+cD/HCkzj3Pc/hxZ
         HRFHL+PBycNRkoU7QH98j8OaO4pe+Sl01c/95ZUfr4ybIMxWIaHgD7B35MHGphLlMhlv
         CSQm0b80pKq2pPCqdLFND6i1Fd2ROvXULkUFbjhnZ7lncJeLUWhgJoUC0mT4VzI8fSOk
         vHSw==
X-Gm-Message-State: ACgBeo2PbEFNcw/gaXCKVzXx6An/0YzwVYoKK/2VOqX0KBfnLSrkt5Tu
        m2UQ4GckFIv6dzseFDRHywc=
X-Google-Smtp-Source: AA6agR4xPFrTrwyEEGXJ0Po8UDRoOtBoEVgShqdqgx8z0EOiVUuaPegyx7QTzcMyskiHU7zkotfZrw==
X-Received: by 2002:a17:902:e881:b0:178:2a6f:bc72 with SMTP id w1-20020a170902e88100b001782a6fbc72mr12859092plg.93.1663087595868;
        Tue, 13 Sep 2022 09:46:35 -0700 (PDT)
Received: from rog ([2a0a:edc0:0:701:a220:c777:e1f2:5de1])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b001782580ce9csm6707664pli.249.2022.09.13.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:46:35 -0700 (PDT)
Date:   Tue, 13 Sep 2022 18:46:25 +0200
From:   Philipp Zabel <philipp.zabel@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        catalin@antebit.com, travisghansen@yahoo.com,
        Shyam-sundar.S-k@amd.com, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/6] acpi/x86: s2idle: If a new AMD _HID is missing
 assume Rembrandt
Message-ID: <YyCz4V0xNyHyt80q@rog>
References: <20220912172401.22301-1-mario.limonciello@amd.com>
 <20220912172401.22301-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912172401.22301-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Sep 12, 2022 at 12:23:56PM -0500 schrieb Mario Limonciello:
> A mistake was made that only AMDI0007 was set to rev of "2", but
> it should have been also set for AMDI008. If an ID is missing from
> the _HID table, then assume it matches Rembrandt behavior.
> 
> This implicitly means that if any other behavior changes happen
> in the future missing IDs must be added to that table.
> 
> Tested-by: catalin@antebit.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index a7757551f750..a8256e5a0e8a 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -412,7 +412,7 @@ static int lps0_device_attach(struct acpi_device *adev,
>  		if (dev_id != NULL)
>  			data = (const struct amd_lps0_hid_device_data *) dev_id->driver_data;
>  		else
> -			return 0;
> +			data = &amd_rembrandt;

Ah, please disregard my suggestion in the previous patch. I'd still use:

		if (dev_id)

Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ

regards
Philipp
