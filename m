Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D074FF11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjGLGL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjGLGL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:11:57 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB314E5C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:11:55 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-403b622101bso126871cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689142315; x=1691734315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrGHgglfwGrgh7FYNVEweHpZMR82hfbCpWVT0KBfOsc=;
        b=ITbIfnQk+hD0KIEfLfwUg4C6F8l1oxCLE4yZyscG2G+VI1VOGHRoB+8VAJWgjzMp5w
         hfa7vNrtBV8f1ilXyzxRNSPmE6NTaALu+s9DzGnygEVD0zxDgOHF2jNuGBYT8cqlLctW
         sZBsut6qGibWPEoEidra78dnvBAKtjVWCQhQZ7w2726hh0C89ZNob+wDM2Bv8NALyYqx
         ItMQnYr3WYfTpGxxCA+5eI5WzLVIKVivUxECPS8LfamLWPm0q6IDeI3sDKNybYBq047z
         KeTEgSZGZiUrjlUGBusSkFX7268X25kxnk3XPUOln+O9+Ia6wGBgkc4SaQorIQJYMG3Y
         dcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689142315; x=1691734315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrGHgglfwGrgh7FYNVEweHpZMR82hfbCpWVT0KBfOsc=;
        b=lTcRG8iZwLLD2tSNvxi4DZMcxyMwvFglttMC71XEygAyEwzhZMZg3h8uRgy4Fc6weI
         qC7oouyaILs1bGXcsxXRdgqUbg+CkCzH2hF6jHQpEkktaGS6PBpNgrbDhSraarAyYbfP
         e1pxB/uABjtcLISgHwMfi2bNt3KDptOsf7wMqcltkPxFYJhE2P07GFRrzQ/rJhVJ4uRR
         trM2RzrewzD6OsA4mAiMZzxYeejU6rsMEGbbVJ1KjA771C/oAYjemlVWOZcYxShpOXlh
         8F/DEVeye9iO3TFM3Hsq9S35igW7VYO56bFmpcuUSq3YxFlVSFe7S37aHvWKVif9lYh3
         6tgA==
X-Gm-Message-State: ABy/qLa/YhwFAyBJLEKd+SVoUv6QRFVd78W1a8OiYVAV3iKbak7BctVs
        6flnMVjgjEFQpunugvhK7joMC4/WfSLCFY6Xk6WX2Q==
X-Google-Smtp-Source: APBJJlE3vJGRpqLVCvUVqssyvL1LScCglLd1wC+w3KiAEeY4+oXePy2JYWwLJ4Qgd5k3+XA2FjGu9skmwv30WyJX4f4=
X-Received: by 2002:ac8:7f11:0:b0:3f6:97b4:1a4d with SMTP id
 f17-20020ac87f11000000b003f697b41a4dmr104943qtk.23.1689142315032; Tue, 11 Jul
 2023 23:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com> <20230712060144.3006358-2-fengwei.yin@intel.com>
In-Reply-To: <20230712060144.3006358-2-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 12 Jul 2023 00:11:18 -0600
Message-ID: <CAOUHufbea7c+ro=dv+K4kO73EQUPfwmCedXUurrXYcEn=_WpPg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] mm: add functions folio_in_range() and folio_within_vma()
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:01=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com=
> wrote:
>
> It will be used to check whether the folio is mapped to specific
> VMA and whether the mapping address of folio is in the range.
>
> Also a helper function folio_within_vma() to check whether folio
> is in the range of vma based on folio_in_range().
>
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>

Reviewed-by: Yu Zhao <yuzhao@google.com>
