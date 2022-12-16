Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E55064F553
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiLPXui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLPXug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:50:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A54F663
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:50:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id tz12so9647252ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TGYD/43itP5jhG3AMBWGsLpG3Fh9gkXSMBOyCxjkuIg=;
        b=DFWmzXhou89wjbd+iGzTLJwfYda3hHS9r24xTVxCKieeD+uu6DdkEXffcEd2ysdH4p
         RpK7h6R1mB8cGGCN1HwXC5CPxrBEnhPYsr06FXPNuYThCqSEPgqVIm6mg0B4k2k6dwtv
         ceqVVN4pcBmmckFqXYpgnIsS34O3w9bS1Lbr6wJLHuNkGfwP0vhKCB0IdgoxuqDerqrL
         KXk3stNKbyLGRtCQq9jtR+PsZxtDn/ONjzQDukYrfHLrxzfDkjHjAmYUZwXUIIlYuves
         Ao7JaoCw8cDZ1d0Qe8iFsKMHYXKZ282+mClr9EB/fCBLg11XL//2GRWtDsS+BdFyEUUR
         4+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGYD/43itP5jhG3AMBWGsLpG3Fh9gkXSMBOyCxjkuIg=;
        b=oyE8QP2EPRwtMkf6ka/Cv/xF1mBtckGfgdOEy58hK5xMI3nz81cKKD/LiKrRBS3m8t
         3wz7zPcdaW0N+XNlY//FTsA4HVQMJRRMy4Ih3uGWyNToN1wAelHjNv/ct937FdPZUYDm
         KcVZocdbg3ieZPWOBs0fXudH3PRNp9vu+akzaopvNUGWJBODhqsmOe4RbUFan++T+ckO
         hMWKZbkbxZ/0kWVMDE6l1KQVus8RtqQxmVKaQ4esP9zrTn5o7TK8m7TKPsYVhpBWMFcE
         +YveYGUCpwsehD051gsnxryokfdTe44gv/g/x2OGdWHoOox9DB9Z1tan+S/Fg030B5y3
         /Beg==
X-Gm-Message-State: ANoB5pl76Ze5STZvFFao6A6MZ+ewHNLCbhSye01/gBRDa2j6JLMrrDq3
        tTSm5s7FpXw0b+Wk/fslKstpkjUKySUWk3797F4cwPGaHxtAIQ==
X-Google-Smtp-Source: AA0mqf4iQerKq0SXayxMXO4sNZ6BbliwbFrIcsnISdHyxGatyx5ONcxi5wUKJH+zijrxaeowMgGhBYK9ymjQbiWn35c=
X-Received: by 2002:a17:906:1308:b0:7c1:55aa:2e83 with SMTP id
 w8-20020a170906130800b007c155aa2e83mr2775643ejb.361.1671234633422; Fri, 16
 Dec 2022 15:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20221216233355.542197-1-robdclark@gmail.com> <20221216233355.542197-2-robdclark@gmail.com>
In-Reply-To: <20221216233355.542197-2-robdclark@gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Fri, 16 Dec 2022 15:50:22 -0800
Message-ID: <CAPaKu7Ti5sEzGVRaE8UFx1RRbBba3=am8rwZf3totX1z8bfJHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Fix GEM handle creation UAF
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 3:33 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Userspace can guess the handle value and try to race GEM object creation
> with handle close, resulting in a use-after-free if we dereference the
> object after dropping the handle's reference.  For that reason, dropping
> the handle's reference must be done *after* we are done dereferencing
> the object.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
