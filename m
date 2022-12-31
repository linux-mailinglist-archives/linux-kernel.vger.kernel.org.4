Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573FB65A5EB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 18:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiLaR0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 12:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaR03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 12:26:29 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B68A2631
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 09:26:28 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id o127so26479566yba.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 09:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ83C9daJ9/wrvL4ea69RztPK4tX5dvLpUHbflQsFfE=;
        b=D5Tz+y0DxxfEWVy5+V/1ZJ3VUOJ5CaRUO4yBF96HtSoGiEQ5S6Z1dA7m0sf8alUReh
         3xxXCXDxkcIAxbBIUfb70hh5y+7L4zmC0HziUrOftGER7XQElqAPOqCNcljbrDpMwYZO
         1F91/4AP2zNITSALyojzGJKSg5d+xHLPNBjAWbPuWzIT/dm+52DVQ4AKclBSYuJt3JfP
         B0YmkOJq7BxPwcOcNCNscoxZ5huIVmDUFkQ/MmdxE1LH4/dNH9mhJj9BLtxqGdZebknp
         YlItXFu20Gn0m3bhLSuw9syDSrXEz4aYexFYQrBJ2FecByyDYohjV3risUp05hnNpiQy
         XbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJ83C9daJ9/wrvL4ea69RztPK4tX5dvLpUHbflQsFfE=;
        b=Et1YH4Ryum/YawmO9yR7pUMhNIcfEc5uiD0E8XJpWq+UyNw0DxFDCYCCfqnOynczLm
         Xr8M3FaxXDxIGiBSqZKOAOw0O0u0k72yzZdHiCBQp6erDrcocImW+7A46y+fZau6rvG4
         DUiVdYvy6VTesDFyWFXh7OCc0Sr9mElOWH5aw/M2f0aDYmVTYSM/eAmfeGfThJLJauic
         QUewxZydKcnhZmRuLUDZfSMx2Y+8FWdbd1Jf24HqjS87PfDoTmyrcazcZB5vFLRuBaSy
         5SmU2e8nMCA1YYAvwB+NT6Qk4xERS6X0KRwYnmafGOflxK2pW4l5jy3ZjljokuyI7ye2
         zjJQ==
X-Gm-Message-State: AFqh2kq0QzB7X11P3HhyRB7bGQmiUaucc6DDlMtCLYGDcum5CKJ9BpiN
        avweGil/d+l34YmZq1BmmDPbRqLzvkKTVL9n7Bk=
X-Google-Smtp-Source: AMrXdXuVtqPz9d6WbAibJxgbMMrNTErAPo9XG0A2xyg0QuobeI7KFjfbcOIgkgeJfY+lVU+5VaF5qoPfSsdeiODfuNI=
X-Received: by 2002:a25:d40d:0:b0:706:ba81:7470 with SMTP id
 m13-20020a25d40d000000b00706ba817470mr3638195ybf.253.1672507587861; Sat, 31
 Dec 2022 09:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20221230163512.23736-1-dmitrii.bundin.a@gmail.com> <20221230133726.4c2e7e148a8a6627cd621e0f@linux-foundation.org>
In-Reply-To: <20221230133726.4c2e7e148a8a6627cd621e0f@linux-foundation.org>
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date:   Sat, 31 Dec 2022 20:26:17 +0300
Message-ID: <CANXV_XwqgEZ5qhP-A1YNOuP7wri5Ax=1yj1CV2BwOFQMyr+hBQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/gdb: add mm introspection utils
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
        Mike Rapoport <rppt@kernel.org>
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

On Sat, Dec 31, 2022 at 12:37 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
> Should it have a check that it's being run on the supported
> architecture?

The x86 code is under the if utils.is_target_arch("x86") ... else
gdb.GdbError("Virtual address translation is not supported for this
arch") check so for now it will be an error to use this command for
other archs. In the patch v2 I mentioned x86 explicitly in the commit
message and also addressed issues Mike pointed out. Could you please
apply https://lore.kernel.org/all/20221231171258.7907-1-dmitrii.bundin.a@gmail.com/
in place of v1?
