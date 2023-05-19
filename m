Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4872A70978C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjESMt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjESMt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:49:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CE3106;
        Fri, 19 May 2023 05:49:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae763f9a94so9408185ad.3;
        Fri, 19 May 2023 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684500595; x=1687092595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSjVrbe8mOm37aNAHvOBDIs3fksOsl+gBbHuEXxeRjg=;
        b=CHbqtrapky6lyl36HYJkCtPVXlpcN7vj9fq+xiDDvO/5Jerg4dS2YvLze4PQiBlMEO
         YWJYdOFZgzlR2aFxGPatCTFUJHs4hakgTpyOC5pnhkjqWm8zu4VFW6NJGzFFNuzGlZpZ
         axn+s7/9yq9Onr+lMr1ZA+19XPZIznnO0qAM9rOqOBtsjEFodnxdx47mPyOpFJhwbA4B
         7Gdu+2+P93+5EQ+QxZV7z8MfiJtiNZrZ554GYCgA5bFFR38lgZtweOtpRS3BBjDZ4Bvn
         5l4hmH0ELQnHpeewXrmZiwLgcZSSzJJPYbmiWlgoyeBF+tFpbQNN/vfJ5q9G1cXqYuG2
         p5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500595; x=1687092595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSjVrbe8mOm37aNAHvOBDIs3fksOsl+gBbHuEXxeRjg=;
        b=Vh4JSM9TyOdu14m225f5SDv4vx6kXBrA2JywX6TS/U925o3wqoIYkU/9Mhk05voYv0
         fc6WM3/LkUQ9o8kYusvGBuW9mZQnBNHXAcw/YTPrtocj9IPE1A00ZmQKwYTbrseGd7Qm
         b0ob9vrr1l+qsumN1SSVG9+XK+XTworOKxRNldHwurzYGP2g9RFRaq3n6MlIXqnz/fat
         2rs2ynDJHrQKWWqd1kkTcYBNDs2UoYyooxTiMEqHcjWAIeMtYJvKma7Cet6jPODff9bi
         +qFf7MXHovkS6qufxIy8jppBd2fbxgZFzP5xfDUrIRDojOnGD67isgdrrKfvxvRoZERu
         fr+w==
X-Gm-Message-State: AC+VfDyWL5xchr96vU/usiF/7Y+KwufZlt6vxI8tzN6dGLCb8ILxwT3y
        jlgi16yXvSLUl4GYatV6EOA=
X-Google-Smtp-Source: ACHHUZ57ceSdLt+728CVL7AnAwb39E1Lh1lpxz1g1jiT+HHZKxFm61iNVzfbRwDH8gGqlvivj3Fb+Q==
X-Received: by 2002:a17:903:1d2:b0:1ac:7260:80a7 with SMTP id e18-20020a17090301d200b001ac726080a7mr3154439plh.43.1684500594888;
        Fri, 19 May 2023 05:49:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902ee4100b001ae6b4b28adsm3347528plo.130.2023.05.19.05.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:49:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 May 2023 05:49:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add new DMI match for OXP Mini
Message-ID: <24dfff32-24af-4957-8249-4705dc89c67d@roeck-us.net>
References: <20230517183540.187383-1-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517183540.187383-1-samsagax@gmail.com>
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

On Wed, May 17, 2023 at 03:35:41PM -0300, Joaquín Ignacio Aramendía wrote:
> A newer BIOS version for the OneXPlayer Mini AMD modified vendor and
> board name strings. Add those to the match table and set the same board
> model as older OXP Mini AMD.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>

Applied.

Thanks,
Guenter
