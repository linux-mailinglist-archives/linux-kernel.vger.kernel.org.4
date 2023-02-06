Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5A68C739
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBFUFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBFUE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:04:59 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC191EFED;
        Mon,  6 Feb 2023 12:04:58 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so19345045lfb.1;
        Mon, 06 Feb 2023 12:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zk+ewRFBhXIWi/NAH6JaxjNcUKFG2te5CNQ01jAgjCE=;
        b=BkRHgrWSUAjfU15CeaXwVzboWNMD5KWAoUgjN1dKzTEO5Xz1Bhy3ePoyPYPHLQ4lE/
         ckGqry3+R7L0ypILO0CtXJJ/QyI0bDVfDAX02niqoIuuBpk77LzGslSNsW799so3lsfu
         zJUL4MxlvHzb5wr1quEP2WU2B+itSIOzlmnKyqj2UJsKzch1WCQTPyQaZ/m1IFOahiRQ
         E7RLpDuoiiExjdWCQGVzmoErqL3jD6PeOYghX8XLiJqGgExB11Oo4l3epyvfdJ+uIxmx
         IxRqrGCIVo/Oq/ymwTSWzF7XzdUI3pJIixX+LyIab6E3hgkidnxXV0jvuSWMaO5XHdEm
         CUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zk+ewRFBhXIWi/NAH6JaxjNcUKFG2te5CNQ01jAgjCE=;
        b=ImyQ1LNrKNn/nABcI5EjQc//kTJg5+yIBY8EudTtLHFb6GrgWuBMzdteTA0rouV2Wl
         4LWNwJTvbSNnMXb9CIf/09Xm9tVDviSUjOn97qLSvgP93J8+wAh4wjsSw1dU6OoFQiCS
         uuECJCmxP9i/hO4Vs3inKgQznWYmHg9yv/ezdXE66dLXfNnY7fDeV8qYGHneaqZsYIfA
         qz9O06bdzmb6C0MtmhWRyU8LUYEiY+qdifxKIa5AgbkptMpehXJ9oMIlbfbSpkGbbHJo
         8nEW6oAcXEx7Ec4ethxaGJpCDRPT1L7n0yNjFfUmZdLvVxEcAVDTAkBgGOykTDVws5cx
         pM+Q==
X-Gm-Message-State: AO0yUKWBRYDGoGStKC6TaOzqdJh8o6Cze0H3urplmRcKZKS3m7CeEokK
        dTeiYd2cjbIjmioicQVY0fmP5chaGdA=
X-Google-Smtp-Source: AK7set/VhtyMGalxRjvC49B4taQLrBSwKjz4qGzPJm8AOaXdKY978ZfmKRCdkQvQG8x7pDdDyT8uxw==
X-Received: by 2002:ac2:5ddc:0:b0:4cc:586b:183b with SMTP id x28-20020ac25ddc000000b004cc586b183bmr38150lfq.60.1675713896919;
        Mon, 06 Feb 2023 12:04:56 -0800 (PST)
Received: from [192.168.1.103] ([178.176.73.245])
        by smtp.gmail.com with ESMTPSA id d30-20020a0565123d1e00b004cc9f7030f3sm835065lfv.292.2023.02.06.12.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 12:04:56 -0800 (PST)
Subject: Re: [PATCH] usb: storage: sddr55: avoid integer overflow
To:     Alan Stern <stern@rowland.harvard.edu>,
        Karina Yankevich <k.yankevich@omp.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230203201821.483477-1-k.yankevich@omp.ru>
 <Y91zL8OWTUd8iTXt@rowland.harvard.edu>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <53bc0584-51eb-8bb7-de48-ca07fccafc19@gmail.com>
Date:   Mon, 6 Feb 2023 23:04:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Y91zL8OWTUd8iTXt@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 2/3/23 11:48 PM, Alan Stern wrote:
[...]
>> We're possibly losing information by shifting an int.
>> Fix it by adding the necessary cast.
> 
> Nonsense.  The card's _total_ capacity is no larger than 128 MB, so a 
> page address can't possibly overflow an int.

   Then the 'address' variables shouldn't be declared *unsigned long*, right?
That should fix the SVACE's report as well. Would you accept such a patch?

> Alan Stern

[...]

MBR, Sergey
