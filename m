Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339F6B7B74
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCMPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjCMPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362115B80
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678719791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZ49mGv28iBaz7X24970hd41Ch6EkiVMx/J+Ek7710U=;
        b=dOSZgkG6tWEAgViqDoeCUrLzNglh3+AOFyKaeSPtJJEyv+DbIeTYEfRWIdQ9uWLqy/FPnF
        R8rms3qL8QdGufnqTwG/C0VIJIHK07JZaKk0Tn6s5zOCuUshSAXQu+i/Tmgz+iU3SRSpL/
        tsHPDKWw1/dSTNhT3B3cMb6cqBnZbFg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-6ygBlzuBMAKaG1YOdySM6A-1; Mon, 13 Mar 2023 11:03:10 -0400
X-MC-Unique: 6ygBlzuBMAKaG1YOdySM6A-1
Received: by mail-ed1-f72.google.com with SMTP id q13-20020a5085cd000000b004af50de0bcfso17618229edh.15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678719789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ49mGv28iBaz7X24970hd41Ch6EkiVMx/J+Ek7710U=;
        b=7XQ3UiaeWRT7A+/hfByAfWjj6BBIkeIc1ni4/XYwAGB+USGa2r1/KdKIN/jjlcryzz
         gJKqud9Ko7e8q7q5kgwqOofYybmZ6OYwMPUSUXBPm3un0DkQ8q5KN5QLzXlYXsfqcvU6
         JKzm6bfph4Wta1AzERnAuXNXhR2FH9/srqPP7TUT4BXksuFIH1BD8aGIaV8c2oDV8X51
         UcdqsIS511kSjTOezOAkQ/iCmue4N98bidFNA8New3jFbsGl6gBhFKyndoA/o9vVP6/x
         w2+b0RAsXbZ6xBA4lkMbekbj8wxWOZ5CDJD0eWWBVgMOawhTExOskqyibYyAEZ9Twppv
         L0fw==
X-Gm-Message-State: AO0yUKWTLAcg/3MU1/rqsH0Rc/z4Dzh35xOt5UH72JeGKCJ5ANTaUFqZ
        Tgz5xBEcIbQH8hwj/EcxVFtvQobLVcaN/2h2Yzv8YW4H9Tzpr2hpdLQE5DYveXihjE0fy06RAV1
        XXfKHf17qPMUS5B6uq+ETfaTl
X-Received: by 2002:a17:907:e8d:b0:8af:5752:691f with SMTP id ho13-20020a1709070e8d00b008af5752691fmr42132561ejc.76.1678719789482;
        Mon, 13 Mar 2023 08:03:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set9DZQ94D+TsWkTFR06KObrdN3jzxn91sJ+YsKqm39NbPokTmU4hc+TAPRkNZv5Irs3O4mIJsg==
X-Received: by 2002:a17:907:e8d:b0:8af:5752:691f with SMTP id ho13-20020a1709070e8d00b008af5752691fmr42132536ejc.76.1678719789224;
        Mon, 13 Mar 2023 08:03:09 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090630d500b008cafeec917dsm3524898ejb.101.2023.03.13.08.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 08:03:08 -0700 (PDT)
Message-ID: <3a91a794-b56e-eb21-58da-5abc8edbbc37@redhat.com>
Date:   Mon, 13 Mar 2023 16:03:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 3/8] x86/include/asm/msr-index.h: Add IFS Array test
 bits
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-4-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230301015942.462799-4-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/1/23 02:59, Jithu Joseph wrote:
> Define MSR bitfields for enumerating support for Array BIST test.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index d3fe82c5d6b6..ad8997773ad3 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -197,6 +197,8 @@
>  
>  /* Abbreviated from Intel SDM name IA32_INTEGRITY_CAPABILITIES */
>  #define MSR_INTEGRITY_CAPS			0x000002d9
> +#define MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT      2
> +#define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
>  #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
>  #define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
>  


Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

