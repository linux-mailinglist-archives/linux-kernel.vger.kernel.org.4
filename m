Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB36E4534
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDQKbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjDQKbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8896EBF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681727229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWbOnCGMg+g2KMIHo6MRFBoLdJ5Yw+JkX3S6axmHUV0=;
        b=GXKLW2kfFp37x/7CgV+Ue7+D+8pgx0rF14ap3Co8dJFwI+OA8Wyf+fDsTz9GeC1rz87680
        H/jQzBh4F+jw3BFQCmTRQbaebEqaTaV/oW0fKMCFgx3XVbRe1IF79sCEHoZeBFnExbBrX1
        V/LwCJcZ3eJ8eDIHjdxUT+JvD3Z34m0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-iBvuNQC7NiqgIrBCgbLOsA-1; Mon, 17 Apr 2023 06:13:12 -0400
X-MC-Unique: iBvuNQC7NiqgIrBCgbLOsA-1
Received: by mail-ed1-f70.google.com with SMTP id g1-20020a50d5c1000000b00506955403b5so2722661edj.23
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681726390; x=1684318390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWbOnCGMg+g2KMIHo6MRFBoLdJ5Yw+JkX3S6axmHUV0=;
        b=kXK30DlMMTTHj0d+dGEUx3N5e05Lw7WspSntxYp7uFtTxHm7z/WFHNrDnW6ppTWwjo
         D7U1QL5nEdDHCY7LhfOK5HOb7DKS99SuqcqFu+ZQSJQHajbHA7wQFuPC7wfDDl7mgRAE
         mw1IymT5pEpI1VqCsMgnByQq96qPiOm6QezQkN0L/yeDUrqHnHLtz7RMin62R3OMz3aq
         sVllCJKA2e5K5gvD7PSRJbq/hIjcGPvXNIQc7DfHZYAbKivXdFgEj27Klr+xbFwd7UrM
         TNFC5IKL4Lwa4xPfwjNJVFD9DRjcTlYfSpuRZ0KLTqggSz6Az3nvq03FWmLDGPtKnnjk
         ntiQ==
X-Gm-Message-State: AAQBX9dNQxOWb/Jwm5wott4lORo74dp/dCLDAZF1hGWmsiMkJvHOYOgJ
        vrUmPyec86+USF9SnwGchYNxN5+05T7dDUjuH3YWfb1e/It+vfuTraccKTdFxZRVSCgUf6Urfzd
        oVXdfMBcGagDd23BUcqOmN/YXTNDqC0oR
X-Received: by 2002:a17:906:2dd4:b0:94f:a03:3d3b with SMTP id h20-20020a1709062dd400b0094f0a033d3bmr5762029eji.20.1681726390562;
        Mon, 17 Apr 2023 03:13:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350akHc/S1wNwk9kDL+94i/OxY5JcMZnmuzDRYEkjj9sWtM7Oxf7LX4RBjEAAPOLk41yDz6szDQ==
X-Received: by 2002:a17:906:2dd4:b0:94f:a03:3d3b with SMTP id h20-20020a1709062dd400b0094f0a033d3bmr5762016eji.20.1681726390295;
        Mon, 17 Apr 2023 03:13:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gb32-20020a170907962000b0094f34fe27c6sm2854357ejc.170.2023.04.17.03.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 03:13:09 -0700 (PDT)
Message-ID: <ad2b3eed-ac33-c13a-5c43-27da89496d86@redhat.com>
Date:   Mon, 17 Apr 2023 12:13:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] platform/x86/intel/pmt: Ignore uninitialized entries
Content-Language: en-US, nl
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230413012922.1521377-1-david.e.box@linux.intel.com>
 <84f5952a-b64d-c3c8-d80-b9d59fe1ed40@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <84f5952a-b64d-c3c8-d80-b9d59fe1ed40@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/13/23 12:13, Ilpo Järvinen wrote:
> On Wed, 12 Apr 2023, David E. Box wrote:
> 
>> On Intel Xeon, unused PMT regions will have uninitialized discovery headers
>> containing all 0xF. Instead of returning an error, just skip the region.
>>
>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>> ---
>>  drivers/platform/x86/intel/pmt/telemetry.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
>> index 71cdef42084a..39cbc87cc28a 100644
>> --- a/drivers/platform/x86/intel/pmt/telemetry.c
>> +++ b/drivers/platform/x86/intel/pmt/telemetry.c
>> @@ -78,7 +78,7 @@ static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
>>  	 * reserved for future use. They have zero size. Do not fail
>>  	 * probe for these. Just ignore them.
>>  	 */
>> -	if (header->size == 0)
>> +	if (header->size == 0 || header->access_type == 0xF)
>>  		return 1;
>>  
>>  	return 0;
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you both for the patch + review, I've applied this patch
to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


