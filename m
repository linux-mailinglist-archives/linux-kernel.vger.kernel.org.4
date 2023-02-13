Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE20695043
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBMTDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBMTDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:03:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F87EE8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:03:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so8734922wmp.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dgnqne/1Nq8OfJxRNJOO9346UMfd+wXQbFoKWdAx77k=;
        b=dFmU9mAdXC0FHtSuIbQw7GqEskDZsHf42DbzKhhZaSIDMA7dIqsrcIihYeuW6ay/KX
         XJ6v0jzT0OsWLjtOBtn2OTK8ra+7q5pNhtkql360HxJf+VSP5S+7HwIA5x6WTrkKj4zF
         7dzCqH0PPbjyEh52Ot8xSKg1uGMGZLQEND2/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dgnqne/1Nq8OfJxRNJOO9346UMfd+wXQbFoKWdAx77k=;
        b=oeGLQUjIb7mjDyoI0K3mwFS37T4f+Pyz5p2WFpJCv+b/NC8YyQkghVxGjpeYu5k175
         qp7vGJAFWF9IhCOmEmyxo85Cpzk13lMwNOIqccl3J8/26ZyJLSLSXAoz54n3cF+iBHB/
         h8kaalSDODCd0j0n5rN3MEtMCyzWtqEHjSLcBc60sHRyi8tm7gVdPZO9GCIksRl/CUr4
         9xb+W17Q8oDli6biPr9wuiKpNsSg719OhD5SvuIneGxPIseBhQOSbgCx9KqEh7ZOElfD
         4SuDAN1n/9oaNjx4bI5SrMvHHwV0bXejoD+xo3SQPlsIOZHXKFOC3Tdu5PGg2G99uqKK
         sOGQ==
X-Gm-Message-State: AO0yUKVRvhsVsNM1jRATjQHeJu3lRGIh17VXoUZuAPE6mzOluDa8k45d
        fes5Bwyg5/XgumC7QW20CdKNwSwbnZuDxar4l5s=
X-Google-Smtp-Source: AK7set+YzSpqvQLsxCmuFEgmqW4K4XySt9Wxrt24UZ1d/ichT2g/TrKjzjz+6Nu1c6VUWE0GT2NohQ==
X-Received: by 2002:a05:600c:4919:b0:3df:f2a5:49fb with SMTP id f25-20020a05600c491900b003dff2a549fbmr18574071wmp.7.1676314991085;
        Mon, 13 Feb 2023 11:03:11 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c3b8200b003dfe659f9b1sm26678301wms.3.2023.02.13.11.03.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 11:03:10 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id sa10so34267659ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:03:10 -0800 (PST)
X-Received: by 2002:a17:906:8585:b0:8af:2ad9:9a1d with SMTP id
 v5-20020a170906858500b008af2ad99a1dmr27244ejx.0.1676314989818; Mon, 13 Feb
 2023 11:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
 <CAFA6WYM5tzs3T1tDgspA=R=VxfWrknm2YPHMCZihx405pF-ftA@mail.gmail.com>
 <63e279f730612_104ce22946f@iweiny-mobl.notmuch> <63e6a8b798a_145760294a6@iweiny-mobl.notmuch>
 <CAHUa44GAM=meibiSDjjWb0wKmHzud6JddE3W=zG3XCFfgP+Sag@mail.gmail.com>
In-Reply-To: <CAHUa44GAM=meibiSDjjWb0wKmHzud6JddE3W=zG3XCFfgP+Sag@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Feb 2023 11:02:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3+moi98rbiMnwnxPNZcYBaVY57TM2EP6NgXgNwFeP7Q@mail.gmail.com>
Message-ID: <CAHk-=wh3+moi98rbiMnwnxPNZcYBaVY57TM2EP6NgXgNwFeP7Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@suse.de>
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

On Mon, Feb 13, 2023 at 7:02 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Sure, I'll take it. The timing is a bit unfortunate, it's likely too
> close to the merge window to be included there. However, I'll pick it
> up and add it to linux-next so it's ready for the 6.4 merge window.

With this boeing almost all code removal, I'm perfectly fine taking it
in the upcoming merge window.

           Linus
