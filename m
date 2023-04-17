Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ECA6E3EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDQFME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDQFMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:12:03 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B371A1FE0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 22:12:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f08b6a9f8aso193155e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 22:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681708320; x=1684300320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5Uk56C6DT5KlXwsZ4KgVtCuJ4XRmcd1m+BGuekOmdg=;
        b=sbbYR02ud5+dC3KqyMkFu+ghbJ0ICpy1eSRCoQaC+vaTbba4vt91fwth7ksiyrhCZ+
         RRO41MlFY2ysg7kZFSp/Bd1g1kShqhyeZJshill8IAFHjTiK3RStFS/hXOynHJX3A8Sv
         piWf0XVwGjF7ehJI3Z8jo3b0K4vs3+3Nb3MrDsNB+PmlsdTyOJT3Dq0Hm4l7TNdbOa11
         ye83LsNeQdaUIXzclQCxZciNeQB5t2CZgzBsj8BOcfBtGzi9xY4BQD/5vj4XpU6Pj9y1
         kyfqUEA4Y9QNal+FzlKtlyv5Iz0TpNiyrMBNT7HNj3+FZW2xSaxo736uNBafB3jWXrpd
         gijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681708320; x=1684300320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5Uk56C6DT5KlXwsZ4KgVtCuJ4XRmcd1m+BGuekOmdg=;
        b=fPTqHPfs2aW7JYOF/3y1/lact1IHAVyOWKy2jmqLm61YqkHtYyfO5cnb3Uy+RctP9y
         fN/U0KkDMYGknB27dfEdQe5huLvI4veerl2Xii6j1Khf4iN/FeSnt8UOimm+H1ZiaFFa
         V649nqmnZhiw9u53Qi50oFEr/7quFNRk8KwPpgm3EnCx6F9WdK/cyIaiwVptWPgaQsfP
         yTQDO+Fitmt+ZUPYNgQV2RXCm10ZzSCUl5cqCXO8ow0Rn7NAgDkWfX53RICea04aN7Zv
         Nf2UQyXBgOkdes5na3x4n+7pcIUIszOqKlabKI1Jfny4Dvwo4ZxQH2o3hl+XhA55+UII
         eeCg==
X-Gm-Message-State: AAQBX9eCSVrSn6AmtJvb4erBxzjZzf28XDzCX1gKRy1UqYj4f72E8aNZ
        zd17LBAYaPcQqvPorvZRU6uiZJhSbAWM0UrDshqYAw==
X-Google-Smtp-Source: AKy350bBkpp+POU4o4Bf2hOFFCGKuoLq3jtew+Y9VwoDnDaUDsJPyaF/YavSC63jOF3tVtfQV6+hQ2L77pbCRlJWjmQ=
X-Received: by 2002:a05:600c:3512:b0:3f0:aeef:e2da with SMTP id
 h18-20020a05600c351200b003f0aeefe2damr409954wmq.3.1681708320158; Sun, 16 Apr
 2023 22:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230304034835.2082479-4-senozhatsky@chromium.org> <20230417050140.1653593-1-senozhatsky@chromium.org>
In-Reply-To: <20230417050140.1653593-1-senozhatsky@chromium.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 16 Apr 2023 23:11:23 -0600
Message-ID: <CAOUHufY0YTJDnnjuCSKnRJx_HjYEvpNPHMG+reyhN3Fhjz+3Gg@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: reset compaction source zspage pointer after putback_zspage()
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Sun, Apr 16, 2023 at 11:01=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Fixup.
>
> Reported-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Tested-by: Yu Zhao <yuzhao@google.com>
