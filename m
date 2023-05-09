Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D506FCFA5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjEIUhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEIUhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:37:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B1A0;
        Tue,  9 May 2023 13:37:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f423521b10so22082495e9.0;
        Tue, 09 May 2023 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683664653; x=1686256653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Bswn/z08Bd4bd6J8MGGINAvE8t6sPW5eGxLX1r3urE=;
        b=jDMOxRrjyGdBqOvvh4JjkZxcFwgQx3a1MkTCs051L8KFpewTjo59nOS43qQKGaikvd
         1ekWusI/LwZKDRsiqdO8XzRwHdRF2kRdPwgBMJOFysGZNXhocFv3+mpazbt9NHuq2pno
         qQRkGul4zLyzPqfcglpJmv7nDVqrZF9lMHwGPRv/e/MNddLe+4LNApkUuZ6b3qIKUAia
         rIJ1BLIh6b6T78g9NAYbuy7l9VAE5v8Wrw0fEpOOjFoL/sgJIbt5uL+/3TdvAMVAFrVe
         63bVp3OC1lHQbxjjZs+7MZOUZrYWO3euY0MdpPQfjr+FpOTIhyzSfhs1jRrsBVGwN8f8
         LuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683664653; x=1686256653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Bswn/z08Bd4bd6J8MGGINAvE8t6sPW5eGxLX1r3urE=;
        b=d9M0hI5lbcZPmgCmSI6XvCra6exApbUgd6dQ1d3rTVW9SWRS+5xW0myQxSEkWL97Yt
         FDLI6K2yPfJeyoMg+L2hS1kLdLPrdgUqnGzABhTBs0zinkjE/TKfssMpXjB6ORp3Skqz
         RiKOrg9LXwR4COPX9F3a6vqaurVd5uttX1eyZAOAvfyZUUt5pPIZNplGwqWG322O+kYs
         +8l6IYfSLrkd4AcI0w0tuLZaCzWnNHoPqVYYH8/Zbns601EohuOFssq8PQSXlWs13PoB
         ZLSnKmHyTC4ZW8UWqeXLR1D8jkclV+1TfGUM7J8Lw1gPCw/xVro3ThYfRkAhG0iI5Jqh
         qjUw==
X-Gm-Message-State: AC+VfDxpeymfWOjx3hcTm9XmDwCrxh+lphJ547J6rWSA7zXS3RJ22bbm
        f4dcreQMRZ9VITtzFs+qYy8=
X-Google-Smtp-Source: ACHHUZ4SVx6IA/oOEjsyRZjD2IHm1XLo6B8QZ2l1mFlQjkPC9UGcMcXbhsXq9ywzoIFBwHGsIIJsEw==
X-Received: by 2002:a1c:f402:0:b0:3f3:3a81:32b with SMTP id z2-20020a1cf402000000b003f33a81032bmr10439045wma.15.1683664652628;
        Tue, 09 May 2023 13:37:32 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id w12-20020a05600c474c00b003f07ef4e3e0sm4498071wmo.0.2023.05.09.13.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:37:32 -0700 (PDT)
Date:   Tue, 9 May 2023 22:37:29 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        pjones@redhat.com, deller@gmx.de, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Cannot boot an i386-UEFI thinkpad lenovo tablet-2
Message-ID: <ZFqvCeNxKJDOYDaT@Red>
References: <ZFnoXiZGGhuWDl2S@Red>
 <af88a590-e20a-0669-c0d8-e073cc6e109f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af88a590-e20a-0669-c0d8-e073cc6e109f@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, May 09, 2023 at 07:01:02AM -0700, Dave Hansen a écrit :
> On 5/8/23 23:29, Corentin Labbe wrote:
> > The tablet has only one port, so I use a hub for keyboard and USB key.
> > Immediatly after booting Linux, all hub port light goes to off.
> 
> If it's dying in the installer, can you boot it to a shell or rescue
> media?  Are you getting any kernel messages on the screen before the
> installer?
> 

Sorry my sentence was not precise ("after booting linux"),

It die after pressing enter on grub menu.
No kernel message, nothing new on screen.
Only visible change are USB light off.

I have really no clue.
