Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4284D62F5F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbiKRN11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241582AbiKRN1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:27:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D2C77219
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:27:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y203so4856300pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x00a1e9-dev.20210112.gappssmtp.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4mockOLuSZubGQkG3QG/e1sfIcGC7HNa2itTRfiEJk=;
        b=pp2S6/w2g+E4KQ/ASRHfUgbXDU2yKSG209Ou5CmcEu0LUE5b0yaPpguav6PIl2cH8Y
         501Pua3ICfWoxszL+VRvQN15HrAwCVFXq75s61XA2ZWsPOGzFDfkzrddnJEnMFnfh/c3
         81iPs566OOXN8g0IZa/xPB1AgG9RpmV2KFOTg/8CZ+7nDpKWp+D6EpDFUOpM703STUaI
         diX63TbWlF6IOD52xyhcEjK1XojBdBdc+biiyj4Ptk/jWcESQcHOSRCZ65elMPB8v/AE
         Npyl8y6JLwdEehQuNYylJMi83Yq/jE+3y6vQzyfgXdU2GXNFfB/eVdtYr2Qxd2cnMw62
         u7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4mockOLuSZubGQkG3QG/e1sfIcGC7HNa2itTRfiEJk=;
        b=jd/KX2Mo8BxDw6LuJcwY1jZKq4TFc7qUKeeXwsgb2bFVU5XTudTM5QnXbnK0Cz29ga
         0aRnm3vBerr3tLSzvM/ZhgDQyyjr6kMX9ByMnEUQaZf8Vpj7oP1pEW0ac1PfN/Ql+8Bp
         RN+OduieOW0ATTR79ylUGuh2htRtJk329ZgcUOFyFnhbSyTk/QxwbzxUn3KgNHfvRtPr
         SxavdZNpdy8HFp7X6HUXxZgHEabYVLKIBWBP6Vr/B9P1Dz3hCqDbaM3b/k5wujOYqfZf
         BSoGXKvoGs20VgjcfKHxKg+p5TNqad6WCYt8+mdiRLMN+M4OUMbDjuitaH/ffIHEP36Z
         RBbA==
X-Gm-Message-State: ANoB5pmlKeGU+CwZGIXwD7NNxVdu2+DaKaL9ncB20qgkz5WDmJ2vmZ1n
        pSzHB2DLXAgyvvHeBT5E9lpMaA==
X-Google-Smtp-Source: AA0mqf6vFUKbm+YSnXaDL9y1kG7iUgQJaV/tfBhSdkijJ3c2G0U9iBHPNDzyN02VxcS53ZRxYyaBcg==
X-Received: by 2002:a62:15d3:0:b0:562:3add:37e1 with SMTP id 202-20020a6215d3000000b005623add37e1mr7762804pfv.80.1668778035667;
        Fri, 18 Nov 2022 05:27:15 -0800 (PST)
Received: from 0x00a1e9.dev ([2001:200:0:8802:c530:27ff:3bde:eaa7])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b0018863e1bd3csm3627881plg.134.2022.11.18.05.27.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Nov 2022 05:27:15 -0800 (PST)
Date:   Fri, 18 Nov 2022 22:27:11 +0900
From:   Yuma Ueda <cyan@0x00a1e9.dev>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, ojeda@kernel.org, boqun.feng@gmail.com,
        masahiroy@kernel.org, samitolvanen@google.com, ytcoode@gmail.com
Subject: Re: [PATCH v2] scripts/kallsyms.c Make the comment up-to-date with
 current implementation
Message-ID: <20221118132704.GA2288@0x00a1e9.dev>
References: <20221115212546.7154-1-cyan@0x00a1e9.dev>
 <CANiq72nJ8OutiA48zzXkZUvfGFjEWazPOgzXtqV2-J5HnDWx=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nJ8OutiA48zzXkZUvfGFjEWazPOgzXtqV2-J5HnDWx=w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comment.

On Wed, Nov 16, 2022 at 09:04:22PM +0100, Miguel Ojeda wrote:
> On Tue, Nov 15, 2022 at 10:26 PM Yuma Ueda <cyan@0x00a1e9.dev> wrote:
> >
> > The comment in scripts/kallsyms.c describing the usage of
> > scripts/kallsyms does not reflect the latest implementation.
> > Fix the comment to be up-to-date with the current implementation.
> 
> It may be a good idea to say in the commit message that this is now
> equivalent to what the `usage()` function prints (and possibly change
> `scripts/kallsyms` to just `kallsyms` to make it exactly equal).

I'll change it that way for both.

> In fact, we could replace the comment with "See usage() function" to
> avoid further desyncs... But that is a different patch :)
> 

I don't know if the comment should just be changed to "See usage() function",
and as you said, that should be done in a different patch,
so for now I will send a patch that fixes the issues you mentioned.

> Also, I am not sure we want to use tabs on the comment -- the rest of
> it uses spaces.

OK, I'll change tabs into spaces.

> 
> Cheers,
> Miguel

I'll send a new version of the patch later.

Regards,

Yuma Ueda
