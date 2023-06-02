Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3F71FAE7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjFBHXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjFBHWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:22:51 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934571BF;
        Fri,  2 Jun 2023 00:22:43 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-96fe88cd2fcso238388466b.1;
        Fri, 02 Jun 2023 00:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685690562; x=1688282562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvroderYS9TgB2JM1PlwHS0YOttaKTEpx7FpQU4spVI=;
        b=JY2/i6xFkSKKjvWppwLHx6q4J2uHcshTjcw/lTO0X5vsvo0IM1qeFu7I8oqP/U0Fue
         UgVIrxV9E9z1x0vXdZVqIolDmXS+zPd3RnYVXDs3QnomkIua6/76fqSaZQOSxIL7hdau
         j8eUXwfiIJg1YcTz/5ZzSgeSg5F/iEu4URPAeOhLY5NIt6wuPifWQA8i4YJF+dxJUmnj
         5OJet6VpHPqc5p2nnhB9sygQDXXQfzxiWjd7JbbVlhdKEZ2ZqiMI/NPdOO/aKlZ4X4n6
         hooLqBJbQCnemWdLaxSr3TX4gC4J32V3nClYRXeHl35d1mJfPCKhahiKPeIGaJYjGPZx
         O1tQ==
X-Gm-Message-State: AC+VfDzXzmqAg88Fmm1/LpLajhXOw97QDJ8q+mZ0MC1Brgv536QOb5ZM
        HCkDCtpamAOuPfhuIYjCoUFaHji/f2Y=
X-Google-Smtp-Source: ACHHUZ4xp7HLi8GSIxvvkDX8Q2N4j2oKbd61KMy4vtNxsXlAbAOwHmSHe37NYzsznoM8RZH0eFr6Vg==
X-Received: by 2002:a17:907:2d20:b0:96a:57fe:3bfb with SMTP id gs32-20020a1709072d2000b0096a57fe3bfbmr9664487ejc.26.1685690561764;
        Fri, 02 Jun 2023 00:22:41 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id qh8-20020a170906eca800b009600ce4fb53sm411639ejb.37.2023.06.02.00.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 00:22:41 -0700 (PDT)
Message-ID: <9fad0236-eb21-aade-16e5-23d71da557c3@kernel.org>
Date:   Fri, 2 Jun 2023 09:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/1] serial: core: Fix error handling for
 serial_core_ctrl_device_add()
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230602070007.59268-1-tony@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230602070007.59268-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 06. 23, 9:00, Tony Lindgren wrote:
> Checking for NULL is incorrect as serial_base_ctrl_add() uses ERR_PTR().
> 
> Let's also pass any returned error along, there's no reason to translate
> all errors to -ENODEV.
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

