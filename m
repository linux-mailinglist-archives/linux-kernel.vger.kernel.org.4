Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB246F3B5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjEBAWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEBAW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:22:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB7110E9;
        Mon,  1 May 2023 17:22:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aad6f2be8eso25780455ad.3;
        Mon, 01 May 2023 17:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682986948; x=1685578948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEMtZF0VN0xwVsvNM/awj6CEFn2nLNLPzgXwSp1mSEw=;
        b=gqO+s7nzSwtFbMVqr8LJCptEz9BKlNeP6x7v0Bi2h9b3c+egbQH6WOhidVDBel2pm6
         Ne0ZFed250Pw1773fu3nlAmgOOQ7xmO3F0FT2k7DAA3IPyKfmZJrPkKptSMivk4adScf
         TI21mjcJLqHvkySmGJK0ZZuoDDyoMolqnhWPGdYRS5WvR3KNfN5WO1g8pgsOyJ2+uFIn
         Cdx0Xwx9xYHQWBBluFz+/IJoKAxBxafr3s3boX7VVPyaFirMOA5DCHy3K8ebJx9A0L6F
         VHJkMXvticNyQ+/EW3CF1244Uo89yHkzYTN84BjS8xMIt/FMK9YK1jZXwRVxnB9UGukm
         RLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682986948; x=1685578948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEMtZF0VN0xwVsvNM/awj6CEFn2nLNLPzgXwSp1mSEw=;
        b=jvCJK15sOrLE5IEVVk9KYAukdRLdBDkErSv6nQA/eY18GuXM2QCqAbKpaZFhPawuLv
         byxb95HWOxawhRPA3Gfj/AqMhrB+t5nHbixIDglpwq18j5zpatNxRty6zygvJztYDlZX
         xEPiZIaVtpibyNJA91qSgFzA7+Kjda0Zd9E6v0qHZNMooXBEwBv83IVclC5+VOUa1msc
         umnGepGxudND64TrqJ8oudKWUtYKPs3jvYhjxJE+zpk0F6FbXpYyv2jmHlIWFsCONowd
         DmGE06b5RWgVPsV5A4r1jZkYo8FpnbB9o/m6xFHd+DChP9MGfG7hx/ISEKaTmb/7kgEz
         zn5Q==
X-Gm-Message-State: AC+VfDxhsrWD741pOYXaK6bJJsBWezqrS4zUU3bwIbdPxQpdCG/JK0qX
        MwhIXGlqSsSOV77iTe/TzLPEgLAHe5w=
X-Google-Smtp-Source: ACHHUZ6do7fAY3wk/MYY6wxlgl+TUrx6FqEwZ0hc5CW8vC3gEURl0rewZs0kWpdJNqZJoFwOxdZQMg==
X-Received: by 2002:a17:903:234c:b0:1a6:b247:4316 with SMTP id c12-20020a170903234c00b001a6b2474316mr19639948plh.62.1682986947701;
        Mon, 01 May 2023 17:22:27 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001a988a71617sm11660577plg.192.2023.05.01.17.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 17:22:26 -0700 (PDT)
Date:   Mon, 1 May 2023 17:22:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Maximilian Weigand <mweigand@mweigand.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 6/6] Input: cyttsp5 - implement proper sleep and
 wakeup procedures
Message-ID: <ZFBXvz17jDhEPI6c@google.com>
References: <20230501113010.891786-1-mweigand@mweigand.net>
 <20230501113010.891786-7-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501113010.891786-7-mweigand@mweigand.net>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 01:30:10PM +0200, Maximilian Weigand wrote:
>  struct cyttsp5 {
>  	struct device *dev;
>  	struct completion cmd_done;
> +	struct completion cmd_command_done;

Why do we need separate comletion? Do you observe some additional
traffic from the controller when powering it off and on?

> +static int __maybe_unused cyttsp5_suspend(struct device *dev)
> +{
> +	struct cyttsp5 *ts = dev_get_drvdata(dev);
> +
> +	if (!ts->is_wakeup_source)

I believe the idiomatic way to check this is to call
device_may_wakeup().

> +		cyttsp5_enter_sleep(ts);
> +	return 0;
> +}

Thanks.

-- 
Dmitry
