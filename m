Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA93660A17
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjAFXJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjAFXJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:09:05 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A4B6EC80
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 15:09:04 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e76so3395526ybh.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 15:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uNw8lJfvZVelqIGpOMPYHB7hbnoUUxqhFFgmI1a0HNk=;
        b=Ocf59FqFbtbgb6yP79O/ILQMj+k8Z7D2kGe44WZRDLxX1HT9ecbApjq9b/iisZaZDu
         PEx2MXaZQuk7VxtfBZEYXiS6+hCB35Y3oiQKrvS4fMN0VeUO/AA0bh7+FsMaOMM6xHEm
         zRR4W4kMh5l0U8OioO8rIC9oGXTwXQufLwPGhG1mbgD3Z3UUs7ukLXLifE+at9DvTMN0
         2AyEzngayztBPyGOq814AP9t5vPrllLh7pz3yKRTgQejkRx5gHIlK+7GitTCuUR2ihIZ
         t2MyxPIyMQVlD2FDfMDrTaLSkrRhzW0OHIlT9nxki35eQDZ7xZdIqui2Rex3J4wv/TYK
         FE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNw8lJfvZVelqIGpOMPYHB7hbnoUUxqhFFgmI1a0HNk=;
        b=kfxNaTNHOIqLe3lA0nQcRM+rwjsF5Fa6f2NIVZGTjPXio2BR1x25i8bRx6a1EFFxhy
         IuJ0I0ELDH07mwqnGfICBRCCedjCwCZXVDd45NQXpiMci9wYyJWNvos3JX8CbEj/2+Sc
         K2zgH9dKjgm11p1vYgQzYZpBu5pdZA/XLnIsTiSQhLg79AOZUvSATjdrJC7KAN/3n0NX
         1bL4EeTDEYv52p0apnKMnDlF/ZWwt45KajN4ZPN0zOekweDFsZ0pTBSBXIhL0JBSAyQ3
         0FDXjQlvIAEY8K2o/yZ9iPhMgfYnQFQ/7NCXSqpmD/YBfal98A+F4NXbeGIvrdv8UKqY
         MBEw==
X-Gm-Message-State: AFqh2krVWuYM5VubbdMC83yS+0k0xz37gRnmBbcjYCKVpH8XL6sCrTxd
        qGH8+c/iO80Jhc9GXhwwcfB+iw4sTIz8heG035jvCoX8xitXwg==
X-Google-Smtp-Source: AMrXdXtcO0NPpRGh2vj6dvBfc5ubxXSJG9BYYCaAJ0L7Hs+UTbrO+YazyoGL2EBaHDM7FuRCUCeWLyqJMurBM4Vdmm0=
X-Received: by 2002:a25:e601:0:b0:761:d9ec:3287 with SMTP id
 d1-20020a25e601000000b00761d9ec3287mr4616285ybh.506.1673046544052; Fri, 06
 Jan 2023 15:09:04 -0800 (PST)
MIME-Version: 1.0
From:   Mingwei Zhang <mizhang@google.com>
Date:   Fri, 6 Jan 2023 15:08:52 -0800
Message-ID: <CAL715W+k6HWJed8niOK4RWta+viLXBnLT6sZPmqdTi09FEep5w@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86/fpu: Improve the init_fpstate setup code
To:     chang.seok.bae@intel.com
Cc:     LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        "Baker, Thomas" <thomas.baker@intel.com>,
        Neel Natu <neelnatu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chang,

Is there any update for this code? I haven't seen any updates since
this version.

Thanks. Regards
-Mingwei
