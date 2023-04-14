Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9C6E1CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNGga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDNGg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:36:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CFF198A;
        Thu, 13 Apr 2023 23:36:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w11so18031635pjh.5;
        Thu, 13 Apr 2023 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681454187; x=1684046187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNTNY+fYIuYgMKhPkuwFtekY/OSbATyn0LHE7jhQLpY=;
        b=pL8hDaTgqJpwUz4GQCEwn9ivr8hlVD67UB1PN9SQW/+QiEASVWD9HYw/QeDVpt0a5G
         kliw2hAD2lkodhWtQOzb1p9Kbc9Z06UBD76F0AfKfAFQnWfktTGUl6Tg6B7vjWDpb7cF
         tYVtUNxomfiiBBZt1Mezk6BrMMwO7814gDgHZbkh/j0IponczvrD2iR7ZA/Sb0juOwWa
         cgMnGEu98E7Scoym+2e75kotm7C/XBRso1sim4c4yJEZAQw+tpzr9t+1B99d2WM3pdWF
         sjiD6eyR3BjasyLb2pNVJf88VmAfhPzofDuw15n2yxd57Ti/lVRzO7uNfNxzgggkEXRK
         UkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681454187; x=1684046187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNTNY+fYIuYgMKhPkuwFtekY/OSbATyn0LHE7jhQLpY=;
        b=bWJKbCMu1E+lcz0UwrIrZ35NbcNcW7e8NCvr7x6SHJ1mOkvrXrxeDFwcykWw5b79Py
         FBfuVwu/SVf97iNYjjCFA+TSm8ltCaMRdCMKtn+PFPj5NXso5Febgxj0k3rLHm85hQil
         pym+Y+al/8FRUjFXV4mR1TFHZoNw8terhVy3OeiR8YQQ6vOaWXf+i5jRtoFOoZiV86Y/
         eJv6JKTS8L9paHvzl9al454f4XYZTGcXJUKWPcp/b0uQv60/1nMRNokPqLNyKjoW3ZhL
         gnhFFaMSrpH7iV5VPe9xUvrMNVINDGW7J0abmOAL4vC1tiYz40xXTpRed9zm/OG2eDMl
         woSQ==
X-Gm-Message-State: AAQBX9eoaUOuqVREjCwiY2g2KwSOB4PBlOT0GZXb00VfvfVmGd7xx5qk
        T9N4yn2OZtB0T+pHoV2Fwwc=
X-Google-Smtp-Source: AKy350ZZkLbS3/CrJ8WVyiQmUj1XJWPAbcMUQaN1pJnPrTtMxdbXILcyu2IMwSXRfIBvkr1pbMFNHg==
X-Received: by 2002:a17:90a:db14:b0:247:1104:c280 with SMTP id g20-20020a17090adb1400b002471104c280mr4521333pjv.31.1681454186706;
        Thu, 13 Apr 2023 23:36:26 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5142:7eb2:ace5:60c1])
        by smtp.gmail.com with ESMTPSA id o22-20020a17090ab89600b002467717fa60sm2263864pjr.16.2023.04.13.23.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 23:36:26 -0700 (PDT)
Date:   Thu, 13 Apr 2023 23:36:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3] dt-bindings: input: pwm-beeper: convert to dt schema
Message-ID: <ZDj0Zz49/sCXvP2k@google.com>
References: <20230407075259.1593739-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407075259.1593739-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 03:52:59PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding doc to dt schema, and also fixed the
> example from fixed-regulator to regulator-fixed.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thank you.

-- 
Dmitry
