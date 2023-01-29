Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FE16800D7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjA2SiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjA2SiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:38:01 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEF2144B9;
        Sun, 29 Jan 2023 10:37:59 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1636eae256cso8335933fac.0;
        Sun, 29 Jan 2023 10:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqvPN10TpxePFaQiCDfEmJae23SIsLPwO0G190apMU8=;
        b=C80IOpthPO/BdyDB6g/K1W4lKyUg6C1yilWgdQX7XO12lo2n5xUCxml+gVIHyR+db8
         5jI3zKfUMshWNEFAR011pF2NhkCN/d3UpbhdKdCTSTdhdGyleUIY6pPwTjIrVWU3xPb6
         +jfcolzn4TAZnZrE5FJmaiNshov9QeB3PeWU5hQsOvchbIO9REwIEWbS5kdj8Zj3RB0v
         Bv/jI3S/j11UAq7JoYF7ggk5cgkTjkfbuMwvZ8rVH/zQwkuulYtssPGIYKS5gIe8ELrd
         wBGE6JcFHn6f8Pg4akTfYCSVdEf0ljEjmQA/0jLRTR+lbhc2PKjtUuc1FKGiRuoyhF++
         UwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqvPN10TpxePFaQiCDfEmJae23SIsLPwO0G190apMU8=;
        b=slaLy+2rZd9fWrKuP5idBc725lfOuun22SgVAPcdgdY2RbPRP4oF9PDkwP7ty3L+gg
         2Y5oeYqwNzppaCTfJrG60XXlbRRpl78dDiApmtvmB43J+W2NWq7ELQD+ouCEPjht4uH9
         +mbSRh7lgktJVGWG7QFZ9DVolXmFZpYDe3CAUSObDxK7HFjuzvbJc3CmVMGSkvygg6hD
         g0nEShSxzV7Vjkx7AZN5dK12ALoJqGp4FfnRdnOFkKHN6QMvKyG1Z++BfaT47PArrcMY
         tu1Iduv26OCDxfamaANQ01gFb9h0Oa6VczQz2zSFCrz2M78d33iXNPJ4IcE0ahpxycCi
         vvGQ==
X-Gm-Message-State: AFqh2koMEPIbzRRA51ry5BU8IhUn6Yrr4jnmOjs80x2b2yQdJw2vBP7u
        Ek09O1eXwkJwk0FIsa/iGfPekKrYz3E=
X-Google-Smtp-Source: AMrXdXtT6+VqrnvyGIMlpZ4+bEjZT8vg7lhafHqqsO+bI1lYycueeuxzgAMNXrZJL8y+TRF1q/VNWQ==
X-Received: by 2002:a05:6870:c21e:b0:15b:9290:3905 with SMTP id z30-20020a056870c21e00b0015b92903905mr27373054oae.42.1675017479112;
        Sun, 29 Jan 2023 10:37:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pa13-20020a0568701d0d00b0015f9cc16ef7sm4319879oab.46.2023.01.29.10.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 10:37:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 29 Jan 2023 10:37:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eric Nguyen <linux@drogman.ch>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add zenith ii extreme alpha
Message-ID: <20230129183756.GA1416397@roeck-us.net>
References: <20230128102135.5199-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128102135.5199-1-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 11:21:34AM +0100, Eugene Shalygin wrote:
> From: Eric Nguyen <linux@drogman.ch>
> 
> The ROG ZENITH II EXTREME ALPHA provides the same set of sensors as the
> no-ALPHA version. Tested with the hardware [1].
> 
> [1] https://github.com/zeule/asus-ec-sensors/issues/31
> 
> Signed-off-by: Eric Nguyen <linux@drogman.ch>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
