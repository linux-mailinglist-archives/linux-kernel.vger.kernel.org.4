Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D16D8400
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjDEQqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjDEQqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:46:39 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC5910FA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:46:37 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id x8so26528980qvr.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680713196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sa+9pa12UmUjhKyTqLxLSiMluret+wii+CF3J0jK7jk=;
        b=4CVIGLIvD5XLJwF7kKQi4Qu6xgohTeysQzKJaqg+Qf0R/8y2SUap5kOBzjK5w5wPpt
         vsDsY067e9TF/TgevFFX8iGdqvhWcJzoHFq6E/E8beiP4K9Xj6or6ITogC5sF5cf3SkV
         qZ98XMUc6G6iyPcqAmmWcM/9wwax8Zt0oCRemV0vFQuWjGlRBzjU8iAgoFCaPPQbxPLY
         iKzCnLoy9U6n/lMwemanEkiEYoHqEfztlEAR3WJyBhGdZQBKbAEXPQ+8k1vw5qseoeV1
         dx2w3/F/InpnnEHDOZVYQHDmfXJm2Yt9k6fMZ+4Rq7fMSniAJQZihIq86vwRCkj0NTsO
         +oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680713196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa+9pa12UmUjhKyTqLxLSiMluret+wii+CF3J0jK7jk=;
        b=XyXU7PA3zL3VsgHwTH9mFKf6DD5Y3pIwKKjNrhk6rdwexVReVbsihWRbMafAVaQJtQ
         3Xb02BHavOokjVcdv9b+ZTLi8Jv1Dle5i/qWXbySvZx7AdS5Oc8ZhuNaJQwK6ZIL4w1S
         tfUwz6EPFt1PzdkX7l0Tf5XmRuxmLQYn53ZDRa2DTfMQlVkOcUiI9Lx2rFVAeHtH6djJ
         F/N4ZOZUE1HE6AT4MJEDxjaoJv1jxuLnBY5VT5hQRiyYqoX0tEhFu7agVHCKSZwcB9vY
         zPkhQQK28u4F9YOhJZT+4bA745JyPn0pzco41IZC8UU3dywIMwwO+6nQF6MOsLJyHZt1
         CGgg==
X-Gm-Message-State: AAQBX9ehlGVyat9Urt4Q7Zgx4bbmfJg5R+6eqqJ3NGWASno4V8pZivHE
        4Kotrr/V1179D3KjC8cPi7YlyQ==
X-Google-Smtp-Source: AKy350YmvjsKpbOEHLeFrppOJKubNmyQWY5AKJDzEHzgeBB88DMvvWgZC2aUv7q2CJGsyBk/VUkpCg==
X-Received: by 2002:a05:6214:2aa3:b0:572:636d:626a with SMTP id js3-20020a0562142aa300b00572636d626amr3546423qvb.25.1680713196626;
        Wed, 05 Apr 2023 09:46:36 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id q7-20020a37f707000000b0074a05d4c61esm4528147qkj.60.2023.04.05.09.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:46:36 -0700 (PDT)
Date:   Wed, 5 Apr 2023 12:46:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tom Rix <trix@redhat.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/psi: set varaiable psi_cgroups_enabled
 storage-class-specifier to static
Message-ID: <20230405164635.GA31303@cmpxchg.org>
References: <20230405163602.1939400-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405163602.1939400-1-trix@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 12:36:02PM -0400, Tom Rix wrote:
> smatch reports
> kernel/sched/psi.c:143:1: warning: symbol
>   'psi_cgroups_enabled' was not declared. Should it be static?
> 
> This variable is only used in one file so should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
