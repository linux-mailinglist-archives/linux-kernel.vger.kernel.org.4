Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E165746FD9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGDL03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGDL02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:26:28 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E73B9D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 04:26:26 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-635e6f8bf77so38775446d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688469985; x=1691061985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+FYsDzkb/nFvICaGqtvvOOQLqyeNdtUzCrxo8fodtA=;
        b=onMESjsb0wyIpnpROpY8x6affZkIZT50vMExkUJ2Ka9QyQaeIMLbGfyb0TaAbEKBAI
         CSEGgXa7dj+OgaVRHgWYAvITi78/fSs8yk/dRQ9hwyOgiEcISTb0f7s/G55UJ1mp3Dzs
         2JMVyAbd4WNo4VTqZ+Ck906ZXS3yAyihvqZcyEXLjzCZoFHVx1r+u3nd2l6qyg4+cMGC
         EOtbqSxPr8rMddYeiKVseUsT9yoDbWLdWUSO/e/C0rhOhi4WyXKPGPMxHY7T7VKgayOr
         MyyQzJkbnoqFeyfSPpDEECtQezzTtIaeXtZlq4vvPd0ldq7EWI8mhmD/znqB0EOio5aK
         JmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688469985; x=1691061985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+FYsDzkb/nFvICaGqtvvOOQLqyeNdtUzCrxo8fodtA=;
        b=WHE14+g49lePRra/aGnyeKLusDFhL85T4DkZ7a/u9bqb0l/RXRajd/9LFN846W61dd
         mRXVdgoKN0YPPMnp5UL1kOYOJNUwQ7fFRMAeXL3xYRMeZ+zq5hSqmPl+98af8OogSOxR
         TCf/Y0Racdl6iwyi0WF45Y2VDKFfspbEtwB+0qaAT0X7SIGhckKYPcltsptCiy9sE1o8
         z/xFS4yalVZZjF9Ctp5cqc8VkhHASBCtwF9juUR+8b2CZJUTdM3uWxF1ys71fFi6E9qt
         PK7yNVnkyOWywTi3ULQGHkr2XRENgo3VxBG4Dm2jkcUOz1YBJtYi3Vib5yhyaWH1Q0vX
         Fdxg==
X-Gm-Message-State: ABy/qLa0lpW1TeLigI+PxJg0SP9phfEpslLR2XNN410Sdw4q2qeoas5T
        r4vLQiD2iz4QaX5qlSTxYCAyHFYiYiWE+ro/fAVgEw==
X-Google-Smtp-Source: APBJJlEqqq6kSJ2f6yJBs8PWXcQYXP7KQN6zCsYdIzwvQZqULqbjhUdEg1tQ98Mu/DbxA3el4ExZMYgTa4V5QNSREgY=
X-Received: by 2002:a05:6214:248e:b0:637:10b1:b2c6 with SMTP id
 gi14-20020a056214248e00b0063710b1b2c6mr3842990qvb.44.1688469985506; Tue, 04
 Jul 2023 04:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230703143820.152479-1-matteorizzo@google.com> <abd3f78b-5027-f859-27c8-296108ec8e92@google.com>
In-Reply-To: <abd3f78b-5027-f859-27c8-296108ec8e92@google.com>
From:   Matteo Rizzo <matteorizzo@google.com>
Date:   Tue, 4 Jul 2023 13:26:12 +0200
Message-ID: <CAHKB1wJE+1B_t-NDTPEfw+vGSAe=HFScXEu0riA1-3o8s1GEfA@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: refactor freelist to use custom type
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023 at 22:10, David Rientjes <rientjes@google.com> wrote:
> Seems strange this would only appear for configs without CONFIG_SLUB_TINY.
>
> Since lots of files include linux/slab.h I think this may start to be used
> in non-slab code.  Not sure why it needs to be added to the header file?
>

Thanks for the comments! I think that makes sense. I will move the typedef
to slub.c and move it out of the ifdef (since that also broke the build with
SLUB_TINY).

--
Matteo
