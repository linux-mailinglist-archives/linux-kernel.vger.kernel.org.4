Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2EA682A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjAaKYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAaKYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:24:53 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784113F2BE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:24:50 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id 6so4462653vko.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FW/XV0xd0Zhp+J2b4xgsonMeFUqp3Uw446N0MlnvYG4=;
        b=pPJJYCFJwQ+UvR/Q4UztWVqoNYLprOBxiGcjXgglvghDXj0JjCIFY8QwSpOMHtL6De
         hJmrQk+4pTSvLFu40wWmmwVje6Hr/WSABWo06LHWUm3ZsEwq15u64jboULJiRFoKtpa6
         tS0pwwds2U/VVd02J4qtIu9N3PthcGB118NaDSdhFnRGJuHW02cBZMAfkSf8nRpPK7zE
         nt+YFuwnUbIjxRq9N7cpc+lrj1khohxa+l7HPZTHJ66YDrkyXidg/EZD50le2iDS/7AQ
         uG/LvOTteClENKKC2p4PYE80vpR+Fa9Vr8xHqkJ6N4f7viAtFKXAyXlqBTDug22jkfz+
         9HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FW/XV0xd0Zhp+J2b4xgsonMeFUqp3Uw446N0MlnvYG4=;
        b=ati9JuBTVAnzSP2qq/dGdJ8fHM0EfVJD+cY4vYCrMkexti4ZuCIZDZFTyRUA8fjLaZ
         7TQ+6BZFb+GjbDrWMH+91MTR0hFP4pg5FLsNoToRTfLLETsSh0PAMWGIBT5mRsHJvQXH
         MlnzKOvsemKWB302qO5m0WvR57fNhwpnfoALlrxTgPWc0dTG0EmEUp6MiSCxxmV0GSfc
         EmOy0liy/2pLJaSC5ZznYmaKKFDhlr1ZYkmmuVdQh6a2gkLm6GeXSugEIWS8LxiUF+9f
         /Dmoixcv/RyONR1hiZgd59g1zD/QD93HAII3Ay/13IRALhmeHVcgslrSzEBB03RfrJHn
         ubsQ==
X-Gm-Message-State: AO0yUKUNU3ZZYZXq0nAWzHBIqeMn432g5+pFy4XBf6osuQGRhJ5iClor
        syImGSEWyMzN7j/JYFdvGNZmNE1nsF3YwRI1Sj+Tgw==
X-Google-Smtp-Source: AK7set+hXB5bQ6Y+1PkiRvDS+1iRabXHq/FsvakWNENm4DdboMdC0MjJyY6XrgsFVoPJmX6tZqoB568t9ZD6icM1Y6I=
X-Received: by 2002:a1f:a2c3:0:b0:3ea:4830:a019 with SMTP id
 l186-20020a1fa2c3000000b003ea4830a019mr892642vke.9.1675160689238; Tue, 31 Jan
 2023 02:24:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <3600069e0b0b3df602999ec8a2d4fc14fcc56a01.1675111415.git.andreyknvl@google.com>
In-Reply-To: <3600069e0b0b3df602999ec8a2d4fc14fcc56a01.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 11:24:13 +0100
Message-ID: <CAG_fn=VwsMC-Ddo3WViQOBMw-W4PNGMRAguNP3OMmQG7s45qEA@mail.gmail.com>
Subject: Re: [PATCH 03/18] lib/stackdepot: use pr_fmt to define message format
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 9:49 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Use pr_fmt to define the format for printing stack depot messages instead
> of duplicating the "Stack Depot" prefix in each message.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
