Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057AC731995
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjFONKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245328AbjFONJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:09:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667CB2707
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:09:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666933f66cfso655990b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686834568; x=1689426568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUROAgBeshgdiJp+vkELQl3KTeabw54ZXtzj3ZlDMXg=;
        b=VZ08EIE86uf0kQRin3iWcQI+HTTNpM4k5NORwuVSzor+ywrVzokQPvuN90/58JG3Ky
         zulxC+X76nd8eOJva50s8HlOuZwlnEnp6OKIVB4woFzYJD5L39NOqAwclB/ISYfEQkk4
         sK3Jp4npS99v9RsupdjO1rc9e5O7R/iwCcVq3uBNSpSga6gLNWEYdxazSZ+ptQ8kNju0
         tkctVcbhN9mlpGzxfHXihAojmuujo/WVGEFOwhaIJne/m7H/jMA9oC7EcX+DUtBr0zVl
         tUDxMdh7YIN1/FTW3fP4M7jyGz9BBSwPsWT1SxI1rtkRGeIAl7R2sayoNZHQCkYX49u2
         tqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834568; x=1689426568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUROAgBeshgdiJp+vkELQl3KTeabw54ZXtzj3ZlDMXg=;
        b=hA95vJd29vv2n3tLITD6bGB28j/u8OwI+A5FlXjYjnsoLSEhiIxBcIgYtLm5owqcYS
         fR08TXoY/cQo3tgRSy9HtqshMyL+GBg7pwknYZHL76pLKzYUorfhX6CPQOSFQWc763oi
         /0qN5iiP/V6ojHTRAKRGwFsFMKy9fw3LZas6XVPwfn5LbTX5bywTqU+GtDFBmjQ5jXE0
         KXtWtTv6wmPd3U3ERkCaIu8lCmRrZfLZWC0NA/rfpAOY7991t6zmbg0VCLa5Xp4qzQUC
         ZBfS5YXaxWmGtyXlNBKMnST++TbnyVueruY2coQM7To6iwp3E2l2ouZvAzyEZzUDfRuV
         pXQw==
X-Gm-Message-State: AC+VfDxRFwCdJPhPmm9sHrYz6P6AbzZyTsD4OiZcJMnc32bZjrsiL2YX
        /7zba6e/cCTpyLucr3t47WXauhXToQwjgf1jYUF3AzkUfdsB2CMhqWo=
X-Google-Smtp-Source: ACHHUZ5C6FhXdMxKSPBM4310iZdAeCeYilPOa98ys57+ZB94IVGz2Owi5H5jWX7YlPLVXK2MyQhueEi1OB+gKFLDV8w=
X-Received: by 2002:a17:90a:c7c4:b0:25b:e4ac:98ac with SMTP id
 gf4-20020a17090ac7c400b0025be4ac98acmr4246384pjb.17.1686834567869; Thu, 15
 Jun 2023 06:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <ZIrbar9yQ6EZ217t@dhcp22.suse.cz> <CACSyD1Pz0SHOZ-aMr6NQ7vX5iNuhUUEnH=iysR49uxo=mbfN=Q@mail.gmail.com>
 <ZIsBM06ZJSbB+bXz@dhcp22.suse.cz>
In-Reply-To: <ZIsBM06ZJSbB+bXz@dhcp22.suse.cz>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 15 Jun 2023 21:09:16 +0800
Message-ID: <CACSyD1O5FZs5H7EFb58n=-MhiXPpOXXPP_+zVVo5nj1cm5ccoA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me check I understand. This patch on its own doesn't really do
> anything. You need the zs_malloc support implemented in patch 3 for this
> to have any effect. Even with that in place the zs_malloc doesn't follow
> the __GFP_ACCOUNT scheme we use for allocation tracking. Correct?
>

Yes=EF=BC=8C I will use it on next version.

> I do not think this is answering my question. Or maybe I just
> misunderstand. Let me try again. Say you have a memcg under hard limit
> pressure so any further charge is going to fail. How can you reasonably
> implement zram back swapout if the memory is charged?
>

Sorry, let me try to explain again. I have a memcg under hard limit pressur=
e.
Any  further charge will  try to free memory and swapout to zram back which
is compressed and stored data in memory.so any further charge is not going
to fail. The charged memory is swapout to compressed memory step by
step, but the compressed memory is not charged to the original memcgroup.
So, Actual memory usage is already greater than the hard limit in some case=
s.
This pachset will charge the compressed memory to the original memcg,
limited by memory.max

> --
> Michal Hocko
> SUSE Labs
