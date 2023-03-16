Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF46BD573
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCPQWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCPQWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:22:39 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD032A994
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:22:31 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x8so1563710qvr.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678983750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9GBmyw0WJBg7ZCrOCyO2Mj9DN8D/RYHEWxuq24q58BM=;
        b=IBbPWCSwUaEft4y5eeSYVHPLcYKZe6q20jMe8CFCou9o8KL0uPCCP39bC6WjHexpL3
         h4ChTrGg9orCknI95a3z0l3Gw3j6Ry3Y/Io3bKEjrTWpiLrgc3A6GcUTlQQC1nzfcHGj
         wjf0n7z2sSyDo7hSofVu9srGEi8xnZ0o26udc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678983750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GBmyw0WJBg7ZCrOCyO2Mj9DN8D/RYHEWxuq24q58BM=;
        b=KflF/XMI4pPmooDK0xRzqqIbbA4B/LkSgEoCKNMgz28Su4AQAw2Q5KEpE3TmxuKwZx
         79Ml4DK/QrbR58J5xhfQMOX0r2oTQqkwUJsHq9RVvix6EDF67jmKo/jC75oL1txG5vfP
         BmMhIQrhzPYpqXNGgrD308ZpCTWf1tktH9+feNaeonniK/7pXFCfWBJklZFzPc5GTXRi
         PkaN2xslS6EjWT5JZqoKF5onFkJ4abfdDWSUO5wWfjcckAhaKWyAxfuzNFMleKgebw3y
         2ZteH2z6ANfHtKx6/CGmED7vkF4diO7sgturJ5pI0fUGHCTmmvpdSXvITWt2eHTvbU7z
         EyGQ==
X-Gm-Message-State: AO0yUKW8fKD/svHnsEk7dBTRv5tID40CE6CimwKE3vQZJGhBUcqHxOOK
        vVUhoWa0v1ntvkbEgHWfljGeNg==
X-Google-Smtp-Source: AK7set8xEGt6h86HL22O97EmhJZzwZ6k+fOwDGCLLvjvxO6ADEVZBNhra0L2aLE9daBvgDOrEjePYQ==
X-Received: by 2002:a05:6214:19ea:b0:5ae:419a:8c22 with SMTP id q10-20020a05621419ea00b005ae419a8c22mr11533826qvc.5.1678983750655;
        Thu, 16 Mar 2023 09:22:30 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id r6-20020a374406000000b007423dad060bsm6139056qka.87.2023.03.16.09.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:22:29 -0700 (PDT)
Date:   Thu, 16 Mar 2023 12:22:27 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kai =?utf-8?Q?Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mptcp@lists.linux.dev
Subject: Re: [PATCH 0/2] docs & checkpatch: allow Closes tags with links
Message-ID: <20230316162227.727rhima2tejdl5j@meerkat.local>
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <c27709bd-90af-ec4f-de0b-3a4536bc17ca@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c27709bd-90af-ec4f-de0b-3a4536bc17ca@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:22:18AM +0100, Thorsten Leemhuis wrote:
> I liked Andrew's `have been using "Addresses:" on occasion. [...] more
> humble [...]` comment.  Sadly that tag is not supported by GitLab and
> GitHub. But well, "Resolves" is and also a bit more humble if you ask
> me. How about using that instead? Assuming that Konstantin can work with
> that tag, too, but I guess he can.

There's a subtle difference between "Closes" and "Resolves" that may be
important to consider ("closes" doesn't really imply the bug is "fixed").

The Bugbot should eventually support a number of "if this, then that"
conditions once it's done, so which tag we look for will be a matter of
configuration. It's not yet at that stage, though I should have some initial
trials in the near future.

-K
