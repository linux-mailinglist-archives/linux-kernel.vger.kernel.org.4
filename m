Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4C6715C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjE3KzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjE3KzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8132CA0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685444069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1q0i4yZqdxDmT+xuTpGSHTNOPsQSPD0T9mC8x9n9pmQ=;
        b=VxeNEVTSI7yS2hefjHpxBmx88WpmIBZtJUw+X+l4UEicjXpghuwK0eLH+2aZgHl26jJCqq
        Ej8cSNBtdb+aWzHu8zL40ZjFP4TUWszNPVTrCeibXD2VbV1i1sTI2YsQf4fcJdwbFEsl+N
        GZh+tKp6H1O5mXx1fa6O8bW0NdwSzRA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-no0XoBy2ON-h9xNRRvqnzg-1; Tue, 30 May 2023 06:54:28 -0400
X-MC-Unique: no0XoBy2ON-h9xNRRvqnzg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-506beab6a73so4224166a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685444067; x=1688036067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1q0i4yZqdxDmT+xuTpGSHTNOPsQSPD0T9mC8x9n9pmQ=;
        b=g2fP0RPb983An7SWxzRdC8oV1t60nqUkA18h9m0B3cVJS2DWD5wezJ7DiN/3LI5JuH
         9ELbByrK6+ElyytfgWbRzlJZyHSBA4j6MaCDXZWuXbvRif2sDtATaww3ovOIOo3CEweg
         EwqkLVkqDNeSqYbaeK2fWLUXpKZKk9r6im0fWXd4C/BGUCcOhLBiNfHY5gbGivnaEYDz
         rrzlnN/A6lfNLHAguiZ/CfLbNCwNi+iMTC92FdLvrfI4GKjF4Nmodtyi+FLqYJ8DfSem
         95+U2zPTBNlu61NmU56sNzIx+CtHLxGLgEYxTkrABx6Lg7AmUR58K22g5UQY1vz1FSec
         R+4w==
X-Gm-Message-State: AC+VfDwGe4jmGUj8K+N+vDsuuoy+PZM5ZmCQPY2gSWCeP2QVx1+2+ush
        m11nmrkv1TP0sAijUgovYOXl+Ya6hCMpHMQXpVzbUDmc/h1Hq/6k4jopNKCl+9+cldgaaMlsnqH
        6glltxIdju/hr1TnEkZ46PbFHvAgElkUX
X-Received: by 2002:aa7:d658:0:b0:514:9e81:906f with SMTP id v24-20020aa7d658000000b005149e81906fmr1305858edr.27.1685444066906;
        Tue, 30 May 2023 03:54:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4I+096SwjLja4pHY4YqUYfGIPnsw0Zn+UHnBRONfv/VtPgD+leGxP0osXxo4zOb0YFNGuQaQ==
X-Received: by 2002:aa7:d658:0:b0:514:9e81:906f with SMTP id v24-20020aa7d658000000b005149e81906fmr1305844edr.27.1685444066550;
        Tue, 30 May 2023 03:54:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id n2-20020aa7d042000000b00514b044ec41sm693137edo.35.2023.05.30.03.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 03:54:26 -0700 (PDT)
Message-ID: <2ca9ef5d-2a24-c6b7-06fc-5b9919a2aaee@redhat.com>
Date:   Tue, 30 May 2023 12:54:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/5] platform/x86: think-lmi: Enable opcode support on
 BIOS settings
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 5/26/23 19:16, Mark Pearson wrote:
> Whilst reviewing some documentation from the FW team on using WMI on
> Lenovo system I noticed that we weren't using Opcode support when
> changing BIOS settings in the thinkLMI driver.
> 
> We should be doing this to ensure we're future proof as the old
> non-opcode mechanism has been deprecated.
> 
> Tested on X1 Carbon G10 and G11.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thank you for this new version. Please prepare a v4 addressing Ilpo's
review remarks.

About the aligning function arguments on the next line to the '('
of the function call start at the previous line, checkpatch also
checks for this.

It is always a good idea to run checkpatch before submitting patches.

E.g.:

git format-patch -v3 HEAD~5
scripts/checkpatch.pl v3-00*.patch
<check output is clean>
git send-email v3-00*.patch

Regards,

Hans





> ---
> Changes in v2: Update comment for clearer explanation of what the driver
> is doing
> Changes in v3: None. Version bump with rest of series
> 
>  drivers/platform/x86/think-lmi.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 1138f770149d..2745224f62ab 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1001,7 +1001,33 @@ static ssize_t current_value_store(struct kobject *kobj,
>  				tlmi_priv.pwd_admin->save_signature);
>  		if (ret)
>  			goto out;
> -	} else { /* Non certiifcate based authentication */
> +	} else if (tlmi_priv.opcode_support) {
> +		/*
> +		 * If opcode support is present use that interface.
> +		 * Note - this sets the variable and then the password as separate
> +		 * WMI calls. Function tlmi_save_bios_settings will error if the
> +		 * password is incorrect.
> +		 */
> +		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
> +					new_setting);
> +		if (!set_str) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
> +		if (ret)
> +			goto out;
> +
> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> +			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> +					tlmi_priv.pwd_admin->password);
> +			if (ret)
> +				goto out;
> +		}
> +
> +		ret = tlmi_save_bios_settings("");
> +	} else { /* old non opcode based authentication method (deprecated)*/
>  		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>  			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
>  					tlmi_priv.pwd_admin->password,

