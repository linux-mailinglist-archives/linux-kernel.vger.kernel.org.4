Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EEA689826
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjBCLzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBCLzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:55:31 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB06172F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:55:29 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lu11so14703609ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 03:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vuRNtaf4lF0Dji+GN/Ms+B6a5GJlCy52N3jxnAqPqXY=;
        b=SiQ4zLhMbTlR71APuahIZVPq9bL1gZhzOMQGIkCpLwvVlcyxojNa3KH0N2JFEhu7X1
         rQcbe+5Ep7e98qpsM55riw+QRzCB96W1bYZrticiJlDcVFRLC/8ES7DSoc6I2HDoKZNq
         GwGSKYfW6V55xXQ4tz6FerK+OUpAtlmAxucYsjjl9fe0w1ENSbc1kP3WiyUjcTI28dDW
         WDci738FYJ4KaD2XJARh+DnqIHg8WF0l/X0iBrTr2pE4zdRRvBsnjamqbMhQzLLtTmUd
         sYlPHeSaR50mzXiNjyO7hckT3oN7CcbMscUDhXfxuv+VwraJEru7MboAY+gihOR8ojxK
         aphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuRNtaf4lF0Dji+GN/Ms+B6a5GJlCy52N3jxnAqPqXY=;
        b=0Jm/qkUXquKsCi2UAXplSMRW6R75ZtNPsh4/Mtf9iakF8uqWXHFY6UgXt6aUwp+AIG
         q9Ej4daanI0wHpqQwsgBxjWXxhCzZngMnPyh60pqVdU6dHculh/p5M6b48EK3FgmIW0C
         kYVKqaw3BqB1qRsPYtMqH0sgbUud746Z5WqBoJwuLS0ZrDeQtmzeaoewGVVZt1DGaFCa
         wHtq63T4nzhdJI/iIKElw8ioIsuhnGW3CC9qBHb2F6FDR1IOHMlKItvgkS914paWQdbg
         1tuDyupITnt/pCPzaA1mTey8KpZcbYIRjqQ1X9b700uoQPcDM84TGyqOHSAbNhdDYN2E
         22XQ==
X-Gm-Message-State: AO0yUKX46+jkxv4oCMDjw2ne/yVCYJ4teaBGrVqa9ObLfNPV2a7fxIL/
        mqShU1LTeQCg9pST3sYwUEV8EA==
X-Google-Smtp-Source: AK7set9YJkwsjiZHmM0GEaZdUIOmX/TKqx6cfDV13309k1cv8/q6a/Wf5+xodqMtqHad8qz6wcX8HA==
X-Received: by 2002:a17:906:c0d2:b0:86d:67b0:6292 with SMTP id bn18-20020a170906c0d200b0086d67b06292mr10217769ejb.73.1675425327990;
        Fri, 03 Feb 2023 03:55:27 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id qx18-20020a170906fcd200b0087b3d555d2esm1280778ejb.33.2023.02.03.03.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 03:55:27 -0800 (PST)
Date:   Fri, 3 Feb 2023 12:55:26 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     =?utf-8?B?6Zm2IOe8mA==?= <taoyuan_eddy@hotmail.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "dev@openvswitch.org" <dev@openvswitch.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= net-next v5 1/1]
 net:openvswitch:reduce cpu_used_mask memory
Message-ID: <Y9z2Lk+VvAHgu/4r@nanopsycho>
References: <OS3P286MB22955AB6FF67B67778343FEDF5D79@OS3P286MB2295.JPNP286.PROD.OUTLOOK.COM>
 <Y9zNMqVIlW0l3kpF@nanopsycho>
 <OS3P286MB2295466ADE3312A2B9C02C51F5D79@OS3P286MB2295.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3P286MB2295466ADE3312A2B9C02C51F5D79@OS3P286MB2295.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fri, Feb 03, 2023 at 10:03:28AM CET, taoyuan_eddy@hotmail.com wrote:
>sorry, Jiri, my bad, will hold on before the next submission/hope it is the final one

Don't top-post please. So what is the change comparing to v4?


>
>eddy
>________________________________
>发件人: Jiri Pirko <jiri@resnulli.us>
>发送时间: 2023年2月3日 9:00
>收件人: Eddy Tao <taoyuan_eddy@hotmail.com>
>抄送: netdev@vger.kernel.org <netdev@vger.kernel.org>; Pravin B Shelar <pshelar@ovn.org>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; dev@openvswitch.org <dev@openvswitch.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
>主题: Re: [PATCH net-next v5 1/1] net:openvswitch:reduce cpu_used_mask memory
>
>Fri, Feb 03, 2023 at 09:52:56AM CET, taoyuan_eddy@hotmail.com wrote:
>>Use actual CPU number instead of hardcoded value to decide the size
>>of 'cpu_used_mask' in 'struct sw_flow'. Below is the reason.
>>
>>'struct cpumask cpu_used_mask' is embedded in struct sw_flow.
>>Its size is hardcoded to CONFIG_NR_CPUS bits, which can be
>>8192 by default, it costs memory and slows down ovs_flow_alloc
>>
>>To address this, redefine cpu_used_mask to pointer
>>append cpumask_size() bytes after 'stat' to hold cpumask
>>
>>cpumask APIs like cpumask_next and cpumask_set_cpu never access
>>bits beyond cpu count, cpumask_size() bytes of memory is enough
>>
>>Signed-off-by: Eddy Tao <taoyuan_eddy@hotmail.com>
>
>Eddy, could you please slow down a bit? Why did you send v5 right
>after v4? Could you please always put a changelog to the patch
>submitted to contain info about changes in between the
>submitted version?
>
>Thanks!
>
