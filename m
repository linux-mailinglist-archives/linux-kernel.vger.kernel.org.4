Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5136A6F72
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCAP3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCAP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8566886B2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677684502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wo8c3Tcx2DQ//t8xrnZzzLmVvOoVEvkO+NT6PEIlThc=;
        b=FT35TsVNqDwtDwpVIHd6KptrGm4EEVqnNSux2mLgJqXHs+R9zlbbTv+V51uQMqn86t7c3k
        Pj6jmpyuAi1AHLwkAbMJaJP2tHxYw84tYWXUlmbjfPzrSLSQxfkST9jEdWzwzKYAVk+2Ti
        tYLeVcON32xIBWoU5zqjIjKLWz9ymkk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-YcmTwm8kPuypVuCodJpSdQ-1; Wed, 01 Mar 2023 10:28:20 -0500
X-MC-Unique: YcmTwm8kPuypVuCodJpSdQ-1
Received: by mail-ed1-f72.google.com with SMTP id k12-20020a50c8cc000000b004accf30f6d3so19759399edh.14
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 07:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wo8c3Tcx2DQ//t8xrnZzzLmVvOoVEvkO+NT6PEIlThc=;
        b=vsHykmgCY3D7ryS1iTGV29n8uy/J37jUQwQeWVdld3GrizegSqWX18lUV1EQLdGWci
         WDdVP05pY50zXLD9gMbznEfS8Kj+DY15alPnPviGSSA6HK3WM9S4Bn12PXfmbhgBJGN9
         0WHM6oNENRhrwEQ/JxjIgQUWd4MmriFZfIhZAhEjCq/vkb42GMm1gadI6waMmlBb4QCb
         G4+n32GkTzeKNVIZPG/f+zkudsxuS3BQaM6I6TZlPEHnvaSZALsCGVtfdnqj/jo6Fwf2
         VhNTjMv9GuThAKFviU+RWen3BVywN6ETbr2Tnxql9aZWZikVzlE+J4u58PQI8hsbYW6y
         xbwg==
X-Gm-Message-State: AO0yUKVLE1TZHq/B2Y0QSK5po3DPVkCfKzXf0gXy2yS1g3EjhUUZbwb5
        dkp+xM0wCReoF0dUAehnUzfkmO6Fjj2aNZWdnCBMZqHhfsD2NTmOiZGvXVYMmTQ536cTfwZOIEc
        2VhgvC6YHViDWmaLTDWXFEAUw
X-Received: by 2002:aa7:cad7:0:b0:4ae:eae1:946a with SMTP id l23-20020aa7cad7000000b004aeeae1946amr8416083edt.13.1677684499838;
        Wed, 01 Mar 2023 07:28:19 -0800 (PST)
X-Google-Smtp-Source: AK7set/lC7BQ/X3iIUDijFHRroNnDZaqL6Ts7DJtSojrTX+Ep99Lryg0+dX/mA8OAY/h84fKvW+ZAw==
X-Received: by 2002:aa7:cad7:0:b0:4ae:eae1:946a with SMTP id l23-20020aa7cad7000000b004aeeae1946amr8416055edt.13.1677684499505;
        Wed, 01 Mar 2023 07:28:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z30-20020a50cd1e000000b004aee548b3e2sm5660326edi.69.2023.03.01.07.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 07:28:18 -0800 (PST)
Message-ID: <846d6f46-07ab-4d4a-5623-417a469c3d0b@redhat.com>
Date:   Wed, 1 Mar 2023 16:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking
 minimum SMU version
Content-Language: en-US, nl
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230301150821.9791-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230301150821.9791-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/1/23 16:08, Mario Limonciello wrote:
> In a few locations there is some boilerplate code for checking
> minimum SMU version.  Switch this to a helper for this check.
> 
> No intended functional changes.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/pmc.c | 49 +++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
> index 2edaae04a691..c42fa47381c3 100644
> --- a/drivers/platform/x86/amd/pmc.c
> +++ b/drivers/platform/x86/amd/pmc.c
> @@ -418,6 +418,22 @@ static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
>  	return 0;
>  }
>  
> +static bool amd_pmc_verify_min_version(struct amd_pmc_dev *pdev, int major, int minor)
> +{
> +	if (!pdev->major) {
> +		int rc = amd_pmc_get_smu_version(pdev);
> +
> +		if (rc) {
> +			dev_warn(pdev->dev, "failed to read SMU version: %d\n", rc);
> +			return false;
> +		}
> +	}
> +	if (pdev->major > major)
> +		return true;
> +
> +	return pdev->major == major && pdev->minor >= minor;
> +}
> +
>  static ssize_t smu_fw_version_show(struct device *d, struct device_attribute *attr,
>  				   char *buf)
>  {
> @@ -526,14 +542,7 @@ static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
>  	struct amd_pmc_dev *dev = s->private;
>  	int rc;
>  
> -	/* we haven't yet read SMU version */
> -	if (!dev->major) {
> -		rc = amd_pmc_get_smu_version(dev);
> -		if (rc)
> -			return rc;
> -	}
> -
> -	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {

The 2 major checks here originally were not in sync, so for major == 55
*and* major == 56 it would only succeed if minor >= 37.

Where as after this patch for major == 56 it will now always succeed.

This feels like a bug in the original code, but might have been
intentional ? Please verify this.

After verifying please post a v2 updating the commit message to
point out this functional change.

> +	if (amd_pmc_verify_min_version(dev, 55, 37)) {
>  		rc = amd_pmc_idlemask_read(dev, NULL, s);
>  		if (rc)
>  			return rc;
> @@ -686,15 +695,8 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
>  static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
>  {
>  	struct device *d;
> -	int rc;
>  
> -	if (!pdev->major) {
> -		rc = amd_pmc_get_smu_version(pdev);
> -		if (rc)
> -			return rc;
> -	}
> -
> -	if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
> +	if (amd_pmc_verify_min_version(pdev, 64, 66))
>  		return 0;
>  
>  	d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
> @@ -718,14 +720,10 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>  	struct rtc_time tm;
>  	int rc;
>  
> -	/* we haven't yet read SMU version */
> -	if (!pdev->major) {
> -		rc = amd_pmc_get_smu_version(pdev);
> -		if (rc)
> -			return rc;
> -	}
> +	if (disable_workarounds)
> +		return 0;
>  
> -	if (pdev->major < 64 || (pdev->major == 64 && pdev->minor < 53))
> +	if (!amd_pmc_verify_min_version(pdev, 64, 53))
>  		return 0;
>  
>  	rtc_device = rtc_class_open("rtc0");
> @@ -772,13 +770,14 @@ static void amd_pmc_s2idle_prepare(void)
>  	/* Reset and Start SMU logging - to monitor the s0i3 stats */
>  	amd_pmc_setup_smu_logging(pdev);
>  
> -	/* Activate CZN specific platform bug workarounds */
> -	if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
> +	switch (pdev->cpu_id) {
> +	case AMD_CPU_ID_CZN:
>  		rc = amd_pmc_verify_czn_rtc(pdev, &arg);
>  		if (rc) {
>  			dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
>  			return;
>  		}
> +		break;
>  	}
>  
>  	msg = amd_pmc_get_os_hint(pdev);


Patch 2/2 looks good to me.

Should I queue v2 (once posted) up as a fix for 6.3-rc#  ?

Regards,

Hans

