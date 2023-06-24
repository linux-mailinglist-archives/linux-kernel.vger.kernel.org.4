Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13E73CBAA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjFXPsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjFXPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:48:01 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345062107;
        Sat, 24 Jun 2023 08:47:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e3b15370so997886b3a.0;
        Sat, 24 Jun 2023 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687621673; x=1690213673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdfaXGINEtUTeyhGC2oZ9KhV4VlXowGN9+aWjM7UxFk=;
        b=YLYiKQHxQ/47fDD+6FaPo0MEQSWW8UW6LFqlMK7VW5v5V8ZN4EiMIFqRdzxdTzVha1
         tSdFL+mGfKbWBqWHkIYkpO4coniQ/xxXLCu8zkzlkwLhBUHr7xUZxF8xYhFUseiudtWW
         FT4cqx/CFxZdtDLsVzD24iCFSWYYf+W5WgsjotmL4zkEl/pfMWUaANFmidIkq/+TkG/O
         oPFTaANByahwV3ffbSBcshuBen1JI80qHmHZhQsQr9VqPCMXcdxAosuwvF5/q0fNjfC9
         P0aI3IsV8PzjZnfOppq0F4bGFbhi0g4hMXcMufp0pI8xxOa0XsNfazIH5d8Pup6mq+fe
         zXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687621673; x=1690213673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdfaXGINEtUTeyhGC2oZ9KhV4VlXowGN9+aWjM7UxFk=;
        b=GVyXyDipsAmY+9j9ZzKJaSLB6xquIesBJj2jK7SigKd/Exnc725FJlz+evert+HXzM
         A4sTq0fThDJvuKZErzwfSHB10RtFFsiyHAn9nvu/pl9Xa+BB4UdSGz1MDKd91zZj5ru+
         oNoC5qWheobdEc4GgFFxk1FtkgICNk229f9hXnBurGp7Eyvk5L9SHqm+H3+TyQsQB1c8
         CTw4QYaCbZI89RSa8CFIl/cqZhsK/0gihGxqNAudLH0ZNAbSUSZ208M1BEs/eNIikyTk
         I5COHXEmxjSGsjD8wd0/q7qriFs/LtCeUk8R8JWkN3NkhUXFwelLuWsSs/piyBdwKS5p
         07GQ==
X-Gm-Message-State: AC+VfDyK9TI/olg/eqJdysi+pXVnQHFxg33VKXhUFXYS7Alx1dYv7N0o
        bYKSdED83fAJaDmEVGW3TTM=
X-Google-Smtp-Source: ACHHUZ7Y1KSpYGFshUqzzlwvSDfdQqN1fIfjk1aqrr3ck4chwdfuvHVevfsuvkj0Aqg6rPnT/81gWA==
X-Received: by 2002:a05:6a20:8428:b0:11f:6dc:4f38 with SMTP id c40-20020a056a20842800b0011f06dc4f38mr22638472pzd.55.1687621673440;
        Sat, 24 Jun 2023 08:47:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x10-20020aa793aa000000b0063b86aff031sm1228474pff.108.2023.06.24.08.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 08:47:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 24 Jun 2023 08:47:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: update Series 2022 and 2023 support
Message-ID: <81368b1a-3b29-4c13-8a36-074f3346bd67@roeck-us.net>
References: <ZJbB72CAPmLflhHG@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJbB72CAPmLflhHG@monster.localdomain>
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

On Sat, Jun 24, 2023 at 10:14:07AM +0000, Wilken Gottwalt wrote:
> The series 2022/2023 reports slightly longer vendor/product strings
> and shares USB ids. Technically the reply size is the USB HID packet
> size (64 bytes) but all the supported commands do not use more than 8
> bytes and replies reporting back strings do not use more then 24 bytes
> (vendor and product are in one string in the newer devices now). The
> rest of the reply is always filled with '\0'. Also update comments
> and documentation accordingly.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied.

Thanks,
Guenter
