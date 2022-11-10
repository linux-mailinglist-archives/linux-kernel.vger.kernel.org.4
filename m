Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB28624C78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiKJVGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiKJVGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A002114D3E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668114297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESV0EBIfdSkKVU9C1MpNbQrrf3Hjd+qZEwZ6K/0lz/0=;
        b=IeJCEhdat7/h4Ft/TS+da3g344RB5k0TQH+1PnilVC1MF9bMPHhsEVsBdROMZX7q/GGND1
        sAKvP04yQyuu4UiTy3OhAWqQNKGiirH3AvlX6FnNmt68kKcLTyotTHd2iNXrPrNa/Ho5GT
        SHPhIveTUyhMH3/dPbrm8wt6aO99XUs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-329-FEfXZkQKO-KA7H9Z7cUXGw-1; Thu, 10 Nov 2022 16:04:55 -0500
X-MC-Unique: FEfXZkQKO-KA7H9Z7cUXGw-1
Received: by mail-ej1-f72.google.com with SMTP id hs34-20020a1709073ea200b007ad86f91d39so1897861ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESV0EBIfdSkKVU9C1MpNbQrrf3Hjd+qZEwZ6K/0lz/0=;
        b=p6DvenzbO2vnQzOLLcmAQdZNTQqDRtBg5K2vpA131XDIjIHeDq5Zl1RWuim5pem9xe
         EtJlAgbB0ykl6wnW3ERyaPoDp3K313xoDzXO6xc3ICFP4QscH0mk9jcXx4DB4gcz9SO1
         VNAffy2tR77R+7D5OGQjx2NvL+GqjbDJ407cN3tVTJCvVKUTozNDkkBC0l1AeLAVpF+0
         f5e8MDj842EMrhHLTuHcFG6JQctrnmHR2oqxnT4+oOMjz1NhbvVdlMsCM6RGj0hPmUXX
         LhBQAbUkolcLX6CVtriLB3UUpPW3QQgv0pMEAQETwR5SBJ3Wmt29DFzLhNNcELSIRvg0
         t6ow==
X-Gm-Message-State: ACrzQf195tQ69M6OjmV6j6NLPaILss3uIqknDCVocFAku2WUDNV0l25W
        y9EZbmvHrbIfqAj1zqvlts+48WRtvX+XHfZl1va8pl4npET5Q4fnBz1PRMKL52PYoSXfMYl/bEh
        +2ZYLO24/S5l0V7Susg3a6sJU
X-Received: by 2002:a17:906:2743:b0:78e:1046:c52a with SMTP id a3-20020a170906274300b0078e1046c52amr3947077ejd.713.1668114293745;
        Thu, 10 Nov 2022 13:04:53 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7RVJLiRUIkFjzfkOCm1t81pUWwfRE35mn+LHOh9gGPoY+OKEbHC0q7S17LQtUVgd7GMW9JYQ==
X-Received: by 2002:a17:906:2743:b0:78e:1046:c52a with SMTP id a3-20020a170906274300b0078e1046c52amr3947055ejd.713.1668114293544;
        Thu, 10 Nov 2022 13:04:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709061bb200b0078d4e39d87esm98563ejg.225.2022.11.10.13.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 13:04:53 -0800 (PST)
Message-ID: <6107283a-ec3f-9873-9f1a-e43a3e5808ea@redhat.com>
Date:   Thu, 10 Nov 2022 22:04:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 02/14] platform/x86/intel/ifs: return a more
 appropriate Error code
Content-Language: en-US, nl
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-3-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221107225323.2733518-3-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/7/22 23:53, Jithu Joseph wrote:
> scan_chunks_sanity_check() returns -ENOMEM if it encounters
> an error while copying IFS test image from memory to Secure Memory.
> 
> Return -EIO in this scenario, as it is more appropriate.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/intel/ifs/load.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index d056617ddc85..89ce265887ea 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -157,8 +157,10 @@ static int scan_chunks_sanity_check(struct device *dev)
>  		INIT_WORK(&local_work.w, copy_hashes_authenticate_chunks);
>  		schedule_work_on(cpu, &local_work.w);
>  		wait_for_completion(&ifs_done);
> -		if (ifsd->loading_error)
> +		if (ifsd->loading_error) {
> +			ret = -EIO;
>  			goto out;
> +		}
>  		package_authenticated[curr_pkg] = 1;
>  	}
>  	ret = 0;

