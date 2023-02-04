Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFE268AC24
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 20:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjBDTvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 14:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjBDTu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 14:50:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4050222DC6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 11:50:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id fi26so8151279edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 11:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XXqZLuT6IJKVYT0/2ie4j2Zj0I5vvT2fCkqKaBFLuZs=;
        b=e/U0/7ZmC3xl9Mx8ivBzxUUiJoNPiTw7CcE1qyUL+o08ualvm7R/rOVGNxEZohscQ4
         btwKjuvQcYKD5I/lF0RWaexripdHlek4KX4ln95igIklMOWBlxrQ48cEbqD4x1c6nhbD
         ih9n9XtXaEauMUFvIg8hoePSW505GE5HB688A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXqZLuT6IJKVYT0/2ie4j2Zj0I5vvT2fCkqKaBFLuZs=;
        b=706TclC7j4zpb66jasfeSzdaY+04P5jTSQF4nYh+yAdxBXE2U09rL2pDYl0iLlncU9
         5Vx424r9j89rwNVZQ0vuhOBo6sqOo6b3KuTCcPkuf64Gv7SwEeFECRrsEpndACOzHPEX
         XpXYvw1c4ZABAWvW/z0pbuI2TgSbZgOqfWe+0kX1IiXggqYfjfHVMszzQShI8YvF6VDt
         KTNbe1kZ/AwCbVJNYo+mlDIb6DbkSdf1oAgy+9mau5GsK+VGzXqdiyv9ZRd6WbBcxU5k
         5Ix4tAtDompTUq1eThDOAGrv/c/oBbrmoSULQ5o8nZrYHMp+0/oJgmO3ljhqoS4NgM1c
         GWlw==
X-Gm-Message-State: AO0yUKV9mtm357sAEs2spiJpUCrHV0vz/Q2000qTRa/x0KxOISJvliwX
        /5booZBkhnjyK6uIhfNy70R0Tek4XNqD+hRknag=
X-Google-Smtp-Source: AK7set/Uj6e5Ri2sIeS1ZRZmWJRgqNWe/wO2iJ3bnTn1c4vf3TFyg0sz0wkw5J3BIEt72E0eQbhYSw==
X-Received: by 2002:a05:6402:34cd:b0:4a3:43c1:842f with SMTP id w13-20020a05640234cd00b004a343c1842fmr12614061edc.3.1675540256255;
        Sat, 04 Feb 2023 11:50:56 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id i19-20020a508713000000b004aaa5019bd7sm484854edb.44.2023.02.04.11.50.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 11:50:55 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id x7so8207573edr.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 11:50:55 -0800 (PST)
X-Received: by 2002:a50:d0da:0:b0:4aa:9bd9:d81b with SMTP id
 g26-20020a50d0da000000b004aa9bd9d81bmr820436edf.70.1675540255245; Sat, 04 Feb
 2023 11:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
In-Reply-To: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Feb 2023 11:50:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiN3fPUDpiZBt+d_p1nncTnBEqmm_xqEa0soL-90Wdsrg@mail.gmail.com>
Message-ID: <CAHk-=wiN3fPUDpiZBt+d_p1nncTnBEqmm_xqEa0soL-90Wdsrg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
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

On Fri, Feb 3, 2023 at 8:06 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> This series also fixes is_kmap_addr() and uses it to ensure no kmap addresses
> slip in later.

Ack. Please make it so.

That said...

I wasn't cc'd on all the patches, but checked them on the mailing
list, and that first is_kmap_addr() patch makes me a bit unhappy.

Right now that 'is_kmap_addr()' is only used for user copy addresses,
for debugging purposes, and I'm not exactly thrilled about extending
it this way.

I get the feeling that we should just have a name for that "kmap _or_
kmap_local" range instead of making it two ranges.

But admittedly I can't come up with anything better, and it looks like
different architectures may do different things.  I just don't like
it.

                Linus
