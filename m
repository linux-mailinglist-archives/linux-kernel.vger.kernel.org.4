Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5073BA96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjFWOtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjFWOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:49:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A81BCC;
        Fri, 23 Jun 2023 07:49:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25e89791877so396064a91.2;
        Fri, 23 Jun 2023 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531743; x=1690123743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+3jEOIDHyYpeAmcqW1Siyno6WqZEGk3DGvek8iu19o=;
        b=V8oop/EztwPgZAVZoo57wK9y9XC5wrfIYcPuxX/05hu3MOL/pvEBgcMw8qPAEgk+eJ
         MnSgfkHjt/UjgwPgoVCsaJngEop48sbaXo78NnFkVNMALPEUALA98GvUSNIKHRMfCyPp
         n6Ge6MeJspvdVPPFjGUI9BWcpDoablAkFJiqr7YWkQuHAAL4XlXTYetuZMCPqrFdiQNH
         qX9oUYu0clvv5/zViPOeYkgCDhVN56CV+aWfbVZTH1VL3oYmQNdDHpsyKRfrNLFbnD6H
         0FOIIXP0TLjpkcnnD088WBudlqUh63ii6vZ/VyPCe89dI7QPK6dvQNix2KT5H+ryiqux
         9HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531743; x=1690123743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+3jEOIDHyYpeAmcqW1Siyno6WqZEGk3DGvek8iu19o=;
        b=SSNgxQhrgEL9PMMpwp5FrTDFYcUGkAvLW5T5BB0r7KWHXK1uVevgU5+ek12P7Tmu9K
         n4xkw67aQZ2wSXsRZ5C+w004vi/338FE1WQKu/M5FcFo5Bnk9Bo4PHEUXdT/keQ2EEue
         T61ipeojkQzaoomMgQfDX4vSO9b+9/+yfJN8ZwqixkkAYL48BcFZGg/azBYZZfnwNzVC
         RwGGCn5GxvbYl0G9/ZexbHgwLxTkBChWbc/sPAW4xFJMgCqty7ZT9F/wb+1DdA4kdP6F
         G8eG+ga5fdPZXi6/ZrQkn2iFAt3nO6Geo1PsBk+FYEQcnZuJ4CFhQDtjDz9goZoIwW+u
         U71Q==
X-Gm-Message-State: AC+VfDzyvbzb1PjtP7t3ZFjVhD/4XsfajUINP2YwxydqxNB6uvppY7xk
        +qCPIKNQdqcQug9+Vexz3oIUOTw8Sqo=
X-Google-Smtp-Source: ACHHUZ4HsE41rhNxvVPWvyC07TrSjQFR9Zdj1c8dT3iFHuhlAaBcbKqPx2q5HH6C2H765s/ILF1ZRA==
X-Received: by 2002:a17:90a:dac5:b0:256:4207:5041 with SMTP id g5-20020a17090adac500b0025642075041mr15396271pjx.28.1687531743098;
        Fri, 23 Jun 2023 07:49:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090aba0200b002535a0f2028sm1559532pjr.51.2023.06.23.07.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:49:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 23 Jun 2023 07:49:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: various cleanups
Message-ID: <625b3133-52bf-4a9d-a6b3-648af4ffab7c@roeck-us.net>
References: <ZJWf3H972hGgLK-8@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJWf3H972hGgLK-8@monster.localdomain>
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

On Fri, Jun 23, 2023 at 01:36:28PM +0000, Wilken Gottwalt wrote:
> Fix some typos, adjust documentation and comments to current state of
> knowledge and update coding style to be more uniform.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied.

Thanks,
Guenter
