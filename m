Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011D56C6E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCWRKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:10:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2800C2057F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:10:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h17so21384549wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679591443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ARKGyVORNEzTzApmH9YUf3ujPzY/5DZ+gpIgKFoWbg=;
        b=BMDkJRyM3q4y+sOHp+ZLvNxbGpVtiEhpSngc1kRoGiusOpbUQfK2AcWnIrDuqBzzW/
         qJWmzGXYUKcwTWUkXQr6uSAqXS8UJgTaiB85f3HU85NkFpoMoDXF0oYRoNPmavdPWwQa
         Ri0fmCcPmm/gxDhdjb3Ec7zVXExAqBw+NPQa4xy+LWjsakonWDdlDRj6+zkhenPFA8Wa
         qjY3AWlPUp4xfdpE3HNGq8ACvlPL4ApkKM2d5AYZo+LXR5jn3z2ilUI0iozZvWQqZoKu
         yW093KRG5fXfx+CsjLW5eO9R4voechOTgUOS+6m70vNgjwp0PPJtLRHKM2p4EQX11QeI
         LK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679591443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ARKGyVORNEzTzApmH9YUf3ujPzY/5DZ+gpIgKFoWbg=;
        b=EHGNMpxXoSNGvlMnOwSvj+W81b/61m8s1mU3OpFTRjxuLxoxIeXn3u5q6SkFAfiaym
         9tMpsU4Fzke/eKPtEkOp2jE9YlJ7UHh3CV9OySBYHjFP5OCbDg43U1+oy8DkN8OGLamX
         ofC1KzWLaB3PEYsaBtYijliMsGNt3N0G4a0hMjvIE2hDW1m+I9GZDcF/N9KRd5eSLR8V
         FeA7SjAerLvGi/Gsz3B6O9sRevWaQJ2i5DDfTLSuttCw+/vafn4ZBS0imNc51IttYYyL
         LbfksuHT94UluQ7XRjTktspF0dSUIcxzreux4uBvn5s1vjK+9APUQDYIs38wKwAOWntd
         x7Wg==
X-Gm-Message-State: AAQBX9cVLm0MxhuYQWccv2cS6TS9LOrr0CO21IQ6csnFm4uzQTdZ0UiY
        IpAA5dhD4+JgfyfgaLiKtKg=
X-Google-Smtp-Source: AKy350ZBXLmeGvWvs18CkEmeE170/L0w+h88X2qJcPw0fbSVm869qMQyxQTBY40Z//n19kM//yk90Q==
X-Received: by 2002:adf:e949:0:b0:2ce:ae49:5edb with SMTP id m9-20020adfe949000000b002ceae495edbmr3293272wrn.7.1679591443464;
        Thu, 23 Mar 2023 10:10:43 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id x12-20020a5d650c000000b002c5544b3a69sm16533539wru.89.2023.03.23.10.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:10:42 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:10:42 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH v2 3/4] mm/mmap/vma_merge: extend invariants, avoid
 invalid res, vma
Message-ID: <42cdf022-4a59-4ebc-a756-8fc93a6255ea@lucifer.local>
References: <cover.1679431180.git.lstoakes@gmail.com>
 <17b6fc3edc46c4b33aa93b9ef17a63a3a76f4b5f.1679431180.git.lstoakes@gmail.com>
 <CGME20230323170046eucas1p2483ab0fcc3d6bc56d4b6d09143bbadda@eucas1p2.samsung.com>
 <a5d567b6-a067-c3e2-e500-e459cf47851f@samsung.com>
 <5f88b7f9-d9f9-44ef-9a74-b338d0ba9895@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f88b7f9-d9f9-44ef-9a74-b338d0ba9895@lucifer.local>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:08:19PM +0000, Lorenzo Stoakes wrote:
> [1]:https://lore.kernel.org/all/over.1679516210.git.lstoakes@gmail.com/

Whoops! Typo - https://lore.kernel.org/all/cover.1679516210.git.lstoakes@gmail.com/

:)
