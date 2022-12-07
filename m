Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0598264566D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLGJ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiLGJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:27:00 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4F82AC4C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:26:58 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so27747475lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 01:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rc5yQDqo/33XKmo9TFbw+UiOcuPLeLQIUtoBKIpmXO0=;
        b=hpusZ9i/KP/+0osnv1x9yG0x4U7le0g2obDIvOu5VZxC7bNXSzblRCgBhlI1uqk1TP
         gVTaKEs1KV615ZKEXzGLqHTJcy0dh6p1OJbcoFy9/3N49qRpRdFveGTU3ZWzt2Pwl9mE
         GNSH8Xo3AzgWinYQhH6slHBPZmSRPeDTchnFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc5yQDqo/33XKmo9TFbw+UiOcuPLeLQIUtoBKIpmXO0=;
        b=GOYnqvCfhnOOwIFL+OnKLmGQcZ4a1Y1iGeVpOK8jzLSK2gR4ASk1XqdzyUXPF/1qD0
         gt6WfpQ77rn6lRNAqwEdJrhh6hfnBZbd2HnXEANeaVoWrjYYtj9o7jpvVbvl7YRSXw6a
         D+nHN2PqjEDFUZ3DxYSANl0fW1wm+mNiaDDcwS6lhI7isIYTGpj+6WUjVurfn9zNtaCe
         eHUbjVXDKREdaPoJE7bM5cXnClO/ODGp7jbIM28iv6u5rwCtIGAC2I97rx/oZAh2aIdN
         9spJAIDCekUwAul38fqHj//91YniuU+tYR8PIlSXZi/NTBQdO/oW4idc59bh42VP4+em
         zRlA==
X-Gm-Message-State: ANoB5pkF7QKkuRUUh0nCWog2DRDSxLlvpqNtn+8uhPQnI2/QUY5YJTbo
        nGSp28EH2VHSFgKu7ZG3iWFOCw==
X-Google-Smtp-Source: AA0mqf4hWKfZ4riTjA3tCg125rG60+g5P5+1UK5nQnrVLXWRJJV5isE8QKJoHc9h/+JpqPYWkAWmzQ==
X-Received: by 2002:a05:6512:128f:b0:4a2:4d89:aa58 with SMTP id u15-20020a056512128f00b004a24d89aa58mr26940806lfs.646.1670405217033;
        Wed, 07 Dec 2022 01:26:57 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r13-20020a2e94cd000000b002778a76a3c3sm1886477ljh.112.2022.12.07.01.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 01:26:55 -0800 (PST)
Message-ID: <41c6f1b8-5c09-d7d4-14b7-214a9f844156@rasmusvillemoes.dk>
Date:   Wed, 7 Dec 2022 10:26:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Content-Language: en-US, da
To:     Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
 <Y49cGRDBVP3bHJuT@casper.infradead.org> <Y49lxZMsKrXRciIg@kroah.com>
 <Y495XgCv+dhGA2Tg@casper.infradead.org> <Y4+OFzfAh7XqOoWv@kroah.com>
 <Y4+jrBBRQ6XfNMfY@casper.infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Y4+jrBBRQ6XfNMfY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2022 21.18, Matthew Wilcox wrote:
> On Tue, Dec 06, 2022 at 07:46:47PM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Dec 06, 2022 at 05:18:22PM +0000, Matthew Wilcox wrote:
>>>  static inline struct external_name *external_name(struct dentry *dentry)
>>>  {
>>> -	return container_of(dentry->d_name.name, struct external_name, name[0]);
>>> +	return container_of_not_const(dentry->d_name.name,
>>> +				      struct external_name, name[0]);
>>>  }
>>
>> Will just:
>> 	return container_of((unsigned char *)dentry->d_name.name, struct external_name, name[0]);
>> work by casting away the "const" of the name?
>>
>> Yeah it's ugly, I never considered the address of a const char * being
>> used as a base to cast back from.  The vfs is fun :)
> 
> Yes, that also works.  This isn't particularly common in the VFS, it's
> just the dcache.  And I understand why it's done like this; you don't
> want rando filesystems modifying dentry names without also updating
> the hash.
> 
> I feel like all the options here are kind of ugly.  Seeing casts in
> the arguments to container_of should be a red flag!
> 
> Here's a bit of a weird option ...
> 
> +#define container_of_2(ptr, p_m, type, member)                         \
> +       _Generic(ptr,                                                   \
> +               const typeof(*(ptr)) *: (const type *)container_of(ptr->p_m, type, member), \
> +               default: ((type *)container_of(ptr->p_m, type, member)))
> +
> 
>  static inline struct external_name *external_name(struct dentry *dentry)
>  {
> -       return container_of(dentry->d_name.name, struct external_name, name[0]);
> +       return container_of_2(dentry, d_name.name, struct external_name,
> +                               name[0]);
>  }
> 
> so we actually split the first argument into two -- the pointer which
> isn't const, then the pointer member which might be const, but we don't
> use it for the return result of container_of_2.

Wait, what? The const-ness or not of dentry is completely irrelevant,
we're not doing any pointer arithmetic on that to obtain some other
pointer that morally should have the same const-ness. We're
dereferencing dentry to get a pointer value, and _that_ pointer value is
then subject to the pointer arithmetic.

Note that external_name might as well have had the prototype

static inline struct external_name *external_name(const struct dentry
*dentry)

and then your container_of_2 would break.

I think that if we want to move towards container_of preserving the
constness of the member pointer, the right fix here is indeed a cast,
but not inside container_of, but rather to cast away the const afterwards:

  return (struct external_name *)container_of(dentry->d_name.name,
struct external_name, name[0]);

knowing that yes, the dentry only keeps a const pointer to the name[]
member for good reasons, but the callers very much do need to modify the
rest of the struct.

Rasmus

