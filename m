Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E416C0A34
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCTFkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCTFj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:39:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DEE136D6;
        Sun, 19 Mar 2023 22:39:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o32so268111wms.1;
        Sun, 19 Mar 2023 22:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679290794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lj6TKm1siAlVTYsFucnGuumrrgiwekYs8gSqZFYaV8=;
        b=fZI2qVAzQGYMO6G0NASDX9+1KvajA3fFlO1ariJDasW5tyS+HLPZAoC4bRjACtsWY7
         nqXKXiWpPmuFp0deXotDzlBoeCaHFfcljWkr17blXd1MORE3TM2JKfsz6Bg/r4ycdIcM
         k30uEL6UKHc9I23PWLu6ykFzkcKWOpKvcJ1kRUOhKII2fNDyIOX4+tfFLoFzoTXUa8IS
         napxa67A1NZtgg8e25KPR3c/Is+rIYdPd8ycocY36DGF5kSojkxw2V1gWC4+Hv1/EXVK
         5EZ71lZbytf5lQ0kzLxmL5d7oPOzWGIBmrs9KgRUhtzEVScDhiPx4RqlE3lVTJBJJADB
         8wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679290794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Lj6TKm1siAlVTYsFucnGuumrrgiwekYs8gSqZFYaV8=;
        b=kKkMW2oe7tM+ivGOUr872afR7K9+VopETl4fWHI+vowTMAr8M7/nK4IkaB1jsB0bcR
         GhuVaHs5ZJWrkexwj2lX+OJ7XTiaTTvASx3gEfXey20SFL5Ja4txsCfqdhv17dL0q86T
         v+BZm2P9QkPVLk7gPH8KSq5OdlD+6eRnrUqtbdq8gUX1gdxJcnbWV6+0YcpIhQp9jyhw
         wsljZmPDtQiBWLqkXjvVpu5Uz8gpNC8H8TU8Ku/ZFnRAeM1Y2McmeyONG8/nFrWWJyUb
         qG+/LmhoSImPXiu4tuwlyTYDhdMx1QUo9b1oY90+OhIrV+IAL4QnqmpkdcwsTYN5ujXF
         nhEQ==
X-Gm-Message-State: AO0yUKUA9ds1fIvciC0DFDea/QGoLb4qZjylzVoMfbl8MJYY701+GNPU
        8M2kjxWTu3JVZLS5Qq8hE0Q=
X-Google-Smtp-Source: AK7set9N8yJewWvbi35ASjy42fSpc8tcEcxT987snWMSBAZsoGxAAeI0352w3LhXWRv1177Y/Ij+Gg==
X-Received: by 2002:a1c:7c01:0:b0:3e5:4fb9:ea60 with SMTP id x1-20020a1c7c01000000b003e54fb9ea60mr8568452wmc.9.1679290793862;
        Sun, 19 Mar 2023 22:39:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k16-20020a7bc310000000b003ed2433aa4asm9314376wmj.41.2023.03.19.22.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 22:39:53 -0700 (PDT)
Date:   Mon, 20 Mar 2023 08:39:49 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] Staging: nvec: Convert to_nvec_led from a macro to an
 inline function
Message-ID: <417e944c-4653-43ef-b492-c82c536e4d87@kili.mountain>
References: <20230318175250.GA49618@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318175250.GA49618@sumitra.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 10:52:50AM -0700, Sumitra Sharma wrote:
> Convert to_nvec_led from a macro to a static inline function, to make the
> relevant types apparent in the definition and to benefit from the type
> checking performed by the compiler at call sites.
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---

You need to compile test your changes.

regards,
dan carpenter

