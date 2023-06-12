Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8193772D497
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjFLWmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjFLWmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:42:12 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A67FB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:42:09 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33bcc8f0d21so3117105ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686609729; x=1689201729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7YHPra9JUFwBLRAu6FagKmsw70SS+E9C1XBRBKRg5s=;
        b=ZUqqtdVYFiVDpHmcGqjiRcBr8CRxP0yNdKI+rwCkpts/Ne+uj04VCEb+FtYP3CTUYu
         QFD7IYLRjFuEaLd/2p7euIuxlRQuuCRnZo6WEDAecFUYQjNxSQkU44bJWUUHSSZEZ3h9
         K92Cv+uQz8Z91qJMd2hkvcjQRXkV3sKuy1fGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686609729; x=1689201729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7YHPra9JUFwBLRAu6FagKmsw70SS+E9C1XBRBKRg5s=;
        b=KcFmwQ+UhfTIL+rNFEqKYDuEC9bMwuFPiPZg/I6NDVcrbcIsMzp1QKHszkaGe7QKZl
         51o5+tN8q2CRIkFe0uuWUqws+8nR9DqnPePUyLNVx3dZXFeSR4Yb2d/eUU2kWfhKgZSo
         ydUp/zKby3aCy6zPDolhyO5UBqbgC3kDhF8MDQ4K+npLh9ZLhLAlDW5wvZuFpdlwDni6
         ZXOHxc6LWUz0WxEQTy0uQT4gnxTKr5APh3bczTwJloQJVS4KsaQIwYGrm1vhP3jP3UKy
         nk5hJnqMdhzN5L+rAkTihZBt6W9Q6zgzQtNTzsrQRhfUQ+iz2XTMJ0MFilIe0zWWwuKf
         fTEA==
X-Gm-Message-State: AC+VfDyueSC0knvOVpAMBOho40ZuP/7yy65Rv6tfaUOtvX20QZAnVtdj
        sF/BhvJhjAYXf44rrUahx7xYAQ==
X-Google-Smtp-Source: ACHHUZ4V8W3LPivr0RC5GMwG6+UDc2130wZaPnjzEmav46f5Z72XKLk6HVj3+kdmfVYC7Ur3rKgIMg==
X-Received: by 2002:a05:6602:1789:b0:777:b456:abbe with SMTP id y9-20020a056602178900b00777b456abbemr5545396iox.0.1686609728883;
        Mon, 12 Jun 2023 15:42:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i12-20020a02ca0c000000b0041869299cb8sm3148692jak.15.2023.06.12.15.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 15:42:08 -0700 (PDT)
Message-ID: <9748dac0-efda-0208-26fc-1de948534689@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 16:42:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] selftests/ftace: Fix KTAP output ordering
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230609-ftrace-ktap-order-v1-1-0abf4d0d6922@kernel.org>
 <20230612143316.1851a0fd7a49971f1b2209bf@kernel.org>
 <20230612101036.2c20c86d@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230612101036.2c20c86d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 08:10, Steven Rostedt wrote:
> 
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Shuah, could you pick this?
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Applied to linux-kselftest next for Linux 6.5-rc1.

thanks,
-- Shuah
