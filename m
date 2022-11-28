Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2969F63B0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiK1SSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiK1SSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:18:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2552127C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669658457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e98UFkdCCGG3Z4gBcM2IeCiwkYxb6IzfKBSCSHIO4aA=;
        b=Q/8YmU3RFF3zW1CkZZLydaoZlHJ4OgI1H7EZsdVdmQdv/7/fiHJ+GFK1o/qa49qwZv/HmQ
        6uu5ujAzjEdg4QgUzc8tDSJhfy2Ku6Kh7YmDkgdXyvkBPuHflqHhAJ1v06jEPpAy46hDx2
        2ZAtPSTKs1GWaUGLGDZneNGAlfyfRpk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-368-O-7jXDu8P6O0IPWcuXLI1w-1; Mon, 28 Nov 2022 13:00:54 -0500
X-MC-Unique: O-7jXDu8P6O0IPWcuXLI1w-1
Received: by mail-wm1-f71.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso6581964wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e98UFkdCCGG3Z4gBcM2IeCiwkYxb6IzfKBSCSHIO4aA=;
        b=KxW6QIdTev4u4hBXUqXPSU8Btkx1ps9dhRH51NnBEPFrZm3MfGThF9m9RbIcfvvHlK
         eX4xnyb/8WwHynoVl6UQeJIQatGqauxkqtuyvyhr8dYqi/a8RycpFlG3XlG2roBzlwDZ
         zuwyTDDi8p1ia/NKAZwKI0oHL46DdxRJKH4NL2IXTfv81mycTYaT/dQi1UwF/a5Eb8PN
         LycEZrM45cOwVKKTx/WlmD/dUTpfqia3SpN37OBmDFcOJ7fGjdL6I4YcEfDc669cLiDS
         dFacbaqOBihcSk8XepYVYdAW1doO8dBi9Cp6sEFFFm2P/blIiEzKvFLMg5GU3n/LrUbH
         /kNg==
X-Gm-Message-State: ANoB5pmIFP9Enk0kWwmosRAhPdz3347EKiSM007sYJyubj4c4HXQk9SM
        +v5/wFej3y312I8Y24I/h2aKvQJlDQh2LPEnwMylw+davWJ+9spXDg/5ctThOtanSowDRfs+YKc
        HbKe11YMbS7m3LxV+Ui7AUYrm
X-Received: by 2002:a05:6000:501:b0:22c:d27d:12e4 with SMTP id a1-20020a056000050100b0022cd27d12e4mr31349431wrf.546.1669658452882;
        Mon, 28 Nov 2022 10:00:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf75JL9xpyxbk62wwl7Tj2ywAHQ0FCfs9OWKoJZX/LahWbRRuAEL1OaEBk/YCCj4JrSDaAtDKA==
X-Received: by 2002:a05:6000:501:b0:22c:d27d:12e4 with SMTP id a1-20020a056000050100b0022cd27d12e4mr31349404wrf.546.1669658452675;
        Mon, 28 Nov 2022 10:00:52 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id i12-20020adffdcc000000b002420cfcd13dsm6903820wrs.105.2022.11.28.10.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 10:00:51 -0800 (PST)
Message-ID: <b98429d8-6d18-cf0b-6ca0-d9d6472d21f9@redhat.com>
Date:   Mon, 28 Nov 2022 19:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     kirill.shutemov@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk, x86@kernel.org
References: <20221128091506.gp4l6klznqhigjxv@box.shutemov.name>
 <20221128101117.3614401-1-mailhol.vincent@wanadoo.fr>
 <20221128111112.dzavip4eqqgpyrai@box.shutemov.name>
 <CAMZ6RqJ0EgbLcz97ujqEzF1MBsH045W0Cu8mMuR0WCx_cTemCQ@mail.gmail.com>
 <20221128124513.76392c3d@gandalf.local.home>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] x86/asm: Remove unused COMPILE_OFFSETS macro from
 asm-offsets.c
In-Reply-To: <20221128124513.76392c3d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 18:45, Steven Rostedt wrote:
> 
>>> If you are sure <asm/ftrace.h> is never included from asm-offsets.c,
>>> remove #ifndef COMPILE_OFFSETS too.
>> It is never included from asm-offsets.c but it is still used by
>> kvm-asm-offsets.c:
>> https://elixir.bootlin.com/linux/v6.1-rc7/source/arch/x86/kvm/kvm-asm-offsets.c#L7
> IIRC, the reason for adding that was because that logic was screwing up
> asm-offsets.c. I'm not sure it screws up kvm-asm-offsets.c though.
> 
> This is one of those cases I wish I commented that code better :-/

I don't think KVM includes linux/ftrace.h or asm/ftrace.h at all.

Paolo

