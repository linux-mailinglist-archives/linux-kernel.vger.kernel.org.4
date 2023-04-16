Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FCD6E3965
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjDPOj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjDPOj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:39:27 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5F5BA;
        Sun, 16 Apr 2023 07:39:26 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7606cf9fc63so43166239f.0;
        Sun, 16 Apr 2023 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681655965; x=1684247965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8ZkUiUebkjTrLhA1EwJs1l6uyjwxYDbX00ZSR/CmGU=;
        b=KoRkjtb3WWSudJ8cPL8IWMqVW9q6LSpBtGBdqIcd/iAtxfnY7hIsogJuKhfY9Csxs4
         VQz0WhTwwODj0ZknGpSg3UXSBAOaavllUKLZzV+lQelvUu8WXNV/eRv9iKJxj9wEra+7
         2mayJ53t/dShfi+j+mvqKE3UoXXU8d1Ipi01UeJiyIf6zRxnIlvU4tPylCDpYrdxen1+
         mj6t5j7GWz8ZG5QoZOupd/SJ0hQkTveuIKZ2LrzaS3SFfFdxwTpESMDbdgBAXSXtw9MI
         /Z60L+9CgE1uYg17sUeI+qAZbfaF2WuBOiC/+8WAA25u5sHXioi+0LEwaYyikyMv5HaN
         VALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681655965; x=1684247965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8ZkUiUebkjTrLhA1EwJs1l6uyjwxYDbX00ZSR/CmGU=;
        b=HTjtey3w5/xZW3lXlNMchq5Zh+CS4Nx6lhCSaPs7gqSwD6ix+B3cudem/JPNbZBJS3
         ZQSjXpMj/ZzaM4pfESZstkful8jEukORzGjWp14bWB6KF5EInpmbk5ysmVlaBTG6kmTl
         027357yPkUXPVKBfhkQk7qGZDg2B6kmqE9HwA/nuj0ptGB4QXkjqzwTBycGN5zOt6n/V
         BmqQwVoduxugVXnmFL4Xbu9kYsKe1QYda3v9n+2Gm86qWEynropTxoeCyRTyQq7Ia1og
         D0Qvm8bQ4Jo0NIJY42uzFvpTDD199nlsq4/61/5PLCMnkORtIS5o1jaAYkluCNamf/X1
         jGDA==
X-Gm-Message-State: AAQBX9eTtCwwPtHaPuNubUex5K5Svm6ORoYZ4brXKM2XJc+J0RgThVtf
        yjw3U4AidsarayrsTFglTw3rF/6/RJw=
X-Google-Smtp-Source: AKy350b7q5fGnvGl8yGQIHPpDZ5OFwlCVkm47u3RzbBXx0WRZsTSXDxHMB53CiwdwuEpdFGUQJYsUA==
X-Received: by 2002:a92:d451:0:b0:325:cc57:df63 with SMTP id r17-20020a92d451000000b00325cc57df63mr7272769ilm.22.1681655965581;
        Sun, 16 Apr 2023 07:39:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cn11-20020a0566383a0b00b0040f72526b1fsm1463291jab.16.2023.04.16.07.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:39:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 07:39:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (sfctemp) Simplify error message
Message-ID: <cb54f91a-5b34-4e88-9afc-d2c714933e7d@roeck-us.net>
References: <f32a6e877f399e11ca130476002f85c2b48ba7ec.1681575790.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f32a6e877f399e11ca130476002f85c2b48ba7ec.1681575790.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Apr 15, 2023 at 06:23:37PM +0200, Christophe JAILLET wrote:
> dev_err_probe() already display the error code. There is no need to
> duplicate it explicitly in the error message.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.

Thanks,
Guenter
