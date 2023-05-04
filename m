Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41756F6788
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjEDIbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjEDIa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:30:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACD45FC2;
        Thu,  4 May 2023 01:27:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so204254e87.2;
        Thu, 04 May 2023 01:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683188856; x=1685780856;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BtbTazpmLK0KSvj4AZeeyjj76DWKlTXEWvhg3rsLf0=;
        b=np3+HZuDjKNtHhzInJKaL4ni7hmJwGjw4t1PgOPYsSARUNDRNfEIgkaxROwcfPNW5B
         JsGuTYTCihmxm9MoKbm5pT6qraIdN07ozJpgh3erjqKs291SvhUNcQSqylqGfIJ1K4Hd
         39JzqpILR3ZByLm+tLDvK+6VWltcOkJeOL4sxXstRMZt48yw6Tb5+OovfhegQjrdJIDn
         Roxx/15qo+tLPhfatNccapdhnhjHwgz8Q7zTYTv8H2+K87LPcECTwM7GnB9LhVJk1Dg3
         CHtGDvQX5kVJ6OumAp0Z8WbU2hHoKabTRWYNobdqh3627GxxmTBSd1XFjPKQ96akKOl8
         H/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683188856; x=1685780856;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BtbTazpmLK0KSvj4AZeeyjj76DWKlTXEWvhg3rsLf0=;
        b=bvEgR2biR8sihQEqnVlApvKeKhbDfDxRCc+DlUbO0rSxlFE8uaURDvW0c7grVeQqSN
         VSesjDp0xAZqit8O03GDczrnnaQn7sylovAG3fh4MN4iPp2CEGXzGLFIq1IFxwO3RxxX
         F4VkSlosP7t0P3876bqHM6LMJ1AABdYDHnGwdlp2+X0iKckh2EZ4N+ql7DO2LyBvsoDJ
         hz9OkuJt12Hj/eZUPHoaE0tFTgSDNGynRxVd97ufc8EXoqboSwcbxdy5fISOeP2zNuje
         8S9HPnCX2/1kGsFry81zsyIPDX9K/V+ZT/o0oQcKLzUdAGnQUrK11wJdjsA8Ubb0cnDs
         T8WA==
X-Gm-Message-State: AC+VfDwwM/bBdM2paug5P0p/+RF2I6C2E8jc86IcjRmvokkAX6MlzkWI
        8yzkmvanU8Eg8IVhYkIeT+gAc4b8qto=
X-Google-Smtp-Source: ACHHUZ6WxHnARl3Y7wPkAyRHxQ9IZvhzKELRZSJbTLi3e2ghMfMi8VKMYojoluPBJy+0pbL2ESqwyQ==
X-Received: by 2002:ac2:4353:0:b0:4f0:80:d0c0 with SMTP id o19-20020ac24353000000b004f00080d0c0mr2162900lfl.63.1683188855735;
        Thu, 04 May 2023 01:27:35 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.76.17])
        by smtp.gmail.com with ESMTPSA id j1-20020a19f501000000b004eff0bcb276sm5210649lfb.7.2023.05.04.01.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 01:27:35 -0700 (PDT)
Subject: Re: [PATCH v5] usb: dwc3: core: add support for realtek SoCs custom's
 global register start address
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230504034423.20813-1-stanley_chang@realtek.com>
 <96706396-7023-b895-169a-788aad11adcb@gmail.com>
 <44451716afa541e298b2e5640fe3aec9@realtek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <747ce0a9-a629-e3f9-c59c-388333d3d911@gmail.com>
Date:   Thu, 4 May 2023 11:27:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <44451716afa541e298b2e5640fe3aec9@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 11:26 AM, Stanley Chang[昌育德] wrote:
[...]

>>> The Realtek RTD1xxx SoCs were designed, the global register address
>>> offset at 0x8100.
>>
>>   Can't parse that, perhaps "with" is missing?
>>
>>> The default address offset is constant at DWC3_GLOBALS_REGS_START
>>> (0xc100). Therefore, add a check if the compatible name of the parent
>>> is "realtek,rtd1xxx-dwc3", then global
>>
>>    Wildcards are not allowed in the "compatible" props...
> 
> I can't understand your meaning.
> Do you mean I can't use rtd1xxx ?

   You can't, indeed.

MBR, Sergey
