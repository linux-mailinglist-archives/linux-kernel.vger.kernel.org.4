Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12938747854
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjGDSg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDSg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:36:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEACE10C1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 11:36:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so9183325e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688495785; x=1691087785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qy4FiJ5na+1a1vs3hEYUs2tM9qGS4/nqRqYBYuksHZA=;
        b=UlcfXpZ4Go1oCkEu+TQmFM6QwqPvLiAFWCahXroRUU/NniRyteEAme4dHDvmRR0+Wi
         r4l3JAPHi/XVA6dv+em9KpdrtGVGdG8wyF9uhQBiCBluFReynDPWZPkt9qDKl9mfhFH+
         ij06tU5+qAeIWdb4Fii2sXBHJ0jpP36WO3X3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688495785; x=1691087785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qy4FiJ5na+1a1vs3hEYUs2tM9qGS4/nqRqYBYuksHZA=;
        b=QBfOdX8FykhOwX2QmcimlTf7paZtq5Ua3N5+AOIjHbbnZ+C+OhJ+koQ1+htMYhM2cu
         afNVcS4n6eiF2iVuexlnZUwHlMOOFtT7Kwx0gS0fwuRnGp0vrUaySgGY7Vawp5cdU/F1
         AF27h4knXGiF1WxRI1FiEiDAtCbshQJraxVLpAoX12Z7C48AwVjqQudjslV2IPxjNs0Z
         1SmWxhXlbMCTGEAjEgg0Asy6+PBvU/zoPKapiin1OGRE/K3Sra+L94Vme2S3rAW8sZQ9
         YVrEgLACQmD6J3JcXgO1Mx0TtxqsXm2E6kKG965VuQCZEG/2fheCOoOI1nHR1tgBxU++
         VSaw==
X-Gm-Message-State: ABy/qLY93klHA88Rhl5qo0SX4FNsdNZELJhg3Zdm9TdM9YYKrgQvpDE4
        4+2t+1GJG8UZouYNDeXbIM5Om9J22+82BjpeMJOvAfsB
X-Google-Smtp-Source: APBJJlE+cCfLW0a7T4XYHV/KD0kyrL9S/Y/C/pXRA2hn+CbvjLpmyZiFfhFEUMzt1FtsoJa/1MUTPA==
X-Received: by 2002:a05:6512:2525:b0:4f8:7960:f72 with SMTP id be37-20020a056512252500b004f879600f72mr11513783lfb.44.1688495784813;
        Tue, 04 Jul 2023 11:36:24 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id f10-20020a19ae0a000000b004fb75142020sm4542047lfc.276.2023.07.04.11.36.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 11:36:24 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso9188127e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 11:36:24 -0700 (PDT)
X-Received: by 2002:ac2:5b8b:0:b0:4f8:58f4:b96e with SMTP id
 o11-20020ac25b8b000000b004f858f4b96emr9284617lfn.37.1688495783799; Tue, 04
 Jul 2023 11:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230704182442.1015301-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230704182442.1015301-1-Liam.Howlett@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 11:36:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUp5+tcsHG89ieuwa0wUtSWWBWRt8xOsoZ1nskZbbk-g@mail.gmail.com>
Message-ID: <CAHk-=wjUp5+tcsHG89ieuwa0wUtSWWBWRt8xOsoZ1nskZbbk-g@mail.gmail.com>
Subject: Re: [PATCH] mm/mmap: Clean up validate_mm() calls
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Sang <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 11:25, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> validate_mm() calls are too spread out and duplicated in numerous
> locations.  Also, now that the stack write is done under the write lock,
> it is not necessary to validate the mm prior to write operations.

So while I applied the fixes directly since I was doing all the
write-locking stuff (and asked for the locking cleanup), I'm hoping
these kinds of cleanups will now go back to normal and go through
Andrew.

I do have a question related to the write locking: now that we should
always hold the mmap lock for writing when doing any modifications,
can the "lock_is_held()" assertions be tightened?

Right now it's "any locking", but for actual modification it should
probably be using

     lockdep_is_held_type(mt->ma_external_lock, 1)

but there's just one 'mt_lock_is_held()' function (presumably because
the internal lock is always just a spinlock that doesn't have the
reader/writer distinction).

              Linus
