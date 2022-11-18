Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F962EFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbiKRIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241182AbiKRIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:36:35 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155262BE4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:35:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i186-20020a1c3bc3000000b003cfe29a5733so6995891wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZBJWsvuPM4N2XNgGuD0Fakzbbh9G5ci/DsGRyhIEdY=;
        b=bHGQfWHm3z3WfK33pmq9dlJOKNe03OeJp8opslres0KGRyyM4Da5kMG28KGUnBQdZC
         l9FVIn02fotJTFGEW2mp0UPJY0Dv22nW97wBkpIpwq/YTlrcrE4pTMWxw5Mn9XEsl//H
         tVot2J6vWtg2iBpIfPhruW8kaSBPK8jbKxDD0anU1IRwyhAoUpvO2s4jQIMRMjRVlutx
         g7qfLtgVN/iTTZCLePMtmadGA9ELPDI52fAfZWoKncymcDepeYnqU+3oM5p66eqMCvXy
         mxfQA4WVE9x0zlv8M619hy96MSUGohRBf9xHo5uUWp9nrXmObbgv8a2RpP97HybC/Awx
         bXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZBJWsvuPM4N2XNgGuD0Fakzbbh9G5ci/DsGRyhIEdY=;
        b=Au80yWct+AWstNp8tQDj3B4cA5Z084oWCYZNdjY6OJc3tZfVYzxdE8SBcUtJI8iYQU
         1i4N7RlNfIlceT5zXPKIRS8z9SfhFuwdMzythRW/tpny7sDbt6nxJCBUE89/neMAFY9n
         SO6RFqe/qy7dVjWQa1Oo8tq09rV3wQ+JvKmuTfSU4JcHN6iZsXv8Wuy3vVSiUNQLGxps
         szrUYKvjvTNEteY9EXsTkRSfI4NZBZq4z4RrXCJfrFVHBD6tv4xDCiZ9FfckV9F/pDAP
         TW558CbO17O2UcCuF3Dszuu20Pd3GrCHo8h+KE3i8HRjPHqh43Bin4xBpBjG+hvgroyb
         Qrzw==
X-Gm-Message-State: ANoB5plwJkOUHf5pGV10MHAXy98Kb1vHYGbQdFKXPomsZO9EYrnP88WM
        20jYWM9flwmlw0JV1/ce0XGt3kUQSBMY3w==
X-Google-Smtp-Source: AA0mqf60YsmnRdTamyBcHrdL4qYmUzr0MzwnwfkljypGszjucXInCUwcNUvqDYFv+EfSlNtYYPr1rg==
X-Received: by 2002:a05:600c:4f12:b0:3cf:e7bd:303a with SMTP id l18-20020a05600c4f1200b003cfe7bd303amr7953544wmq.151.1668760556423;
        Fri, 18 Nov 2022 00:35:56 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cf703000000b003cf774c31a0sm7538328wmh.16.2022.11.18.00.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:35:55 -0800 (PST)
Date:   Fri, 18 Nov 2022 11:35:52 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/3] Revert "staging: mmal-vchiq: Avoid use of bool in
 structures"
Message-ID: <Y3dD6Lg2L7CgkDFe@kadam>
References: <20221117160015.344528-1-umang.jain@ideasonboard.com>
 <20221117160015.344528-2-umang.jain@ideasonboard.com>
 <166870135963.50677.14827688186331561108@Monstersaurus>
 <c718624a-bb6f-5474-5cc3-4319b1fdb282@ideasonboard.com>
 <Y3Z3Is8u4wGZfKU5@kroah.com>
 <c5e03c65-2994-6518-c79d-f6ad1557c4e0@ideasonboard.com>
 <Y3bN8I7DlxRUZumH@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3bN8I7DlxRUZumH@lunn.ch>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:12:32AM +0100, Andrew Lunn wrote:
> 
> Does :1 really initialise the variable?

Obviously not.

> In "u32 enabled:1" it means
> this is a 1 bit wide bit field. It seems odd that bool is somehow
> special and :1 means something else.

If you have a bunch of consecutive bool a:1; bool b:1; then GCC will
squeeze them into the same byte.  But if you have bool a; bool b; then
they each take a byte with GCC.  I have specified GCC because the size
of bool types are a bit vague in the C standard.

regards,
dan carpenter
