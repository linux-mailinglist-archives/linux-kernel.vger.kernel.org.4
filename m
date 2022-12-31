Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73765A05E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 02:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbiLaBO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 20:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbiLaBO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 20:14:56 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506C8178B4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 17:14:56 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c1:5967:deb4:a714:2940] ([IPv6:2601:646:8600:40c1:5967:deb4:a714:2940])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2BV1EVmS1463922
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 30 Dec 2022 17:14:32 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2BV1EVmS1463922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022120601; t=1672449273;
        bh=p758Zgd+yGDuok+ksdSxE2idQGSI127bm719tcowUaE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=G4LeLSN1au620qGat9Nr+WlKrYb7uSchs4cjj5ly0FiMkE05k6lizUbSIlwEBhEI7
         w+kdSn+PABHB9xif38RY+Vt10NnD9unHylbnxZnZ87bqtWrwGBZxtAk0jS7Jn/WHzr
         oc5/PdIRZ8o6PVFPfme08Ihme5BC2aHQftb1nYb6lVOECNg9d21n9nE7eJgw/in88R
         FYfBTgAypVgCc1Fvqd2QayztYKT2cqjxFjY+fodRgQbu+B0C/jwmJj71Wl/2thAyQC
         2HncnwoI+KOaHMwZgSQ0rXJ86AQzrJ1MQRbmk4UOf+auLmv94S6xThtlWKI5pNiChR
         6CYFmtuhbDQpg==
Message-ID: <7dc37024-5bdd-1206-020b-5072629b80dd@zytor.com>
Date:   Fri, 30 Dec 2022 17:14:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Content-Language: en-US
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
References: <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com> <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com> <Y62MdawGaasXmoVL@zn.tnic>
 <Y68Js5b0jW/2nLU4@zx2c4.com> <Y68Zf/MKmX3Rr18E@zn.tnic>
 <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
 <Y69B40T9kWfxZpmf@zn.tnic> <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com>
 <Y69h6ur79SMhu61F@zx2c4.com> <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
In-Reply-To: <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/22 17:06, H. Peter Anvin wrote
> 
> TThe 62 MB limit mentioned in boot.rst is unrelated, and only applies to 
> very, very old kernels that used INT 15h, AH=88h to probe memory.
> 

I am 88% sure this was fixed long before setup_data was created, as it 
was created originally to carry e820 info for more than 128(!) memory 
segments. However, as we see here, it is never certain that bugs didn't 
creep in in the meantime...

	-hpa

