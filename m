Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25936DF970
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjDLPNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjDLPMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:12:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A27A59FF;
        Wed, 12 Apr 2023 08:12:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a506757855so7270975ad.2;
        Wed, 12 Apr 2023 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681312369; x=1683904369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7djEHIQrshlicHr42jwhKPLdZ1EvVn0N5vUUqxUmqs=;
        b=CjvkCyRKqYzyN3zvx3QAOedCz+G9rh2V2ILPIvY2UwFt3pYrT3i6cuF3zRYjPAsByV
         nJ02sCFbqYroAu5oPi7qLWcxcwtz/Eb+o6iA/187UrYaXf0CWpmH1eYDDqCF+Hr8Bz2y
         Bv3JNB3vt8wKaQwVrwRF611YCDhLbeRwMQ9filNwXZZ5O34EbhGNTFWEB68IhZyB3BOT
         D8k3GLYo1f5AqQfWg52IHoy8bm5rgzSdoICS08bQMfIjvvNP/RIZ78EMOYkGSZ9eTQe8
         ZEqLKIglXpumZFi7C0ZJO1YxKlAQ2GkFS6w38OrZ20j45+dozTT5c3h7MwW0iIcV3FLd
         suZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312369; x=1683904369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7djEHIQrshlicHr42jwhKPLdZ1EvVn0N5vUUqxUmqs=;
        b=EghknxYwSfPs1ZO1A//YCqAo9RKOEKQ8Jw1lJ6LRRup24WhgDZkOUpeqogZsxSV7Dt
         BdBPrl/SsPEcC5qtjFDOAjDXIkk7yjhqlRgGIBPfvjDzAPgitW3QNDSPxbbNaoMy2ttd
         l8rlmHgTt4O/mUUzqdcnS6KVRefSVeFgvq142epx2Ygewohy1XlGufgSunh/lKFax5HB
         YjKK8VaTMykqIB7Hb3FptDFYta1yHhUt8DR/DUR1gbZKYmTFUG0CW/cMziicaPNtHX9D
         fg1yErPiowgi/4vY00XKZ8aN+VfLKLgbuB6EhaWiaS5JC1F49uZFJPzlJWbhcQ2PQyrZ
         ephw==
X-Gm-Message-State: AAQBX9eB/3KBVp7sCi0RvxjN58hYNrohiJHZXVsN/d0ncvWGSwtJhhxg
        Nu9VB37feYc7QlA9WVJQ/70=
X-Google-Smtp-Source: AKy350acRcrp59SCXeSc0kywlfrpXfki4xa6IWy89wPCByupZhHsuBG80q8my0ZYopvgCwqUqX488A==
X-Received: by 2002:aa7:96fb:0:b0:628:87f:6b5d with SMTP id i27-20020aa796fb000000b00628087f6b5dmr7218748pfq.11.1681312369495;
        Wed, 12 Apr 2023 08:12:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b006227c3d5e29sm12365504pfn.16.2023.04.12.08.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:12:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Apr 2023 08:12:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: (pmbus/core): Add rdev in pmbus_data struct
Message-ID: <24cfe115-59a1-4a25-8745-47c9dba87d25@roeck-us.net>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 05:03:33PM +0200, Naresh Solanki wrote:
> Add regulator device in pmbus_data & initialize the same during PMBus
> regulator register.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied to hwmon-next.

Thanks,
Guenter
