Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A055A6F88EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjEESsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjEESsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:48:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB1C18859;
        Fri,  5 May 2023 11:48:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643990c5319so1354628b3a.2;
        Fri, 05 May 2023 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683312494; x=1685904494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/ZSD3qVmnjgI8CLCJbb/H/o7q7YENLY/p8MYrwTe60=;
        b=iW5l1IzDT/jT2aAVpLQa9T5II3XZ+LCgczoeIrc1acjv7D6v6zR9N/IG5EoGxOqb6v
         KFTkyRMqaj4gyFm/tCxRIyD7KimB7SCvVOWM6QzRJwOVDbnPXaSLJW0/zMa9W3CLmhOl
         sAmcsSHV0yggBW6LDrfV6perkgDHMhJZpzWRVgf1jlugQMjm1WY72VZMA62fgisITO+/
         2gY5YgK4HYxYLDN95i/tgtWuMUu1L45IdYQaIOAnPAGncLxtlFbqCNW/cjNmscIyfb08
         +iPSZGKAVLxFRJi/XUsROkfZWhttoDDSh2ZCYdJlDIli5kVgi5i8JhxquYqthDECTTa/
         jgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312494; x=1685904494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/ZSD3qVmnjgI8CLCJbb/H/o7q7YENLY/p8MYrwTe60=;
        b=jJYuj0XyvAy4CWZ/wfR9FKN6dtPz2PpHXzz88i7E181MUkT6dKWW5cbW6dGLkgP5M8
         muxTdW+8LBUq7YZN+4zhgF/6N5JGY+udvQr8+yMxFOG7JDy7Yh5QN263mfG2sOnfg8XS
         dmbEVPe9u3zbM9g8tftok2a8HAgq5HEbsE115RCThuraWNOaClI2qFU6ZmWUAlAjUubB
         TUSpwxiernRK9d28pR8w44A5BPXykMGXuFpt7QksO6IsyKsH8P+X1QJ0NaKRvZzDfYuq
         sqi5PJysJc2hea/pzFR84DhKx0XN+n2RmL+EmB02F0P1ecd4p35Gdm1azD3lrk9Muueq
         xSPw==
X-Gm-Message-State: AC+VfDzD0UsGkJ87V/ta+sADKEeTZZYPGTTzGAZ79tvYe8aNyQSBSRNs
        qj4hlJoO9XeWVAnDUGjW4ZQ=
X-Google-Smtp-Source: ACHHUZ6Npq2QjU7NSXbb3o4MAO4ao/WWYrGM8gk6BfTW9PlI0WYnptP02fu4fjSJk6A6JDBAicCkPg==
X-Received: by 2002:a05:6a20:244d:b0:f5:9f72:1aaa with SMTP id t13-20020a056a20244d00b000f59f721aaamr3189440pzc.19.1683312493725;
        Fri, 05 May 2023 11:48:13 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5658:95c:e1cf:a1b0])
        by smtp.gmail.com with ESMTPSA id j9-20020aa79289000000b0063a5837d9e8sm1939941pfa.156.2023.05.05.11.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 11:48:13 -0700 (PDT)
Date:   Fri, 5 May 2023 11:48:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Maximilian Weigand <mweigand2017@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v3 1/1] Input: cyttsp5 - implement proper sleep and
 wakeup procedures
Message-ID: <ZFVPaqSy6Vu7LPVB@google.com>
References: <20230504120316.408687-1-mweigand2017@gmail.com>
 <20230504120316.408687-2-mweigand2017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504120316.408687-2-mweigand2017@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maximilian,

On Thu, May 04, 2023 at 02:03:16PM +0200, Maximilian Weigand wrote:
> +static int cyttsp5_enter_sleep(struct cyttsp5 *ts)
...
> +static int cyttsp5_wakeup(struct cyttsp5 *ts)

These 2 look like twins, I collapsed them into cyttsp5_power_control()
and applied the patch, thank you.

-- 
Dmitry
