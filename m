Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0F46830F8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjAaPLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjAaPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:10:40 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BD859548;
        Tue, 31 Jan 2023 07:08:46 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-163adf0cfc4so8426347fac.7;
        Tue, 31 Jan 2023 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nohc6E2ihYOuK35Jea33fNaQW2kkFVKii1+lDbXYoXE=;
        b=LKUUEQFvdbXg0F7ZzAUYxKQYRgMZTPIUvQ6MS/Abge1gDeK8F6k4qwR3h1Ui26ut3w
         8/RkuJTy0zFzZNi+7+ja00myfNp4wtgNJ3ChkRc/vxo0IVJH9n3D/Q/4ymbgj9UW4rmO
         vIZwxXpR96K3Co2SL1R21rW7V3I4+n3yUafMl2MCCp9rsp6l7O5c2M/9JmeDgQhhI+cY
         8t3gln9oCxLpT2CL8DQbsM1wJ1uJ8KjSP6DFVycKCmi8lZIIVuKtDzngrljpHSW+LwbO
         V27YMKNc3ENAyD25/8HBW/nhaYb1yUPozU5t+aWhhR2ZpvWDIoUZQocov5PA/VHPGSva
         /NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nohc6E2ihYOuK35Jea33fNaQW2kkFVKii1+lDbXYoXE=;
        b=bbl9zqiyXE4sI3/e54ZAD4dMl9qf1IYTHOi3QkObE6l82HALDAeIu2ZHk7ld2Pli+8
         U3r9gbUg/60dW1HSgNleYbyCDynM4mZHYvgJl/1tHyrt+raBcg5AdKAt7qmIi1dZvAGM
         R5BlvY7jq3pSNB9QpXrMoJkoHwIJXpUsQcqNHxIpybGr2Ld96gXAlYv91/eiK4v6wTX4
         tVc2r39GUh+P7wuYF5D1ni/UKB46UiJSKlQWY4WcFLZuFjRkVjhPTtQ8c+HJ5lk0ZYqZ
         F9MWnxZatc7/dUPWxlAzJJfc/P+a7YCWaAlovpkBzOUQNq0bgJI00N7UTMXdWeUzawJN
         sMRw==
X-Gm-Message-State: AO0yUKW9bgCrCfw4w63Ngwq/6T7l94/FmYef99gytU3NFXv2XYEsKjlB
        NVEaJS+pzWmGeMCqtmv/P8Mz/art/LI=
X-Google-Smtp-Source: AK7set8NsaYc5sNtkn/Z6zl56qhpr0hi+bisvlrj6EqghOSyhntrOk4esNAh+err3DkVEXLMZbptpg==
X-Received: by 2002:a05:6870:9106:b0:163:ade9:27b4 with SMTP id o6-20020a056870910600b00163ade927b4mr5132883oae.26.1675177671306;
        Tue, 31 Jan 2023 07:07:51 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id z12-20020a056870738c00b0016343c187dfsm6670244oam.32.2023.01.31.07.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:07:50 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
Subject: Re: [PATCH] rust: add this_module macro
Date:   Tue, 31 Jan 2023 12:07:45 -0300
Message-Id: <20230131150745.370345-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <Y9kasJQZf146ekp+@kroah.com>
References: <Y9kasJQZf146ekp+@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:42:08PM +0100, Greg KH wrote:
>On Tue, Jan 31, 2023 at 10:08:41AM -0300, Martin Rodriguez Reboredo wrote:
>> Adds a Rust equivalent to the handy THIS_MODULE macro from C.
>> 
>> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
>> ---
>>  rust/kernel/lib.rs | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>> 
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index e0b0e953907d..afb6b0390426 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -80,6 +80,18 @@ impl ThisModule {
>>      }
>>  }
>>  
>> +/// Returns the current module.
>> +#[macro_export]
>> +macro_rules! this_module {
>> +    () => {
>> +        if cfg!(MODULE) {
>> +            Some(unsafe { $crate::ThisModule::from_ptr(&mut $crate::bindings::__this_module) })
>> +        } else {
>> +            None
>> +        }
>> +    };
>> +}
>
>While this is handy, what exactly will it be used for?  The C
>wrappers/shim/whatever should probably handle this for you already when
>you save this pointer into a structure right?
>
>Surely you aren't trying to increment your own module's reference count,
>right?  That just doesn't work :)
>
>thanks,
>
>greg k-h

This was meant for setting the owner field of a file_operations struct
or the cra_owner field of crypto_alg and many other structs.

I know that increfing a module without a good reason is dead dumb, so
I'm not trying to send things in a downwards spiral. @@@

And yes, I should have mentioned that in the commit message, but I let
slip that detail.
