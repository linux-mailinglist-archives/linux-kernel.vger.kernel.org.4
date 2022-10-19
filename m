Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3466043EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJSLxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiJSLxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:53:14 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102B185424;
        Wed, 19 Oct 2022 04:31:48 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id bv10so28542009wrb.4;
        Wed, 19 Oct 2022 04:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+C4/MEmPs6jjzJFhCgwSQZ9Bhv6OsstKQBIugIvO+Hw=;
        b=Q7MsmlMZULcAQQpRWR2KUHzwGMbOEt6ookbLhEsT5VxqIj8gGI/XnlFOv+mgHXnt1x
         7nwUuJJEO3IIONd7Ii0Zk4Eot7HXBz1cxhl1gZVUEopzuHpEVqniBJa6P5KyLh1/xCqi
         sTvthIYyU9i9RbszdKfHVwVqC1q2reVoZz6aLRdDcdWmSbqUFL+ILbxxYyhY+Nx0LM8R
         kAvqCtKwJpjOPEaU5Cre7a6buvIoCtiYH1MV/QhpRcnvC6dDrAuGbS8L4OK0aw28Ch96
         aK9usAelUVzakRO/a/qCVh0ys4m1iOnUVjdmgq5rIZ7MPw3yGLQB/81Wnsr91GqTgqW6
         mZhA==
X-Gm-Message-State: ACrzQf0+UXOAOYmS1RDI9nCzauEI5/DqAjr0TszUaCdrhuCYhZiGCj11
        TBTwGvYa6WCzsXH8TU0mLmg1Dv4nyS2QDg==
X-Google-Smtp-Source: AMsMyM5eOm/kk0xoS7rbKDQ7Op+l6IBKQUmMJaS9A02c4eqJwLEKEdJy4cerww606ujYl19fXuBwBA==
X-Received: by 2002:a05:6402:350d:b0:45c:f5a2:348e with SMTP id b13-20020a056402350d00b0045cf5a2348emr6802451edd.398.1666176917245;
        Wed, 19 Oct 2022 03:55:17 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id x9-20020a170906710900b0073a20469f31sm8795985ejj.41.2022.10.19.03.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 03:55:16 -0700 (PDT)
Message-ID: <c7e5c112-e53f-b3ab-6b85-f47fadef7ce9@kernel.org>
Date:   Wed, 19 Oct 2022 12:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 00/44] serial: Convert drivers to use uart_xmit_advance()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 10. 22, 11:11, Ilpo Järvinen wrote:
> I've tried to pick the drivers such that these shouldn't collide with
> the ones Jiri's tx loop rewrite series is touching (unless he has
> something hidden beyond what has been on the list).

No, nothing more here.

thanks,
-- 
js

