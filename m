Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE670A496
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 04:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjETCQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 22:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjETCQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 22:16:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FF0E4C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:16:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510d1972d5aso5673724a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684548959; x=1687140959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0gJN167bDqfq0Xjot6aQ2NfScujfQQVtYPukcrFzaM=;
        b=H742rLalEWqjuZIxMMi23m+V5n4cq5iDoDrJFYkx/Gpy3orxRKxFDxwwJ76mf8iZZV
         MhAUK5FDBF/HyrNIFTIVHywiQmaKuE0V6T+muc6Fh1G1a9lIe5YpzQ2b/aTWLt4QHbK6
         Do+RPa+tbatYtEDY6k466XChdw82jehydUj2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684548959; x=1687140959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0gJN167bDqfq0Xjot6aQ2NfScujfQQVtYPukcrFzaM=;
        b=bHVlIvjDiEdgISxeZqfywB7vgcPwJbvpsXxoi7l+GFHfRfvBM5i7ezI9/5wnm1zook
         v6r8qGiZteiUYFW/ohHUsn0Coj1yKD6n8o5SU83EWntyQsvG+08iezpv+ZqXXsLnV2b6
         3iKjVDv4Tj1D2JxXVZJ4hKp+j6tJZolCtkObxfbehdToyVTc6ECCm54O61QGrnNTbRBU
         1CCbTGrDWzc1Y9MBmk5xLLkbhB7ioj4zoljiAcKx4UGsiB/PxgHWBcLAxTsHXJjgzYGb
         grPRzuxbqN4ljSecIyVLzxiE14lQP9MoDlwawcwaGvhvEPjBviObIyrhDwAwryffWkpt
         JPUw==
X-Gm-Message-State: AC+VfDyuEbZPbeEr2hLXSW/3PCQXleeOFfAqODQn2mXpckR3qbtMoDah
        WNZuJRhghipqaQ0wDYw1P2Y9WkuPPuXgkifiNRl10MyG
X-Google-Smtp-Source: ACHHUZ71+MzSj+JgoMo5DbXc1bfIpJvaHvNsKfod/Ic7fNP70WQ6HW8IlzNp19OD2Cu6UwmUSXxIFA==
X-Received: by 2002:a17:907:9955:b0:947:ebd5:c798 with SMTP id kl21-20020a170907995500b00947ebd5c798mr2878796ejc.54.1684548958983;
        Fri, 19 May 2023 19:15:58 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b00965aee5be9asm268534ejp.170.2023.05.19.19.15.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 19:15:57 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-96f7bf29550so153615466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:15:57 -0700 (PDT)
X-Received: by 2002:a17:906:c155:b0:94f:432f:243e with SMTP id
 dp21-20020a170906c15500b0094f432f243emr3325059ejc.14.1684548957398; Fri, 19
 May 2023 19:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230519230741.669-1-beaub@linux.microsoft.com>
In-Reply-To: <20230519230741.669-1-beaub@linux.microsoft.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 19:15:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgi1Cbe0RV0M2Fm1j1LFgC+tFMPEQhUBC1Mtk+3w944uw@mail.gmail.com>
Message-ID: <CAHk-=wgi1Cbe0RV0M2Fm1j1LFgC+tFMPEQhUBC1Mtk+3w944uw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] tracing/user_events: Use non-RCU context for
 enabler writes
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 4:08=E2=80=AFPM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
>
> There was also feedback given that some of the code was confusing and
> needed further comments and field renames, especially for links. I think
> having this feedback will help others contribute to this code easier, so
> I am grouping this into a single series to address this together.

Thanks, added comments and renaming look sane to me,

                 Linus
