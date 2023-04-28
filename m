Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BED6F10BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 05:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344875AbjD1DQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 23:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjD1DQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 23:16:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD312709
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 20:16:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-959a3e2dc72so1152997266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 20:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682651775; x=1685243775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7sdITuIFnEQoKW0N5OSKzGyU3doRmglDS9WyyDhnvg=;
        b=eGb+aPgX+DH/BU1Feq4tdkTB+pn1heXwPBeihvAsYFF1/y6lDG1UwgcmYcYooxszbl
         LCdKCNVkUeH0T/t+6BVGCKlxYGjBM1OI1Tq5JV3PCCybyrejmolRu3BXxz91FQ8QFOyb
         /dF/fRqY3aZ3pjpkB2Wlbd4FWbht2fUAh+7no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682651775; x=1685243775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7sdITuIFnEQoKW0N5OSKzGyU3doRmglDS9WyyDhnvg=;
        b=Dwc0M/YDw4cmo1/rHuO6Oka+ZKZpQPV4Mw5sGvc5hbf/Gd0iyhgrSOzkb2dEajihgr
         Vocn9jxQjyURVmVUE6ewKgOOeRoDgtdWEFNV50IJDkZHyNuCKTmn1EoQJ61WQt+79gPq
         khNUavrpmcuqXEptuNwsgAmgXVLpKlRr/t219iwsBeZlo26f2VZ2EHvMFtLHiBvNOg3i
         pa5TsaiylLlBEh7DMcJOmWoAj/cNGdiMFA9sGd7eF1kWYPXr1em3FWVRJJxZEy2fMWgl
         FlN26yF8wBPfLlrhXRQlwXDav9qxZnRLHv7p1xF9mOdo5ecbIbgNXfJSeyOPGXC3GSEr
         2bBA==
X-Gm-Message-State: AC+VfDzGdD63NgPgoWFY0qaSpnSwyOI20PZNrCxhNSoiDom/vAg4s9Ey
        Hi62jaoQZseMALwOVUX0cCO2/v9yGkS86SzDSH5kBQ==
X-Google-Smtp-Source: ACHHUZ7nS8vXwfB3Z9qXkgg8xD3XBvYLwd/rXZs/1OWLXJ7wUBpet2Xk/1Lc9slTU36/8z03DeRs2Q==
X-Received: by 2002:a17:907:c0d:b0:947:71bf:ca19 with SMTP id ga13-20020a1709070c0d00b0094771bfca19mr3943128ejc.65.1682651775357;
        Thu, 27 Apr 2023 20:16:15 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id qn7-20020a170907210700b0094e44899367sm10390883ejb.101.2023.04.27.20.16.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 20:16:14 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-959a3e2dc72so1152992866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 20:16:14 -0700 (PDT)
X-Received: by 2002:a17:907:5c1:b0:94a:90e5:b2b6 with SMTP id
 wg1-20020a17090705c100b0094a90e5b2b6mr3512007ejb.58.1682651774330; Thu, 27
 Apr 2023 20:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
In-Reply-To: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 20:15:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaYXeWKsyifQCS=gJf4mxav-b6cdf5boKpMO6M1C-2LQ@mail.gmail.com>
Message-ID: <CAHk-=wjaYXeWKsyifQCS=gJf4mxav-b6cdf5boKpMO6M1C-2LQ@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 3:33=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-20=
23-04-27-15-30

Ok, so all the merge conflicts looked straightforward enough (except
the one I asked Vlastimil to look at - and that conflict was tiny and
straightforward too, it was just in a really grotty place).

However, let's not get cocky - so I'd ask people double-check my
conflict resolution, even if it looked fairly straightforward.
Mistakes happen.

Most of the bulk of the conflicts were around __filemap_get_folio()
now returning an ERR_PTR, particularly then with Willy doing the ext4
folio conversion.

So Christoph, Willy, mind just double-checking me?

                 Linus
