Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121416DC445
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDJIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDJIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:24:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D930C8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:23:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso3714386pjp.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681115028; x=1683707028;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1W005AayHnSnC0Q+oReD/D5t2+Li6rvV6AQr1B7Tyk=;
        b=bdPG/gHpFLO7zfO27S5nMmHY+VfdcQg0Rg94jRyuweXxzhXMohVKcyLRl2CN9EwVZB
         7csG30jy10quW1ZNPe+n3gb4YsD8c1yolLHAkLtdatUBPuYIe4CzwxyZW5e7PeUJtN1U
         8Xs9ujh0areeiTd/kQ3wYsefuwdGqLb0j+fp7qrgXiRQuBahL1DVv4CorsrTlYyPuM84
         nbIIaBSo/q/WmSGrVU+8/sAtO9zaOTdkZ1DMr+lyr2F5ivegwgPnXbi0lCTPU7FFQAeK
         jNpwNBCaZ+A7l/3nypkc7V6bCUCFxxxOxR00lBG4AUjr/Bk6fstwlwNgWqRgNK8Ynd5i
         Y/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681115028; x=1683707028;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X1W005AayHnSnC0Q+oReD/D5t2+Li6rvV6AQr1B7Tyk=;
        b=VcTOl1VThgWPL9cAUsLDoiSrYTbcflijyis+uwFRFK/I3StKbHU64TH5y0TfUZoj+S
         anF8yLBmYJdDOYqePo+NQXoNi588ApgI4ESAEFIPCLtxyQpyyhV/e7vchAhusl7W0b/a
         V+EDiVjVwEXaBiMEFBvfHXSIuBK6KXmRimYFgvx6G7Or10BF+ew7GJx9CXEbmoKUXu+r
         v8s1d0CrLMX8BtyyPxpgk5nh4UKUOpLnUDQ9lR4HALmobWpqdorAJc93uiDRNuqinc0u
         zq8vNPNZyWeCwBttWVnPU1dT27nuUia0rMmTZ95WcCQcOFPXljNsm4myVCQIbz1rWo8S
         4Skw==
X-Gm-Message-State: AAQBX9eAjgkM5WbtPXrCD/zp6tXixvVU7ovdV2hUkzVNU0yJviE6XYfG
        UVhYJfaQ5fz86FatOFzAstnyOA==
X-Google-Smtp-Source: AKy350YEB+Ka6I6jeIr2IK5nIlbB+75TTNeBj0SufalIOGCjQdxIjZ+U2+9TWGJdo885+jIatimTcQ==
X-Received: by 2002:a17:902:d492:b0:1a6:4c2b:9e7e with SMTP id c18-20020a170902d49200b001a64c2b9e7emr277284plg.64.1681115028272;
        Mon, 10 Apr 2023 01:23:48 -0700 (PDT)
Received: from [10.200.10.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b0019cb534a824sm7219758plb.172.2023.04.10.01.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 01:23:47 -0700 (PDT)
Message-ID: <cd5b6ce1-3c2f-97f5-64c5-4c4c90c40627@bytedance.com>
Date:   Mon, 10 Apr 2023 16:23:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: linux-6.3-rc6/lib/maple_tree.c: Two style issues
To:     David Binderman <dcb314@hotmail.com>
References: <DB6P189MB0568CB290411B23A176511239C959@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maple-tree@lists.infradead.org
In-Reply-To: <DB6P189MB0568CB290411B23A176511239C959@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/10 15:05, David Binderman 写道:
> Hello there,
>
> Static analyser cppcheck says:
>
> 1.
>
> linux-6.3-rc6/lib/maple_tree.c:1951:21: style: Array index 'split' is used before limits check. [arrayIndexThenCheck]
>
> Source code is
>
>          while (((bn->pivot[split] - min) < slot_count - 1) &&
>                 (split < slot_count - 1) && (b_end - split > slot_min))
>
> Suggest move limits check to before use.

Hi,

It should be fine here. The upper bound of split is b_end.
The initial state (split = b_end / 2) must not cross the boundary,
and (b_end - split > slot_min) ensures that it will not cross the 
boundary in the future.

>
> 2.
>
> linux-6.3-rc6/lib/maple_tree.c:3289:11: warning: Size of pointer 'pivs' used instead of size of its data. [pointerSize]
>
> Source code is
>
>             memset(pivs + tmp, 0,
>                     sizeof(unsigned long *) * (max_p - tmp));

It's not good here, I can fix it.

Thanks.

>
> but
>
>      unsigned long *l_pivs, *pivs, gap;
>
> Pointers and long don't have to be the same size. Suggest code rework.
>
> Regards
>
> David Binderman
>
