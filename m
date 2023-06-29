Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3367427FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjF2OJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjF2OJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:09:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A4C26B6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:09:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b816d30140so1446795ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688047792; x=1690639792;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0g2z9+kP4L2FrybPa6mrtDT1Fz/ig5aYsRSMpf+4bA=;
        b=ICbsD1KGdHfxWbVn/ZLQtZLR+K+BlsiNzJp0z2VvqT4HrKa8dIbSxL3F387fJ883Q1
         6ZoWgYZUghAP2d5NEmZpgD5wu+4FBNf3N9au0iCyt8n9Bp6uFsFUHVNM8DFJCQc6NhYf
         KglDfN3P4t+6DZGS2VQnPWrg+FPSHcuZuu6+7Nf2NNRVndkAf289P1M49cCavBLFy3Qg
         eBhE4ObZe2Ry2JZZCM+oCrw8xc47yJOg1vhy1JCCeL5IhYUB7jpgB5uIG+AvXpgcKDwf
         LWFwf2vbpJhs6PfaiDe0AOYy35zA+kcGlNnG9fzXxIZQVSFbtlDEAX6fbpQTGj0NZxuc
         6K0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688047792; x=1690639792;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0g2z9+kP4L2FrybPa6mrtDT1Fz/ig5aYsRSMpf+4bA=;
        b=jItWN79XUAACyM6X+NLRUU4vnUh++4+uL7XGxpY38TTakKKiB6ASKW6dTnKRr9IcSB
         13XhU7m5ICxTJHrBw5eMWAYmCEGbm3qs0TyRBIhDH432hVsw9/20+0ll7bDcsJs6gt9E
         QPQ1U1j05DyOpAxV5xMOs7dRXgLh9Xp4G3Vv4pVT3dj2HQ0Xt8ElNDV80B06oeBgjYqq
         vSuJuIziOgrfp4ouuWaZoo0RXw1RvQCKSrE3PvwlCz+IwFGDW+NHxER/xlG7HvVZbC4b
         fxN/1IRW/uU03mHADtuNo5kU06VfjLNeEWl2PSGxNsjEYhfJDL8jsxyTT0XQKm95WCAA
         TSPQ==
X-Gm-Message-State: AC+VfDxbjGG+Ri/Ar4XRWOzj1uiu5po9oj1IGp7/GVZhu5jQEWQRiZlJ
        gHlnR4KYXfk9HFkiLgHHpwF/oA==
X-Google-Smtp-Source: ACHHUZ5lVZcRHJV60CGMnzjUEJER0DcTPO9CTWINk8+t/vyaZvPU8Ezdmy6yzNwGpuioHG6hn7cjmQ==
X-Received: by 2002:a17:903:338d:b0:1b8:17e8:5482 with SMTP id kb13-20020a170903338d00b001b817e85482mr9312511plb.1.1688047792027;
        Thu, 29 Jun 2023 07:09:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001b843593e48sm2541633plg.228.2023.06.29.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 07:09:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Phillip Potter <phil@philpotter.co.uk>,
        Hannes Reinecke <hare@suse.de>,
        Christian Brauner <brauner@kernel.org>
In-Reply-To: <20230629083047.3487172-1-linux@roeck-us.net>
References: <20230629083047.3487172-1-linux@roeck-us.net>
Subject: Re: [PATCH] cdrom/gdrom: Fix build error
Message-Id: <168804779076.1357010.1628577959450806700.b4-ty@kernel.dk>
Date:   Thu, 29 Jun 2023 08:09:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Jun 2023 01:30:47 -0700, Guenter Roeck wrote:
> Commit 7ae24fcee992 ("cdrom: remove the unused mode argument to
> cdrom_release") was supposed to remove an unused argument from
> cdrom_release(). but instead removed a used argument from
> cdrom_open(). This results in the following build error.
> 
> drivers/cdrom/gdrom.c: In function 'gdrom_bdops_open':
> drivers/cdrom/gdrom.c:484:15: error: too few arguments to function 'cdrom_open'
> 
> [...]

Applied, thanks!

[1/1] cdrom/gdrom: Fix build error
      commit: a587b046ce921cc1805de6f0f000209b3644cadd

Best regards,
-- 
Jens Axboe



