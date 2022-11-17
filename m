Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3562E811
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiKQWRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiKQWRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:17:20 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CA7781A1;
        Thu, 17 Nov 2022 14:17:19 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 62so3310323pgb.13;
        Thu, 17 Nov 2022 14:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+T+yCR4pz9N337uQvPoNcZUchUUEmXxrQWO0IVxYKg=;
        b=R9ZqaUP8/hhLT39Iz2NOnc33IPF9Q4S6BV6vSvAuRU+g8Xy2gwa6HT31gjljbcvhaD
         TI9Md1XwB0SP5UPYkILAWLhUW4IQLVOGJutnO6f8cR4SYe3g+ltlJr0i6cVKfH32AIPI
         aP+3ADV2PjMpI7sAHeuzQ8yIjbgYqekSUp4eSQWM9v1KwDm//pH30RdLszAi2B+DTJ0y
         LVBrG4rqKc3JT7xjmyh5HYlZezVI5xSBDSOzm5LpI6Tb9TFa/9J5L4nU1qGjT94odwmd
         RC65vYt5VtIXZKsQi3e645V3aOAOos3p8uS6xg1VWpcJChP99Xv64caLunsxXRX7S3lq
         QfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+T+yCR4pz9N337uQvPoNcZUchUUEmXxrQWO0IVxYKg=;
        b=TpJ6Ikc4B0fSSsydhRTClEeC58LRftfsbaVAMIDIhJzcE1SlKL7bMaiG8zXfb6nawv
         EeQRiFL81tIJYCD9PKBUm5APHSB1cCHMcNfuaIm+L2QNE1j5fKKsdsD844EZBZIxZ83l
         HXzMkwxAiAYG34aDAcxinJ1SLzOYl5lUqsms/bOsss6UXUdzg2Bfw7rn8XkgN5NHIXcV
         eGqV+oNBfkZZXxkznA5/l4bjmrUhNDLgs+daA2qUp8oxPdb0fa3W1X5KCwrPd/K8riu5
         fi4xI2m/iqdACTVxAMo0wHW3yE/n6wDGKyYwDv6zu/wfA214fHvfQfc5UMJl43QRmuSj
         MGyA==
X-Gm-Message-State: ANoB5plzkHEGPz0qiyLFRY8vo6WTEWucvt0lbvaie7EKjL16wuaCjmgM
        rFE/aGll2ScpOz0nAqBWP7E=
X-Google-Smtp-Source: AA0mqf7jJSeAEhyF4cchyzNzr7k6ot4JKA3SYOjtu77Jff+AJii+HO9h/Wf/dbqY4kjM9HgXwVhkOA==
X-Received: by 2002:a62:36c7:0:b0:563:8011:e9e4 with SMTP id d190-20020a6236c7000000b005638011e9e4mr4837948pfa.76.1668723439358;
        Thu, 17 Nov 2022 14:17:19 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e4c5:c31d:4c68:97a0])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b001837b19ebb8sm1854089plk.244.2022.11.17.14.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:17:18 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:17:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alistair Francis <alistair@alistair23.me>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: cyttsp5 - add vddio regulator
Message-ID: <Y3ay6zgq7JiWDR/Z@google.com>
References: <20221117190507.87535-1-linmengbo0689@protonmail.com>
 <20221117190507.87535-3-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117190507.87535-3-linmengbo0689@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:05:41PM +0000, Lin, Meng-Bo wrote:
> The Samsung touchscreen controllers are often used with external pull-up
> for the interrupt line and the I2C lines, so we might need to enable
> a regulator to bring the lines into usable state. Otherwise, this might
> cause spurious interrupts and reading from I2C will fail.
> 
> Implement support for a "vddio-supply" that is enabled by the cyttsp5
> driver so that the regulator gets enabled when needed.

This needs binding update.

Thanks.

-- 
Dmitry
