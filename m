Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66BC62381C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiKJAZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKJAZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:25:54 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3632C28E31;
        Wed,  9 Nov 2022 16:25:53 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so319453oti.5;
        Wed, 09 Nov 2022 16:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sf2JYplIlxplrlcYmyHFio4Z7D0ZeTluJ3Jv8dt1IeY=;
        b=H4vU+/CFoz1BfHHfDk0Nk9qTZ5Q6vGf13K+qpUKAYS9ak8KZeL4U+2tIN59GqX/oY2
         d1ESXXzSez9+3Iv3RXqex/bigI/ezTfgVIc5zgo4BieyQpG8UXY1ha13Wh2xAiSypDEP
         myMrB+2QAXNe/7pKThtK2TaSuOoWHpSg9PU8Y04tlXDTZN4XZXpyS0r4+NLylBea6Bx/
         QBSogqz3HJcAg1JjJ7PG1yqkMDeHST+aImijA6E7Z375O4tNE1jTWZdyHoPCYAcN3iCl
         Uj8rmUE7qKJP0+WjPgMchhlHEjPJctNF3eZ3e+/I/oXDbDBukcSdgrefgJxRUdLL5Jdw
         4pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf2JYplIlxplrlcYmyHFio4Z7D0ZeTluJ3Jv8dt1IeY=;
        b=HMKFaepTbGZ9B4YvEub9UVB6/oWlysy59OTVGTIFHKXAk0/Z0/RO5m2Efh/w2zTWkp
         PdBbbvgwPGKlPiyud2aZeRZN1kqVOOi+7y7lAtENiVAzkOcQ+d3bVg8tCIittbg+i9dT
         RkIUuhrrHT4OmP4NcpOC5ZtINHr55wIFhx1hRclC1A4D+SADDQ+ytO6wB2+dsrPIk0TP
         JJOWiBkAlr65mKvqtpLtHYYvOxalZhM8Uplt8P/tL6qDwqsBJHQbQc97fuGX/yWy9Mt9
         /4zMFQpz1s5SWEKDQpwnbtEteJR9hH83MnNa3jlaLw+7WGo+MgKAXSmKEJmFwDue9XQU
         CSww==
X-Gm-Message-State: ACrzQf1fKAGaYd3hWfOaj5tYTYrd51GVr9VL1KY8wJ3qy4/hgUCBO0tJ
        C7HKlrvRLKJLyEvr+B/hj/nlL6KHkOM=
X-Google-Smtp-Source: AMsMyM74cy7c5IKRFts+MR7fbvddggIj6mu7GKL3V8QLmkiO9wWqdPyXl32ZFRa7SgyPwy8O0vUfjA==
X-Received: by 2002:a9d:6749:0:b0:66c:301e:9f05 with SMTP id w9-20020a9d6749000000b0066c301e9f05mr29856836otm.211.1668039952499;
        Wed, 09 Nov 2022 16:25:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d132-20020aca368a000000b00359ba124b07sm5114814oia.36.2022.11.09.16.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:25:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 9 Nov 2022 16:25:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] thermal/core: Introduce locked version of
 thermal_zone_device_update
Message-ID: <20221110002549.GA3550654@roeck-us.net>
References: <20221017130910.2307118-1-linux@roeck-us.net>
 <20221017130910.2307118-6-linux@roeck-us.net>
 <CAJZ5v0hO9_95uD1qY8aBe094JWsxPrba2wk_PchKHmVqRj0CHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hO9_95uD1qY8aBe094JWsxPrba2wk_PchKHmVqRj0CHw@mail.gmail.com>
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

On Wed, Nov 09, 2022 at 08:15:17PM +0100, Rafael J. Wysocki wrote:
> On Mon, Oct 17, 2022 at 3:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > In thermal_zone_device_set_mode(), the thermal zone mutex is released only
> > to be reacquired in the subsequent call to thermal_zone_device_update().
> >
> > Introduce __thermal_zone_device_update() as locked version of
> 
> Did you mean "unlocked"?
> 
No, I did mean "locked", as in "must be called with thermal zone device
mutex acquired".

locked:

void __thermal_zone_device_update(struct thermal_zone_device *tz,
                                  enum thermal_notify_event event)
{
	...
}

unlocked:

void thermal_zone_device_update(struct thermal_zone_device *tz,
                                enum thermal_notify_event event)
{
        mutex_lock(&tz->lock);
        if (device_is_registered(&tz->device))
                __thermal_zone_device_update(tz, event);
        mutex_unlock(&tz->lock);
}

Should I phrase or explain it differently ?

Thanks,
Guenter
