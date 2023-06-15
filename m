Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C277318DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244762AbjFOMWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbjFOMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:21:58 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BBD3AA5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:19:48 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39c84863e34so5263390b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686831585; x=1689423585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yc998ofQCHm70AwB7NGDYCaKxTBU0pzjXhl26vDvsJg=;
        b=W5d2iaL0xLxeTxydjWXF/LUkWcB/DdME8rnY19xiPLLyXug+kQYXQPe/1xBvvUiyUL
         MDxrbStEySHhARpOzmwUg+F5Q2OP8vCQdv4S6h+pRMFyW6U3zOAmVl6UN20qTK45mEiR
         4uk8P65+2dAeaTwNFiYoq0siRRmkKMd8EqgPY5BTI4oDiQCa64+1lBg5G9JtT2E+Gk5c
         RGnEsdiVfqgQyXokUdwXfjZStw0poN4oanK5MIn9EcmQXm4wi9q59Of6aMwf7jqQnS7Z
         YYRNZDVqGHC5IW1zlDzi6qJUbbVgpGrfL1h/mFRvyjqS+boTC7XBZOfdZdtXAhSVRX7T
         Uh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831585; x=1689423585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yc998ofQCHm70AwB7NGDYCaKxTBU0pzjXhl26vDvsJg=;
        b=Apx2q4w4k0bOOQNjPJVEgwKIsgrZAUmOZXloXB4Y2UTCNUuu0CZsT+dAADZ4PCLctt
         4ABmArywhC2GDRPR6m0w270PKSi8OK5xZQK7SFskqR8IXRxyPzDUFcsBAFyq/V29Rdj0
         6sE6dP+7Uit0AryRgMSjmv5DOIEHyejgDAmMbe0TIx0aCgPnB9JsTMJWAG+NjKxaiZJn
         F65U+Uu6unjcnCA6qnS7Gb0s+yUuR5l0mi+OpCMSZbNjiqoGyG4grrT3dJQP6bBz8vOj
         Psx/C1oi76E1QFAip6/WF+f01jUYoirx4ZPrWlXVySQD+5T1CSeFNm77oxiBMn3WBptw
         VYXA==
X-Gm-Message-State: AC+VfDyVNORSJBErz4w10HIJsDCNrhY4mQTGiS/yuXgaGkxT+GJ83LmM
        +ywKXK7ihS8wo3fbwjA5WoKidTp9wyKbrHgFkaDhtg==
X-Google-Smtp-Source: ACHHUZ5WrmIJVbfZZcCG2r7Hjk+HLMRYL17VSgdmiezx6+vZa6lm8dDBphUk9F5+TRLkeL945yAf9jL+ydR7FGueous=
X-Received: by 2002:a54:4403:0:b0:39d:adbe:fa29 with SMTP id
 k3-20020a544403000000b0039dadbefa29mr6796163oiw.4.1686831585566; Thu, 15 Jun
 2023 05:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <d9b22eaa-00a1-6c5c-99a0-126b085f7cb0@redhat.com> <CACSyD1NxcYn_Uy2DUk1ywSyWsxFzq4H+poaWvF55SZZz5W-uRw@mail.gmail.com>
 <3f54542e-235b-8456-f13f-786d21c6c14f@redhat.com>
In-Reply-To: <3f54542e-235b-8456-f13f-786d21c6c14f@redhat.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 15 Jun 2023 20:19:33 +0800
Message-ID: <CACSyD1OxAMowHTE7KnL8nac_-=Vp4eyO00oyMLFo0qcEHx33GA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     David Hildenbrand <david@redhat.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Thu, Jun 15, 2023 at 7:19=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> Yes, but my point is that there are cases where the pages you get are
> not charged. zram_bvec_write_partial() is just one such example that
> highlights the issue.

Sorry ,I got it.

>
> --
> Cheers,
>
> David / dhildenb
>
