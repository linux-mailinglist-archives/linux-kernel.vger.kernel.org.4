Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCE472AADB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 12:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjFJKZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 06:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFJKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 06:25:03 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5735B8;
        Sat, 10 Jun 2023 03:25:01 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1c910ee19so29089101fa.3;
        Sat, 10 Jun 2023 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686392699; x=1688984699;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1amQyhc+nv8NT2kKmm9VpSR6/WIVyNzgkj2D/x5YIs=;
        b=HOoT5xmA7Ad3ui/OJhSgvvg519+/nfEH0TG2vAWtTAY31v6u3mKAHPz6jt0Rj1ljya
         rK+Cx6VDwUda7pDQdhNz9d0EouRjMqYO4FzNWnNHA0CfX9xzsC1jVAHlS+TQIy96Syi8
         Wa/EkwJNL6QwKsYbvZ7kUh3/4XTUgIPNEwNgNP3gxsaD5CRs90u46EkhEb43GNDPRReo
         3XW+OScQiHd15GRdRpvt969zU6o4K0HxcRnY7cLMsU22dy7oCA4516U04WI7A8apYUew
         u7WnuYeNGqjJFGUVZ7KYXsimFwXAGxvr1+UTLWsGS12ZBzJL1/syEtIhAOrMUoqSGVBz
         hx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686392699; x=1688984699;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1amQyhc+nv8NT2kKmm9VpSR6/WIVyNzgkj2D/x5YIs=;
        b=FZvtQvQZEjOEdB7aistbDD2tzfJuCg3OQ/my1QFy1vx0xG1lalJtVG2IXcpDpMel4Y
         VGawKaOytRl2ThxB62JFxQOALCYpuZAnZtF8lRhzvEraxvmFDQmTTSWr8bjnV73cJTqY
         Ey09+jSz6dFP+V48oGNGyAUq7Avn23Dfh/gV4Kz0R9dQON5c9p9W9xdn+muvuEHmjm0G
         0Aj5doYfGXO1AncmjCVnF+9ZT1c0Pnh3z/HJs2Sq19w2IbbIwn1DAB6isoREFFxi351F
         X1jkgE5fWxJgNifLPZj9kF6SJPpnpb4IaR/fgBTaVbfbRfANZ+bV9R/r1EIKHzwxVjtD
         gv8Q==
X-Gm-Message-State: AC+VfDwhM5ao9hbCFMteMeHyBQbPZQR/QIL4bBP83XUMWyyY1WqhwgEs
        TVG5Qr6X4rPcucOVII4dKC+D3C9lJQ4=
X-Google-Smtp-Source: ACHHUZ4ly3M+0uqFmfE4M46VDaXwNPpsVE7Bjwb2KKnTh4mooYPOtZj7fBlj2rBhLURtdYV9t7Ezyw==
X-Received: by 2002:a2e:a0d6:0:b0:2b2:5d2:ce63 with SMTP id f22-20020a2ea0d6000000b002b205d2ce63mr470206ljm.35.1686392699015;
        Sat, 10 Jun 2023 03:24:59 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.80.166])
        by smtp.gmail.com with ESMTPSA id x13-20020a2e9c8d000000b002ad9a1bfa8esm791825lji.1.2023.06.10.03.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 03:24:58 -0700 (PDT)
Subject: Re: [PATCH v6] sh: avoid using IRQ0 on SH3/4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
References: <71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru>
 <983d701befce7fc0010c53d09be84f5c330bdf45.camel@physik.fu-berlin.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <837a586e-5e76-7a5b-a890-403ce26ea51b@gmail.com>
Date:   Sat, 10 Jun 2023 13:24:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <983d701befce7fc0010c53d09be84f5c330bdf45.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/23 7:32 AM, John Paul Adrian Glaubitz wrote:

>> IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
>> return -EINVAL instead.  However, the kernel code supporting SH3/4 based
>> SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
>> IRQ #s from 16 instead.
>>
>> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
>> indeed are using IRQ0 for the SMSC911x compatible Ethernet chip...
> 
> Do you mind if I remove the ellipsis at the end of this sentence when I merge
> this later today? I think it makes no sense from a grammatical point of view.

   No, I don't mind. :-)

> Adrian

MBR, Sergey

