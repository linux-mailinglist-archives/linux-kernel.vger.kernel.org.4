Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1950B717129
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjE3XAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjE3XAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:00:53 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C474EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:00:52 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52cb78647ecso3247338a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487651; x=1688079651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rJiLW7AmmQnpv9DEnjN9p5/4mIGo+5HG0C4i82Hita4=;
        b=dxiJXImoRvtMCanp9c/ceTZ8qTmSPzD9b1rkVpo2uNvegmRaKNTVAVmuuWbCmnqbZk
         LO6bFjayl63AyoqRb11VMuyfiv45TChQjVsuP5zqr3dkHUYMwJRPzRkIqo4njsP3bcSV
         LjrzWPAs6kMkf5eHTc1VLqHWDu3hatO7OD3Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487651; x=1688079651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJiLW7AmmQnpv9DEnjN9p5/4mIGo+5HG0C4i82Hita4=;
        b=XOFsV8GrN4RNZXQtXnErgGw+5OVAyLhmHGe6zMTum8Ckktq40oBUhnsexfxk+waTpz
         KZXekfl4rSkqmhQheZ4eKLU6qGxqF9F1Dn/0oIJ18dSFZIyuKgACKk9AknP4YZLcVEMK
         0jnv+xyiQ6WgHIbm2/XBBUwT2n6Yw5b3ScZBOPWoVzLKtBIcj2+SMP6YGlqliU5Bc3Cx
         QlE9BR8/RnsyB7ONO0UYZ2H7qDcev24WEYO0zaeZ8nU84YgjFx8vTiE/tO+2FXNrwPZR
         SH/I6mbFWvDv+ay+Xb8q7+gfEuHVA20wWwozLOPF/F4+TKwUj7JPl4nKopVlMToIcoJX
         vXFg==
X-Gm-Message-State: AC+VfDzCwbVpTmUiq1cw2FF9c4PvNHrSASPyfbUrnYWG9PkHke1jfBZR
        gV3AN1SPfvDkK3xsX0hUQT8IMQ==
X-Google-Smtp-Source: ACHHUZ67LwwGjf/CO2NXgUokK7LdElpmLqHmamM5N0opD0v/5UjtIAhbIW+nDOEd3A//mwLET8bStQ==
X-Received: by 2002:a17:902:e809:b0:1a5:22a:165c with SMTP id u9-20020a170902e80900b001a5022a165cmr3877787plg.0.1685487651583;
        Tue, 30 May 2023 16:00:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ik24-20020a170902ab1800b001b0142908f7sm8886130plb.291.2023.05.30.16.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:00:50 -0700 (PDT)
Date:   Tue, 30 May 2023 16:00:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] md/raid5: Convert stripe_head's "dev" to flexible
 array member
Message-ID: <202305301600.EEF0BAAD@keescook>
References: <20230522212114.gonna.589-kees@kernel.org>
 <CAPhsuW5ibONdyyJq0zVCEHuM38GUocn8A1abi4mTa9gUHH1hHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5ibONdyyJq0zVCEHuM38GUocn8A1abi4mTa9gUHH1hHQ@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 10:43:52AM -0700, Song Liu wrote:
> On Mon, May 22, 2023 at 2:21 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Replace old-style 1-element array of "dev" in struct stripe_head with
> > modern C99 flexible array. In the future, we can additionally annotate
> > it with the run-time size, found in the "disks" member.
> >
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: linux-raid@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > It looks like this memory calculation:
> >
> >         memory = conf->min_nr_stripes * (sizeof(struct stripe_head) +
> >                  max_disks * ((sizeof(struct bio) + PAGE_SIZE))) / 1024;
> >
> > ... was already buggy (i.e. it included the single "dev" bytes in the
> > result). However, I'm not entirely sure if that is the right analysis,
> > since "dev" is not related to struct bio nor PAGE_SIZE?
> >
> > v1: https://lore.kernel.org/all/20230517233313.never.130-kees@kernel.org/
> > v2: use new struct_size_t() helper from
> >     https://lore.kernel.org/lkml/20230522211810.never.421-kees@kernel.org/
> 
> LTGM. Thanks!

Thanks!

> I will hold this for a while until struct_size_t() merged.

Since my tree will introduce struct_size_t(), I will just carry it
there.

-- 
Kees Cook
