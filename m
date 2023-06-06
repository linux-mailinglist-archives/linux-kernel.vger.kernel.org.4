Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01265724597
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbjFFOSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjFFOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:18:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A430E18B;
        Tue,  6 Jun 2023 07:18:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b02d0942caso28854185ad.1;
        Tue, 06 Jun 2023 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686061113; x=1688653113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JU5bs373RCUOgXJLUDTSML0K5+ZCRMog9EmfC27Cho=;
        b=TgULhQk1Qffs+vjFYJckFp6sI812uCDLS3xBoVRd+823Rwwpi8mxXSngSIqM1/Rrts
         Rcdqu+pv8MeCxsLVZsDm5mQJ6aYN24vL2LMNIGRTo7Sds1IZxnNNOaErqHSImCJslcMx
         zlBdkPLZfIlyc0Hrjal3QWcM5AtB4MAUZ7XndMvLWhKUFReX0qzqTdn0KZAPl/ZsryvT
         foJQ6LejTAOIqtwmy7r8hdpCZGslzDWaGJkwyIIS9i+fSb0mhZhi6j2icU+CwpcQ1vKh
         XHm+89z3ooeHKCFPhuenknZAiUoc4CyUUqLzk8kgiS0t/cFfCicDnIkkqroC0pPa5Me+
         sGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061113; x=1688653113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JU5bs373RCUOgXJLUDTSML0K5+ZCRMog9EmfC27Cho=;
        b=jNQYFtN93+qlQ0GCSTCOlE21QXeEjfpq7+QhQ2NrjbDzW1uxmdy//p+oTOcSmCE3+O
         xNTv9XYVuzNmSbf4ueTESAs3FyYJL5e/wfCTQr4MVnzIJFGcdU/cS5f0p+tRbGujVgRx
         33alg4r6dD8jxuVcVAItKnF3rjaL4tD9o1IENU7kRm4XATls8AEZ8YQ9o9CCF7LigwmJ
         f1/byLnTpsv+TwzOrD1vB2PSTpevSQJ6GUXH41IU5/09PRoCps4l8IYSxCqi8y7yzrIJ
         LxEgr8ghVTKZrPwuweJcL9d7tQCtyiJc18S6J17xHXv2NGOqtq1nsh8j4q2n3j1Xllim
         6olw==
X-Gm-Message-State: AC+VfDwO6u2hKohD/W9sTzx3NY74JxZ7k6I9clvqqg6jlctYvigV+h8L
        LHD6KfmioZ/uNVEHLo+aG68=
X-Google-Smtp-Source: ACHHUZ5UKJgO5MIyr1LCARXSsR3GdPMcC2rCTCQhTsMaHYFgMYIhNslpRd7axkM5nWnCaY7+s7D04g==
X-Received: by 2002:a17:902:c412:b0:1b0:34c6:3be2 with SMTP id k18-20020a170902c41200b001b034c63be2mr1421801plk.1.1686061113033;
        Tue, 06 Jun 2023 07:18:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902b10100b001a6a6169d45sm8596280plr.168.2023.06.06.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:18:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Jun 2023 07:18:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jdelvare@suse.com, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Message-ID: <22d5f12e-578b-4484-a90e-6e81289ed458@roeck-us.net>
References: <20230606014234.29491-1-nick.hawkins@hpe.com>
 <20230606014234.29491-5-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606014234.29491-5-nick.hawkins@hpe.com>
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

On Mon, Jun 05, 2023 at 08:42:33PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The fan driver now is independent of the fan plreg GPIO information.
> Therefore there will no longer be presence or fail information available
> from the driver. Part of the changes includes removing a system power check
> as the GPIO driver needs it to report power state to host.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Let me know if you want me to apply this patch now or if I should wait
for the gpio patches to be accepted.

Guenter
