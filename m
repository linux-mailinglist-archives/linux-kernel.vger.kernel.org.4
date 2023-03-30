Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99A26CFE16
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjC3IUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjC3IUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0EF1BEF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680164374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6jCDp5R5UTDCRaJgvAusDHOREnAzeh37U4DgZVNJuM=;
        b=cAIrlPIG5njsVVlW0HKNysgG0csXoyGqeyhzugJ65zhvFwlFLwMV8RytU6XrFnu+riB10c
        ZWV8qf4mdCHh9bWSWXMn7q2iByjRzJ71eXe1JrgpmKG9rP5vkFIKtCjsrbmgGJaV3oV+Bn
        IWQbzLhKUCetZDwOJrsNX6lyfcaqTy4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-RXm2-DtFOfOn3FLA6EyefQ-1; Thu, 30 Mar 2023 04:19:32 -0400
X-MC-Unique: RXm2-DtFOfOn3FLA6EyefQ-1
Received: by mail-ed1-f69.google.com with SMTP id x35-20020a50baa6000000b005021d1b1e9eso26249428ede.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680164371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6jCDp5R5UTDCRaJgvAusDHOREnAzeh37U4DgZVNJuM=;
        b=MpwZGj2DmAO286LM9Fe94Z0vfb/mRg7PI9Cg+OaWI3Pi7AW5buY0QBrSlAT1PRE42P
         /Kiczyz8AY4WoTBYCgtYxEWOzZAjWG6p+uC3oUPOSBnaFvNcejLTHXZrEfPICvI4prK5
         uXCB8bya4761hERGDdrFD8Nf9gDr9yehYC0tATFRq02olcXf9e2yzMVgVevlVbuvUbzE
         s0Rf4GVpAmnpsTXyOFNyjxdnKGNtvBFKbo3zpPQRxcFjwuliBqfJqil99iH0O5TJM6bv
         JxIlWvIZvttn7YgYFLloLjeDNRFJa/4I9PC9nuTD3jWScf1wLfcedP6d/mZc/Rbp7ZZg
         rvCw==
X-Gm-Message-State: AAQBX9e4nS+qeHfn9FtnWtnmwiM+XnPXraFB+pn7xWxPb7fEXyrWjbjT
        fSy3xTYTjcXlRqLX35FDlA4kNb+F6qSeupPMYF4M8+8BPlzK8vSCBVU+qNgfOxlsI/zk7cY2U79
        45c0CQ8IEiFJoHnXa3s0HScEG
X-Received: by 2002:aa7:ccc7:0:b0:4ac:b614:dd00 with SMTP id y7-20020aa7ccc7000000b004acb614dd00mr20695724edt.30.1680164371220;
        Thu, 30 Mar 2023 01:19:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350apSQp5MBlS/cA/cdZpOW4RsJ11da4ieQjuIibFRO7HEAy3t2ntlH34TjEdg6AUTexNtD9DcA==
X-Received: by 2002:aa7:ccc7:0:b0:4ac:b614:dd00 with SMTP id y7-20020aa7ccc7000000b004acb614dd00mr20695718edt.30.1680164370986;
        Thu, 30 Mar 2023 01:19:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v15-20020a50c40f000000b004d8d2735251sm18024701edf.43.2023.03.30.01.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 01:19:30 -0700 (PDT)
Message-ID: <1e6460f9-5dbe-57a4-2986-ff3cbf5a39ad@redhat.com>
Date:   Thu, 30 Mar 2023 10:19:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] fs: vboxsf: remove unused out_len variable
Content-Language: en-US, nl
To:     Tom Rix <trix@redhat.com>, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230329230310.1816101-1-trix@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230329230310.1816101-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/30/23 01:03, Tom Rix wrote:
> clang with W=1 reports
> fs/vboxsf/utils.c:442:9: error: variable
>   'out_len' set but not used [-Werror,-Wunused-but-set-variable]
>         size_t out_len;
>                ^
> This variable is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  fs/vboxsf/utils.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
> index dd0ae1188e87..ab0c9b01a0c2 100644
> --- a/fs/vboxsf/utils.c
> +++ b/fs/vboxsf/utils.c
> @@ -439,7 +439,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  {
>  	const char *in;
>  	char *out;
> -	size_t out_len;
>  	size_t out_bound_len;
>  	size_t in_bound_len;
>  
> @@ -447,7 +446,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  	in_bound_len = utf8_len;
>  
>  	out = name;
> -	out_len = 0;
>  	/* Reserve space for terminating 0 */
>  	out_bound_len = name_bound_len - 1;
>  
> @@ -468,7 +466,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  
>  		out += nb;
>  		out_bound_len -= nb;
> -		out_len += nb;
>  	}
>  
>  	*out = 0;

