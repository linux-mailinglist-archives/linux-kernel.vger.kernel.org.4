Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DD168E6BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBHDoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBHDol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:44:41 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E6140CA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 19:44:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r2so15467880wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 19:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/P34Ea6kcP/xz6Bqj95JLA29Age86Sx+MLI3/fM7his=;
        b=pNNhcWsl+A6QzP8NqoomWh/b1CP0p8ie44Wt5FgtNQOJZpk2/fSPSdjGFjBfxXYu2z
         dKBVMeF/XpsQko502YJnw68XC1HigBQKtJi4l6K4uHKDsRidjlpOHYCTTxBri9hO4wl5
         Ha4PHyJYAP7WH2MBzLq0WlMZlHMShdYlbJtO9ELcVHR3yvchPeDbVkITwt5R6T2F21bp
         G0Z+jmfaP4HXvRXLSoO6yAEM7MdFQaToA1cjYxAQIIPEiUf5nEwmpUHVCdIDqkDonlCj
         8Y4b+4XrjCbTJX5SqQag+Z0YRB0exv/SnW/CkqnrL2iWf6eA8OeNxBFtmbftyIKDLzUv
         LStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/P34Ea6kcP/xz6Bqj95JLA29Age86Sx+MLI3/fM7his=;
        b=vfhMsAFfhxyV5QYs1RjgmspyzTMuwdbLCowoC350yXnMxVxDfqvMPV4kp+9g1vv8BM
         Uu8caMkKoxopT/SrxmydVdaS9KyqHFA2gxebsIbxC4i3BZHyQmYg6lU7KaYNVINsU7Lc
         nZ8ZWzuOWYfXtR8ZNVOHtNtJw4pZ3yscgyw6Ys+aHYodH2T/A5FV5C5JN5q48S91Qoi/
         /0S/GjYI3qo41yiIRNhwPgtVp8Wf3J+4Nm4+IR8/HHBei4PcDUDRShjTnmn/Xod2Sp9f
         eoL/C9J71DP95/mHN2a/gKUlehqL3IF0iI5JrL6ncvtbW04LL208IdfbTsxeLxVpy8Gm
         di+g==
X-Gm-Message-State: AO0yUKVDbD8yLW71HOYXuRTlTHxBe9nrpL1sez2F0PAkZ54r5QuQFONA
        l6ZYFXDtV2oYwVgfEezoAFyBJgDiULTxuRDIi9uKKA==
X-Google-Smtp-Source: AK7set/bXWXj2OBbWZzNpv7zBuiK5jo84QLC6ck27qK+lC8O36jtpEyeKMH7wPdVj1wajuia84kyedW0h72D+r2uSn8=
X-Received: by 2002:a5d:53c4:0:b0:2bf:c336:43ba with SMTP id
 a4-20020a5d53c4000000b002bfc33643bamr187280wrw.698.1675827854784; Tue, 07 Feb
 2023 19:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20230207114456.2304801-1-usama.arif@bytedance.com>
In-Reply-To: <20230207114456.2304801-1-usama.arif@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 8 Feb 2023 11:43:37 +0800
Message-ID: <CAMZfGtWZbBmHgv9hKrYQGuUq9wQ76dwBn+ZuRnRBOvnKRXU=fg@mail.gmail.com>
Subject: Re: [PATCH] docs: mm: Fix number of base pages for 1GB HugeTLB
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 7:45 PM Usama Arif <usama.arif@bytedance.com> wrote:
>
> 1GB HugeTLB page consists of 262144 base pages.
>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Thanks for your fix.

Acked-by: Muchun Song <songmuchun@bytedance.com>
