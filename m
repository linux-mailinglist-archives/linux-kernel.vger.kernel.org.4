Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E43692A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjBJWWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjBJWWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:22:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3C475347
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:22:39 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso5064174wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tI/5EvoUb2b1YfGjLvZOx2cuiGfB7/qRUXmljsRRQ8=;
        b=UKX/8zPK15fwrWSudAEfFDY2yxRysZDG/CowOUCO2ThMPb0xgBfuhbUugHcCyV/iKS
         nthIkxz6MKN2FMCOvv3oH4NG0wZ0K6sDC1NRfKqI37lqFApAm+ZIKMk02JdRAwoUxKD4
         zA4HBIqc/tNsJMylZB9TEpU2xNIIA/79Xy/cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tI/5EvoUb2b1YfGjLvZOx2cuiGfB7/qRUXmljsRRQ8=;
        b=btlSJYBbK6TiKsBYiFAqJeCR7MKx39K9VODNp0lZUQvdfijZX01ui3XYB0fiWCGker
         PPX0C95fuOQZ8vXVHfD+hkgOwVV/Zi5zG2LETfDLow2vK85tZpv4wlT8qnjsDeXQcmQU
         f3tEDTbf4Dd0PqIM+nHJ775b4g+HcKs50Nx5Oxv3Aqs64DE5omIyP3lLqWHGVt2eD3Ic
         4gyFixMChPiWSmxXEZN41jhsW/+tdkPEo6JZyaiyykx9O+q83MOrKYorgoiWfomXD6fU
         HImVWM0/3c+jTeWoit2LjKmbzLgmGPYDAWVr7cCfInok3VbD06gqxQBE5cKLmdxiV4Y5
         WpmA==
X-Gm-Message-State: AO0yUKUhTlzpvh98b3qSxyFVXs/JROeZsmfEM1Ivo2gJ5gvLwQSMPbgj
        O6VAMAxBJjuABVgWKg2V4diJ84n1fOG0GLQ5Y6Y=
X-Google-Smtp-Source: AK7set+tno+eCD3uAE5voqBc/Spv2l+8EVI7xYNYiJLkbfG9ycPgjlU3oTbP+d17AEkHFXu37M4BMQ==
X-Received: by 2002:a05:600c:1604:b0:3d2:3be4:2d9a with SMTP id m4-20020a05600c160400b003d23be42d9amr14249132wmn.20.1676067757694;
        Fri, 10 Feb 2023 14:22:37 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c2cd000b003daffc2ecdesm10053351wmc.13.2023.02.10.14.22.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 14:22:37 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id dr8so19312382ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:22:36 -0800 (PST)
X-Received: by 2002:a17:906:f749:b0:8af:2ad9:9a1d with SMTP id
 jp9-20020a170906f74900b008af2ad99a1dmr1661134ejb.0.1676067756680; Fri, 10 Feb
 2023 14:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20230210215735.GA2700622@bhelgaas>
In-Reply-To: <20230210215735.GA2700622@bhelgaas>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 14:22:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_W2OzOoZ4P2GuPV89UoQuFdbsaz5YQcGJdaMEzoOCdQ@mail.gmail.com>
Message-ID: <CAHk-=wi_W2OzOoZ4P2GuPV89UoQuFdbsaz5YQcGJdaMEzoOCdQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v6.2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Witt <kernel@witt.link>,
        Vidya Sagar <vidyas@nvidia.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 1:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Note that we're moving PCI development to a shared git tree, so this
> pull request refers to the new tree.

Yeah, I saw the linux-next note, so I knew to expect it.

But thanks for the clarification regardless - the fewer surprises I
have in pull requests, the happier I tend to be ;)

               Linus
