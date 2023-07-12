Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47F274FFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjGLGra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjGLGr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:47:26 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B82F19B;
        Tue, 11 Jul 2023 23:47:25 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so71464575e9.3;
        Tue, 11 Jul 2023 23:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689144444; x=1691736444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foHvoBBfPTVQkBVi8mySw1VhQvfle75h/iYshfe3d14=;
        b=BxAC+Lwyeh7HadVCQqqwfP94xBRq0h4hFmBG0/WqlIYfC5sMeewfo/ba/9R8LyDgJ5
         tuae13/VVTABxXWeNE0yAHxIjTYmCq4ZBYX6gU6PvkERFr9XjukO4F5hM7f0GcwNv9Bz
         CITv0eXLwX9k+/sJnEmP8mT2M60ncovJFAZ6Jt0F/id5jpBFbD4U15BEsPN5kOlkYnlW
         iA4gfjJ0P7HJMPpN7x0l7Zqhi4OCgljO68xUicyHeyZNKYzzvmEBlE5Uvxmc8XOD48i5
         NBu9R2yfAEji96nLYzncv2+UQSELbg5kB/8B/jNHFqtb+T2Wp4YCUPuaqfCMykfikMhM
         BrJQ==
X-Gm-Message-State: ABy/qLawlFqo+lfJfVwRjMLtgQfBFzXVqstDQjMmwtsLGtFVFeiNBHL1
        1tz/UIRm6XioWwLzezxDRpb9ufFaVCDCzQ==
X-Google-Smtp-Source: APBJJlF2mTLoSRlIAkqpRMJumEW6a38O3Ms2HJaT0rQkHDPqz/vdPpFML7QEgTNTpNRgutb6Oyw+Ww==
X-Received: by 2002:a05:600c:253:b0:3fa:984d:7e99 with SMTP id 19-20020a05600c025300b003fa984d7e99mr18235981wmj.22.1689144443692;
        Tue, 11 Jul 2023 23:47:23 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b003143867d2ebsm4124322wrq.63.2023.07.11.23.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 23:47:22 -0700 (PDT)
Message-ID: <23779aa4-e1c1-c311-5f6b-8be652826cc7@kernel.org>
Date:   Wed, 12 Jul 2023 08:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] libkmod, depmod: Load modprobe.d, depmod.d from
 $prefix/lib.
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>, linux-modules@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711153126.28876-1-msuchanek@suse.de>
 <20230711153126.28876-3-msuchanek@suse.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230711153126.28876-3-msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 07. 23, 17:31, Michal Suchanek wrote:
> There is an ongoing effort to limit use of files outside of /usr (or
> $prefix on general). Currently all modprobe.d paths are hardcoded to
> outside of $prefix. Teach kmod to load modprobe.d from $prefix/lib.
> 
> On some distributions /usr/lib and /lib are the same directory because
> of a compatibility symlink, and it is possible to craft configuration
> files with sideeffects that would behave differently when loaded twice.
> However, the override semantic ensures that one 'overrides' the other,
> and only one configuration file of the same name is loaded from any of
> the seach directories.

search

...
> --- a/man/Makefile.am
> +++ b/man/Makefile.am
> @@ -17,9 +17,14 @@ EXTRA_DIST = $(MAN5:%.5=%.xml) $(MAN8:%.8=%.xml)
>   CLEANFILES = $(dist_man_MANS)
>   
>   %.5 %.8: %.xml
> -	$(AM_V_XSLT)$(XSLT) \
> +	$(AM_V_XSLT)if [ -n '$(prefix)' ] ; then \
> +		sed -e 's|@PREFIX@|$(prefix)|g' $< ; \

Hmm, if prefix is empty, this will remove @PREFIX@. So why you need this 
'if' at all?

> +	else \
> +		sed -e '/@PREFIX@/d' $< ; \
> +	fi | \


-- 
js
suse labs

