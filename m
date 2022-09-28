Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E15EE129
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiI1QCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiI1QCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:02:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB998DF38D;
        Wed, 28 Sep 2022 09:02:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so2899538pjh.2;
        Wed, 28 Sep 2022 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xBtPbtpgFKdD1PChx7TQxHSmLi/XgqKNlKbX/Ab3jsU=;
        b=euGTU+76bMbEWzWwM1ghvRI9QyzkpU6r5r9iCaClPNHEsNTy8XUD8PW/tZeq14MPLB
         HDOLSvGRTRBP0dsOKwW/RUZBvZ2GUuAlNt/EvTajndVH3iSJSK28W0b1phLlbLapx0NH
         C7c8wdYaP/JMwjL1/e2OTvQxCrXoguZJEohr0AD+WqmnXDXHADPGE69Ota5/r9UMcs8w
         6oq+gCEg4wHCnbTetCq5zYv2g9CUFoMqQRhSxCFfmL+rRVXqzO1IRfjGhZ/QTTVhRpFi
         L15s40DXM6hKXnz5WfL2egKk2Hb1h2kaOPWDVGqz8bUhi2EUxJbYgK+MUfWnkeasqH7J
         koxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xBtPbtpgFKdD1PChx7TQxHSmLi/XgqKNlKbX/Ab3jsU=;
        b=1UciwxJ6dih+JiHZ/VkYiMWJTwliEabgKdE05Wq2eXZzmUrLXrhj6KDAueIsH75JpE
         NiXtQxUd3/Rt8PHW+FGIT9cKoS3bw5FThxYMhgQpjQmS1FXaFPjTp34ZSvOZHbG1PR5E
         yBXQ84SbNbE6afw9fwtZjfuL1rVNlB7z5x/FXvUoiSSBKK2kD9rW3bK4+ePRfa42EuCQ
         Va9dPV+j2Mc1hYgLw0J16F6WP9KoSC4zjXRw7Dzkh9CHZiso513o2LmoaIU8dB46FAw5
         rwqJMKNLqe5R6KFwVnOhVW19JxhPtXcZW8eX2V7mx3MlwtMaPX2WUH868gFJAVmou/Zu
         jWtQ==
X-Gm-Message-State: ACrzQf1O/imacw8XcKHmezt/8q4y3sgYAMNacRKH3e2qQ3nc9A0FI2fO
        ZNtEDY8Dd905t3Yqzjx7iXClkd5uhRU=
X-Google-Smtp-Source: AMsMyM7b3aE25+G8dGmrleeeWsrgQ2WVJpG6PMYNP7NAS1z3KVgJrk2iuNm1lDi7FuoRqNw8JlWlig==
X-Received: by 2002:a17:90b:4c0c:b0:203:1407:809c with SMTP id na12-20020a17090b4c0c00b002031407809cmr11221709pjb.193.1664380940029;
        Wed, 28 Sep 2022 09:02:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1a91:59b8:faf:7b4f])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902ced200b0017808db132bsm3960720plg.137.2022.09.28.09.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 09:02:19 -0700 (PDT)
Date:   Wed, 28 Sep 2022 09:02:17 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/1] Input: icn8505 - Utilize acpi_get_subsystem_id()
Message-ID: <YzRwCbU7mTWTRYX6@google.com>
References: <20220928110548.43955-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928110548.43955-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:05:48PM +0300, Andy Shevchenko wrote:
> Replace open coded variant of recently introduced acpi_get_subsystem_id().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thank you.

-- 
Dmitry
