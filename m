Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33616E9C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjDTTic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjDTTi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:38:29 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576E42137
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:38:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3e0965f70ecso905771cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682019507; x=1684611507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbkXWBpwVxhf9T5z1cj4mwmJl7+Xdft765BvQGmNJoc=;
        b=Ciz/t1cEtCUCOm5soArFZ936T3/SUb8VLB6c5P8LGdbu6vVDAjL9VlEeJbi2ziuhxy
         C3vmNugZAc+x8atgpej6AYWTbg/CH71jBJ0GUVSsktziCLpabOw7/zqEc+skmTFrOO+i
         ZotbQR6QLIGThfZYmTQOsHIcM4IBzEj1DPNrJDhEruo8QA3xEDRWU0solT/rU2BAY/yV
         85SiFvDILk1jQ3JOtF5iesWxvT/b7C3s8OyqovZ33BteZR/RTUJDUejNm5BY5J1b+QCh
         LqVHQd2X9sSBfcuCGaWZZ5VX5RmRRr6etLFaH8HToHo6sDWVSQ8xu7PDiyXLRdFEokvw
         TciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682019507; x=1684611507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbkXWBpwVxhf9T5z1cj4mwmJl7+Xdft765BvQGmNJoc=;
        b=gwHO36ioFllCeapLPQkEl/ppvpMTOztCIHhJzsszVZYK2H/OmZGz+JAm83iiV/jVM5
         kzZhrgRI1WKm+KoCv22yeJdGXAauASmlamOo8o5lxsWwBPS6AKh71zB9JW+OKXH/6CK1
         1MrcDKzSQ5jnvuHVTbV8BxBlDEzKMqUFcqQ160viUpVLp55BglNfYXsBFwosOCk8zD9b
         R2lSgkvSo3MfBphZDfxWAmWIfqpocKfNQeJR8+t7qbWYMyiZnNIYqZYHey7rB8aJvMq3
         A9BskdD4ZFfTeqRml11x0mwMb4tlALa0LRWftD4tkU+rMNsv5S6OnzDy9EAjwBvUpK2X
         TRhA==
X-Gm-Message-State: AAQBX9eSw00AdwL+UGguqp5nZ9C/+ykVy3L+37gZo4qe4O/IIb+vSKTt
        RRq241dX4RG+y1PArk1prPjIJ4YOgT6LJdL//07+Xg==
X-Google-Smtp-Source: AKy350abRG/tf4z4pattUwmk/F2Ixto8fxjoWPcUpuCUwzt1ET28kNEYXAvB43l6rGnhhp3YHPvNlcprP6JiHQXpUXM=
X-Received: by 2002:a05:622a:1102:b0:3bf:e4e0:26a0 with SMTP id
 e2-20020a05622a110200b003bfe4e026a0mr56484qty.14.1682019507455; Thu, 20 Apr
 2023 12:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com> <20230403220337.443510-5-yosryahmed@google.com>
In-Reply-To: <20230403220337.443510-5-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Apr 2023 12:38:16 -0700
Message-ID: <CALvZod6wiCzpbCOtR06vGXy+gb6adC8RCkXfsRjC-N8yJorGWg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 4/5] memcg: remove mem_cgroup_flush_stats_atomic()
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> Previous patches removed all callers of mem_cgroup_flush_stats_atomic().
> Remove the function and simplify the code.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
