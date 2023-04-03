Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A136C6D3F99
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjDCI74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjDCI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:59:53 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1745B97
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:59:52 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p15so33831256ybl.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680512392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zZWYuyDzpZNaRiVgD/KXahhQyG8Rw0U/M+C/mTD0fU=;
        b=TB7n4Sll6+wGMCCKJoZHcjmcdlpdf1Buj2PBDZjVt04QPJMT4w9dweZ/4w4mJkHrwm
         RI5xaufgOseCWl4DfM2y8qRHw1TvmN4BOops5/ctjHK2AyK/oFcKeKk3Rxew6GBSyMhF
         AYpYmPfFtf8tzcUq4d+6gFMmhTdUDucOgP2/Eqk2f4bVkzNQCK2eTMs9ViD6lOo6RT6g
         EfR+AW5vEQflq/t39pMcJ0GlkUdavlgNBL8Y5etH8c78uHlOlslRhc92WSDq7SIzukAo
         MuWRkN3E/wxYZaFI0pC5QIMsReLBPWMjXdePEze/kVC+blGdizAUkBAvCF0Y3nX/LV3m
         mviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680512392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zZWYuyDzpZNaRiVgD/KXahhQyG8Rw0U/M+C/mTD0fU=;
        b=syB+mYDTvOI1adwNr5J4oIggiy9QnRxgUWcXA9LRd/Yn9L1Bn+t2z7kxMGJpVhYiGs
         qmtrOpYPdURBL0H3ru8TuA8jO8cZ5U2qKI/A5MryWeNObOhM7171D6GaWUbunYMnFPFI
         UQRyNh5LqdIluIfvdN6XHr5l85yjrbvNqhHNcIMZqgt5DTog6kmooWWlQJaQ+faKJ0sC
         nJIzCKD/j9JW9rIRemfLLRJ59L15K+cSiAfVopUCsBAhS9MluL+krnCbyPYUaepnfYO3
         0OFI1urmOyRJS9fU/ceEYlP47lmv7qfkx5MAv0yzpEZ1rfZsEBxJ0f0AaS3Hhp7gakef
         ycYA==
X-Gm-Message-State: AAQBX9dFhcIc6filgDG10ZfBNabe80fVmwt0ZehzXxj13cti1vuzARga
        VpgItCuu0PFUHV9xDMsuOxSdEgxDZEAAP8IffhciNQ==
X-Google-Smtp-Source: AKy350YhrqtcFCPbK/Bo4aEinktnzvwTH7mhQiGhFbj2JO+Z/NPE1MChVykitzhOF6EyhnllRIB0hi4wqqbieclivNM=
X-Received: by 2002:a25:2d03:0:b0:b61:29e8:e93a with SMTP id
 t3-20020a252d03000000b00b6129e8e93amr35916224ybt.53.1680512391776; Mon, 03
 Apr 2023 01:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230328095807.7014-1-songmuchun@bytedance.com> <20230328095807.7014-5-songmuchun@bytedance.com>
In-Reply-To: <20230328095807.7014-5-songmuchun@bytedance.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 3 Apr 2023 10:59:15 +0200
Message-ID: <CAG_fn=W+WxdRNJVmhm+UUcTxnR204CfGHcNZ2VdxmMid91Mvkw@mail.gmail.com>
Subject: Re: [PATCH 4/6] mm: kfence: remove useless check for CONFIG_KFENCE_NUM_OBJECTS
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        jannh@google.com, sjpark@amazon.de, muchun.song@linux.dev,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:58=E2=80=AFAM Muchun Song <songmuchun@bytedance.=
com> wrote:
>
> The CONFIG_KFENCE_NUM_OBJECTS is limited by kconfig and vary from 1 to
> 65535, so CONFIG_KFENCE_NUM_OBJECTS cannot be equabl to or smaller than

Nit: "equal"

> 0. Removing it to simplify code.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
