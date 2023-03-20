Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F05C6C11F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCTMed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjCTMeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14D017CC8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679315613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mL7Pa+Jk7dydG+7X5vomiVh7eAKGEcv01KgJbTLjz/Y=;
        b=OcQRAJ2/IUfTCTNDJ5RcCFh60yImyo96zABa1wAf5mFWVAsFdHAKM0ycPEBoQ/QbGC6+Bn
        EyMLbCrFpAND95TrxYsjt7Y7Th6RL4Ofkb3mOeVKaghDU0d91linqbNKtoEnbZyimscr+F
        kIUPlr/qWwBaY8asSn+5/hG8pBwjjQ0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-N_hFCDjoOuSIczy-4r7ywg-1; Mon, 20 Mar 2023 08:33:31 -0400
X-MC-Unique: N_hFCDjoOuSIczy-4r7ywg-1
Received: by mail-qk1-f198.google.com with SMTP id 187-20020a3707c4000000b007468d9a30faso638912qkh.23
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679315611;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mL7Pa+Jk7dydG+7X5vomiVh7eAKGEcv01KgJbTLjz/Y=;
        b=Gd3Lgto70NefYfgETbKt76emv4eA9mOg+1fdXT6K7zHX+0yITXDyEv6sCL1UWXDdWs
         sv5ONTbKMN+dmj6rQSPFeRgQW3bYgUGOw+sUUjh6BULfliF4mHl1sr6/blY6RpExRzL4
         V/McOWWTR/3S5JNleKfdhftvplc1AVQNSxuvsU6ly8FcC+NqCFhxscTNac+fbUSY6Rvx
         SPoAaYJooNlL+DoUqa+qJVywB7bm3DRYV84e31ks5pqIPCSeBPGpPw99fyruLIAh/DkK
         pdrL9SfEc4EOnvBHQL+NyOOidO2+/zKllzOeNt6mNbuVWUoUnBrrKxAnrYuaQDAjFSm+
         h4ew==
X-Gm-Message-State: AO0yUKVugEePI9m40Qkuld5329XdRR4vWRTzUggWdUj57HGxXoapKYd+
        ahz1RAcnumC/83UCJTzTDFfK0U2t9bRM/lKbiPr5OKQ9Gehq/Je3pPYKS3RUkOVcTIvl4hGjwJV
        Ryc7jqMapRP8RwxBG5ug5gaMc
X-Received: by 2002:a05:6214:509d:b0:5c8:15bc:f630 with SMTP id kk29-20020a056214509d00b005c815bcf630mr8113708qvb.24.1679315611295;
        Mon, 20 Mar 2023 05:33:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set9m58vXQOg3Ou0SQtJl6BazktNBq/LaOdPM7o0iQnoGKYlgBO/jM4F6HPU2A5dh/YPqrJKRyw==
X-Received: by 2002:a05:6214:509d:b0:5c8:15bc:f630 with SMTP id kk29-20020a056214509d00b005c815bcf630mr8113670qvb.24.1679315610953;
        Mon, 20 Mar 2023 05:33:30 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 75-20020a370a4e000000b006ff8a122a1asm1702109qkk.78.2023.03.20.05.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 05:33:30 -0700 (PDT)
Subject: Re: [PATCH] ALSA: ymfpci: remove unused snd_ymfpci_readb function
To:     Nathan Chancellor <nathan@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, ndesaulniers@google.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230318132708.1684504-1-trix@redhat.com>
 <87mt49mabx.wl-tiwai@suse.de> <20230319233444.GA12415@dev-arch.thelio-3990X>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6896b706-a406-1667-8d87-765cd02e6fca@redhat.com>
Date:   Mon, 20 Mar 2023 05:33:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230319233444.GA12415@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/19/23 4:34 PM, Nathan Chancellor wrote:
> On Sun, Mar 19, 2023 at 09:09:22AM +0100, Takashi Iwai wrote:
>> On Sat, 18 Mar 2023 14:27:08 +0100,
>> Tom Rix wrote:
>>> clang with W=1 reports
>>> sound/pci/ymfpci/ymfpci_main.c:34:18: error:
>>>    unused function 'snd_ymfpci_readb' [-Werror,-Wunused-function]
>>> static inline u8 snd_ymfpci_readb(struct snd_ymfpci *chip, u32 offset)
>>>                   ^
>>> This static function is not used, so remove it.
>>>
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>> I applied now, but still wondering why it warns at all even if it's a
>> static inline function...
> See commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build") for some more information. The key part
> of the commit message is 'with W=1', this will not happen with a normal
> clang build.

IMO from this general cleanup, being at W=1, is the correct location.

There many functions that could be removed and some that should not be.

Tom

>
> Cheers,
> Nathan
>
>>> ---
>>>   sound/pci/ymfpci/ymfpci_main.c | 5 -----
>>>   1 file changed, 5 deletions(-)
>>>
>>> diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
>>> index c80114c0ad7b..2858736ed20a 100644
>>> --- a/sound/pci/ymfpci/ymfpci_main.c
>>> +++ b/sound/pci/ymfpci/ymfpci_main.c
>>> @@ -31,11 +31,6 @@
>>>   
>>>   static void snd_ymfpci_irq_wait(struct snd_ymfpci *chip);
>>>   
>>> -static inline u8 snd_ymfpci_readb(struct snd_ymfpci *chip, u32 offset)
>>> -{
>>> -	return readb(chip->reg_area_virt + offset);
>>> -}
>>> -
>>>   static inline void snd_ymfpci_writeb(struct snd_ymfpci *chip, u32 offset, u8 val)
>>>   {
>>>   	writeb(val, chip->reg_area_virt + offset);
>>> -- 
>>> 2.27.0
>>>

