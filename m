Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66806F2516
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 16:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjD2On7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 10:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjD2On6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 10:43:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7E171B;
        Sat, 29 Apr 2023 07:43:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63f273b219eso745339b3a.1;
        Sat, 29 Apr 2023 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682779437; x=1685371437;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtQcCcsd0WyUvLflKw9nAPm3HmROy9BRA3Rhv/4CEZU=;
        b=fB/c0FDn/u9p1WjTt7scrYROtvG2nXs8R7cMmvi2vYf7hLzUwL/ULek1FwjW9BgUt2
         oS0pIfqylC5z36C0i6dKOGKSL6vNRed6wjNFdZkhy+VU+pP7GvPSw4EgyWyjdejk3P/G
         i5WLhobw96JgJRM8jwOM/w1GtwBI8H7nUTqkrH6+5YLv1EffaqlOdBZ8qV6g3cpHWbX/
         OGAK/bL24G9EJGrZ7x6buhTEqAK8mCFZWpnC/H5865zx6WeyT57kwp/4FAtzAhUrdnVo
         hctnuiCenPpgJQ9S8Vk5wXpiopHi4ZwyEFrOGggRqQfhzxCjAlcfEKfmzTM9wTrqATi4
         LjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682779437; x=1685371437;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtQcCcsd0WyUvLflKw9nAPm3HmROy9BRA3Rhv/4CEZU=;
        b=HFvuBJPppx5yuuHgT7dPdmPTZud6mqOOq4pCNnHyegpbymcSMcBh8FoTLRGH79zBAh
         z2Qx1BnhL3NuZYuv9uM0mj8QylES5GOl/EJ3CZZcKUCYa10EkPn2DJuMJ3EepoIuJdbO
         igknKH/hGFji3iraS0uhFrhw7T3PWHeRsg9cx2RSaC1fzZTX2HJMNHPVs45kC6j/o6lv
         /g5omQHiibkIzP83f0H44vBA9xtTbi5pFINkcF3o5VGK0w+CYUVxr1X8Ddncefzjxzpr
         rDJ1ZiCxPNIaHiJn6hU5F0Yc1ybTwUmPGY8U2JSu/ZeFKkKDbJhKIdrH33ZCZzG88VZf
         QcyA==
X-Gm-Message-State: AC+VfDzrxsNyDjOKFSnKyaJSwnisNQ8FWDqDJ+nXiaQJjsFEbEjc5EUU
        qT56f7T/liq3xTuoY/ZDaQc=
X-Google-Smtp-Source: ACHHUZ4jIA4nFe897/85zv3aWVj3OztxrHpkulRfJjN8MhTLF64jvowf0zxhcnJI2LEQY0/FpjlOoA==
X-Received: by 2002:a05:6a21:6da1:b0:f2:6984:b8d with SMTP id wl33-20020a056a216da100b000f269840b8dmr10685994pzb.29.1682779436659;
        Sat, 29 Apr 2023 07:43:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i134-20020a62878c000000b006328ee1e56csm16976793pfe.2.2023.04.29.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 07:43:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 29 Apr 2023 07:43:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (oxp-sensors) Use less convoluted enum cast
Message-ID: <18804132-56f2-436e-ba1c-298653324d37@roeck-us.net>
References: <20230429142547.328125-1-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230429142547.328125-1-samsagax@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 11:25:48AM -0300, Joaquín Ignacio Aramendía wrote:
> Change
> 
>   .driver_data = (void *) &(enum type) {enum_literal};
> 
> to more readable form:
> 
>   .driver_data = (void *) enum_literal;
> 
> and corresponding cast usage as board type flag.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
