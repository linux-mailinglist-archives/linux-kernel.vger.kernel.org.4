Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6BF6E4C64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjDQPIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:08:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDACA240
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:08:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id gw13so13965803wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1681744093; x=1684336093;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55fxefDFHrQp+MYrTaJxCxKVkM9zeGMdMFPZ2LVQ3ho=;
        b=kQbQz2zx/FHe4EPRYHEFqLGqmtVFPdoD5cx6J9toAmDcNDx50N0mO7ZdPuYhbnGWoC
         wOafXsXQaeVr4RC/h9wzHEFFM1ZtlHa5XNOberhMHDu0cun7174GabEgA2jKHNN5w9XN
         LRlaHVVh0nqtlWadVhwJ6ZBkh4YILSO0Lxm8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681744093; x=1684336093;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55fxefDFHrQp+MYrTaJxCxKVkM9zeGMdMFPZ2LVQ3ho=;
        b=Wec7xNT3CzwnV2OpFnYHuuvOgvVtPQ/K4W/cfRKA6kygx4/S4WsHWKecW/3x1YXW10
         Adl1ZEz/QBBzCfODRW57gOMNrBAmA+lklmANZtPsenWo6oaDV+Grf85EkOajaeX7nXG1
         ulATHbeXQtoy0qMGD3WYXj7ESRWuY1u77uXiiACLNk0S78AfB4UHStalzBYiu+cJLbmt
         nIXgoQZE/cEveSIwQ8DugCqDfU0O2WVb6ix0HMaM63FDFhkfDb/HYW4t8STd++vncYi4
         RFssbk9e2YEfLmNP43dJpxXzWcaCDaVA9Qhjr9fC0pWvRe9Pu6nAne6OaP05znrXF9Qy
         trYg==
X-Gm-Message-State: AAQBX9fnUrCt46FDjGPBWjSl/nwQpuCMlf6IQ/+5eg7JdjjvsC0jYQpA
        xBbryDCsxee5AK77qvEuyvTfbw==
X-Google-Smtp-Source: AKy350aeDlmz5qtYqFcxbEZoBmBIRj9JcvLreThMosdJsBo6eDIkLz026MM0nDaVQwBavm+MN147Og==
X-Received: by 2002:a1c:7408:0:b0:3f0:b1c9:25d4 with SMTP id p8-20020a1c7408000000b003f0b1c925d4mr8356374wmc.21.1681744092992;
        Mon, 17 Apr 2023 08:08:12 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c160900b003f0b1c4f229sm9132546wmn.28.2023.04.17.08.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:08:12 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:08:11 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] printk: console: Create console= parser that
 supports named options
Message-ID: <ZD1g2zidSD80OyJO@chrisdown.name>
References: <cover.1658339046.git.chris@chrisdown.name>
 <732ee897b2bd49ada3f7dee396475c5a2195071b.1658339046.git.chris@chrisdown.name>
 <Yw80MmyBl4js09If@alley>
 <ZD1f-1JjpihR1djd@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZD1f-1JjpihR1djd@chrisdown.name>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>Any thoughts on something simple like this that takes advantage of 
>memmove()? This should overcome the mmio/io concerns, and it's fairly 
>simple.

(although coming to think of it, this can just use memcpy(), but the same idea 
applies)
