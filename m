Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA35BE1DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiITJ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiITJ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:26:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149DE6A4A9;
        Tue, 20 Sep 2022 02:26:16 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e791329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e791:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 965DE1EC0380;
        Tue, 20 Sep 2022 11:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663665970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zP1NkRhYUiHW8Z4Cjl9uESlEcyLKkpoT10sJq+VUOXI=;
        b=Jxb3tMlwXBS+WYLMTAcR68WY6sEb9gmqi337ahH+pBBWnITp6FG60PhXCD37K2u3zfNGR+
        DBW0O77ElthTe5H0yD7OMnyg9zU+oCFCjPNNa/C+JaBC/4A87HA/ZreaCS3VX6lZfSZzc7
        isaevu2/SzCFnGIEyq9B96oETeIW3F0=
Date:   Tue, 20 Sep 2022 11:26:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jay Lu <jaylu102@amd.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com,
        dave.hansen@linux.intel.com, jarkko@kernel.org,
        xueshuai@linux.alibaba.com, terry.bowman@amd.com,
        yazen.ghannam@amd.com, smita.koralahallichannabasappa@amd.com,
        robert.richter@amd.com, linux-acpi@vger.kernel.org,
        jayakumar.govindankalivu@amd.com
Subject: Re: [PATCH 2/3] ACPI, APEI, EINJ: Refactor available_error_type_show
Message-ID: <YymHLo5JzuqdcMab@zn.tnic>
References: <20220729153550.181209-1-jaylu102@amd.com>
 <20220729153550.181209-3-jaylu102@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220729153550.181209-3-jaylu102@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 10:35:49AM -0500, Jay Lu wrote:
> Move error type descriptions into an array and loop over error types
> to improve readability and maintainability.
> 
> Replace seq_printf() with seq_puts() as recommended by checkpatch.pl.
> 
> Signed-off-by: Jay Lu <jaylu102@amd.com>
> ---
>  drivers/acpi/apei/einj.c | 41 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index da039c630fd0..a68103280f74 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -569,6 +569,20 @@ static u64 error_param2;
>  static u64 error_param3;
>  static u64 error_param4;
>  static struct dentry *einj_debug_dir;
> +static const char * const einj_error_type_string[] = {
> +	"0x00000001\tProcessor Correctable\n",                          /* bit 0  */
> +	"0x00000002\tProcessor Uncorrectable non-fatal\n",              /* bit 1  */
> +	"0x00000004\tProcessor Uncorrectable fatal\n",                  /* bit 2  */
> +	"0x00000008\tMemory Correctable\n",                             /* bit 3  */
> +	"0x00000010\tMemory Uncorrectable non-fatal\n",                 /* bit 4  */
> +	"0x00000020\tMemory Uncorrectable fatal\n",                     /* bit 5  */
> +	"0x00000040\tPCI Express Correctable\n",                        /* bit 6  */
> +	"0x00000080\tPCI Express Uncorrectable non-fatal\n",            /* bit 7  */
> +	"0x00000100\tPCI Express Uncorrectable fatal\n",                /* bit 8  */
> +	"0x00000200\tPlatform Correctable\n",                           /* bit 9  */
> +	"0x00000400\tPlatform Uncorrectable non-fatal\n",               /* bit 10 */
> +	"0x00000800\tPlatform Uncorrectable fatal\n",                   /* bit 11 */
									^^^^^^^^^^^^

Those comments look useless - you have the bit numbers in front already.


>  static int available_error_type_show(struct seq_file *m, void *v)
>  {
> @@ -578,30 +592,9 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  	rc = einj_get_available_error_type(&available_error_type);
>  	if (rc)
>  		return rc;
> -	if (available_error_type & 0x0001)
> -		seq_printf(m, "0x00000001\tProcessor Correctable\n");
> -	if (available_error_type & 0x0002)
> -		seq_printf(m, "0x00000002\tProcessor Uncorrectable non-fatal\n");
> -	if (available_error_type & 0x0004)
> -		seq_printf(m, "0x00000004\tProcessor Uncorrectable fatal\n");
> -	if (available_error_type & 0x0008)
> -		seq_printf(m, "0x00000008\tMemory Correctable\n");
> -	if (available_error_type & 0x0010)
> -		seq_printf(m, "0x00000010\tMemory Uncorrectable non-fatal\n");
> -	if (available_error_type & 0x0020)
> -		seq_printf(m, "0x00000020\tMemory Uncorrectable fatal\n");
> -	if (available_error_type & 0x0040)
> -		seq_printf(m, "0x00000040\tPCI Express Correctable\n");
> -	if (available_error_type & 0x0080)
> -		seq_printf(m, "0x00000080\tPCI Express Uncorrectable non-fatal\n");
> -	if (available_error_type & 0x0100)
> -		seq_printf(m, "0x00000100\tPCI Express Uncorrectable fatal\n");
> -	if (available_error_type & 0x0200)
> -		seq_printf(m, "0x00000200\tPlatform Correctable\n");
> -	if (available_error_type & 0x0400)
> -		seq_printf(m, "0x00000400\tPlatform Uncorrectable non-fatal\n");
> -	if (available_error_type & 0x0800)
> -		seq_printf(m, "0x00000800\tPlatform Uncorrectable fatal\n");
> +	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
> +		if (available_error_type & (BIT(0) << pos))
					   ^^^^^^^^^^^^^^^

That's a weird way of saying:

	BIT(pos)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
