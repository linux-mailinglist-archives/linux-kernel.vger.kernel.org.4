Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1C370DAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbjEWKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjEWKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD7FFD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684838816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdamzV1t3DecLpEkbaHfZsvvgjRzeqa9TpV6iGjo904=;
        b=RlgjD1MSz4fyIviLcqbVD/a+7nN1i6P8ANAiQizoHjYVy0hQubTpeXbqc/jd09NPiq7jle
        dCmhwUN9hEevapt9iF7jZKWPqbIMFrg3+f7eHli6XjtYINbl6jPemac++j5yY7TpIjInOt
        4RK2miK1rqR+1gRKTDrK0OlMp2MnE9w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-woAAGKI4MlO4GiCX4hBeGg-1; Tue, 23 May 2023 06:46:55 -0400
X-MC-Unique: woAAGKI4MlO4GiCX4hBeGg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-513ddd8e39cso768315a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684838814; x=1687430814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdamzV1t3DecLpEkbaHfZsvvgjRzeqa9TpV6iGjo904=;
        b=AtOr4pW1l87tzcJ4xKp/LVoEp4/TfKSKFdnuSyT0x6TAwzXz55kt+p3EyzUYzz0Cxc
         99Y/r/pCjzlZbYYZa/optgpWwluyGotnHKrxZvlkOUgrOXdL/8sNm5ERHGpVTQEV8Xri
         +Ldg8PcqElKcMFn8aN22X3l55r+QmWJfFrjDMCcfQVBahhBhvJljkZN02BGUeJmN5qj7
         I/SOhkdjA/gxi5o8Rw8iJ7tdaqFJCiZ5ssFChmheBTcLB69D9qgbLK8nsvKIee3KssO9
         KDYGz/pL9zD0nq2SPwqyYJBmf8VL8MhdaytW0QJltFYARC+bD0o+JDkySbibJLOflQum
         owYw==
X-Gm-Message-State: AC+VfDzejpJrYiJnvW8fqJl6c2sVnvO37GTG7ap+mB51MiRA9e/JlC+o
        okPUwDNp3yoza7XZOGuV4qlNrst0/NRn+iu7+tvjQEA/fxJ5j/VZACeRI01V3QdJRwztCMe4f32
        OafzS8gkdYb7v12+74RZSAwll
X-Received: by 2002:a17:907:74d:b0:94f:7edf:8fa1 with SMTP id xc13-20020a170907074d00b0094f7edf8fa1mr13028312ejb.32.1684838813948;
        Tue, 23 May 2023 03:46:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ791OsQNLyxRvm0hlAHuT1LWt1eKUmvsJqgUmQz6Jj33QWw/nF9uPCy+9VTbhkcgy3lyVXADQ==
X-Received: by 2002:a17:907:74d:b0:94f:7edf:8fa1 with SMTP id xc13-20020a170907074d00b0094f7edf8fa1mr13028296ejb.32.1684838813634;
        Tue, 23 May 2023 03:46:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u25-20020a1709063b9900b009596e7e0dbasm4194292ejf.162.2023.05.23.03.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:46:53 -0700 (PDT)
Message-ID: <ce7d7bef-c342-fb1a-8a7a-463ffcfd2896@redhat.com>
Date:   Tue, 23 May 2023 12:46:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] platform/x86: think-lmi: Correct System password
 interface
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
 <20230517181945.3725-2-mpearson-lenovo@squebb.ca>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230517181945.3725-2-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 5/17/23 20:19, Mark Pearson wrote:
> The system password identification was incorrect. This means that if
> the password was enabled it wouldn't be detected correctly; and setting
> it would not work.
> 
> Correct these mistakes.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
>  drivers/platform/x86/think-lmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index d9341305eba9..b8431d3b137f 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -171,7 +171,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>  #define TLMI_POP_PWD (1 << 0)
>  #define TLMI_PAP_PWD (1 << 1)
>  #define TLMI_HDD_PWD (1 << 2)
> -#define TLMI_SYS_PWD (1 << 3)
> +#define TLMI_SYS_PWD (1 << 6)
>  #define TLMI_CERT    (1 << 7)
>  
>  #define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
> @@ -1504,7 +1504,7 @@ static int tlmi_analyze(void)
>  		tlmi_priv.pwd_power->valid = true;
>  
>  	if (tlmi_priv.opcode_support) {
> -		tlmi_priv.pwd_system = tlmi_create_auth("sys", "system");
> +		tlmi_priv.pwd_system = tlmi_create_auth("smp", "system");

"smp" ?

Also this is not explained in the commit message.

Regards,

Hans


>  		if (!tlmi_priv.pwd_system)
>  			goto fail_clear_attr;
>  

