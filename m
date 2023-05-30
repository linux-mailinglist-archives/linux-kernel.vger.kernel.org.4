Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D3B71619D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjE3NXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjE3NXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:23:01 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B1E5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:22:59 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6af9dcc98f0so3462882a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1685452979; x=1688044979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MaKm3OkrYm3ffEnUF3bIEtKrMYvCJUWRE4ejQF6bOxM=;
        b=kE5ti0X/mrift+8Pf9KI2pGnO3Xw60WttWdj3ssey2ROTgCl2bG/e1Y8b1ZQHGjt3c
         Ks+Ek6ey5qwEyjBaxPenK7cHfsrC6bg44+eg9N3dOdV5yQzmLlq6FBhpTnQ6YHYc9G0h
         XFuPiDqBlhUldoZQ3GwUu7i5G0mHsqxtYEx0Jr6OV39FLZJpL04fd4HduismrxyxhLMT
         Pn7rIdeO6hQc5iEaEBSuST+M/3AdznuzNFI2AaKsJu5bZds1f2Z9msBoVLpAoOYO3iK2
         yQm/gukhtbAkftMgVZRC9orGD5y6H5eLTuBV3jr2TlIQ9Y1a4eGt7LmVkeDJMOENaq4i
         E5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452979; x=1688044979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaKm3OkrYm3ffEnUF3bIEtKrMYvCJUWRE4ejQF6bOxM=;
        b=kJVQY1BhOycpvtsc27K8zRSimiFJzJKi7c41+hcalhmO3dFln0Zy6CFlcKNjXRcKll
         qdgYBYYOLWZJyeOOOYW4Q7enZ4Apl7UhoonjqoUk++DwR5eNmfNVQSjaLVg1ccbqXDPj
         Oj5yjuWHeTAdHZ8WE45msQwSwHm5ChBcy2cpL2yZwQp9Az+3RnOLXy+uyZu11WYB8MkT
         f70DEXSPqDz4WwgIXyaYhxp3BLjX7YpNot2DhEsxp1Dlpb018MhDyMK/k0atKjS0PTet
         JtBFd+R1HLa769KiRoklpUj8MGBRSgG2F362a7lHTnQaF8EITuc2ZSoWl2HohiyhY9AB
         WxkA==
X-Gm-Message-State: AC+VfDzufJm2BSHbCe1LjxMj/dD5PxXR0BP8uqCK8xNYx7ImZKqT2sVx
        CAzaZag6t/WK/LHU7JI010vIVOiH9noQ6DvvybAZGA==
X-Google-Smtp-Source: ACHHUZ67RbR3lr9W+CdbQTIvItTYn0BF1JkwzV5z5qMEIWe12DhLoZzVrl7NU81GngciN/LqEorqqTTtGAZA9zL2cc0=
X-Received: by 2002:a05:6830:1e6c:b0:69f:7b9b:473e with SMTP id
 m12-20020a0568301e6c00b0069f7b9b473emr909908otr.38.1685452978924; Tue, 30 May
 2023 06:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230526145519.2282062-1-vineeth@bitbyteword.org>
 <20230526172959.5440b9dd@nowhere> <CAO7JXPgLFgXANqXY7L-YLbijxJCOgUKmd8nUQizb62JorOXGhA@mail.gmail.com>
 <CAO7JXPit6snFM2oW-uSs-mtbmKr9wpbX2exqAUF0iAiaAO6hOg@mail.gmail.com>
 <CAO7JXPgf9ffVQ3n9iD8-1abuDSAZHWAZmz56BmM68uJZ7uy+Uw@mail.gmail.com> <e9ea284d-3a8b-b9ef-d179-b67628771bf4@redhat.com>
In-Reply-To: <e9ea284d-3a8b-b9ef-d179-b67628771bf4@redhat.com>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Tue, 30 May 2023 09:22:48 -0400
Message-ID: <CAO7JXPjn1AKMsngPi_LMPEhN0=+eV-L+HCM3SqC=fTcteQFZZQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/deadline: Fix bandwidth reclaim equation in GRUB
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, luca abeni <luca.abeni@santannapisa.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 5/26/23 18:15, Vineeth Remanan Pillai wrote:
> > I have just sent the fix as a reply to the initial patch. I shall send a
> > v5 if needed. Please let me know.
>
> Please, send a v5... so we avoid mixing up patches on testing.
>
Sure, Will send it soon..

Thanks,
Vineeth
