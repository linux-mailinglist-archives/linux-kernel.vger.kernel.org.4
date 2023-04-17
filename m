Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9756E466D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjDQL2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjDQL1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:27:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA4D4232
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:26:16 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n17so9300519pln.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681730666; x=1684322666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LkCrILb9IuvbZSWvzfLhM66GWJHFdrMr5qCX1S/DkU=;
        b=KbNyF8OBDiZXi97ZYaJA3QSSRzMsa69uKIMSClYQLH6b2Rr0cJ8pwnj2pxQjcxY4x9
         M+UmQ4Fe0QgmEixYvr4iJk85QxnXlY98AysCnXpD9iJGhMBJMaijD+5kQtlsMUJkuSMt
         RoybIcdHz2bg0TbSJH5AGv6Rj7DTOs+TGzjN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681730666; x=1684322666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LkCrILb9IuvbZSWvzfLhM66GWJHFdrMr5qCX1S/DkU=;
        b=Cf/8wsUriYvctCdYWJ0oE5R6OJbOWcgBZEEpPCcQhigOSsmMglcwjvybeZqPtcxZTg
         C9bhjcLGhSkACZahSZpkGqOsewxPxyh5YMZIWHmmPzKafz5yQbs3/yvBvjuKA4XXhrAM
         Kk99JFR72WbEY1FSZdV/qIU3GMJ1QHk6Y1TBnIXAqQyIfS8KtvTGfmg+uLn3T/3R3Hxv
         RBWULhd0q6JhcZjoDAdKrLlFD9oFYCCcrIILBkIeehvCskURo8XuJjnE4ATq9skAM6kS
         HkJjeX7lhGBxbrOREVGV+gYAoZYfkIEYtgurONBakCIcHUhXVdEdkuTJ+YTkmSubNxWn
         RmSg==
X-Gm-Message-State: AAQBX9df4BU+r1Dot4gZWKg1GRPVm287KN+p69l+QVbr5aEFQHChHMmQ
        nLN9YlKQBhzNgfEiKoLVYH2HHQ==
X-Google-Smtp-Source: AKy350YAx4Y+1l34FPHHHgsaRaE74K1JFkgBVWI188vcNGdM6psUQGX2v6zAr/nFWr/Z2VElHDtixg==
X-Received: by 2002:a05:6a20:7aaf:b0:c6:bd82:ea2d with SMTP id u47-20020a056a207aaf00b000c6bd82ea2dmr14773435pzh.2.1681730666125;
        Mon, 17 Apr 2023 04:24:26 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id 142-20020a630494000000b00513955cc174sm6960590pge.47.2023.04.17.04.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 04:24:25 -0700 (PDT)
Date:   Mon, 17 Apr 2023 20:24:21 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <20230417112421.GO25053@google.com>
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
 <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com>
 <20230416151853.GK25053@google.com>
 <CAOUHufZk+dxE8UXWwGzGbX1BYxomD_25u2xoWt3vnoQp4xSZqw@mail.gmail.com>
 <20230417024446.GL25053@google.com>
 <CAOUHufYJtB0n314GnMH1ByXL5PTtzzsrMvi2YbHz2YVqTTcYfA@mail.gmail.com>
 <20230417035232.GM25053@google.com>
 <CAJD7tkZFufCacfu-EeqwhQBYXt8dpea1DYhyDgponjFjdLt5Sw@mail.gmail.com>
 <20230417111243.GN25053@google.com>
 <CAJD7tkah9kx2kAcTY47J2R5p7NYS+b+3A9S_R-hSv9z8OSzzqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkah9kx2kAcTY47J2R5p7NYS+b+3A9S_R-hSv9z8OSzzqA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/17 04:16), Yosry Ahmed wrote:
> > That's a good question to which I don't have an answer. We can list_add()
> > the same zspage twice, unlocking the pool after first list_add() so that
> > another process (including another zs_compact()) can do something to that
> > zspage. The answer is somewhere between these lines, I guess.
> 
> But the first list_add() is (in this case) the correct add, so we
> expect other processes to be able to access the zspage after the first
> list_add() anyway, right?

Correct. Compaction also can unlock pool->lock and schedule() so that
another process can access the source zspage, when compaction gets
scheduled it can attempt putback/unlock the same zspage one more time
(the zspage may not even exist at this point, I assume).
