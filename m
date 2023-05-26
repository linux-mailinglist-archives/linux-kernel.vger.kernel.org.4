Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3E5712D08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243741AbjEZTFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEZTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:05:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E5513D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:05:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d1e96c082so1027130b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685127902; x=1687719902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SAeQ2xMzsERoeM9PeVs0BB2mFGDfR2b9upLxc7DKkI=;
        b=AVVFpfyumrAcUAFk2l9Ratbv9bsaw11PAYDGo6T3IZvy3cYQrAwoQT01W1qnrApGOK
         oABFsf7K+o87TdmzTYPQgTYedlOWmW3p2s+2H+2XuKTFD9MUK0v6UxwH/z7PcuqMjNeO
         Mi+g8XRtj05iJjOqgqN+fHct+fTVCbzw17Bso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685127902; x=1687719902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SAeQ2xMzsERoeM9PeVs0BB2mFGDfR2b9upLxc7DKkI=;
        b=XXAgfC3Fcnotx8L3oVkciAFMf1YPccczX9zTmnkGHLlFXD4FEcouT7LCbkVzUJSsNV
         8Z/AZjQ05DStS/KxLclFiF36RdoGMSnl2bm6S+08J6iP33ZuBaRx7vDNsxvFAluReElO
         Yv918/Q7NHQzR9FMxQxsu8VOGMlgjutvv4iUEMK5PbQzfd/FpJRErWVDmghZ9bD9hZHn
         W5BAx81JiKM5ZYDx7dcf/Ug5E0oH5TLqQSRLrWTwZBEsrtI0nU3p8CXTiTGQfsaBUMPv
         U4ZrwJXJtPTcfXYgsQJJMDOAqLHSHirNf3evf2XXelU//eVf8mJrFQejkF6NhelqDAe1
         jd+Q==
X-Gm-Message-State: AC+VfDxoVhQ2yHJmCOqWIhf+m8GutaBT7EK76udGx90MgO7xQhjdkgcM
        1GY+g3Z6mxx0FFO3SAXZUtsebG2HFB6ByTw9zZ5ReA==
X-Google-Smtp-Source: ACHHUZ7hETaDyIP/AquuzMzsvZqXmXkcXAMHkRrdZ9WMX6jPPnI13s0UvIqhbe5ejE8JxL34iakcftJhPiaZy/8pZoo=
X-Received: by 2002:a05:6a20:938e:b0:104:d82a:63c5 with SMTP id
 x14-20020a056a20938e00b00104d82a63c5mr302697pzh.53.1685127902268; Fri, 26 May
 2023 12:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230517150321.2890206-1-revest@chromium.org> <20230517150321.2890206-4-revest@chromium.org>
 <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com> <884d131bbc28ebfa0b729176e6415269@ispras.ru>
 <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com> <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
 <c63053b0-5797-504d-7896-c86271b64162@redhat.com> <7c572622c0d8e283fc880fe3f4ffac27@ispras.ru>
 <c3530ffb-c004-98cd-2651-280c391aca92@redhat.com>
In-Reply-To: <c3530ffb-c004-98cd-2651-280c391aca92@redhat.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 26 May 2023 21:04:51 +0200
Message-ID: <CABRcYmJSNqbe-GexfgJNULNWSs5Msmp1O+rThy_D6baGXvKt-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexey Izbyshev <izbyshev@ispras.ru>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        peterx@redhat.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 4:10=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> I'm easily confused by such (va_args) things, so sorry for the dummy
> >> questions.
> >
> > This stuff *is* confusing, and note that Linux man pages don't even tel=
l
> > that prctl() is actually declared as a variadic function (and for
> > ptrace() this is mentioned only in the notes, but not in its signature)=
.
>
> Agreed, that's easy to miss (and probably many people missed it).
>
>
> Anyhow, for this patch as is (although it feels like drops in the ocean
> after our discussion)
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks everyone for the review and the exchange ! :)
