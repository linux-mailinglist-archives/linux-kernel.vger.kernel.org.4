Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273B561F7DA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiKGPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiKGPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:40:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2FF1F63A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667835559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbangJEJrbXgXqHJdhlq4R8fIkEkN66BXotud0VPUA8=;
        b=R+QnVcv8eJZWwGNYS6aXJw+YuJ/YtRzGVGiciMAOtSEgp7BEdHMZIa9CY+WcjI8jFIAm8v
        R56WpzenTMw1lGqgYV6bBOf71XT2rtOgexE7JCpRx2pqcI4bGvEUTt+edGcObDohDXNBW0
        8lwkPlciR6EeWEjbMvqxdcaWgi+SKjo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-400-82Si1m9UONSIEBblIzSw5g-1; Mon, 07 Nov 2022 10:39:18 -0500
X-MC-Unique: 82Si1m9UONSIEBblIzSw5g-1
Received: by mail-ed1-f72.google.com with SMTP id m7-20020a056402430700b0045daff6ee5dso8560928edc.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 07:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbangJEJrbXgXqHJdhlq4R8fIkEkN66BXotud0VPUA8=;
        b=dgaGMfr3RFJZA6CCLOwYAu6v/GATYzJ1G8V2wSAslJSLVlQF0CiFQApqJoXBVJveLl
         ZvQ2CA2zc81PhuTTq7jUcerZPP6tibE/XbDw/b7UmcG9eQ9k/U6fvwYXk8Na1SWNRqrD
         CaxES0HFQ+wQlFvwi0WrUmAiudBcYQMKah+iHCbpfrHcs73dnt5FQv4FB7TkUGNOl9/X
         CftOuXb+WGVVct/NSJcpijG5yw9MLcfHxWvcASQbOR+IYvPs8IqfvTz+Gjx+Wtx62YTy
         rorQlWtYn/pnPaVjGSYJaKHJ7VA0KRPxqhj5MXRf0a80pAsDsWrfQgTLTc3F5WooEis1
         KXgQ==
X-Gm-Message-State: ACrzQf1PbnAnVVfv5BatY+t18xe1VMeys7hTEOluipFD4EWh3y95/Qtm
        aydKlh7LcesDXXmfw72mi6AW+WqMyImTHHhd/OgH0vB9fGBtneZTdOjCraZ0c2diHRMZ5RCSSP7
        TahCi/2C93L3Sr13Jm06lJzNl
X-Received: by 2002:a17:906:8a47:b0:7a3:86dd:d33b with SMTP id gx7-20020a1709068a4700b007a386ddd33bmr49288289ejc.67.1667835556902;
        Mon, 07 Nov 2022 07:39:16 -0800 (PST)
X-Google-Smtp-Source: AMsMyM42A3zHo2QHCCnHvmWMgIPyOHhFQwigkSk3YswDJwOV6fLcIgR0QfuMfeivQAYv33WAjFrKqg==
X-Received: by 2002:a17:906:8a47:b0:7a3:86dd:d33b with SMTP id gx7-20020a1709068a4700b007a386ddd33bmr49288269ejc.67.1667835556655;
        Mon, 07 Nov 2022 07:39:16 -0800 (PST)
Received: from [192.168.0.46] (host-87-10-24-76.retail.telecomitalia.it. [87.10.24.76])
        by smtp.gmail.com with ESMTPSA id ca12-20020a170906a3cc00b0079800b81709sm3570235ejb.219.2022.11.07.07.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 07:39:15 -0800 (PST)
Message-ID: <624afa7a-3b9a-29a3-ab33-1b0efee83c19@redhat.com>
Date:   Mon, 7 Nov 2022 16:39:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH V2] rtla: Fix exit status when returning from calls to
 usage()
To:     John Kacur <jkacur@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Chang Yin <cyin@redhat.com>
References: <20221107144313.22470-1-jkacur@redhat.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20221107144313.22470-1-jkacur@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 15:43, John Kacur wrote:
> rtla_usage(), osnoise_usage() and timerlat_usage() all exit with an
> error status.
> 
> However when these are called from help, they should exit with a
> non-error status.
> 
> Fix this by passing the exit status to the functions.
> 
> Note, although we remove the subsequent call to exit after calling
> usage, we leave it in at the end of a function to suppress the compiler
> warning "control reaches end of a non-void function".
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel

