Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B096BCCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCPK3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCPK3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:29:40 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EAEDBDD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:29:38 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e194so1245596ybf.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678962578;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Utrqm6TMaaiRVdrnBHDzX43Ie3rDTCdv2ZFEbN+1erI=;
        b=Mm8g/4lA/RM9mTGWfDnkv91n6UAyLxonCLwXc5bZROiIN2gtK3dvrNLF4PV9n7GSHF
         0Emqub9OhhD5mLv8KOKqe8k8rM2twKxcLsPqNNx0jWssymO7jDm6YGjq5yryrsRceK1O
         gk8TmukItGCsoP+LrY7HEIpqi3nI/ut3DrikxQXoezJICLuqEBVi5AQ8xy7lMRWQo6+I
         clnF3djPz+lWXhKGdZFqqRWkW8IC5bBcGfutplVRKvv9jVw0+qqYlXNYIIds/fxQTvQl
         ZDFm1G7FIaqWpi3aewC+lCtSbF5gAvOoJ1bBFEtnRBXvEtAcjvnWaCDwD8Kr6z0Auwi0
         Qnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678962578;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Utrqm6TMaaiRVdrnBHDzX43Ie3rDTCdv2ZFEbN+1erI=;
        b=eOaqVcJ7tJa5ErePRuXZm/+LMTpoAGRAj1gIk5s/08ygHOLkGLc/pMcuZku/sgPPkG
         DQu0Hk/1GTbAoBeqqmlz7L0AyVrxOq53UbWJHaLsdDVJdnVbLI7XYPj0m8KKyKSEts+2
         BHt+6J6vTm3DgArQh7OnDm7SoNlBJplJU7VlW/9UhMYUKtq8sVbX8i83ZKjj0olvmclc
         JK5BWbq0zy8iJlsCLMITM59IWmVZgeIIaOxc4XDjjarCreIGCyNA2qAr4VgqIoponBo0
         pT9rhSx9cMcbj+Hy/i8eIQfy1SCqLkWVkdHow+GV9/Arh5L75SEIa7h2XoaX3qsz8Ekn
         0SzA==
X-Gm-Message-State: AO0yUKXzuM8Vv5rJx/dAlwJOwgBtOUQWf28gGTrhsTvANp8cBMLSbPbA
        s/UPg7p6ehb6OQmP/u20GT5+tyjOnmEHe97wwpLd17yyyOSeFg==
X-Google-Smtp-Source: AK7set+hUxuWIQO1bnYJu+rdDJPXLcaZR+T0tHn8HIfaIscR71O8XrIYeia9WemAU22cirm2oiFCeiB/aVn6VDJ3axI=
X-Received: by 2002:a25:f50e:0:b0:b26:81e1:f928 with SMTP id
 a14-20020a25f50e000000b00b2681e1f928mr16194078ybe.1.1678962577835; Thu, 16
 Mar 2023 03:29:37 -0700 (PDT)
MIME-Version: 1.0
From:   Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Date:   Thu, 16 Mar 2023 11:29:26 +0100
Message-ID: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
Subject: Change of behaviour when console=null and ttynull driver is used
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, Guenter Roeck <linux@roeck-us.net>
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

Hi all,

We have several embedded systems where pass console= or console=null
in production to disable the console.

Later we check for this in user space: in our inittab we check if fd0
is "associated with a terminal" (test -t 0); if so, we are in
development mode and we open a debug shell; otherwise (console
disabled) we just start the application.

Recently [1] this behaviour has changed and now if we pass console= or
console=null, the new ttynull driver is used. This breaks the check we
were doing (test -t 0 always true now).

Is there a way to get the previous behaviour? If not, is there an easy
way for userspace to detect whether the console device is a "real" tty
or ttynull (other than trying to parse the kernel boot args, which
would be a bit fragile).

Thank you,

(If possible, please CC me in any replies)

 [1]: https://lore.kernel.org/lkml/X%2FcDG%2FxCCzSWW2cd@alley/t/

-- 
Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
