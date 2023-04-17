Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB236E47A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjDQM0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjDQM0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:26:19 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F374359C9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:25:47 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id l13so1890592uan.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681734346; x=1684326346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JixgYwWa7BlwqObsT/AUW3SuD9EHVR6lIpoIyDwEkmE=;
        b=4IYfU7fwDiuPdzxLCN2I/e6xbtjRLi668VfHNAbGrpuvaCbU3r06w3i2X5ot65D9hs
         7EVQDvwfdcaWIDuH/oO3qBQL9Cf+gxlE5QFCEDnnSI3K4GdqPO8qBxpW0XBoIzG5lEd4
         IbFyMIlWJwaa4KISUiTaZK/++rwZqyf1Wz2QMXR0KC4wkuObu01yidELPdTK6zk9Nnjh
         9kBSbhlwNmGeCoZRn+AIuvbILqxRKgfzbzQkOpSdaQ41EAHosIpEGjU5TCi5sHiQFokM
         ZbPgdQyvIrDsHlhaK/UAqjUJtCLMy/ppUyH/evfQT55AXm+o/9MnepdyjH3kezRlJjvQ
         Y7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681734346; x=1684326346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JixgYwWa7BlwqObsT/AUW3SuD9EHVR6lIpoIyDwEkmE=;
        b=DR8RtFAB8oMCawVFfToDUBsdepyDB6sfp4BcTAHjP311LMb3XZ3rBHBAEpTXeCccvh
         LMqf0eOiMpIRl6yHObVh3RLTOx+DUelG9DQdtJPZJYYkznlTWl9dAQ1oPV7k3B/YnejB
         jRZXU6LOphi2QDv3Mrgno6wKq1zGK2VdD7lHwFt/QP7OPa8OclyQwdAXlgMIMftrQPQH
         OoWeaYevYGoSPiEKku5/LwJqk0UYboOUiWO4D2jfvq+oAMcRQk0WIYyrbbs6AilRsiLd
         hmKg16t5Geu5q+IixTLD8kBZquuya681QfaSFvUohsR3I9mf+ufLTjBJPn7UKcW92gMR
         H2OQ==
X-Gm-Message-State: AAQBX9fL87pr7qDvvEfkRiZ7yo9F8B0TDJS4qH0nd8hAe3wxys0Qpcdm
        6zSqFFn0ReXhhoZ5gcCA6+ZldLgJIE51wxLchZv4Aw==
X-Google-Smtp-Source: AKy350bRvGIdVkXV8vicmzwnEjTbHvNshy1BhmtYdaaUpqxWSbFvgngFPg/FxxPLXppuJD9GgPEIq9oBGrVGNzVaWOU=
X-Received: by 2002:a1f:c682:0:b0:440:4938:fe24 with SMTP id
 w124-20020a1fc682000000b004404938fe24mr4010877vkf.13.1681734346378; Mon, 17
 Apr 2023 05:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230413100859.1492323-1-quic_pkondeti@quicinc.com> <20230415065808.GI25053@google.com>
In-Reply-To: <20230415065808.GI25053@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 17 Apr 2023 14:25:10 +0200
Message-ID: <CAG_fn=VEdPHopbJgip97uD48sW6OX7MOh4L671dTxuc_rG1gRw@mail.gmail.com>
Subject: Re: [PATCH] printk: Export console trace point for kcsan/kasan/kfence/kmsan
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Sat, Apr 15, 2023 at 8:58=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/04/13 15:38), Pavankumar Kondeti wrote:
> > The console tracepoint is used by kcsan/kasan/kfence/kmsan test
> > modules. Since this tracepoint is not exported, these modules iterate
> > over all available tracepoints to find the console trace point.
> > Export the trace point so that it can be directly used.
> >
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org> # printk
Reviewed-by: Alexander Potapenko <glider@google.com>
