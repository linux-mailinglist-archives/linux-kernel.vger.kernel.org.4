Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC767AEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbjAYJua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:50:28 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B353A13F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:50:25 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e204so8247022iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3dGewbCBEk8znJB/rL0pY57fT4B6zUWIZHf+6ieq5k4=;
        b=JSgpiqWm4mWyX31Cus3Irx44EA0dWprO9q8zVs7utvZsLhtjf6L/Kbp8ckxYrsbR0y
         KFGcYRoqSKlJexOxQ4Tx2SRuunp5wGOmPurL6AW0WBrHu+gPPyXLnCtxQ4FIS7RgOhal
         tI/s/rq7aCqxwuPwePl9ncoy1cJepp9QHn/zI2rRm8Wwn2GUA3uD01u+eid/vA5QyFaz
         LJJdozDgdZWBcJlJJgcTN5RnFH10XBEpGOnqU1l5Rn8mKWCdHLe5sQSlpJZIrHdXgWHg
         +LtDMPROdcfXZ/hjoqx6uJNMeXotQZh2xgklp4ExPGRPKSj73afHU6j5mheS1JshKJpC
         WIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dGewbCBEk8znJB/rL0pY57fT4B6zUWIZHf+6ieq5k4=;
        b=GynWRNws1FY/KAZ4lWWkjUyCHLw+Sb2eJ+jZRIMvq0CWc+O+k0PEzRCkOqM6sPKzvq
         454j6dqOVmIZchVZLzXwmXaS9s9OGeyHl2hlibTML4xuq4S/aA00bge3ZBKIC1EKsMOH
         0gZweDRA2qHUcKzirleh5gbLK+yXhsfu7ijw9DkMaksN4vz+hw+ASpjVmLc+ly9luSIM
         ejfcpXdLBTeLl6z2fOK7Yzlv+3GgWE1n3PMom8BCbmNs+p83FdPnt6scc3OrdnzGO5I1
         0dhmWb+O0szCUwta3n650z6sDYESD42sJ93ZzEDaTSgyQ0tDeDyPiUkI6K0oC59zMjJy
         NFXA==
X-Gm-Message-State: AFqh2kqDLDyeWtpit5tX2dutUW/aJ46DrbRMJgYqh0PPtkydJBwk1RLK
        mg0caRcHQT260kLxenQxGcedpP/IrFM9fYf9QfRusw==
X-Google-Smtp-Source: AMrXdXttr6p62zviugUg0k63VLEkcgzRHvJUKRS+ygrgM7qb6TP4Pl3kO2M/z+bFsMgih1khTHQv+cdne9WhR7+AOoI=
X-Received: by 2002:a02:cc24:0:b0:389:af9:4860 with SMTP id
 o4-20020a02cc24000000b003890af94860mr3582826jap.164.1674640224797; Wed, 25
 Jan 2023 01:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20230117163543.1049025-1-jannh@google.com>
In-Reply-To: <20230117163543.1049025-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 25 Jan 2023 10:49:48 +0100
Message-ID: <CAG48ez246oQD-rdnemBokm+345Uo+OejvVQk1mR4=9fXzbX0gQ@mail.gmail.com>
Subject: Re: [PATCH] fork, vmalloc: KASAN-poison backing pages of vmapped stacks
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com
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

On Tue, Jan 17, 2023 at 5:35 PM Jann Horn <jannh@google.com> wrote:
> KASAN (except in HW_TAGS mode) tracks memory state based on virtual
> addresses. The mappings of kernel stack pages in the linear mapping are
> currently marked as fully accessible.
> Since stack corruption issues can cause some very gnarly errors, let's be
> extra careful and tell KASAN to forbid accesses to stack memory through the
> linear mapping.
>
> Signed-off-by: Jann Horn <jannh@google.com>

@akpm please remove this one from your tree for now, it's unlikely to
work at least for now because there's code like cifs_sg_set_buf()
