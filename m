Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B1A735E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjFSUCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjFSUCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:02:33 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF6CE6E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:02:31 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-558cb7f201cso2481075eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687204951; x=1689796951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+G0fcPAE3L0k+TSYVrkjAY3Nac6G4KG4HwEow/M6nfM=;
        b=MxTzKEpPsN8E1NeSqfonHti4awTgTuvYy/mjO/bv/gu0ZMswT+k+ao1q6z9qPCW3cM
         WJpRDOV7jEzMIa0r4uhzpy/DMPB1zGlduIulz1ULfbZHPRsgpcGJntCIh68zl1788SGC
         qiAIo2P7Ur3swlE7KWCdMSObPW8t8yt3WzFzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204951; x=1689796951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G0fcPAE3L0k+TSYVrkjAY3Nac6G4KG4HwEow/M6nfM=;
        b=Pvh6l9r0T1xN2acvNqRA1VnITtMa84z9OJ1S7cjgxNJPkqmNRZuuxblFG/626UKIGE
         3mw+2PiJ43XNLu/iK4nCI7v6v/4C52Gzm6IBxuIWUlF+Bpwrag6i5KCYTFNK17FGo/NK
         n/p4CrNGIDROej0tLDf7xYTNgeSFr13D6d06QcvlEIJ+Pu/ppuL/qI4hhzM6HeXyUWoq
         xx/NUw3570UA5xjISMTWTMzEKQHTy6x+7J13A0bLf8SHHntAjZYMysifv6UW5O+UqXG4
         gx5k/rWyrf7/9rd2FETdES5kdjrSPTMzwq8jVYbqOLEAqCOvpIv75X63R1ZxvrJkRlj0
         tufg==
X-Gm-Message-State: AC+VfDxztbLyF7OsYm4+wUFk9dqkdBe1lu/1RV4dzCRkG+CBQYCB43Y3
        6Mjc9P7egeZAGoSY27Kynnd+cw==
X-Google-Smtp-Source: ACHHUZ4ZoxYuE6uFoU/9PanoiRvxpOUmQpxKPvt3v0x/+zQ3f49YW8hcYed3sSmYg5qTbN8rRKCtIg==
X-Received: by 2002:aca:220d:0:b0:39a:afc3:bdf1 with SMTP id b13-20020aca220d000000b0039aafc3bdf1mr11532542oic.48.1687204950862;
        Mon, 19 Jun 2023 13:02:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o2-20020a63e342000000b0053fb37fb626sm88386pgj.43.2023.06.19.13.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:02:30 -0700 (PDT)
Date:   Mon, 19 Jun 2023 13:02:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v11 07/11] LSM: Helpers for attribute names and filling
 lsm_ctx
Message-ID: <202306191302.94F212CD@keescook>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
 <20230616165055.4705-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616165055.4705-8-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 09:50:51AM -0700, Casey Schaufler wrote:
> Add lsm_name_to_attr(), which translates a text string to a
> LSM_ATTR value if one is available.
> 
> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> the trailing attribute value.
> 
> All are used in module specific components of LSM system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
