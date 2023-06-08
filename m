Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015BA727741
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjFHG3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjFHG3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:29:07 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1579C1FF3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:29:06 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso394121a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686205744; x=1688797744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seSDBs2iSKzHixZsKT42rBb3Fve7AmQHnIoa9gvwdBE=;
        b=Bk+nSKVgyibd0bi0HrFmGY7dZ33LFmMjGTLfgjD2v7jGK8b86cFKGqNIUku/67Scuk
         BidoOCvBDy1oIdHL8FfI2bmu/s7VYiCCtSlreKd1XlCiuff5Pl34v1aeIa5EI4VDtbLq
         Lls+HonM6nl2H6x+OWOg69JBwLA28VfWppc8Z++1a/UjY7Qkb8J3QT5xzIjqNZpgEcqA
         XLyAwPPhl3xOdFTdqkLe1QgFOzzVEoQk9aopoV0Zy3l/pqvc5Cm1QJDYXEly9XW0ziiP
         +F9TCEqGrZ9vdJlBrYajB/Iu7oQoNPVw+ygDY8br+C5Y5Rz7NqlRP+AaHuVdSRTFtcX4
         jskA==
X-Gm-Message-State: AC+VfDyhIL0VehSY5u/OAYoGsTFsOeVsAwkp2RKJJ6BsropDtOatH+gL
        mLRfQnVygYGZuVX3RdTYv6A=
X-Google-Smtp-Source: ACHHUZ6J4Jq+eaM+N/W547FDXtvrOnP9Wu+gVHBtzzvLUx6kLTGdoEJOaSN3MGv9NFEf4b/+LLMpbg==
X-Received: by 2002:a05:6402:785:b0:50b:d76a:7904 with SMTP id d5-20020a056402078500b0050bd76a7904mr5764069edy.28.1686205744312;
        Wed, 07 Jun 2023 23:29:04 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id w25-20020a056402129900b0051659c6d50csm164816edv.22.2023.06.07.23.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 23:29:03 -0700 (PDT)
Message-ID: <2a64981c-ee53-f146-32a4-e97d4c036259@kernel.org>
Date:   Thu, 8 Jun 2023 08:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled
 is passed
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
 <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com> <874jnjj5z2.ffs@tglx>
 <278d7231-ee27-602f-4ba7-45d45d6772b3@citrix.com> <871qimkdft.ffs@tglx>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <871qimkdft.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 06. 23, 2:25, Thomas Gleixner wrote:
>> For usecases where there ought not to be any 32bit code at all (and
>> there absolutely are), it would be lovely if this could be enforced,
>> rather than relying on blind hope that it doesn't happen.
> 
> I think it's rather clear what needs to be done here to achieve that,
> but that's completely orthogonal to the intent of the patch series in
> question which aims to make CONFIG_IA32_EMULATION a boot time decision.

Agreed. The original intent was only to disable the 32bit paths in the 
kernel. I.e. set CONFIG_IA32_EMULATION=n by a runtime switch.

Then we came up with idea to disallow loading 32bit binaries to WARN 
people as the bins won't (mostly) work anyway. (We are/were aware this 
doesn't forbid running 32bit code.)

But now, when we are doing that, I think we should disable 32 bits 
completely by the switch. I.e. don't provide 32bit segments and 
whatever. And make that clear and documented in the series. Because as 
it stands now, it's half-way. Agreed? This whole attempt served as a 
call for opinions which we got and which is perfect.

thanks,
-- 
js
suse labs

