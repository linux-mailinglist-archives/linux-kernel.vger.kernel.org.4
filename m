Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555CE70E272
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbjEWQt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjEWQt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:49:26 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0418E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:49:25 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id c4f33e1d-f989-11ed-b3cf-005056bd6ce9;
        Tue, 23 May 2023 19:49:23 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 19:49:22 +0300
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, hdegoede@redhat.com, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com,
        Basavaraj.Natikar@amd.com
Subject: Re: [PATCH v2 2/4] ACPI: x86: Add pm_debug_messages for LPS0 _DSM
 state tracking
Message-ID: <ZGzukhSTqWzXJRAL@surfacebook>
References: <20230522200033.2605-1-mario.limonciello@amd.com>
 <20230522200033.2605-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522200033.2605-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 22, 2023 at 03:00:31PM -0500, Mario Limonciello kirjoitti:
> Enabling debugging messages for the state requires turning on dynamic
> debugging for the file. To make it more accessible, use
> `pm_debug_messages` and clearer strings for what is happening.

...

> +		switch (state) {
> +		case ACPI_LPS0_SCREEN_OFF:
> +			return "screen off";
> +		case ACPI_LPS0_SCREEN_ON:
> +			return "screen on";
> +		case ACPI_LPS0_ENTRY:
> +			return "lps0 entry";
> +		case ACPI_LPS0_EXIT:
> +			return "lps0 exit";
> +		case ACPI_LPS0_MS_ENTRY:
> +			return "lps0 ms entry";
> +		case ACPI_LPS0_MS_EXIT:
> +			return "lps0 ms exit";

No default?

> +		}

...

> +		switch (state) {
> +		case ACPI_LPS0_SCREEN_ON_AMD:
> +			return "screen on";
> +		case ACPI_LPS0_SCREEN_OFF_AMD:
> +			return "screen off";
> +		case ACPI_LPS0_ENTRY_AMD:
> +			return "lps0 entry";
> +		case ACPI_LPS0_EXIT_AMD:
> +			return "lps0 exit";
> +		}
> +	}
> +
> +	return "unknown";

Make it default in each switch-case. That way we might have an option to alter
them if needed.

...

> -	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
> -			  func, out_obj ? "successful" : "failed");
> +	lps0_dsm_state = func;
> +	if (pm_debug_messages_on) {
> +		acpi_handle_info(lps0_device_handle,
> +				"%s transitioned to state %s\n",
> +				 out_obj ? "Successfully" : "Failed to",
> +				 acpi_sleep_dsm_state_to_str(lps0_dsm_state));
> +	}

Can we keep the original choice (i.e. 

	? "successful" : "failed");

) unmodified? The rationale is that we migh add something like
str_successful_failed() to the string_helpers.h for wider use and common
standardization.

-- 
With Best Regards,
Andy Shevchenko


